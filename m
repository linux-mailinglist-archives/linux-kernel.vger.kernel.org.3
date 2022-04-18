Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20D6504E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbiDRJHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiDRJHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:07:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4FF13DFC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 02:04:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t12so11867602pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGycGFvEc/grEUwBLjN4FrsuSMK10Ph1TJa/0rHLB00=;
        b=SyqgyxdXATvl1tqV7yph+r4Ov29FnV+LuEYRD3cNUQbaEnKLSOmMXI7R9KN2yxV6OR
         LjumbVKsA9Bzn676oEXHvjHFXu1CDjVvtFd6wJxz/NOtDrfukBxwmRP2wwHWScH+hGgh
         hbWTgSDqaLGqkLhNPNYBZNqiR2ZnSJ5R3Mft1zvXK05rWjuGXmJMH3srjGuX4D834G/E
         YrASL7u82Pj5BEv1wNW/7TMbIO+uC9JFCvPe6cwD0wYb9NXyFVAw20WUL8v7oQrlwg+y
         ZoF45RADFCEW+dDKIM+plRx6Bloo7DSGc6vK6v/Ckv2g3S++SN80sfYi5E0N+MDY4bSi
         SKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGycGFvEc/grEUwBLjN4FrsuSMK10Ph1TJa/0rHLB00=;
        b=UwKTa/1F7Bjc1CkO/eDbAPcWmDi9hcVoh0tW0KGxNgOblx1OE7ny0g1cPzyhgkQ+PJ
         DqGQSNiio9wa9r2CVQNYeFjbvRJI10YhuIGcJOB+g70Sf/yYOJeodb3N8JhnW5PufNZR
         78XXqD5yVWgLLErLf6Wzu2QxhxPeiBHJJ7bUyv7NfqW4Zkd3iQsFka8cz2+x01xXgDFu
         O0zgYBmKRUrk4AF/bpt4nXOppY3P8WWRlILxfa5Vvk4ttkEJDu+TsCdjh09q/FdIIMDt
         SV/8WYje+6lyxnHxVFtL/6YUeRi8NKNfFgVpW6k7WS1ScRHi6BkqVbK4rt14r6M1SZu7
         KOSg==
X-Gm-Message-State: AOAM533F4+diTREY3SNfX9CCMgIZOZnSzAioCGUH0D+Eip6LDEfB9+PO
        To7SwTQMNTg91C5ajPaSXT34dg==
X-Google-Smtp-Source: ABdhPJzl0keGE9CDZ9JEYQSKw/oJDMmcnJw0PJyud+pyqmk6lmwwYeDI+kw+cMA+ac6eAWEccD+O7g==
X-Received: by 2002:a17:903:40ce:b0:158:8178:8563 with SMTP id t14-20020a17090340ce00b0015881788563mr9800299pld.167.1650272683819;
        Mon, 18 Apr 2022 02:04:43 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a7f9500b001c97c6bcaf4sm16408071pjl.39.2022.04.18.02.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 02:04:43 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, lei he <helei@bytedance.com>,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 3/4] virtio-crypto: adjust dst_len at ops callback
Date:   Mon, 18 Apr 2022 17:00:50 +0800
Message-Id: <20220418090051.372803-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418090051.372803-1-pizhenwei@bytedance.com>
References: <20220418090051.372803-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lei he <helei@bytedance.com>

For some akcipher operations(eg, decryption of pkcs1pad(rsa)),
the length of returned result maybe less than akcipher_req->dst_len,
we need to recalculate the actual dst_len through the virt-queue
protocol.

Signed-off-by: lei he <helei@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 9561bc2df62b..82db86e088c2 100644
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

