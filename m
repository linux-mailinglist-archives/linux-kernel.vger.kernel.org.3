Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FC6533879
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbiEYIbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiEYIbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:31:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C81F330
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:31:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24AEB1FB;
        Wed, 25 May 2022 01:31:08 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.0.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3E743F73D;
        Wed, 25 May 2022 01:31:02 -0700 (PDT)
Date:   Wed, 25 May 2022 09:30:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v4 3/7] arm64: add support for machine check error
 safe
Message-ID: <Yo3pP/Y+6HHuVBns@FVFF77S0Q05N>
References: <20220420030418.3189040-1-tongtiangen@huawei.com>
 <20220420030418.3189040-4-tongtiangen@huawei.com>
 <Yn54mA7KnlAs1dER@lakrids>
 <46e5954c-a9a8-f4a8-07cc-de42e2753051@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46e5954c-a9a8-f4a8-07cc-de42e2753051@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 02:29:54PM +0800, Tong Tiangen wrote:
> 
> 
> 在 2022/5/13 23:26, Mark Rutland 写道:
> > On Wed, Apr 20, 2022 at 03:04:14AM +0000, Tong Tiangen wrote:
> > > During the processing of arm64 kernel hardware memory errors(do_sea()), if
> > > the errors is consumed in the kernel, the current processing is panic.
> > > However, it is not optimal.
> > > 
> > > Take uaccess for example, if the uaccess operation fails due to memory
> > > error, only the user process will be affected, kill the user process
> > > and isolate the user page with hardware memory errors is a better choice.
> > 
> > Conceptually, I'm fine with the idea of constraining what we do for a
> > true uaccess, but I don't like the implementation of this at all, and I
> > think we first need to clean up the arm64 extable usage to clearly
> > distinguish a uaccess from another access.
> 
> OK,using EX_TYPE_UACCESS and this extable type could be recover, this is
> more reasonable.

Great.

> For EX_TYPE_UACCESS_ERR_ZERO, today we use it for kernel accesses in a
> couple of cases, such as
> get_user/futex/__user_cache_maint()/__user_swpX_asm(), 

Those are all user accesses.

However, __get_kernel_nofault() and __put_kernel_nofault() use
EX_TYPE_UACCESS_ERR_ZERO by way of __{get,put}_mem_asm(), so we'd need to
refactor that code to split the user/kernel cases higher up the callchain.

> your suggestion is:
> get_user continues to use EX_TYPE_UACCESS_ERR_ZERO and the other cases use
> new type EX_TYPE_FIXUP_ERR_ZERO?

Yes, that's the rough shape. We could make the latter EX_TYPE_KACCESS_ERR_ZERO
to be clearly analogous to EX_TYPE_UACCESS_ERR_ZERO, and with that I susepct we
could remove EX_TYPE_FIXUP.

Thanks,
Mark.
