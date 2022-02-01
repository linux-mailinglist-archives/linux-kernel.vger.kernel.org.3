Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817B04A68B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiBAXrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:47:32 -0500
Received: from mail-4316.protonmail.ch ([185.70.43.16]:17559 "EHLO
        mail-4316.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiBAXrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:47:31 -0500
Date:   Tue, 01 Feb 2022 23:47:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1643759249;
        bh=SzxGyHc0MaRHChzTCdfR+eLaUqpReD6n1FCyEvsk43k=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=tmAslqzDF4OjbdvUsLuPf4FNXsaYYBeeKrW/n1jjNzCxJEqFN0JH9hV8Nt35vwvpv
         yH5X7JsSkISNXfQNC6ErlJgbMS41nhEjfpJ4T1DB2N9JZKE4LJRj4z/hWVVWs6gwxq
         +MrMf2Zxf3Ip2CO8INk5EqTumceCNGXIn8dLSvelDcwDb+VfDUezocMYEVka/z+H3P
         T4TrGdV3ah18cG3w7rduXmaEj5T4yg/t9PI+XLU8rSJHR18Za5J18vzlCg2nhwPLnL
         f53dx+py7Awk6OZu69NQUzYGGGfN1yTNZqbCWlJ7UWihdZjEySJvP8G1OHwzx9l5Uw
         tJpj38djD++kg==
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ye Bin <yebin10@huawei.com>,
        Frank Shi <shifu0704@thundersoft.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Reply-To: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>
Subject: [PATCH] ASoC: tas2770: Insert post reset delay
Message-ID: <20220201234612.74401-1-povik+lin@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        T_SCC_BODY_TEXT_LINE shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per TAS2770 datasheet there must be a 1 ms delay from reset to first
command. So insert delays into the driver where appropriate.

Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
Signed-off-by: Martin Povi=C5=A1er <povik+lin@protonmail.com>
---
 sound/soc/codecs/tas2770.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index b52c0861edc8..b397a2122dd4 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -38,10 +38,12 @@ static void tas2770_reset(struct tas2770_priv *tas2770)
 =09=09gpiod_set_value_cansleep(tas2770->reset_gpio, 0);
 =09=09msleep(20);
 =09=09gpiod_set_value_cansleep(tas2770->reset_gpio, 1);
+=09=09usleep_range(1000, 2000);
 =09}

 =09snd_soc_component_write(tas2770->component, TAS2770_SW_RST,
 =09=09TAS2770_RST);
+=09usleep_range(1000, 2000);
 }

 static int tas2770_set_bias_level(struct snd_soc_component *component,
@@ -110,6 +112,7 @@ static int tas2770_codec_resume(struct snd_soc_componen=
t *component)

 =09if (tas2770->sdz_gpio) {
 =09=09gpiod_set_value_cansleep(tas2770->sdz_gpio, 1);
+=09=09usleep_range(1000, 2000);
 =09} else {
 =09=09ret =3D snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
 =09=09=09=09=09=09    TAS2770_PWR_CTRL_MASK,
@@ -529,8 +532,10 @@ static int tas2770_codec_probe(struct snd_soc_componen=
t *component)

 =09tas2770->component =3D component;

-=09if (tas2770->sdz_gpio)
+=09if (tas2770->sdz_gpio) {
 =09=09gpiod_set_value_cansleep(tas2770->sdz_gpio, 1);
+=09=09usleep_range(1000, 2000);
+=09}

 =09tas2770_reset(tas2770);

--
2.33.0


