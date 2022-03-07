Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D644D0817
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245212AbiCGUBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbiCGUBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:01:44 -0500
X-Greylist: delayed 771 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Mar 2022 12:00:47 PST
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496B67E581
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:00:46 -0800 (PST)
Received: from 104.47.1.53_.trendmicro.com (unknown [172.21.10.208])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 2A3AE1025CC76
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:47:57 +0000 (UTC)
Received: from 104.47.1.53_.trendmicro.com (unknown [172.21.168.86])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 885F910000099;
        Mon,  7 Mar 2022 19:47:55 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1646682474.957000
X-TM-MAIL-UUID: b59241d4-0d33-46da-90b8-651d6262293e
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (unknown [104.47.1.53])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id E9C6A100011DA;
        Mon,  7 Mar 2022 19:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abD6WfGnQ/py3hzrjgIwldgg6qED+7hF7JXos4ThWRPvnd9seUd8j6dXfBGsE9CRjNuGGBrwZ5WEBHWQpS0zqW9HJs/upgHRusdnA9SrM9l5XY70B8HE4d7iQluDapZDY/gW6vQL90OPyH/3W86p1y2ETZGPIzYDJGe5i8Anqn0nlKkSS68Xf++onlsIULGTCi2SAFPi+ReUvG5/KDCETpDq1NMkeVoJCVph+zWEWNZMh24lvtS5ATJ6bUgRkoXcc8yzDZl8jxUc9iX3QRarDeAA1X00XiLPOG6W2o8OGlF6AzAuh2etWFnOmnTEPn5oVY0dd/HOMlJtzq4JOL43RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuvY2z6NqstpeXVe5oGYpqU+tHORyOTcDnT3Dnp1/HQ=;
 b=njCoaEaSyRqRoqi+v+vf3+QRxSMwiSpoThqLJIoyRjeyiXLwf7n2BlkJk98ceH6mtPB8/+cj9KcqzP2A3Pe2IpFZu+waq1sgFw+LCuZwtATfibrOoUIRVSpmyiV+Cfixnak6ilRbTllaHnvMEPijfgt+jF1Xt60SqVVDtpLhFPqeZWHwKjQNeVu91PRhxAdhM/FogSFriJEOQXQllH0A/3T49Jc5OMhyUfK/JAHmh4EG4T9jXEvlUAo8yRhBhRzdmPRKhIbjJ6YHCyjnhu/4dj9wMHetWaJINjs84L0Alrpf93h4W4czw+B08dc0RHo4MffnpiIutpwgwvpmhCE9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
