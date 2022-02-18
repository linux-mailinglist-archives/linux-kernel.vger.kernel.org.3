Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CBB4BAD55
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiBQXrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:47:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBQXrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:47:31 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB0B378F5A;
        Thu, 17 Feb 2022 15:47:04 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id E7DFF135;
        Thu, 17 Feb 2022 15:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1645141061;
        bh=vR4wXeIsXpO2AhBfg332ghYS2clWTWkcLNBwoNM5S2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UwM3xDxYKJYkwEYh3RtBbQE2Eu79t1a2jQOUNlsVvXmE/G5vPk9pBGt9jFV51PG7R
         QrrgrFIzDLevsMP352cJ7xc1wGPWIpEX6CPwAEWN8jBUoMb/kymUkzqctzyiLhXoxG
         rrjAV1utG/aYOEThHP+APsipOU0RcHg+C9cIDQiY=
Date:   Thu, 17 Feb 2022 15:37:39 -0800
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/4] hwmon: (pmbus) Add get_error_flags support to
 regulator ops
Message-ID: <Yg7cQwA+i5oTYqHJ@hatter.bewilderbeest.net>
References: <20220217104444.7695-1-zev@bewilderbeest.net>
 <20220217104444.7695-2-zev@bewilderbeest.net>
 <b22ca322-c8f2-d17c-75ff-54ee26b0041b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b22ca322-c8f2-d17c-75ff-54ee26b0041b@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 10:11:32AM PST, Guenter Roeck wrote:
>On 2/17/22 02:44, Zev Weiss wrote:
>>The various PMBus status bits don't all map perfectly to the more
>>limited set of REGULATOR_ERROR_* flags, but there's a reasonable
>>number where they correspond well enough.
>>
>>Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>---
>>  drivers/hwmon/pmbus/pmbus_core.c | 97 ++++++++++++++++++++++++++++++++
>>  1 file changed, 97 insertions(+)
>>
>>diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>>index 776ee2237be2..a274e8e524a5 100644
>>--- a/drivers/hwmon/pmbus/pmbus_core.c
>>+++ b/drivers/hwmon/pmbus/pmbus_core.c
>>@@ -2417,10 +2417,107 @@ static int pmbus_regulator_disable(struct regulator_dev *rdev)
>>  	return _pmbus_regulator_on_off(rdev, 0);
>>  }
>>+/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
>>+struct pmbus_regulator_status_assoc {
>>+	int pflag, rflag;
>>+};
>>+
>>+/* PMBus->regulator bit mappings for a PMBus status register */
>>+struct pmbus_regulator_status_category {
>>+	int func;
>>+	int reg;
>>+	const struct pmbus_regulator_status_assoc *bits; /* zero-terminated */
>>+};
>>+
>>+static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
>>+	{
>>+		.func = PMBUS_HAVE_STATUS_VOUT,
>>+		.reg = PMBUS_STATUS_VOUT,
>>+		.bits = (const struct pmbus_regulator_status_assoc[]) {
>>+			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
>>+			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
>>+			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
>>+			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
>>+			{ },
>>+		},
>>+	}, {
>>+		.func = PMBUS_HAVE_STATUS_IOUT,
>>+		.reg = PMBUS_STATUS_IOUT,
>>+		.bits = (const struct pmbus_regulator_status_assoc[]) {
>>+			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
>>+			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
>>+			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
>>+			{ },
>>+		},
>>+	}, {
>>+		.func = PMBUS_HAVE_STATUS_TEMP,
>>+		.reg = PMBUS_STATUS_TEMPERATURE,
>>+		.bits = (const struct pmbus_regulator_status_assoc[]) {
>>+			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
>>+			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
>>+			{ },
>>+		},
>>+	},
>>+};
>>+
>>+static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
>>+{
>>+	int i, status, statusreg;
>>+	const struct pmbus_regulator_status_category *cat;
>>+	const struct pmbus_regulator_status_assoc *bit;
>>+	struct device *dev = rdev_get_dev(rdev);
>>+	struct i2c_client *client = to_i2c_client(dev->parent);
>>+	struct pmbus_data *data = i2c_get_clientdata(client);
>>+	u8 page = rdev_get_id(rdev);
>>+	int func = data->info->func[page];
>>+
>>+	*flags = 0;
>>+
>>+	for (i = 0; i < ARRAY_SIZE(pmbus_regulator_flag_map); i++) {
>>+		cat = &pmbus_regulator_flag_map[i];
>>+		if (!(func & cat->func))
>>+			continue;
>>+
>>+		status = pmbus_read_byte_data(client, page, cat->reg);
>>+		if (status < 0)
>>+			return status;
>>+
>>+		for (bit = cat->bits; bit->pflag; bit++) {
>>+			if (status & bit->pflag)
>>+				*flags |= bit->rflag;
>>+		}
>>+	}
>>+
>>+	/*
>>+	 * Map what bits of STATUS_{WORD,BYTE} we can to REGULATOR_ERROR_*
>>+	 * bits.  Some of the other bits are tempting (especially for cases
>>+	 * where we don't have the relevant PMBUS_HAVE_STATUS_*
>>+	 * functionality), but there's an unfortunate ambiguity in that
>>+	 * they're defined as indicating a fault *or* a warning, so we can't
>>+	 * easily determine whether to report REGULATOR_ERROR_<foo> or
>>+	 * REGULATOR_ERROR_<foo>_WARN.
>>+	 */
>>+	statusreg = data->has_status_word ? PMBUS_STATUS_WORD : PMBUS_STATUS_BYTE;
>>+	status = pmbus_get_status(client, page, statusreg);
>>+
>
>pmbus_get_status() calls data->read_status if PMBUS_STATUS_WORD is provided
>as parameter, and data->read_status is set to pmbus_read_status_byte()
>if reading the word status is not supported. Given that, why not just call
>pmbus_get_status(client, page, PMBUS_STATUS_WORD) ?

Good point, I'll change it to do that instead.  (And send v2 separately 
from the power-efuse driver patches.)

