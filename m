Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BA4507C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbiDSWNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbiDSWNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:13:34 -0400
X-Greylist: delayed 4658 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 15:10:49 PDT
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D784A1CB2F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:10:49 -0700 (PDT)
Date:   Tue, 19 Apr 2022 22:10:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1650406248;
        bh=D1aJP9MiYSLnkVbAGTpQnSXWUEjVCXnYrp90gUHgSl0=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=x174y0oXB4dpO2diKXlWaxRTtpGTlCrClG+l+k3WVk2PiO2tfVk6O5JfaIMh5yTXI
         mmX4/wml8lhXuRb2v4aGogTxacDHj3iEEvzXkhyaODRRC+t0aT8wLmLpXQ/FJLcxd2
         ftom4Tjf/uOLcRGzVPdwITbhesXpv9vy3XOO6NfRC4GNUnTmDWNMZP7qO+25KzHVZB
         wh1NX5KSnunrFyPtAcB3kfU2h06nlEoHomIu3q6HyBAEa9qobdnZUSQt8i468BepZv
         djTPbIVFSH8M3zend5KIhXYt1d4G4f28m8whES3m8Srbusg0tsLgPgUUeLf9WNzDhJ
         QCdl5wz8WgHmw==
To:     Guenter Roeck <linux@roeck-us.net>
From:   wujek dev <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: wujek dev <dev_public@wujek.eu>
Subject: Re: [PATCH] hwmod: (pmbus) disable PEC if not enabled
Message-ID: <zNXN2w4xqB6a_14RhNubTjTdcUmzypjeVY-5FXeXlPHsYDuSdQ0qlDjO0CNFnYOrUUAnIlBBIdvMjKURyH4nuthmNQ29ifpaNywsWiU99oQ=@wujek.eu>
In-Reply-To: <734e748b-941c-5ae1-5140-22cc845bdfc1@roeck-us.net>
References: <20220419205228.303952-1-dev_public@wujek.eu> <734e748b-941c-5ae1-5140-22cc845bdfc1@roeck-us.net>
Feedback-ID: 23425257:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------- Original Message -------
On Wednesday, April 20th, 2022 at 00:00, Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
>
> On 4/19/22 13:53, Adam Wujek wrote:
>
> > Explicitly disable PEC when the client does not support it.
> > Without the explicit disable, when the device with the PEC support is r=
emoved
> > later when a device without PEC support is inserted into the same addre=
ss,
> > the driver uses the old value of client->flags which contains the I2C_C=
LIENT_PEC
> > flag. As a consequence the PEC is used when it should not.
>
>
> How can that happen ? I would assume the I2C device gets deleted and re-c=
reated
> in that case, which should clear the PEC flag.
>
> Guenter
In my case it was when I unloaded the driver for the I2C slave, changed the=
 advertised PEC value in PMBUS_CAPABILITY register on slave. Then loaded th=
e driver. When the switch was from disable->enable it worked as expected (t=
his case was already covered), but when the PEC was set in the slave from e=
nabled->disabled it was still using PEC to communicate.

Adam
>
> > Signed-off-by: Adam Wujek dev_public@wujek.eu
> > ---
> > drivers/hwmon/pmbus/pmbus_core.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmb=
us_core.c
> > index 82c3754e21e3..f8ca36759b0a 100644
> > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > @@ -2014,6 +2014,8 @@ static int pmbus_init_common(struct i2c_client *c=
lient, struct pmbus_data *data,
> > ret =3D i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
> > if (ret >=3D 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
> > client->flags |=3D I2C_CLIENT_PEC;
> > + else
> > + client->flags &=3D ~I2C_CLIENT_PEC;
> >
> > pmbus_clear_faults(client);
> >
> > --
> > 2.17.1
