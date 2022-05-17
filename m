Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD5252A25A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbiEQM7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346806AbiEQM7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:00 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7E74D9D1
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:58:07 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220517125805epoutp03aa3350ec8d746593e5f353bd46eccd20~v5dOeHAum0460204602epoutp03c
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:58:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220517125805epoutp03aa3350ec8d746593e5f353bd46eccd20~v5dOeHAum0460204602epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792285;
        bh=cRQ3zk3wvBjeVEyf7E0Lw6KXkrabG1oRLGuBC+AkypY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/TJox87WyR/fh2K7CPJVQ4CKOl15rD93+tIwQ/d941ZrkYPpawBZekWHD8eSxLvo
         VkHMGtEwRrU1nJquFkz34nvy1GRR23h1VfpzpnfWtqMRyDhvPrMjur7+4m7WYgyGeq
         ex0ygQqjPhOHM6IOOSd0zgRAvUHYoOIY3/sMtVQA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220517125804epcas5p3b4884f6a2d76bc4d13efdb0e501e2b44~v5dNv0ZN42689826898epcas5p3g;
        Tue, 17 May 2022 12:58:04 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L2bkx2Fdkz4x9Q0; Tue, 17 May
        2022 12:58:01 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.2C.09762.9DB93826; Tue, 17 May 2022 21:58:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220517125612epcas5p28e4cc7a208d1ac68267fa845e932ccc9~v5blBb-nJ2262022620epcas5p2m;
        Tue, 17 May 2022 12:56:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517125612epsmtrp14d7701cdac06f040184f09e8dbdc5be7~v5blAP4Iq3276532765epsmtrp1Y;
        Tue, 17 May 2022 12:56:12 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-bc-62839bd95684
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.36.08924.B6B93826; Tue, 17 May 2022 21:56:11 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125608epsmtip1236942f35aef30c11b75ce80fc86c422~v5bh1kiQF1799817998epsmtip1O;
        Tue, 17 May 2022 12:56:08 +0000 (GMT)
