Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6410E596AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiHQIGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiHQIFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:05:55 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FD72F39F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtrniIcLMtfC9GuHc7o2d6rSkea9eyevxUzToOs3b4+WgGVHJN5bxYjh+aizdVkNiIDNf/qOi38TWSO63z6MZ/OCB4jQAaDqUURZMlmsbWepo6GdlNv8d/3gPmOMTCva9T/4FUqxzjYI2N66HvKQ+xBHXAFVky2tGBq7t/AZoUyR7r/E4hkPAnL5miOyjtb/QGtqKgQp0JpKq8fYi9QE3dhDSu7p195q5OAEE4LEW74KBLh4gDQ0TKd0F2C5+FFVSNcQDfE4TKmrQGKOLAODM1bWrHiZzOxh040ZeVVjTo/TVg9cDkDoSZoHZshWDTLy7rZ9psrsF29R0shhp9AHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+29B8g6FWmsRTmm8MhWkeccZoIlYvU93XqkN5sZP7EA=;
 b=ER1tVGIE4Yi+jGYEcpjvj6L1Pin0g5A2uZi1yoOzqqRfPdzOiHDC2NBTMwSKIpL+3uopePWhcYzyqmBpebUJUJkMgsNzKn2YcKk+tBaNIjNZ3gk5KwW1nkmoOMG8NrlqEgvLPMebry1Jm5aU0pcMU96t8lgQhzlGLAbufzga/bnCwk4ndkc0dF+78N6qa18763pB17b6ASYLs8tJ/AN0oAsZphpwuf9Awow9V+a66ItOguNHOPFoIOHmCLSq3pkzVf5Ks1nQpEvhBvTuJTr2QxRUXcQwUQWOMWoEANT0ZD1g3spNu/kM5sQbyoLHmNk7hRtAz0IGEpuI3DxwQJCwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+29B8g6FWmsRTmm8MhWkeccZoIlYvU93XqkN5sZP7EA=;
 b=G2+VU3FG2gQuCSS0JaEl2l6TfCQNzmnu2iUqqHvDZET0/d97Sa1q8LQZk9bB439X3GC1MWSCI3tIcGt263t9Vxeo7/+nbTLYCGdwelqzaHNTQauZo/NRrcGHsNgCCIF+Gw3CqatgVYB8lMfxNrPQ4cebRJQqART8vKVFF/rf6n4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 08:05:53 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::68e3:e10a:8232:10e5]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::68e3:e10a:8232:10e5%5]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 08:05:53 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
        pierre-louis.bossart@linux.intel.com, daniel.baluta@gmail.com,
        laurentiu.mihalcea@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>
