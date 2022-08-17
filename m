Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E6F596B14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiHQIGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiHQIF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:05:59 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3912339B85
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSu+smIPt4fOlab3FBh83cVckRX8KyJbsNwOqgUGeeEGg1oTgLzYsqBktKRl3bTPBKE9e+z7ES4Oh+pbicbP6Vig11GIRnCIgh2qkq2Bv4leaRRXxO84XezH9525KFFgS8EiwCWMhyKRVE1VwdxdPkVrxRiG5qa4azdfh1EcMK+Z9HwPDl8fQYTD+7APt62Lt8cH/oOW3j07hBOVm/knQKrOFuPaHPH01w2eYYPBV4RTZJ39g+SZLrfSjUJhoiFn1JMhrEeqO9mcTGj4qKdqOFSskqOE91/DiVJww17hWcgIxnUrdJvsHBBNtbQao2nnkXBdOFlRhBIkABSkaPZ1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWWVJMpPl/MqDcxHnpDFV3ubvAG0DGhWmip0gI/eHxs=;
 b=EOsCQhHPBLHnIsoDTxZbb0yV2ompsX0B2wX0iHX2JzmXYLIyHECqbu3Isvji+e0HJlLbO2m+hpJm29RMDjB/GGFhZ+2RRou7teXPn06V9jPIeATSNoRd0jOAvpr88T4fKGBGAURWQaBitGjXR0sd98YLnBSGN67lMOnaGdZtq3BMW6tfn39Te11jOBzpY3ZIo+T0f4DCCBPEYIqt5eH8CwoVJM+4vdUa38o9QMCT88bPm1EOpgkX2IOrN21uJLxwSw7AGUw9iDCS/TqdQJCi671FEiAxFAfS3EMVVXvywQ+jJS4CVLDvOIJ4ZdYh8jT3cb3pPR/0t2eFCpUD4E1eUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWWVJMpPl/MqDcxHnpDFV3ubvAG0DGhWmip0gI/eHxs=;
 b=PtnVrJWle60FbbI+OOHN3CbmRIkiAYYOoTbjum8I1hWzgIMw1dgeo4pj/ZV9+wLi3F+d7Hq0CEwLe0qrD/p0QPa2TfT8xa6zYkczF3+UTwVof4iqcsdA02aDP8dExjE+ulseoxJlGf7oVzrWQ2KE/gArGzxVaG/12r9Qjn9BLxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 08:05:55 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::68e3:e10a:8232:10e5]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::68e3:e10a:8232:10e5%5]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 08:05:55 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
        pierre-louis.bossart@linux.intel.com, daniel.baluta@gmail.com,
        laurentiu.mihalcea@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>
