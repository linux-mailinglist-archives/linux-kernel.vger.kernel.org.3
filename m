Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AB1505D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbiDRRRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbiDRRR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:17:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F7DE39;
        Mon, 18 Apr 2022 10:14:46 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58fe329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58fe:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 317881EC04AD;
        Mon, 18 Apr 2022 19:14:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650302081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=t7fx5g7C/Fr97o1K+NsY6oTSAJaB9WJV2sayN5CLMqc=;
        b=p6ZxZekncgxR5NE2k1fLqT2jYtKL3o96HIeMDPg8xq4EY6tenQhsidmTPDeivT61YdogKI
        TROhikBXO9aLXf6ldHQKLNe/77KIikWOZHzNl3olYWadigDAWDgWhyAJdWgCZ/mYiUkpYE
        AVd9GcT+69jBLfPa01Vog0N7xuWOznk=
Date:   Mon, 18 Apr 2022 19:14:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org
Subject: Re: [tip: x86/sev] virt: Add SEV-SNP guest driver
Message-ID: <Yl2cffonOopK6JrM@zn.tnic>
References: <20220307213356.2797205-44-brijesh.singh@amd.com>
 <164940891958.389.8256762641375131456.tip-bot2@tip-bot2>
 <CAAH4kHZpwbJSE6tDz-3ZzMH75rmgDYvBQ5_gLteXRmEk54yORQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAH4kHZpwbJSE6tDz-3ZzMH75rmgDYvBQ5_gLteXRmEk54yORQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 09:42:31AM -0700, Dionna Amalie Glaze wrote:
> What is the intended name of this driver? I see the following
> 
> +static struct platform_driver snp_guest_driver = {
> +       .remove         = __exit_p(snp_guest_remove),
> +       .driver         = {
> +               .name = "snp-guest",
> +       },
> +};
> 
> yet...
> 
> +#define DEVICE_NAME    "sev-guest"
> 
> and
> 
> +       misc->minor = MISC_DYNAMIC_MINOR;
> +       misc->name = DEVICE_NAME;
> +       misc->fops = &snp_guest_fops;

Gah, I have raised this in the past:

https://lore.kernel.org/r/YNxzJ2I3ZumTELLb@zn.tnic

but that aspect has veered off into the weeds.

I *think* this should be called "sev-guest".

Dov's driver which is mentioned in that thread, ended up being called
efi_secret so I guess sev-guest.

Tom?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
