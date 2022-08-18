Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA159814A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243999AbiHRKIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbiHRKIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:08:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4E04CA3B;
        Thu, 18 Aug 2022 03:08:34 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98ec329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98ec:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51DD11EC056D;
        Thu, 18 Aug 2022 12:08:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660817309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=O4EgIYZ64hmyiZkormnNEy3aMOezDlwYFaPWr1H3z4I=;
        b=N2cZKh1232bwCm0szW2TX51kDArsuJiJJlpJPcfR7WoNMA1FMs2LpLcaElPYPBBSwigkWH
        /Pb8v8U2dmaZmsJ6IfXLxC5XFgA2V2tIQU8SQ2BXyoa5O8q9jJ/+gO5Wm0uxPOgvP/9ow6
        V65dxZcgRQpf2ePLeH77IsktPKjl0RI=
Date:   Thu, 18 Aug 2022 12:08:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        antonio.gomez.iglesias@linux.intel.com,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        andrew.cooper3@citrix.com, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v2] x86/bugs: Add "unknown" reporting for MMIO Stale Data
Message-ID: <Yv4PmGS98IDZ7ujH@zn.tnic>
References: <79d2455c75bdbad4e68a3843fe1c1e67826008e6.1659562129.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79d2455c75bdbad4e68a3843fe1c1e67826008e6.1659562129.git.pawan.kumar.gupta@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 02:41:32PM -0700, Pawan Gupta wrote:
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 6761668100b9..fe3f7e762b80 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -433,7 +433,8 @@ static void __init mmio_select_mitigation(void)
>  	u64 ia32_cap;
>  
>  	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
> -	    cpu_mitigations_off()) {
> +	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
> +	     cpu_mitigations_off()) {
>  		mmio_mitigation = MMIO_MITIGATION_OFF;
>  		return;
>  	}

Needs also:

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d08c5589fa59..da7c361f47e0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -539,6 +539,8 @@ static void __init md_clear_update_mitigation(void)
 		pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
 	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
+	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
+		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
 }
 
 static void __init md_clear_select_mitigation(void)

I've added it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