Subject: [PATCH 2/4] ASoC: SOF: compress: Introduce sof_compr_stream
Date:   Wed, 17 Aug 2022 11:05:27 +0300
Message-Id: <20220817080529.10864-3-daniel.baluta@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4946b95f-c1d6-4209-4770-08da80274f72
X-MS-TrafficTypeDiagnostic: AM9PR04MB7617:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eRqA4ruhUBKYDghQL/Hxq8fUn2m3atDYtiARPYnEL2xR20mdj6/u+B1WT9cq0V5yDX+lFIbjTZrdoS4TQLQwRE4x3WhYbHpnJB/NlEuJx+jdayMXN+mMU9rwnlBOBlX7Wn5sDtDNcQc3g0VaNQ42t9ygmAiUnirBHCwhzpKlQI/vOEGhxWmYG2/OR/pTvAleSzvVHz4jD8a3OaqUd5K0xM3Vsz93mFzY9NXgNFZwyMscGB0KMbW/PVbu/zwNNwjuG8u/qIY0uYvNMUpKYrwX+4J/AZ+F2yWAYmnIImxZyu6g65r7tI1GintKVfDCpJASSd036iaw3bYEVCdxgoW6YW82Lb8kOo7PNQhOVr+U0BovVfcDstMt/Mcy7HqpkTbAWqS5ekRsxwg4UxoJyUlh30vsfDb9RLt91k8Nh/oC6s/ks52yf02jMl1avyI817n+su6yeJbSPHR/UCLi3t4NRLGE7jg3B45MK1ex7OM6d/urutdCnjNiMATrSUvxPnaUlfaEUOZE4Lne1Vw6B8x+zlcJPcvlnzbWdbNjsFC2ATTVP97cK9n83RYHW0Kvv8emChzGb+yHW8RWe19MwQOP+NkUf4MCmE4duAIf/xe5gtSFjJWD8nomyskk3A3CEm3ty2+ZxdhqvXiLswb0O8QuTwXUkcahRvW4ZIPSwUGyUf0wazvSVLhNXg4IW703E1xBWGEZSQd8cw03b6Vsoy5iYL2LAUW1YxRgrPAPqNo2CoDWw0X6zImekr5Y19TVDxmWkloO/kNWbb49Lgc/mIJhhY7WPx4EIQYFEqpwP4OcRgBxfTRCG7bnPImOBBw+HBDW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(8676002)(316002)(4326008)(66476007)(54906003)(66556008)(66946007)(2906002)(44832011)(7416002)(8936002)(38100700002)(5660300002)(38350700002)(86362001)(186003)(41300700001)(6486002)(6506007)(52116002)(6666004)(26005)(6512007)(1076003)(83380400001)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4blRDoqvfSHaRtRVO3EGCMm/vZVPv4+d1IUHps2Wb6AGwtDJzHXDhWiKKuw?=
 =?us-ascii?Q?Luoq32cdu5vz27koG9KHjXMNSvnbeCPCGL62lGE4cs9jkvqRuzTCaY03SJRy?=
 =?us-ascii?Q?n+XW0zmKN8Gy0Wfn5nbCxPC2TEbRvBgqgPShURgKvxyyPQc3kFftaiMleaz+?=
 =?us-ascii?Q?+jEmujMKJCqn+25zY2x6x0pyL6Xekt6v6WgM9yObpu+TrqFsC0jWW78fIwzN?=
 =?us-ascii?Q?ju8ylIgIe+vIOz2+aWQBA2oz1tqPmq+qb/PJ96iYQSJc6CbwqJBzl60G+0KA?=
 =?us-ascii?Q?vvcem94ogotruxhdiINyBPDw8Dfn/+MQ21Lm2NmjA4dJ/k2esIGwAkrHJ3ee?=
 =?us-ascii?Q?kwker6JIDaJMZJ9anVv9UPH+yGK5KrQILHkIFF0VpLPN1vsX7CB+XZQiU92t?=
 =?us-ascii?Q?EVDY4z4Qc6atsouzv6qf/MQQvro61RKzwjXc2gKNazt3KGo93Vs6eZQr5r28?=
 =?us-ascii?Q?a6N3DXFWWz1sMO9KmRtAUKTjIfK96pK9meBVajZ9QtD1Kjy7O5VXu/TpLwEY?=
 =?us-ascii?Q?jCaP3MFrt88OPz28sy3Ca9HCbiCtn7c1orUkeYE6hSDSl8fqeL6uCOcuJlT4?=
 =?us-ascii?Q?Taa429oSpr44krTwEhEFu0SPGGclPGJk6eZ4fQbBdJZ1SlCsN98BBWCpqpxU?=
 =?us-ascii?Q?bjx4/eJwsgAQpKbgNd7Hb0C8beUOvLSJoSoFV/9FOz0wli4AjJ8yuusmBBdd?=
 =?us-ascii?Q?4JV61R1EHDm1veV5jdVWNf7DRshXWC4gyH6uZ6k9rApeglzfPXZfui2YLFhP?=
 =?us-ascii?Q?sN/ViGv1APnDkPMru/lUsgC9oxiS55xAbOYIKzq2W6dboF/uOi/aUqhE+Kdo?=
 =?us-ascii?Q?WlFPcr2HsNL48l5gPVEc8LmI9gcEmtev3W6HcYtcLCNya8tZ7GT/94lmScwk?=
 =?us-ascii?Q?3zzya/ORLgsSeCN5eKjmYFTbqMrDbmd5XA2ircdIrKR+mgxXOOvDVlPfx5BD?=
 =?us-ascii?Q?5CmBvGZ7Pwzk20o556jbe+lPsafRvRQK4CDKl3GbLS9Eiyju36JtlVXThb2U?=
 =?us-ascii?Q?0/o4AJIKkGANwF+uw6np7MpBBktocb5mcsI3eGWVKyFDXb/IjqoS5exkCE/V?=
 =?us-ascii?Q?L67huIdVlaEzMmGBd2JjXwwN7QuhD6UPsfL/zV2knbOgROj62W+zvxFlLDun?=
 =?us-ascii?Q?qgyD6YBk6m1KSCqVmPLgN+tdzMu6F/3FkliqcMdBTh0Ipp7/J0sKqSxAvU0e?=
 =?us-ascii?Q?E5EZkM5BNp9h3ZXTcTW9VAAULbVrOxjllI+YSU5/TH/OAXGsCduwc944yyQ3?=
 =?us-ascii?Q?tINdeK223uUwwYNozK+kgfHaGsV0fU8jr+LXvngqMQ2EFk35ZL2NEfyqifCL?=
 =?us-ascii?Q?utju47GUAeJlyH0z0bNsU7sDGEbJLzs9HQL2wFeLx6wVCjog7nV1taTMl1EV?=
 =?us-ascii?Q?/hxrhkhUaJc7usO9qVAsN3LUq9ArhxT8ftakgr2eNd8/nsiKEfXHn/C871ym?=
 =?us-ascii?Q?/l0zEHjHw6AUlHKGZIOaKrei/Wh8RMfTRCzAUWBIXLoocnNJxBb9lfqIXOPj?=
 =?us-ascii?Q?A7MoscBZEyeww0FEoTMIxjiOQapSZHfK57hsiv1Kkci1ae4F/Du443koEpFx?=
 =?us-ascii?Q?pOCKd+1lAQ2/dXzMuKx+4947AnltGX1MSje3utev?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4946b95f-c1d6-4209-4770-08da80274f72
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 08:05:55.6003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNzvAl+Ho6tkXDlTYvL4MJZlHauXsodwJ3N2zrOrf1dj5xcmzkHYZwhUXe6BuLK80alE2DoFkgZhNfIpvQJnKQ==
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

