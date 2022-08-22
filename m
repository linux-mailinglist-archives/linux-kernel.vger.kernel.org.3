Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEA159BD64
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 12:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiHVKNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 06:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiHVKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 06:13:39 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D53BF7B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 03:13:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrGL5ULBo8oAtyJYxtQO0hovAcQdqE3JH5g1kqwrQXmYsyuZi+9uuL6uDvDT0zWMo+yKM5TgeI2geDIKfrmT4H3mIbCEd9SVUS7PF/9cTHANLXGQz22xOeMOcdraVur3SuRFdJCzOMwaXFHeXolN1Gr5RN0N8d8l0M2AlCzzxoagIbxbVl8DJkkFG65CgkbuhhBtO3uTuv6jOREwaB1Nywy08VhbSmq1/gRgVUn05wSaX+UigoflWTmVhCIar68HIid/lZ5ZpYMOToim1qZWG2wsi7mb8UkY6OrCwrldWZF8NY9wyDmRXhoQ7EP8J9t5jp41QUkavEcl2YbHy3RKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iR1EL29NQ/hedgu50F3y7L38qEkGIk03MFj1BBcaddc=;
 b=bh/pXNaG36gWguiG1saNTCiHr9q/+evbcIje7XvHr9OzbI1+AQf/Qq4OnAysBcO+k4Onzi+5qrwmaexW15S2rVIMpGcb+nYHQ2bR39XEau/YH0zze1cPLd4R5/npSswAGVRztIsFIjK3CGsR3+kaGMdr2sk+v+8xzvJgTjpWa8SU0j3tVdxf8WuKRuqkTIXQThRfpdWySZsnp34iyW/JA1LfFceyvp5whhm4NOuKoUzoApuHe5LSegvvKBdmX2XKlXVltYGmh3hmaBD3/GKYfcBe/+OmhCVIUNrnk1qVSWXUEI+AEkkeAvSAcR4s3ixMIwUUmSxHjFPlx+l5h8w3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iR1EL29NQ/hedgu50F3y7L38qEkGIk03MFj1BBcaddc=;
 b=oeIBSorLKD3euCFozwJaoSpBxMWWRVigjSEYN1Y6HyVFvRU8dUm3KpsRBbl93ZV9xWc9yv2KgZMt8rCAGJX0ch9QS6FEEKok/WiHcfbnEY/0nwCs89wM8+fSBqr1EwVUChwk1sCXKeqckljG2+KpaM0tRIUlorZGD2ELZDrnC2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6607.eurprd04.prod.outlook.com (2603:10a6:803:121::19)
 by PA4PR04MB7645.eurprd04.prod.outlook.com (2603:10a6:102:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 10:13:35 +0000
Received: from VE1PR04MB6607.eurprd04.prod.outlook.com
 ([fe80::71f1:4e4c:c9c:bd9e]) by VE1PR04MB6607.eurprd04.prod.outlook.com
 ([fe80::71f1:4e4c:c9c:bd9e%4]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 10:13:35 +0000
From:   Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, kai.vehmanen@linux.intel.com,
        linux-kernel@vger.kernel.org,
        Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/2] ASoC: SOF: compress: Move sof_compr_copy functionality
Date:   Mon, 22 Aug 2022 13:15:01 +0300
Message-Id: <20220822101502.17644-2-laurentiu.mihalcea@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220822101502.17644-1-laurentiu.mihalcea@nxp.com>
References: <20220822101502.17644-1-laurentiu.mihalcea@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::14) To VE1PR04MB6607.eurprd04.prod.outlook.com
 (2603:10a6:803:121::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a533ff5-6abb-418c-8b9e-08da8426f927
X-MS-TrafficTypeDiagnostic: PA4PR04MB7645:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWoxbrNwSs6biNRP12QoYFpnvbsjYTIYJ3UktSKbCSOH9z8xEIX4WwXlYUXjfTx4nd9itEZyCrN9Lmdte01eiNtKYqAltiqtEQIt0mdxRwUlUaIOX4vS+yiXFoFn3QcqSeGq2HzLCSOUtGj+OrNm+VJZ5Afrf5Lod1Ms9ZpTBSfTrLWK4ILyQAFssIlrXoQYNGP7mfbkhQW4u4/k+GCBo5Rg4CkRlIzlXDfbfZKkjZW7+YRgg95gcgyVHvuUyKat9z/x0TpHw3k3HQ7si0NqLnsMweq/XEQJZgA0LCfkCqzlvKrp0aoHDxtpcTntW7X/QVY4UGxYixDpa7sX9A+91eQVan6nXzNSUYuOW6ooiC2CVPo7NcoP5Asrkd98EWCC0junvwyT83QTwZ+6gtCVeE/e3xueZzndJnBGGYGPppsXyq3lHzw7QFE8rhJ+TOfabQ2LUl6mzX8ZSkIcZ8IwIcPS8C+4gkgrJV82R2EMm+6z99R/evRPmKRA728ZOTUQH3ZwbcQSPhSByAib275dFLL6dxrIdzqP6Sj6Y7qf1zDEO7V6SawXTmqtcPs1Iy085KtDcDTWAzTuuLYAM072iBExM2uzcUdVsl1Fj49bX3u/SS8DIt9WkBupze7Fp2EPhwsQ7nQhVuliRs6J/wwQvJPLY+V00igpRc9N7KAosK81xQv/B8k4bQihroXxcvwg2bs5UZbXUleZvYer4qlTymW6wS5SDP/ELVpTwSL4xzyoN9Ozs0u9TBD8soQjwPkd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(66476007)(316002)(66556008)(66946007)(8676002)(4326008)(6486002)(38350700002)(38100700002)(54906003)(478600001)(36756003)(5660300002)(41300700001)(8936002)(186003)(1076003)(2616005)(83380400001)(44832011)(6666004)(52116002)(2906002)(6512007)(6506007)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zab/w7Oog9iAF3RwE8y4gvwYhrNI7mfVt0CUXz1auZSXW2co8gR9nHE/Tuvo?=
 =?us-ascii?Q?k4mpYMh0F8FnQ193AAsciVEmBY7twrddMQkzABpu524iqw9aaUzV9ijQxklB?=
 =?us-ascii?Q?9O2juAkFhld39SgRC9zeRFleLhJmJhqEbR//o0qWUObatjbTjiuby9KfnlF2?=
 =?us-ascii?Q?fnBiS61RcHGq1p30ju6q/DNDxws86AmyZxOMHPDNXxPcPmQfGg2b7GSJwe8O?=
 =?us-ascii?Q?6qRbKsJcZnNNPK/e52mmLnRobe87JlY2a2wzKsAVUNcDVkX0KRjrrf7LjfE8?=
 =?us-ascii?Q?MOz5bY+dFXCn4q7orOtD4g35nMYPeivOPnIHRje3RF6s8DS2i11YQI2D9Hq3?=
 =?us-ascii?Q?cSGbbYC3NeY0d/AtxEYKxWPACAuVOWa9+0TFtCMQLQLldH4ybfhC8WX49wWu?=
 =?us-ascii?Q?ArovgrVO6zg6TvYDupPhuBjcddSOS7oceCyrBkfGdory5Si/411fx0jmUCx9?=
 =?us-ascii?Q?C+dAJVLMFUCqf+vEvm6zUnRsOkGwhQZabUkIfZZdPD5AYl5dBXpB9jLast78?=
 =?us-ascii?Q?xHS/XpnbRQxHrhx8DE7m0f1s6QMBSp1EDumpnFxbLsLW/4hToFfToj44CIJ0?=
 =?us-ascii?Q?wYCyyGM/POVNQTOvofXkm/e5IABIS2OqKmqL3QZQjFZ+0NlhzYx0qevIXCkD?=
 =?us-ascii?Q?UK//s2kRDxYbpTwQTBJzXN62lhii6jXNHwPCH+2e58WFymtu3SnFrruzqjGj?=
 =?us-ascii?Q?yqYMtW9w0UH5OyZxTerU+87iSLWqNnAU2Gxsn+Q8+P1VkOMW3f9v0mkXCQVc?=
 =?us-ascii?Q?0Ewe9VbluBOZwWmcCuWDNfzC2C2ESrRatFcr/Hv0KqumQEUdHpQY6ktdH9T2?=
 =?us-ascii?Q?oJiJZnCeEpt64W2WtLAm9RuER54pOb5amT0PeywPMa4uBsvEzgAWRJSoGhvZ?=
 =?us-ascii?Q?tpO/y7YG9sDjTeSA2bi8+K4rxeohDFmGqKwIz8uYPG6AJaMCF3X+J9M/ZE1L?=
 =?us-ascii?Q?oEhi6b5ywHKH+E6DS907zdg1HHPUqRa4ryEUytkHlLLDOI9iA1t5vAtJuKME?=
 =?us-ascii?Q?TF8UNS1j256b4cbqSutWyU8DgsmDqfu8SzdyWvXgGsyaKeDX0wMMCXVxOdjY?=
 =?us-ascii?Q?G3giDHqck8T9nyvqspUbSzz9G+1/u+AN41Po5TRuBLX0yoA/od7qxgTBVuqh?=
 =?us-ascii?Q?GJedZOuwNzfxwmLA4+3fJgyGC0oxhsIHE9XSN5ijrb2vGtvEwIsYoNmYrRB9?=
 =?us-ascii?Q?BvcCznJSLqpuEeJoHkG8/eQmbJXTI58J2AOX3AHOllvnQqaC00QpKnRpyKrg?=
 =?us-ascii?Q?q8n0pc+3NVluYdDj9K1GWeGmdOxDlBheVi0HBoF6155mG8/opKyQd7C41ZSr?=
 =?us-ascii?Q?h7J9ATcC4EhnFnWG0DQwV4Bee458Jlf282h4UzzxC5wbJ/1hDMwEajQRI5qZ?=
 =?us-ascii?Q?oe1u1U8hziSrdtIBShBURUgevZZ7CS9AGTXTd4IAJCVFIC0Hbi+hwh7QRmFr?=
 =?us-ascii?Q?HEL6YbQkaMJEHNAhiN/TwR0c6QlM5myZ84inS22+Hjrw2pDD5uE0ecATNIEp?=
 =?us-ascii?Q?WqUPuG7eOsT1psrgo3A+5sIQOeduJegA6YXQIDDzvyYYgsbJ82fobsb3qbwt?=
 =?us-ascii?Q?z72dCEs+4MjTDEp/IdC7F4av3ECuAi85Zf2IuIyzmSZOZS+pCIa//rO34FpT?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a533ff5-6abb-418c-8b9e-08da8426f927
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 10:13:35.1182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgEv85v5a8ig2tDTci+CCmk90cxILpqb3o535G0Ed5sjh8GhbUTkmDjrBBWJLbdZaUsAL/XzQ2gs5OjK+rwQRveQzi4LfHkwyM3eshsUtdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7645
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're preparing to add support for compress capture,
we need to move the content of sof_compr_copy into a
separate function which handles the playback direction just
like the initial sof_compr_copy.

Reviewed-by: Paul Olaru <paul.olaru@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 sound/soc/sof/compress.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 174b3d8e67dd..1b0b8b43723b 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -297,18 +297,13 @@ static int sof_compr_trigger(struct snd_soc_component *component,
 				  &reply, sizeof(reply));
 }
 
