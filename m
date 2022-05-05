Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280CB51BC28
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiEEJda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354424AbiEEJc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:32:28 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A330153B50
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:28:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i24so3197510pfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 02:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWUmfRvGF2BB+VZsTwGLae04hlnLvJ88GBm4mvPdVfY=;
        b=H6GLIk6bwodWrBOYEDm4+3SJj4/BTDn+p3oSwWbxAEs9y8gq3fek8GOJlclMDdwUiv
         dHCe0nAEw4q60SaI6Vv69CYld5DHxwZSv1FTzqAUDuUvgWdtnsTq1bAWD7Rn/HJ9a65K
         MmWUiUEDQVYmZAMyzpzWK8VaqlxJ7HqHCyFFf5L8Plp4mUb5e3sOgAFADcTR/UxPEUvH
         rTgsGzYxMrdowQPHybdiBUZho2Kin9IpZLk7nE8sbllOLvFhPVlQ2SxocQd0wQ8HmulW
         61sQcCyCwlrSToHRrP8m9cP9k4vziMrARbTX2DIG1E39DPCD6eQ7KcerTR0hDdc7McPw
         w7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWUmfRvGF2BB+VZsTwGLae04hlnLvJ88GBm4mvPdVfY=;
        b=HiawKx9CGcslc0ofQPRhovOmKOEtMP0vNq1xQbxKbACN4esgTCDAbp/5NDe/BrZs9R
         3N8snzAMXQyZ7uYXZctUd0RqIvo6rc7nbY1DpdEinlG+SBCdBossJVFpTI3Q38FiRw6Z
         GtvKSdDiq/eYP+xq2dMoT+99NCwde9AgbnzgETR0cTkL7aNaZSdG+FTnJLFIUMu3K8ZH
         K0zAj0TSJu26iLv9lG1eAbSKktFoN4JlgVT1dBj14mls9xy1p8pSEF5AfImaal15l3gU
         udXMzzHiverXxU8klhzL3AiSiGMDTwN0jNRD0FXhI9IUlSa87vx2mvy/IrbcPnRziJTk
         suQw==
X-Gm-Message-State: AOAM531zh1mnA528UhOInZIw607Q6zQKdKUkXdORsXT6zIqMOyD7Sdz0
        jYKUiVhrqLna7N+VzOctGsJ6YA==
X-Google-Smtp-Source: ABdhPJy0arwU8vCS8L/uqGSWrM7EpznmQ61YconxXJuGXjqJbFk5NzLR7b0Un/RvHp3HP83OWpdBFw==
X-Received: by 2002:a05:6a00:22c6:b0:510:3c78:638d with SMTP id f6-20020a056a0022c600b005103c78638dmr7293480pfj.54.1651742904156;
        Thu, 05 May 2022 02:28:24 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id t68-20020a625f47000000b0050dc76281dcsm884224pfb.182.2022.05.05.02.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 02:28:23 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        pizhenwei@bytedance.com, davem@davemloft.net
Subject: [PATCH v5 4/5] virtio-crypto: adjust dst_len at ops callback
Date:   Thu,  5 May 2022 17:24:07 +0800
Message-Id: <20220505092408.53692-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505092408.53692-1-pizhenwei@bytedance.com>
References: <20220505092408.53692-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lei he <helei.sig11@bytedance.com>

For some akcipher operations(eg, decryption of pkcs1pad(rsa)),
the length of returned result maybe less than akcipher_req->dst_len,
we need to recalculate the actual dst_len through the virt-queue
protocol.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 382ccec9ab12..2a60d0525cde 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -90,9 +90,12 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 	}
 
 	akcipher_req = vc_akcipher_req->akcipher_req;
-	if (vc_akcipher_req->opcode != VIRTIO_CRYPTO_AKCIPHER_VERIFY)
+	if (vc_akcipher_req->opcode != VIRTIO_CRYPTO_AKCIPHER_VERIFY) {
+		/* actuall length maybe less than dst buffer */
+		akcipher_req->dst_len = len - sizeof(vc_req->status);
 		sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
 				    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
+	}
 	virtio_crypto_akcipher_finalize_req(vc_akcipher_req, akcipher_req, error);
 }
 
-- 
2.20.1