This will keep SOF compress stream private data. So far
we used snd_compr_tstamp to hold the private data but this
is no longer enough as we need to hold other info like
number of channels or sample bytes.

Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/compress.c | 40 ++++++++++++++++++++--------------------
 sound/soc/sof/sof-priv.h |  5 +++++
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 760d6a4a5253..e990fa093bb5 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -11,20 +11,20 @@
 #include "sof-priv.h"
 #include "sof-utils.h"
 
-static void sof_set_transferred_bytes(struct snd_compr_tstamp *tstamp,
+static void sof_set_transferred_bytes(struct sof_compr_stream *sstream,
 				      u64 host_pos, u64 buffer_size)
 {
 	u64 prev_pos;
 	unsigned int copied;
 
-	div64_u64_rem(tstamp->copied_total, buffer_size, &prev_pos);
+	div64_u64_rem(sstream->copied_total, buffer_size, &prev_pos);
 
 	if (host_pos < prev_pos)
 		copied = (buffer_size - prev_pos) + host_pos;
 	else
 		copied = host_pos - prev_pos;
 
-	tstamp->copied_total += copied;
+	sstream->copied_total += copied;
 }
 
 static void snd_sof_compr_fragment_elapsed_work(struct work_struct *work)
@@ -49,7 +49,7 @@ void snd_sof_compr_fragment_elapsed(struct snd_compr_stream *cstream)
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_compr_runtime *crtd;
 	struct snd_soc_component *component;
-	struct snd_compr_tstamp *tstamp;
+	struct sof_compr_stream *sstream;
 	struct snd_sof_pcm *spcm;
 
 	if (!cstream)
@@ -57,7 +57,7 @@ void snd_sof_compr_fragment_elapsed(struct snd_compr_stream *cstream)
 
 	rtd = cstream->private_data;
 	crtd = cstream->runtime;
-	tstamp = crtd->private_data;
+	sstream = crtd->private_data;
 	component = snd_soc_rtdcom_lookup(rtd, SOF_AUDIO_PCM_DRV_NAME);
 
 	spcm = snd_sof_find_spcm_dai(component, rtd);
@@ -67,7 +67,7 @@ void snd_sof_compr_fragment_elapsed(struct snd_compr_stream *cstream)
 		return;
 	}
 
