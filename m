Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76FD49583B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 03:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378524AbiAUCZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 21:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378504AbiAUCZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 21:25:55 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7ADC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 18:25:54 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so7827486pja.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 18:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H7JmmzsPHQSuzWfJZBXSsb0PJRIcxpIGkWIutdwXFtA=;
        b=g6wmR3YSYiAG6LPeb3AVbb1wA5Qv46BXNPRJkhm1eu9hOAd0vkfA9zIVArLOIDmuBe
         03oia1PpJzgI79TVu/ukcHl6i4FL9UTeSASpS9aBQG/yRqHDEmIfxzMJOEErPZd40TeD
         dlmFX5FyZGVhrCi5MoVkMNkwWEvgptbpJXVZygvtgL/IIN4T2HcUeURcrOh0YW4ST0s6
         wrneQ05e9SxVFiRgboyRg7XapdvXXKO8TvUDlQeF663uqSTLxgQP13jGLztbUaAiM/KT
         1LReyxJ7Xm5gfrEY5Rx3wTEFcr9C60KRx/UAL06uscltGmQFbogoOakiGPTzMr0V5QrN
         u6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H7JmmzsPHQSuzWfJZBXSsb0PJRIcxpIGkWIutdwXFtA=;
        b=1mCa72QkBckVyWqjloAfO4cSJbsbej1m7OVmzFBWWth/nOvqQwrDLQNatds1vcRG2w
         tHC2mTnw6heV0PeEf8GLHmi3LoNWbG/zC9MZtS5dDcmemyOInCNYCQpqxF4W/RdbiFr6
         GTUZ/W0SZ0gO9H+rbLB0LctToj82GR1TJyjlYRmAVfgq936DJcveDaigGLC/jH1KUbxW
         IwS4TPrRhvmMsc5Hlc8Oj9+n9a2JnwbTKkD7mON4yS1D+YdxNlaTOdSy8PwSJ+GEW68f
         6LMPtrUKACCF7nT+LT/RdpKSKDPGYWcw2x8UTQDJIeeLfk7dQZGFC7AHyZoAZe+p+a1E
         w4GQ==
X-Gm-Message-State: AOAM533OUG87hMan8wOu9fXb3fiFLGl1sYnPP5Xm5kABpQR/0t/oJf7P
        W2jUNLjEyD2Hahd1GnUtI5AgMQ==
X-Google-Smtp-Source: ABdhPJwRy1SsjpaeBdGt8J2kb5KCSENFUecVPfqV558TVUh7PJhLtSmTBd0uAVSaqQkHmiA1DmFvWA==
X-Received: by 2002:a17:902:bd87:b0:14a:adaa:87ea with SMTP id q7-20020a170902bd8700b0014aadaa87eamr2038644pls.171.1642731954510;
        Thu, 20 Jan 2022 18:25:54 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.72])
        by smtp.gmail.com with ESMTPSA id h2sm5057577pfv.31.2022.01.20.18.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 18:25:54 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     mst@redhat.com, arei.gonglei@huawei.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        helei.sig11@bytedance.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/3] virtio_crypto: Introduce VIRTIO_CRYPTO_NOSPC
Date:   Fri, 21 Jan 2022 10:24:36 +0800
Message-Id: <20220121022438.1042547-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121022438.1042547-1-pizhenwei@bytedance.com>
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Base on the lastest virtio crypto spec, define VIRTIO_CRYPTO_NOSPC.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/uapi/linux/virtio_crypto.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
index a03932f10565..1166a49084b0 100644
--- a/include/uapi/linux/virtio_crypto.h
+++ b/include/uapi/linux/virtio_crypto.h
@@ -408,6 +408,7 @@ struct virtio_crypto_op_data_req {
 #define VIRTIO_CRYPTO_BADMSG    2
 #define VIRTIO_CRYPTO_NOTSUPP   3
 #define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
+#define VIRTIO_CRYPTO_NOSPC     5 /* no free session ID */
 
 /* The accelerator hardware is ready */
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
-- 
2.25.1

