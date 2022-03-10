Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB2E4D4C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244616AbiCJO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243239AbiCJOwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:52:14 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABDB6477
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:51:00 -0800 (PST)
Received: from zn.tnic (p200300ea97193878846c1e519efb88e1.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3878:846c:1e51:9efb:88e1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D1A4D1EC0674;
        Thu, 10 Mar 2022 15:50:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646923854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dnu4winw/k2VpPk5B/AtlyZwX+44/EW+U+leUG4NiJY=;
        b=rQMINH3LIicAmhh/h08/5jxDNbwW8UpZ1EtiVbS29Dee5S5m1pLGVBMlntFv11rCnkBAtN
        FbxWN3W4glMvGJcHbjt+XNsbWeWi3iMhupSRA4Olmu7pYN6NZBSjvMp5nrkRD1vcDmkLLM
        4uZEfH42bEK4wnZQoj8FFXJTy6GDzzY=
Date:   Thu, 10 Mar 2022 15:51:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 02/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
Message-ID: <YioQVLY9Q5OWoqF4@zn.tnic>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-3-kirill.shutemov@linux.intel.com>
 <Yinv6Dptnj0aTf/Y@zn.tnic>
 <20220310144404.5g4asrzzxwon7v7u@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220310144404.5g4asrzzxwon7v7u@black.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 05:44:04PM +0300, Kirill A. Shutemov wrote:
> I'm fine moving where you want. But I want to make sure we are on the same
> page: this code is common for guest and host TDX. I think VMX referes more
> to host side of the thing, no?

Well, that patch has host-side stuff too.

If we have to be pedantic, this should be in

arch/x86/virt/shared/vmx/tdx

or so but that's bikeshedding gone out of control to me.

And it isn't generic, as pointed out earlier, so arch/x86/virt/ does not
fit either.

So I'd think of something with "tdx" in the pathname and
arch/x86/virt/vmx/tdx/ is kinda the only one we agreed upon as a path...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
