Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B548D4B2020
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348009AbiBKI04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:26:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiBKI0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:26:51 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40079.outbound.protection.outlook.com [40.107.4.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E82E4B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:26:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIX6Tf74XfplN1/LxIYrrLPlzXhgxlbKjTJKuQTl/j2SVyzAIj0l1ZAQGb+YH4SLlUFy8UFfMQnaRkHKVcrmiO62hyvhMXVzZtcIR1EeK9tNj4LExD5WvFVx6Zrk+Q+dpEubboqa6VLb/kSzFONDTrXa9GUzDP0w3mHgVk/GQFV2tYurflaoQtsX2tVl2nYbDdiHXq3EkSTYvtm01FKon3aS1w4a8lMhq9K6Nht8QtmrKwN7MO0B1YpAaMJ4D3w0jhFOdO2YoPy1vnPXI0/RffwB8F628wdI63A0NhfzMxZhToJSU/Iqng+B690MaYb8wC2l13prGaFvzKqX/iekkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+4VY6o2rAvVwpae+4eXRJd8wMx7neoWEyuAclhSMV0=;
 b=Damwth167S1PoXOelo1jvw3gLYfewgLqv8VTtVweB1xrAK6SWdRgWG8xCMQgiQ9K6oty5QBhxsMqsOmzHj/5CRSXC6tq+IcRb4AKk7XocWb1Jtw0jAR8w6+AT53P+v2Vqn3zbWqf/lpt1ANWmbIcmmX5xVbmf+dI6vcC1X7fWVj/R2SDt9aR3IS1RwRONNPSDNtqmG8NjHRFmURlXRrz8Gg2LxsB8LYDzY3TN3WrgPSOcYVIvW88a5ANUrvZ8azaXqPaZUJHa1S1snT6bLfPKWmUDdQJ1mUVK2A1iYme675f3/czNUZ9GgtzR+WzkQC4HQqMxlz9NYhJebZugm2tZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+4VY6o2rAvVwpae+4eXRJd8wMx7neoWEyuAclhSMV0=;
 b=Zad8aGdMB+iWC7Z9cYWhOTouwk7uI8xugFrha7HLiHXvYPQ5xlkEWwUuwLlz3aB6ShB5M5q/BYjCPmerYmCQpbhcyG0pUB41IpiV5MaJ5TMMQ2mPuJr7PHKib5jv66VXRuQdTK1Fgtj18t0x4VANBoBPxdUxIJgOFxzUDxR5DPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by AS8PR04MB7815.eurprd04.prod.outlook.com (2603:10a6:20b:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 08:26:46 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::5004:926e:e5b:38c7]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::5004:926e:e5b:38c7%5]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 08:26:46 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, daniel.baluta@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: SOF: compr: Mark snd_compress_ops static
