Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCE54BB05D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiBRDqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:46:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBRDql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:46:41 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A24BE097
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:46:25 -0800 (PST)
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A29223FDC7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645155983;
        bh=0RxOc3UniivNO6eEtLtFNmWfIVvDozmAkMICYO3UsLU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=jyWvHdVlS6HnQKXgSmUxlr9/W/2EW2qUS/3EufFv7tcoBlqpZSeea/gMBn9X0ZgB1
         wD92FWXwID7gOrVMmkk4qbQa9CdgtDAu2gcUhAq+LWrw2315vpt1FPdQZc+K9Zjgbt
         qdxAJdrmqgDu8ZjcPMLQ/nyCEcg/GAnhkUdsCyR/7JxgGZCKyAGwKhsUbOdg43oBBv
         PrgG3DgpM2JUHjTlX3arR5+5gSY626dz28tpLH4/cuJbksUZ1qRLPgFEUgrd7Ih5wB
         kEz9/VdEWMSafjNOxrs68aLkvpfj4vm5y4MSL3KDSwfJmgKq0VSEjTpCxhxzBxNK1x
         oFfIz5/q2BEBg==
Received: by mail-ot1-f72.google.com with SMTP id q9-20020a05683033c900b005ad0806c5b3so898485ott.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0RxOc3UniivNO6eEtLtFNmWfIVvDozmAkMICYO3UsLU=;
        b=Szw6gdK/UKLBFy557SiP04SuBJ9Tlci8tGQ0iSuc19TNPtcZNWDeVT7s2AuOg9hzRg
         oWqQ6JaUlxdzHKwV4RJ5J4szpln8xoQVBgkkoH/MyQF+yWG0QYzNVCWpQRCC4/jmB7pN
         9FD6j+Jt98yyX9TuEtapU7WYi83A2SyCE5CvpMUiEztE7eLMFqCH+FeNveh7/a76cQCm
         et9CYgB3i3cHUzOn1BGvaFwLHR4AZosxNaDrgXFANEzkHpsYUXkDOT3FUtj3px94TdGg
         RZFQ0avKxtV4vVHsPOngj0px+E4hThOZw8aXTalKfHEGvIHfTk7Q+XlAxXphjG6dY31u
         CaBg==
X-Gm-Message-State: AOAM530m04aZ8+pr3Am37XKp8FUmpQVTYcAs+E55UJdX5BMT3g1qNex7
        yGIKlAm826a5/vz+1633JHTvUZ9+f1s493cNyl4imP4Isr7CNSFYaT5xwiwkiHkU2jwL1f2wBmA
        7G1XZwSyUEUwK+WbG0GuQ3Xzph6aA8Zlw7NxdN0uUmnzdSXpMCRLEuCQYXA==
X-Received: by 2002:a05:6808:2110:b0:2d4:4137:b4fc with SMTP id r16-20020a056808211000b002d44137b4fcmr4329999oiw.111.1645155982391;
        Thu, 17 Feb 2022 19:46:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMQyIw05tp8VFtFxbc+dsgMQp7NcON7pbi2DUtJ4YIPKYpvyCcRQpeoHCvrdqIRDQhi34L+gklycZtFQqlR1c=
X-Received: by 2002:a05:6808:2110:b0:2d4:4137:b4fc with SMTP id
 r16-20020a056808211000b002d44137b4fcmr4329992oiw.111.1645155982128; Thu, 17
 Feb 2022 19:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20220217055208.2388929-1-kai.heng.feng@canonical.com> <CAHp75VfFGw3b_ZtQir0AfTfXfQ7fi_LKLsY-7ww=4+MMBR8BAQ@mail.gmail.com>
