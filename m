Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05248D3C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiAMIl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiAMIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:41:25 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1A7C061748
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:41:25 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e19so8567332plc.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:to:cc;
        bh=Fe3mAnM++kzBC9pRQd1pZ9Fhuen5QuM9mWQ9yMCDDGE=;
        b=7KSwhWDt/Hxi//BWQwVhRR9WcdsOuxOJXxaWs+thdGetITzbnG7WfPakIx+08sosYd
         TcGZ5xVRYyq+MO5J+v4qBU5Y74LrZN3t3e6RLCK8JkyhC1NLxZgk3reO3FCc+C47GXC+
         dnxlbHPmHwepXPDJKjzRIM8w+Saq4uzXTuZocagUxlPiV0SoxOGWo3DifdH8KotrPNXq
         6FE4UW655qZTXSV4yeoTTqlMkmffAHqsSjklGOnYR9AqYMkSiAlD1l0nqUoNwThx3azZ
         D8FYOdg2gVCHwv7AwTk/jZiv72VHKbi6yuekPKDw6grcr+iwxuQ4c0WyywQQQ/f99gAx
         cSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:to:cc;
        bh=Fe3mAnM++kzBC9pRQd1pZ9Fhuen5QuM9mWQ9yMCDDGE=;
        b=JV9xkCq3uMQ4vDASlL2o85YF4x0L4hK+Ik80SBnOJPENUsa3I8IgplhkT84szA+GwA
         65XHKBVD66jwmb9COjbrVdEboDmt36I1FQC9p+/YMEaY7GTbbMFu4pksdh/Sm5kjHGCj
         sQ9b+bCV+PGTBzO1/Oxhyc/YFmzUN+CuCrFfSnKFPWtBzX65HhKCG2eTQ8HIe943YISb
         gsMXDRshkogreGS9ee+JPJlENvNv/N6goI7CKSN+Ri+V4W73NUk2fPjzoIiBT5h7JBw/
         EEP1Ve0pPsX3rtXqqM4e39xvkSnfrTTPEzKZxKOiv3a/3Di2+/WwQnf+yuAIeJ1c2JZq
         me0Q==
X-Gm-Message-State: AOAM533IF0sC66PMkvS/G+7OkscyRhRa6CvAqyjQe/m8aGuzMFIJgVqb
        8V3/gKDIQlvLgrBjnb5COXZ7cA==
X-Google-Smtp-Source: ABdhPJz8RhsMigPLWChY08qVdDMIuW5j+wMzZl3W4zsD+unsU+QXRhd3JKGqNG+0xfUZY7TmgFr3Wg==
X-Received: by 2002:aa7:900e:0:b0:4be:9cf:6cdc with SMTP id m14-20020aa7900e000000b004be09cf6cdcmr3256284pfo.25.1642063284532;
        Thu, 13 Jan 2022 00:41:24 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id b4sm2034031pfl.101.2022.01.13.00.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 00:41:24 -0800 (PST)
Message-Id: <a2e4461ee2d2a052984f447f9891f8b4ecc9307c.1642063121.git.daniel.beer@igorinstitute.com>
In-Reply-To: <cover.1642063121.git.daniel.beer@igorinstitute.com>
References: <cover.1642063121.git.daniel.beer@igorinstitute.com>
From:   Daniel Beer <daniel.beer@igorinstitute.com>
Date:   Tue, 11 Jan 2022 12:53:11 +1300
Subject: [PATCH v2 1/2] ASoC: add support for TAS5805M digital amplifier
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Liu <andy-liu@ti.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Texas Instruments TAS5805M is a class D audio amplifier with an
integrated DSP. DSP configuration is expected to be supplied via a
device-tree attribute containing a sequence of register writes.

These register writes set up application-specific DSP settings and are
expected to be generated using TI's PPC3 tool.

Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>
---
 sound/soc/codecs/Kconfig    |   9 +
 sound/soc/codecs/Makefile   |   2 +
 sound/soc/codecs/tas5805m.c | 554 ++++++++++++++++++++++++++++++++++++
 3 files changed, 565 insertions(+)
 create mode 100644 sound/soc/codecs/tas5805m.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index d3e5ae8310ef..d6b8f5cb6ef8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1485,6 +1485,15 @@ config SND_SOC_TAS5720
 	  Enable support for Texas Instruments TAS5720L/M high-efficiency mono
 	  Class-D audio power amplifiers.
 
