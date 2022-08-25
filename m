Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10E05A0EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241470AbiHYLWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiHYLWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:22:48 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020CFAEDB0;
        Thu, 25 Aug 2022 04:22:47 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-334dc616f86so532032677b3.8;
        Thu, 25 Aug 2022 04:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GRYO7G3mRjzW1fw3dAdOY31yO6ERGY2FYryEhajulBc=;
        b=mS7tm2Rpqeui2+0n3Gz+dL+1z+AmeSnXczHefanziYona46q0IVYA/G+cwtVDrR3JS
         53UnYtQlvRTKV95nP/S80TH+1qLBEsQOi+7EHAkeyj+I0+8bX/yzbHnvFK1xtSUrASE+
         7alHaaebWF/35TG6n+d0v59ohlx5Bl0hgEtYhTTpKYt7bAA0fvY/NnR5mgZLnhne65GT
         zFhlpXbwUSaEj1CaYU396c3Qsqr6oNm6kVGADkhluP9UnimSDvMFxAEjan3mVz1KOJhE
         YFInXzaausEozggllP6Q2rP6HS7Dv+HnsX3WuF963/IBtL/cFFwKAIo4nA8aLNHPSVpU
         Qf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GRYO7G3mRjzW1fw3dAdOY31yO6ERGY2FYryEhajulBc=;
        b=3YAlkDrw57sl2FGuwkBXTXXX0tqpNfA6WM718Y5BAQ/0tRh//XoaiUQ3cr5ZWMW+m/
         1MmfbcXYAzNaADTJRWSsHjeWqFNBtyi61Oq26ESpw4GQ4Hz2R9dF7NOJzQvfrdVMLb9+
         60HmEKKDuOB2W7tmMQ40o9gAApZIuLFCkxq7Ban7oPUMDnk46Ws/BzO7rWFjcM61RS33
         rEJ1qHBMSGjZkdUQrPBDz9wijTBQwWnazu35x3deGfJicebhgzabjc+d5crFstsksNLj
         RbthZobi5DTgaFb6GYzq8e2E6+184dF8Lo/zv39Ttq2iBvexvb8Zlfjo0KkVz/IKxO3W
         I7lg==
X-Gm-Message-State: ACgBeo3/86vHPMfBgU2AMqkNMQ7BULKpvvTj/zdaY9/5W2XN6IZQ7a0S
        Owsg7juNTe8+OtifM9Pd3HJUP7J6fY2Ra0VLRj3YTj5mKilsdw==
X-Google-Smtp-Source: AA6agR4KxqKgfCWUZmHktmdpShpDtZweo4sTRhWjVNawu7ya9FNgOB05EydNM906dGurapfSAGgJvwmwj1Fq5zAmM2k=
X-Received: by 2002:a81:1dd0:0:b0:33d:6c3e:ebc9 with SMTP id
 d199-20020a811dd0000000b0033d6c3eebc9mr3293008ywd.491.1661426566162; Thu, 25
 Aug 2022 04:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <1660878283-9512-1-git-send-email-Duke.Du@quantatw.com>
 <20220819133458.GC3108215@roeck-us.net> <CAJqQiD39b=n-Lsza_YUPQR2jm49a3ZLxT-x7eYUv=yhD4fiDJQ@mail.gmail.com>
 <20220824105027.GA13261@roeck-us.net>
In-Reply-To: <20220824105027.GA13261@roeck-us.net>
From:   Duke Du <dukedu83@gmail.com>
Date:   Thu, 25 Aug 2022 19:22:34 +0800
Message-ID: <CAJqQiD2+6jo3h5Ymd2e7Th634gBZgijBxp5xRHB=h7-__8N0uQ@mail.gmail.com>
Subject: Re: [PATCH v3] hwmon: Add driver for the TEXAS TPS546D24 Buck Converter.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        fran.hsu@quantatw.com, charles.hsu@quantatw.com,
        george.hung@quantatw.com, duke.du@quantatw.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 6:50 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Aug 24, 2022 at 01:58:33PM +0800, Duke Du wrote:
