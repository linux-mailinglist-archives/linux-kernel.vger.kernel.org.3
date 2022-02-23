Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3DD4C134E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbiBWM4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiBWM4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:56:04 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF0697B96
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645620936; x=1677156936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xDllAEF46R317WHwvyU/EeytzHdwGiWyww3otsuSb90=;
  b=i9sYKv29c2wbSLjh3ho/6Ru/K0U9yLIzpItU8QrDaiEo+wOK8tGtwBSo
   I0D3e39ezPLuM3m0pjCaLW97epJuM+K62dhvAjOQ/uBfT5ndD2P7BWvZa
   J4OrKMrR7ln1OTXhDMjfH6DSYiPrR/PoFnLdonZOkzE0GEZ9hnlRGWqO4
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Feb 2022 04:55:36 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 04:55:37 -0800
Received: from hu-rbankapu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 04:55:32 -0800
From:   Raghu Bankapur <quic_rbankapu@quicinc.com>
To:     Jaroslav Kysela <perex@perex.cz>, <linux-kernel@vger.kernel.org>,
        "Takashi Iwai" <tiwai@suse.com>, <alsa-devel@alsa-project.org>
CC:     Krishna Jha <kkishorj@codeaurora.org>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>
Subject: [PATCH V1 1/1] ASoC: compress: propagate the error code from the compress framework
Date:   Wed, 23 Feb 2022 18:22:50 +0530
Message-ID: <eda8b6cdd53576c5487422e46af20bae1a5c864f.1645618332.git.quic_rbankapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1645618332.git.quic_rbankapu@quicinc.com>
References: <cover.1645618332.git.quic_rbankapu@quicinc.com>
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

Propagate the error code from the compress framework for the timestamp
query. This error code will be used by the client to handle the
error case scenarios gracefully.

Signed-off-by: Raghu Bankapur <quic_rbankapu@quicinc.com>
---
 sound/core/compress_offload.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index de514ec8c83d..48aa87d08bdc 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -31,7 +31,11 @@
 #include <sound/info.h>
 #include <sound/compress_params.h>
 #include <sound/compress_offload.h>
-#include <sound/compress_driver.h>
+#include <sound/compress_driver.h>ASoC: compress: propagate the error code from the compress framework
+
+Propagate the error code from the compress framework for the timestamp
+query. This error code will be used by the client to handle the
+error case scenarios gracefully.
 
 /* struct snd_compr_codec_caps overflows the ioctl bit size for some
  * architectures, so we need to disable the relevant ioctls.
@@ -166,9 +170,12 @@ static int snd_compr_free(struct inode *inode, struct file *f)
 static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
 		struct snd_compr_tstamp *tstamp)
 {
+	int ret = 0;
 	if (!stream->ops->pointer)
 		return -ENOTSUPP;
-	stream->ops->pointer(stream, tstamp);
+	ret = stream->ops->pointer(stream, tstamp);
+	if (ret)
+		return ret;
 	pr_debug("dsp consumed till %d total %d bytes\n",
 		tstamp->byte_offset, tstamp->copied_total);
 	if (stream->direction == SND_COMPRESS_PLAYBACK)
-- 
2.17.1