From:   Smitha T Murthy <smitha.t@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH 07/20] media: v4l2: Add v4l2 control IDs for VP9 encoder.
Date:   Tue, 17 May 2022 18:25:35 +0530
Message-Id: <20220517125548.14746-8-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHPfe2t60RvRYZR7Ih62IMCtgCracCGwlku6LZmFtm4mbwAneF
        0BdtYYxksVpgymCAU5S3sww3UHCldBVQXmVs6licIBPsLCgqLs0cxdcguJaW7b/P7/X9/c7v
        nMPF+eNEEDdTqWM0SlouIFayLAOhm8Jv1hhShV2zPOSotxDI+Ow+hm4bXSzU397BQeaRGhyd
        GeplowbbMBv90DfFQt8/cEevVdlZ6H5DK0Az1X8QyHTnBhtNPtyDrnfWEqjkfAcbnbPZOeib
        sWsYajItYOh0xxwHFV60cZC92wJQQZENiw+kztafBZTV3gioscZZnLpQbedQxu4ZjDI1HyGo
        Wze6Caq98QBVOPgPi/rS3AyoxUN1HKrYNkZQLlMwdfmxi5O8em9WbAZDpzOaEEaZpkrPVMri
        BDvfS0lIEUuEonCRFG0ThChpBRMnSNyVHP5mpty9AUFILi3PcbuSaa1WsPX1WI0qR8eEZKi0
        ujgBo06Xq6PVEVpaoc1RyiKUjG67SCiMFLsT92dljHY/xdT12/L0NdcJPRgUFgMeF5LR0GA7
        wy4GK7l8sgvACec94DVmAfz1VBPuNVwAOkqsYLmk/UnZEvPJTgCPtX3kTSrA4MJEJdsTIMgw
        +OSvK4SH15EHAbxzWOdhnJzHYdVIsIf9yR3Q2l/E8TCL3Ajn2kqXRP1IKTw35NWB5AbYcr7X
        PQWXyyO3w7rFfZ5ekDTw4N2ff8S9OYlwotbkY3/4cMjM8XIQnCkr8rEM3nYZfAdQwzq9GfPy
        G7B3pJbl0cfJUNjWudXrfgUev9yKeUdeDUvn7/rS/aC1fpkF8PTVn3zyEI46O3wjU9Be0EN4
        d1IK4NXhQnY5CK7+v8UpAJrBekatVcgYrVgdpWQ++e/S0lQKE1h65Jt3WsGU41FEP8C4oB9A
        Li5Y5yfM06fy/dLpT/MZjSpFkyNntP1A7N5fBR4UkKZy/xKlLkUULRVGSySSaGmURCQI9CNf
        HEzlkzJax2QxjJrRLNdhXF6QHvslwUnEmz+szP5st3Gw6OTXq1aVfXGxbnK6dHFT7F7Ly2/H
        9EX6Z1qyjhjyVxj9Mf5o7THa+ff+E0mhagPLevTVA/f6hm3aQH5dnHhsl7PEURRmfFcW+xbz
        SP5VqhnSa6IQ1WV8zDF9m+9YDN1dGJD0QZqw5UFTLn6ht+RK+ZbnCYkbynPmmqfG16t5LMUO
        sfTzfQsVtdKwHv+0LRmVJ7JOTv45eklS1RMTKUpfUZM7tTbg0LPsYkvMparXyDXximyXRdo3
        PScfeH5zDB3eM9ASkzn9/jsNcR9/l1gwlfd7xSjboB8/2lpeaZs/fsuUlORITcgrLlU6n770
        4jdjsiapDBewtBm0aDOu0dL/AnqEjZxtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRiA+87OzjkuZqdledKyXAghNS+UfZWlFMEppCIKQSs75snr5tjR
        tAu5ZjMcXUy6qMtLaZlTS+clleVlbgwvlfehtjJL7G6olVRITunf8/I8vO+Pl+CJMlEXIlqW
        wCpkTJwYE6C1rWK3jbHa1HDv0Xvb4EheLQYLZ8YR+KZwCoXGqhocVvdpebDY0syH+aYXfPi0
        ZRSFlR/mbHe2DYXj+Y8B/JjzGoP6dwN8+PZTMOxtuIvBKxU1fFhusuHwgbUbgQ/1fxF4v2Ya
        h+pnJhzaDLUAXkozIYHOdFleGaDrbEWAthZN8uj6HBtOFxo+IrRel47RrwYMGF1VlEKrzb9R
        +lq1DtCzqlyc1pisGD2ld6Pbf0zhBx1DBP4RbFz0aVbhtfOEIKrf8AuR521JVmp7MSUwe2uA
        A0GRm6iqn9eBBggIEVkHKMundmRBUFTJn0ywwMuoktlxfCFSIVSlRYnZBUZuoH5OdGB24USq
        AWUtSUfsA4+8gVI3rb959moZuZeqM6bhdkZJD2r6ydX5tUJyK1Vuuc1fOLGGKq1onusJwoHc
        RuXOHrOjaC4Za4IZwLEALNKBlayck0ZKOR+5r4xNknCMlEuURUpOxkv1YP5tnp51wKD7LjEC
        hABGQBE8sZPQO1kZLhJGMGfOsor4MEViHMsZgSuBip2FXZq2MBEZySSwsSwrZxX/LUI4uCiR
        4NBzuz77p3j4Ch4emhEOj/URuv2lAdoVAYu2Xmh52cjvlHpcbMxMjQZJB3LfE8ln3/UfNoPU
        8JjHoWxG2+b43QlLv21QHZoZOtXh6Npe0xSe0tR59I+kc0nze99foiMyOX93ccjG0eGXivU7
        ZNxEK/SqQOuX/GjSMObs4/fLE47SRTuulNwevjDTdaPbb3mH/ypLZYM7RuxZMTnmasRUp79M
        Z3TWXxs67Bekivl269a+S+vYr9Yg/0Bzn8P5tVMaUXFye1qoDY3OYsLU3Ov+6pHMNe6PvBaz
        byUjYy7Ec1DMbB/syfbhFJdz7iT1uGF3BlcPemv9ErPVoQXrswwFYpSLYnw8eQqO+Qdv+I5t
        JQMAAA==
X-CMS-MailID: 20220517125612epcas5p28e4cc7a208d1ac68267fa845e932ccc9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125612epcas5p28e4cc7a208d1ac68267fa845e932ccc9
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125612epcas5p28e4cc7a208d1ac68267fa845e932ccc9@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add V4l2 controls for VP9 encoder

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-defs.c | 44 +++++++++++++++++++++++
 include/uapi/linux/v4l2-controls.h        | 33 +++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 54ca4e6b820b..f251d63e333c 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -572,6 +572,21 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		"VBV/CPB Limit",
 		NULL,
 	};