> > Hi Guenter,
> > Thanks for your reply !
> > But I have some confusion as following, please help to give me some feedback.
> > Thanks a lot !
> >
> > On Fri, Aug 19, 2022 at 9:35 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Fri, Aug 19, 2022 at 11:04:43AM +0800, Duke Du wrote:
> > > > Add the pmbus driver for TEXAS tps546d24 Buck Converter. The
> > > > tps546d24 PMBUS_VOUT_MODE is 0x97 (i.e. the bit 5~7 are 100)
> > > > which could not meet the standard pmbus spec, the standard mode
> > > > of PMBUS_VOUT_MODE must be 000 (linear foramt) or 001 (vid format).
> > > > Make the tps546d24 PMBUS_VOUT_MODE return value 0x17 (i.e. the
> > > > bit5~7 are 000), VOUT returned value is linear11.
> > > >
> > >
> > > First of all, the above should be documented as comment in the
> > > implementation.
> > >
> > > Second, this is actually problematic. In PMBus version 1.3.1, bit
> > > 7 of PMBUS_VOUT_MODE no longer describes the mode (linear, vid, direct,
> > > IEEE) but Absolute vs/ Relative VOUT voltages. This affects vout fault
> > > and warning limits. If the relative mode bit is set, those limits
> > > are supposed to reflect percentages, not absolute voltages.
> > >
> > > This means that the driver interprets vout voltage limits wrongly,
> > > at least if the chip works as described in the datasheet. Changing
> > > the reported value of PMBUS_VOUT_MODE is actually counter-productive.
> > >
> > > This means we'll need a number of changes. At the very least, the
> > > PMBus core needs to be be modified to only use bit 5 and 6 to determine
> > > the mode. On top of that, the driver probe function should update
> > > VOUT_MODE and clear bit 7. It might also make sense to warn in the
> > > PMBus core if mode bit 7 is set.
> > >
> >
> > When the vout mode bit 7 is set, we update vout mode and clear bit 7
> > in the driver probe function, this operation is the same as changing
> > the reported value of PMBUS_VOUT_MODE ?
>
> Absolutely not. When changing the bit in the register, the chip operation
> mode changes, and the associated values (VOUT*) change from relative
> to absolute mode. When changing the value reported by the chip, nothing
> changes from the chip side, it still operates in relative mode, and all
> VOUT* registers are set to relative mode.
>
> Guenter
>
Got it, thanks for your reply !!

Another question, If we don't need to change the mode from relative to absolute
mode, could we just change the PMBus core to determine vout mode with only
bit 5 and 6 ?
And clearing the bit 7 in the driver (tps546d24.c) probe function
would not be needed, right ?

Thanks
Duke

