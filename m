Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7855789AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbiGRSmV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Jul 2022 14:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGRSmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:42:19 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5322CDFA;
        Mon, 18 Jul 2022 11:42:18 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id e69so22468214ybh.2;
        Mon, 18 Jul 2022 11:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C4cwXdJ7L3y4frrr1jRFdIf4YSYSSE+S+nPlQERL2co=;
        b=XFx1AwvdORaXP82jsF8RAgNUvLCgOxDaDpJ1ncaxDYnvsTZtlIZiNhHXSSZ8E3HjYs
         cjtPRWR0ytEq4U2Z1ACGYViKwPI09W9sOjUnX+tHw8M/zgp/3EoiC98kaenSVRWKWqTq
         2U2/GmC0WVh5TKzMoFpAHnmEappf5PWwHeWOrtEcFzqLIBRQ17DWZznPui6qZdUtLWx2
         NqlcQVaVcqe48iS7mFpR3Vd224QTiijY5uYDGzDmsMhcd64doLgJ4qmaF+zS4y0lYccM
         xtuAi8K9kY4Wprrirzt0+dhHUObRR8PkKcw6zUuEBh90F0WSgHWu469lM/Sw3QIEZr8F
         o1Kg==
X-Gm-Message-State: AJIora9hIJSecvcS9MjS4PmcnFcXgCRdF2RaiDAfxh5dhCsoKsIVm87B
        C1joZgPD3mG9QcKXoTcNBfWhehWckJft2yLSDYA=
X-Google-Smtp-Source: AGRyM1vFgT8R1gPsi9sI02Sz99YuHNheKRhHqMzOe17wC/miaaaXd3bzbbiisF892JjtVwpdTR9j6fEc5CrEFeME2VE=
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr26320244ybu.365.1658169738067; Mon, 18
 Jul 2022 11:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220715173326.3578-1-mario.limonciello@amd.com>
In-Reply-To: <20220715173326.3578-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Jul 2022 20:42:02 +0200
Message-ID: <CAJZ5v0h7G0PLr7NUL-NhB0AJm=-vfN-Os29M+8WjFW-W2gPpkQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Don't require flexible address space if
 X86_FEATURE_CPPC is supported
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Yuan, Perry" <perry.yuan@amd.com>,
        =?UTF-8?Q?Arek_Ru=C5=9Bniak?= <arek.rusi@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 7:33 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> commit 0651ab90e4ad ("ACPI: CPPC: Check _OSC for flexible address space")
> changed _CPC probing to require flexible address space to be negotiated
> for CPPC to work.
>
> However it was observed that this caused a regression for Arek's ROG
> Zephyrus G15 GA503QM which previously CPPC worked, but now it stopped
> working.
>
> To avoid causing a regression waive this failure when the CPU is known
> to support CPPC.
>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216248
> Fixes: 0651ab90e4ad ("ACPI: CPPC: Check _OSC for flexible address space")
> Reported-and-tested-by: Arek Ruśniak <arek.rusi@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 6ff1901d7d43..3c6d4ef87be0 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -782,7 +782,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>
>                                         if (!osc_cpc_flexible_adr_space_confirmed) {
>                                                 pr_debug("Flexible address space capability not supported\n");
> -                                               goto out_free;
> +                                               if (!cpc_supported_by_cpu())
> +                                                       goto out_free;
>                                         }
>
>                                         addr = ioremap(gas_t->address, gas_t->bit_width/8);
> @@ -809,7 +810,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>                                 }
>                                 if (!osc_cpc_flexible_adr_space_confirmed) {
>                                         pr_debug("Flexible address space capability not supported\n");
> -                                       goto out_free;
> +                                       if (!cpc_supported_by_cpu())
> +                                               goto out_free;
>                                 }
>                         } else {
>                                 if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
> --

Applied as 5.19-rc material, thanks!
