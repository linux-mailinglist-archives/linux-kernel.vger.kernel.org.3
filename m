Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6352DBA9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242943AbiESRri convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 May 2022 13:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241094AbiESRrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:47:36 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994E666AD3;
        Thu, 19 May 2022 10:47:35 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2ff155c239bso64799767b3.2;
        Thu, 19 May 2022 10:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rpb9BNLyf7R7d5RWXSuPx6wZerxEmHR0KWWlnJXf2Aw=;
        b=RE9puDcJtvXHhpHn8YxW8bKYRIqO2eA7O73NTm6z+IrF1wprA516iAlraWn4iJAEUT
         iLVeqc6bLMV7zSIfiTZF6w0W30bnRg0uMhQLmUeiVHIRZJsXSnCD1QK0cQKdLpRjc6V5
         xiqb5Fc97PjTQed/jsx3ZcMa4mDT8AxOLvGPH5ytti+ksje4R9Yg3UWyTlfpggZcVBuA
         EUJLr2/AFQ5oJs94gg/DES1kwXK24WN4v2aHjuZPpfVCnEtMDPN7WiecKoCls/P2o9Rh
         1FBbd+uxkoK4Vsc4Ret2EjSgewUwssTpP7GRa05tnUSYo0BB766DZE6pf6OcGWJCS3Hy
         XD/A==
X-Gm-Message-State: AOAM5325tdWuWGtffINlo3iaNx04a0SJsNJHD0zGu0dMmuNmgWoCfyy8
        cC/0IvlKmyzkDQRW0P6pt5BtBtI6Fgaq5AUYKtU=
X-Google-Smtp-Source: ABdhPJxV9pbOpPfCOH4nXppcBkZkdQKdFP+vsxlKUg4Nf8Slup/mRhnzd2IMEdcOSas1ZAI38LfOrftqjKl9kSWdg1E=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr5761339ywb.326.1652982454816; Thu, 19
 May 2022 10:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220518090901.2724518-1-pierre.gondois@arm.com>
In-Reply-To: <20220518090901.2724518-1-pierre.gondois@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 May 2022 19:47:24 +0200
Message-ID: <CAJZ5v0iHMuw7Ap5edok38TjaTCqE5sBn2GYVPz2_z_tc09t-hw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ACPI: CPPC: Check _OSC for flexible address space
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:09 AM Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> ACPI 6.2 Section 6.2.11.2 'Platform-Wide OSPM Capabilities':
>   Starting with ACPI Specification 6.2, all _CPC registers can be in
>   PCC, System Memory, System IO, or Functional Fixed Hardware address
>   spaces. OSPM support for this more flexible register space scheme is
>   indicated by the “Flexible Address Space for CPPC Registers” _OSC bit
>
> Otherwise (cf ACPI 6.1, s8.4.7.1.1.X), _CPC registers must be in:
> - PCC or Functional Fixed Hardware address space if defined
> - SystemMemory address space (NULL register) if not defined
>
> Add the corresponding _OSC bit and check it when parsing _CPC objects.
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/bus.c       | 18 ++++++++++++++++++
>  drivers/acpi/cppc_acpi.c |  9 +++++++++
>  include/linux/acpi.h     |  2 ++
>  3 files changed, 29 insertions(+)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 3e58b613a2c4..9eca43d1d941 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -278,6 +278,20 @@ bool osc_sb_apei_support_acked;
>  bool osc_pc_lpi_support_confirmed;
>  EXPORT_SYMBOL_GPL(osc_pc_lpi_support_confirmed);
>
> +/*
> + * ACPI 6.2 Section 6.2.11.2 'Platform-Wide OSPM Capabilities':
> + *   Starting with ACPI Specification 6.2, all _CPC registers can be in
> + *   PCC, System Memory, System IO, or Functional Fixed Hardware address
> + *   spaces. OSPM support for this more flexible register space scheme is
> + *   indicated by the “Flexible Address Space for CPPC Registers” _OSC bit.
> + *
> + * Otherwise (cf ACPI 6.1, s8.4.7.1.1.X), _CPC registers must be in:
> + * - PCC or Functional Fixed Hardware address space if defined
> + * - SystemMemory address space (NULL register) if not defined
> + */
> +bool osc_cpc_flexible_adr_space_confirmed;
> +EXPORT_SYMBOL_GPL(osc_cpc_flexible_adr_space_confirmed);
> +
>  /*
>   * ACPI 6.4 Operating System Capabilities for USB.
>   */
> @@ -321,6 +335,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>         }
>  #endif
>
> +       capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
> +
>         if (IS_ENABLED(CONFIG_SCHED_MC_PRIO))
>                 capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_CPC_DIVERSE_HIGH_SUPPORT;
>
> @@ -366,6 +382,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
>                         capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
>                 osc_sb_native_usb4_support_confirmed =
>                         capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
> +               osc_cpc_flexible_adr_space_confirmed =
> +                       capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
>         }
>
>         kfree(context.ret.pointer);
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index bc1454789a06..6f09fe011544 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -736,6 +736,11 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>                                 if (gas_t->address) {
>                                         void __iomem *addr;
>
> +                                       if (!osc_cpc_flexible_adr_space_confirmed) {
> +                                               pr_debug("Flexible address space capability not supported\n");
> +                                               goto out_free;
> +                                       }
> +
>                                         addr = ioremap(gas_t->address, gas_t->bit_width/8);
>                                         if (!addr)
>                                                 goto out_free;
> @@ -758,6 +763,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>                                                  gas_t->address);
>                                         goto out_free;
>                                 }
> +                               if (!osc_cpc_flexible_adr_space_confirmed) {
> +                                       pr_debug("Flexible address space capability not supported\n");
> +                                       goto out_free;
> +                               }
>                         } else {
>                                 if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
>                                         /* Support only PCC, SystemMemory, SystemIO, and FFH type regs. */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d7136d13aa44..03465db16b68 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -574,6 +574,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>  #define OSC_SB_OSLPI_SUPPORT                   0x00000100
>  #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT                0x00001000
>  #define OSC_SB_GENERIC_INITIATOR_SUPPORT       0x00002000
> +#define OSC_SB_CPC_FLEXIBLE_ADR_SPACE          0x00004000
>  #define OSC_SB_NATIVE_USB4_SUPPORT             0x00040000
>  #define OSC_SB_PRM_SUPPORT                     0x00200000
>
> @@ -581,6 +582,7 @@ extern bool osc_sb_apei_support_acked;
>  extern bool osc_pc_lpi_support_confirmed;
>  extern bool osc_sb_native_usb4_support_confirmed;
>  extern bool osc_sb_cppc_not_supported;
> +extern bool osc_cpc_flexible_adr_space_confirmed;
>
>  /* USB4 Capabilities */
>  #define OSC_USB_USB3_TUNNELING                 0x00000001
> --

Applied as 5.19 material along with the rest of the series, thanks!
