Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21996501AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245346AbiDNSUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344395AbiDNSUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA40BE3884
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649960262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=azZFyvbXbsRrL2GrJ7PQeirmm3t2q04DjeZIVAP8lC0=;
        b=JbPSQfAW6ZkXqO8ZJrpaf4NLismXY+/05EP/S37ixzlpKqWD4r+0CCKO9vWRCilCBYpHzT
        mCO3JQZYi7rN/tlO3pOaQTp528p4zfKHNsLzqLMF44YVx1rSKob/OmkXs04yKNIoUnFtmA
        i3lGCyHeemk28TaTf3gJ/GyiGsO/q+Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-paO6HHR0P-ahh3NnDDWk0A-1; Thu, 14 Apr 2022 14:17:41 -0400
X-MC-Unique: paO6HHR0P-ahh3NnDDWk0A-1
Received: by mail-qk1-f198.google.com with SMTP id bk23-20020a05620a1a1700b0067b32f93b90so3794869qkb.16
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azZFyvbXbsRrL2GrJ7PQeirmm3t2q04DjeZIVAP8lC0=;
        b=J8z9fzmF312o3d/aoeE8zXvWpptnwVHJgTUyHNOXyJq8lR4X21pW5cUfpxEi+MaQhu
         EQpSlsbbF0CkfazViMzqaXbitoFhOf/N/2tPrlWnWneZlEs7UiVoVQznkYL44blCFvfh
         cm1FFLckzAuZiOS4t+InpL983dFr0fjXA7Ka3cuPKHNhm2u9I2+LbOZiHNWRGfXuxNjI
         z1QretXAoHaSvInMFV8pdkcqDZKKdKYU1vO9JRSbFOQBhn7hAfO0zjg+6TvKz2puZaCG
         uIbgVUmUUrJf6UAyVvfgrNmvWVEm9/e0G8Kyy2OduORHXy46bzNy0fTM6p0RvUpzHNif
         PRPQ==
X-Gm-Message-State: AOAM533blhVLdmySDikuHj/GLr0n7UvngzFj2XQzyPZvPUQLYTkGTBMg
        CYJF7Gx0T36Ubw25XC3DVCu6w9DIvJ+PJfAgmd1Si8aUG84pDqXr9csIthjFKmI02iKDuN6C8aI
        fC4T7XWu9Hg735Cm8iY7DLYWv
X-Received: by 2002:a05:6214:2607:b0:444:3e1c:9491 with SMTP id gu7-20020a056214260700b004443e1c9491mr4658506qvb.12.1649960261423;
        Thu, 14 Apr 2022 11:17:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPFI9LaNCqQ5DDacyUpStgLvPbYlekuXV70UXl0i1kqJef4wmHRnyufxpuU13B2NmCskEb1g==
X-Received: by 2002:a05:6214:2607:b0:444:3e1c:9491 with SMTP id gu7-20020a056214260700b004443e1c9491mr4658476qvb.12.1649960261204;
        Thu, 14 Apr 2022 11:17:41 -0700 (PDT)
Received: from fedora.redhat.com (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85845000000b002edfd4b0503sm1701816qth.88.2022.04.14.11.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:17:40 -0700 (PDT)
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
Subject: [PATCH v2 2/5] staging: bcm2835-audio: fix line ending with '('
Date:   Thu, 14 Apr 2022 14:16:19 -0400
Message-Id: <20220414181622.102049-3-athierry@redhat.com>
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

CHECK: Lines should not end with a '('
FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:85:

Signed-off-by: Adrien Thierry <athierry@redhat.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index f2ef1d641e70..856d3c022f80 100644
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
-- 
2.35.1