-	sof_set_transferred_bytes(tstamp, spcm->stream[cstream->direction].posn.host_posn,
+	sof_set_transferred_bytes(sstream, spcm->stream[cstream->direction].posn.host_posn,
 				  crtd->buffer_size);
 
 	/* use the same workqueue-based solution as for PCM, cf. snd_sof_pcm_elapsed */
@@ -96,24 +96,24 @@ static int sof_compr_open(struct snd_soc_component *component,
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_compr_runtime *crtd = cstream->runtime;
-	struct snd_compr_tstamp *tstamp;
+	struct sof_compr_stream *sstream;
 	struct snd_sof_pcm *spcm;
 	int dir;
 
-	tstamp = kzalloc(sizeof(*tstamp), GFP_KERNEL);
-	if (!tstamp)
+	sstream = kzalloc(sizeof(*sstream), GFP_KERNEL);
+	if (!sstream)
 		return -ENOMEM;
 
 	spcm = snd_sof_find_spcm_dai(component, rtd);
 	if (!spcm) {
-		kfree(tstamp);
+		kfree(sstream);
 		return -EINVAL;
 	}
 
 	dir = cstream->direction;
 
 	if (spcm->stream[dir].cstream) {
-		kfree(tstamp);
+		kfree(sstream);
 		return -EBUSY;
 	}
 
@@ -122,7 +122,7 @@ static int sof_compr_open(struct snd_soc_component *component,
 	spcm->stream[dir].posn.dai_posn = 0;
 	spcm->prepared[dir] = false;
 
-	crtd->private_data = tstamp;
+	crtd->private_data = sstream;
 
 	return 0;
 }
@@ -131,7 +131,7 @@ static int sof_compr_free(struct snd_soc_component *component,
 			  struct snd_compr_stream *cstream)
 {
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
-	struct snd_compr_tstamp *tstamp = cstream->runtime->private_data;
+	struct sof_compr_stream *sstream = cstream->runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct sof_ipc_stream stream;
 	struct sof_ipc_reply reply;
@@ -155,7 +155,7 @@ static int sof_compr_free(struct snd_soc_component *component,
 
 	cancel_work_sync(&spcm->stream[cstream->direction].period_elapsed_work);
 	spcm->stream[cstream->direction].cstream = NULL;
-	kfree(tstamp);
+	kfree(sstream);
 
 	return ret;
 }
@@ -169,7 +169,7 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 	struct sof_ipc_pcm_params_reply ipc_params_reply;
 	struct sof_ipc_fw_ready *ready = &sdev->fw_ready;
 	struct sof_ipc_fw_version *v = &ready->version;
-	struct snd_compr_tstamp *tstamp;
+	struct sof_compr_stream *sstream;
 	struct sof_ipc_pcm_params *pcm;
 	struct snd_sof_pcm *spcm;
 	size_t ext_data_size;
@@ -184,7 +184,7 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 		return -EINVAL;
 	}
 
-	tstamp = crtd->private_data;
+	sstream = crtd->private_data;
 
 	spcm = snd_sof_find_spcm_dai(component, rtd);
 
@@ -237,7 +237,7 @@ static int sof_compr_set_params(struct snd_soc_component *component,
 		goto out;
 	}
 
-	tstamp->sampling_rate = params->codec.sample_rate;
+	sstream->sampling_rate = params->codec.sample_rate;
 
 	spcm->prepared[cstream->direction] = true;
 
@@ -325,10 +325,10 @@ static int sof_compr_pointer(struct snd_soc_component *component,
 			     struct snd_compr_stream *cstream,
 			     struct snd_compr_tstamp *tstamp)
 {
-	struct snd_compr_tstamp *pstamp = cstream->runtime->private_data;
+	struct sof_compr_stream *sstream = cstream->runtime->private_data;
 
-	tstamp->sampling_rate = pstamp->sampling_rate;
-	tstamp->copied_total = pstamp->copied_total;
+	tstamp->sampling_rate = sstream->sampling_rate;
+	tstamp->copied_total = sstream->copied_total;
 
 	return 0;
 }
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 823583086279..42f112030fb8 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -105,6 +105,11 @@ enum sof_debugfs_access_type {
 	SOF_DEBUGFS_ACCESS_D0_ONLY,
 };
 
+struct sof_compr_stream {
+	u64 copied_total;
+	u32 sampling_rate;
+};
+
 struct snd_sof_dev;
 struct snd_sof_ipc_msg;
 struct snd_sof_ipc;
-- 
2.27.0