In-Reply-To: <CAHp75VfFGw3b_ZtQir0AfTfXfQ7fi_LKLsY-7ww=4+MMBR8BAQ@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 18 Feb 2022 11:46:10 +0800
Message-ID: <CAAd53p7O7joFa7MH0s+rw-59WQkigvjKBf1bpO9e2gX9ddjF-A@mail.gmail.com>
Subject: Re: [PATCH v4] iio: accel: adxl345: Add ACPI HID table
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 6:57 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
>
>
> On Thursday, February 17, 2022, Kai-Heng Feng <kai.heng.feng@canonical.co=
m> wrote:
>>
>> x86 boards may use ACPI HID "ADS0345" for adxl345 device.
>>
>> Analog replied:
>> "ADS034X is not a valid PNP ID. ADS0345 would be.
>> I'm not aware that this ID is already taken.
>> Feel free to submit a mainline Linux input mailing list patch."
>>
>> So add an ACPI match table for that accordingly.
>>
>> Since ACPI device may not match to any I2C ID, use the name and type
>> directly from ACPI ID table in absence of I2C ID.
>>
>> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v4:
>>  - Drop "ADS0345:00" and use driver_date from ACPI table directly.
>>
>> v3:
>>  - Convert the driver from input to iio.
>>
>> v2:
>>  - Drop ACPI_PTR()
>>  - Drop redundant empty line and comma
>>  - Add info from vendor
>>
>>  drivers/iio/accel/adxl345_i2c.c | 29 ++++++++++++++++++++++++-----
>>  1 file changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345=
_i2c.c
>> index a431cba216e69..cdcc3ef1f1d33 100644
>> --- a/drivers/iio/accel/adxl345_i2c.c
>> +++ b/drivers/iio/accel/adxl345_i2c.c
>> @@ -22,20 +22,32 @@ static const struct regmap_config adxl345_i2c_regmap=
_config =3D {
>>  static int adxl345_i2c_probe(struct i2c_client *client,
>>                              const struct i2c_device_id *id)
>>  {
>> +       struct device *dev =3D &client->dev;
>> +       const struct acpi_device_id *acpi_id;
>> +       enum adxl345_device_type type;
>> +       const char *name;
>>         struct regmap *regmap;
>>
>> -       if (!id)
>> -               return -ENODEV;
>> +       if (id) {
>> +               type =3D id->driver_data;
>> +               name =3D id->name;
>> +       } else {
>> +               acpi_id =3D acpi_match_device(dev->driver->acpi_match_ta=
ble, dev);
>> +               if (acpi_id) {
>> +                       type =3D acpi_id->driver_data;
>> +                       name =3D acpi_id->id;
>> +               } else
>> +                       return -ENODEV;
>> +       }
>>
>
>
> Thanks, but can we do this in ACPI agnostic way?
>
> Can be as simple as
>
> if (id)
>   ...
> else {
>   match =3D device_get_match_data(dev);
>   if (!match)
>     return -ENODEV;
> }
>
> Note, it might require to reconsider what is put in the driver data (eith=
er convert to pointers, or be sure that valid type is never a 0/NULL).

Unlike acpi_match_device(), device_get_match_data() only get
driver_data, so we need a new struct to provide both name and type.

>
> Also note, in both cases using ID name for name us fragile. Probably we h=
ave to fix that first. Let me check today=E2=80=99s evening.

Can you please explain more on this? How does ID name make it fragile?

Kai-Heng

>
>>
>>         regmap =3D devm_regmap_init_i2c(client, &adxl345_i2c_regmap_conf=
ig);
>>         if (IS_ERR(regmap)) {
>> -               dev_err(&client->dev, "Error initializing i2c regmap: %l=
d\n",
>> +               dev_err(dev, "Error initializing i2c regmap: %ld\n",
>>                         PTR_ERR(regmap));
>>                 return PTR_ERR(regmap);
>>         }
>>
>> -       return adxl345_core_probe(&client->dev, regmap, id->driver_data,
>> -                                 id->name);
>> +       return adxl345_core_probe(&client->dev, regmap, type, name);
>>  }
>>
>>  static const struct i2c_device_id adxl345_i2c_id[] =3D {
>> @@ -54,10 +66,17 @@ static const struct of_device_id adxl345_of_match[] =
=3D {
>>
>>  MODULE_DEVICE_TABLE(of, adxl345_of_match);
>>
>> +static const struct acpi_device_id adxl345_acpi_match[] =3D {
>> +       { "ADS0345", ADXL345 },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
>> +
>>  static struct i2c_driver adxl345_i2c_driver =3D {
>>         .driver =3D {
>>                 .name   =3D "adxl345_i2c",
>>                 .of_match_table =3D adxl345_of_match,
>> +               .acpi_match_table =3D adxl345_acpi_match,
>>         },
>>         .probe          =3D adxl345_i2c_probe,
>>         .id_table       =3D adxl345_i2c_id,
>> --
>> 2.34.1
>>
>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
