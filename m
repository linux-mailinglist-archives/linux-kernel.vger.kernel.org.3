Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD875450E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbiFIPdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242129AbiFIPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:33:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F6F12AB1D;
        Thu,  9 Jun 2022 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654788815; x=1686324815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sA0rq9EgvIhQ2pGZLCBdDeRoUaCtcbrEIva0enaW/no=;
  b=gxJPFoNakh9J2IMf9LXURkSSAk322s+6wbeCB5G7SxCiwOxyzXrxYVhH
   u3Hl6uhKcBFQ39dSx8Or7AlvPeUXvk04cSLZw1XzXE96rHK4u0Qb9Hncp
   ejiuE/EqdN4xXCjOPUpNMSadem9O3FGnOxhbg+0W/m4/tL4spGnBSkMrF
   FJ9luClNeJC+SQtm4k+UCUNWEm7TQoFk7KM2xjp3RCwE3cquUD9/8+tBP
   oLOBJYIJnYQzyaKKe8NzrNgiFyiHZDKUogB4GrA23l9jqc2qN2PrF6SjT
   oyq0+MWEVkZce/ZA4MyyYln1xnt/lfDS/swKjgURK2Qk9AnX0KNRmO87T
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="277345940"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="277345940"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:33:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="637586207"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.57.243])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:33:12 -0700
Message-ID: <f2b9b34d-2d80-9e75-3158-7604ffd099a8@intel.com>
Date:   Thu, 9 Jun 2022 18:33:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v1 15/16] ACPI / MMC: PM: Unify fixing up device power
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
References: <1843211.tdWV9SEqCh@kreacher> <2159220.NgBsaNRSFp@kreacher>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <2159220.NgBsaNRSFp@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/06/22 17:18, Rafael J. Wysocki wrote:
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

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
>  	struct device *dev = &pdev->dev;
>  	const struct sdhci_acpi_slot *slot;
> -	struct acpi_device *device, *child;
>  	const struct dmi_system_id *id;
> +	struct acpi_device *device;
>  	struct sdhci_acpi_host *c;
>  	struct sdhci_host *host;
>  	struct resource *iomem;
> @@ -796,10 +796,7 @@ static int sdhci_acpi_probe(struct platf
>  	slot = sdhci_acpi_get_slot(device);
>  
>  	/* Power on the SDHCI controller and its children */
> -	acpi_device_fix_up_power(device);
> -	list_for_each_entry(child, &device->children, node)
> -		if (child->status.present && child->status.enabled)
> -			acpi_device_fix_up_power(child);
> +	acpi_device_fix_up_power_extended(device);
>  
>  	if (sdhci_acpi_byt_defer(dev))
>  		return -EPROBE_DEFER;
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
> +	if (adev->status.present && adev->status.enabled)
> +		acpi_device_fix_up_power(adev);
> +
> +	return 0;
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
> +	acpi_device_fix_up_power(adev);
> +	acpi_dev_for_each_child(adev, fix_up_power_if_applicable, NULL);
> +}
> +EXPORT_SYMBOL_GPL(acpi_device_fix_up_power_extended);
> +
>  int acpi_device_update_power(struct acpi_device *device, int *state_p)
>  {
>  	int state;
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
> -	struct acpi_device *device, *child;
> +	struct acpi_device *device;
>  
>  	device = ACPI_COMPANION(&slot->chip->pdev->dev);
> -	if (!device)
> -		return;
> -
> -	acpi_device_fix_up_power(device);
> -	list_for_each_entry(child, &device->children, node)
> -		if (child->status.present && child->status.enabled)
> -			acpi_device_fix_up_power(child);
> +	if (device)
> +		acpi_device_fix_up_power_extended(device);
>  }
>  #else
>  static inline void intel_mrfld_mmc_fix_up_power_slot(struct sdhci_pci_slot *slot) {}
> 
> 
> 

