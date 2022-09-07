Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512325B0E20
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiIGU10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiIGU1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:27:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A151DC1650
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:27:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6DEF106F;
        Wed,  7 Sep 2022 13:27:27 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 880233F7B4;
        Wed,  7 Sep 2022 13:27:16 -0700 (PDT)
Message-ID: <26f5d7b9-48bc-7268-16f7-53e7d48c99ee@arm.com>
Date:   Wed, 7 Sep 2022 21:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v4 04/16] iommu: Always register bus notifiers
Content-Language: en-GB
To:     Saravana Kannan <saravanak@google.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
References: <cover.1660572783.git.robin.murphy@arm.com>
 <7462347bf938bd6eedb629a3a318434f6516e712.1660572783.git.robin.murphy@arm.com>
 <CAGETcx8fTP_wEq_5eo2xDb4pFY9X5t7naOdNnexPhrhZsQCVpQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAGETcx8fTP_wEq_5eo2xDb4pFY9X5t7naOdNnexPhrhZsQCVpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-07 19:50, Saravana Kannan wrote:
> On Mon, Aug 15, 2022 at 9:20 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> The number of bus types that the IOMMU subsystem deals with is small and
>> manageable, so pull that list into core code as a first step towards
>> cleaning up all the boilerplate bus-awareness from drivers. Calling
>> iommu_probe_device() before bus->iommu_ops is set will simply return
>> -ENODEV and not break the notifier call chain, so there should be no
>> harm in proactively registering all our bus notifiers at init time.
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
>> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com> # s390
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v4: Squash iommu_bus_init() entirely, for maximum simplicity. Ignoring
>>      the return from bus_register_notifier() is common, so hopefully it's
>>      all pretty self-explanatory now.
>>
>>   drivers/iommu/iommu.c | 72 ++++++++++++++++++++++---------------------
>>   1 file changed, 37 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 780fb7071577..a8d14f2a1035 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -6,6 +6,7 @@
>>
>>   #define pr_fmt(fmt)    "iommu: " fmt
>>
>> +#include <linux/amba/bus.h>
>>   #include <linux/device.h>
>>   #include <linux/dma-iommu.h>
>>   #include <linux/kernel.h>
>> @@ -16,11 +17,13 @@
>>   #include <linux/export.h>
>>   #include <linux/slab.h>
>>   #include <linux/errno.h>
>> +#include <linux/host1x_context_bus.h>
>>   #include <linux/iommu.h>
>>   #include <linux/idr.h>
>>   #include <linux/err.h>
>>   #include <linux/pci.h>
>>   #include <linux/bitops.h>
>> +#include <linux/platform_device.h>
>>   #include <linux/property.h>
>>   #include <linux/fsl/mc.h>
>>   #include <linux/module.h>
>> @@ -75,6 +78,8 @@ static const char * const iommu_group_resv_type_string[] = {
>>   #define IOMMU_CMD_LINE_DMA_API         BIT(0)
>>   #define IOMMU_CMD_LINE_STRICT          BIT(1)
>>
>> +static int iommu_bus_notifier(struct notifier_block *nb,
>> +                             unsigned long action, void *data);
>>   static int iommu_alloc_default_domain(struct iommu_group *group,
>>                                        struct device *dev);
>>   static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>> @@ -103,6 +108,22 @@ struct iommu_group_attribute iommu_group_attr_##_name =            \
>>   static LIST_HEAD(iommu_device_list);
>>   static DEFINE_SPINLOCK(iommu_device_lock);
>>
>> +static struct bus_type * const iommu_buses[] = {
>> +       &platform_bus_type,
>> +#ifdef CONFIG_PCI
>> +       &pci_bus_type,
>> +#endif
>> +#ifdef CONFIG_ARM_AMBA
>> +       &amba_bustype,
>> +#endif
>> +#ifdef CONFIG_FSL_MC_BUS
>> +       &fsl_mc_bus_type,
>> +#endif
>> +#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
>> +       &host1x_context_device_bus_type,
>> +#endif
>> +};
>> +
>>   /*
>>    * Use a function instead of an array here because the domain-type is a
>>    * bit-field, so an array would waste memory.
>> @@ -126,6 +147,8 @@ static const char *iommu_domain_type_str(unsigned int t)
>>
>>   static int __init iommu_subsys_init(void)
>>   {
>> +       struct notifier_block *nb;
>> +
>>          if (!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API)) {
>>                  if (IS_ENABLED(CONFIG_IOMMU_DEFAULT_PASSTHROUGH))
>>                          iommu_set_default_passthrough(false);
>> @@ -152,6 +175,15 @@ static int __init iommu_subsys_init(void)
>>                          (iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
>>                                  "(set via kernel command line)" : "");
>>
>> +       nb = kcalloc(ARRAY_SIZE(iommu_buses), sizeof(*nb), GFP_KERNEL);
>> +       if (!nb)
>> +               return -ENOMEM;
>> +
>> +       for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>> +               nb[i].notifier_call = iommu_bus_notifier;
>> +               bus_register_notifier(iommu_buses[i], &nb[i]);
>> +       }
>> +
> 
> Carrying on the community's general disdain for notifiers, can we drop
> the bus notifier and just call iommu_probe_device() directly from
> device_add()? That way, you also won't need to keep an ifdef-ed array
> of buses and it'll be easy to tell from driver core code that iommu
> stuff is happening as devices are added. And I'd probably move that
> call to be AFTER some of the fw_devlink stuff is done too.

Yup, we're working in that general direction, this is just big and moves 
slow :)

One of the next steps after this is unpicking 
{of,acpi}_iommu_configure() for iommu_probe_device() to take ownership 
of firmware parsing, after which it should be sufficiently 
self-contained that the notifier might indeed become the worst 
impediment to further reasoning. We'll still want to limit things to the 
small subset of buses where IOMMUs are at all relevant (one of the 
reasons that I stopped short of trying to grovel the whole list of 
registered buses out of the driver core here), but since there's a 
bus-specific element involved in parsing the firmware bindings, I'm 
expecting it to work out quite neatly in the end.

> Also, would it be possible to delay this until probe (sorry, don't
> have enough of IOMMU details in my head) and call iommu_probe_device()
> from really_probe() like we do to set up pinctrl, etc? That'd be
> ideal.

No, that's not so good, and in fact the stuff that can currently happen 
at driver probe time is already problematic and responsible for various 
subtle breakage. There are things about the IOMMU topology that need to 
be known regardless of whether drivers exist for all the devices, so now 
that fw_devlink can take care of waiting for IOMMU drivers to load, the 
rest of IOMMU setup (other than DMA ops) really does want to move back 
to device_add() time.

Thanks,
Robin.

> 
> -Saravana
> 
> 
>>          return 0;
>>   }
>>   subsys_initcall(iommu_subsys_init);
>> @@ -1775,39 +1807,6 @@ int bus_iommu_probe(struct bus_type *bus)
>>          return ret;
>>   }
>>
>> -static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
>> -{
>> -       struct notifier_block *nb;
>> -       int err;
>> -
>> -       nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
>> -       if (!nb)
>> -               return -ENOMEM;
>> -
>> -       nb->notifier_call = iommu_bus_notifier;
>> -
>> -       err = bus_register_notifier(bus, nb);
>> -       if (err)
>> -               goto out_free;
>> -
>> -       err = bus_iommu_probe(bus);
>> -       if (err)
>> -               goto out_err;
>> -
>> -
>> -       return 0;
>> -
>> -out_err:
>> -       /* Clean up */
>> -       bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
>> -       bus_unregister_notifier(bus, nb);
>> -
>> -out_free:
>> -       kfree(nb);
>> -
>> -       return err;
>> -}
>> -
>>   /**
>>    * bus_set_iommu - set iommu-callbacks for the bus
>>    * @bus: bus.
>> @@ -1836,9 +1835,12 @@ int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
>>          bus->iommu_ops = ops;
>>
>>          /* Do IOMMU specific setup for this bus-type */
>> -       err = iommu_bus_init(bus, ops);
>> -       if (err)
>> +       err = bus_iommu_probe(bus);
>> +       if (err) {
>> +               /* Clean up */
>> +               bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
>>                  bus->iommu_ops = NULL;
>> +       }
>>
>>          return err;
>>   }
>> --
>> 2.36.1.dirty
>>
>>
