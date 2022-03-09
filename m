Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698D54D30F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbiCIOYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiCIOYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:24:05 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050B1107DA0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646835787; x=1678371787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=RWKnNnTeEOjVqq7CWbHUR0BTNxJt/MW7KsU/tp//GhY=;
  b=vDbWtlI0qMF0Z+71q2+iFj6temLkQIIGL1ANTCx22f+N+Akf7T6dLaK1
   TTdmSOvClicnCFZ6FvPzszEhQ+CYfUGUlMCUQKw0biamce+oed3kvtSji
   IZajmVRWoAs4yizrfD9dagiSS7QnlNHH0pKDzvSa4kE32bpHJFWFNIjzW
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Mar 2022 06:23:06 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 06:23:06 -0800
Received: from hu-rbankapu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Mar 2022 06:23:03 -0800
From:   Raghu Bankapur <quic_rbankapu@quicinc.com>
To:     Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     Krishna Jha <quic_kkishorj@quicinc.com>,
        Raghu Bankapur <quic_rbankapu@quiinc.com>
Subject: [PATCH V0 1/1] ASoC: msm: fix integer overflow for long duration offload playback
Date:   Wed, 9 Mar 2022 19:52:28 +0530
Message-ID: <b906dbaf772d0152a3af52d639b090d15fe8c362.1646835508.git.quic_rbankapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1646835508.git.quic_rbankapu@quicinc.com>
References: <cover.1646835508.git.quic_rbankapu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raghu Bankapur <quic_rbankapu@quiinc.com>

32 bit variable is used for storing number of bytes copied to DSP,
which can overflow when playback duration goes beyond 24 hours.
Change data type for this variable to uint64_t to prevent overflow
and related playback anomaly.

Signed-off-by: Raghu Bankapur <quic_rbankapu@quicinc.com>
---
 include/uapi/sound/compress_offload.h | 2 +-
 sound/core/compress_offload.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 9555f31c8425..57d24d89b2f4 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -67,7 +67,7 @@ struct snd_compr_params {
  */
 struct snd_compr_tstamp {
 	__u32 byte_offset;
-	__u32 copied_total;
+	__u64 copied_total;
 	__u32 pcm_frames;
 	__u32 pcm_io_frames;
 	__u32 sampling_rate;
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index de514ec8c83d..068376b586be 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -169,7 +169,7 @@ static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
 	if (!stream->ops->pointer)
 		return -ENOTSUPP;
 	stream->ops->pointer(stream, tstamp);
-	pr_debug("dsp consumed till %d total %d bytes\n",
+	pr_debug("dsp consumed till %d total %llu bytes\n",
 		tstamp->byte_offset, tstamp->copied_total);
 	if (stream->direction == SND_COMPRESS_PLAYBACK)
 		stream->runtime->total_bytes_transferred = tstamp->copied_total;
-- 
2.17.1