+	static const char * const vp9_golden_framesel[] = {
+		"Use previous",
+		"Use refresh period",
+		NULL,
+	};
+	static const char * const vp9_ref_num_for_pframes[] = {
+		"1",
+		"2",
+		NULL,
+	};
+	static const char * const vp9_max_partition_depth[] = {
+		"No CU partition depth",
+		"Allow 1 CU partition depth",
+		NULL,
+	};
 
 	switch (id) {
 	case V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ:
@@ -703,6 +718,12 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		return hevc_decode_mode;
 	case V4L2_CID_MPEG_VIDEO_HEVC_START_CODE:
 		return hevc_start_code;
+	case V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAMESEL:
+		return vp9_golden_framesel;
+	case V4L2_CID_MPEG_VIDEO_VP9_REF_NUMBER_FOR_PFRAMES:
+		return vp9_ref_num_for_pframes;
+	case V4L2_CID_MPEG_VIDEO_VP9_MAX_PARTITION_DEPTH:
+		return vp9_max_partition_depth;
 	case V4L2_CID_CAMERA_ORIENTATION:
 		return camera_orientation;
 	default:
@@ -942,6 +963,26 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_VP8_PROFILE:			return "VP8 Profile";
 	case V4L2_CID_MPEG_VIDEO_VP9_PROFILE:			return "VP9 Profile";
 	case V4L2_CID_MPEG_VIDEO_VP9_LEVEL:			return "VP9 Level";
+	case V4L2_CID_MPEG_VIDEO_VP9_I_FRAME_QP:		return "VP9 I Frame QP Value";
+	case V4L2_CID_MPEG_VIDEO_VP9_P_FRAME_QP:		return "VP9 P Frame QP Value";
+	case V4L2_CID_MPEG_VIDEO_VP9_MAX_QP:			return "VP9 Frame QP MAX Value";
+	case V4L2_CID_MPEG_VIDEO_VP9_MIN_QP:			return "VP9 Frame QP MIN Value";
+	case V4L2_CID_MPEG_VIDEO_VP9_RC_FRAME_RATE:		return "VP9 Frame Rate";
+	case V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAMESEL:		return "VP9 Indication of Golden Frame";
+	case V4L2_CID_MPEG_VIDEO_VP9_GF_REFRESH_PERIOD:		return "VP9 Golden Frame Refresh Period";
+	case V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_QP_ENABLE:	return "VP9 Hierarchical QP Enable";
+	case V4L2_CID_MPEG_VIDEO_VP9_REF_NUMBER_FOR_PFRAMES:	return "VP9 Number of Reference Pictures";
+	case V4L2_CID_MPEG_VIDEO_VP9_HIERARCHICAL_CODING_LAYER:	return "VP9 Num of Hierarchical Layers";
+	case V4L2_CID_MPEG_VIDEO_VP9_MAX_PARTITION_DEPTH:	return "VP9 Maximum Coding Unit Depth";
+	case V4L2_CID_MPEG_VIDEO_VP9_DISABLE_INTRA_PU_SPLIT:	return "VP9 Disable Intra PU Split";
+	case V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_RC_ENABLE:	return "VP9 Hierarchical BitRate Enable";
+	case V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_BR:		return "VP9 Hierarchical Layer 0 BitRate";
+	case V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_BR:		return "VP9 Hierarchical Layer 1 BitRate";
+	case V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_BR:		return "VP9 Hierarchical Layer 2 BitRate";
+	case V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_QP:		return "VP9 Layer0 QP Value";
+	case V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_QP:		return "VP9 Layer1 QP Value";
+	case V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_QP:		return "VP9 Layer2 QP Value";
+	case V4L2_CID_MPEG_VIDEO_VP9_DISABLE_IVF_HEADER:	return "VP9 IVF header generation";
 
 	/* HEVC controls */
 	case V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP:		return "HEVC I-Frame QP Value";
@@ -1357,6 +1398,9 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE:
 	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE:
 	case V4L2_CID_MPEG_VIDEO_HEVC_START_CODE:
+	case V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAMESEL:
+	case V4L2_CID_MPEG_VIDEO_VP9_REF_NUMBER_FOR_PFRAMES:
+	case V4L2_CID_MPEG_VIDEO_VP9_MAX_PARTITION_DEPTH:
 	case V4L2_CID_STATELESS_H264_DECODE_MODE:
 	case V4L2_CID_STATELESS_H264_START_CODE:
 	case V4L2_CID_CAMERA_ORIENTATION:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index bb40129446d4..6dd82b738ef5 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -711,6 +711,38 @@ enum v4l2_mpeg_video_vp9_level {
 	V4L2_MPEG_VIDEO_VP9_LEVEL_6_1	= 12,
 	V4L2_MPEG_VIDEO_VP9_LEVEL_6_2	= 13,
 };
+#define V4L2_CID_MPEG_VIDEO_VP9_RC_FRAME_RATE	(V4L2_CID_CODEC_BASE+514)
+#define V4L2_CID_MPEG_VIDEO_VP9_MIN_QP		(V4L2_CID_CODEC_BASE+515)
+#define V4L2_CID_MPEG_VIDEO_VP9_MAX_QP		(V4L2_CID_CODEC_BASE+516)
+#define V4L2_CID_MPEG_VIDEO_VP9_I_FRAME_QP	(V4L2_CID_CODEC_BASE+517)
+#define V4L2_CID_MPEG_VIDEO_VP9_P_FRAME_QP	(V4L2_CID_CODEC_BASE+518)
+#define V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAMESEL	(V4L2_CID_CODEC_BASE+519)
+enum v4l2_mpeg_vp9_golden_framesel {
+	V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAME_USE_PREV           = 0,
+	V4L2_CID_MPEG_VIDEO_VP9_GOLDEN_FRAME_USE_REF_PERIOD     = 1,
+};
+#define V4L2_CID_MPEG_VIDEO_VP9_GF_REFRESH_PERIOD (V4L2_CID_CODEC_BASE+520)
+#define V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_QP_ENABLE (V4L2_CID_CODEC_BASE+521)
+#define V4L2_CID_MPEG_VIDEO_VP9_REF_NUMBER_FOR_PFRAMES (V4L2_CID_CODEC_BASE+522)
+enum v4l2_mpeg_vp9_ref_num_for_pframes {
+	V4L2_CID_MPEG_VIDEO_VP9_1_REF_PFRAME     = 0,
+	V4L2_CID_MPEG_VIDEO_VP9_2_REF_PFRAME     = 1,
+};
+#define V4L2_CID_MPEG_VIDEO_VP9_HIERARCHICAL_CODING_LAYER (V4L2_CID_CODEC_BASE+523)
+#define V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_BR	(V4L2_CID_CODEC_BASE+524)
+#define V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_BR	(V4L2_CID_CODEC_BASE+525)
+#define V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_BR	(V4L2_CID_CODEC_BASE+526)
+#define V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L0_QP	(V4L2_CID_CODEC_BASE+527)
+#define V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L1_QP	(V4L2_CID_CODEC_BASE+528)
+#define V4L2_CID_MPEG_VIDEO_VP9_HIER_CODING_L2_QP	(V4L2_CID_CODEC_BASE+529)
+#define V4L2_CID_MPEG_VIDEO_VP9_MAX_PARTITION_DEPTH	(V4L2_CID_CODEC_BASE+530)
+enum v4l2_mpeg_vp9_num_partitions {
+	V4L2_CID_MPEG_VIDEO_VP9_0_PARTITION     = 0,
+	V4L2_CID_MPEG_VIDEO_VP9_1_PARTITION	= 1,
+};
+#define V4L2_CID_MPEG_VIDEO_VP9_DISABLE_INTRA_PU_SPLIT	(V4L2_CID_CODEC_BASE+531)
+#define V4L2_CID_MPEG_VIDEO_VP9_DISABLE_IVF_HEADER	(V4L2_CID_CODEC_BASE+532)
+#define V4L2_CID_MPEG_VIDEO_VP9_HIERARCHY_RC_ENABLE	(V4L2_CID_CODEC_BASE+533)
 
 /* CIDs for HEVC encoding. */
 
@@ -821,6 +853,7 @@ enum v4l2_mpeg_video_frame_skip_mode {
 #define V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY		(V4L2_CID_CODEC_BASE + 653)
 #define V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE	(V4L2_CID_CODEC_BASE + 654)
 
+
 /*  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2 */
 #define V4L2_CID_CODEC_CX2341X_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1000)
 #define V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE		(V4L2_CID_CODEC_CX2341X_BASE+0)
-- 
2.17.1

