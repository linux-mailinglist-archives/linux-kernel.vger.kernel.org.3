Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F94BA627
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243322AbiBQQkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:40:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiBQQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:40:06 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E842B2FD7;
        Thu, 17 Feb 2022 08:39:50 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4K00sw4FKDz9sYX;
        Thu, 17 Feb 2022 17:39:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645115986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKMYfIYEKaO/AzJDq7YrqWp6caWHvpKI3f237QWlRnk=;
        b=qJ7CRQ26R9aRwRfGUMDqGnjIbKh5IktR3F3AfNPngw9wmBwuwYd/GNRq/AL1EtOeAZYo4Z
        JzcY0KZyDU4YwShOTaVEE2UQbQCbrRIZd2LiBXCqKP15W6fEICl7H0US8IzKLGBJtonSsw
        HHwR97z2TB8mNmmufhu2lkuJ1H1ZoLJsbfB2KsiOGFionLdtKqkU7cbhbijvBzhMSafvVd
        jqdo0vLCujR4oqP0HPJg2BFdt9EXhn5WxcbQ0SRwrnW/nl6o+IpPfpEeSss9u/2ROyHEnd
        8hZDGqmlGfzHNwcVjuOq0g0k4WmfQ9dsAU28Yr5MVFXihqW1P7oclEdb+Ps7Tw==
Message-ID: <246de83631dd5e165f95904d7f1628502f030e02.camel@sylv.io>
Subject: Re: [PATCH v2 2/3] hwmon (xdpe12284): Add support for xdpe11280
From:   sylv <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-doc@vger.kernel.org
Date:   Thu, 17 Feb 2022 17:39:41 +0100
In-Reply-To: <f1e13a4e-2e86-1d53-f34d-a04838e8e8f9@roeck-us.net>
References: <cover.1645108566.git.sylv@sylv.io>
         <6103836f1116a045a25919ae3e5c18dfdc485902.1645108566.git.sylv@sylv.io>
         <f1e13a4e-2e86-1d53-f34d-a04838e8e8f9@roeck-us.net>
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

On Thu, 2022-02-17 at 07:20 -0800, Guenter Roeck wrote:
> On 2/17/22 06:41, Marcello Sylvester Bauer wrote:
> > Add support for another family of Infineon Multi-phase controllers.
> > The xdpe11280 uses linear instead of vid data format for VOUT.
> > Add the required logic to detect VOUT_MODE during identification,
> > and set the format accordingly.
> > 
> This talks about the chip, but ...

Oh, sure. I should be more clear that it is a chip of a different
family.

> 
> > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > ---
> >   Documentation/hwmon/xdpe12284.rst | 10 +++++++---
> >   drivers/hwmon/pmbus/xdpe12284.c   | 17 ++++++++++++++++-
> >   2 files changed, 23 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/xdpe12284.rst
> > b/Documentation/hwmon/xdpe12284.rst
> > index 67d1f87808e5..e9a5a19b0c3d 100644
> > --- a/Documentation/hwmon/xdpe12284.rst
> > +++ b/Documentation/hwmon/xdpe12284.rst
> > @@ -5,6 +5,10 @@ Kernel driver xdpe122
> >   
> >   Supported chips:
> >   
> > +  * Infineon XDPE11280
> > +
> > +    Prefix: 'xdpe11280'
> > +
> >     * Infineon XDPE12254
> >   
> >       Prefix: 'xdpe12254'
> > @@ -20,9 +24,9 @@ Authors:
> >   Description
> >   -----------
> >   
> > -This driver implements support for Infineon Multi-phase XDPE122
> > family
> > -dual loop voltage regulators.
> > -The family includes XDPE12284 and XDPE12254 devices.
> > +This driver implements support for Infineon Multi-phase XDPE112
> > and XDPE122
> > +family dual loop voltage regulators.
> > +These families include XDPE11280, XDPE12284 and XDPE12254 devices.
> >   The devices from this family complaint with:
> 
> Hmm, s/complaint/compliant/.

ack

> 
> Anyway, is it still correct that the XDPE11280 is compliant with the
> Intel specifications ? The datasheet isn't public, so I can not check
> myself
> what the chip actually supports.

The hardware we are testing on is an Intel Cascade Lake, which uses
this chip. The datasheet tells us it is compliant:

```
The XDPE11280B implements a fully compliant Intel® VR 13, VR12, VR
12.5, VR13.HC, and IMVP8 Serial VID (SVID)
interface.
```

> 
> >   
> >   - Intel VR13 and VR13HC rev 1.3, IMVP8 rev 1.2 and IMPVP9 rev 1.3
> > DC-DC
> > diff --git a/drivers/hwmon/pmbus/xdpe12284.c
> > b/drivers/hwmon/pmbus/xdpe12284.c
> > index b07da06a40c9..ec947c697670 100644
> > --- a/drivers/hwmon/pmbus/xdpe12284.c
> > +++ b/drivers/hwmon/pmbus/xdpe12284.c
> > @@ -27,6 +27,9 @@ static int xdpe122_read_word_data(struct
> > i2c_client *client, int page,
> >         s32 mantissa;
> >         int ret;
> >   
> > +       if (info->format[PSC_VOLTAGE_OUT] == linear)
> > +               return -ENODATA;
> > +
> >         switch (reg) {
> >         case PMBUS_VOUT_OV_FAULT_LIMIT:
> >         case PMBUS_VOUT_UV_FAULT_LIMIT:
> > @@ -75,9 +78,19 @@ static int xdpe122_read_word_data(struct
> > i2c_client *client, int page,
> >   static int xdpe122_identify(struct i2c_client *client,
> >                             struct pmbus_driver_info *info)
> >   {
> > -       u8 vout_params;
> > +       u8 vout_mode, vout_params;
> >         int i, ret;
> >   
> > +       ret = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       vout_mode = ret >> 5;
> > +       if (vout_mode == 0) {
> > +               info->format[PSC_VOLTAGE_OUT] = linear;
> > +               return 0;
> > +       }
> 
> .... the code above is not chip dependent but this code checks the
> mode register on page 0. At the very least this is confusing.
> 
> What the driver should do instead is to check the chip type during
> probe and make the necessary changes there, ie set the output format
> for xdpe11280 to linear and drop the pointers to the .identify
> and .read_word_data.

Sgtm. This sounds like a better approach indeed.

Thanks,
Marcello

> 
> Guenter
> 
> > +
> >         for (i = 0; i < XDPE122_PAGE_NUM; i++) {
> >                 /* Read the register with VOUT scaling value.*/
> >                 ret = pmbus_read_byte_data(client, i,
> > PMBUS_VOUT_MODE);
> > @@ -140,6 +153,7 @@ static int xdpe122_probe(struct i2c_client
> > *client)
> >   }
> >   
> >   static const struct i2c_device_id xdpe122_id[] = {
> > +       {"xdpe11280", 0},
> >         {"xdpe12254", 0},
> >         {"xdpe12284", 0},
> >         {}
> > @@ -148,6 +162,7 @@ static const struct i2c_device_id xdpe122_id[]
> > = {
> >   MODULE_DEVICE_TABLE(i2c, xdpe122_id);
> >   
> >   static const struct of_device_id __maybe_unused
> > xdpe122_of_match[] = {
> > +       {.compatible = "infineon,xdpe11280"},
> >         {.compatible = "infineon,xdpe12254"},
> >         {.compatible = "infineon,xdpe12284"},
> >         {}
> 

