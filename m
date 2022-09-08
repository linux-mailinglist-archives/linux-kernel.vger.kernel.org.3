Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0345D5B2309
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiIHQDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiIHQDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:03:17 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1556ACCE25
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:03:15 -0700 (PDT)
Date:   Thu, 08 Sep 2022 16:03:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1662652990; x=1662912190;
        bh=fN5LYgf8ykM66XFTITzzmVqEhmAPH3iXrdqrj8qdGJk=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=x6GE+uyoD3POaXSPg0gguTpBqEEI5gJLCH1YRle7DioyW1D+icZfUMKNT8rMe7Vcp
         9Hx0qnxZIhRliRWcUQo/c3Q5DwdLxqtnYS9GOGHA4z1WvUYKniC/V31QFaeA3zPaMk
         DwzMxHQah37SbwvcgiT523+e/LrrHNMu2t4gwt9JBY3C6yvIW7LalfIno27HKMuQzr
         LA7I8quOeOLGrvQwEuehLU3200bBh/pKjlWd+QlTG+dmk5y15XK/cQFqpkKv/t/0Di
         eriqkyLXXiJ6szVaVg7UoyxZpiPEI/HijmRaMWMx/0XWy/NazjF0MntxpB8nRaMLoE
         I+KARfqUU4OQQ==
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@protonmail.com>
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Reply-To: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@protonmail.com>
Subject: Re: [PATCH 09/12] ASoC: cs42l42: Split I2C identity into separate module
Message-ID: <90D59877-4FED-483D-8581-85E017614A57@protonmail.com>
Feedback-ID: 6533334:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 19. 8. 2022, at 14:52, Richard Fitzgerald <rf@opensource.cirrus.com> w=
rote:
>
> Split the I2C bus driver definition and probe()/remove() into a
> separate module so that a Soundwire build of CS42L42 support does
> not have a spurious dependency on I2C.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---


> +static int cs42l42_i2c_probe(struct i2c_client *i2c_client)
> +{
> +=09struct device *dev =3D &i2c_client->dev;
> +=09struct cs42l42_private *cs42l42;
> +=09struct regmap *regmap;
> +=09int ret;
> +
> +=09cs42l42 =3D devm_kzalloc(dev, sizeof(*cs42l42), GFP_KERNEL);
> +=09if (!cs42l42)
> +=09=09return -ENOMEM;
> +
> +=09regmap =3D devm_regmap_init_i2c(i2c_client, &cs42l42_regmap);
> +=09if (IS_ERR(regmap)) {
> +=09=09ret =3D PTR_ERR(regmap);
> +=09=09dev_err(&i2c_client->dev, "regmap_init() failed: %d\n", ret);
> +=09=09return ret;
> +=09}
> +
> +=09cs42l42->dev =3D dev;
> +=09cs42l42->regmap =3D regmap;
> +=09cs42l42->irq =3D i2c_client->irq;
> +
> +=09ret =3D cs42l42_common_probe(cs42l42, &cs42l42_soc_component, &cs42l4=
2_dai);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09return cs42l42_init(cs42l42);

The common_remove should probably be called here if the init fails.

Best,
Martin

> +}
> +
> +static int cs42l42_i2c_remove(struct i2c_client *i2c_client)
> +{
> +=09struct cs42l42_private *cs42l42 =3D dev_get_drvdata(&i2c_client->dev)=
;
> +
> +=09cs42l42_common_remove(cs42l42);
> +
> +=09return 0;
> +}

