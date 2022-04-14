Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A17501AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbiDNSUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344404AbiDNSUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58C15E38B4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649960264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zy+BZO4byiGtpgAVtL3WxpyUEL13EpkA7IKsqDx9JAE=;
        b=JPdlRJ7VSywEe/KXV4Uop8bfG87UORAXcOLICgcQGYip9RUgott2kDp0Dd8iTquXPFWOlT
        JmwQtg9pm5k6rvbcuY/U36+1tlWBh7sAHcPKd8hR35eLFRm4Mrt1vWDlOF/Qrd5vi/BOc8
        Xwj8Dt4Ut81PY58h/cBGGD5jks4QFuM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-nCvztXz1NmGjXEy7Ez72bw-1; Thu, 14 Apr 2022 14:17:43 -0400
X-MC-Unique: nCvztXz1NmGjXEy7Ez72bw-1
Received: by mail-qt1-f199.google.com with SMTP id z3-20020ac86b83000000b002ed0f18c23cso3711026qts.17
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:17:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zy+BZO4byiGtpgAVtL3WxpyUEL13EpkA7IKsqDx9JAE=;
        b=USWfA12yQ+CQ5kKiOaNji52OFMKZQdp80vnoma8P7z5D/qoCCa+uhoYApwCLc0IgA/
         mWHUrp3S89741fp1GP0n5iQ5hYfxQhY1xnOlimS2xOX9bV9Y8BVguMRNttF19A3s4wy2
         md5VqNmXrY7pTQGt4E5iRcmBF1cm8kcUHYcPgYD6N9enBJkdCdymW3T/7YppQenAEXdS
         flWihIETrpjJhJYR4rLiWgx7okF2ikTolHnkqW/Ymv9V78fmg9Md6Vv+0eAJQqtx6vYB
         PE/Z/txbF3u/9wuY1mzkMzdgtwoBC140uKPwpiJxC01ZsbSCvxZiR/jxyh5DyPGnqC//
         7V9A==
X-Gm-Message-State: AOAM530VTmy6AgYk1gIgV9cJXKa45P4i2rmvXsCE+lb/fEb3VZyGaVPt
        z+PxbcBFP0O4wVJrBHI7NMECHbQqHrr3vbtnT9ZRAuB5E2nOX43ZL1IkulYRPxrMmH4wp+D+jNI
        6yMB6afLSjISKC8kbQNXBzdrz
X-Received: by 2002:ac8:7f83:0:b0:2e1:df62:380c with SMTP id z3-20020ac87f83000000b002e1df62380cmr2818248qtj.427.1649960262928;
        Thu, 14 Apr 2022 11:17:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwulDgYN2XzG/gLG13Jj3INXMKsHc0v0l2aMhB1g0X7v8vggHhHUIziyZIXU72AkWg9yx8ExQ==
X-Received: by 2002:ac8:7f83:0:b0:2e1:df62:380c with SMTP id z3-20020ac87f83000000b002e1df62380cmr2818235qtj.427.1649960262737;
        Thu, 14 Apr 2022 11:17:42 -0700 (PDT)
Received: from fedora.redhat.com (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85845000000b002edfd4b0503sm1701816qth.88.2022.04.14.11.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:17:42 -0700 (PDT)
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
Subject: [PATCH v2 3/5] staging: bcm2835-audio: fix unnecessary space after cast
Date:   Thu, 14 Apr 2022 14:16:20 -0400
Message-Id: <20220414181622.102049-4-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414181622.102049-1-athierry@redhat.com>
References: <20220414181622.102049-1-athierry@redhat.com>
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

Fix issue reported by checkpatch:

CHECK: No space is necessary after a cast
FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:240:

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 856d3c022f80..68e8d491a7ec 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -236,7 +236,7 @@ static void snd_bcm2835_pcm_transfer(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
-	void *src = (void *) (substream->runtime->dma_area + rec->sw_data);
+	void *src = (void *)(substream->runtime->dma_area + rec->sw_data);
 
 	bcm2835_audio_write(alsa_stream, bytes, src);
 }
-- 
2.35.1

