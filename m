Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4990C500895
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbiDNIox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbiDNIou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:44:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A3E6541E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:42:27 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id bo5so4257600pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=eJD0zgkQOtvBhg3kkOLY0JJ5fnzikCWkGfIBVnyjkyw=;
        b=SCIe2hRXByLjvsqBzSZB8ICjWmUkFlhXp81uju/X73gpEf7+GXrqi7qZaRfAvRbmmv
         CetmkAcq0whO6+BuZ0hVskN5LnbAgMzQyQ9M5bm43arg9HMj1pRUOk0NcPK23mgMMuVH
         vVkJL1zM47Uak2yYkRL1YAsfWYJAPWoo4xO5vN1Ni8WKsE5p5lTBYMAM1U2H5zZP0f/i
         U+PoM13iz1cXb0Uxdo/47d/mdTvPebCo7A5WU5/bwNCIQIA2P5WwPKGHq9cVX5Gg/2np
         H/PVeT0K1EcLLD9qzwRoXG37EOUCXnqmp1ilsYzR9yrUQSBTGjA5G8twgHwRBlH5ruVV
         k2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eJD0zgkQOtvBhg3kkOLY0JJ5fnzikCWkGfIBVnyjkyw=;
        b=oQle5cMFh4Dn+mqk74+FkFydICxKVBDww420RqMTHSdi/argB2IYel4FLsLfcFvqad
         O+HLgreVvDnqz5rXCUdOhsKCv0CTJHyecVVy0W27njCkPeOE/Hbud76wwFYpimhABsDi
         MZIZ/Ze76WWx9MdTvuclH60qasVr/u4sfQE0En/SgMhWhyVlwHd6gS3/76DdWsn2DiIf
         VlHvZ1uIS462f2iEXe5JLJIfYM3GOX/StGL6uyz5G3bY+bIh8WG4/937WXPMds4Nycwf
         mCskjCByvtuYJ4nJNzjqFKBEEHBV1RtcZHqNK+rM6WPge2uM+Oe7KCdcEgTJT23sbw3b
         hTrA==
X-Gm-Message-State: AOAM533pl973JY08LUlkNfC1bIz3VQOkDV/rwJXcnRQhvD97owt666Q3
        /78AEMdc9MpgvW+8RE1J1uU=
X-Google-Smtp-Source: ABdhPJzaVPhzdnr/iDGxWIFtI6vG92JfkSadUCnYnYRQ315Q+PYJtunuyJakOXPgkdCr8swJOmxEXw==
X-Received: by 2002:a63:e051:0:b0:382:6aff:229a with SMTP id n17-20020a63e051000000b003826aff229amr1413694pgj.493.1649925746625;
        Thu, 14 Apr 2022 01:42:26 -0700 (PDT)
Received: from localhost.localdomain ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id rm5-20020a17090b3ec500b001c7559762e9sm4977308pjb.20.2022.04.14.01.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 01:42:25 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     vaibhav.sr@gmail.com, dan.carpenter@oracle.com,
        mgreer@animalcreek.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v2] greybus: audio_codec: initialize data to silence static checker warnings
Date:   Thu, 14 Apr 2022 16:42:19 +0800
Message-Id: <20220414084219.13501-1-xiam0nd.tong@gmail.com>
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
changes since v1:
 - not bug, but can avoid warnnings (Dan Carpenter)

v1: https://lore.kernel.org/lkml/20220327060120.4316-1-xiam0nd.tong@gmail.com/
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

