Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D01D46C6FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237691AbhLGV5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:57:17 -0500
Received: from thorn.bewilderbeest.net ([71.19.156.171]:41567 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbhLGV5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:57:16 -0500
Received: from hatter.bewilderbeest.net (174-21-184-96.tukw.qwest.net [174.21.184.96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id BAF23613;
        Tue,  7 Dec 2021 13:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1638914024;
        bh=CvghTx/r5viUdpFKeoGF2p6OU37g5jR62YEdfJZenXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MSXUDWGuNoELTfnshEDiwshsJmG0uYjejLuhbWu1DKgJZ6tI5TEyIYf9JZ9+WpEvN
         nuUV4c47zRor+SzgRWrGKx6s/X7Vn7FXTD9k4YDY1jFBix6zJNaA92rhsy5JD2uGm9
         9q2jZKp7TIbbp+zDme3eNUYEgAPb+9OH8u+L0dBU=
Date:   Tue, 7 Dec 2021 13:53:39 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] hwmon: (pmbus) Add Delta AHE-50DC fan control
 module driver
Message-ID: <Ya/X46owU78iVbSO@hatter.bewilderbeest.net>
References: <20211207071521.543-1-zev@bewilderbeest.net>
 <20211207071521.543-2-zev@bewilderbeest.net>
 <20211207175015.GA772416@roeck-us.net>
 <Ya+0YDWIRBQFnEDb@hatter.bewilderbeest.net>
 <f30241ad-f3c4-ee78-22f3-405401615b61@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f30241ad-f3c4-ee78-22f3-405401615b61@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:44:01AM PST, Guenter Roeck wrote:
>On 12/7/21 11:22 AM, Zev Weiss wrote:
>>On Tue, Dec 07, 2021 at 09:50:15AM PST, Guenter Roeck wrote:
>>>On Mon, Dec 06, 2021 at 11:15:20PM -0800, Zev Weiss wrote:
>>>>This device is an integrated module of the Delta AHE-50DC Open19 power
>>>>shelf.� For lack of proper documentation, this driver has been developed
>>>>referencing an existing (GPL) driver that was included in a code release
>>>>from LinkedIn [1].� It provides four fan speeds, four temperatures, and
>>>>one voltage reading, as well as a handful of warning and fault
>>>>indicators.
>>>>
>>>>[1] https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-kernel/fancontrol-mod/files/fancontrol.c
>>>>
>>>
>>>Hmm, that reference isn't really accurate anymore. I think it would be
>>>better to just say that the device was found to be PMBus compliant.
>>
>>Sure, will do.
>>
>
> Makes me wonder: How do you know that the referenced driver is for 
> Delta AHE-50DC ?

We'd been waiting for the source code for the software it ships with for 
a while, and were finally provided with that repo; everything I've 
observed from the factory software is consistent with the code in that 
driver.  A sampling:

     # no modinfo command available, but...
     root@bmc-oob:~# strings -n8 /lib/modules/4.1.51-deltapower/extra/fancontrol.ko | head
     fancontrol
     license=GPL
     description=FANCTRL Driver
     author=Ping Mao <pmao@linkedin.com>
     alias=i2c:fancontrol
     depends=i2c_dev_sysfs
     vermagic=4.1.51-deltapower mod_unload ARMv5 p2v8
     fancontrol
     status_word
     bit 2:  Temparature Warning
     root@bmc-oob:~# cd /sys/bus/i2c/drivers/fancontrol/8-0030
     root@bmc-oob:/sys/bus/i2c/drivers/fancontrol/8-0030# grep . fan* temp* vin
     fan1_2_status:0
     fan1_speed:7860
     fan2_speed:7860
     fan3_4_status:0
     fan3_speed:7680
     fan4_speed:7560
     temperature1:292
     temperature2:278
     temperature3:286
     temperature4:302
     vin:12251


>>>
>>>>Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>>>---
>>>>�MAINTAINERS���������������������������� |� 6 ++
>>>>�drivers/hwmon/pmbus/Kconfig������������ | 12 ++++
>>>>�drivers/hwmon/pmbus/Makefile����������� |� 1 +
>>>>�drivers/hwmon/pmbus/delta-ahe50dc-fan.c | 84 +++++++++++++++++++++++++
>>>>�4 files changed, 103 insertions(+)
>>>>�create mode 100644 drivers/hwmon/pmbus/delta-ahe50dc-fan.c
>>>>
>>>>diff --git a/MAINTAINERS b/MAINTAINERS
>>>>index 0ac052200ecb..8bb7ba52d2f5 100644
>>>>--- a/MAINTAINERS
>>>>+++ b/MAINTAINERS
>>>>@@ -5425,6 +5425,12 @@ W:��� https://linuxtv.org
>>>>�T:��� git git://linuxtv.org/media_tree.git
>>>>�F:��� drivers/media/platform/sti/delta
>>>>
>>>>+DELTA AHE-50DC FAN CONTROL MODULE DRIVER
>>>>+M:��� Zev Weiss <zev@bewilderbeest.net>
>>>>+L:��� linux-hwmon@vger.kernel.org
>>>>+S:��� Maintained
>>>>+F:��� drivers/hwmon/pmbus/delta-ahe50dc-fan.c
>>>>+
>>>>�DELTA DPS920AB PSU DRIVER
>>>>�M:��� Robert Marko <robert.marko@sartura.hr>
>>>>�L:��� linux-hwmon@vger.kernel.org
>>>>diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>>>>index ffb609cee3a4..937e1c2c11e7 100644
>>>>--- a/drivers/hwmon/pmbus/Kconfig
>>>>+++ b/drivers/hwmon/pmbus/Kconfig
>>>>@@ -66,6 +66,18 @@ config SENSORS_BPA_RS600
>>>>������ This driver can also be built as a module. If so, the module will
>>>>������ be called bpa-rs600.
>>>>
>>>>+config SENSORS_DELTA_AHE50DC_FAN
>>>>+��� tristate "Delta AHE-50DC fan control module"
>>>>+��� depends on I2C
>>>>+��� select REGMAP_I2C
>>
>>And I realize I neglected to drop the depends & select lines here when moving this bit into the pmbus directory...
>>
>>>>+��� help
>>>>+����� If you say yes here you get hardware monitoring support for
>>>>+����� the integrated fan control module of the Delta AHE-50DC
>>>>+����� Open19 power shelf.
>>>>+
>>>>+����� This driver can also be built as a module. If so, the module
>>>>+����� will be called delta-ahe50dc-fan.
>>>>+
>>>>�config SENSORS_FSP_3Y
>>>>���� tristate "FSP/3Y-Power power supplies"
>>>>���� help
>>>>diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>>>>index 0ed4d596a948..a56b2897288d 100644
>>>>--- a/drivers/hwmon/pmbus/Makefile
>>>>+++ b/drivers/hwmon/pmbus/Makefile
>>>>@@ -9,6 +9,7 @@ obj-$(CONFIG_SENSORS_ADM1266)��� += adm1266.o
>>>>�obj-$(CONFIG_SENSORS_ADM1275)��� += adm1275.o
>>>>�obj-$(CONFIG_SENSORS_BEL_PFE)��� += bel-pfe.o
>>>>�obj-$(CONFIG_SENSORS_BPA_RS600)��� += bpa-rs600.o
>>>>+obj-$(CONFIG_SENSORS_DELTA_AHE50DC_FAN) += delta-ahe50dc-fan.o
>>>>�obj-$(CONFIG_SENSORS_FSP_3Y)��� += fsp-3y.o
>>>>�obj-$(CONFIG_SENSORS_IBM_CFFPS)��� += ibm-cffps.o
>>>>�obj-$(CONFIG_SENSORS_DPS920AB)��� += dps920ab.o
>>>>diff --git a/drivers/hwmon/pmbus/delta-ahe50dc-fan.c b/drivers/hwmon/pmbus/delta-ahe50dc-fan.c
>>>>new file mode 100644
>>>>index 000000000000..07b1e7c5f5f5
>>>>--- /dev/null
>>>>+++ b/drivers/hwmon/pmbus/delta-ahe50dc-fan.c
>>>>@@ -0,0 +1,84 @@
>>>>+// SPDX-License-Identifier: GPL-2.0
>>>>+/*
>>>>+ * Delta AHE-50DC power shelf fan control module driver
>>>>+ *
>>>>+ * Copyright 2021 Zev Weiss <zev@bewilderbeest.net>
>>>>+ */
>>>>+
>>>>+#include <linux/kernel.h>
>>>>+#include <linux/module.h>
>>>>+#include <linux/i2c.h>
>>>>+#include <linux/pmbus.h>
>>>
>>>Alphabetic include file order please.
>>
>>Ack, will fix.
>>
>>>
>>>>+
>>>>+#include "pmbus.h"
>>>>+
>>>>+#define AHE50DC_PMBUS_READ_TEMP4 0xd0
>>>>+
>>>>+static int ahe50dc_fan_read_word_data(struct i2c_client *client, int page, int phase, int reg)
>>>>+{
>>>>+��� /* temp1 in (virtual) page 1 is remapped to mfr-specific temp4 */
>>>>+��� if (page == 1) {
>>>>+������� if (reg == PMBUS_READ_TEMPERATURE_1)
>>>>+����������� return i2c_smbus_read_word_data(client, AHE50DC_PMBUS_READ_TEMP4);
>>>>+������� return -EOPNOTSUPP;
>>>>+��� }
>>>>+��� return -ENODATA;
>>>>+}
>>>>+
>>>>+static struct pmbus_driver_info ahe50dc_fan_info = {
>>>>+��� .pages = 2,
>>>>+��� .format[PSC_FAN] = direct,
>>>>+��� .format[PSC_TEMPERATURE] = direct,
>>>>+��� .format[PSC_VOLTAGE_IN] = direct,
>>>>+��� .m[PSC_FAN] = 1,
>>>>+��� .b[PSC_FAN] = 0,
>>>>+��� .R[PSC_FAN] = 0,
>>>>+��� .m[PSC_TEMPERATURE] = 1,
>>>>+��� .b[PSC_TEMPERATURE] = 0,
>>>>+��� .R[PSC_TEMPERATURE] = 1,
>>>>+��� .m[PSC_VOLTAGE_IN] = 1,
>>>>+��� .b[PSC_VOLTAGE_IN] = 0,
>>>>+��� .R[PSC_VOLTAGE_IN] = 3,
>>>
>>>How did you determine the exponents ? The referenced driver
>>>doesn't seem to make a difference between voltage and temperature
>>>exponents (nor fan speed, which is a bit odd).
>>
>>Lacking documentation, the honest answer here is that I just sort of eyeballed it.� However, after doing so, I dug through the code dump a bit more and found some userspace unit-conversion bits that appear to confirm what I arrived at:
>>
>>https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-deltapower/platform-lib/files/powershelf/powershelf_fan.c
>>
>>(Lines 107, and 153/161/169/177.)
>>
>
>Brr. Well, why use a standard API/ABI if one can invent a non-standard one.
>

It's...not the only bit of gratuitous wheel-reinvention we've come
across in this particular system.

>Can you check this with real hardware, by any chance ?
>

If you mean running that code on it, yes -- here's the userspace utility 
that invokes that library routine:

     root@bmc-oob:~# fan-util.sh
     fan1 speed: 7860 RPM
     fan2 speed: 7860 RPM
     fan3 speed: 7620 RPM
     fan4 speed: 7560 RPM
     temperature1: 29.20 C
     temperature2: 27.80 C
     temperature3: 28.50 C
     temperature4: 30.20 C
     vin_undervolt_fault: no
     overtemperature_warning: no
     fan_fault: no
     fan_warning: no
     fan_status: ok

That fan-util.sh script being this:

https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-deltapower/liutils/files/fan-util.sh

which invokes this:

https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-deltapower/liutils/files/fan-ctrl/fan-util.c

(which calls into the routine in powershelf_fan.c linked above).


Zev

