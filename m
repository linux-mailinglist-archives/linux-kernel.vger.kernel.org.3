Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917525609CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiF2SyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiF2SyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBE5F1EAC7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656528841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EzOiWzYVI0mEc79jZBk4HlKwQXxVL7d+puocaZTpstw=;
        b=O7SACM+v3fTxA5drB0fN1r3rsmemplkeagVfIELJJTRr86Noc5Ymep0bRTOBKDHlqkjnmD
        ddz/5agaFYVp2RxdrwFWysnj9eB+XCS2XS1N/tTBfcgNYrSE9bVsoOOoKmZE5p5d2kGlO8
        80qJpWm9Dg8N2OFYDSOrIASr78/M5Qc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-4EpV8jh4M_eTGGZZmCz4zA-1; Wed, 29 Jun 2022 14:54:00 -0400
X-MC-Unique: 4EpV8jh4M_eTGGZZmCz4zA-1
Received: by mail-qv1-f70.google.com with SMTP id ld6-20020a056214418600b004708c5a26edso16297978qvb.23
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzOiWzYVI0mEc79jZBk4HlKwQXxVL7d+puocaZTpstw=;
        b=oFNo6FasmZJ3lkgZTAHgKHrhhe8dsBvJh0aHWJXDgIEyQfgCoPddFkKLAE/obggLH3
         ZEgWGIl4aWgfFrvprS0G+gkRkWscM1Ek1S8wbBRI1hiZBzi8Z810xChlaQ+A9AP4KAEI
         jGNVaW6xcC8R9tYj95umHJ0wAzfaeaCQ+EzhzNKh+gCQAqI5t/Nq7aetBSofhP803sWj
         PO9nUUAFDU1xqeT5+Wi79YYA+9f1+EJU8MDYf9aNg8XlHTlbkt0FGTeDtPv9MUNqoPJU
         TlYBz+C19at5HL9AZKSHK2YdZzvfvd5NU4h/+zroheJT39VRJ3kPPWDOKT5DyTeJQQxg
         nN3Q==
X-Gm-Message-State: AJIora83vK34hhzedt1x6fM3Ikx3sON5WsB+4aogA8WcLYwfLFRwKYXG
        tCul9xhl2cmA1N5JXWrqL+gGYsGejjyIg+GyqjSl9FV2+xf36xq3koZ9rUp2hN9G9lxWCLtcXFI
        +kJOqujfoXUosnDBwUYG4q9K4
X-Received: by 2002:a05:6214:c4b:b0:470:8a1a:fed0 with SMTP id r11-20020a0562140c4b00b004708a1afed0mr9353642qvj.125.1656528839567;
        Wed, 29 Jun 2022 11:53:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v7HasjPeb63XOccShZcAVfjGTKQd7gcGfCjzhmhoDE2TfmMib4mfVm1foRZjItlX4x5Cy26w==
X-Received: by 2002:a05:6214:c4b:b0:470:8a1a:fed0 with SMTP id r11-20020a0562140c4b00b004708a1afed0mr9353631qvj.125.1656528839281;
        Wed, 29 Jun 2022 11:53:59 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b14-20020ac84f0e000000b00317c3ce1f4esm11009895qte.45.2022.06.29.11.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 11:53:58 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     krzysztof.kozlowski@linaro.org, s.nawrocki@samsung.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, arnd@arndb.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ASoC: samsung: change gpiod_speaker_power and rx1950_audio from global to static variables
Date:   Wed, 29 Jun 2022 14:53:45 -0400
Message-Id: <20220629185345.910406-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse reports
sound/soc/samsung/rx1950_uda1380.c:131:18: warning: symbol 'gpiod_speaker_power' was not declared. Should it be static?
sound/soc/samsung/rx1950_uda1380.c:231:24: warning: symbol 'rx1950_audio' was not declared. Should it be static?

Both gpiod_speaker_power and rx1950_audio are only used in rx1950_uda1380.c,
so their storage class specifiers should be static.

Fixes: 83d74e354200 ("ASoC: samsung: rx1950: turn into platform driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/soc/samsung/rx1950_uda1380.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index ff3acc94a454..abf28321f7d7 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -128,7 +128,7 @@ static int rx1950_startup(struct snd_pcm_substream *substream)
 					&hw_rates);
 }
 
-struct gpio_desc *gpiod_speaker_power;
+static struct gpio_desc *gpiod_speaker_power;
 
 static int rx1950_spk_power(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event)
@@ -228,7 +228,7 @@ static int rx1950_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(dev, &rx1950_asoc);
 }
 
-struct platform_driver rx1950_audio = {
+static struct platform_driver rx1950_audio = {
 	.driver = {
 		.name = "rx1950-audio",
 		.pm = &snd_soc_pm_ops,
-- 
2.27.0

