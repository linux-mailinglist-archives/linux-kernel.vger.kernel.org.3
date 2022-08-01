Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814DE586568
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiHAGtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiHAGr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:47:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2CE41C106
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:44:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D865A1515;
        Sun, 31 Jul 2022 23:44:29 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D94B73F73B;
        Sun, 31 Jul 2022 23:44:27 -0700 (PDT)
Date:   Mon, 1 Aug 2022 07:44:21 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Arun KS <arunks.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com
Subject: Re: [RFC PATCH 14/16] firmware: arm_scmi: Add testing Voltage
 protocol support
Message-ID: <Yud2RbgHEiMz2OvD@e120937-lin>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
 <20220227205608.30812-15-cristian.marussi@arm.com>
 <CAKZGPANYh4aS47WH8UBPiTVdE9sOstZD+yZgHkPcUAWX=Gc-dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKZGPANYh4aS47WH8UBPiTVdE9sOstZD+yZgHkPcUAWX=Gc-dQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 10:17:00AM +0530, Arun KS wrote:
> Hi Cristian,
> 

Hi Arun,

first of all thanks for the feedback !

> On Mon, Feb 28, 2022 at 4:23 AM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > firmware: arm_scmi: Add testing Voltage protocol support
> >
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  .../arm_scmi/scmi_test_driver/Makefile        |  2 +-
> >  .../arm_scmi/scmi_test_driver/scmi_test.c     |  2 +
> >  .../arm_scmi/scmi_test_driver/test_common.h   |  1 +
> >  .../arm_scmi/scmi_test_driver/test_voltages.c | 51 +++++++++++++++++++
> >  4 files changed, 55 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c
> >
> > diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/Makefile b/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
> > index 68a3d94a6a88..3b7df18de250 100644
> > --- a/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
> > +++ b/drivers/firmware/arm_scmi/scmi_test_driver/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  scmi_test_driver-objs := scmi_test.o test_common.o test_clocks.o test_sensors.o \
> > -       test_powers.o
> > +       test_powers.o test_voltages.o
> >  obj-$(CONFIG_ARM_SCMI_TEST_DRIVER) += scmi_test_driver.o
> >
> > diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c b/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
> > index df0d3e572010..2ca9f82c5bf3 100644
> > --- a/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
> > +++ b/drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
> > @@ -26,6 +26,7 @@ int (*scmi_test_init[SCMI_MAX_PROTOCOLS])(struct scmi_test_setup *) = {
> >         [SCMI_PROTOCOL_POWER] = scmi_test_power_init,
> >         [SCMI_PROTOCOL_CLOCK] = scmi_test_clock_init,
> >         [SCMI_PROTOCOL_SENSOR] = scmi_test_sensor_init,
> > +       [SCMI_PROTOCOL_VOLTAGE] = scmi_test_voltage_init,
> >  };
> >
> >  static void
> > @@ -125,6 +126,7 @@ static int scmi_testing_probe(struct scmi_device *sdev)
> >  }
> >
> >  static const struct scmi_device_id scmi_id_table[] = {
> > +       { SCMI_PROTOCOL_VOLTAGE, "__scmi_test-voltage" },
> >         { SCMI_PROTOCOL_CLOCK, "__scmi_test-clock" },
> >         { SCMI_PROTOCOL_SENSOR, "__scmi_test-sensor" },
> >         { SCMI_PROTOCOL_POWER, "__scmi_test-power" },
> > diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
> > index 9f3d35ba4477..338b65da593f 100644
> > --- a/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
> > +++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
> > @@ -102,6 +102,7 @@ int scmi_test_release(struct inode *ino, struct file *filp);
> >
> >  int scmi_test_clock_init(struct scmi_test_setup *tsp);
> >  int scmi_test_sensor_init(struct scmi_test_setup *tsp);
> > +int scmi_test_voltage_init(struct scmi_test_setup *tsp);
> >  int scmi_test_power_init(struct scmi_test_setup *tsp);
> >
> >  #endif /* __SCMI_TEST_COMMON_H */
> > diff --git a/drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c b/drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c
> > new file mode 100644
> > index 000000000000..ab91080e3a0f
> > --- /dev/null
> > +++ b/drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * SCMI Testing Driver - Voltage Protocol
> > + *
> > + * Copyright (C) 2022 ARM Ltd.
> > + */
> > +
> > +#include <linux/dcache.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/err.h>
> > +#include <linux/fs.h>
> > +#include <linux/io.h>
> > +#include <linux/kstrtox.h>
> > +#include <linux/module.h>
> > +#include <linux/scmi_protocol.h>
> > +#include <linux/slab.h>
> > +
> > +#include "test_common.h"
> > +
> > +struct scmi_voltage_data {
> > +       unsigned int version;
> > +       int count;
> > +};
> > +
> > +int scmi_test_voltage_init(struct scmi_test_setup *tsp)
> > +{
> > +       struct scmi_voltage_data *vdata;
> > +       struct device *dev = &tsp->sdev->dev;
> > +       const struct scmi_voltage_proto_ops *voltage_ops;
> > +
> > +       vdata = devm_kzalloc(dev, sizeof(*vdata), GFP_KERNEL);
> > +       if (!vdata)
> > +               return -ENOMEM;
> > +
> > +       voltage_ops = tsp->ops;
> > +       vdata->version = voltage_ops->version_get(tsp->ph);
> > +       vdata->count = voltage_ops->num_domains_get(tsp->ph);
> > +
> > +       if (vdata->count <= 0) {
> > +               dev_err(dev, "number of voltage doms invalid: %d\n",
> > +                       vdata->count);
> > +               return vdata->count ?: -EINVAL;
> > +       }
> > +
> > +       dev_info(dev, "Found %d voltage resources.\n", vdata->count);
> > +
> > +       tsp->priv = vdata;
> > +       debugfs_create_x32("version", 0400, tsp->parent, &vdata->version);
> Any particular reason, why we are not creating debugfs entires for
> regulator level_get/level_set like it was done for
> clocks(rate_get_set)?

No, it is just that this RFC initial series was meant to gather feedback
on this approach at testing and to experiment with this solution itself
a bit, before committing more work to more extensive cover all SCMI protocols
and ops... so the series is 'incomplete' by design :P

... having said that, despite the series had not received so much
feedback at the end, I have worked in the background on extending its
SCMI coverage, so that now I can support all SCMI protocols (exposing all
ops on debugfs) ... I'll plan to post a new more extensive series in the
near(-ish) future once I'll have the time to clean it up and add more
example KSFT testcases (and fix the dummy ones ...)

Thanks,
Cristian

