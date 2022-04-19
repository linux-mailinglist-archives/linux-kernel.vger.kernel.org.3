Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF073507C70
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbiDSWVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbiDSWVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:21:18 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2850222512
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:18:35 -0700 (PDT)
Date:   Tue, 19 Apr 2022 22:18:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail2; t=1650406713;
        bh=CZngQfBsYzzOAk/YAglyQ7Wm95FYN4tsduDoER6urxw=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=LUWyrXpDJIy+CPmfGYSAyvokVH2LbtzDfqxqOOKLRdLXtqBRsSbTQhWvczgAcpeT+
         pO9sJ4rcsrtcrs0X/aqCCiN1cjStAIKUKFX2KHhxu0wkellqLuuywhDvduxX4Xad+z
         3a2uwmizWpi7Mzn25mEKvQAe2vge43tm1rw+EMpb+E6WtkpYJR7mC+lIMh2aQ/1KGz
         R7RIfuZY8F7FP03RUBtNJQls916c9AUODnTsPeUfbdpaYth6qIIBeKRrp1FqDX10iR
         XWUlORfN2hWzrVe9PkHzaeCToQWUFshSo6KCWykO1hJRd4lb2j+Ys5sZrQQWl41IOD
         twXt6A6Ior5hg==
To:     Guenter Roeck <linux@roeck-us.net>
From:   wujek dev <dev_public@wujek.eu>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: wujek dev <dev_public@wujek.eu>
Subject: Re: [PATCH] hwmon: (pmbus) allow to use a custom read_byte_data function for PMBUS_CAPABILITY
Message-ID: <zhBIzasdu7Dys33upjpvrg4Ho_-MGpd1dAPkMdfwnelzg8KC-lI6KE7o-6Thz6OF_rOuZYUgMlbneKAxPJtMilcpgJCV9tu5fD2vpdcnlX0=@wujek.eu>
In-Reply-To: <23a10930-e78b-d795-056e-879e52e2b45f@roeck-us.net>
References: <20220419215149.309760-1-dev_public@wujek.eu> <23a10930-e78b-d795-056e-879e52e2b45f@roeck-us.net>
Feedback-ID: 23425257:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------- Original Message -------
On Wednesday, April 20th, 2022 at 00:08, Guenter Roeck <linux@roeck-us.net>=
 wrote:


>
>
> On 4/19/22 14:52, Adam Wujek wrote:
>
> > Some devices returns a wrong value in PMBUS_CAPABILITY register.
> > Allow the use of read_byte_data function defined in a driver for
> > a specific device.
>
>
> Those devices should set PMBUS_NO_CAPABILITY.
>
> Guenter
Yes, you're correct. I was working with the older kernel. Please ignore thi=
s patch.

Adam
>
> > Signed-off-by: Adam Wujek dev_public@wujek.eu
> > ---
> > drivers/hwmon/pmbus/pmbus_core.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmb=
us_core.c
> > index f8ca36759b0a..ef9989be8f89 100644
> > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > @@ -2011,7 +2011,7 @@ static int pmbus_init_common(struct i2c_client *c=
lient, struct pmbus_data *data,
> > }
> >
> > /* Enable PEC if the controller supports it */
> > - ret =3D i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
> > + ret =3D _pmbus_read_byte_data(client, -1, PMBUS_CAPABILITY);
> > if (ret >=3D 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
> > client->flags |=3D I2C_CLIENT_PEC;
> > else
> > --
> > 2.17.1
