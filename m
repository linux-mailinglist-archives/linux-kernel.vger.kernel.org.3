Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91AD5017DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiDNPv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358350AbiDNPlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 107BDECC73
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649949836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGRJLz7z/3jGasxkIFljjT/M7YCjB3xjYdcrHt5JsPY=;
        b=R6F46RRSoVmJ5TxbsSSECf0FPaYBKNSX1pSMHSwwfkqQ58M4RFcvU0fIGssO1qfcSOpKjD
        HqtfPS9KGBI13SP/wAzyH2Wffa8rjfSYYgyzSSPsLS4kNkNK+vOvUq4BQncX0RU+fVYbbD
        8w+Na2hMm1eGJqgOOVCLdufUTWkpCmI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-f-lfp3HlNhyHZPEo0TjWEg-1; Thu, 14 Apr 2022 11:23:55 -0400
X-MC-Unique: f-lfp3HlNhyHZPEo0TjWEg-1
Received: by mail-qv1-f69.google.com with SMTP id jz4-20020a0562140e6400b004461f104a7cso2693773qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGRJLz7z/3jGasxkIFljjT/M7YCjB3xjYdcrHt5JsPY=;
        b=w+6ZlI6Zs6E4bfEZvfFN4Qcn8S9WGf8z6QRmxtrUQ9JzEUWDtCnXLCL1PUAJOZ+LFx
         ubsT/tOZFtbCT7sMIWNqZz2ZLnkUbaaaIXYSZ2gIlepS2UlKHIfj3C/9WGRYx8acCDyy
         5YwRT02oJ98UMTUU4aj3sQwBXHj2f/kEerwtde3U1tahe2P+69uxNJfaLs2ahX1nKFz2
         QaUFrQZ6JuCwheBOS0HFCK9sN8pu6A0sui00l9dXkafMzw5uRQlIktsYM9IX7OPcYWoT
         N4GmQbE89Q7R7oRKwcOIFpWLov45jaeKPLVbncgCOBXWxDPBB2nwIAbQ1HPmAuMwh713
         K8Vw==
X-Gm-Message-State: AOAM533hiAamZWIkT5mVElv2SXXUdhZ8IbbEqwldHtjGg7P1xGDW1Sf1
        Mp930Eaqkg0UD1U2kfUMLUdREwYlpS5UBSVR4tP+8p4oXvYaQDOMMOEB9suEPiGVADY+zJkq1vx
        j7ZJR1+FaFq/I+yukhohVyavU
X-Received: by 2002:ad4:5dc7:0:b0:443:6f15:fe32 with SMTP id m7-20020ad45dc7000000b004436f15fe32mr3852121qvh.6.1649949834657;
        Thu, 14 Apr 2022 08:23:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDIMnHIaFBi6EAQ93deNI9TIf/lTnkCTwd5RkyfWbj4eTfNhDjJwcfrcjQzxV8pE0w7SpAiw==
X-Received: by 2002:ad4:5dc7:0:b0:443:6f15:fe32 with SMTP id m7-20020ad45dc7000000b004436f15fe32mr3852106qvh.6.1649949834481;
        Thu, 14 Apr 2022 08:23:54 -0700 (PDT)
Received: from fedora.redhat.com (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id p5-20020a378d05000000b0069beaffd5b3sm1166038qkd.4.2022.04.14.08.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:23:54 -0700 (PDT)
From:   Adrien Thierry <athierry@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <mripard@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Thierry <athierry@redhat.com>
Subject: [PATCH 1/2] staging: bcm2835-audio: fully describe config symbol
Date:   Thu, 14 Apr 2022 11:23:39 -0400
Message-Id: <20220414152340.68932-2-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414152340.68932-1-athierry@redhat.com>
References: <20220414152340.68932-1-athierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain SND_BCM2835 config option in more detail, especially the
implications of using the bcm2835-audio driver in conjunction with vc4
for HDMI audio.

Reported by checkpatch:

WARNING: please write a help paragraph that fully describes the config
symbol
FILE: drivers/staging/vc04_services/bcm2835-audio/Kconfig:2

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 drivers/staging/vc04_services/bcm2835-audio/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/Kconfig b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
index d32ea348e846..7cd0b3c0cae4 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Kconfig
+++ b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
@@ -5,5 +5,8 @@ config SND_BCM2835
 	select SND_PCM
 	select BCM2835_VCHIQ
 	help
-	  Say Y or M if you want to support BCM2835 built in audio
+	  Say Y or M if you want to support BCM2835 built in audio.
+	  This driver handles both 3.5mm and HDMI audio. However, please
+	  note that when HDMI audio is enabled with this driver, the vc4
+	  driver cannot be used simultaneously, otherwise HDMI will break.
 
-- 
2.35.1

