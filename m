Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6E8567638
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiGESLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGESLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:11:43 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA3D1CFEC;
        Tue,  5 Jul 2022 11:11:42 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2ef5380669cso117173777b3.9;
        Tue, 05 Jul 2022 11:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7yFNBLntIRTuUOtHmi7K8qocSAg/tXKsZNm9+w3CgA=;
        b=VmsLD219wIgsB3ln3tr7r6v61s8IZjTmFAa6ac7ahLV0mOUnU8glmsVJGcsVF5pW44
         vIR+gt3tSpRiXfzBA4SVtpPGVfyoTMydy43aTbGhY1W2MqX80fUXDfZcUxikY3qFOxQ7
         M+yCEVXTrQK0W/D6JK7wG6nh6/fdNIam7362NXpJ3alJo/FjrfY1lZR/8K9SUFjacauc
         r0xThi070fJJd2aPuhyN7+x7g2n/DJJboQ93tr4CljnznSXQysZaGQPbdJYP8p+WuiA/
         nbqTJ6gWGLfeE1p1kANFfJhMdSzsDkljDRbaxTZq+oN1V5R6DngOHP/eKQVqodyt2LBJ
         Z5vw==
X-Gm-Message-State: AJIora+90KT8qP+cMniGnJYWMTHa9sp0ViEjqxzwO3U9/+evOk6KCPtM
        IGQepLej1nEgogdqqtacPVa0Yqx2dQc/0B0xCKQ=
X-Google-Smtp-Source: AGRyM1uDGXwdvLFBX3KtfmMGlyKzjR+9MjL+JTmyQO21nMPnqagWGSpyeIvtyUpMSQv4NZj3TOgUnxRyozG2KgUpKKg=
X-Received: by 2002:a0d:d086:0:b0:31b:d0b2:e11f with SMTP id
 s128-20020a0dd086000000b0031bd0b2e11fmr40152405ywd.515.1657044702084; Tue, 05
 Jul 2022 11:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220629200433.6103-1-mario.limonciello@amd.com>
In-Reply-To: <20220629200433.6103-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 20:11:31 +0200
Message-ID: <CAJZ5v0jtgWk6qDQFJQrzRJ9+H2eO+X9KgGFo+UTDmqGQcOgJXQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supported
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Perry Yuan <perry.yuan@amd.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 10:04 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 72f2ecb7ece7 ("ACPI: bus: Set CPPC _OSC bits for all and
> when CPPC_LIB is supported") added support for claiming to
> support CPPC in _OSC on non-Intel platforms.
>
> This unfortunately caused a regression on a vartiety of AMD
> platforms in the field because a number of AMD platforms don't set
> the `_OSC` bit 5 or 6 to indicate CPPC or CPPC v2 support.
>
> As these AMD platforms already claim CPPC support via a dedicated
> MSR from `X86_FEATURE_CPPC`, use that to enable this feature rather
> than requiring the `_OSC` on platforms with a dedicated MSR.
>
> If there is additional breakage on the shared memory designs also
> missing this _OSC, additional follow up changes may be needed.
>
> Fixes: 72f2ecb7ece7 ("Set CPPC _OSC bits for all and when CPPC_LIB is supported")
> Reported-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I'm still concerned about the possible cases in which there is _CPC,
but it returns garbage, because the firmware thinks that the OS will
not use _CPC due to the _OSC handshake.

> ---
> v1->v2:
>  * Make the code easier to follow (suggested by Rafael)
>  * Update commit message to reflect this is only fixing the MSR case
>    and that any other breakage from 72f2ecb7ece7 will need additional
>    follow ups
>  drivers/acpi/cppc_acpi.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 903528f7e187..cc154519c608 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -629,7 +629,15 @@ static bool is_cppc_supported(int revision, int num_ent)
>                 return false;
>         }
>
> -       return true;
> +       if (!osc_sb_cppc_not_supported)
> +               return true;
> +
> +       pr_debug("Firmware missing _OSC support\n");
> +#ifdef CONFIG_X86
> +       return boot_cpu_has(X86_FEATURE_CPPC);

So can you please add an additional X86_VENDOR_AMD check to the above?

> +#else
> +       return false;
> +#endif
>  }
>
>  /*
> @@ -684,9 +692,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>         acpi_status status;
>         int ret = -ENODATA;
>
> -       if (osc_sb_cppc_not_supported)
> -               return -ENODEV;
> -
>         /* Parse the ACPI _CPC table for this CPU. */
>         status = acpi_evaluate_object_typed(handle, "_CPC", NULL, &output,
>                         ACPI_TYPE_PACKAGE);
> --
> 2.25.1
>