+config SND_SOC_TAS5805M
+	tristate "Texas Instruments TAS5805M speaker amplifier"
+	depends on I2C
+	help
+	  Enable support for Texas Instruments TAS5805M Class-D
+	  amplifiers. This is a speaker amplifier with an integrated
+	  DSP. DSP configuration for each instance needs to be supplied
+	  via a device-tree attribute.
+
 config SND_SOC_TAS6424
 	tristate "Texas Instruments TAS6424 Quad-Channel Audio amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index ac7f20972470..b4e11c3e4a08 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -236,6 +236,7 @@ snd-soc-sti-sas-objs := sti-sas.o
 snd-soc-tas5086-objs := tas5086.o
 snd-soc-tas571x-objs := tas571x.o
 snd-soc-tas5720-objs := tas5720.o
+snd-soc-tas5805m-objs := tas5805m.o
 snd-soc-tas6424-objs := tas6424.o
 snd-soc-tda7419-objs := tda7419.o
 snd-soc-tas2770-objs := tas2770.o
@@ -574,6 +575,7 @@ obj-$(CONFIG_SND_SOC_TAS2764)	+= snd-soc-tas2764.o
 obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o
 obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
 obj-$(CONFIG_SND_SOC_TAS5720)	+= snd-soc-tas5720.o
+obj-$(CONFIG_SND_SOC_TAS5805M)	+= snd-soc-tas5805m.o
 obj-$(CONFIG_SND_SOC_TAS6424)	+= snd-soc-tas6424.o
 obj-$(CONFIG_SND_SOC_TDA7419)	+= snd-soc-tda7419.o
 obj-$(CONFIG_SND_SOC_TAS2770) += snd-soc-tas2770.o