To:     virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc:     Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ALSA: virtio: add support for audio controls
Date:   Mon,  7 Mar 2022 20:47:15 +0100
Message-Id: <20220307194716.1517565-2-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307194716.1517565-1-anton.yakovlev@opensynergy.com>
References: <20220307194716.1517565-1-anton.yakovlev@opensynergy.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR1001CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::17) To AM0PR04MB5891.eurprd04.prod.outlook.com
 (2603:10a6:208:12e::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbd0940a-04ea-4abe-56a8-08da00735e8f
X-MS-TrafficTypeDiagnostic: HE1PR04MB3210:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB32101F6AAF8A477A6A8E40B08D089@HE1PR04MB3210.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYeW/459fLF1Y6h96XmI55vC0emIwROVOUegcOdo0O6GnePxRgsThDFmF5/VW9PZ7AfNfOshetyucPHkev5AH0eZ24lDHBZ2lECwFCGzOgDCAfyyKj5Tv9bzqLLzawWSY2/hQXO9PDZEL4EiWSkHUtrsnd94YMdL4ihUzbnL7bdtruNZ/4GOVFyzXghb4pLOb/koNrSi1qGy5Ty3LHg1i1AKFK/SP8TOuUDMUM6071i5Wt1xtGcnukWj3J632p0EWrfow8q7nynVCbvMsuFX1bYCln/OBRu/uRVWo0TjFhKtiIgfzv+Ecl0QYyujxQsCSTKqZjU6RlSW3/H35igAoMyxPTdcik2I5QsIPd3MuJnqtf85z0kcxaLvuh5MmGO5XKgdThftuQCMSNc0hn7awi2ALqObCaLou6JPMoyEyH+6/IwC4AEm508QpZf24m2yUqr+ZW/N04EbhaoJ213cShouqfgBRja6haxdeSivy5NQXVT/cP8Lyv0PYsq+lujt2lR9Lq9NzRGfjp7FFPMj1RXRkRojzALirj4eedWIPd0+HFJ5j5HGSlC4+iAjQS80psGdFzExfsZN/hGO+Fr3d4iqehFpo1yRgLksG3Ar39PQBtHOZNcLSOX55TCqSx04E1n4oVFrfIhCUdECNzP4IQfqgBRHuxM1O1gzCuCnqDUOojjui6MptcSbabnK5/rs2WI6WKbF1p/uBf13ErJqiZoilRwD8a9R949YgDDebzU5d7mmo/ggHICpKWOhigHgKEyqRtm9mbmSAlDM2H2d30nWhV4xsOe3V2jmekSsBFZ10pcHYyOBbM+zxpaC0tE/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5891.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(966005)(8936002)(8676002)(4326008)(66946007)(66476007)(66556008)(2906002)(52116002)(30864003)(86362001)(38100700002)(316002)(42186006)(83380400001)(38350700002)(26005)(1076003)(186003)(508600001)(5660300002)(44832011)(2616005)(54906003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?biaEI2Rg5waJl2ujgoDZ048HO2+bLAIFmK/WdK/m3YDLYbZmzhP+rX+C+qcd?=
 =?us-ascii?Q?1vqN+kSsX3DNF+p/VNSWfTcCpdQdGTRAec5s6m2yuzRAFSGJM2Jna/ny8YS1?=
 =?us-ascii?Q?TwgGAWaaBQ5sLpwLp53kQilPuO/EtIY4ZgxMxGJuhWqsepr3YiM2+Mpzk14f?=
 =?us-ascii?Q?d47GQc2Ey4lh672m5G6rY77eDNSUO/awmG5cIEZxgsRVU1LNQUBj/OPSVsoD?=
 =?us-ascii?Q?16f1DHluAiFmN4dxFBp9WmfNdxH0F3CgntykckxUoWv5PAaU3CEiXkOnSm/u?=
 =?us-ascii?Q?qE4z5r0SY3lzleYENb1FGnJ0yc/BIxEFhoExMmiLGIGJAlhAJ2zQS2Lt1Xuo?=
 =?us-ascii?Q?/A56WvoGzv5vIkJeHQMmygWckIJUa+88F95/LAjR5naMjY8FvzyU/RgTntpo?=
 =?us-ascii?Q?B0LCVAFSHQ9NggjcDU/Zrkx+Ff1U8xzDuk/kZU+FBV6JQgFdgtAVwuezlzww?=
 =?us-ascii?Q?g5SbyjaMMnbddq9xHrp0vDgQfOPIBvoOtNN/bSTWg/o5X4uoPm4K952LcOl5?=
 =?us-ascii?Q?1Uv9/Bdmvbv5ChiMbFNpOO26FIU3lwbW1SFxVHGcWvWeEfo9s/TFgiK96+F/?=
 =?us-ascii?Q?rHly3ym6+oMPeTHNXPMwDbst08QtoC4ABvsecR+RR5uXjIN3vF1u7n6sQEqD?=
 =?us-ascii?Q?4EUcyP7vmU+I/vMgiQQDnQReLe+3xyB5hmOt0LSTw+66iHA+Lms9lxxi9T91?=
 =?us-ascii?Q?wehHFVyQUmcGIUs/moJT83wdmotwIE1vK9sAAn0ld+XkZAYUVYk3lN4UjrlA?=
 =?us-ascii?Q?v/EuJRfIbTZ23zP2zqjAMZWCllQATXQIB8GcZ+MvxHoBH5JrPOJku6d4QMOD?=
 =?us-ascii?Q?Me3sQIoLCc7aXAPakMXEm7Q4oSz5B9qVzNvuASxxs/4i/PniJQqT6eHucZ+G?=
 =?us-ascii?Q?ovguSkWi5WBli/+jufFqoZQXMyZas4r1MuMAtvIissjBfruP3IA+MwQISysk?=
 =?us-ascii?Q?5jfz2Fnz7548tzVz66KSXKzc47pdmPz99S7yxqO9knrujv0SUEEMcqzuwbpY?=
 =?us-ascii?Q?K+tgxjGGM7sMeWpqj3jLi95JUDjSAy9uMvVd2Gf9mI+6ubKAOx+SSw80MqCN?=
 =?us-ascii?Q?epTvNX4BdE+VaaUKwiVB1RLda97SfRWUXvwNJ0r6aUXWgNe15uc2vOoVpf6u?=
 =?us-ascii?Q?0VE4aRsGrFvOsAi5PkFa/l/wQM/7Bs0oxKPSf3CEugmfMxCtHF5b+f1ApkEe?=
 =?us-ascii?Q?AONoLKshaXqkmtAzIR+oxm2P/4Stmkz2NfaQybnfvNLHOB6YAypFLYmrP2Rm?=
 =?us-ascii?Q?fUe1YCecTmUDjyCXKYotqh10vVju894zIzy8yMzycrEGWTQ4ZaHVCEk4fp2T?=
 =?us-ascii?Q?GJDjhCObSdWhfuWpEfhYf5KbBuSNkSAbeVSJoNxRZ+ktZ85TLtvfHiR0pmRD?=
 =?us-ascii?Q?+76sVt4Hn5xQffImsBO+gGX15CpPqvGAMKDnMHJFHzI/w6XNsE5B5axMf3JX?=
 =?us-ascii?Q?+tXNvIe6hOZCqD+90S4zGeVa3pEXXeRVDfPH016VIlYuXHX0XCRalrGl0Tr3?=
 =?us-ascii?Q?EydCcpxIHZSGTIFioMxyPdIzV3mVm+eqzHeiBLOFCmRAPrJhehluNe0KYW/D?=
 =?us-ascii?Q?V21ajdZZb6VXxwREmvrIk1dP3vCr8f22rY1KqXfcPMWnwiysFvTCaJg/drem?=
 =?us-ascii?Q?1LMgpLlq69BDIrGsS9Ks0gs=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd0940a-04ea-4abe-56a8-08da00735e8f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5891.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 19:47:53.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUUla3VaFMzD9Dxhdigiypx22cRnqH6YYCcv9ueZl08P1C5N//qPzbVJEP4Up1VTU6JrUC458sjBELJ48EHgYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3210
X-TM-AS-ERS: 104.47.1.53-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26758.002
X-TMASE-Result: 10--27.434200-4.000000
X-TMASE-MatchedRID: QkBk6NM3bYkJjCNolxOpSRFbgtHjUWLy0bdjqKOoG3cpurQKRyCSC/MI
        NXcIwLY+L2EYbInFI5sj9UCLTHyvuM2xBiOieygkb/oIJuUAIuFZDdHiTk9OcCxMw0FMkBlZK7m
        JD0QzrgRntI1EQdgdET2H0NTsYyE4d4yyDWGwM4b9QfnpVLoxlgeK93mzhKdFX30pMm+iz0h1N6
        CkrtCdcVIeZmiiCQMf5p98cjyQCaKgKIcGQclMlr9A3Bl1/DcVjlRp8uau9oYO2jNO6qqUWylfT
        GxFF4SxdfnosVrzNz3Olrk3M/IDPKlnRUJEkD40fUkgDiuGxn9pkBMYDn8FeDclhAqYjfRnOcY/
        jkDGKiKwcLLU2//UpRcfV2p41YOpFlh98BIUXtILsPjFXByaSvlSepWcgdLPF45HquLQw3jdZii
        xSw6RgZjY5FaoNLuDSaGNrMgEu1ws8AejW2/5AQrcxrzwsv5uUrr7Qc5WhKhR965L821jzHlbNL
        JMhGkt/LF6HmtZY72GFT1Fsy+CXUPFZL7uftIdKiJEqUFWRggyhLY8urUHvskHbDtTC/XbILMvr
        u9XoSs45PBNB8uybffPBI3wIcRmlwV2iaAfSWcURSScn+QSXt0H8LFZNFG7JQhrLH5KSJ0=
X-TMASE-XGENCLOUD: 7c01af79-62ff-4628-a668-edad408a8ec2-0-0-200-0
X-TM-Deliver-Signature: 41A141EBCCB9DA50C59B5242498DAE39
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1646682475;
        bh=0XYq4g1AhiOSmFZ/lLVcu8iJR4HQ6D6WGVqWJiTK6yQ=; l=24328;
        h=From:To:Date;
        b=zwbtpR7T/6VQhgNwSAItQlMSGWJif+QMSlhlX0oHvy+UT2EvMj3MAt/O8WDY6ODL0
         rsBLFuCAejxNo3EZsmDdC+PkFZ68Tb3Mwn+lUnmGa7OFrwKLjej66a7rZNM1a16l+S
         tAjrYg2tjOqYNUENaP4o2Ono4cCG16yz/GVDtZRjYWY2nLsefn1q27FvLVvEU5zvSG
         5OOX9bW87FhfKwmG6sNvFr7/y0lf6PGo6G5HEA+e7IA3U49nFm0cZv+ngrzMT5XNQH
         ux+5RWZMTGvYkZPbgIHhj0kb+cxBA0w/hS8HNI7saAo0oFeQHMejB8x+dKTLAaQ8Jc
         LXAAYqTKvtWgw==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of support for audio controls in accordance with the
proposed extension of the virtio sound device specification [1].

The device can announce the VIRTIO_SND_F_CTLS feature. If the feature is
negotiated, then an additional field appears in the configuration space:

  struct virtio_snd_config {
    ...
    /* number of available control elements */
    __le32 controls;
  };

The driver can send the following requests to manage audio controls:

  enum {
    ...
    /* control element request types */
    VIRTIO_SND_R_CTL_INFO = 0x0300,
    VIRTIO_SND_R_CTL_ENUM_ITEMS,
    VIRTIO_SND_R_CTL_READ,
    VIRTIO_SND_R_CTL_WRITE,
    VIRTIO_SND_R_CTL_TLV_READ,
    VIRTIO_SND_R_CTL_TLV_WRITE,
    VIRTIO_SND_R_CTL_TLV_COMMAND,
    ...
  };

And the device can send the following audio control event notification:

  enum {
    ...
    /* control element event types */
    VIRTIO_SND_EVT_CTL_NOTIFY = 0x1200,
    ...
  };

See additional details in [1].

[1] https://lists.oasis-open.org/archives/virtio-comment/202104/msg00013.html

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 include/uapi/linux/virtio_snd.h | 154 +++++++++++
 sound/virtio/Makefile           |   1 +
 sound/virtio/virtio_card.c      |  21 ++
 sound/virtio/virtio_card.h      |  22 ++
 sound/virtio/virtio_kctl.c      | 464 ++++++++++++++++++++++++++++++++
 5 files changed, 662 insertions(+)
 create mode 100644 sound/virtio/virtio_kctl.c

diff --git a/include/uapi/linux/virtio_snd.h b/include/uapi/linux/virtio_snd.h
index dfe49547a7b0..5f4100c2cf04 100644
--- a/include/uapi/linux/virtio_snd.h
+++ b/include/uapi/linux/virtio_snd.h
@@ -7,6 +7,14 @@
 
 #include <linux/virtio_types.h>
 
+/*******************************************************************************
+ * FEATURE BITS
+ */
+enum {
+	/* device supports control elements */
+	VIRTIO_SND_F_CTLS = 0
+};
+
 /*******************************************************************************
  * CONFIGURATION SPACE
  */
@@ -17,6 +25,8 @@ struct virtio_snd_config {
 	__le32 streams;
 	/* # of available channel maps */
 	__le32 chmaps;
+	/* # of available control elements */
+	__le32 controls;
 };
 
 enum {
@@ -55,6 +65,15 @@ enum {
 	/* channel map control request types */
 	VIRTIO_SND_R_CHMAP_INFO = 0x0200,
 
+	/* control element request types */
+	VIRTIO_SND_R_CTL_INFO = 0x0300,
+	VIRTIO_SND_R_CTL_ENUM_ITEMS,
+	VIRTIO_SND_R_CTL_READ,
+	VIRTIO_SND_R_CTL_WRITE,
+	VIRTIO_SND_R_CTL_TLV_READ,
+	VIRTIO_SND_R_CTL_TLV_WRITE,
+	VIRTIO_SND_R_CTL_TLV_COMMAND,
+
 	/* jack event types */
 	VIRTIO_SND_EVT_JACK_CONNECTED = 0x1000,
 	VIRTIO_SND_EVT_JACK_DISCONNECTED,
@@ -63,6 +82,9 @@ enum {
 	VIRTIO_SND_EVT_PCM_PERIOD_ELAPSED = 0x1100,
 	VIRTIO_SND_EVT_PCM_XRUN,
 
+	/* control element event types */
+	VIRTIO_SND_EVT_CTL_NOTIFY = 0x1200,
+
 	/* common status codes */
 	VIRTIO_SND_S_OK = 0x8000,
 	VIRTIO_SND_S_BAD_MSG,
@@ -331,4 +353,136 @@ struct virtio_snd_chmap_info {
 	__u8 positions[VIRTIO_SND_CHMAP_MAX_SIZE];
 };
 
+/*******************************************************************************
+ * CONTROL ELEMENTS MESSAGES
+ */
+struct virtio_snd_ctl_hdr {
+	/* VIRTIO_SND_R_CTL_XXX */
+	struct virtio_snd_hdr hdr;
+	/* 0 ... virtio_snd_config::controls - 1 */
+	__le32 control_id;
+};
+
+/* supported roles for control elements */
+enum {
+	VIRTIO_SND_CTL_ROLE_UNDEFINED = 0,
+	VIRTIO_SND_CTL_ROLE_VOLUME,
+	VIRTIO_SND_CTL_ROLE_MUTE,
+	VIRTIO_SND_CTL_ROLE_GAIN
+};
+
+/* supported value types for control elements */
+enum {
+	VIRTIO_SND_CTL_TYPE_BOOLEAN = 0,
+	VIRTIO_SND_CTL_TYPE_INTEGER,
+	VIRTIO_SND_CTL_TYPE_INTEGER64,
+	VIRTIO_SND_CTL_TYPE_ENUMERATED,
+	VIRTIO_SND_CTL_TYPE_BYTES,
+	VIRTIO_SND_CTL_TYPE_IEC958
+};
+
+/* supported access rights for control elements */
+enum {
+	VIRTIO_SND_CTL_ACCESS_READ = 0,
+	VIRTIO_SND_CTL_ACCESS_WRITE,
+	VIRTIO_SND_CTL_ACCESS_VOLATILE,
+	VIRTIO_SND_CTL_ACCESS_INACTIVE,
+	VIRTIO_SND_CTL_ACCESS_TLV_READ,
+	VIRTIO_SND_CTL_ACCESS_TLV_WRITE,
+	VIRTIO_SND_CTL_ACCESS_TLV_COMMAND
+};
+
+struct virtio_snd_ctl_info {
+	/* common header */
+	struct virtio_snd_info hdr;
+	/* element role (VIRTIO_SND_CTL_ROLE_XXX) */
+	__le32 role;
+	/* element value type (VIRTIO_SND_CTL_TYPE_XXX) */
+	__le32 type;
+	/* element access right bit map (1 << VIRTIO_SND_CTL_ACCESS_XXX) */
+	__le32 access;
+	/* # of members in the element value */
+	__le32 count;
+	/* index for an element with a non-unique name */
+	__le32 index;
+	/* name identifier string for the element */
+	__u8 name[44];
+	/* additional information about the element's value */
+	union {
+		/* VIRTIO_SND_CTL_TYPE_INTEGER */
+		struct {
+			/* minimum supported value */
+			__le32 min;
+			/* maximum supported value */
+			__le32 max;
+			/* fixed step size for value (0 = variable size) */
+			__le32 step;
+		} integer;
+		/* VIRTIO_SND_CTL_TYPE_INTEGER64 */
+		struct {
+			/* minimum supported value */
+			__le64 min;
+			/* maximum supported value */
+			__le64 max;
+			/* fixed step size for value (0 = variable size) */
+			__le64 step;
+		} integer64;
+		/* VIRTIO_SND_CTL_TYPE_ENUMERATED */
+		struct {
+			/* # of options supported for value */
+			__le32 items;
+		} enumerated;
+	} value;
+};
+
+struct virtio_snd_ctl_enum_item {
+	/* option name */
+	__u8 item[64];
+};
+
+struct virtio_snd_ctl_iec958 {
+	/* AES/IEC958 channel status bits */
+	__u8 status[24];
+	/* AES/IEC958 subcode bits */
+	__u8 subcode[147];
+	/* nothing */
+	__u8 pad;
+	/* AES/IEC958 subframe bits */
+	__u8 dig_subframe[4];
+};
+
+struct virtio_snd_ctl_value {
+	union {
+		/* VIRTIO_SND_CTL_TYPE_BOOLEAN|INTEGER value */
+		__le32 integer[128];
+		/* VIRTIO_SND_CTL_TYPE_INTEGER64 value */
+		__le64 integer64[64];
+		/* VIRTIO_SND_CTL_TYPE_ENUMERATED value (option indexes) */
+		__le32 enumerated[128];
+		/* VIRTIO_SND_CTL_TYPE_BYTES value */
+		__u8 bytes[512];
+		/* VIRTIO_SND_CTL_TYPE_IEC958 value */
+		struct virtio_snd_ctl_iec958 iec958;
+	} value;
+};
+
+/* supported event reason types */
+enum {
+	/* element's value has changed */
+	VIRTIO_SND_CTL_EVT_MASK_VALUE = 0,
+	/* element's information has changed */
+	VIRTIO_SND_CTL_EVT_MASK_INFO,
+	/* element's metadata has changed */
+	VIRTIO_SND_CTL_EVT_MASK_TLV
+};
+
+struct virtio_snd_ctl_event {
+	/* VIRTIO_SND_EVT_CTL_NOTIFY */
+	struct virtio_snd_hdr hdr;
+	/* 0 ... virtio_snd_config::controls - 1 */
+	__le16 control_id;
+	/* event reason bit map (1 << VIRTIO_SND_CTL_EVT_MASK_XXX) */
+	__le16 mask;
+};
+
 #endif /* VIRTIO_SND_IF_H */
diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index 2742bddb8874..a839f8c8b5e6 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -7,6 +7,7 @@ virtio_snd-objs := \
 	virtio_chmap.o \
 	virtio_ctl_msg.o \
 	virtio_jack.o \
+	virtio_kctl.o \
 	virtio_pcm.o \
 	virtio_pcm_msg.o \
 	virtio_pcm_ops.o
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index e2847c040f75..61df3476cf70 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -64,6 +64,9 @@ static void virtsnd_event_dispatch(struct virtio_snd *snd,
 	case VIRTIO_SND_EVT_PCM_XRUN:
 		virtsnd_pcm_event(snd, event);
 		break;
+	case VIRTIO_SND_EVT_CTL_NOTIFY:
+		virtsnd_kctl_event(snd, event);
+		break;
 	}
 }
 
@@ -235,6 +238,12 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 	if (rc)
 		return rc;
 
+	if (virtio_has_feature(vdev, VIRTIO_SND_F_CTLS)) {
+		rc = virtsnd_kctl_parse_cfg(snd);
+		if (rc)
+			return rc;
+	}
+
 	if (snd->njacks) {
 		rc = virtsnd_jack_build_devs(snd);
 		if (rc)
@@ -253,6 +262,12 @@ static int virtsnd_build_devs(struct virtio_snd *snd)
 			return rc;
 	}
 
+	if (snd->nkctls) {
+		rc = virtsnd_kctl_build_devs(snd);
+		if (rc)
+			return rc;
+	}
+
 	return snd_card_register(snd->card);
 }
 
@@ -419,10 +434,16 @@ static const struct virtio_device_id id_table[] = {
 	{ 0 },
 };
 
+static unsigned int features[] = {
+	VIRTIO_SND_F_CTLS
+};
+
 static struct virtio_driver virtsnd_driver = {
 	.driver.name = KBUILD_MODNAME,
 	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
 	.validate = virtsnd_validate,
 	.probe = virtsnd_probe,
 	.remove = virtsnd_remove,
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index 86ef3941895e..3ceee4e416fc 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -31,6 +31,16 @@ struct virtio_snd_queue {
 	struct virtqueue *vqueue;
 };
 
+/**
+ * struct virtio_kctl - VirtIO control element.
+ * @kctl: ALSA control element.
+ * @items: Items for the ENUMERATED element type.
+ */
+struct virtio_kctl {
+	struct snd_kcontrol *kctl;
+	struct virtio_snd_ctl_enum_item *items;
+};
+
 /**
  * struct virtio_snd - VirtIO sound card device.
  * @vdev: Underlying virtio device.
@@ -45,6 +55,9 @@ struct virtio_snd_queue {
  * @nsubstreams: Number of PCM substreams.
  * @chmaps: VirtIO channel maps.
  * @nchmaps: Number of channel maps.
+ * @kctl_infos: VirtIO control element information.
+ * @kctls: VirtIO control elements.
+ * @nkctls: Number of control elements.
  */
 struct virtio_snd {
 	struct virtio_device *vdev;
@@ -59,6 +72,9 @@ struct virtio_snd {
 	u32 nsubstreams;
 	struct virtio_snd_chmap_info *chmaps;
 	u32 nchmaps;
+	struct virtio_snd_ctl_info *kctl_infos;
+	struct virtio_kctl *kctls;
+	u32 nkctls;
 };
 
 /* Message completion timeout in milliseconds (module parameter). */
@@ -108,4 +124,10 @@ int virtsnd_chmap_parse_cfg(struct virtio_snd *snd);
 
 int virtsnd_chmap_build_devs(struct virtio_snd *snd);
 
+int virtsnd_kctl_parse_cfg(struct virtio_snd *snd);
+
+int virtsnd_kctl_build_devs(struct virtio_snd *snd);
+
+void virtsnd_kctl_event(struct virtio_snd *snd, struct virtio_snd_event *event);
+
 #endif /* VIRTIO_SND_CARD_H */
diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
new file mode 100644
index 000000000000..16c48abe0ca1
--- /dev/null
+++ b/sound/virtio/virtio_kctl.c
@@ -0,0 +1,464 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * virtio-snd: Virtio sound device
+ * Copyright (C) 2022 OpenSynergy GmbH
+ */
+#include <sound/control.h>
+#include <linux/virtio_config.h>
+
+#include "virtio_card.h"
+
+/* Map for converting VirtIO types to ALSA types. */
+static const snd_ctl_elem_type_t g_v2a_type_map[] = {
+	[VIRTIO_SND_CTL_TYPE_BOOLEAN] = SNDRV_CTL_ELEM_TYPE_BOOLEAN,
+	[VIRTIO_SND_CTL_TYPE_INTEGER] = SNDRV_CTL_ELEM_TYPE_INTEGER,
+	[VIRTIO_SND_CTL_TYPE_INTEGER64] = SNDRV_CTL_ELEM_TYPE_INTEGER64,
+	[VIRTIO_SND_CTL_TYPE_ENUMERATED] = SNDRV_CTL_ELEM_TYPE_ENUMERATED,
+	[VIRTIO_SND_CTL_TYPE_BYTES] = SNDRV_CTL_ELEM_TYPE_BYTES,
+	[VIRTIO_SND_CTL_TYPE_IEC958] = SNDRV_CTL_ELEM_TYPE_IEC958
+};
+
+/* Map for converting VirtIO access rights to ALSA access rights. */
+static const unsigned int g_v2a_access_map[] = {
+	[VIRTIO_SND_CTL_ACCESS_READ] = SNDRV_CTL_ELEM_ACCESS_READ,
+	[VIRTIO_SND_CTL_ACCESS_WRITE] = SNDRV_CTL_ELEM_ACCESS_WRITE,
+	[VIRTIO_SND_CTL_ACCESS_VOLATILE] = SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	[VIRTIO_SND_CTL_ACCESS_INACTIVE] = SNDRV_CTL_ELEM_ACCESS_INACTIVE,
+	[VIRTIO_SND_CTL_ACCESS_TLV_READ] = SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+	[VIRTIO_SND_CTL_ACCESS_TLV_WRITE] = SNDRV_CTL_ELEM_ACCESS_TLV_WRITE,
+	[VIRTIO_SND_CTL_ACCESS_TLV_COMMAND] = SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND
+};
+
+/* Map for converting VirtIO event masks to ALSA event masks. */
+static const unsigned int g_v2a_mask_map[] = {
+	[VIRTIO_SND_CTL_EVT_MASK_VALUE] = SNDRV_CTL_EVENT_MASK_VALUE,
+	[VIRTIO_SND_CTL_EVT_MASK_INFO] = SNDRV_CTL_EVENT_MASK_INFO,
+	[VIRTIO_SND_CTL_EVT_MASK_TLV] = SNDRV_CTL_EVENT_MASK_TLV
+};
+
+/**
+ * virtsnd_kctl_info() - Returns information about the control.
+ * @kcontrol: ALSA control element.
+ * @uinfo: Element information.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_info(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_info *uinfo)
+{
+	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_kctl *kctl = &snd->kctls[kcontrol->private_value];
+	struct virtio_snd_ctl_info *kinfo =
+		&snd->kctl_infos[kcontrol->private_value];
+	unsigned int i;
+
+	uinfo->type = g_v2a_type_map[le32_to_cpu(kinfo->type)];
+	uinfo->count = le32_to_cpu(kinfo->count);
+
+	switch (uinfo->type) {
+	case SNDRV_CTL_ELEM_TYPE_INTEGER:
+		uinfo->value.integer.min =
+			le32_to_cpu(kinfo->value.integer.min);
+		uinfo->value.integer.max =
+			le32_to_cpu(kinfo->value.integer.max);
+		uinfo->value.integer.step =
+			le32_to_cpu(kinfo->value.integer.step);
+
+		break;
+	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
+		uinfo->value.integer64.min =
+			le64_to_cpu(kinfo->value.integer64.min);
+		uinfo->value.integer64.max =
+			le64_to_cpu(kinfo->value.integer64.max);
+		uinfo->value.integer64.step =
+			le64_to_cpu(kinfo->value.integer64.step);
+
+		break;
+	case SNDRV_CTL_ELEM_TYPE_ENUMERATED:
+		i = uinfo->value.enumerated.item;
+		if (i >= le32_to_cpu(kinfo->value.enumerated.items))
+			return -EINVAL;
+
+		strscpy(uinfo->value.enumerated.name, kctl->items[i].item,
+			sizeof(uinfo->value.enumerated.name));
+
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_kctl_get() - Read the value from the control.
+ * @kcontrol: ALSA control element.
+ * @uvalue: Element value.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *uvalue)
+{
+	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd_ctl_info *kinfo =
+		&snd->kctl_infos[kcontrol->private_value];
+	unsigned int type = le32_to_cpu(kinfo->type);
+	unsigned int count = le32_to_cpu(kinfo->count);
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_ctl_hdr *hdr;
+	struct virtio_snd_ctl_value *kvalue;
+	size_t request_size = sizeof(*hdr);
+	size_t response_size = sizeof(struct virtio_snd_hdr) + sizeof(*kvalue);
+	unsigned int i;
+	int rc;
+
+	msg = virtsnd_ctl_msg_alloc(request_size, response_size, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	virtsnd_ctl_msg_ref(msg);
+
+	hdr = virtsnd_ctl_msg_request(msg);
+	hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_READ);
+	hdr->control_id = cpu_to_le32(kcontrol->private_value);
+
+	rc = virtsnd_ctl_msg_send_sync(snd, msg);
+	if (rc)
+		goto on_failure;
+
+	kvalue = (void *)((u8 *)virtsnd_ctl_msg_response(msg) +
+			  sizeof(struct virtio_snd_hdr));
+
+	switch (type) {
+	case VIRTIO_SND_CTL_TYPE_BOOLEAN:
+	case VIRTIO_SND_CTL_TYPE_INTEGER:
+		for (i = 0; i < count; ++i)
+			uvalue->value.integer.value[i] =
+				le32_to_cpu(kvalue->value.integer[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_INTEGER64:
+		for (i = 0; i < count; ++i)
+			uvalue->value.integer64.value[i] =
+				le64_to_cpu(kvalue->value.integer64[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_ENUMERATED:
+		for (i = 0; i < count; ++i)
+			uvalue->value.enumerated.item[i] =
+				le32_to_cpu(kvalue->value.enumerated[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_BYTES:
+		memcpy(uvalue->value.bytes.data, kvalue->value.bytes, count);
+		break;
+	case VIRTIO_SND_CTL_TYPE_IEC958:
+		memcpy(&uvalue->value.iec958, &kvalue->value.iec958,
+		       sizeof(uvalue->value.iec958));
+		break;
+	}
+
+on_failure:
+	virtsnd_ctl_msg_unref(msg);
+
+	return rc;
+}
+
+/**
+ * virtsnd_kctl_put() - Write the value to the control.
+ * @kcontrol: ALSA control element.
+ * @uvalue: Element value.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *uvalue)
+{
+	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd_ctl_info *kinfo =
+		&snd->kctl_infos[kcontrol->private_value];
+	unsigned int type = le32_to_cpu(kinfo->type);
+	unsigned int count = le32_to_cpu(kinfo->count);
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_ctl_hdr *hdr;
+	struct virtio_snd_ctl_value *kvalue;
+	size_t request_size = sizeof(*hdr) + sizeof(*kvalue);
+	size_t response_size = sizeof(struct virtio_snd_hdr);
+	unsigned int i;
+
+	msg = virtsnd_ctl_msg_alloc(request_size, response_size, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = virtsnd_ctl_msg_request(msg);
+	hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_WRITE);
+	hdr->control_id = cpu_to_le32(kcontrol->private_value);
+
+	kvalue = (void *)((u8 *)hdr + sizeof(*hdr));
+
+	switch (type) {
+	case VIRTIO_SND_CTL_TYPE_BOOLEAN:
+	case VIRTIO_SND_CTL_TYPE_INTEGER:
+		for (i = 0; i < count; ++i)
+			kvalue->value.integer[i] =
+				cpu_to_le32(uvalue->value.integer.value[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_INTEGER64:
+		for (i = 0; i < count; ++i)
+			kvalue->value.integer64[i] =
+				cpu_to_le64(uvalue->value.integer64.value[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_ENUMERATED:
+		for (i = 0; i < count; ++i)
+			kvalue->value.enumerated[i] =
+				cpu_to_le32(uvalue->value.enumerated.item[i]);
+		break;
+	case VIRTIO_SND_CTL_TYPE_BYTES:
+		memcpy(kvalue->value.bytes, uvalue->value.bytes.data, count);
+		break;
+	case VIRTIO_SND_CTL_TYPE_IEC958:
+		memcpy(&kvalue->value.iec958, &uvalue->value.iec958,
+		       sizeof(kvalue->value.iec958));
+		break;
+	}
+
+	return virtsnd_ctl_msg_send_sync(snd, msg);
+}
+
+/**
+ * virtsnd_kctl_tlv_op() - Perform an operation on the control's metadata.
+ * @kcontrol: ALSA control element.
+ * @op_flag: Operation code (SNDRV_CTL_TLV_OP_XXX).
+ * @size: Size of the TLV data in bytes.
+ * @utlv: TLV data.
+ *
+ * Context: Process context.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
+			       unsigned int size, unsigned int __user *utlv)
+{
+	struct virtio_snd *snd = kcontrol->private_data;
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_ctl_hdr *hdr;
+	unsigned int *tlv;
+	struct scatterlist sg;
+	int rc;
+
+	msg = virtsnd_ctl_msg_alloc(sizeof(*hdr), sizeof(struct virtio_snd_hdr),
+				    GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	tlv = kzalloc(size, GFP_KERNEL);
+	if (!tlv) {
+		virtsnd_ctl_msg_unref(msg);
+		return -ENOMEM;
+	}
+
+	sg_init_one(&sg, tlv, size);
+
+	hdr = virtsnd_ctl_msg_request(msg);
+	hdr->control_id = cpu_to_le32(kcontrol->private_value);
+
+	switch (op_flag) {
+	case SNDRV_CTL_TLV_OP_READ:
+		hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_TLV_READ);
+
+		rc = virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
+		if (!rc) {
+			if (copy_to_user(utlv, tlv, size))
+				rc = -EFAULT;
+		}
+
+		break;
+	case SNDRV_CTL_TLV_OP_WRITE:
+	case SNDRV_CTL_TLV_OP_CMD:
+		if (op_flag == SNDRV_CTL_TLV_OP_WRITE)
+			hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_TLV_WRITE);
+		else
+			hdr->hdr.code =
+				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
+
+		if (copy_from_user(tlv, utlv, size))
+			rc = -EFAULT;
+		else
+			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
+
+		break;
+	}
+
+	kfree(tlv);
+
+	return rc;
+}
+
+/**
+ * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
+ * @snd: VirtIO sound device.
+ * @cid: Control element ID.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+static int virtsnd_kctl_get_enum_items(struct virtio_snd *snd, unsigned int cid)
+{
+	struct virtio_device *vdev = snd->vdev;
+	struct virtio_snd_ctl_info *kinfo = &snd->kctl_infos[cid];
+	struct virtio_kctl *kctl = &snd->kctls[cid];
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_ctl_hdr *hdr;
+	unsigned int n = le32_to_cpu(kinfo->value.enumerated.items);
+	struct scatterlist sg;
+
+	msg = virtsnd_ctl_msg_alloc(sizeof(*hdr),
+				    sizeof(struct virtio_snd_hdr), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	kctl->items = devm_kcalloc(&vdev->dev, n, sizeof(*kctl->items),
+				   GFP_KERNEL);
+	if (!kctl->items) {
+		virtsnd_ctl_msg_unref(msg);
+		return -ENOMEM;
+	}
+
+	sg_init_one(&sg, kctl->items, n * sizeof(*kctl->items));
+
+	hdr = virtsnd_ctl_msg_request(msg);
+	hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_ENUM_ITEMS);
+	hdr->control_id = cpu_to_le32(cid);
+
+	return virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
+}
+
+/**
+ * virtsnd_kctl_parse_cfg() - Parse the control element configuration.
+ * @snd: VirtIO sound device.
+ *
+ * This function is called during initial device initialization.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_kctl_parse_cfg(struct virtio_snd *snd)
+{
+	struct virtio_device *vdev = snd->vdev;
+	u32 i;
+	int rc;
+
+	virtio_cread_le(vdev, struct virtio_snd_config, controls,
+			&snd->nkctls);
+	if (!snd->nkctls)
+		return 0;
+
+	snd->kctl_infos = devm_kcalloc(&vdev->dev, snd->nkctls,
+				       sizeof(*snd->kctl_infos), GFP_KERNEL);
+	if (!snd->kctl_infos)
+		return -ENOMEM;
+
+	snd->kctls = devm_kcalloc(&vdev->dev, snd->nkctls, sizeof(*snd->kctls),
+				  GFP_KERNEL);
+	if (!snd->kctls)
+		return -ENOMEM;
+
+	rc = virtsnd_ctl_query_info(snd, VIRTIO_SND_R_CTL_INFO, 0, snd->nkctls,
+				    sizeof(*snd->kctl_infos), snd->kctl_infos);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < snd->nkctls; ++i) {
+		struct virtio_snd_ctl_info *kinfo = &snd->kctl_infos[i];
+		unsigned int type = le32_to_cpu(kinfo->type);
+
+		if (type == VIRTIO_SND_CTL_TYPE_ENUMERATED) {
+			rc = virtsnd_kctl_get_enum_items(snd, i);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_kctl_build_devs() - Build ALSA control elements.
+ * @snd: VirtIO sound device.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_kctl_build_devs(struct virtio_snd *snd)
+{
+	unsigned int cid;
+
+	for (cid = 0; cid < snd->nkctls; ++cid) {
+		struct virtio_snd_ctl_info *kinfo = &snd->kctl_infos[cid];
+		struct virtio_kctl *kctl = &snd->kctls[cid];
+		struct snd_kcontrol_new kctl_new;
+		unsigned int i;
+		int rc;
+
+		memset(&kctl_new, 0, sizeof(kctl_new));
+
+		kctl_new.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		kctl_new.name = kinfo->name;
+		kctl_new.index = le32_to_cpu(kinfo->index);
+
+		for (i = 0; i < ARRAY_SIZE(g_v2a_access_map); ++i)
+			if (le32_to_cpu(kinfo->access) & (1 << i))
+				kctl_new.access |= g_v2a_access_map[i];
+
+		if (kctl_new.access & (SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+				       SNDRV_CTL_ELEM_ACCESS_TLV_WRITE |
+				       SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND)) {
+			kctl_new.access |= SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
+			kctl_new.tlv.c = virtsnd_kctl_tlv_op;
+		}
+
+		kctl_new.info = virtsnd_kctl_info;
+		kctl_new.get = virtsnd_kctl_get;
+		kctl_new.put = virtsnd_kctl_put;
+		kctl_new.private_value = cid;
+
+		kctl->kctl = snd_ctl_new1(&kctl_new, snd);
+		if (!kctl->kctl)
+			return -ENOMEM;
+
+		rc = snd_ctl_add(snd->card, kctl->kctl);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * virtsnd_kctl_event() - Handle the control element event notification.
+ * @snd: VirtIO sound device.
+ * @event: VirtIO sound event.
+ *
+ * Context: Interrupt context.
+ */
+void virtsnd_kctl_event(struct virtio_snd *snd, struct virtio_snd_event *event)
+{
+	struct virtio_snd_ctl_event *kevent =
+		(struct virtio_snd_ctl_event *)event;
+	struct virtio_kctl *kctl;
+	unsigned int cid = le16_to_cpu(kevent->control_id);
+	unsigned int mask = 0;
+	unsigned int i;
+
+	if (cid >= snd->nkctls)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(g_v2a_mask_map); ++i)
+		if (le16_to_cpu(kevent->mask) & (1 << i))
+			mask |= g_v2a_mask_map[i];
+
+
+	kctl = &snd->kctls[cid];
+
+	snd_ctl_notify(snd->card, mask, &kctl->kctl->id);
+}
-- 
2.35.1

