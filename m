Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF70858DA88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244435AbiHIOuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243158AbiHIOuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:50:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21761A0;
        Tue,  9 Aug 2022 07:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660056611; x=1691592611;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MeOY66iMfT0VrAnqeNnxzAkGciSEZ0bAm2GSHVjxkys=;
  b=moRigWkGD0OvYRjUNcza8+vltn2dDl6Ctqs5lx1lFRDsoN9jvzc/5nbD
   YUmsGYR98HHcnaHmnA5CPd57Yh5D23MXBs0oaP0/BVPueVRVD2gQ1LslJ
   ekOVrlC9Qyge+fCg+xB5/N9RVL2UNIeCD5hRzBoabSE4qVbJuer2sNLyo
   JP9/36RMo4A21xmBs4aExiKRgNduqAf7LcJzRIxQFDVOU0XmNVYN0uuU1
   YmspuBdrZ+hyslxOWSP8eN6X2qAaWegt2qMMpggzo+/eQsqdRYo8EuDuE
   /KlcvKIDNwgMZlTWF8Ns6XpnFn1quDTxJuBNieFXVfe1ngWVUqXmexKOb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="271234059"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="271234059"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 07:50:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="850488485"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 07:50:10 -0700
Message-ID: <f7fd60bd53c54212dce08a49f73ab529b4277fce.camel@linux.intel.com>
Subject: Re: [PATCH v1 25/26] thermal/intel/int340x: Replace parameter to
 simplify
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Antoine Tenart <atenart@kernel.org>
Date:   Tue, 09 Aug 2022 07:50:10 -0700
In-Reply-To: <20220805145729.2491611-26-daniel.lezcano@linaro.org>
References: <20220805145729.2491611-1-daniel.lezcano@linaro.org>
         <20220805145729.2491611-26-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-05 at 16:57 +0200, Daniel Lezcano wrote:
> In the process of replacing the get_trip_* ops by the generic trip
> points, the current code has an 'override' property to add another
> indirection to a different ops.
> 
> Rework this approach to prevent this indirection and make the code
> ready for the generic trip points conversion.
> 
> Actually the get_temp() is different regarding the platform, so it is
> pointless to add a new set of ops but just create dynamically the ops
> at init time.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  .../int340x_thermal/int340x_thermal_zone.c    | 31 ++++++++-----------
>  .../int340x_thermal/int340x_thermal_zone.h    |  4 +--
>  .../processor_thermal_device.c                | 10 ++----
>  3 files changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git
> a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 62c0aa5d0783..10731b9a140a 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -18,9 +18,6 @@ static int int340x_thermal_get_zone_temp(struct
> thermal_zone_device *zone,
>         unsigned long long tmp;
>         acpi_status status;
>  
> -       if (d->override_ops && d->override_ops->get_temp)
> -               return d->override_ops->get_temp(zone, temp);
> -
>         status = acpi_evaluate_integer(d->adev->handle, "_TMP", NULL,
> &tmp);
>         if (ACPI_FAILURE(status))
>                 return -EIO;
> @@ -46,9 +43,6 @@ static int int340x_thermal_get_trip_temp(struct
> thermal_zone_device *zone,
>         struct int34x_thermal_zone *d = zone->devdata;
>         int i;
>  
> -       if (d->override_ops && d->override_ops->get_trip_temp)
> -               return d->override_ops->get_trip_temp(zone, trip,
> temp);
> -
>         if (trip < d->aux_trip_nr)
>                 *temp = d->aux_trips[trip];
>         else if (trip == d->crt_trip_id)
> @@ -79,9 +73,6 @@ static int int340x_thermal_get_trip_type(struct
> thermal_zone_device *zone,
>         struct int34x_thermal_zone *d = zone->devdata;
>         int i;
>  
> -       if (d->override_ops && d->override_ops->get_trip_type)
> -               return d->override_ops->get_trip_type(zone, trip,
> type);
> -
>         if (trip < d->aux_trip_nr)
>                 *type = THERMAL_TRIP_PASSIVE;
>         else if (trip == d->crt_trip_id)
> @@ -112,9 +103,6 @@ static int int340x_thermal_set_trip_temp(struct
> thermal_zone_device *zone,
>         acpi_status status;
>         char name[10];
>  
> -       if (d->override_ops && d->override_ops->set_trip_temp)
> -               return d->override_ops->set_trip_temp(zone, trip,
> temp);
> -
>         snprintf(name, sizeof(name), "PAT%d", trip);
>         status = acpi_execute_simple_method(d->adev->handle, name,
>                         millicelsius_to_deci_kelvin(temp));
> @@ -134,9 +122,6 @@ static int int340x_thermal_get_trip_hyst(struct
> thermal_zone_device *zone,
>         acpi_status status;
>         unsigned long long hyst;
>  
> -       if (d->override_ops && d->override_ops->get_trip_hyst)
> -               return d->override_ops->get_trip_hyst(zone, trip,
> temp);
> -
>         status = acpi_evaluate_integer(d->adev->handle, "GTSH", NULL,
> &hyst);
>         if (ACPI_FAILURE(status))
>                 *temp = 0;
> @@ -217,7 +202,7 @@ static struct thermal_zone_params
> int340x_thermal_params = {
>  };
>  
>  struct int34x_thermal_zone *int340x_thermal_zone_add(struct
> acpi_device *adev,
> -                               struct thermal_zone_device_ops
> *override_ops)
> +                                                    int (*get_temp)
> (struct thermal_zone_device *, int *))
>  {
>         struct int34x_thermal_zone *int34x_thermal_zone;
>         acpi_status status;
> @@ -231,8 +216,15 @@ struct int34x_thermal_zone
> *int340x_thermal_zone_add(struct acpi_device *adev,
>                 return ERR_PTR(-ENOMEM);
>  
>         int34x_thermal_zone->adev = adev;
> -       int34x_thermal_zone->override_ops = override_ops;
>  
> +       int34x_thermal_zone->ops = kmemdup(&int340x_thermal_zone_ops,
> +                                         
> sizeof(int340x_thermal_zone_ops), GFP_KERNEL);
> +       if (!int34x_thermal_zone->ops)
> +               goto err_ops_alloc;
> +
> +       if (get_temp)
> +               int34x_thermal_zone->ops->get_temp = get_temp;
> +       
>         status = acpi_evaluate_integer(adev->handle, "PATC", NULL,
> &trip_cnt);
>         if (ACPI_FAILURE(status))
>                 trip_cnt = 0;
> @@ -262,7 +254,7 @@ struct int34x_thermal_zone
> *int340x_thermal_zone_add(struct acpi_device *adev,
>                                                 acpi_device_bid(adev),
>                                                 trip_cnt,
>                                                 trip_mask,
> int34x_thermal_zone,
> -
>                                                &int340x_thermal_zone_ops
> ,
> +                                               int34x_thermal_zone-
> >ops,
>                                                 &int340x_thermal_params
> ,
>                                                 0, 0);
>         if (IS_ERR(int34x_thermal_zone->zone)) {
> @@ -281,6 +273,8 @@ struct int34x_thermal_zone
> *int340x_thermal_zone_add(struct acpi_device *adev,
>         acpi_lpat_free_conversion_table(int34x_thermal_zone-
> >lpat_table);
>         kfree(int34x_thermal_zone->aux_trips);
>  err_trip_alloc:
> +       kfree(int34x_thermal_zone->ops);
> +err_ops_alloc:
>         kfree(int34x_thermal_zone);
>         return ERR_PTR(ret);
>  }
> @@ -292,6 +286,7 @@ void int340x_thermal_zone_remove(struct
> int34x_thermal_zone
>         thermal_zone_device_unregister(int34x_thermal_zone->zone);
>         acpi_lpat_free_conversion_table(int34x_thermal_zone-
> >lpat_table);
>         kfree(int34x_thermal_zone->aux_trips);
> +       kfree(int34x_thermal_zone->ops);
>         kfree(int34x_thermal_zone);
>  }
>  EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
> diff --git
> a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> index 3b4971df1b33..e28ab1ba5e06 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> @@ -29,13 +29,13 @@ struct int34x_thermal_zone {
>         int hot_temp;
>         int hot_trip_id;
>         struct thermal_zone_device *zone;
> -       struct thermal_zone_device_ops *override_ops;
> +       struct thermal_zone_device_ops *ops;
>         void *priv_data;
>         struct acpi_lpat_conversion_table *lpat_table;
>  };
>  
>  struct int34x_thermal_zone *int340x_thermal_zone_add(struct
> acpi_device *,
> -                               struct thermal_zone_device_ops
> *override_ops);
> +                               int (*get_temp) (struct
> thermal_zone_device *, int *));
>  void int340x_thermal_zone_remove(struct int34x_thermal_zone *);
>  int int340x_thermal_read_trips(struct int34x_thermal_zone
> *int34x_zone);
>  
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index a8d98f1bd6c6..317703027ce9 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -207,10 +207,6 @@ static int proc_thermal_get_zone_temp(struct
> thermal_zone_device *zone,
>         return ret;
>  }
>  
> -static struct thermal_zone_device_ops proc_thermal_local_ops = {
> -       .get_temp       = proc_thermal_get_zone_temp,
> -};
> -
>  static int proc_thermal_read_ppcc(struct proc_thermal_device
> *proc_priv)
>  {
>         int i;
> @@ -285,7 +281,7 @@ int proc_thermal_add(struct device *dev, struct
> proc_thermal_device *proc_priv)
>         struct acpi_device *adev;
>         acpi_status status;
>         unsigned long long tmp;
> -       struct thermal_zone_device_ops *ops = NULL;
> +       int (*get_temp) (struct thermal_zone_device *, int *) = NULL;
>         int ret;
>  
>         adev = ACPI_COMPANION(dev);
> @@ -304,10 +300,10 @@ int proc_thermal_add(struct device *dev, struct
> proc_thermal_device *proc_priv)
>                 /* there is no _TMP method, add local method */
>                 stored_tjmax = get_tjmax();
>                 if (stored_tjmax > 0)
> -                       ops = &proc_thermal_local_ops;
> +                       get_temp = proc_thermal_get_zone_temp;
>         }
>  
> -       proc_priv->int340x_zone = int340x_thermal_zone_add(adev, ops);
> +       proc_priv->int340x_zone = int340x_thermal_zone_add(adev,
> get_temp);
>         if (IS_ERR(proc_priv->int340x_zone)) {
>                 return PTR_ERR(proc_priv->int340x_zone);
>         } else


