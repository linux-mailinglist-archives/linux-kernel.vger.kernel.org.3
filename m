Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606F8539AC8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 03:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349000AbiFABeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 21:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244972AbiFABeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 21:34:07 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8789A5B3F9;
        Tue, 31 May 2022 18:34:06 -0700 (PDT)
Date:   Wed, 01 Jun 2022 01:34:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1654047244; x=1654306444;
        bh=HNyDEZPUiD5WQaSU7ZB0ohB0dUGEd+n30NevK73Q/eI=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=umXE7fDg9UuUBFZhWph6ZfofMERBm05Gjwtrwv8u/71VhAYOt5IP6X+Ak3y69SKpC
         Cqy+GMIiGV00jDMMsXQ96f/nev0j6CJC0y5uX6yCEIsYGYfykGmZsYsoi21Rsb+XMQ
         CZ/O/8FXfaldufSLQL2Q+aIoTo3QZbRX3GqenNFmPRcHxVRD6sxwAwY8XvGqFlbRXP
         bx2KEyJoHfmRFmTGt+Rxf4hf89XmTZHgjXSkKV/umnXuYYaIIlhWQ07PPPq510AJoN
         IfRF/mnTPagHtAobrvM1DuFOxYnsJ5ZV/nsDEklwcGdAILWSpBUoTC/gHCOhxEirGu
         4MmxbHDxmE7bQ==
To:     Guenter Roeck <linux@roeck-us.net>
From:   wujek dev <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: wujek dev <dev_public@wujek.eu>
Subject: Re: [PATCH v2 1/2] hwmon: (pmbus) add a function to check the presence of a block register
Message-ID: <WVehAlzjh6tqHumVgSPQaBJ2HyS2440oKiqR96qmMbXIv1Z0h_HQuGZf-6xh1KgeCXIGFmTg1Vym3ekryjnKUB8pEN3Hdm-PJBVakHg1FDo=@wujek.eu>
In-Reply-To: <e0bfc3c0-d15f-f19e-5355-03a76ffa71ee@roeck-us.net>
References: <20220524104307.272806-1-dev_public@wujek.eu> <e0bfc3c0-d15f-f19e-5355-03a76ffa71ee@roeck-us.net>
Feedback-ID: 23425257:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday, May 24th, 2022 at 15:32, Guenter Roeck <linux@roeck-us.net> wro=
te:


>
>
> On 5/24/22 03:43, Adam Wujek wrote:
>
> > Other functions (like pmbus_check_byte_register) cannot be used to chec=
k
> > the presence of a block register, because it will generate error when P=
EC
> > is used.
> >
> > Signed-off-by: Adam Wujek dev_public@wujek.eu
> > ---
> > Notes:
> > Changes in v2:
> > - Use Phase 0xff when setting the page
> >
> > drivers/hwmon/pmbus/pmbus_core.c | 26 ++++++++++++++++++++++++++
> > 1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmb=
us_core.c
> > index acf78d0829d9..2ff66f133d95 100644
> > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > @@ -421,6 +421,18 @@ static int _pmbus_read_byte_data(struct i2c_client=
 *client, int page, int reg)
> > return pmbus_read_byte_data(client, page, reg);
> > }
> >
> > +static int pmbus_read_block_data(struct i2c_client *client, int page, =
u8 reg,
> > + char *data_buf)
> > +{
> > + int rv;
> > +
> > + rv =3D pmbus_set_page(client, page, 0xff);
> > + if (rv < 0)
> > + return rv;
> > +
> > + return i2c_smbus_read_block_data(client, reg, data_buf);
> > +}
> > +
> > static struct pmbus_sensor *pmbus_find_sensor(struct pmbus_data *data, =
int page,
> > int reg)
> > {
> > @@ -558,6 +570,20 @@ bool pmbus_check_word_register(struct i2c_client *=
client, int page, int reg)
> > }
> > EXPORT_SYMBOL_NS_GPL(pmbus_check_word_register, PMBUS);
> >
> > +static bool pmbus_check_block_register(struct i2c_client *client, int =
page,
> > + int reg)
> > +{
> > + int rv;
> > + struct pmbus_data *data =3D i2c_get_clientdata(client);
> > + char data_buf[I2C_SMBUS_BLOCK_MAX + 2] =3D { 0 };
>
>
> Unnecessary initialization.
Agree
>
> > +
> > + rv =3D pmbus_read_block_data(client, page, reg, data_buf);
> > + if (rv >=3D 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
> > + rv =3D pmbus_check_status_cml(client);
>
>
> How about PMBUS_READ_STATUS_AFTER_FAILED_CHECK ?
added in the next version
>
> Thanks,
> Guenter
BR,
Adam
>
> > + pmbus_clear_fault_page(client, -1);
> > + return rv >=3D 0;
> > +}
> > +
> > const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client=
 *client)
> > {
> > struct pmbus_data *data =3D i2c_get_clientdata(client);
> > --
> > 2.17.1
