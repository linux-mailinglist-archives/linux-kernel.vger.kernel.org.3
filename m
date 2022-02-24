Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381184C24D9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiBXIHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBXIHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:07:19 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0915343AD3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645690010; x=1677226010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/f7/5aXrj1VvkZohdg3wHcq2F85RKdCY94ltEOcCXyE=;
  b=BNBnxtQNfmSTLujFyUaZJS79gwrjSKUSp0CQ64LUsDznD0QEKtUViWk3
   1TjimgAV2ILpiQuUyaCG1RGJm3c6UYUTd8YEl8j2KxNULT8I3ie/a7os/
   LFnXEN+Ecl29PvJsemXNs/dyAE2wGxoo8em0ECAqCQ2vMHIX1ihRDVjU+
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Feb 2022 00:06:49 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 00:06:49 -0800
Received: from hu-rbankapu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 24 Feb 2022 00:06:47 -0800
From:   Raghu Bankapur <quic_rbankapu@quicinc.com>
To:     Jaroslav Kysela <perex@perex.cz>, <linux-kernel@vger.kernel.org>,
        "Takashi Iwai" <tiwai@suse.com>, <alsa-devel@alsa-project.org>
CC:     Krishna Jha <quic_kkishorj@quicinc.com>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>
Subject: [PATCH V1 1/1] ASoC: compress: propagate the error code from the compress framework
Date:   Thu, 24 Feb 2022 13:36:14 +0530
Message-ID: <ec8263009612ead127398ba089f84dafb9fcfa88.1645689841.git.quic_rbankapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1645689841.git.quic_rbankapu@quicinc.com>
References: <cover.1645689841.git.quic_rbankapu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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
 sound/core/compress_offload.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index de514ec8c83d..b89adbf666b1 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -166,9 +166,12 @@ static int snd_compr_free(struct inode *inode, struct file *f)
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

