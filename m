Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD156094E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiF2SmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiF2SmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:42:06 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A9D29827;
        Wed, 29 Jun 2022 11:42:04 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id d5so29545964yba.5;
        Wed, 29 Jun 2022 11:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niDepKniCB5d3I07y4zpYfnckX8GQNMPL/217Nk44uM=;
        b=364Lo2zzksxZUBSXzgrA+UfG7auHtNmoAZcSnFq8vTie+mrlVHVOEYS6DLv3zkRk3R
         1wstW/FG9jnhBZlhibDelgcvyqCRPO8KQ0KKEEpkW7bnDHxsP3s8jnUF0JU88JkB7z6B
         TCDM0Fh4RYYlbXPJHQ+LPSaok8H6OGmDo/ZMJ+bNCz1vyEfWSHuvclQrrVWPs+5uwBy+
         mgtRcd0CU7SEjaT3MHShhiq6rJqHnth8kv/tvdgUbFLx6s62pzHtLrTNCjzxiJp4Eino
         dikTAlfY/riGRTRPYfNXqhXd/ZuJnSaKlLIP4HLWkRt5+j/6fejwWkX4Kl1vx0H5wvlP
         nw1g==
X-Gm-Message-State: AJIora8UNbTa4dp76VvM3MYGq7h+oFhitZkgjJQgRAWwcAeI2yQ8S35j
        r803I0KPIS/psry5R9lPOuPIFpCCJ0JOwz/tVPoH5yMD
X-Google-Smtp-Source: AGRyM1u2pV3v9yOzU1KyjK6E4kduzKglliClPmQ+ZLhcYXW9iky+twdm/TvRio6H/u+xzywgKaQSQ0Em3pryU+SuJwk=
X-Received: by 2002:a25:5d8:0:b0:66c:dbd1:b2bb with SMTP id
 207-20020a2505d8000000b0066cdbd1b2bbmr4996934ybf.81.1656528124098; Wed, 29
 Jun 2022 11:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220627165832.10246-1-mario.limonciello@amd.com>
In-Reply-To: <20220627165832.10246-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 20:41:53 +0200
Message-ID: <CAJZ5v0g2qfA00=ukatTxSXPnoOaquwvn8tk0oNHaY-0F7ODZQw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supported
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Perry Yuan <perry.yuan@amd.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 6:58 PM Mario Limonciello
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
> As these AMD platforms already claim CPPC support via `X86_FEATURE_CPPC`,
> use this enable this feature rather than requiring the `_OSC`.
>
> Fixes: 72f2ecb7ece7 ("Set CPPC _OSC bits for all and when CPPC_LIB is supported")
> Reported-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 903528f7e187..5463e6309b9a 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -629,6 +629,15 @@ static bool is_cppc_supported(int revision, int num_ent)
>                 return false;
>         }
>
> +       if (osc_sb_cppc_not_supported) {
> +               pr_debug("Firmware missing _OSC support\n");
> +#ifdef CONFIG_X86
> +               return boot_cpu_has(X86_FEATURE_CPPC);
> +#else
> +               return false;
> +#endif

What about doing

if (osc_sb_cppc_not_supported) {
        pr_debug("Firmware missing _OSC support\n");
        return IS_ENABLED(CONFIG_X86) && boot_cpu_has(X86_FEATURE_CPPC);
}

instead for the sake of reducing #ifdeffery?

Also, this is somewhat risky, because even if the given processor has
X86_FEATURE_CPPC set, the platform may still not want to expose CPPC
through ACPI.  How's that going to work after this change?


> +       }
> +
>         return true;
>  }
>
> @@ -684,9 +693,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
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
> 2.34.1
>
