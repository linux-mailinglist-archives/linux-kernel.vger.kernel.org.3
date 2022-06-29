Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D30755FD5A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiF2K2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiF2K2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:28:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03C43DDC2;
        Wed, 29 Jun 2022 03:27:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v14so21718887wra.5;
        Wed, 29 Jun 2022 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hg8Agbq4mVHkuTg7yeofSNYUTSRLwIyIHLfG6qwLBeg=;
        b=C2+TpVRiRBe2BxVymZqGsxLurT1OGPL4h9CO7oXcP10zEMb9H+IkUGNt009IJBTPIl
         JuaPnxje+CkdkVqBA4DT0qFHjEWuLcYsRtmtri7KMZMoJeMDBTKtBDI6wSiiy9d+N9Kl
         wl677uKYKqdlFB1f0a6Yp2tRuesScdWfAGt1StvCbFTwl7+b+CTBoV6BonSeD/6A5ocG
         cQaPgSQ8QXadw70bCmjkeqpNp78DhvHiqy4uBhfra3whguxCyfv8/CAdwtA2HHolYwaS
         KKwkzdZnHPY4h5CjbD7/UKWWHDpoSP1tK+K54DPPxBAUicXxwDOU1gLI9EcKlXrBPkJJ
         ChMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hg8Agbq4mVHkuTg7yeofSNYUTSRLwIyIHLfG6qwLBeg=;
        b=RJuIDeAO2GgJj2psUPIPdQrdvMoy8NIH9KS+3c/fOUkew3q3QW9nITL5bYIlyo0oq2
         p+NqiKS6q8paiF/XtIvq9OJWEYhs7k1ay5q/+fxqaTpLrOnIMqo66Nn4Yxn3JsEFISPq
         vp6OcOMMe8peygr9kDInpWg11xodVvC78rVQ73wtKOxuqk2aViGOBaWNi0GKV8kLIxTM
         3iTFg8VZ0037vuqqry96cEv8biWykxL8RY7afl0HYPRMuF7crA2q745udtrVNuI77FEU
         shHQnF+fXUvuezgPNnrhzSvRkPxtOvOXI9ccmtoHQryn1QYyHAydsOvBsx0iDK2Z+8jv
         ZGNQ==
X-Gm-Message-State: AJIora+0HS5Vn+CNTm8edixcYSVHGaHQeS02rnxqbcoIEdTrpcSl5MvW
        ibpZEfV/2HXZ//FbtOOFIHg=
X-Google-Smtp-Source: AGRyM1ufw2P/OIzIfF6EchFfqB3P0dWO5nbggmQs0aSA+PHDT+se1HLVPrFSvZuGO2P//WpKNJCfFQ==
X-Received: by 2002:a5d:43cd:0:b0:21b:8e53:befe with SMTP id v13-20020a5d43cd000000b0021b8e53befemr2397726wrr.255.1656498467106;
        Wed, 29 Jun 2022 03:27:47 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q13-20020adfcd8d000000b00219b391c2d2sm19268969wrj.36.2022.06.29.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 03:27:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: wavefront: remove redundant assignment to pointer end
Date:   Wed, 29 Jun 2022 11:27:43 +0100
Message-Id: <20220629102744.139673-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Pointer end is being re-assigned the same value as it was initialized
with in the previous statement. The re-assignment is redundant and
can be removed.

Cleans up clang scan-build warning:
sound/isa/wavefront/wavefront_synth.c:582:17: warning: Value stored
to 'end' during its initialization is never read

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/isa/wavefront/wavefront_synth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index 2aaaa6807174..13ce96148fa3 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -581,8 +581,6 @@ demunge_buf (unsigned char *src, unsigned char *dst, unsigned int src_bytes)
 	int i;
 	unsigned char *end = src + src_bytes;
     
-	end = src + src_bytes;
-
 	/* NOTE: src and dst *CAN* point to the same address */
 
 	for (i = 0; src != end; i++) {
-- 
2.35.3