diff --git a/sound/soc/codecs/tas5805m.c b/sound/soc/codecs/tas5805m.c
new file mode 100644
index 000000000000..300d28bb053d
--- /dev/null
+++ b/sound/soc/codecs/tas5805m.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Driver for the TAS5805M Audio Amplifier
+//
+// Author: Andy Liu <andy-liu@ti.com>
+// Author: Daniel Beer <daniel.beer@igorinstitute.com>
+//
+// This is based on a driver originally written by Andy Liu at TI and
+// posted here:
+//
+//    https://e2e.ti.com/support/audio-group/audio/f/audio-forum/722027/linux-tas5825m-linux-drivers
+//
+// It has been simplified a little and reworked for the 5.x ALSA SoC API.
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <linux/atomic.h>
+#include <linux/workqueue.h>
+
+#include <sound/soc.h>
+#include <sound/pcm.h>
+#include <sound/initval.h>
+
+/* Datasheet-defined registers on page 0, book 0 */
+#define REG_PAGE		0x00
+#define REG_DEVICE_CTRL_1	0x02
+#define REG_DEVICE_CTRL_2	0x03
+#define REG_SIG_CH_CTRL		0x28
+#define REG_SAP_CTRL_1		0x33
+#define REG_FS_MON		0x37
+#define REG_BCK_MON		0x38
+#define REG_CLKDET_STATUS	0x39
+#define REG_VOL_CTL		0x4c
+#define REG_AGAIN		0x54
+#define REG_ADR_PIN_CTRL	0x60
+#define REG_ADR_PIN_CONFIG	0x61
+#define REG_CHAN_FAULT		0x70
+#define REG_GLOBAL_FAULT1	0x71
+#define REG_GLOBAL_FAULT2	0x72
+#define REG_FAULT		0x78
+#define REG_BOOK		0x7f
+
+/* DEVICE_CTRL_2 register values */
+#define DCTRL2_MODE_DEEP_SLEEP	0x00
+#define DCTRL2_MODE_SLEEP	0x01
+#define DCTRL2_MODE_HIZ		0x02
+#define DCTRL2_MODE_PLAY	0x03
+
+#define DCTRL2_MUTE		0x08
+#define DCTRL2_DIS_DSP		0x10
+
+/* This sequence of register writes must always be sent, prior to the
+ * 5ms delay while we wait for the DSP to boot.
+ */
+static const uint8_t dsp_cfg_preboot[] = {
+	0x00, 0x00, 0x7f, 0x00, 0x03, 0x02, 0x01, 0x11,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x7f, 0x00, 0x03, 0x02,
+};
+
+static const uint32_t tas5805m_volume[] = {
+	0x0000001B, /*   0, -110dB */ 0x0000001E, /*   1, -109dB */
+	0x00000021, /*   2, -108dB */ 0x00000025, /*   3, -107dB */
+	0x0000002A, /*   4, -106dB */ 0x0000002F, /*   5, -105dB */
+	0x00000035, /*   6, -104dB */ 0x0000003B, /*   7, -103dB */
+	0x00000043, /*   8, -102dB */ 0x0000004B, /*   9, -101dB */
+	0x00000054, /*  10, -100dB */ 0x0000005E, /*  11,  -99dB */
+	0x0000006A, /*  12,  -98dB */ 0x00000076, /*  13,  -97dB */
+	0x00000085, /*  14,  -96dB */ 0x00000095, /*  15,  -95dB */
+	0x000000A7, /*  16,  -94dB */ 0x000000BC, /*  17,  -93dB */
+	0x000000D3, /*  18,  -92dB */ 0x000000EC, /*  19,  -91dB */
+	0x00000109, /*  20,  -90dB */ 0x0000012A, /*  21,  -89dB */
+	0x0000014E, /*  22,  -88dB */ 0x00000177, /*  23,  -87dB */
+	0x000001A4, /*  24,  -86dB */ 0x000001D8, /*  25,  -85dB */
+	0x00000211, /*  26,  -84dB */ 0x00000252, /*  27,  -83dB */
+	0x0000029A, /*  28,  -82dB */ 0x000002EC, /*  29,  -81dB */
+	0x00000347, /*  30,  -80dB */ 0x000003AD, /*  31,  -79dB */
+	0x00000420, /*  32,  -78dB */ 0x000004A1, /*  33,  -77dB */
+	0x00000532, /*  34,  -76dB */ 0x000005D4, /*  35,  -75dB */
+	0x0000068A, /*  36,  -74dB */ 0x00000756, /*  37,  -73dB */
+	0x0000083B, /*  38,  -72dB */ 0x0000093C, /*  39,  -71dB */
+	0x00000A5D, /*  40,  -70dB */ 0x00000BA0, /*  41,  -69dB */
+	0x00000D0C, /*  42,  -68dB */ 0x00000EA3, /*  43,  -67dB */
+	0x0000106C, /*  44,  -66dB */ 0x0000126D, /*  45,  -65dB */
+	0x000014AD, /*  46,  -64dB */ 0x00001733, /*  47,  -63dB */
+	0x00001A07, /*  48,  -62dB */ 0x00001D34, /*  49,  -61dB */
+	0x000020C5, /*  50,  -60dB */ 0x000024C4, /*  51,  -59dB */
+	0x00002941, /*  52,  -58dB */ 0x00002E49, /*  53,  -57dB */
+	0x000033EF, /*  54,  -56dB */ 0x00003A45, /*  55,  -55dB */
+	0x00004161, /*  56,  -54dB */ 0x0000495C, /*  57,  -53dB */
+	0x0000524F, /*  58,  -52dB */ 0x00005C5A, /*  59,  -51dB */
+	0x0000679F, /*  60,  -50dB */ 0x00007444, /*  61,  -49dB */
+	0x00008274, /*  62,  -48dB */ 0x0000925F, /*  63,  -47dB */
+	0x0000A43B, /*  64,  -46dB */ 0x0000B845, /*  65,  -45dB */
+	0x0000CEC1, /*  66,  -44dB */ 0x0000E7FB, /*  67,  -43dB */
+	0x00010449, /*  68,  -42dB */ 0x0001240C, /*  69,  -41dB */
+	0x000147AE, /*  70,  -40dB */ 0x00016FAA, /*  71,  -39dB */
+	0x00019C86, /*  72,  -38dB */ 0x0001CEDC, /*  73,  -37dB */
+	0x00020756, /*  74,  -36dB */ 0x000246B5, /*  75,  -35dB */
+	0x00028DCF, /*  76,  -34dB */ 0x0002DD96, /*  77,  -33dB */
+	0x00033718, /*  78,  -32dB */ 0x00039B87, /*  79,  -31dB */
+	0x00040C37, /*  80,  -30dB */ 0x00048AA7, /*  81,  -29dB */
+	0x00051884, /*  82,  -28dB */ 0x0005B7B1, /*  83,  -27dB */
+	0x00066A4A, /*  84,  -26dB */ 0x000732AE, /*  85,  -25dB */
+	0x00081385, /*  86,  -24dB */ 0x00090FCC, /*  87,  -23dB */
+	0x000A2ADB, /*  88,  -22dB */ 0x000B6873, /*  89,  -21dB */
+	0x000CCCCD, /*  90,  -20dB */ 0x000E5CA1, /*  91,  -19dB */
+	0x00101D3F, /*  92,  -18dB */ 0x0012149A, /*  93,  -17dB */
+	0x00144961, /*  94,  -16dB */ 0x0016C311, /*  95,  -15dB */
+	0x00198A13, /*  96,  -14dB */ 0x001CA7D7, /*  97,  -13dB */
+	0x002026F3, /*  98,  -12dB */ 0x00241347, /*  99,  -11dB */
+	0x00287A27, /* 100,  -10dB */ 0x002D6A86, /* 101,  -9dB */
+	0x0032F52D, /* 102,   -8dB */ 0x00392CEE, /* 103,   -7dB */
+	0x004026E7, /* 104,   -6dB */ 0x0047FACD, /* 105,   -5dB */
+	0x0050C336, /* 106,   -4dB */ 0x005A9DF8, /* 107,   -3dB */
+	0x0065AC8C, /* 108,   -2dB */ 0x00721483, /* 109,   -1dB */
+	0x00800000, /* 110,    0dB */ 0x008F9E4D, /* 111,    1dB */
+	0x00A12478, /* 112,    2dB */ 0x00B4CE08, /* 113,    3dB */
+	0x00CADDC8, /* 114,    4dB */ 0x00E39EA9, /* 115,    5dB */
+	0x00FF64C1, /* 116,    6dB */ 0x011E8E6A, /* 117,    7dB */
+	0x0141857F, /* 118,    8dB */ 0x0168C0C6, /* 119,    9dB */
+	0x0194C584, /* 120,   10dB */ 0x01C62940, /* 121,   11dB */
+	0x01FD93C2, /* 122,   12dB */ 0x023BC148, /* 123,   13dB */
+	0x02818508, /* 124,   14dB */ 0x02CFCC01, /* 125,   15dB */
+	0x0327A01A, /* 126,   16dB */ 0x038A2BAD, /* 127,   17dB */
+	0x03F8BD7A, /* 128,   18dB */ 0x0474CD1B, /* 129,   19dB */
+	0x05000000, /* 130,   20dB */ 0x059C2F02, /* 131,   21dB */
+	0x064B6CAE, /* 132,   22dB */ 0x07100C4D, /* 133,   23dB */
+	0x07ECA9CD, /* 134,   24dB */ 0x08E43299, /* 135,   25dB */
+	0x09F9EF8E, /* 136,   26dB */ 0x0B319025, /* 137,   27dB */
+	0x0C8F36F2, /* 138,   28dB */ 0x0E1787B8, /* 139,   29dB */
+	0x0FCFB725, /* 140,   30dB */ 0x11BD9C84, /* 141,   31dB */
+	0x13E7C594, /* 142,   32dB */ 0x16558CCB, /* 143,   33dB */
+	0x190F3254, /* 144,   34dB */ 0x1C1DF80E, /* 145,   35dB */
+	0x1F8C4107, /* 146,   36dB */ 0x2365B4BF, /* 147,   37dB */
+	0x27B766C2, /* 148,   38dB */ 0x2C900313, /* 149,   39dB */
+	0x32000000, /* 150,   40dB */ 0x3819D612, /* 151,   41dB */
+	0x3EF23ECA, /* 152,   42dB */ 0x46A07B07, /* 153,   43dB */
+	0x4F3EA203, /* 154,   44dB */ 0x58E9F9F9, /* 155,   45dB */
+	0x63C35B8E, /* 156,   46dB */ 0x6FEFA16D, /* 157,   47dB */
+	0x7D982575, /* 158,   48dB */
+};
+
+#define TAS5805M_VOLUME_MAX	((int)ARRAY_SIZE(tas5805m_volume) - 1)
+#define TAS5805M_VOLUME_MIN	0
+
+struct tas5805m_priv {
+	struct regulator		*pvdd;
+	struct gpio_desc		*gpio_pdn_n;
+
+	uint8_t				*dsp_cfg_data;
+	int				dsp_cfg_len;
+
+	struct regmap			*regmap;
+	struct mutex			lock;
+
+	int				vol[2];
+	bool				is_powered;
+	bool				is_muted;
+};
+
+static void set_dsp_scale(struct regmap *rm, int offset, int vol)
+{
+	uint8_t v[4];
+	uint32_t x = tas5805m_volume[vol];
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		v[3 - i] = x;
+		x >>= 8;
+	}
+
+	regmap_bulk_write(rm, offset, v, ARRAY_SIZE(v));
+}
+
+static void tas5805m_refresh_unlocked(struct snd_soc_component *component)
+{
+	struct tas5805m_priv *tas5805m =
+		snd_soc_component_get_drvdata(component);
+	struct regmap *rm = tas5805m->regmap;
+
+	dev_dbg(component->dev, "refresh: is_muted=%d, vol=%d/%d\n",
+		tas5805m->is_muted, tas5805m->vol[0], tas5805m->vol[1]);
+
+	regmap_write(rm, REG_PAGE, 0x00);
+	regmap_write(rm, REG_BOOK, 0x8c);
+	regmap_write(rm, REG_PAGE, 0x2a);
+
+	/* Refresh volume. The actual volume control documented in the
+	 * datasheet doesn't seem to work correctly. This is a pair of
+	 * DSP registers which are *not* documented in the datasheet.
+	 */
+	set_dsp_scale(rm, 0x24, tas5805m->vol[0]);
+	set_dsp_scale(rm, 0x28, tas5805m->vol[1]);
+
+	/* Set/clear digital soft-mute */
+	regmap_write(rm, REG_DEVICE_CTRL_2,
+		(tas5805m->is_muted ? DCTRL2_MUTE : 0) |
+		DCTRL2_MODE_PLAY);
+}
+
+static int tas5805m_vol_info(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+
+	uinfo->value.integer.min = TAS5805M_VOLUME_MIN;
+	uinfo->value.integer.max = TAS5805M_VOLUME_MAX;
+	return 0;
+}
+
+static int tas5805m_vol_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	struct tas5805m_priv *tas5805m =
+		snd_soc_component_get_drvdata(component);
+
+	mutex_lock(&tas5805m->lock);
+	ucontrol->value.integer.value[0] = tas5805m->vol[0];
+	ucontrol->value.integer.value[1] = tas5805m->vol[1];
+	mutex_unlock(&tas5805m->lock);
+
+	return 0;
+}
+
+static inline int volume_is_valid(int v)
+{
+	return (v >= TAS5805M_VOLUME_MIN) && (v <= TAS5805M_VOLUME_MAX);
+}
+
+static int tas5805m_vol_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	struct tas5805m_priv *tas5805m =
+		snd_soc_component_get_drvdata(component);
+
+	if (!(volume_is_valid(ucontrol->value.integer.value[0]) &&
+	      volume_is_valid(ucontrol->value.integer.value[1])))
+		return -EINVAL;
+
+	mutex_lock(&tas5805m->lock);
+	tas5805m->vol[0] = ucontrol->value.integer.value[0];
+	tas5805m->vol[1] = ucontrol->value.integer.value[1];
+	dev_dbg(component->dev, "set vol=%d/%d (is_powered=%d)\n",
+		tas5805m->vol[0], tas5805m->vol[1], tas5805m->is_powered);
+	if (tas5805m->is_powered)
+		tas5805m_refresh_unlocked(component);
+	mutex_unlock(&tas5805m->lock);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new tas5805m_snd_controls[] = {
+	{
+		.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name	= "Master Playback Volume",
+		.access	= SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+			  SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info	= tas5805m_vol_info,
+		.get	= tas5805m_vol_get,
+		.put	= tas5805m_vol_put,
+	},
+};
+
+static void send_cfg(struct regmap *rm,
+		     const uint8_t *s, unsigned int len)
+{
+	unsigned int i;
+
+	for (i = 0; i + 1 < len; i += 2)
+		regmap_write(rm, s[i], s[i + 1]);
+}
+
+/* The TAS5805M DSP can't be configured until the I2S clock has been
+ * present and stable for 5ms, or else it won't boot and we get no
+ * sound.
+ */
+static int tas5805m_trigger(struct snd_pcm_substream *substream, int cmd,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tas5805m_priv *tas5805m =
+		snd_soc_component_get_drvdata(component);
+	struct regmap *rm = tas5805m->regmap;
+	unsigned int chan, global1, global2;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		dev_dbg(component->dev, "DSP startup\n");
+
+		/* We mustn't issue any I2C transactions until the I2S
+		 * clock is stable. Furthermore, we must allow a 5ms
+		 * delay after the first set of register writes to
+		 * allow the DSP to boot before configuring it.
+		 */
+		mutex_lock(&tas5805m->lock);
+		usleep_range(5000, 10000);
+		send_cfg(rm, dsp_cfg_preboot,
+			ARRAY_SIZE(dsp_cfg_preboot));
+		usleep_range(5000, 15000);
+		send_cfg(rm, tas5805m->dsp_cfg_data,
+			tas5805m->dsp_cfg_len);
+
+		tas5805m->is_powered = true;
+		tas5805m_refresh_unlocked(component);
+		mutex_unlock(&tas5805m->lock);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		dev_dbg(component->dev, "DSP shutdown\n");
+
+		mutex_lock(&tas5805m->lock);
+		tas5805m->is_powered = false;
+
+		regmap_write(rm, REG_PAGE, 0x00);
+		regmap_write(rm, REG_BOOK, 0x00);
+
+		regmap_read(rm, REG_CHAN_FAULT, &chan);
+		regmap_read(rm, REG_GLOBAL_FAULT1, &global1);
+		regmap_read(rm, REG_GLOBAL_FAULT2, &global2);
+
+		dev_dbg(component->dev,
+			"fault regs: CHAN=%02x, GLOBAL1=%02x, GLOBAL2=%02x\n",
+			chan, global1, global2);
+
+		regmap_write(rm, REG_DEVICE_CTRL_2, DCTRL2_MODE_HIZ);
+		mutex_unlock(&tas5805m->lock);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_route tas5805m_audio_map[] = {
+	{ "DAC", NULL, "DAC IN" },
+	{ "OUT", NULL, "DAC" },
+};
+
+static const struct snd_soc_dapm_widget tas5805m_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("DAC IN", "Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("OUT")
+};
+
+static const struct snd_soc_component_driver soc_codec_dev_tas5805m = {
+	.controls		= tas5805m_snd_controls,
+	.num_controls		= ARRAY_SIZE(tas5805m_snd_controls),
+	.dapm_widgets		= tas5805m_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(tas5805m_dapm_widgets),
+	.dapm_routes		= tas5805m_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(tas5805m_audio_map),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
+static int tas5805m_mute(struct snd_soc_dai *dai, int mute, int direction)
+{
+	struct snd_soc_component *component = dai->component;
+	struct tas5805m_priv *tas5805m =
+		snd_soc_component_get_drvdata(component);
+
+	mutex_lock(&tas5805m->lock);
+	dev_dbg(component->dev, "set mute=%d (is_powered=%d)\n",
+		mute, tas5805m->is_powered);
+	tas5805m->is_muted = !!mute;
+	if (tas5805m->is_powered)
+		tas5805m_refresh_unlocked(component);
+	mutex_unlock(&tas5805m->lock);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops tas5805m_dai_ops = {
+	.trigger		= tas5805m_trigger,
+	.mute_stream		= tas5805m_mute,
+	.no_capture_mute	= 1,
+};
+
+static struct snd_soc_dai_driver tas5805m_dai = {
+	.name		= "tas5805m-amplifier",
+	.playback	= {
+		.stream_name	= "Playback",
+		.channels_min	= 2,
+		.channels_max	= 2,
+		.rates		= SNDRV_PCM_RATE_48000,
+		.formats	= SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.ops		= &tas5805m_dai_ops,
+};
+
+static const struct regmap_config tas5805m_regmap = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+
+	/* We have quite a lot of multi-level bank switching and a
+	 * relatively small number of register writes between bank
+	 * switches.
+	 */
+	.cache_type	= REGCACHE_NONE,
+};
+
+static int tas5805m_i2c_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct regmap *regmap;
+	struct tas5805m_priv *tas5805m;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(i2c, &tas5805m_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(dev, "unable to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	tas5805m = devm_kzalloc(dev, sizeof(struct tas5805m_priv), GFP_KERNEL);
+	if (!tas5805m)
+		return -ENOMEM;
+
+	tas5805m->pvdd = devm_regulator_get(dev, "pvdd");
+	if (IS_ERR(tas5805m->pvdd)) {
+		dev_err(dev, "failed to get pvdd supply: %ld\n",
+			PTR_ERR(tas5805m->pvdd));
+		return PTR_ERR(tas5805m->pvdd);
+	}
+
+	dev_set_drvdata(dev, tas5805m);
+	tas5805m->regmap = regmap;
+	tas5805m->gpio_pdn_n = devm_gpiod_get(dev, "pdn", GPIOD_OUT_LOW);
+	if (IS_ERR(tas5805m->gpio_pdn_n)) {
+		dev_err(dev, "error requesting PDN gpio: %ld\n",
+			PTR_ERR(tas5805m->gpio_pdn_n));
+		return PTR_ERR(tas5805m->gpio_pdn_n);
+	}
+
+	tas5805m->dsp_cfg_len = of_property_count_elems_of_size(dev->of_node,
+		"ti,dsp-config", 1);
+	if (tas5805m->dsp_cfg_len < 0) {
+		dev_err(dev, "no DSP config provided\n");
+		return tas5805m->dsp_cfg_len;
+	}
+
+	tas5805m->dsp_cfg_data = devm_kmalloc(dev, tas5805m->dsp_cfg_len,
+		GFP_KERNEL);
+	if (!tas5805m->dsp_cfg_data)
+		return -ENOMEM;
+
+	of_property_read_u8_array(dev->of_node, "ti,dsp-config",
+		tas5805m->dsp_cfg_data, tas5805m->dsp_cfg_len);
+	dev_dbg(dev, "%d bytes of DSP config loaded\n",
+		tas5805m->dsp_cfg_len);
+
+	/* Do the first part of the power-on here, while we can expect
+	 * the I2S interface to be quiet. We must raise PDN# and then
+	 * wait 5ms before any I2S clock is sent, or else the internal
+	 * regulator apparently won't come on.
+	 *
+	 * Also, we must keep the device in power down for 100ms or so
+	 * after PVDD is applied, or else the ADR pin is sampled
+	 * incorrectly and the device comes up with an unpredictable I2C
+	 * address.
+	 */
+	tas5805m->vol[0] = TAS5805M_VOLUME_MIN;
+	tas5805m->vol[1] = TAS5805M_VOLUME_MIN;
+	mutex_init(&tas5805m->lock);
+
+	ret = regulator_enable(tas5805m->pvdd);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable pvdd: %d\n", ret);
+		return ret;
+	}
+
+	usleep_range(100000, 150000);
+	gpiod_set_value(tas5805m->gpio_pdn_n, 1);
+	usleep_range(10000, 15000);
+
+	/* Don't register through devm. We need to be able to unregister
+	 * the component prior to deasserting PDN#
+	 */
+	ret = snd_soc_register_component(dev, &soc_codec_dev_tas5805m,
+					 &tas5805m_dai, 1);
+	if (ret < 0) {
+		dev_err(dev, "unable to register codec: %d\n", ret);
+		gpiod_set_value(tas5805m->gpio_pdn_n, 0);
+		regulator_disable(tas5805m->pvdd);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int tas5805m_i2c_remove(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct tas5805m_priv *tas5805m = dev_get_drvdata(dev);
+
+	snd_soc_unregister_component(dev);
+	gpiod_set_value(tas5805m->gpio_pdn_n, 0);
+	usleep_range(10000, 15000);
+	regulator_disable(tas5805m->pvdd);
+	return 0;
+}
+
+static const struct i2c_device_id tas5805m_i2c_id[] = {
+	{ "tas5805m", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tas5805m_i2c_id);
+
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id tas5805m_of_match[] = {
+	{ .compatible = "ti,tas5805m", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tas5805m_of_match);
+#endif
+
+static struct i2c_driver tas5805m_i2c_driver = {
+	.probe_new	= tas5805m_i2c_probe,
+	.remove		= tas5805m_i2c_remove,
+	.id_table	= tas5805m_i2c_id,
+	.driver		= {
+		.name		= "tas5805m",
+		.of_match_table = of_match_ptr(tas5805m_of_match),
+	},
+};
+
+module_i2c_driver(tas5805m_i2c_driver);
+
+MODULE_AUTHOR("Andy Liu <andy-liu@ti.com>");
+MODULE_AUTHOR("Daniel Beer <daniel.beer@igorinstitute.com>");
+MODULE_DESCRIPTION("TAS5805M Audio Amplifier Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.30.2