> > Maybe I misunderstood, could you please help to explain clearly about this ?
> > Thanks again for your help :)
> >
> > Thanks,
> > Duke
> >
> > > An alternative to the second change would be to implement relative
> > > vout support in the PMBus core, but that would be much more complex.
> > > We could also clear the relative bit in the PMBus core, but that might
> > > lead to unexpected side effects (we don't know how various chips
> > > respond to that) and thus probably not be a good idea.
> > >
> > > > Signed-off-by: Duke Du <Duke.Du@quantatw.com>
> > >
> > > This e-mail address does not match the e-mail address used to send
> > > the patch, resulting in a checkpatch warning. Please fix.
> > >
> > > More comments inline.
> > >
> > > Thanks,
> > > Guenter
> > >
> > > > ---
> > > > Change in v1:
> > > >     Initial patchset.
> > > > Change in v2:
> > > >     Correct the tps546d24.rst format.
> > > > Change in v3:
> > > >     1. Modify the patch description.
> > > >     2. Put the change log between the dashes and diffstat.
> > > > ---
> > > > ---
> > > >  Documentation/hwmon/index.rst     |  1 +
> > > >  Documentation/hwmon/tps546d24.rst | 35 +++++++++++++++++++
> > > >  MAINTAINERS                       |  7 ++++
> > > >  drivers/hwmon/pmbus/Kconfig       |  9 +++++
> > > >  drivers/hwmon/pmbus/Makefile      |  1 +
> > > >  drivers/hwmon/pmbus/tps546d24.c   | 73 +++++++++++++++++++++++++++++++++++++++
> > > >  6 files changed, 126 insertions(+)
> > > >  create mode 100644 Documentation/hwmon/tps546d24.rst
> > > >  create mode 100644 drivers/hwmon/pmbus/tps546d24.c
> > > >
> > > > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > > > index f7113b0..d3eede4 100644
> > > > --- a/Documentation/hwmon/index.rst
> > > > +++ b/Documentation/hwmon/index.rst
> > > > @@ -205,6 +205,7 @@ Hardware Monitoring Kernel Drivers
> > > >     tps23861
> > > >     tps40422
> > > >     tps53679
> > > > +   tps546d24
> > > >     twl4030-madc-hwmon
> > > >     ucd9000
> > > >     ucd9200
> > > > diff --git a/Documentation/hwmon/tps546d24.rst b/Documentation/hwmon/tps546d24.rst
> > > > new file mode 100644
> > > > index 0000000..3061fd8
> > > > --- /dev/null
> > > > +++ b/Documentation/hwmon/tps546d24.rst
> > > > @@ -0,0 +1,35 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +Kernel driver tps546d24
> > > > +======================
> > > > +
> > > > +Supported chips:
> > > > +
> > > > +  * TI TPS546D24
> > > > +
> > > > +    Prefix: 'tps546d24'
> > > > +
> > > > +    Addresses scanned: -
> > > > +
> > > > +    Datasheet: https://www.ti.com/lit/gpn/tps546d24
> > > > +
> > > > +Author: Duke Du <dukedu83@gmail.com>
> > >
> > > This needs to match Author and Signed-off-by:. This applies to all
> > > e-mail addresses.
> > >
> > > > +
> > > > +
> > > > +Description
> > > > +-----------
> > > > +
> > > > +The TPS546D24A is a highly integrated, non-isolated DC/DC converter capable
> > > > +of high frequency operation and 40-A current output from a 7-mm x 5-mm
> > > > +package.
> > > > +
> > > > +Two, three, and four TPS546D24A devices can be interconnected
> > > > +to provide up to 160 A on a single output. The device has an option to
> > > > +overdrive the internal 5-V LDO with an external 5-V supply via the VDD5
> > > > +pin to improve efficiency and reduce power dissipation of the converter.
> > > > +
> > > > +
> > > > +Platform data support
> > > > +---------------------
> > > > +
> > > > +The driver supports standard PMBus driver platform data.
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 8a5012b..fa2d4fb 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -20583,6 +20583,13 @@ Q:   https://patchwork.kernel.org/project/linux-integrity/list/
> > > >  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> > > >  F:   drivers/char/tpm/
> > > >
> > > > +TPS546D24 DRIVER
> > > > +M:   Duke Du <dukedu83@gmail.com>
> > > > +L:   linux-hwmon@vger.kernel.org
> > > > +S:   Maintained
> > > > +F:   Documentation/hwmon/tps546d24.rst
> > > > +F:   drivers/hwmon/pmbus/tps546d24.c
> > > > +
> > > >  TRACING
> > > >  M:   Steven Rostedt <rostedt@goodmis.org>
> > > >  M:   Ingo Molnar <mingo@redhat.com>
> > > > diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> > > > index 951e4a9..89668af 100644
> > > > --- a/drivers/hwmon/pmbus/Kconfig
> > > > +++ b/drivers/hwmon/pmbus/Kconfig
> > > > @@ -397,6 +397,15 @@ config SENSORS_TPS53679
> > > >         This driver can also be built as a module. If so, the module will
> > > >         be called tps53679.
> > > >
> > > > +config SENSORS_TPS546D24
> > > > +     tristate "TPS546D24"
> > > > +     help
> > > > +       If you say yes here you get hardware monitoring support for TEXAS
> > > > +       TPS546D24.
> > > > +
> > > > +       This driver can also be built as a module. If so, the module will
> > > > +       be called tps546d24
> > > > +
> > > >  config SENSORS_UCD9000
> > > >       tristate "TI UCD90120, UCD90124, UCD90160, UCD90320, UCD9090, UCD90910"
> > > >       help
> > > > diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> > > > index e2fe86f..0002dbe 100644
> > > > --- a/drivers/hwmon/pmbus/Makefile
> > > > +++ b/drivers/hwmon/pmbus/Makefile
> > > > @@ -41,6 +41,7 @@ obj-$(CONFIG_SENSORS_Q54SJ108A2)    += q54sj108a2.o
> > > >  obj-$(CONFIG_SENSORS_STPDDC60)       += stpddc60.o
> > > >  obj-$(CONFIG_SENSORS_TPS40422)       += tps40422.o
> > > >  obj-$(CONFIG_SENSORS_TPS53679)       += tps53679.o
> > > > +obj-$(CONFIG_SENSORS_TPS546D24)      += tps546d24.o
> > > >  obj-$(CONFIG_SENSORS_UCD9000)        += ucd9000.o
> > > >  obj-$(CONFIG_SENSORS_UCD9200)        += ucd9200.o
> > > >  obj-$(CONFIG_SENSORS_XDPE122)        += xdpe12284.o
> > > > diff --git a/drivers/hwmon/pmbus/tps546d24.c b/drivers/hwmon/pmbus/tps546d24.c
> > > > new file mode 100644
> > > > index 0000000..f6f79d3
> > > > --- /dev/null
> > > > +++ b/drivers/hwmon/pmbus/tps546d24.c
> > > > @@ -0,0 +1,73 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +/*
> > > > + * Hardware monitoring driver for TEXAS TPS546D24 buck converter
> > > > + */
> > > > +
> > > > +#include <linux/err.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/pmbus.h>
> > > > +#include "pmbus.h"
> > > > +
> > > > +static int tps546d24_read_byte_data(struct i2c_client *client, int page, int reg)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     switch (reg) {
> > > > +     case PMBUS_VOUT_MODE:
> > > > +             ret = 0x17;
> > > > +             break;
> > > > +     default:
> > > > +             ret = -ENODATA;
> > > > +             break;
> > > > +     }
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static struct pmbus_driver_info tps546d24_info = {
> > > > +     .pages = 1,
> > > > +     .format[PSC_VOLTAGE_IN] = linear,
> > > > +     .format[PSC_VOLTAGE_OUT] = linear,
> > > > +     .format[PSC_TEMPERATURE] = linear,
> > > > +     .format[PSC_CURRENT_OUT] = linear,
> > > > +     .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN |
> > > > +         PMBUS_HAVE_IOUT | PMBUS_HAVE_VOUT |
> > > > +             PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_VOUT |
> > > > +             PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
> > > > +     .read_byte_data = tps546d24_read_byte_data,
> > >
> > > The chip supports multiple phases, and per-phase telemetry.
> > > Have you considered supporting it ?
> > >
> > > > +};
> > > > +
> > > > +static int tps546d24_probe(struct i2c_client *client)
> > > > +{
> > > > +     return pmbus_do_probe(client, &tps546d24_info);
> > > > +}
> > > > +
> > > > +static const struct i2c_device_id tps546d24_id[] = {
> > > > +     {"tps546d24", 0},
> > > > +     {}
> > > > +};
> > > > +MODULE_DEVICE_TABLE(i2c, tps546d24_id);
> > > > +
> > > > +static const struct of_device_id __maybe_unused tps546d24_of_match[] = {
> > > > +     {.compatible = "tps546d24"},
> > >
> > > This needs a vendor prefix.
> > >
> > > > +     {}
> > > > +};
> > > > +
> > > > +/* This is the driver that will be inserted */
> > > > +static struct i2c_driver tps546d24_driver = {
> > > > +     .driver = {
> > > > +                .name = "tps546d24",
> > > > +                .of_match_table = of_match_ptr(tps546d24_of_match),
> > > > +        },
> > > > +     .probe_new = tps546d24_probe,
> > > > +     .id_table = tps546d24_id,
> > > > +};
> > > > +
> > > > +module_i2c_driver(tps546d24_driver);
> > > > +
> > > > +MODULE_AUTHOR("Duke Du <dukedu83@gmail.com>");
> > > > +MODULE_DESCRIPTION("PMBus driver for TI tps546d24");
> > > > +MODULE_LICENSE("GPL");
> > > > +MODULE_IMPORT_NS(PMBUS);
> > > > --
> > > > 2.7.4
> > > >
