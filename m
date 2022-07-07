Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD4C5699D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbiGGFbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGGFbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:31:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90A031346;
        Wed,  6 Jul 2022 22:31:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so10356358wme.0;
        Wed, 06 Jul 2022 22:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HGdsxecpYJqAjSPrIEI+NBuaZfrpU2l3H+tCGdU0dyY=;
        b=MipbWvdNcwc96uOIPdWR/lsfUyMKG5wgbpEl54sz6DMk0btSjU27Y7/4CXdLBjDopn
         7iJY+H0LCQLUTuPnuCcgH4gYipys2O/Z371Tl1+IEvsU4CGgBHHg1hOwkbR/qe2o7XzA
         Sf15IpRUZ243lavVcxXsSPq+62PSAYeKUwRk4ir1Nn08wCM9DrHMM3BvT7kbV77o+8VU
         pbzr/9uA4J6M2bdJXpwVfgzLrlVL2GY/2OFrr1Kz9VW2z9H8VtXq8O8PduOAQXWzj22m
         JUl/6XsxQVtzNlxgUIOCs7BCC4oH2CTqbsvRQnfeRLEtiIo6oSykM1BaJxxeIbMnvpIc
         Ha3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HGdsxecpYJqAjSPrIEI+NBuaZfrpU2l3H+tCGdU0dyY=;
        b=lIkStEn7kiO5mvGD0rB613z4u87TTM3XttDH1kvEEGDuk8fqg9pIpkxJjOXwN9mQP8
         w/RcIAN19I0cEAmbs7x43A2KhGd6QNHrNbc9WgNQ20qO5foZkoxbJ3JXgAoM+A1rDt80
         vTBWj3RCuzkNIiNUczfu/52ObMRraqVjfilm/TEVC0eA1jukXSfResZx6UZgQvpryUt/
         kz3vVKarovM6BIHSLAzIfQRa7Rn4ZuZFs9nidV4sULFfJeGNKfqPHU9/6DNbX0u41sZF
         EKMNSNf143CZfD0aES5pwSh1O3Mp5acoWMev5OV7xAnT1rloI1P7kus290thSFSVwVTS
         zvnA==
X-Gm-Message-State: AJIora/cmaIpSYOILd3XBoKDxmMKdtN+5slZBuuZ0L4RLSZvMnyEhl13
        tUnLS1VzEm65fS8jJzKBhflLlETWZJ3UiiKXp/o=
X-Google-Smtp-Source: AGRyM1sw2zioOwNBihKYn4OlhwOa3MfdRHukGDSRJV8elZqm7FuKgyqiC7Oe7vzFFHOBTH3HXxv4GeCZC/eazZ1Itz8=
X-Received: by 2002:a05:600c:3507:b0:3a1:9fbb:4d62 with SMTP id
 h7-20020a05600c350700b003a19fbb4d62mr2226711wmq.161.1657171871861; Wed, 06
 Jul 2022 22:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220527084647.30835-1-ctcchien@nuvoton.com> <20220527084647.30835-4-ctcchien@nuvoton.com>
 <YrYd+FkiFPz84twJ@mail.local>
In-Reply-To: <YrYd+FkiFPz84twJ@mail.local>
From:   Medad Young <medadyoung@gmail.com>
Date:   Thu, 7 Jul 2022 13:30:59 +0800
Message-ID: <CAHpyw9cdmCSZEE4ZbpnehpyvFhpPWA+_E5zXzJerNX9xqYet5Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] RTC: nuvoton: Add NCT3018Y real time clock driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, a.zummo@towertech.it,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING <KFTING@nuvoton.com>, ctcchien@nuvoton.com,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-rtc@vger.kernel.org, Mining Lin <mimi05633@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexandre,

Thanks for your comments.
I add Mining Lin <mimi05633@gmail.com> into this mail thread,
and she is going to follow up this RTC driver.
She will be in charge of maintaining this driver.

