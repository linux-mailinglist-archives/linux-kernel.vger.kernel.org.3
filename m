Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15DD4D013B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbiCGOam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiCGOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:30:40 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48920723CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:29:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZrzglwRYi35MFh6Tug+AbpXWAwW3g+N0SoK3ICL1I+tPS2A/zHW0VNCzsiKyzTu6s6CTyKLYhBVL8QHzBkt2GBhqoQvqLj0kq97pGOWhIVa3ArMJ/7QF4j86c4j81syXH1d0ZlGgbqwv/x26UwdRvzymMA7lnCuD/vCSD9mC4crh83+HIVuANL+yAGNvjrvAnM1K6J+O/rW4RPk7A/17Uj1dLGe3TrfXRx4Ucp/VCsWprgl7hXyYZGp66Kkg8b6gU7V7yG3iQ5pkgdN5TnNw0T1nnROzKI1i04uH6QLPocio0LhNt0cbgyaYrGC3/u0jTYwcJOSKn9m4w+CXdwy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/uUZogRVj6IEov+sc1F21msDWJOo7H/ekaq8yXaXaU=;
 b=NwKEpA1sSxS6ie6Nao2Hinpmfp6uSqpO5Az4Hds/CdwEMamf9pbKZqA61RXPRbitm/veiJPWI9Cc/yIb22LqbmDSGWpBt4pwQJH+KCqoF96O2tI9wNRrRi/a5UU56LB4LotpaDlLpEwQUpFrYt1j4J8QI0BDnAhwAqOt8cd1Kjx/5O3YU53tA0TtCS0KTfF5QftLk9q5Zd4tPWWNIIORzgAyWiKIIpPK4zzlD43HED8TpP0LFH8nOQj5ziICXtYckW5ro3piVbobADQagmbxFGunnOoF7rTwXNB9upPqD0CYzIASTzE+mUyk5PFuTjE6xTu5gE1JAsr2p3PTz6TwWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/uUZogRVj6IEov+sc1F21msDWJOo7H/ekaq8yXaXaU=;
 b=acxY1Lx1fvVML02VHaPclWZZaL4DL2iP1u874AxNK9V8OBtkCkOq18TZQkDC3eG4/8Hf/q7P/rKKQfKXTewZNEJUzdcBoSA+WyepPnORwqo3F6OL6tpz5/pF79Z64+ZVCUDftqZ1Aqz8HY83PMMGRYQm4oXJuZFgX0tupOpYWPX7WdVIV7G6bb99zH86pEKapsFUwuTTLFu8OTmhHRqR5nXRq2oX+V4YQe8G+GnmMmiUJ0DEkLpmbXuy/Yc54oMOHJDn1NNojklrXMCA3KhhjmHKqCU6x/F7cmrD/1gLw2bHq4X/MXLrame/yBv+Zvv3sCjZZz7ritd7yklWiJyxLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AM9PR08MB6999.eurprd08.prod.outlook.com (2603:10a6:20b:41a::7)
 by AM5PR0802MB2481.eurprd08.prod.outlook.com (2603:10a6:203:a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 14:29:41 +0000
Received: from AM9PR08MB6999.eurprd08.prod.outlook.com
 ([fe80::784c:5631:d38f:9a63]) by AM9PR08MB6999.eurprd08.prod.outlook.com
 ([fe80::784c:5631:d38f:9a63%6]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 14:29:39 +0000
From:   Alifer Moraes <alifer.m@variscite.com>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        eran.m@variscite.com, lgirdwood@gmail.com, perex@perex.cz,
        pierluigi.p@variscite.com, tiwai@suse.com,
        Alifer Moraes <alifer.m@variscite.com>
Subject: [PATCH] ASoC: simple-card: add bindings for amplifier support
Date:   Mon,  7 Mar 2022 11:29:23 -0300
Message-Id: <20220307142923.28365-1-alifer.m@variscite.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CP2PR80CA0041.lamprd80.prod.outlook.com (2603:10d6:102::27)
 To AM9PR08MB6999.eurprd08.prod.outlook.com (2603:10a6:20b:41a::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c6c7234-3cd2-49df-9088-08da0046e9d4
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2481:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2481901BEED4A27C78A6106087089@AM5PR0802MB2481.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYe/Bq/razSpEtTWIsobNwexAVY5OFKYQhpdtf31wQz5J6VHSZ8zfjvow+0nKsPdHa+CzF9jUtyWMExT3IVpAOiS4z5BSjRjggzQ4hoY/HIw3Im9Ix8zAVFGRmn03P7Pzb+uos/JRZkJez89GiasMMQCaMZ753ZD2e+d9x7cXn4Vq7tTYag7BVgZNnGTlGIXI7gJVB+uYOXCpgQx3vJQ5cIO6H8w1MK01Y7bDg43L29gRw00ba4t0hpbmmga11RCoE/EFJM6cRmW5rsYYmFCe5WgHPF1ufeNNzkQJQRxHFIeODM1Y/Qii3OPqi6IBLofu582Lb3KthbTY8IPjluZQz6Jnj1hP8Dl2IyyJVYPYmzZEejcwmoITO+pRFziCX49aZgiM0pHRduWKYQrAt1TVsBzksqk8j4p34w3qC9VKUynSUEJCzFBN3tBJ/I8ZrfxPewzkG8C9besmDAC0/ttRx5dZ7li85DHObWxfP3eE5ikeSdm/Wqa+5UCVtqj4gpWCFiGcVDVk+rtt72C75gOjNYPhsfGihkurVMfM07aNI1eY5ywgQuIWUQdJgeuGW3w72GmmtlxcxNkY+WtIT9jBDQImAoIGMG8qQhymvvCdzWsgBBLzWmam6ZEspCStWozxxHiQ2qHEcr6p5p/SdB3T1vLqlb2onh+jr5W4IbC3jsWFPO2pXK7BAyxPURT5z/c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6999.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(346002)(508600001)(8936002)(6666004)(6512007)(6506007)(2906002)(86362001)(38100700002)(38350700002)(5660300002)(4326008)(107886003)(36756003)(8676002)(6916009)(52116002)(2616005)(1076003)(186003)(26005)(66476007)(66946007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hXx9dMMzeqF0YydMk+uq0NqfDSOiHoZnUsn+oXOC1aGCJSLV20qqTJruiuhF?=
 =?us-ascii?Q?bDDTztxxIlHngxgFOIOMnrqeo6GSKu+0rFGo0iCTVnELz5h70ES4BOXr98Pu?=
 =?us-ascii?Q?+NpOaBiDtORLPWe2Er1pzXqeyOXlJF6sRj7UySBUqO2rfFIlU2nYyUmAKJyL?=
 =?us-ascii?Q?84waBlUKh/BjY4gMniWKMFXNbVyunUN4nCSHjJw7GhI9802GpOxGeMHQJ2Nj?=
 =?us-ascii?Q?QD7eMfm/0GOKVWOywQwnN0orF5m+kgUglkVOss4uYCjORxvSx/JdL/42ZvMs?=
 =?us-ascii?Q?ZxldaggESB+An3yg7UEAdPAs+ZRINGh+svUYJQoYh6wwd3yHntZu+PS6Czop?=
 =?us-ascii?Q?CTYCPIm05l3D/BM6CLib0pWMM4XNRsPJ/zAsO5lVIh/Bd367QlqcSUznNyFf?=
 =?us-ascii?Q?7qbTgkdd2ZUBROR5QgNMtx5CILAGSmB84eZwwwIHwHd4eZgp8tBvytbQbKyM?=
 =?us-ascii?Q?XEnB/z20nCzzGUwxK22du58XnlHeIbO1pdMnlCRstXd3clcjKpz1J61bNT/s?=
 =?us-ascii?Q?94REGPyolPKromUzVF2Qfs0x/fSzfQfPIfOuwsqvs0Kpe/PvSgFAasLVLCdg?=
 =?us-ascii?Q?u+5ebgQgmti/0B8ci3bkpJk+q54PYI1t/OYjKmGPR6BVHLWoWGvLxTJnRDUi?=
 =?us-ascii?Q?xvUIwPPKw/E96+zKHCr9n1dBFuMyJmv0EYPjifjb3l2StT1S9z3gA762L9j5?=
 =?us-ascii?Q?elYIxXZmsRLow7inUUJY+KnEHYJxK4jaJ3xA//aYdPRslNOW4lV3No0c2v7z?=
 =?us-ascii?Q?ikU5yHvjWVYsPU476NCR7djs/043fHzBIJa/IA0t6bfOTihPyxd/9aEt6AGo?=
 =?us-ascii?Q?ROJi0oAEfQVw6qZAVmVBZ9dlPHSktaVOg+EzzBRacP/jtGbNHE7kLlBwoQ+f?=
 =?us-ascii?Q?0dSH7laszOYJlKZePusYtllZ7sObnIBDSFiAWo0C1vWY9qpoeMPhWiRFI4hH?=
 =?us-ascii?Q?NUJ+WclmOBeicSTFlPeU2YQPf9nNJDFkgXSsVt7JNbt3W1flZIxtgVsgVu5m?=
 =?us-ascii?Q?ayPpSpgaJIkcoNlIyeEqVqHzLbTaIPDyepQXvXjU7huGG5kEBANYyZoSJDPJ?=
 =?us-ascii?Q?l2NhAUHRLyy/uLvP9s2sQRWxcolE8O0umVX/ckNdm7TF7jzOahnvn3L3mR1/?=
 =?us-ascii?Q?QdPZvPJN/YZTgt8ssYPEZ4faHRpV8MRXkTGctCtdT0RwYvvoNA3Oc/3MfXOm?=
 =?us-ascii?Q?xf+c24WFYN5e4zSiY1AD1nW71CXvHh/qYwwRzhk8h5/wvdJwhcBVKwozAvby?=
 =?us-ascii?Q?1lxEtASfo3vCP2YBFrGGn50wguxdk8lYHQ/8W7gYwUZAWO7tmEfNrzR+iE5o?=
 =?us-ascii?Q?69Gs73irlMR5ODWKQ8yp0vw7qDcwEz0RIt1fgDngWY5bTQdvvStv0OSlAkxF?=
 =?us-ascii?Q?U1cYNXJNhz3Cvn0Z8b6+j1yHi+AAwgNUJHEeT7qunFCnpNPXxntzAS1yE9Dh?=
 =?us-ascii?Q?Na4MHO9senTiusgnkjGTkDkEhszQYjdEHDvVFJe8WW0o+azgTDkhzionWGo9?=
 =?us-ascii?Q?GmqMu+JccSSs2ilZeMMv9tu81WNbtm/JFlgFnrna/Bf4D1Ltfr+FV9QJ42BW?=
 =?us-ascii?Q?4I72OalA1vtZf9JpaYjgZLLPq5tWLVw9bTeSBbI6pozzsergwAIg3sfeiRiD?=
 =?us-ascii?Q?aCbr1RtE2vN8mAmknfRj8J0=3D?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6c7234-3cd2-49df-9088-08da0046e9d4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6999.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 14:29:39.8016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxkDjNtvZQcZGUoVjJSV6FkzoUnXDjEtx+d/UcRMgDi58obU8s0jB9zgfkYgBnRwsN6cWH58CipMAK/mevOP+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2481
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierluigi Passaro <pierluigi.p@variscite.com>

Add an optional property 'pa-gpios' for controlling external amplifier,
which depends on DAPM widgets and routing.

Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
Signed-off-by: Alifer Moraes <alifer.m@variscite.com>
---
 sound/soc/generic/simple-card.c | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index a89d1cfdda32..d042be556f1b 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
 #include <sound/simple_card.h>
@@ -22,6 +23,33 @@
 #define CELL	"#sound-dai-cells"
 #define PREFIX	"simple-audio-card,"
 
+static int simple_outdrv_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol,
+			      int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct asoc_simple_priv *priv = snd_soc_card_get_drvdata(dapm->card);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		gpiod_set_value_cansleep(priv->pa_gpio, 1);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		gpiod_set_value_cansleep(priv->pa_gpio, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget simple_dapm_widgets[] = {
+	SND_SOC_DAPM_OUT_DRV_E("Amplifier", SND_SOC_NOPM,
+			       0, 0, NULL, 0, simple_outdrv_event,
+			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+};
+
 static const struct snd_soc_ops simple_ops = {
 	.startup	= asoc_simple_startup,
 	.shutdown	= asoc_simple_shutdown,
@@ -620,6 +648,8 @@ static int asoc_simple_probe(struct platform_device *pdev)
 	card = simple_priv_to_card(priv);
 	card->owner		= THIS_MODULE;
 	card->dev		= dev;
+	card->dapm_widgets	= simple_dapm_widgets;
+	card->num_dapm_widgets	= ARRAY_SIZE(simple_dapm_widgets);
 	card->probe		= simple_soc_probe;
 	card->driver_name       = "simple-card";
 
@@ -638,6 +668,13 @@ static int asoc_simple_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	priv->pa_gpio = devm_gpiod_get_optional(dev, "pa", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->pa_gpio)) {
+		ret = PTR_ERR(priv->pa_gpio);
+		dev_err(dev, "failed to get amplifier gpio: %d\n", ret);
+		return ret;
+	}
+
 	if (np && of_device_is_available(np)) {
 
 		ret = simple_parse_of(priv, li);
-- 
2.25.1