>
>>+	if (status < 0)
>>+		return status;
>>+
>>+	if (pmbus_regulator_is_enabled(rdev) && (status & PB_STATUS_OFF))
>>+		*flags |= REGULATOR_ERROR_FAIL;
>>+	if (status & PB_STATUS_IOUT_OC)
>>+		*flags |= REGULATOR_ERROR_OVER_CURRENT;
>
>If the current status register is supported, this effectively means that
>an overcurrent warning is always reported as both REGULATOR_ERROR_OVER_CURRENT
>and REGULATOR_ERROR_OVER_CURRENT_WARN. Is that intentional ?
>

No, but I don't think (by my reading of the spec) that's what would 
happen?

I'm looking at table 16 ("STATUS_WORD Message Contents") in section 17.2 
("STATUS_WORD") of Part II of revision 1.3.1 of the PMBus spec, which 
says that bit 4 of the low byte (PB_STATUS_IOUT_OC) indicates an output 
overcurrent fault, not a warning (in contrast to most of the other bits, 
which may indicate either).

>
>>+	if (status & PB_STATUS_VOUT_OV)
>>+		*flags |= REGULATOR_ERROR_REGULATION_OUT;
>
>Same for voltage.

Likewise, PB_STATUS_VOUT_OV is specified as indicating a fault, not a 
warning.

>On the other side, temperature limit violations are not
>reported at all unless the temperature status register exists.
>That seems to be a bit inconsistent to me.
>

Right -- that's because PB_STATUS_TEMPERATURE is one of the "fault or 
warning" bits (unlike VOUT_OV and IOUT_OC), and hence it's an ambiguous 
case as described in the comment before the pmbus_get_status() call.

It's certainly not ideal, but it seemed like the best approach I could 
see given the semantics of the available flags -- I'm open to other 
possibilities though if there's something else that would work better.

Thanks for the review,
Zev

