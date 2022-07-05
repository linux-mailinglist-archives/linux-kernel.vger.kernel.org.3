Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7C056721A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiGEPIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiGEPHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:07:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4A0220FA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:04:51 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff682329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f682:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7299F1EC0513;
        Tue,  5 Jul 2022 17:04:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657033476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=A3o83DD+B1z/6kiI4KQQIPd6dtqOA5pz/dpE36h38W8=;
        b=jkN8Vw62hc7iKa88OPl2ClVxqDZZcTXMySFImEcGL0S8nJorx7CDCmqDTQMJnayaw9xIzk
        LHjGDPZOSaxrCRUZSFFMFEyCqqMiIRerKV2/mupELKxAl+F8Ac8RaI6qFg84cYP+XxKbP1
        sYaLNFoWAfyJuXvx/Ucp4B3UoyvyWmI=
Date:   Tue, 5 Jul 2022 17:04:32 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] x86/PAT: have pat_enabled() properly reflect state when
 running on e.g. Xen
Message-ID: <YsRTAGI2PhfZ5V7M@zn.tnic>
References: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9385fa60-fa5d-f559-a137-6608408f88b0@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 04:50:29PM +0200, Jan Beulich wrote:
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -62,6 +62,7 @@
>  
>  static bool __read_mostly pat_bp_initialized;
>  static bool __read_mostly pat_disabled = !IS_ENABLED(CONFIG_X86_PAT);
> +static bool __initdata pat_force_disabled = !IS_ENABLED(CONFIG_X86_PAT);
>  static bool __read_mostly pat_bp_enabled;
>  static bool __read_mostly pat_cm_initialized;

Why yet another boolean var?

Why not extend pat_enabled() to reflect the Xen case and explain it
properly above it?

My comment is likely wrong because I don't know what the Xen HV hides or
doesn't but you get the idea...

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index d5ef64ddd35e..a8f1a02f9bc2 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -92,6 +92,13 @@ early_param("nopat", nopat);
 
 bool pat_enabled(void)
 {
+	/*
+	 * Xen PV doesn't expose the PAT MSR to dom0 so the proper init path
+	 * there cannot be exercised. Announce PAT is enabled in that case too.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV) && !pat_disabled)
+		return true;
+
 	return pat_bp_enabled;
 }
 EXPORT_SYMBOL_GPL(pat_enabled);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
