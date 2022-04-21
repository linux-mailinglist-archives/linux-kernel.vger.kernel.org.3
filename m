Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86802509CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387855AbiDUJu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386466AbiDUJuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:50:21 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C4524BE5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:47:32 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58ed329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58ed:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 467E91EC0494;
        Thu, 21 Apr 2022 11:47:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650534447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iMYBR9W+xUN4GuRJPU5HgPfkxQ4sP0rpD27ixTAIoIg=;
        b=iMSEBgEKybKb7DJ0E7f23kD6V5ijkmC2vZUKCGKW3mDaS3tiI5hg9vUNhrYxFKZsq3LQg1
        A1ii9XrsXV2EdPVD4SP8xCN/qX2Zw3b0OeKqQSSG7yrlEAz50U03jq3z7rmasQm5eXqw/c
        /YYKFX4IsZhgiCfQLfy8D1dB4BgcnCo=
Date:   Thu, 21 Apr 2022 11:47:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v2] x86/sev: get the AP jump table address from secrets
 page
Message-ID: <YmEoLvEX15l0vmam@zn.tnic>
References: <20220421021445.24307-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421021445.24307-1-michael.roth@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 09:14:45PM -0500, Michael Roth wrote:
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index f01f4550e2c6..29b832c3f27f 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -558,6 +558,55 @@ void noinstr __sev_es_nmi_complete(void)
>  	__sev_put_ghcb(&state);
>  }
>  
> +static u64 get_secrets_page(void)
> +{
> +	u64 pa_data = boot_params.cc_blob_address;
> +	struct cc_blob_sev_info info;
> +	void *map;
> +
> +	/*
> +	 * The CC blob contains the address of the secrets page, check if the
> +	 * blob is present.
> +	 */
> +	if (!pa_data)
> +		return 0;
> +
> +	map = early_memremap(pa_data, sizeof(info));

WARNING: modpost: vmlinux.o(.text+0x58a1d): Section mismatch in reference from the function get_secrets_page() to the function .init.text:early_memremap()
The function get_secrets_page() references
the function __init early_memremap().
This is often because get_secrets_page lacks a __init 
annotation or the annotation of early_memremap is wrong.

WARNING: modpost: vmlinux.o(.text+0x58a3e): Section mismatch in reference from the function get_secrets_page() to the function .init.text:early_memunmap()
The function get_secrets_page() references
the function __init early_memunmap().
This is often because get_secrets_page lacks a __init 
annotation or the annotation of early_memunmap is wrong.

The previous caller was __init.

Seeing how the call chain starts at setup_real_mode() which is
__init, I'm thinking all those functions down to and including
get_secrets_page() should be __init too. And I'm guessing that should be
a pre-patch and then this one ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
