Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017E24B4646
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243377AbiBNJdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:33:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243670AbiBNJdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:33:05 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494D7BF45;
        Mon, 14 Feb 2022 01:31:32 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [80.241.60.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4JxzW66xYzz9sSG;
        Mon, 14 Feb 2022 10:31:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644831080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+KNf5VBw/BGO6N+UWzAJN/8XoP69TgmwRel9/e1LHdg=;
        b=uee5135QzTJVC864McL9zc6JsVDktlFAu3iewxMF01thf/VMj8hs0qsCQmD+z+nzk5yZ48
        7hdPos1n7k5JMDefm/JI5lKKtpCHk6DcN6vF8J7JgHSVYZLsGovpHHsh8BlqF4cfHMi4Xe
        0h54Ij07w1NAwmOhrF9IXS9OrJUSclCHNVIeWTiPyvPScS8QxlN6xQLbCgzNBrexsRvs8m
        q2ETxaHxWeSGq33YFqhHvTd3im9/byZGdnBHd5PYykMpM5JrdTEhu/RJWjnvPjQi/CQC8+
        Jl4dMcs2nyVHLcf8rMBwHJ0WM+KLXQMKi9v9w7/zaIgmixO2tfe79rjtbSswbg==
Message-ID: <a3114a04f293714a3ed2eaf131e33a812b31d10a.camel@sylv.io>
Subject: Re: [PATCH v1 4/4] pmbus (pli1209bc): Add regulator support
From:   sylv <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Date:   Mon, 14 Feb 2022 10:31:12 +0100
In-Reply-To: <07a08a9f-5600-f5d2-0955-4bc6e1f9a893@roeck-us.net>
References: <cover.1644597670.git.sylv@sylv.io>
         <0a657d200809dedc5fdd2095fae8c0f2fceecf1f.1644597670.git.sylv@sylv.io>
         <07a08a9f-5600-f5d2-0955-4bc6e1f9a893@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-11 at 11:44 -0800, Guenter Roeck wrote:
> On 2/11/22 09:17, Marcello Sylvester Bauer wrote:
> > Add regulator support for PLI1209BC Digital Supervisor.
> > 
> > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > ---
> >   drivers/hwmon/pmbus/Kconfig     |  8 ++++++++
> >   drivers/hwmon/pmbus/pli1209bc.c | 33
> > +++++++++++++++++++++++++++++++++
> >   2 files changed, 41 insertions(+)
> > 
> > diff --git a/drivers/hwmon/pmbus/Kconfig
> > b/drivers/hwmon/pmbus/Kconfig
> > index 831db423bea0..e64e0f2d93c9 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -319,6 +319,14 @@ config SENSORS_PLI1209BC
> >           This driver can also be built as a module. If so, the
> > module will
> >           be called pli1209bc.
> >   
> > +config SENSORS_PLI1209BC_REGULATOR
> > +       bool "Regulator support for PLI1209BC"
> > +       depends on SENSORS_PLI1209BC && REGULATOR
> > +       help
> > +         If you say yes here you get regulator support for Vicor
> > PLI1209BC
> > +         Digital Supervisor.
> > +
> > +
> 
> Single empty line please

ack.

> 
> >   config SENSORS_PM6764TR
> >         tristate "ST PM6764TR"
> >         help
> > diff --git a/drivers/hwmon/pmbus/pli1209bc.c
> > b/drivers/hwmon/pmbus/pli1209bc.c
> > index da345eb105fd..ec479b22aa10 100644
> > --- a/drivers/hwmon/pmbus/pli1209bc.c
> > +++ b/drivers/hwmon/pmbus/pli1209bc.c
> > @@ -8,6 +8,7 @@
> >   #include <linux/i2c.h>
> >   #include <linux/module.h>
> >   #include <linux/pmbus.h>
> > +#include <linux/regulator/driver.h>
> >   #include "pmbus.h"
> >   
> >   /*
> > @@ -32,11 +33,39 @@ static int pli1209bc_read_word_data(struct
> > i2c_client *client, int page,
> >                 if (data < 0)
> >                         return data;
> >                 return div_s64(data + 5LL, 10L);
> > +#if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
> 
> I don't think this needs to be conditional.

Sure, this would cause a redundant status check, if regulator support
is disabled. But that's not a big overhead I guess.

> 
> > +       /*
> > +        * PMBUS_READ_VOUT and PMBUS_READ_TEMPERATURE_1 returns
> > invalid data,
> 
> s/returns/return/ and no ','

ack.

Thanks,
Marcello

> 
> > +        * when the BCM is turned off. Since it is not possible to
> > return
> > +        * ENODATA error, return zero instead.
> > +        */
> > +       case PMBUS_READ_VOUT:
> > +       case PMBUS_READ_TEMPERATURE_1:
> > +               data = pmbus_read_word_data(client, page, phase,
> > +                                           PMBUS_STATUS_WORD);
> > +               if (data < 0)
> > +                       return data;
> > +               if (data & PB_STATUS_POWER_GOOD_N)
> > +                       return 0L;
> > +               return pmbus_read_word_data(client, page, phase,
> > reg);
> > +#endif
> >         default:
> >                 return -ENODATA;
> >         }
> >   }
> >   
> > +#if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
> > +static const struct regulator_desc pli1209bc_reg_desc = {
> > +       .name = "vout2",
> > +       .id = 1,
> > +       .of_match = of_match_ptr("vout2"),
> > +       .regulators_node = of_match_ptr("regulators"),
> > +       .ops = &pmbus_regulator_ops,
> > +       .type = REGULATOR_VOLTAGE,
> > +       .owner = THIS_MODULE,
> > +};
> > +#endif
> > +
> >   static struct pmbus_driver_info pli1209bc_info = {
> >         .pages = 2,
> >         .format[PSC_VOLTAGE_IN] = direct,
> > @@ -64,6 +93,10 @@ static struct pmbus_driver_info pli1209bc_info =
> > {
> >             | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> >             | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT,
> >         .read_word_data = pli1209bc_read_word_data,
> > +#if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
> > +       .num_regulators = 1,
> > +       .reg_desc = &pli1209bc_reg_desc,
> > +#endif
> >   };
> >   
> >   static int pli1209bc_probe(struct i2c_client *client)
> 

