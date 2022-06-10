Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0870F546664
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345267AbiFJMRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiFJMQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:16:59 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A38248558
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:16:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m25so26072632lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gx0HoGasRN7LdR7eXYM/bWw5laTDgx21Bj10QU7IgZA=;
        b=PnkYuuTonTwBAgjp/oKukv2FRIPd9je9Ttx3Q7yPHEpSoRKF9u97bHZ5iZ6/9JNTFS
         rhA5sF0dx/LtqGpSihcCe5Vsf6yVNhWEm3yCE2Uc23JvAxaaelk/CWNhazNI/abNqL5Q
         PABNTspLYCIwWOsW8fRrQUBWWG+XSnXU9YGS1QdDHhewm+5321VV+AVLpJ77ALXkJJzn
         a7PxBnMdO7CtNWeROr5ayi4wtni+E2aA82zhcSJ752cDBFC2JaBTnRiTCa99ph0NtaTe
         q4A1pWQNZCtjoPzO2v4xzEAh/BW094vPipo8w/R+PYFayhNprB/QBOhb9EPotq478h0V
         kUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gx0HoGasRN7LdR7eXYM/bWw5laTDgx21Bj10QU7IgZA=;
        b=y0aGBnkrDmnAjFLJW71R39KowHedm/4GQRGvnhck3sN4atFV6dPBcf+vQl1y2K3YfN
         V7odDVPnWIXTgw8KYjLE6sdoo+mMRnn3nIcis34F13x2G7b3EhUQylTuJbbkC3OqRqFU
         NAsccSnnB6f4Mkic+UZPz5ZMganfxBOQ1ntBc+VMq33m2MJ4uUPYJOLISdCR66B7Kw57
         3cDo30btklMbZb0bMikxvLpOtyy3NpDD2F3r+YYjlLCyhWhGLdZcmm7wb1yZ8cJCTiP2
         CxBpTXY2jf4r1GFNgF8w+fFuf+8/gh+dyCUtLRKm5RCOSl2xJlDVV9hAoWPZzkKznBCj
         u1Mw==
X-Gm-Message-State: AOAM531Gmc0Hp66N3h5h3kXn18cPmRhwqybZ6nIK3xdO1aNRpcL7qP/R
        I+z3bBahBiJzYFfC/+UcrO892QL5T4Skm7qU8sxDSA==
X-Google-Smtp-Source: ABdhPJzVguDPZ+MKhgnbfJ241zsjVT6vsWAAftLPmBKsL1BbPVGEvC63gkUEhpJLAgXajRky7w54C+QoCvQsvmQNKRc=
X-Received: by 2002:a2e:818c:0:b0:255:a6c5:4304 with SMTP id
 e12-20020a2e818c000000b00255a6c54304mr10731225ljg.367.1654863413929; Fri, 10
 Jun 2022 05:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <2159220.NgBsaNRSFp@kreacher>
