Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E959501827
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350307AbiDNQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358363AbiDNPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E9D9ECC7E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649949838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymoHjSbTJfTWENDrZAMakMAu3NTQlX8fnQuTkXZ1c+0=;
        b=NjM4/oM453w+Y3ZL2zQHem4spfK/U+l1r/IXAii8ukpXAHjIgsjwt7B96Ij/U1ddA9WkDw
        YjMiEpHphTq1kHEwSdLXnoFf1eV6h9fICqLT1tBq97/Lcs9Gqy82FygLLTDhmLCLze0xPU
        DCVy2ZRxsOosIxqGpm8VDVf0MRSWgY0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-NFF5WRSIMtWYdd1dkAKzXw-1; Thu, 14 Apr 2022 11:23:57 -0400
X-MC-Unique: NFF5WRSIMtWYdd1dkAKzXw-1
Received: by mail-qv1-f72.google.com with SMTP id o1-20020a0c9001000000b00440e415a3a2so4621963qvo.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymoHjSbTJfTWENDrZAMakMAu3NTQlX8fnQuTkXZ1c+0=;
        b=vg9gG2Vv+c2fyP3V6WwWAr/+3I9KgEnE34eksK0RRzuqS1QUU4Jhx7cLCLufgjBVUA
         sNoOxKgtF0xoltE9ZmXQAOEteq1oLCDV4UaK2LuRL3QjaPQHvJvuO316fzB3HIdzMcCx
         COIlSYF3lV9aq8BVScqXp6+q+PkZaE6WcMYz1D3Yt5SlvM2rlSNjeJEgwtEUY5RyMryB
         Uz115/m3h12BXfX7bZyenmhIjLd2H6lcKThptKYNtYEgOQIo7f6c6QPff8Jl2cJHItam
         k+mLwFrxDOpXZurCB7HkmFyLYbn1VTSQ8nvu7106rLBHuADz1BCWSGXh5quatI2ggdmB
         yznw==
X-Gm-Message-State: AOAM5313jhigNVLrPfDoKV0fXCl861mJ69abTWTEJkwpIgOKdgYP0sqQ
        xCBqBw7gjPvpYu4QQK4VtH5rHh9oC27TJFupiTu7RfNVQ1h7MfaatEhsc1TTnbRiBO5u0V96ub8
        F9FGprlyUHD000gd7oNYKVNtw
X-Received: by 2002:a05:622a:1793:b0:2e1:ba41:ed2 with SMTP id s19-20020a05622a179300b002e1ba410ed2mr2180116qtk.238.1649949836596;
        Thu, 14 Apr 2022 08:23:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs3AjMBWvnaeFFepMGw6xBfV7UrXSMsLV3Nf+VF6QIpa+RPOmd63l8E4yiuw2decacPo8cmQ==
X-Received: by 2002:a05:622a:1793:b0:2e1:ba41:ed2 with SMTP id s19-20020a05622a179300b002e1ba410ed2mr2180095qtk.238.1649949836406;
        Thu, 14 Apr 2022 08:23:56 -0700 (PDT)
Received: from fedora.redhat.com (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id p5-20020a378d05000000b0069beaffd5b3sm1166038qkd.4.2022.04.14.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 08:23:56 -0700 (PDT)
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
Subject: [PATCH 2/2] staging: bcm2835-audio: clean code style warnings
Date:   Thu, 14 Apr 2022 11:23:40 -0400
Message-Id: <20220414152340.68932-3-athierry@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414152340.68932-1-athierry@redhat.com>
References: <20220414152340.68932-1-athierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean a few minor code style warnings.

Reported by checkpatch:

CHECK: Lines should not end with a '('
FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:85:

CHECK: No space is necessary after a cast
FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:240:

CHECK: struct mutex definition without comment
FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:14:

CHECK: struct mutex definition without comment
FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835.h:64:

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c   | 5 ++---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c | 2 +-
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.h       | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index f2ef1d641e70..68e8d491a7ec 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -82,8 +82,7 @@ void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream,
 }
 
 /* open callback */
-static int snd_bcm2835_playback_open_generic(
-	struct snd_pcm_substream *substream, int spdif)
+static int snd_bcm2835_playback_open_generic(struct snd_pcm_substream *substream, int spdif)
 {
 	struct bcm2835_chip *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -237,7 +236,7 @@ static void snd_bcm2835_pcm_transfer(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
-	void *src = (void *) (substream->runtime->dma_area + rec->sw_data);
+	void *src = (void *)(substream->runtime->dma_area + rec->sw_data);
 
 	bcm2835_audio_write(alsa_stream, bytes, src);
 }
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index d567a2e3f70c..e429b33b4d39 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -11,7 +11,7 @@ struct bcm2835_audio_instance {
 	struct device *dev;
 	unsigned int service_handle;
 	struct completion msg_avail_comp;
-	struct mutex vchi_mutex;
+	struct mutex vchi_mutex; /* Serialize vchiq access */
 	struct bcm2835_alsa_stream *alsa_stream;
 	int result;
 	unsigned int max_packet;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 51066ac8eea5..38b7451d77b2 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -61,7 +61,7 @@ struct bcm2835_chip {
 
 	unsigned int opened;
 	unsigned int spdif_status;
-	struct mutex audio_mutex;
+	struct mutex audio_mutex; /* Serialize chip data access */
 
 	struct bcm2835_vchi_ctx *vchi_ctx;
 };
-- 
2.35.1

