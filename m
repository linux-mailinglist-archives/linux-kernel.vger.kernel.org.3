Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1284AD9A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350752AbiBHNWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbiBHMRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:17:42 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70082.outbound.protection.outlook.com [40.107.7.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2E7C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:17:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdMmAKY/OCXTJMaUuuFnzPHwBQdNE2Cz0fffXIwUMh1JCUb42NszijgWs0W1Erc+oSS6NumgaLq5GHvK1IF5zdvAGX8qxhq+uprJ1NxlBNAfdvHxLmmXdF40GTUqMdtcW3q4gdK2nzf02CAkiO4gRlFgiyHNO00qKPDe1/rgf/G5NaI2P7mRhoIn9sEzaCAMJYBLV0v177LRai1XQCsBf4fmHu+T6s/9oBWcVx34TZv3Ra7XvHvn3g4eMAOlmWAArUPSge76bryXLgrTyhtPPZJn7sc4YJL3r4dmb6HAmPC760aGZhr2NnIG6BoW/pFo6/FYqH+OEtwut954IPbrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jehz2CGQ/78gH5W6bQj7gRfwRkj1JZMXA4L762ITIXc=;
 b=lZuDh9VrgJzfTZtFgnE3poFP2FXrSfc7kn3rnDQiLxkupzs4URxxOiQbkrnisQq66ec0okI52eLLFe6iJS+QSPdz9Ha3+xSJt3zBPbHCXvw25YqSpIAx2wYEwSVljx0DlPBr6TSIVcfiTADxYInEMz7XnePmfyTWDPDEqh7vNZy32ifDXJlJV0jp+8I4Uhx1AQvjXQ/FhMx36b8mFCEF/9zcITxCYtj6Jrz9Kmn9N1lxCuw6GOXWkDrCAUZ4QhpTUn2EMGjwu1ALQ9N/9KxybECBo9AxMJ/pNXgLdi7MUV1vd+6m55EFwcIaWu0aovYjkbcUBVOMI/7q3kV/iwBX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jehz2CGQ/78gH5W6bQj7gRfwRkj1JZMXA4L762ITIXc=;
 b=FC6K9Xe0vC+xjEn6tAn95NZdFydA/1dwLZE4j1dUeF3d2U06/AeqG6zinmKoZXq6vPhPc0zgFAkpFWkT7V0a27KT9jelERK9RbUpyaZ5pvbTFFzPv8C3Pebq7rrsN0ErP8kQonHiKTlJy6DFzHRLqRrNtQPaVgc7SFK63Dp/2cQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 12:17:37 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::acb8:bd1e:d125:8259]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::acb8:bd1e:d125:8259%4]) with mapi id 15.20.4951.017; Tue, 8 Feb 2022
 12:17:37 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@freescale.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codec: wm8960: complete discharge on BIAS OFF->STANDBY
Date:   Tue,  8 Feb 2022 14:17:27 +0200
Message-Id: <20220208121727.4461-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.26.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0226.eurprd07.prod.outlook.com
 (2603:10a6:802:58::29) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7adaf6bb-0bfa-4989-65c4-08d9eafcfe8a
