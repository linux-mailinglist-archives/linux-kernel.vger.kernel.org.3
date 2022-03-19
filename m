Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4392F4DEA98
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244114AbiCSUWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240604AbiCSUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:22:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB30939B83
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:21:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a8so22978200ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHLMgXqZPwAjL27Id0sSqj94GzZmSc3lr7K5901Tgpk=;
        b=ZNtk/pp6yjLOiEaL/Kugxtk0VwmKSKQnMp/QX0Odlg3DSks4r6MCEHTB2EMZVVWn/v
         LmxJMZ1Rq6QEspYvEcZte27/pKeHa0zXORDmOttJad8LaM34/xYNQUB/4xPmTAPahkKz
         Tr6BWdiDNZykYDrMsAmIM/C/3lNOu4YYqZc6aY5xhrUb0aKzOp/M0+wrEnFcV+9qObg5
         yR/Pk1uYxQdc4ZEQwdgfYLYky5w4VzBG61xmOuAq1TAwHXNuvuLBhN7UrECZdY0zce+2
         wsVM+mYksjFjU2YnPResFSJ2/n0h3bXnuLxDhOsNabpEjrcDwuG9q5SpLpi/VGfM03pu
         zMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHLMgXqZPwAjL27Id0sSqj94GzZmSc3lr7K5901Tgpk=;
        b=WOza1Z2kNBJc6rCuK3kVzET32sDp0EwxRGBb30b+e34iU4/rMaYKc05wne4x88ptBg
         yMr0lzCr1sx3nGYfvhzdDIMbGFjOHtsavBrz4qAUbvMimwLDjIlBKNd5xb3IWEc0r7Fv
         +9Uw11yj/Guvjwcqf6RWrxQyHCHo9VBkjT4SC/xbORDM7X7+lebeS7fYlT7cbkiMAxma
         1DU1WFSc9owqnQXbxE4CmiKKSnwUray9tjauxvdG0ux+eyjZ/ECPXxpCd7zzRPmRpzxz
         510hiPOv139vIywPSr30RtHsOHWwNpz9Hw/EyLk6tO3ag9GUSdQjbulkGBAnGTOD5muH
         tMAQ==
X-Gm-Message-State: AOAM532DDCHZjGLzCUgZ4dge4zRrlpb2jxmH6HBBUjEHzNUgMjjM2Dhk
        xcs4ytbmikimN9p6vnMS2xA=
X-Google-Smtp-Source: ABdhPJwBdKbx0Y3W/PyFwMf1nRyC4G9Vb1RxtvkzGcHKA6U+X2LuzPFT6K7ipx0eljDg1AXH3aBvOA==
X-Received: by 2002:a17:906:7c93:b0:6cd:341a:a1d5 with SMTP id w19-20020a1709067c9300b006cd341aa1d5mr13999454ejo.698.1647721289256;
        Sat, 19 Mar 2022 13:21:29 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm5103628ejb.82.2022.03.19.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:21:28 -0700 (PDT)
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
Subject: [PATCH] staging: greybus: codecs: fix type confusion with dedicated list iterator variable
Date:   Sat, 19 Mar 2022 21:20:58 +0100
Message-Id: <20220319202058.2518847-1-jakobkoschel@gmail.com>
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

If the list does not exit early then data == NULL and 'module' does not
point to a valid list element.
Using 'module' in such a case is not valid and was therefore removed.

In preparation to limit the scope of the list iterator to the list
traversal loop, use a dedicated pointer pointing to the found element [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index b589cf6b1d03..0f50d1e51e2c 100644
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
@@ -592,15 +594,17 @@ static int gbcodec_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
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
-		dev_err(dai->dev, "%s:%s DATA connection missing\n",
-			dai->name, module->name);
+		dev_err(dai->dev, "%s DATA connection missing\n",
+			dai->name);
 		mutex_unlock(&codec->lock);
 		return -ENODEV;
 	}

base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
--
2.25.1