Date:   Fri, 11 Feb 2022 10:26:31 +0200
Message-Id: <20220211082631.179735-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0018.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::28) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e1d17c3-bb64-4a09-6be0-08d9ed383df6
X-MS-TrafficTypeDiagnostic: AS8PR04MB7815:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7815290258F906F539FF2AEAB8309@AS8PR04MB7815.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8zJKR8wwEBBZ5BnUR05mcOJNf5i20hyKi80oItB12HuobBrl64AHJpl7xTsjh8zcXjXa2AfNSEm/jAAOCk5nqD2V2Vf2M2CHBpVT+5N3gbdOCNGzE2+M9lTA4ja3kSFnXB1pDMK46kK89t6K/6Hztv9gOGgzkiVrxN0MqftR7CnZcgUve7bYJ8ug/BZ5HLHV8r2EAIF1Pkt5oiTvlSeH9zyaZPxrGJ9Lp1G6kS06qHqSeeuthv0knGh4dVwFjJTK35x7E7LahjZOz2m95cQ80xCcSoghT1ukcjIg+3zlq8z7m8NvSON+l9syuOhd0IqrrOD8TgtLxQVla2oA/ojVH8PeaIbsAQaumLNqtwlDDjvWo/foyvOIbPXZcBQASD83bQcJ5O+WcMGGR9EbIdE4MkVFfOTp2z3GSrL1HaNQwgqzpb83mBc1xO6ccr9q/qZoA2ufHVs/2QiDHNsEd4AL8TIDKnWx9uo5jAMjYUXgUxjZf7TKhys1AO9I9YaizWlzPbRPyKuBmit2U72p5SXg3iF8m0QoCzSbj4E9qJgtrl7tNILa/kDljQVXSDI5f8Tm8YZ5tQqwddQkedssk30G8gnuFRcSg1RaeQrXqWUQE9W9SmoGxDZyPwNPpd4Awzd13wSGdi9gVKmVMJkkCzgE4e3yBxFx7XPEUmkJGzJXVeZOiuIdNgWg+/qMr3PpPkD0qoaxUb8yC3HV5LsVgHZaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6666004)(86362001)(6512007)(66476007)(8936002)(8676002)(6506007)(66556008)(4326008)(508600001)(66946007)(1076003)(26005)(2616005)(316002)(186003)(44832011)(83380400001)(52116002)(38100700002)(6486002)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H72rIbVOSnFq/5r8h6M8gg9Mfpao2i4RPSn4/l6EORP5wfexPB+75Y4H52j2?=
 =?us-ascii?Q?4TMaHG53rT4gFl6TR8KYPMTue1p7m/Bt4vnnlaVbKqZNxqiPAArdytscbdLZ?=
 =?us-ascii?Q?TdwMthyqXHSlDE4/Oes8fH3jnu5w/KLudcFKUEg8asS/h0QbG6gY+CWM903h?=
 =?us-ascii?Q?k8wnYhzD8vVyuH++I2ltbw9liLGCc2HRp4F2DU4bGB96rPPvmyTxH4c7ejf4?=
 =?us-ascii?Q?sYeFb6UsJQMgvPQF9Cj1wDPC4k8UnDQJ8ZHniQDmFmCV5Sivhv48kEQH2P1y?=
 =?us-ascii?Q?Jnzv/2w2PMzJkqjFQpjQcaBzRtn0oNivA6+siZoiTK2zi0OfxNRWxEfJc0l+?=
 =?us-ascii?Q?9+3v4Y/e3X9NBnKEYkXu5n2QGGI7rzpjESNrKz5Z6esG6jnXspVY80Q3elLX?=
 =?us-ascii?Q?pzCw/Qyj2cfakRCwdARtiYZEVo0C4KUq90GcTURuBstwGyt25/e8VN5AEkfK?=
 =?us-ascii?Q?PZAjlJfT0T6JrvH8++hFcSc5wSUGXpjwRGmxV0NkGLnJaMQh2J6J5NqU+aaS?=
 =?us-ascii?Q?8/3dsMOWVG1eg9CKGk9ENpiC7YVApcOz6BrSyZtNJiRqRmUvigINeU+cGe2C?=
 =?us-ascii?Q?bqRStxiQdFG11LN3wwGEGlOSmGv2WXbbxyIXGSJvWgu7EPxxeKKg9K7ozo3K?=
 =?us-ascii?Q?KrnDNrT5AWCuEJacWCUEGt29+XI1fo/W8EIO8f2+oIWtpqvUE4iVo5sfavTg?=
 =?us-ascii?Q?x07ewGJm63endBBdUoG9HQHbOK++OSOSUQq+9NQYZafluoi6XJOZHQO0jMNb?=
 =?us-ascii?Q?T7bIAsvxyzGSLNHQEGAhg6EaavcpRiXdkyEBU+0CSYGZ1RfyT42FHqYbW17i?=
 =?us-ascii?Q?Wb5rM+R3m1fcQwjcJnH51nPkNdojl6NwWSDKYSKnE4hacHEzlrNk+Mctsygb?=
 =?us-ascii?Q?8WinrKEwBbf3iw63/Wz15fV+VOZ1iu1WeOnCqhNC1I+N2I/McVyoR5asBnCl?=
 =?us-ascii?Q?eu1O0pSUl7JrbgMgU57pgDJzdriqe2VtQEz8fuhFstTvRrJjJUaxUlaQhB6F?=
 =?us-ascii?Q?zYoXWF5q4qFxWFY8akCy4zxEIyctdzBHfT1RsXLcoz6WMyHj9NfNATeTZ/+b?=
 =?us-ascii?Q?dbsPWlw94TXNsTmKjE2Y+zzlGaMEetbiUZNVjIIA5UlkLwwSSs6gQ3G04Vr1?=
 =?us-ascii?Q?FrYRRtHgMYpmIxzYvgXB6+Bqg1DRKqBuKW5HGrnkYXcezp8+hraaRZtu8p9+?=
 =?us-ascii?Q?AS/vgnlTvhk0Stc0RQ03yk1QoWgIJU4I9ZJz8MtHK4F27STM+NZMivf52d1s?=
 =?us-ascii?Q?emd//GoW0wopxmVMvUGihlhIQo8EGOxJQSKk+ggMDr4DN2eOvNN6i1vmAO0+?=
 =?us-ascii?Q?qHZ2C+NAjW4pLLruzDoqhS5hKzAauNEnn+54E4CwvLZnreNo9sR8uUfUIZba?=
 =?us-ascii?Q?DNgrXTIyW+iutguuTf+O/id92tPO5Aa9wl0GrRDNlszla5NODHiAPxLzHz+g?=
 =?us-ascii?Q?XlnVpiyRY2zN5LsLwkOnO12ZzyAIn0fGXZhuOS59dixzeHdxkL9wNUJmR9Nx?=
 =?us-ascii?Q?c50U1W7iVMWBBK5E+6vpPkTPnFoviIgRhXKiCzLrHSI+kHzAEYvHqHr0qS5n?=
 =?us-ascii?Q?ZRPeq8RdXd2CrW30IcuP8I9xHomC/7f41Ew+I+ZQAqr0snhXabDPbb/SoF40?=
 =?us-ascii?Q?iJUUuDvniVoxGlVO38rZhbM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1d17c3-bb64-4a09-6be0-08d9ed383df6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 08:26:46.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHiVh/Ax0YWb4+5cZyK5W2K9A2+szCIID086euPsi+WwL508gYkoNcSFsvJ9FLZH8x5B0zzIa+fZRiopbhz+BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7815
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Functions won't be directly used outside of compress.c file
so mark them as static.

