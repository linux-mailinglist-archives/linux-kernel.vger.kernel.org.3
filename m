Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985E95676A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiGESiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGESiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:38:13 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421CB1EC49;
        Tue,  5 Jul 2022 11:38:12 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31c86fe1dddso70398027b3.1;
        Tue, 05 Jul 2022 11:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTBtd5j1WUMnQ7vVABaHhbRtIXEepXmmN1NIn3/rT9A=;
        b=Kh109Tuai4Xkc0EWPnvSxpSh1vr/ZB2r7wZY887YO///j1T4c+AMJVFQeALEQDdCfb
         SN+3AZhWaNsmm/dNDXCuTQhh580XznmYYwLAb79CqSgllI5fcBE46Jzl7RyqNtcjQ/W5
         AuduDLisBdPMq3kAM+sS9194Rnq7hEROPG9M7hgBgusOeTYuadZj1YmWnYupGIHv/3mo
         Z2gpPn+G3PUSyY0vrrio3dWAqqdSeBWh4zp2PUSbpNtaMlqWx8qS2bvqlUYUh5GUOTPt
         Aju3rzmMMUKL6TRr0X7q2nzlcv4QjZI7r5sKXOmFv5ssaHSMOcVhVGIQrvWl3jXT09Zc
         wEHw==
X-Gm-Message-State: AJIora/GYbNt0ZENVUf7pvFRRa8qt40Of0sFnPeNrF0DFZzglReit+s0
        NBHzWL1dHTqTWEWcwUtw78Yt/DDxAXCrX4WXVwg=
X-Google-Smtp-Source: AGRyM1ugx3bqj0ffGQZP3Lyq3KuVaiHocgvfONScSpWL8SaIQbh9qUopfJuc1FMiHrwWqbv3DBB/uyXnQSZWTMzzqAM=
X-Received: by 2002:a81:a184:0:b0:31c:b00e:b5c4 with SMTP id
 y126-20020a81a184000000b0031cb00eb5c4mr10147696ywg.149.1657046291320; Tue, 05
 Jul 2022 11:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220705182915.11663-1-mario.limonciello@amd.com>
In-Reply-To: <20220705182915.11663-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 20:38:00 +0200
Message-ID: <CAJZ5v0gcNxWF9UHhdfT3Qm9XxqRHMnaCOyPoMS6rqxP9SgZ+LA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, CUI Hao <cuihao.leo@gmail.com>,
        maxim.novozhilov@gmail.com, lethe.tree@protonmail.com,
        garystephenwright@gmail.com, galaxyking0419@gmail.com,
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

On Tue, Jul 5, 2022 at 8:29 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Previously the kernel used to ignore whether the firmware masked CPPC
> or CPPCv2 and would just pretend that it worked.
>
> When support for the USB4 bit in _OSC was introduced from commit
> 9e1f561afb ("ACPI: Execute platform _OSC also with query bit clear")
> the kernel began to look at the return when the query bit was clear.
>
> This caused regressions that were misdiagnosed and attempted to be solved
> as part of commit 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities
> to the _OSC regardless of the query flag""). This caused a different
> regression where non-Intel systems weren't able to negotiate _OSC
> properly.
>
> This was reverted in commit 2ca8e6285250 ("Revert "ACPI: Pass the same
> capabilities to the _OSC regardless of the query flag"") and attempted to
> be fixed by commit c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not
> supported by firmware") but the regression still returned.
>
> These systems with the regression only load support for CPPC from an SSDT
> dynamically when _OSC reports CPPC v2.  Avoid the problem by not letting
> CPPC satisfy the requirement in `acpi_cppc_processor_probe`.
>
> Reported-by: CUI Hao <cuihao.leo@gmail.com>
> Reported-by: maxim.novozhilov@gmail.com
> Reported-by: lethe.tree@protonmail.com
> Reported-by: garystephenwright@gmail.com
> Reported-by: galaxyking0419@gmail.com
> Fixes: c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not supported by firmware")
> Fixes: 2ca8e6285250 ("Revert "ACPI Pass the same capabilities to the _OSC regardless of the query flag"")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=213023
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2075387
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: CUI Hao <cuihao.leo@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3->v4:
>  * Pick up tags
>
>  drivers/acpi/bus.c       | 11 +++++------
>  drivers/acpi/cppc_acpi.c |  4 +++-
>  include/linux/acpi.h     |  2 +-
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 86fa61a21826c..e2db1bdd9dd25 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -298,7 +298,7 @@ EXPORT_SYMBOL_GPL(osc_cpc_flexible_adr_space_confirmed);
>  bool osc_sb_native_usb4_support_confirmed;
>  EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
>
> -bool osc_sb_cppc_not_supported;
> +bool osc_sb_cppc2_support_acked;
>
>  static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
>  static void acpi_bus_osc_negotiate_platform_control(void)
> @@ -358,11 +358,6 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>                 return;
>         }
>
> -#ifdef CONFIG_ACPI_CPPC_LIB
> -       osc_sb_cppc_not_supported = !(capbuf_ret[OSC_SUPPORT_DWORD] &
> -                       (OSC_SB_CPC_SUPPORT | OSC_SB_CPCV2_SUPPORT));
> -#endif
> -
>         /*
>          * Now run _OSC again with query flag clear and with the caps
>          * supported by both the OS and the platform.
> @@ -376,6 +371,10 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>
>         capbuf_ret = context.ret.pointer;
>         if (context.ret.length > OSC_SUPPORT_DWORD) {
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +               osc_sb_cppc2_support_acked = capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPCV2_SUPPORT;
> +#endif
> +
>                 osc_sb_apei_support_acked =
>                         capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
>                 osc_pc_lpi_support_confirmed =
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 903528f7e187e..d64facbda0fb7 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -684,8 +684,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>         acpi_status status;
>         int ret = -ENODATA;
>
> -       if (osc_sb_cppc_not_supported)
> +       if (!osc_sb_cppc2_support_acked) {
> +               pr_debug("CPPC v2 _OSC not acked\n");
>                 return -ENODEV;
> +       }
>
>         /* Parse the ACPI _CPC table for this CPU. */
>         status = acpi_evaluate_object_typed(handle, "_CPC", NULL, &output,
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4f82a5bc6d987..44975c1bbe12f 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -584,7 +584,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>  extern bool osc_sb_apei_support_acked;
>  extern bool osc_pc_lpi_support_confirmed;
>  extern bool osc_sb_native_usb4_support_confirmed;
> -extern bool osc_sb_cppc_not_supported;
> +extern bool osc_sb_cppc2_support_acked;
>  extern bool osc_cpc_flexible_adr_space_confirmed;
>
>  /* USB4 Capabilities */
> --

Applied along with the [2/2] as fixes for 5.19-rc, thanks!