In-Reply-To: <2159220.NgBsaNRSFp@kreacher>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Jun 2022 14:16:17 +0200
Message-ID: <CAPDyKFrbSm7iMx-XnMJ5xyKnd13_kC9w+qjVreeadUb=+bwaNQ@mail.gmail.com>
Subject: Re: [PATCH v1 15/16] ACPI / MMC: PM: Unify fixing up device power
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 at 16:20, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Introduce acpi_device_fix_up_power_extended() for fixing up power of
> a device having an ACPI companion in a manner that takes the device's
> children into account and make the MMC code use it in two places
> instead of walking the list of the device ACPI companion's children
> directly.
>
> This will help to eliminate the children list head from struct
> acpi_device as it is redundant and it is used in questionable ways
> in some places (in particular, locking is needed for walking the
> list pointed to it safely, but it is often missing).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rafael, feel free to pick this via your tree.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/acpi/device_pm.c          |   22 ++++++++++++++++++++++
>  drivers/mmc/host/sdhci-acpi.c     |    7 ++-----
>  drivers/mmc/host/sdhci-pci-core.c |   11 +++--------
>  include/acpi/acpi_bus.h           |    1 +
>  4 files changed, 28 insertions(+), 13 deletions(-)
>
> Index: linux-pm/drivers/mmc/host/sdhci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/mmc/host/sdhci-acpi.c
> +++ linux-pm/drivers/mmc/host/sdhci-acpi.c
> @@ -775,8 +775,8 @@ static int sdhci_acpi_probe(struct platf
>  {
>         struct device *dev = &pdev->dev;
>         const struct sdhci_acpi_slot *slot;
> -       struct acpi_device *device, *child;
>         const struct dmi_system_id *id;
> +       struct acpi_device *device;
>         struct sdhci_acpi_host *c;
>         struct sdhci_host *host;
>         struct resource *iomem;
> @@ -796,10 +796,7 @@ static int sdhci_acpi_probe(struct platf
>         slot = sdhci_acpi_get_slot(device);
>
>         /* Power on the SDHCI controller and its children */
> -       acpi_device_fix_up_power(device);
> -       list_for_each_entry(child, &device->children, node)
> -               if (child->status.present && child->status.enabled)
> -                       acpi_device_fix_up_power(child);
> +       acpi_device_fix_up_power_extended(device);
>
>         if (sdhci_acpi_byt_defer(dev))
>                 return -EPROBE_DEFER;
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -369,6 +369,28 @@ int acpi_device_fix_up_power(struct acpi
>  }
>  EXPORT_SYMBOL_GPL(acpi_device_fix_up_power);
>
> +static int fix_up_power_if_applicable(struct acpi_device *adev, void *not_used)
> +{
> +       if (adev->status.present && adev->status.enabled)
> +               acpi_device_fix_up_power(adev);
> +
> +       return 0;
> +}
> +
> +/**
> + * acpi_device_fix_up_power_extended - Force device and its children into D0.
> + * @adev: Parent device object whose power state is to be fixed up.
> + *
> + * Call acpi_device_fix_up_power() for @adev and its children so long as they
> + * are reported as present and enabled.
> + */
> +void acpi_device_fix_up_power_extended(struct acpi_device *adev)
> +{
> +       acpi_device_fix_up_power(adev);
> +       acpi_dev_for_each_child(adev, fix_up_power_if_applicable, NULL);
> +}
> +EXPORT_SYMBOL_GPL(acpi_device_fix_up_power_extended);
> +
>  int acpi_device_update_power(struct acpi_device *device, int *state_p)
>  {
>         int state;
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -524,6 +524,7 @@ const char *acpi_power_state_string(int
>  int acpi_device_set_power(struct acpi_device *device, int state);
>  int acpi_bus_init_power(struct acpi_device *device);
>  int acpi_device_fix_up_power(struct acpi_device *device);
> +void acpi_device_fix_up_power_extended(struct acpi_device *adev);
>  int acpi_bus_update_power(acpi_handle handle, int *state_p);
>  int acpi_device_update_power(struct acpi_device *device, int *state_p);
>  bool acpi_bus_power_manageable(acpi_handle handle);
> Index: linux-pm/drivers/mmc/host/sdhci-pci-core.c
> ===================================================================
> --- linux-pm.orig/drivers/mmc/host/sdhci-pci-core.c
> +++ linux-pm/drivers/mmc/host/sdhci-pci-core.c
> @@ -1240,16 +1240,11 @@ static const struct sdhci_pci_fixes sdhc
>  #ifdef CONFIG_ACPI
>  static void intel_mrfld_mmc_fix_up_power_slot(struct sdhci_pci_slot *slot)
>  {
> -       struct acpi_device *device, *child;
> +       struct acpi_device *device;
>
>         device = ACPI_COMPANION(&slot->chip->pdev->dev);
> -       if (!device)
> -               return;
> -
> -       acpi_device_fix_up_power(device);
> -       list_for_each_entry(child, &device->children, node)
> -               if (child->status.present && child->status.enabled)
> -                       acpi_device_fix_up_power(child);
> +       if (device)
> +               acpi_device_fix_up_power_extended(device);
>  }
>  #else
>  static inline void intel_mrfld_mmc_fix_up_power_slot(struct sdhci_pci_slot *slot) {}
>
>
>
