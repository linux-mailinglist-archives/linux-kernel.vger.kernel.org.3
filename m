Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192604F994F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiDHPYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiDHPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:24:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0335F108753
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:22:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D875113E;
        Fri,  8 Apr 2022 08:22:26 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D62393F73B;
        Fri,  8 Apr 2022 08:22:24 -0700 (PDT)
Date:   Fri, 8 Apr 2022 16:22:22 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH -next V2 5/7] arm64: add get_user to machine check
 safe
Message-ID: <YlBTLn1cf7+gJmiM@lakrids>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
 <20220406091311.3354723-6-tongtiangen@huawei.com>
 <Yk14AwR92MX0LKqZ@FVFF77S0Q05N>
 <ac80045b-24f0-a163-ea96-be0d01c48d29@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac80045b-24f0-a163-ea96-be0d01c48d29@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:38:04PM +0800, Tong Tiangen wrote:
> 在 2022/4/6 19:22, Mark Rutland 写道:
> > On Wed, Apr 06, 2022 at 09:13:09AM +0000, Tong Tiangen wrote:
> > > Add scenarios get_user to machine check safe. The processing of
> > > EX_TYPE_UACCESS_ERR_ZERO and EX_TYPE_UACCESS_ERR_ZERO_UCE_RECOVERY is same
> > > and both return -EFAULT.
> > 
> > Which uaccess cases do we expect to *not* be recoverable?
> > 
> > Naively I would assume that if we're going to treat a memory error on a uaccess
> > as fatal to userspace we should be able to do that for *any* uacesses.
> > 
> > The commit message should explain why we need the distinction between a
> > recoverable uaccess and a non-recoverable uaccess.
> > 
> > Thanks,
> > Mark.
> 
> Currently, any memory error consumed in kernel mode will lead to panic
> (do_sea()).
> 
> My idea is that not all memory errors consumed in kernel mode are fatal,
> such as copy_ from_ user/get_ user is a memory error consumed when
> reading user data in the process context. In this case, we can not let the
> kernel panic, just kill the process without affecting the operation
> of the system.

I understood this part.

> However, not all uaccess can be recovered without affecting the normal
> operation of the system. The key is not whether it is uaccess, but whether
> there are key data affecting the normal operation of the system in the read
> page.

Ok. Can you give an example of such a case where the a uaccess that hits
a memory error must be fatal?

I think you might be trying to say that for copy_{to,from}_user() we can
make that judgement, but those are combined user+kernel access
primitives, and the *uaccess* part should never be reading from a page
with "key data affecting the normal operation of the system", since
that's userspace memory.

Is there any *userspace access* (e.g. where we use LDTR/STTR today)
where we must treat a memory error as fatal to the system?

Thanks,
Mark.
