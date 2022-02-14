Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F814B59C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357397AbiBNSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:19:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiBNSTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:19:23 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E826580D8;
        Mon, 14 Feb 2022 10:19:14 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4JyCCz6Ld1z9sSM;
        Mon, 14 Feb 2022 19:19:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644862749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fSNa1XXhMflYfEl9flLMmS6tKFpzfbgDV0wJBFFW1JA=;
        b=tezwYnUQqH7RQDjLAvGA87PdwlPMoGt+e/NrKEmKHUMw6xuIaBVjSbmjPx5zydbahRvhHr
        Cx+WIAdJQxRwrebFbm4LRBQBzYCgFMeM4BC/iucG4s5GcobCsLg57qa1ZQEmztSgRskvUr
        YbbZu1gO9enrKvi+9lT49tepoCoZPAoWYNFCuPXoFZJxjHLGjzU5zTpRZ8pbEQB798swR8
        dCaMs1h8NxZEWjd/zed7jLBz6LJhpcM19G+wv2UnkCxiLXP4868n1AVLBDV1jpkQEme9rj
        IMVoS4zzUZ6hqSE/FddURCsOZiS+6hr0ZKhDNCNySfHNAFkQRW/6c1ROJ2VG7w==
Message-ID: <2cdb16a3d94506f453a5722c860d2f17b5dd5b1d.camel@sylv.io>
Subject: Re: [PATCH v2 4/4] pmbus (pli1209bc): Add regulator support
From:   sylv <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Date:   Mon, 14 Feb 2022 19:19:05 +0100
In-Reply-To: <62de6f93-12eb-838f-884d-f1ef96ab6e22@roeck-us.net>
References: <cover.1644834803.git.sylv@sylv.io>
         <fc5b0ba1f7d41e88ef066c3ff23aaf882c19c543.1644834803.git.sylv@sylv.io>
         <62de6f93-12eb-838f-884d-f1ef96ab6e22@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-14 at 09:40 -0800, Guenter Roeck wrote:
> On 2/14/22 04:40, Marcello Sylvester Bauer wrote:
> > Add regulator support for PLI1209BC Digital Supervisor.
> > 
> > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > ---
> >   drivers/hwmon/pmbus/Kconfig     |  7 +++++++
> >   drivers/hwmon/pmbus/pli1209bc.c | 31
> > +++++++++++++++++++++++++++++++
> >   2 files changed, 38 insertions(+)
> > 
> > diff --git a/drivers/hwmon/pmbus/Kconfig
> > b/drivers/hwmon/pmbus/Kconfig
> > index 831db423bea0..8b8f0d8733b2 100644
> > --- a/drivers/hwmon/pmbus/Kconfig
> > +++ b/drivers/hwmon/pmbus/Kconfig
> > @@ -319,6 +319,13 @@ config SENSORS_PLI1209BC
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
> >   config SENSORS_PM6764TR
> >         tristate "ST PM6764TR"
> >         help
> > diff --git a/drivers/hwmon/pmbus/pli1209bc.c
> > b/drivers/hwmon/pmbus/pli1209bc.c
> > index 8a9af2ccc46f..7212d73f6e04 100644
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
> > @@ -32,11 +33,37 @@ static int pli1209bc_read_word_data(struct
> > i2c_client *client, int page,
> >                 if (data < 0)
> >                         return data;
> >                 return data * 10;
> > +       /*
> > +        * PMBUS_READ_VOUT and PMBUS_READ_TEMPERATURE_1 return
> > invalid data
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
> 
> Why 0L ? The return value of pli1209bc_read_word_data() is int.

ack. 0L makes no sense here.

> 
> > +               return pmbus_read_word_data(client, page, phase,
> > reg);
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
> > @@ -74,6 +101,10 @@ static struct pmbus_driver_info pli1209bc_info
> > = {
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