Alexandre Belloni <alexandre.belloni@bootlin.com> =E6=96=BC 2022=E5=B9=B46=
=E6=9C=8825=E6=97=A5 =E9=80=B1=E5=85=AD =E5=87=8C=E6=99=A84:26=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hello,
>
> Please run ./scripts/checkpatch.pl --strict on your patch, there are a
> bunch of issues.
>
> On 27/05/2022 16:46:47+0800, medadyoung@gmail.com wrote:
> > +static int nct3018y_set_alarm_mode(struct i2c_client *client, bool on)
> > +{
> > +     int err, flags;
> > +
> > +     dev_dbg(&client->dev, "%s:on:%d\n", __func__, on);
> > +
> > +     flags =3D  i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
> > +     if (flags < 0) {
> > +             dev_err(&client->dev,
> > +                     "Failed to read NCT3018Y_REG_CTRL\n");
>
> You should cut down on the number of error messages, they are usually
> not useful as the user doesn't have any specific action after getting
> one of them apart from trying the action once again. Also, this will
> make your code shorter. dev_dbg is fine.
>
> > +/*
> > + * In the routines that deal directly with the nct3018y hardware, we u=
se
> > + * rtc_time -- month 0-11, hour 0-23, yr =3D calendar year-epoch.
> > + */
> > +static int nct3018y_rtc_read_time(struct device *dev, struct rtc_time =
*tm)
> > +{
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     unsigned char buf[10];
> > +     int err;
> > +
>
> You should still return an error if the time is invalid there but without
> an error message.
>
> > +     err =3D i2c_smbus_read_i2c_block_data(client, NCT3018Y_REG_SC, si=
zeof(buf), buf);
> > +     if (err < 0)
> > +             return err;
> > +
> > +     tm->tm_sec =3D bcd2bin(buf[0] & 0x7F);
> > +     tm->tm_min =3D bcd2bin(buf[2] & 0x7F);
> > +     tm->tm_hour =3D bcd2bin(buf[4] & 0x3F);
> > +     tm->tm_wday =3D buf[6] & 0x07;
> > +     tm->tm_mday =3D bcd2bin(buf[7] & 0x3F);
> > +     tm->tm_mon =3D bcd2bin(buf[8] & 0x1F) - 1;
> > +     tm->tm_year =3D bcd2bin(buf[9]) + 100;
> > +
> > +     return 0;
> > +}
> > +
> > +static int nct3018y_rtc_read_alarm(struct device *dev, struct rtc_wkal=
rm *tm)
> > +{
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     unsigned char buf[5];
> > +     int err;
> > +
> > +     err =3D i2c_smbus_read_i2c_block_data(client, NCT3018Y_REG_SCA,
> > +                                         sizeof(buf), buf);
> > +     if (err < 0) {
> > +             dev_err(&client->dev, "Unable to read date\n");
> > +             return -EIO;
> > +     }
> > +
> > +     dev_dbg(&client->dev, "%s: raw data is sec=3D%02x, min=3D%02x hr=
=3D%02x\n",
> > +             __func__, buf[0], buf[2], buf[4]);
> > +
> > +     tm->time.tm_sec =3D bcd2bin(buf[0] & 0x7F);
> > +     tm->time.tm_min =3D bcd2bin(buf[2] & 0x7F);
> > +     tm->time.tm_hour =3D bcd2bin(buf[4] & 0x3F);
> > +
> > +     err =3D nct3018y_get_alarm_mode(client, &tm->enabled, &tm->pendin=
g);
> > +     if (err < 0)
> > +             return err;
> > +
> > +     dev_dbg(&client->dev, "%s:s=3D%d m=3D%d, hr=3D%d, enabled=3D%d, p=
ending=3D%d\n",
> > +             __func__, tm->time.tm_sec, tm->time.tm_min,
> > +             tm->time.tm_hour, tm->enabled, tm->pending);
> > +
> > +     return 0;
> > +}
> > +
> > +static int nct3018y_rtc_set_alarm(struct device *dev, struct rtc_wkalr=
m *tm)
> > +{
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     unsigned char buf[3];
> > +     int err;
> > +
> > +     dev_dbg(dev, "%s, sec=3D%d, min=3D%d hour=3D%d tm->enabled:%d\n",
> > +             __func__, tm->time.tm_sec, tm->time.tm_min, tm->time.tm_h=
our,
> > +             tm->enabled);
> > +
> > +     buf[0] =3D bin2bcd(tm->time.tm_sec);
> > +     buf[1] =3D bin2bcd(tm->time.tm_min);
> > +     buf[2] =3D bin2bcd(tm->time.tm_hour);
>
> I don't think buf is useful in this function
> > +
> > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_SCA, buf[0=
]);
> > +     if (err < 0) {
> > +             dev_err(&client->dev, "Unable to write NCT3018Y_REG_SCA\n=
");
> > +             return err;
> > +     }
> > +
> > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_MNA, buf[1=
]);
> > +     if (err < 0) {
> > +             dev_err(&client->dev, "Unable to write NCT3018Y_REG_MNA\n=
");
> > +             return err;
> > +     }
> > +
> > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_HRA, buf[2=
]);
> > +     if (err < 0) {
> > +             dev_err(&client->dev, "Unable to write NCT3018Y_REG_HRA\n=
");
> > +             return err;
> > +     }
> > +
> > +     return nct3018y_set_alarm_mode(client, tm->enabled);
> > +}
> > +
>
>
> > +static struct clk *nct3018y_clkout_register_clk(struct nct3018y *nct30=
18y)
> > +{
> > +     struct i2c_client *client =3D nct3018y->client;
> > +     struct device_node *node =3D client->dev.of_node;
> > +     struct clk *clk;
> > +     struct clk_init_data init;
> > +     int flags, err;
> > +
> > +     /* disable the clkout output */
> > +     flags =3D 0;
> > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CLKO, flag=
s);
>
> BTW, this introduces a glitch in the clock output if the clock is
> actually used. Maybe you could just rely on the CCF core to disable this
> clock when there are no users.
>
> > +     if (err < 0) {
> > +             dev_err(&client->dev, "Unable to write oscillator status =
register\n");
> > +             return ERR_PTR(err);
> > +     }
> > +
> > +     init.name =3D "nct3018y-clkout";
> > +     init.ops =3D &nct3018y_clkout_ops;
> > +     init.flags =3D 0;
> > +     init.parent_names =3D NULL;
> > +     init.num_parents =3D 0;
> > +     nct3018y->clkout_hw.init =3D &init;
> > +
> > +     /* optional override of the clockname */
> > +     of_property_read_string(node, "clock-output-names", &init.name);
> > +
> > +     /* register the clock */
> > +     clk =3D devm_clk_register(&client->dev, &nct3018y->clkout_hw);
> > +
> > +     if (!IS_ERR(clk))
> > +             of_clk_add_provider(node, of_clk_src_simple_get, clk);
> > +
> > +     return clk;
> > +}
> > +#endif
> > +
> > +static const struct rtc_class_ops nct3018y_rtc_ops =3D {
> > +     .read_time      =3D nct3018y_rtc_read_time,
> > +     .set_time       =3D nct3018y_rtc_set_time,
> > +     .read_alarm     =3D nct3018y_rtc_read_alarm,
> > +     .set_alarm      =3D nct3018y_rtc_set_alarm,
> > +     .alarm_irq_enable =3D nct3018y_irq_enable,
> > +     .ioctl          =3D nct3018y_ioctl,
> > +};
> > +
> > +static int nct3018y_probe(struct i2c_client *client,
> > +                       const struct i2c_device_id *id)
> > +{
> > +     struct nct3018y *nct3018y;
> > +     int err, flags;
> > +
> > +     if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>
> Don't you rather need I2C_FUNC_SMBUS_BYTE and I2C_FUNC_SMBUS_BLOCK_DATA?
>
> > +             dev_err(&client->dev, "%s: ENODEV\n", __func__);
> > +             return -ENODEV;
> > +     }
> > +
> > +     nct3018y =3D devm_kzalloc(&client->dev, sizeof(struct nct3018y),
> > +                             GFP_KERNEL);
> > +     if (!nct3018y)
> > +             return -ENOMEM;
> > +
> > +     i2c_set_clientdata(client, nct3018y);
> > +     nct3018y->client =3D client;
> > +     device_set_wakeup_capable(&client->dev, 1);
> > +
> > +     flags =3D i2c_smbus_read_byte_data(client, NCT3018Y_REG_CTRL);
> > +     if (flags < 0) {
> > +             dev_err(&client->dev, "%s: read error\n", __func__);
> > +             return flags;
> > +     } else if (flags & NCT3018Y_BIT_TWO)
> > +             dev_dbg(&client->dev, "%s: NCT3018Y_BIT_TWO is set\n", __=
func__);
> > +
> > +
> > +     flags =3D NCT3018Y_BIT_TWO;
> > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_CTRL, flag=
s);
> > +     if (err < 0) {
> > +             dev_err(&client->dev, "Unable to write NCT3018Y_REG_CTRL\=
n");
> > +             return err;
> > +     }
> > +
> > +     flags =3D 0;
> > +     err =3D i2c_smbus_write_byte_data(client, NCT3018Y_REG_ST, flags)=
;
> > +     if (err < 0) {
> > +             dev_err(&client->dev, "%s: write error\n", __func__);
> > +             return err;
> > +     }
> > +
> > +
> > +     nct3018y->rtc =3D devm_rtc_allocate_device(&client->dev);
> > +     if (IS_ERR(nct3018y->rtc))
> > +             return PTR_ERR(nct3018y->rtc);
> > +
> > +     nct3018y->rtc->ops =3D &nct3018y_rtc_ops;
> > +     nct3018y->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
> > +     nct3018y->rtc->range_max =3D RTC_TIMESTAMP_END_2099;
> > +
> > +     if (client->irq > 0) {
> > +             err =3D devm_request_threaded_irq(&client->dev, client->i=
rq,
> > +                             NULL, nct3018y_irq,
> > +                             IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
> > +                             "nct3018y", client);
> > +             if (err) {
> > +                     dev_err(&client->dev, "unable to request IRQ %d\n=
", client->irq);
> > +                     return err;
> > +             }
> > +     }
>
> You need to clear RTC_FEATURE_UPDATE_INTERRUPT and RTC_FEATURE_ALARM
> from nct3018y->rtc->features when client->irq <=3D 0
>
> > +
> > +     return devm_rtc_register_device(nct3018y->rtc);
> > +
>
> > +#ifdef CONFIG_COMMON_CLK
> > +     /* register clk in common clk framework */
> > +     nct3018y_clkout_register_clk(nct3018y);
> > +#endif
> > +
>
> This code is not reachable anymore
>
> > +     return 0;
> > +}
> > +
> > +static const struct i2c_device_id nct3018y_id[] =3D {
> > +     { "nct3018y", 0 },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, nct3018y_id);
> > +
> > +
> > +static const struct of_device_id nct3018y_of_match[] =3D {
> > +     { .compatible =3D "nuvoton,nct3018y" },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, nct3018y_of_match);
> > +
> > +static struct i2c_driver nct3018y_driver =3D {
> > +     .driver         =3D {
> > +             .name   =3D "rtc-nct3018y",
> > +             .of_match_table =3D of_match_ptr(nct3018y_of_match),
> > +     },
> > +     .probe          =3D nct3018y_probe,
> > +     .id_table       =3D nct3018y_id,
> > +};
> > +
> > +module_i2c_driver(nct3018y_driver);
> > +
> > +MODULE_AUTHOR("Medad CChien <ctcchien@nuvoton.com>");
> > +MODULE_DESCRIPTION("Nuvoton NCT3018Y RTC driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.1
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

B.R.
Medad
