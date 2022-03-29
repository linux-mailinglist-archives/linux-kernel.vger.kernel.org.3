Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8554EA4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 03:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiC2CBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiC2CBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:01:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628CAAE68
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:59:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i11so16347645plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 18:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Q2tEzc6qqUTq/8x9S+eo1Cjz2mjNMrLq0btC0WZqnOM=;
        b=Bj5rWMMqUgL/GsAyNikkuLD6Fiapi3KQknPLIqpvdw6qNvpOodVRhqD6Zx8YE7Kb5e
         3AUWVNw6NUkGik5KKu4qU/k5YSyrktA1aACy9otYtuR7WMO4E223UxWy4Brc9wvDB0/O
         uEM2mp7QVYOo6yXgu2rWNnRCJbCzraQILh34397i0OhyjQNSxrr2MQBLAr1ouwfiq0pY
         bIP7nYqAoKu5ZKSwDqeIBUHJpxTy8GdT1OGVKoWSCDVTp7NOdvI5E16vben5U3PJ7B0y
         oVIQTTqyZfbfFpg60kfS5hpXGY0saEXIlfNLCcD5lYt72/l0ZHNZISmY5sXkxhwZBJfQ
         N/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q2tEzc6qqUTq/8x9S+eo1Cjz2mjNMrLq0btC0WZqnOM=;
        b=U+6lKhI23nN6HErHz72t3AU8V52qTVxgyjMmQASL3mopQRyB329RE54u4wBOUEIInC
         2XbSm108XYVCLUVsqRfxE5AOqiJSWET23HDnpRDFxTdW0oKQ+z87sC3sZbhOI5Vq+0AA
         NBWV+ranm/XDJ4CZGvK9Ge4iLHrJY05aMoM4NvE0UgMkuot6nyh4Doa+GKyVYixixx7A
         leQOV04E4Aetrvdit33oWRzc68FJhBXrdOI16/X42djn+/VdedjQlUTCC5Ga7Q519HPF
         M23G+gUxcPH7F9+UT15cW2rJnRUVb8JEIgCvPS0zE9him1MD1GP9NRt5H72SK7jF9Tv2
         LKkQ==
X-Gm-Message-State: AOAM533RtNscQd//SBWj8rknEEYBjDvfAqHxTZnvz4iif3tT5UjprMA9
        69FZYqM6xGWYpjuLMXmUVJQ=
X-Google-Smtp-Source: ABdhPJyFcCNoQ/NPBV248dgiFpK3SjyUeJt5otlQ2gLkLeX9M1U17rD6APQ7GfI1hPe30uxQGJncyg==
X-Received: by 2002:a17:902:728f:b0:156:24d3:ae1a with SMTP id d15-20020a170902728f00b0015624d3ae1amr3094825pll.9.1648519162988;
        Mon, 28 Mar 2022 18:59:22 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id hg5-20020a17090b300500b001c795eedcffsm736287pjb.13.2022.03.28.18.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 18:59:22 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     vaibhav.sr@gmail.com
Cc:     dan.carpenter@oracle.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] greybus: audio_codec: initialize data to silence static checker warnings
Date:   Tue, 29 Mar 2022 09:59:13 +0800
Message-Id: <20220329015913.10420-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These three declares are here:
	struct gbaudio_data_connection *data;

Since all three of these functions check for if the codec->module_list is
empty at the start of the function so these are not real bugs to bypass
'if (!data) {'. To avoid static checker warnings like Smatch, initialize
the data with NULL.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index b589cf6b1d03..939e05af4dcf 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -397,7 +397,7 @@ static int gbcodec_hw_params(struct snd_pcm_substream *substream,
 	u8 sig_bits, channels;
 	u32 format, rate;
 	struct gbaudio_module_info *module;
-	struct gbaudio_data_connection *data;
+	struct gbaudio_data_connection *data = NULL;
 	struct gb_bundle *bundle;
 	struct gbaudio_codec_info *codec = dev_get_drvdata(dai->dev);
 	struct gbaudio_stream_params *params;
@@ -498,7 +498,7 @@ static int gbcodec_prepare(struct snd_pcm_substream *substream,
 {
 	int ret;
 	struct gbaudio_module_info *module;
-	struct gbaudio_data_connection *data;
+	struct gbaudio_data_connection *data = NULL;
 	struct gb_bundle *bundle;
 	struct gbaudio_codec_info *codec = dev_get_drvdata(dai->dev);
 	struct gbaudio_stream_params *params;
@@ -562,7 +562,7 @@ static int gbcodec_prepare(struct snd_pcm_substream *substream,
 static int gbcodec_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	int ret;
-	struct gbaudio_data_connection *data;
+	struct gbaudio_data_connection *data = NULL;
 	struct gbaudio_module_info *module;
 	struct gb_bundle *bundle;
 	struct gbaudio_codec_info *codec = dev_get_drvdata(dai->dev);
-- 
2.17.1

