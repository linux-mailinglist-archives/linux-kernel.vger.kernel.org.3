Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7234BED48
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiBUWhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:37:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiBUWhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:37:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F752E22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:36:53 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D7051EC02DD;
        Mon, 21 Feb 2022 23:36:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645483007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9GPOSFJdlvNVfhtJwpSJothTg8wq6LHibcLqRGT+qKc=;
        b=p/xh+xeA0eimJktPhI4pVZUi3CfBsliye4Yo3dsXzoF4twNsEAsrzWrfJmGSnCcx42POK9
        oW2QsMAsGY81FoXrE72azAw8sJxkP+R+pAgWTi5p45M1AZ5jt0OsDf/vj4pG+O4qYSp+vA
        yXvhnnN+BgZgikrKegtL8ve4OIXyoYc=
Date:   Mon, 21 Feb 2022 23:36:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCHv3.1 2.1/2] x86/coco: Add API to handle encryption mask
Message-ID: <YhQUB2dIQJ/Ov3zp@zn.tnic>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
 <20220219001305.22883-2-kirill.shutemov@linux.intel.com>
 <YhP+kES/UVx7RwYz@zn.tnic>
 <20220221221049.p5zvappg4s2mjem7@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220221221049.p5zvappg4s2mjem7@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 01:10:49AM +0300, Kirill A. Shutemov wrote:
> I'm not sure it is a good idea. It leaves room for code between these two
> calls. I believe they conceptually has to initialized in one shot. That's
> the only way we get consistent state.

Really, where?

My expectation would be that those things are set early enough during
boot, in your case in tdx_early_init(), for example, where stuff gets
initialized - not where it is used.

If you worry about having inconsistent state, then you're doing the init
not early enough.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
