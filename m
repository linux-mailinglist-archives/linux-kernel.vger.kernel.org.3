Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9C15B0CB6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIGSvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIGSvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:51:11 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1272E9E9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 11:51:10 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 130so22924007ybw.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 11:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3OvMVNdxc1Lr6xZwtK0p7ZbJJgvUUT7bh3TNLzVW9Ic=;
        b=j2jWsXJ59nilQ4XJNzg7SjjuppLOXRS91QnE1qzWm0fp5mbF07WsPzBOLb4HgRCewr
         Rr6C58AHRycj2GXncRRJt8W5mWrmW4noaEFy2mGbUz3x+YAZVRFbAdypfnlyx7SpPCUT
         74EurW8jX+/oDM9BAzSWkb4bRh5rDr+nvGFkg607bF/Q6XVXl8vnV8/hmzWEca8p+vb3
         cdX0kqyHNF89pxjFD3XJT4e4o5YOZ/Hhr1rQWF8nAVOABaNAPQNy5IY0y0jqnjUFFI39
         5CHVR99BA9ZGv7mV4+7d5YWF2QYm5ziVs9YzQ5s1OS9x39qUUJHtKL4+EP4mriBRXl4M
         hsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3OvMVNdxc1Lr6xZwtK0p7ZbJJgvUUT7bh3TNLzVW9Ic=;
        b=4/QIWKoqARW+1w/rjmpIG24zXTONsranLuacXn2G+9mNu65IC2xkPGaog45qMIOD21
         3mh+54/2LwiuKs2eyg1KZWBbs9IgB6dyG5FqKVOAs7deUuKwAk/5QXnUCBfFLL3XqooI
         g6+BD/4dahY/0zTwx5iatNafEjjqLLjHb06/FIF6jEqcWor1B5b14aYaQbxcZvZOJZz4
         XujwFDQRWUwq33JL8oL3EALElLG2nBSkRvGQdQt7twgiBpQ1T5xgaznuj9vIYm1phDnU
         i8FT4LDN4ZnCfC7gVOrhnhaQR+wWLKzpvjw671MV0EjlQaC2tOaSDDcHjN1EsOFbkiPE
         H+6w==
X-Gm-Message-State: ACgBeo2N3TByz6OXM2+6MyTkGFVEgY+tk6u7NBV2l5cWTHrKTw06mU6J
        03KH+ftg/GFCT6NFBorziFDJvqRCds9vgvwJbMxQrA==
X-Google-Smtp-Source: AA6agR5xn7D0pJIAmORXSpr+dwaItRsj/1cuWja16B5o1WH6ER4gwVbakDcn+kSTW1GNdIIyT5jS+IkaaGDy1OG8jDs=
X-Received: by 2002:a25:4683:0:b0:69d:cfad:660e with SMTP id
 t125-20020a254683000000b0069dcfad660emr4005569yba.352.1662576669201; Wed, 07
 Sep 2022 11:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660572783.git.robin.murphy@arm.com> <7462347bf938bd6eedb629a3a318434f6516e712.1660572783.git.robin.murphy@arm.com>
