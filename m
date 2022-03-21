Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1C4E26B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347497AbiCUMjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343611AbiCUMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:39:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FAF1680B5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:37:20 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w25so17614073edi.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRjhCmUK3oCUee61cBk8RWBfzYem6vzRvo8MfD2Xsek=;
        b=TXnBWcEzq++rM6dKuuLB6BLFl6gqNs6THIYwaBvze0VDaT1xhchA/2D4sZuvIkC4A+
         Na98eVdTzfmRT+t+I3XEOCyQVchH6ujIL7WjDl3me4DULQxxu19jvtZi2Q6a8dieIjwc
         CpYWth0Ucw5mTFfayzPOTuxgo42NV7t5g8yqnhfxNPpW6ZU9gW68024901NoTsy0WhRk
         I3xcuC/NPtbSDQHHFRRLSnbe1nszFIcYqVtjCcNoThTcJawdDaiWYritHMJpWrx92OTZ
         5YXJbV0IbZvCiVH01JgNGqIR6TfJEiLzTm+CM1eEh/dOGrEPwwlNRSAzc3qVhaZarX/d
         8Lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRjhCmUK3oCUee61cBk8RWBfzYem6vzRvo8MfD2Xsek=;
        b=olFzcK2hECCgRfBVCUGoQpn24I8X+KxYt2f3xj6JSnKU5hcnce5C9AtTdw+smzQO7A
         WfSzPlnImcDyTLpMj5J3tijNxJXnEHdGKb1oNB/wvKgusV0Hr/21KzKRD8mYA7iqmjR+
         HXdQWxsOaVORl7TIbci0aYsxazv36qi179Lxa0tcj67lH0wxFtKWkqP7Jv3y/BVsJn/O
         SE3oGMXwiOnbYk4iQQ6TGfKcTm8e0fCJ3ROSTbVpvKfpL6dUH2nQbo69QqbvwcVUEQl+
         G/K3Z5wYd0w2fgy2GMLyZwr10hHHPxP0SH93E+t5UG5HDxm3EOwbQ+r7TOHo8cTyf7Co
         rK+Q==
X-Gm-Message-State: AOAM531OSvyJwcJlrKRn9MpODLsh+WWZ4vksNkz7aPeLPuOSwLxw3etb
        yPRozjMjYsf1GEZU+JNiaOk=
X-Google-Smtp-Source: ABdhPJxdZNGfZ/MJWrWNAUwKIPsAS8dgeql0tJLH/bNUH2QSyyo1NxAh4EGJxzpnmqzwon6K90lyYg==
X-Received: by 2002:a05:6402:3488:b0:419:172c:e287 with SMTP id v8-20020a056402348800b00419172ce287mr14182660edc.87.1647866239250;
        Mon, 21 Mar 2022 05:37:19 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id g11-20020a170906538b00b006ae38eb0561sm6923828ejo.195.2022.03.21.05.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 05:37:18 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH] staging: greybus: codecs: use dedicated list iterator variable
Date:   Mon, 21 Mar 2022 13:37:12 +0100
Message-Id: <20220321123712.3068778-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to limit the scope of the list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index b589cf6b1d03..a446d6455fbd 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -497,7 +497,7 @@ static int gbcodec_prepare(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	int ret;
-	struct gbaudio_module_info *module;
+	struct gbaudio_module_info *module = NULL, *iter;
 	struct gbaudio_data_connection *data;
 	struct gb_bundle *bundle;
 	struct gbaudio_codec_info *codec = dev_get_drvdata(dai->dev);
@@ -511,11 +511,13 @@ static int gbcodec_prepare(struct snd_pcm_substream *substream,
 		return -ENODEV;
 	}
 
-	list_for_each_entry(module, &codec->module_list, list) {
+	list_for_each_entry(iter, &codec->module_list, list) {
 		/* find the dai */
-		data = find_data(module, dai->id);
-		if (data)
+		data = find_data(iter, dai->id);
+		if (data) {
+			module = iter;
 			break;
+		}
 	}
 	if (!data) {
 		dev_err(dai->dev, "DATA connection missing\n");
@@ -563,7 +565,7 @@ static int gbcodec_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	int ret;
 	struct gbaudio_data_connection *data;
-	struct gbaudio_module_info *module;
+	struct gbaudio_module_info *module = NULL, *iter;
 	struct gb_bundle *bundle;
 	struct gbaudio_codec_info *codec = dev_get_drvdata(dai->dev);
 	struct gbaudio_stream_params *params;
@@ -592,11 +594,13 @@ static int gbcodec_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 		return ret;
 	}
 
-	list_for_each_entry(module, &codec->module_list, list) {
+	list_for_each_entry(iter, &codec->module_list, list) {
 		/* find the dai */
-		data = find_data(module, dai->id);
-		if (data)
+		data = find_data(iter, dai->id);
+		if (data) {
+			module = iter;
 			break;
+		}
 	}
 	if (!data) {
 		dev_err(dai->dev, "%s:%s DATA connection missing\n",

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