Subject: [PATCH 1/4] ASoC: SOF: compress: Remove byte offset computation
Date:   Wed, 17 Aug 2022 11:05:26 +0300
Message-Id: <20220817080529.10864-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220817080529.10864-1-daniel.baluta@oss.nxp.com>
References: <20220817080529.10864-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 698d4801-70c9-4ae5-44fe-08da80274e67
X-MS-TrafficTypeDiagnostic: AM9PR04MB7617:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7EkhFj6AT3/9t9zJJw9bZr71baUQAfHVmBsAXVt9U2qsNRuB6Qy+x2DSM68Z28cPvLpOZ1uauVSvD3edU6+Bxw9cde0sqjvfkf0lA219crt3avDFj8FD6w1DrOrejX/VnRfpToqlcNSdvRUwAL0/GS7TI4S7/xMqMLUP1nz/wX42djg/ULrhioUcKk3fTa4xSGGtN9bYIGK6x5CbI7IzGuiWZG4obDFiLWosdjB9OKuixptykYaRdqj60j6hp1dIUdnEB4BTWtZsJ3zoOUamiVUgFxXkZv2kpBFEl9CKjcXQpsrrDyYu9T9Ma126JfHw9Si6GRO/hyF5KMlfAwLyoWSU3gpmJwZQQCEMu9yU7BdZIWe1h3VVxBhiiFo7dvvKG5mIiyctKCl1KizEf/q3Ts6vtSUrzDXaJoAsPlljRh6lFX5Q1YPHJgXE2Rte34ehFD70Mm2aTXwnhBX8uG68bg73BIyK86A5pyq+MhEfi1MphBM1xDi1aFFIffgrtxslIk/uqMUfxKcDYBJX5QyDXLyhpDB49v4bErqx3hXxWHCC26ZsZVtSOze0B/ZR+WLdpDAz20LN3WJfxxTEnmIEvIukAs/vUkSzw9FPiDKitnbYMo+uFvLOSnT81Mj6Xj0zMdmq5M8bPtvPDbGsB6aHpUyssSYlOgnB2fNWavyh3D7VXEtypz4O74jTv0UwT3FPLgD0NhtPoOkpFYw9OWn80g2kO++OIiE+8263YZLjJl4U6FpQyLwCa6Q5ErJhG+HisK3/0LkevvhB0KEmTFwSaakunQ5WPZsEYPpbveAfgL6hzYLW415AZaULOL/Jy15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(8676002)(316002)(4326008)(66476007)(54906003)(4744005)(66556008)(66946007)(2906002)(44832011)(7416002)(8936002)(38100700002)(5660300002)(38350700002)(86362001)(186003)(41300700001)(6486002)(6506007)(52116002)(6666004)(26005)(6512007)(1076003)(83380400001)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RUtGX8t3clGgr+Jwk2dQ+iAK0JlLUUEf4Qo1OxYuW+D50bjt0YfxfGGukHuS?=
 =?us-ascii?Q?3nG3Fi/Ef4j3BYAbuPjpa5CWF60ymdrYfI2Cbr+9LUR/yTglSbHgRIK1hWC6?=
 =?us-ascii?Q?v5UoOxZFJ6SG5LmbsMrgtKLqOCFXh7rpzK1za1LAhwPWSKYV7Bc9FlZ/2whg?=
 =?us-ascii?Q?nPpEurzVWh65629XEenAPwOKBjWN2o+7yyn3Sal+wV6tWjLvd3gC4stpzHd8?=
 =?us-ascii?Q?nm+Hm2LyPU48Fv8Noh0blfym7QNONloj12GMLMFFRZD7d1KMhgLsRHQqjcVz?=
 =?us-ascii?Q?Q9aGqgFpUgAu4ta3Lwndqd8VEGQj3v3END40jp7hthXsLDKIuPsU54Y1PVyY?=
 =?us-ascii?Q?qruBi9KC9OgqxuT1eIazffbY8//l+iM8D45eUXmp6Xc/Xmsa6pwkquBhfWbv?=
 =?us-ascii?Q?ST8nP0Ipb4vgM+XcA5e53bPR4pWJ8MtHD4tmBNa7z3ocODPMEXMBbpZ0jEVm?=
 =?us-ascii?Q?TUUhZC4gW2a4PmNJbDzL8Me05e1EdlJZErr+uvsuwcu/A6o4g56aKnCiHo6Q?=
 =?us-ascii?Q?KWYJiUjSYQBFMst1xvlW3XAgmGj6lqYf9eH3cqZ3ehgY/UpXgz7C9M3PoP/d?=
 =?us-ascii?Q?qi+xof+CeOA2gVq8fSEyBbeC/c67rCW0hAmTVu4weqNVSV/574Hy3JEUDnYc?=
 =?us-ascii?Q?9zBcfe5aRzGi65bO/1PikXhTu3djj6oTeB4iy+MzSRndamRedmD8GPVhuNml?=
 =?us-ascii?Q?hJgPZjojyVOHp+6Fq0b9/DLbFUsaIb4kUKexc9Cg3zqhcR0IQfnP6TN2Capg?=
 =?us-ascii?Q?11p2OddCQhhd0qpEeaD805IyymvpDgg146wj18wSZFgztYcFtN6sqCQ8GrRV?=
 =?us-ascii?Q?T4mFUrKrhk/QKBGgMUh39ICfl6M054Hg2s2NdQAr51j4I5TjQRM0xZUWMzir?=
 =?us-ascii?Q?61vYVp2fvqBcl6RclqRZHU+ssSLjBJOTyT34aEk+DZ0OvD2/1mJPCBT0iwUZ?=
 =?us-ascii?Q?WwwlgkVpjSzaqQ8Kt7fWfkkCli77YW/Xl9ZUhU6yBkNH9YH+AlGMdToXWLC7?=
 =?us-ascii?Q?5zekpjNBFoWqb7S1Th9ia+DBLIE6PtwrC8nea9pNUG54N6pBPRC4CMRgTcBb?=
 =?us-ascii?Q?CdOf89FmYpGHV9i6MMVvFFZmrgrsVmIjPKXEXKXprwiwV39X3ho3saDUvMjV?=
 =?us-ascii?Q?CVlR0USBnvgsMBGNI3FuHUGDNRfuLJysS89kUrG9rG0uT8w6sdVBtrPP5t9/?=
 =?us-ascii?Q?35/xjfHdrCeUvVAXaW+hEEjvsM0rFk+2E6vX3FXM1vPOljzSuO3OhJpdOJ5e?=
 =?us-ascii?Q?92xFX07f64dOWN4f9DqgLQXPz33GuHwrq6irSgqDrxzsIa9FexJoiVKYp1Eu?=
 =?us-ascii?Q?8j7pQMAJqf/vhLWyl9+U3qJZmIMEoH+JXo9izPy6QHkUT9KDSsYhri1pXxJJ?=
 =?us-ascii?Q?tSGi9RnR406Semsv8lk8sw8xp2XDfi1yVJkAI4/TtShpwp0GLvumDsxKiiM0?=
 =?us-ascii?Q?7eiIKleAKzTWHMtkcLe864VlFyb8JWNGREEnPfYUk8gzWCvK20NZsz+42ume?=
 =?us-ascii?Q?JXd8bEzgA8oCHj5cTxr7Lj1zxrLLxSk3tbdlTqD8KKzUzXgcCdgtWHTMobhh?=
 =?us-ascii?Q?ZuiOUn9WzjSlCq1hn+Qg+LSosmK7T79oAdHGKF8L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698d4801-70c9-4ae5-44fe-08da80274e67
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 08:05:53.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pmtk9pDi9GuFZAZ1fYfVUW+xjFDxaDY2fXGlNO/LFR+iDNwa2iESngPfvDKPubXtKL3jWU6Oz5f3vPeYEa54Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7617
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Byte offset is the offset in the ring buffer to the DSP
while posn_offset is an offset inside the stream_box where
we keep position information.

Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/compress.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 67139e15f862..760d6a4a5253 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -237,7 +237,6 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 		goto out;
 	}
 
-	tstamp->byte_offset = sdev->stream_box.offset + ipc_params_reply.posn_offset;
 	tstamp->sampling_rate = params->codec.sample_rate;
 
 	spcm->prepared[cstream->direction] = true;
-- 
2.27.0

