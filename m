Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20494C8706
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiCAItd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiCAItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:49:32 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE765643E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:48:51 -0800 (PST)
Received: from nazgul.tnic (dynamic-002-247-255-128.2.247.pool.telefonica.de [2.247.255.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D37CF1EC0531;
        Tue,  1 Mar 2022 09:48:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646124526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DLDmVbmw136AE1vrsgg4jKyCqguGiCRn5bNifxsS4B8=;
        b=WR4JNbC5yjGcUL+BBotyaxfPNR+OMH2CGhWsoB8Z5PoXxA/5vxPSNmUL7KqFafLiScrnpE
        wy860Ii46YoTt0/E3zW9UJ6y0l7PzHwWrKUoVhF/NygtWMXYUR4R3ElKOvD83Z+Ls9S/d2
        P5e/Cr4yQ1Pi/7zzU0dXo47Uus0eZLU=
Date:   Tue, 1 Mar 2022 09:48:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
Subject: Re: [PATCHv4 01/30] x86/mm: Fix warning on build with
 X86_MEM_ENCRYPT=y
Message-ID: <Yh3d8Trp4ZCmdOW2@nazgul.tnic>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-2-kirill.shutemov@linux.intel.com>
 <20220227220130.23yjme7jucxo266l@treble>
 <20220228162056.gul22bjr4w6zjslq@black.fi.intel.com>
 <20220228164007.nfrg7xvrl4blzzrm@treble>
 <080f9306-8c72-c7bd-010a-f0ed32c4b692@intel.com>
 <20220228171159.pkp3t46pxbs6o2ul@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220228171159.pkp3t46pxbs6o2ul@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 09:11:59AM -0800, Josh Poimboeuf wrote:
> People rely on the "Fixes:" tag for actual bug fixes.  Using it here --
> along with the rest of the "this is fixing a bug" tone of the title and
> description -- is guaranteed to confuse stable maintainers and distros
> doing backports.

Yes, they very much do. There's even automatic tools which look at Fixes
and give people work. So yeah, pls don't take this lightly.

> I would call it misinformation.  How is that useful?
> 
> It's ok to reference a related commit in the patch description itself.
> Just don't abuse the "Fixes" tag.
> 
> But IMO, for the least amount of confusion, it makes more sense to
> squash this with the patch which actually requires it.

Full ack. Please squash it into the patch which causes the issue. And
frankly, I don't understand why you guys are making such a fuss about it
and why this needs to be a separate patch, at all?!

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