X-MS-TrafficTypeDiagnostic: PAXPR04MB8301:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB83018F0596BAC61D9C73D4B8D32D9@PAXPR04MB8301.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOSzTEbdhg6LJbwyS10LhO1TviSBY7ErJNtoLMXTnf/fLrAKi1V5FW94jqZZYUblnqi6fGGJMTH5Y/o6dOzEC785efrMkpIynC3QDOzMGV4GlWSYFl7hlKl89gKunVeSvOGIK6jKSb/F1XIZ31YC8oIelhadXTyGivOY1vnkLtOaSLt1DvqUX0ocd6wznMD8tS6hgRZ/AToGiGU5yQML/cQQAOh1fm15yCr+tx8Ygma+DzZw/oBJjPs4Agu/hIkTqEG3Soh5D5yLGHhB538xK3ySaP1/ae727Kq/rCA3HKcR2HDeV6cNpDQ4I+MuBH9PgI540J+WxKZEx0PmiAW00GHG4+UkZ1V4SgUGYD3CB60LWx3LUbponObm8idbUoOV8Zg01X3m4bAKYMl8CYK2SYQw1Yb2OQHHWnCV4NvIP5/Zze33m8r7KF6n4Pk1QVCYr+aM2z2IXS0SGeGGyh/YLIarL/4kDWGpnhDX1X10QvN9axvgz3OHRq6oAFFnP/EMi8thUwg1MqdCbl8mpslZV0FmJbA8wrCMidlqoVkjL9OTgwTaiKbD7QMJPHhco46u6mNnJeKPSNJaU/p74MPJLtSbt+0gK0hWYR3/5yXJeh+XhcT5Ef6NGQpyCAekKcBffQmD6XIW+CfknCBGR0rIdJBIMEksxECLrHMB2wT0L1QCIw/er+zR8pMDD7egahOxGNYIWFelur/lI9+IWVL4i/t8nm8krdqf7fa5ILkcL1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(1076003)(6506007)(316002)(26005)(508600001)(6486002)(83380400001)(52116002)(2616005)(2906002)(86362001)(6666004)(8676002)(8936002)(66946007)(66556008)(66476007)(110136005)(6512007)(38350700002)(38100700002)(921005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0IF+Pkw0vvYQdLysxzUMX4tU2BlekP/Qowj4t25m7/jcw5JCjntPXoZ66itp?=
 =?us-ascii?Q?i51nOdKlxT7wvkAqTyOtwheSFCTWyg3+Ub1MtcZL6fyvqxnsxpi93oyvWkfT?=
 =?us-ascii?Q?Un+Ig+XBKnuoj0M9ijFB4o+Q+iJj2bnwaCHGtVRWD443IyEbU3h0ojSXgYn0?=
 =?us-ascii?Q?6XLMLZdNlqHbUa0jsIrp3KAN8mVc2yYKcCFsB+0ISIQUh4I/7+7POTvF+CIs?=
 =?us-ascii?Q?qYE8C2bQ/nXQv+ZcfPn2r6jLJGFYDNiGgciZlxWSVhdA/2uItLs4iRYEjDFu?=
 =?us-ascii?Q?De1gM/YI6J36zg8bDUl4u8j1QWCXHoVDqWGb0pB8idDg4iaSkNrhiNXJXm2h?=
 =?us-ascii?Q?48ERuA7ukfWdzIXfieMJ4J/KuYqM98rlZa3vjIK4S4DSKqplytGM6N4dvUTq?=
 =?us-ascii?Q?oxev5Sn4hsriVXc8ULF6uIw9u5h+Be4MAaDtWuBcXX11W2qTFy/W2CeefqHX?=
 =?us-ascii?Q?KWdENYf1J4eSoV2zz6c03BoeUSrYeaiH6P6xbzqCu8I0D42O4jOA4pgYa3qN?=
 =?us-ascii?Q?NOfZWt8snBMc4HDxmJiPxC/3Cv7o1cuvCcomkYILj25NT2zTjDhjj03GHGSu?=
 =?us-ascii?Q?f78XNV0V1gUovMOwJb0KtBsWOsDHbw/KT4+PZEPVBfZKVvgSOO/l0sJ3jc6L?=
 =?us-ascii?Q?hskhBcaLvNRcVKs+PA0XFedpIJeprnaavLpv7Qk8zS+HSzKReVDzeJdl5YF9?=
 =?us-ascii?Q?qrozeJlhoWwbqLm28U/BOyt2WXcWNJrHLhpuaBDrNloPXxouttVuAw5ZSTZz?=
 =?us-ascii?Q?Exk+q0lozAB5qA61LPigIp8ZUq7Iw4RbfKCD6Bh9J9VKLZZoAbnlSlrFr8pe?=
 =?us-ascii?Q?NRoVQovcYtcLBDhWv2KXN4srSiebe6Nv6Uy5kbds8VSYspqNUXF0EGyTy3H6?=
 =?us-ascii?Q?ZQ4F3re+7BKuxKVtgEE3Td8H+q6PzI74qZxrojTp15NZyen3kCl9RvCvvW5R?=
 =?us-ascii?Q?5JD0HljZ58tgtLStBRIhImeSHZx+8aeHBz8uLQsfQUJ2ve3Qzv2GU5bavK1h?=
 =?us-ascii?Q?Ltpfu0nN2atimAe3Z+9tGNtyPQ1mkRGz56pGaow3AXYCDUw4AsHuebLJbF71?=
 =?us-ascii?Q?BkMqS8FgwPmn/KtdqQ4eiCdkukr++djK+V3F45ZqHK3+BE8OniSHLodZqArg?=
 =?us-ascii?Q?0/ilRthKjKffKRtXd8fAKRul3y0wuEYKSpW8K6jJD/G+H1R9V3C7MUu6Gveu?=
 =?us-ascii?Q?ZUWM9fKR+0sHKi29EvIk+atiNFxRclvXk6WabsL8I0ZwqU9niVKyR/23hhlM?=
 =?us-ascii?Q?4Ldp1JErD+qseY4XFjFwAkZGUR0yXc8j0VMDsCOP2HsWHg2pEqXlhIyS1O3N?=
 =?us-ascii?Q?VIgJUEmVmZlmEayAEMyEWXLLV0aY7QPUIbkbMn/wOisOuH9fK3XwWeabDktE?=
 =?us-ascii?Q?ldWW+xwd90wsf9e7Jl8mLFeogLBO4cso91hc9FDsYW7hVYLNFxWPzChrjqTP?=
 =?us-ascii?Q?g9pmrxpewwxTpF+U0C9pl2hXINVHy0agwiI/odQwbbydL1N481iIfLWWGM/N?=
 =?us-ascii?Q?bkoJG+7CHHSMykU78eeTm7+XrlnmMy48lVtHSczaO/DM5Cs4hOxOFI0bCtxl?=
 =?us-ascii?Q?qvP0Tf0mSpx//F947Fceenz15kQpVPa0x6OvTvqDRcnq7qKbVf3up+YfjAUp?=
 =?us-ascii?Q?2b1E2sl0x0KuJmjYdqY5cJ8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adaf6bb-0bfa-4989-65c4-08d9eafcfe8a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 12:17:37.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DU0k1w1dTVMB0+KahZTV0Cw8FhNvLL0i04geWu1/nMScb4a2q0vhP/rwVCHngCHjvc8dDy6WnKs87mw6EAGtcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

On BIAS STANDBY->OFF transition the current implementation sleeps
600ms on suspend in order to discharge the chip. The suspend is
propagated from "snd_soc_suspend" call for all audio cards in a
serial fashion, thus in case of boards like i.MX8DXL EVK which has
3 distinct WM8960 codecs the total cumulated sleep on suspend is 1.8
seconds.

On the other hand the BIAS OFF->STANDBY transition happens
asynchronously with regard to "snd_soc_resume" - the call is
propagated from "soc_resume_deferred" which is just scheduled
from "snd_soc_resume", each card having its own work scheduled to
execute "soc_resume_deferred" call.

The patch performs discharge completion on BIAS OFF->STANDBY transition
so that the cumulated effect on suspend described above is avoided
and discharge is completed in paralel in case of multiple WM8960
codecs on the board.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 sound/soc/codecs/wm8960.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 75de6a81465df..b7a2246184e08 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -45,6 +45,8 @@
 #define WM8960_DISOP     0x40
 #define WM8960_DRES_MASK 0x30
 
+#define WM8960_DSCH_TOUT	600 /* discharge timeout, ms */
+
 static bool is_pll_freq_available(unsigned int source, unsigned int target);
 static int wm8960_set_pll(struct snd_soc_component *component,
 		unsigned int freq_in, unsigned int freq_out);
@@ -133,6 +135,7 @@ struct wm8960_priv {
 	int freq_in;
 	bool is_stream_in_use[2];
 	struct wm8960_data pdata;
+	ktime_t dsch_start;
 };
 
 #define wm8960_reset(c)	regmap_write(c, WM8960_RESET, 0)
@@ -898,6 +901,7 @@ static int wm8960_set_bias_level_out3(struct snd_soc_component *component,
 	struct wm8960_priv *wm8960 = snd_soc_component_get_drvdata(component);
 	u16 pm2 = snd_soc_component_read(component, WM8960_POWER2);
 	int ret;
+	ktime_t tout;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -944,6 +948,11 @@ static int wm8960_set_bias_level_out3(struct snd_soc_component *component,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
+			/* ensure discharge is complete */
+			tout = WM8960_DSCH_TOUT - ktime_ms_delta(ktime_get(), wm8960->dsch_start);
+			if (tout > 0)
+				msleep(tout);
+
 			regcache_sync(wm8960->regmap);
 
 			/* Enable anti-pop features */
@@ -973,9 +982,9 @@ static int wm8960_set_bias_level_out3(struct snd_soc_component *component,
 			     WM8960_POBCTRL | WM8960_SOFT_ST |
 			     WM8960_BUFDCOPEN | WM8960_BUFIOEN);
 
-		/* Disable VMID and VREF, let them discharge */
+		/* Disable VMID and VREF, mark discharge */
 		snd_soc_component_write(component, WM8960_POWER1, 0);
-		msleep(600);
+		wm8960->dsch_start = ktime_get();
 		break;
 	}
 
-- 
2.26.3