-static int sof_compr_copy(struct snd_soc_component *component,
-			  struct snd_compr_stream *cstream,
-			  char __user *buf, size_t count)
+static int sof_compr_copy_playback(struct snd_compr_runtime *rtd,
+				   char __user *buf, size_t count)
 {
-	struct snd_compr_runtime *rtd = cstream->runtime;
-	unsigned int offset, n;
 	void *ptr;
+	unsigned int offset, n;
 	int ret;
 
-	if (count > rtd->buffer_size)
-		count = rtd->buffer_size;
-
 	div_u64_rem(rtd->total_bytes_available, rtd->buffer_size, &offset);
 	ptr = rtd->dma_area + offset;
 	n = rtd->buffer_size - offset;
@@ -323,6 +318,18 @@ static int sof_compr_copy(struct snd_soc_component *component,
 	return count - ret;
 }
 
+static int sof_compr_copy(struct snd_soc_component *component,
+			  struct snd_compr_stream *cstream,
+			  char __user *buf, size_t count)
+{
+	struct snd_compr_runtime *rtd = cstream->runtime;
+
+	if (count > rtd->buffer_size)
+		count = rtd->buffer_size;
+
+	return sof_compr_copy_playback(rtd, buf, count);
+}
+
 static int sof_compr_pointer(struct snd_soc_component *component,
 			     struct snd_compr_stream *cstream,
 			     struct snd_compr_tstamp *tstamp)
-- 
2.34.1

