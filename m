Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0612508F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381517AbiDTSdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380958AbiDTSdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:33:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F73129
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:31:00 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58ed329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58ed:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35BB91EC0373;
        Wed, 20 Apr 2022 20:30:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650479455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BoNR3/TdNmyezoOlYlqywibUKdPvf4k/cpq0M78h2eM=;
        b=FxfdO9k+Kak1V3zq5HzCJV24/DCBM9ITfIJXMCjtrbnkvjuY9cD3nWzi+TcRyKYYoE7h7V
        W+U16zdwWF0EIaR8psuZpFjrEJiVqXzmWQIVO/BCXJcVtkjsPoJ12w2Ai8Jbql2zS41QWt
        orZ7vA8q61+iMidIq0T/jx/rZ7hwUvM=
Date:   Wed, 20 Apr 2022 20:30:51 +0200
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
Subject: Re: [PATCH] x86/sev: get the AP jump table address from secrets page
Message-ID: <YmBRW6xMhNiW7JRU@zn.tnic>
References: <20220420152751.145180-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220420152751.145180-1-michael.roth@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:27:51AM -0500, Michael Roth wrote:
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

That function can return NULL so you need to handle it.

> +	memcpy(&info, map, sizeof(info));
> +	early_memunmap(map, sizeof(info));
> +
> +	/* smoke-test the secrets page passed */
> +	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
> +		return 0;
> +
> +	return info.secrets_phys;
> +}
> +
> +static u64 get_snp_jump_table_addr(void)
> +{
> +	struct snp_secrets_page_layout *layout;
> +	u64 pa = get_secrets_page();
> +	u64 addr;

Please don't hide the function call in the local variables declaration
but do this instead:

        struct snp_secrets_page_layout *layout;
        u64 pa, addr;

        pa = get_secrets_page();
        if (!pa)
                return 0;

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