This will also fix warnings reported by kernel test robot:

>> sound/soc/sof/compress.c:91:5: warning: no previous prototype for
function 'sof_compr_open' [-Wmissing-prototypes]
   int sof_compr_open(struct snd_soc_component *component,
       ^
   sound/soc/sof/compress.c:91:1: note: declare 'static' if the function
is not intended to be used outside of this translation unit
   int sof_compr_open(struct snd_soc_component *component,

Fixes: 6324cf901e14 ("SoC: SOF: compr: Add compress ops implementation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/compress.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 2137d1d65dd9..2af8d75204e9 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -89,8 +89,8 @@ static int create_page_table(struct snd_soc_component *component,
 					 spcm->stream[dir].page_table.area, size);
 }
 
-int sof_compr_open(struct snd_soc_component *component,
-		   struct snd_compr_stream *cstream)
+static int sof_compr_open(struct snd_soc_component *component,
+			  struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_compr_runtime *crtd = cstream->runtime;
@@ -125,8 +125,8 @@ int sof_compr_open(struct snd_soc_component *component,
 	return 0;
 }
 
-int sof_compr_free(struct snd_soc_component *component,
-		   struct snd_compr_stream *cstream)
+static int sof_compr_free(struct snd_soc_component *component,
+			  struct snd_compr_stream *cstream)
 {
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
 	struct snd_compr_tstamp *tstamp = cstream->runtime->private_data;
@@ -159,8 +159,8 @@ int sof_compr_free(struct snd_soc_component *component,
 	return ret;
 }
 
-int sof_compr_set_params(struct snd_soc_component *component,
-			 struct snd_compr_stream *cstream, struct snd_compr_params *params)
+static int sof_compr_set_params(struct snd_soc_component *component,
+				struct snd_compr_stream *cstream, struct snd_compr_params *params)
 {
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
@@ -222,8 +222,8 @@ int sof_compr_set_params(struct snd_soc_component *component,
 	return 0;
 }
 
-int sof_compr_get_params(struct snd_soc_component *component,
-			 struct snd_compr_stream *cstream, struct snd_codec *params)
+static int sof_compr_get_params(struct snd_soc_component *component,
+				struct snd_compr_stream *cstream, struct snd_codec *params)
 {
 	/* TODO: we don't query the supported codecs for now, if the
 	 * application asks for an unsupported codec the set_params() will fail.
@@ -231,8 +231,8 @@ int sof_compr_get_params(struct snd_soc_component *component,
 	return 0;
 }
 
-int sof_compr_trigger(struct snd_soc_component *component,
-		      struct snd_compr_stream *cstream, int cmd)
+static int sof_compr_trigger(struct snd_soc_component *component,
+			     struct snd_compr_stream *cstream, int cmd)
 {
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
@@ -271,9 +271,9 @@ int sof_compr_trigger(struct snd_soc_component *component,
 				  &reply, sizeof(reply));
 }
 
-int sof_compr_copy(struct snd_soc_component *component,
-		   struct snd_compr_stream *cstream,
-		   char __user *buf, size_t count)
+static int sof_compr_copy(struct snd_soc_component *component,
+			  struct snd_compr_stream *cstream,
+			  char __user *buf, size_t count)
 {
 	struct snd_compr_runtime *rtd = cstream->runtime;
 	unsigned int offset, n;
-- 
2.27.0

