Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704C25AC50F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiIDPmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiIDPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:42:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 489E12CDCB;
        Sun,  4 Sep 2022 08:42:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1151D6E;
        Sun,  4 Sep 2022 08:42:05 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D1CF3F73D;
        Sun,  4 Sep 2022 08:41:57 -0700 (PDT)
Date:   Sun, 4 Sep 2022 16:41:55 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        dan.carpenter@oracle.com, "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] powercap: arm_scmi: Add SCMI Powercap based driver
Message-ID: <YxTHQ9PRU8spf5x2@e120937-lin>
References: <20220817105424.3124006-1-cristian.marussi@arm.com>
 <20220817105424.3124006-2-cristian.marussi@arm.com>
 <9ee42d60-1bdd-c1e8-ec6e-38d0e1fcf4d8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ee42d60-1bdd-c1e8-ec6e-38d0e1fcf4d8@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 02:16:42PM +0100, Lukasz Luba wrote:
> Hi Cristian,
> 

Hi Lukasz,

thanks for having a look first of all !

> On 8/17/22 11:54, Cristian Marussi wrote:
> > Add a powercap driver that, using the ARM SCMI Protocol to query the SCMI
> > platform firmware for the list of existing Powercap domains, registers all
> > of such discovered domains under the new 'arm-scmi' powercap control type.
> > 
> > A new simple powercap zone and constraint is registered for all the SCMI
> > powercap zones that are found.
> > 
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v4 --> v5
> > - fix _init cleaning up powerctrl zone on failure
> > - removed uneeded casting
> > - simplified normalization helpers
> > v3 --> v4
> > - get rid of scmi setup/teardwn and use std module_init/module_exit
> > v1 --> v2
> > - fix sparse warning about missing static on global  *scmi_top_pcntrl;
> > ---
> >   drivers/powercap/Kconfig             |  13 +
> >   drivers/powercap/Makefile            |   1 +
> >   drivers/powercap/arm_scmi_powercap.c | 544 +++++++++++++++++++++++++++
> >   3 files changed, 558 insertions(+)
> >   create mode 100644 drivers/powercap/arm_scmi_powercap.c
> > 
> > diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> > index 515e3ceb3393..90d33cd1b670 100644
> > --- a/drivers/powercap/Kconfig
> > +++ b/drivers/powercap/Kconfig
> > @@ -44,6 +44,19 @@ config IDLE_INJECT
> >   	  synchronously on a set of specified CPUs or alternatively
> >   	  on a per CPU basis.
> > +config ARM_SCMI_POWERCAP
> > +	tristate "ARM SCMI Powercap driver"
> > +	depends on ARM_SCMI_PROTOCOL
> > +	help
> > +	  This enables support for the ARM Powercap based on ARM SCMI
> > +	  Powercap protocol.
> > +
> > +	  ARM SCMI Powercap protocol allows power limits to be enforced
> > +	  and monitored against the SCMI Powercap domains advertised as
> > +	  available by the SCMI platform firmware.
> > +
> > +	  When compiled as module it will be called arm_scmi_powercap.ko.
> > +
> >   config DTPM
> >   	bool "Power capping for Dynamic Thermal Power Management (EXPERIMENTAL)"
> >   	depends on OF
> > diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
> > index 494617cdad88..4474201b4aa7 100644
> > --- a/drivers/powercap/Makefile
> > +++ b/drivers/powercap/Makefile
> > @@ -6,3 +6,4 @@ obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
> >   obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
> >   obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
> >   obj-$(CONFIG_IDLE_INJECT) += idle_inject.o
> > +obj-$(CONFIG_ARM_SCMI_POWERCAP) += arm_scmi_powercap.o
> > diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> > new file mode 100644
> > index 000000000000..9f3b8386b4d8
> > --- /dev/null
> > +++ b/drivers/powercap/arm_scmi_powercap.c
> > @@ -0,0 +1,544 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * SCMI Powercap support.
> > + *
> > + * Copyright (C) 2022 ARM Ltd.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/math.h>
> > +#include <linux/limits.h>
> > +#include <linux/list.h>
> > +#include <linux/module.h>
> > +#include <linux/powercap.h>
> > +#include <linux/scmi_protocol.h>
> > +
> > +#define to_scmi_powercap_zone(z)		\
> > +	container_of(z, struct scmi_powercap_zone, zone)
> > +
> > +static const struct scmi_powercap_proto_ops *powercap_ops;
> > +
> > +struct scmi_powercap_zone {
> > +	unsigned int height;
> > +	struct device *dev;
> > +	struct scmi_protocol_handle *ph;
> > +	const struct scmi_powercap_info *info;
> > +	struct scmi_powercap_zone *spzones;
> > +	struct powercap_zone zone;
> > +	struct list_head node;
> > +};
> > +
> > +struct scmi_powercap_root {
> > +	unsigned int num_zones;
> > +	struct scmi_powercap_zone *spzones;
> > +	struct list_head *registered_zones;
> > +};
> > +
> > +static struct powercap_control_type *scmi_top_pcntrl;
> > +
> > +static int scmi_powercap_zone_release(struct powercap_zone *pz)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int scmi_powercap_get_max_power_range_uw(struct powercap_zone *pz,
> > +						u64 *max_power_range_uw)
> > +{
> > +	*max_power_range_uw = U32_MAX;
> 
> Shouldn't be calculated based on pai info from the platform FW?
> e.g.
> *max_power_range_uw = spz->info->max_power_cap - spz->info->min_power_cap
> 
> (but with uW conversion in mind if needed)
> 

I double checked this and in include/linux/powercap.h these
powercap_zone_ops are defined as:

 * @get_max_power_range_uw:	Get maximum range of power counter in
 *				micro-watts.
 * @get_power_uw:		Get current power counter in micro-watts.

so these are really data related to average power consumed, i.e. in SCMI
parlance, info counters I can retrieve for a powercapping domain with
POWERCAP_MEASUREMENTS_GET, which returns a uint32 representing the
"average power consumption of the powercapping domain in the last PAI"

It seemed to me that this was unrelated to min/max powercap but more
something used to report actual powercap domain consumption, so I use
UINT32_MAX to represent the max range...on the other side in Linux these
powercap ops may seem more to expect to report a sort of progressive
accumulated comsuption value while I can only expose the average consumption
as calculated and reported by fw across the last PAI. (SCMI 4.10.3.10)

Looking again at this, I'm not sure really if this is ok for the powercap
Linux framework or should I instead try to keep a running accumulated value
inside this driver (built from the values I get from
POWERCAP_MEASUREMENTS_GET) and expose that....

... so thanks for pointing this out because it triggered more doubts :D
...any hint about this welcome.

> > +	return 0;
> > +}
> > +
> > +static int scmi_powercap_get_power_uw(struct powercap_zone *pz,
> > +				      u64 *power_uw)
> > +{
> > +	int ret;
> > +	u32 avg_power, pai;
> > +	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
> 
> Please order these lines from longest (on top) to shortest.
> 

Ah ok..I was convinced to have to order those exactly the other way around :P
(from shortest to the longest, from unitialized to initialized)...I'll fix

> > +
> > +	if (!spz->info)
> > +		return -ENODEV;
> > +
> > +	if (!spz->info->powercap_monitoring)
> > +		return -EINVAL;
> 
> Those checks might be done during setup. Please find my comment there.
> 

I agree partially, see my reply below near to your comment.

> > +
> > +	ret = powercap_ops->measurements_get(spz->ph, spz->info->id, &avg_power,
> > +					     &pai);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (spz->info->powercap_scale_mw)
> > +		*power_uw = avg_power * 1000;
> > +	else
> > +		*power_uw = avg_power;
> 
> Maybe:
> 
> 	*power_uw = avg_power;
> 	if (spz->info->powercap_scale_mw)
> 		*power_uw *= 1000;
> 

Yes definetely better, I'll fix in V6.

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct powercap_zone_ops zone_ops = {
> > +	.get_max_power_range_uw = scmi_powercap_get_max_power_range_uw,
> > +	.get_power_uw = scmi_powercap_get_power_uw,
> > +	.release = scmi_powercap_zone_release,
> > +};
> > +
> > +static inline void
> 
> Drop inline here, compiler will figure out.
> 

Ok.
> > +scmi_powercap_normalize_cap(const struct scmi_powercap_info *info,
> > +			    u64 power_limit_uw, u32 *normalized)
> > +{
> > +	u64 req_power;
> > +
> > +	if (info->powercap_scale_mw)
> > +		req_power = DIV_ROUND_UP_ULL(power_limit_uw, 1000);
> > +	else
> > +		req_power = power_limit_uw;
> > +
> > +	if (req_power > info->max_power_cap)
> > +		*normalized = info->max_power_cap;
> > +	else if (req_power < info->min_power_cap)
> > +		*normalized = info->min_power_cap;
> > +	else
> > +		/*
> > +		 * This cast is lossless since here @req_power is certain to be
> > +		 * within the range [min_power_cap, max_power_cap] whose bounds
> > +		 * are assured to be two unsigned 32bits quantities.
> > +		 */
> > +		*normalized = (u32)req_power;
> 
> clamp() or clamp_t() might simplify those lines
> 

Yes indeed I wondered if there was not some Kernel macros to do that in
a simpler way...thanks for pointing me at that ! I'll rework.

> > +
> > +	*normalized = rounddown(*normalized, info->power_cap_step);
> > +}
> > +
> > +static int scmi_powercap_set_power_limit_uw(struct powercap_zone *pz, int cid,
> > +					    u64 power_uw)
> > +{
> > +	u32 norm_power;
> > +	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
> 
> sorting ^^^
> 

Ok.
> > +
> > +	if (!spz->info)
> > +		return -ENODEV;
> > +
> > +	if (!spz->info->powercap_cap_config)
> > +		return -EINVAL;
> > +
> > +	scmi_powercap_normalize_cap(spz->info, power_uw, &norm_power);
> > +
> > +	return powercap_ops->cap_set(spz->ph, spz->info->id, norm_power, false);
> > +}
> > +
> > +static int scmi_powercap_get_power_limit_uw(struct powercap_zone *pz, int cid,
> > +					    u64 *power_limit_uw)
> > +{
> > +	int ret;
> > +	u32 power;
> > +	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
> 
> sorting ^^^
> 
Ok.

> > +
> > +	if (!spz->info)
> > +		return -ENODEV;
> > +
> > +	ret = powercap_ops->cap_get(spz->ph, spz->info->id, &power);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (spz->info->powercap_scale_mw)
> > +		*power_limit_uw = power * 1000;
> > +	else
> > +		*power_limit_uw = power;
> 
> 	*power_limit_uw = power;
> 	if (spz->info->powercap_scale_mw)
> 		*power_limit_uw *= 1000;
> 

Ditto.

> > +
> > +	return 0;
> > +}
> > +
> > +static inline void
> 
> IMO inline not needed here, compiler will know.
> 

Ok.

> > +scmi_powercap_normalize_time(const struct scmi_powercap_info *info,
> > +			     u64 time_us, u32 *normalized)
> > +{
> > +	if (time_us > info->max_pai)
> > +		*normalized = info->max_pai;
> > +	else if (time_us < info->min_pai)
> > +		*normalized = info->min_pai;
> > +	else
> > +		/*
> > +		 * This cast is lossless since here @time_us is certain to be
> > +		 * within the range [min_pai, max_pai] whose bounds
> > +		 * are assured to be two unsigned 32bits quantities.
> > +		 */
> > +		*normalized = (u32)time_us;
> 
> clamp() ?
> 

Ditto.

> > +
> > +	*normalized = rounddown(*normalized, info->pai_step);
> > +}
> > +
> > +static int scmi_powercap_set_time_window_us(struct powercap_zone *pz, int cid,
> > +					    u64 time_window_us)
> > +{
> > +	u32 norm_pai;
> > +	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
> > +
> > +	if (!spz->info)
> > +		return -ENODEV;
> > +
> > +	if (!spz->info->powercap_pai_config)
> > +		return -EINVAL;
> > +
> > +	scmi_powercap_normalize_time(spz->info, time_window_us, &norm_pai);
> > +
> > +	return powercap_ops->pai_set(spz->ph, spz->info->id, norm_pai);
> > +}
> > +
> > +static int scmi_powercap_get_time_window_us(struct powercap_zone *pz, int cid,
> > +					    u64 *time_window_us)
> > +{
> > +	int ret;
> > +	u32 pai;
> > +	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
> 
> sorting
> 

Ok.

> > +
> > +	if (!spz->info)
> > +		return -ENODEV;
> > +
> > +	ret = powercap_ops->pai_get(spz->ph, spz->info->id, &pai);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*time_window_us = pai;
> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_powercap_get_max_power_uw(struct powercap_zone *pz, int cid,
> > +					  u64 *max_power_uw)
> > +{
> > +	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
> > +
> > +	if (!spz->info)
> > +		return -ENODEV;
> > +
> > +	if (spz->info->powercap_scale_uw)
> > +		*max_power_uw = spz->info->max_power_cap;
> > +	else
> > +		*max_power_uw = spz->info->max_power_cap * 1000;
> 
> 	*max_power_uw = spz->info->max_power_cap;
> 	if (spz->info->powercap_scale_mw)
> 		*max_power_uw *= 1000;
> 

Ditto.

> > +
> > +	return 0;
> > +}
> > +
> > +static int scmi_powercap_get_min_power_uw(struct powercap_zone *pz, int cid,
> > +					  u64 *min_power_uw)
> > +{
> > +	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
> > +
> > +	if (!spz->info)
> > +		return -ENODEV;
> > +
> > +	if (spz->info->powercap_scale_uw)
> > +		*min_power_uw = spz->info->min_power_cap;
> > +	else
> > +		*min_power_uw = spz->info->min_power_cap * 1000;
> 
> 	*min_power_uw = spz->info->min_power_cap;
> 	if (spz->info->powercap_scale_mw)
> 		*min_power_uw *= 1000;
> 

Ditto.

> > +
> > +	return 0;

[snip]

> > +
> > +static int scmi_powercap_probe(struct scmi_device *sdev)
> > +{
> > +	int ret, i;
> > +	struct scmi_powercap_root *pr;
> > +	struct scmi_powercap_zone *spz;
> > +	struct scmi_protocol_handle *ph;
> > +	struct device *dev = &sdev->dev;
> > +	const struct scmi_handle *handle = sdev->handle;
> 
> I would drop 'handle' since it's used once only, then sort those
> lines in order.
> 
> > +
> > +	if (!handle)
> 
> maybe:
> 	if (!sdev->handle)
> 
> > +		return -ENODEV;
> > +
> > +	powercap_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_POWERCAP,
> 
> and here 'sdev->handle'
> 

Yes indeed it's better, I'll do.

> > +						 &ph);
> > +	if (IS_ERR(powercap_ops))
> > +		return PTR_ERR(powercap_ops);
> > +
> > +	pr = devm_kzalloc(dev, sizeof(*pr), GFP_KERNEL);
> > +	if (!pr)
> > +		return -ENOMEM;
> > +
> > +	pr->num_zones = powercap_ops->num_domains_get(ph);
> > +	if (pr->num_zones < 0) {
> > +		dev_err(dev, "number of powercap domains not found\n");
> > +		return pr->num_zones;
> > +	}
> > +
> > +	pr->spzones = devm_kcalloc(dev, pr->num_zones,
> > +				   sizeof(*pr->spzones), GFP_KERNEL);
> > +	if (!pr->spzones)
> > +		return -ENOMEM;
> > +
> > +	/* Allocate for worst possible scenario of maximum tree height. */
> > +	pr->registered_zones = devm_kcalloc(dev, pr->num_zones,
> > +					    sizeof(*pr->registered_zones),
> > +					    GFP_KERNEL);
> > +	if (!pr->registered_zones)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0, spz = pr->spzones; i < pr->num_zones; i++, spz++) {
> > +		/*
> > +		 * Powercap domains are validate by the protocol layer, i.e.
> > +		 * when only non-NULL domains are returned here, whose
> > +		 * parent_id is assured to point to another valid domain.
> > +		 */
> > +		spz->info = powercap_ops->info_get(ph, i);
> > +
> > +		spz->dev = dev;
> > +		spz->ph = ph;
> > +		spz->spzones = pr->spzones;
> > +		INIT_LIST_HEAD(&spz->node);
> > +		INIT_LIST_HEAD(&pr->registered_zones[i]);
> > +
> > +		/*
> > +		 * Forcibly skip powercap domains using an abstract scale.
> > +		 * Note that only leaves domains can be skipped, so this could
> > +		 * lead later to a global failure.
> > +		 */
> > +		if (!spz->info->powercap_scale_uw &&
> > +		    !spz->info->powercap_scale_mw) {
> > +			dev_warn(dev,
> > +				 "Abstract power scale not supported. Skip %s.\n",
> > +				 spz->info->name);
> > +			spz->info = NULL;
> > +			continue;
> > +		}
> 
> We can say that the power scale should be consistent in
> a platform. Then we can bail out when abstract scale has
> been found. This could also simplify code by a bit.
> 

I do NOT agree on this since I do NOT think from the SCMI spec we can
assume this semplification: Linux powercap has indeed this limitation on
scales BUT other non-Linux agents could indeed support abstract scales and
the SCMI server could advertise a well built hierarchy of powercap domains
including some abstract scale ones tha, if placed as leaves of the hierarchy,
could be ignored by Linux but used instead by other agents...or in the future
used by Linux too ?

I'll double check with Archs since I had already an internal exchange on
this and seemed to me that the current approach (of only bailing out when
non-leaves abstract scale domains are found) was fine, i.e. that I could
not just assume to receive only uw/mv scale domains.

> Can we also validate here some those lines, which are
> checked in many callback funcitons?
> 

Partially yes....see below...

> These are the lines, which could be then removed if we bail
> out here earlier:
> 	if (!spz->info)
> 		return -ENODEV;

I can remove this surely from everywhere since I really never register a
zone with NULL spx->info, this check all-around, my bad, is redundant.

> 	if (!spz->info->powercap_pai_config)
> 		return -EINVAL;
> 	if (!spz->info->powercap_monitoring)
> 		return -EINVAL;
>

Instead I cannot see why a powercap domain missing this capabilities
(PAI configuration and power consumption monitoring) should be
excluded as a whole...for this reason (if valid from the scale
perspective as said above) I currently register these powercap SCMI
zones even if lacking these supports and then return -EINVAL only for
the related Powercap unsupported callbacks...while still supporting as
an example setting min/max powercaps.

Thanks,
Regards,
Cristian