In-Reply-To: <7462347bf938bd6eedb629a3a318434f6516e712.1660572783.git.robin.murphy@arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 7 Sep 2022 11:50:33 -0700
Message-ID: <CAGETcx8fTP_wEq_5eo2xDb4pFY9X5t7naOdNnexPhrhZsQCVpQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/16] iommu: Always register bus notifiers
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 9:20 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> The number of bus types that the IOMMU subsystem deals with is small and
> manageable, so pull that list into core code as a first step towards
> cleaning up all the boilerplate bus-awareness from drivers. Calling
> iommu_probe_device() before bus->iommu_ops is set will simply return
> -ENODEV and not break the notifier call chain, so there should be no
> harm in proactively registering all our bus notifiers at init time.
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com> # s390
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> v4: Squash iommu_bus_init() entirely, for maximum simplicity. Ignoring
>     the return from bus_register_notifier() is common, so hopefully it's
>     all pretty self-explanatory now.
>
>  drivers/iommu/iommu.c | 72 ++++++++++++++++++++++---------------------
>  1 file changed, 37 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 780fb7071577..a8d14f2a1035 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -6,6 +6,7 @@
>
>  #define pr_fmt(fmt)    "iommu: " fmt
>
> +#include <linux/amba/bus.h>
>  #include <linux/device.h>
>  #include <linux/dma-iommu.h>
>  #include <linux/kernel.h>
> @@ -16,11 +17,13 @@
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/errno.h>
> +#include <linux/host1x_context_bus.h>
>  #include <linux/iommu.h>
>  #include <linux/idr.h>
>  #include <linux/err.h>
>  #include <linux/pci.h>
>  #include <linux/bitops.h>
> +#include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/fsl/mc.h>
>  #include <linux/module.h>
> @@ -75,6 +78,8 @@ static const char * const iommu_group_resv_type_string[] = {
>  #define IOMMU_CMD_LINE_DMA_API         BIT(0)
>  #define IOMMU_CMD_LINE_STRICT          BIT(1)
>
> +static int iommu_bus_notifier(struct notifier_block *nb,
> +                             unsigned long action, void *data);
>  static int iommu_alloc_default_domain(struct iommu_group *group,
>                                       struct device *dev);
>  static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
> @@ -103,6 +108,22 @@ struct iommu_group_attribute iommu_group_attr_##_name =            \
>  static LIST_HEAD(iommu_device_list);
>  static DEFINE_SPINLOCK(iommu_device_lock);
>
> +static struct bus_type * const iommu_buses[] = {
> +       &platform_bus_type,
> +#ifdef CONFIG_PCI
> +       &pci_bus_type,
> +#endif
> +#ifdef CONFIG_ARM_AMBA
> +       &amba_bustype,
> +#endif
> +#ifdef CONFIG_FSL_MC_BUS
> +       &fsl_mc_bus_type,
> +#endif
> +#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
> +       &host1x_context_device_bus_type,
> +#endif
> +};
> +
>  /*
>   * Use a function instead of an array here because the domain-type is a
>   * bit-field, so an array would waste memory.
> @@ -126,6 +147,8 @@ static const char *iommu_domain_type_str(unsigned int t)
>
>  static int __init iommu_subsys_init(void)
>  {
> +       struct notifier_block *nb;
> +
>         if (!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API)) {
>                 if (IS_ENABLED(CONFIG_IOMMU_DEFAULT_PASSTHROUGH))
>                         iommu_set_default_passthrough(false);
> @@ -152,6 +175,15 @@ static int __init iommu_subsys_init(void)
>                         (iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
>                                 "(set via kernel command line)" : "");
>
> +       nb = kcalloc(ARRAY_SIZE(iommu_buses), sizeof(*nb), GFP_KERNEL);
> +       if (!nb)
> +               return -ENOMEM;
> +
> +       for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
> +               nb[i].notifier_call = iommu_bus_notifier;
> +               bus_register_notifier(iommu_buses[i], &nb[i]);
> +       }
> +

Carrying on the community's general disdain for notifiers, can we drop
the bus notifier and just call iommu_probe_device() directly from
device_add()? That way, you also won't need to keep an ifdef-ed array
of buses and it'll be easy to tell from driver core code that iommu
stuff is happening as devices are added. And I'd probably move that
call to be AFTER some of the fw_devlink stuff is done too.

Also, would it be possible to delay this until probe (sorry, don't
have enough of IOMMU details in my head) and call iommu_probe_device()
from really_probe() like we do to set up pinctrl, etc? That'd be
ideal.

-Saravana


>         return 0;
>  }
>  subsys_initcall(iommu_subsys_init);
> @@ -1775,39 +1807,6 @@ int bus_iommu_probe(struct bus_type *bus)
>         return ret;
>  }
>
> -static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
> -{
> -       struct notifier_block *nb;
> -       int err;
> -
> -       nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
> -       if (!nb)
> -               return -ENOMEM;
> -
> -       nb->notifier_call = iommu_bus_notifier;
> -
> -       err = bus_register_notifier(bus, nb);
> -       if (err)
> -               goto out_free;
> -
> -       err = bus_iommu_probe(bus);
> -       if (err)
> -               goto out_err;
> -
> -
> -       return 0;
> -
> -out_err:
> -       /* Clean up */
> -       bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
> -       bus_unregister_notifier(bus, nb);
> -
> -out_free:
> -       kfree(nb);
> -
> -       return err;
> -}
> -
>  /**
>   * bus_set_iommu - set iommu-callbacks for the bus
>   * @bus: bus.
> @@ -1836,9 +1835,12 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
>         bus->iommu_ops = ops;
>
>         /* Do IOMMU specific setup for this bus-type */
> -       err = iommu_bus_init(bus, ops);
> -       if (err)
> +       err = bus_iommu_probe(bus);
> +       if (err) {
> +               /* Clean up */
> +               bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
>                 bus->iommu_ops = NULL;
> +       }
>
>         return err;
>  }
> --
> 2.36.1.dirty
>
>
