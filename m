Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32774D4708
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbiCJMdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiCJMdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:33:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FAA5AA4B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 04:32:40 -0800 (PST)
Received: from zn.tnic (p200300ea97193878c63bc5569fbdd396.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3878:c63b:c556:9fbd:d396])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 033411EC0628;
        Thu, 10 Mar 2022 13:32:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646915555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TqrBU22UdViPIxWmZbGrokeFlrkwHRgjEfM2ZXpQzTU=;
        b=fMOX7k/toKzTVYXbNX7/galkpHpMtJeC3Wj7Dt4rchxTL3yN0wAufQkHKLOgqfKTMEskfj
        5aJEAXtvezcI4vaZVMMEL49cGUjlX0ZRgTTLnoX/FJ2YwR6Ko7YCxMp5iiE0sZbzyFIwjO
        PAWPV0pr/W/ywBYFK44ydLkuGkQlAa0=
Date:   Thu, 10 Mar 2022 13:32:40 +0100
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
Message-ID: <Yinv6Dptnj0aTf/Y@zn.tnic>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220302142806.51844-3-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 05:27:38PM +0300, Kirill A. Shutemov wrote:
>  arch/x86/include/asm/tdx.h    | 28 +++++++++++
>  arch/x86/kernel/asm-offsets.c |  9 ++++
>  arch/x86/virt/tdxcall.S       | 95 +++++++++++++++++++++++++++++++++++

Right, you asked already about putting this under arch/x86/virt/ but on
a second thought, this doesn't look like

"- generic host virtualization stuff: arch/x86/virt/"

to me:

https://lore.kernel.org/r/Yg5nh1RknPRwIrb8@zn.tnic

Rather, this looks like it wants to be under

 arch/x86/virt/vmx/tdx/

where we said that this should be the coco host code place.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
