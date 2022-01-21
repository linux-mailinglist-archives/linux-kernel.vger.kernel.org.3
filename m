Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABBB495840
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 03:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378514AbiAUC0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 21:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378522AbiAUCZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 21:25:58 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97984C061746
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 18:25:58 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r11so6988299pgr.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 18:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/xLkpZ2sPhON9Uu4HwhEOk6KJqVId8ApNAzoWtNRra0=;
        b=nGMcYSi2ftHKX3ltcV11aTskHheSJFXB61BSAN7mJcfMxi3ks7XfA/UbpJASpA6pni
         pyVDdEHUYFBRNOD0Y7UWBLTWzJANO7N7TORmFFoY4jc+3DmM83CYImj/kX65S4S0/Wfr
         GyC1qmJIiAWNC5cpwFsfXQczfACjA1+NpL7Y0qDgw5sDYLuqfZXa9HvsaOFm/p4PWntv
         Ex7GhP6pWe3JOL0u+lCrlQyKVS1mxV2FIhCyalcQA+LGrPEtWTvXuOLuLW0Je/ITu4OE
         sfVr0BlOmRCM8BNFs7NBnubDgn89imVXx9jCsy97stVlK8kCGoRxDNt9Gp2XLRfrUaOj
         UyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/xLkpZ2sPhON9Uu4HwhEOk6KJqVId8ApNAzoWtNRra0=;
        b=8Ne8GVFtE+MlwEChYdJ1v3zXTCkEhhWgjrmDPM4/TdX6d2dysyyqfWRzHOuavKDAxT
         2JO9O6+SkoLu+DetWg3aOftL5eiBN/gTH2V9fSMIKeEN4GUW8SNGtdZd1mesGDABI05D
         BdKJ9zz+wooGkDf19ZYHJRoQtrVSJKxJSrRG2mXKd5ADO0V53icBTUi23hkHhbXl8As8
         sXYohncKdB8fA96ImkHDDdG+EQx+PwOWvGBWOYGNKBd6XxMZsY3rrcOAlD467dvw25lN
         eBCnbeIESSLVTcVbbTjQ/hsw1GzU2tKYa4pJUJ8zfi1gGE+SVDlWIVn/4Cj2XQKn0Rk8
         VS3A==
X-Gm-Message-State: AOAM531sV56yl64FUBv0J2jA1xd7HiImDDBNszC7qm55T8rhFOlAFELC
        tIVyFAxPe647Glulcu8zvYxnjg==
X-Google-Smtp-Source: ABdhPJyuwOBSEd1JIlhU+2G/71EkHDtbQ+C8B4IdLrFnoBXm0tR/YH1SqBMuk4mOyD8PnZkL/SnoRg==
X-Received: by 2002:a05:6a00:216f:b0:49f:dcb7:2bf2 with SMTP id r15-20020a056a00216f00b0049fdcb72bf2mr1973578pff.19.1642731958115;
        Thu, 20 Jan 2022 18:25:58 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.72])
        by smtp.gmail.com with ESMTPSA id h2sm5057577pfv.31.2022.01.20.18.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 18:25:57 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     mst@redhat.com, arei.gonglei@huawei.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        helei.sig11@bytedance.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/3] virtio-crypto: introduce akcipher service
Date:   Fri, 21 Jan 2022 10:24:37 +0800
Message-Id: <20220121022438.1042547-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121022438.1042547-1-pizhenwei@bytedance.com>
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce asymmetric service definition, asymmetric operations and
several well known algorithms.

Co-developed-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/uapi/linux/virtio_crypto.h | 99 +++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
index 1166a49084b0..050578d61d85 100644
--- a/include/uapi/linux/virtio_crypto.h
+++ b/include/uapi/linux/virtio_crypto.h
@@ -33,10 +33,11 @@
 #include <linux/virtio_config.h>
 
 
-#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
-#define VIRTIO_CRYPTO_SERVICE_HASH   1
-#define VIRTIO_CRYPTO_SERVICE_MAC    2
-#define VIRTIO_CRYPTO_SERVICE_AEAD   3
+#define VIRTIO_CRYPTO_SERVICE_CIPHER   0
+#define VIRTIO_CRYPTO_SERVICE_HASH     1
+#define VIRTIO_CRYPTO_SERVICE_MAC      2
+#define VIRTIO_CRYPTO_SERVICE_AEAD     3
+#define VIRTIO_CRYPTO_SERVICE_AKCIPHER 4
 
 #define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
 
@@ -57,6 +58,10 @@ struct virtio_crypto_ctrl_header {
 	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
 #define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
 	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
+#define VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x04)
+#define VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x05)
 	__le32 opcode;
 	__le32 algo;
 	__le32 flag;
@@ -180,6 +185,57 @@ struct virtio_crypto_aead_create_session_req {
 	__u8 padding[32];
 };
 
+struct virtio_crypto_rsa_session_para {
+#define VIRTIO_CRYPTO_RSA_RAW_PADDING   0
+#define VIRTIO_CRYPTO_RSA_PKCS1_PADDING 1
+	__le32 padding_algo;
+
+#define VIRTIO_CRYPTO_RSA_NO_HASH   0
+#define VIRTIO_CRYPTO_RSA_MD2       1
+#define VIRTIO_CRYPTO_RSA_MD3       2
+#define VIRTIO_CRYPTO_RSA_MD4       3
+#define VIRTIO_CRYPTO_RSA_MD5       4
+#define VIRTIO_CRYPTO_RSA_SHA1      5
+#define VIRTIO_CRYPTO_RSA_SHA256    6
+#define VIRTIO_CRYPTO_RSA_SHA384    7
+#define VIRTIO_CRYPTO_RSA_SHA512    8
+#define VIRTIO_CRYPTO_RSA_SHA224    9
+	__le32 hash_algo;
+};
+
+struct virtio_crypto_ecdsa_session_para {
+#define VIRTIO_CRYPTO_CURVE_UNKNOWN   0
+#define VIRTIO_CRYPTO_CURVE_NIST_P192 1
+#define VIRTIO_CRYPTO_CURVE_NIST_P224 2
+#define VIRTIO_CRYPTO_CURVE_NIST_P256 3
+#define VIRTIO_CRYPTO_CURVE_NIST_P384 4
+#define VIRTIO_CRYPTO_CURVE_NIST_P521 5
+	__le32 curve_id;
+};
+
+struct virtio_crypto_akcipher_session_para {
+#define VIRTIO_CRYPTO_NO_AKCIPHER    0
+#define VIRTIO_CRYPTO_AKCIPHER_RSA   1
+#define VIRTIO_CRYPTO_AKCIPHER_DSA   2
+#define VIRTIO_CRYPTO_AKCIPHER_ECDSA 3
+	__le32 algo;
+
+#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC  1
+#define VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE 2
+	__le32 keytype;
+	__le32 keylen;
+
+	union {
+		struct virtio_crypto_rsa_session_para rsa;
+		struct virtio_crypto_ecdsa_session_para ecdsa;
+	} u;
+};
+
+struct virtio_crypto_akcipher_create_session_req {
+	struct virtio_crypto_akcipher_session_para para;
+	__u8 padding[36];
+};
+
 struct virtio_crypto_alg_chain_session_para {
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
 #define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
@@ -247,6 +303,8 @@ struct virtio_crypto_op_ctrl_req {
 			mac_create_session;
 		struct virtio_crypto_aead_create_session_req
 			aead_create_session;
+		struct virtio_crypto_akcipher_create_session_req
+			akcipher_create_session;
 		struct virtio_crypto_destroy_session_req
 			destroy_session;
 		__u8 padding[56];
@@ -266,6 +324,14 @@ struct virtio_crypto_op_header {
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
 #define VIRTIO_CRYPTO_AEAD_DECRYPT \
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
+#define VIRTIO_CRYPTO_AKCIPHER_ENCRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x00)
+#define VIRTIO_CRYPTO_AKCIPHER_DECRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x01)
+#define VIRTIO_CRYPTO_AKCIPHER_SIGN \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x02)
+#define VIRTIO_CRYPTO_AKCIPHER_VERIFY \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x03)
 	__le32 opcode;
 	/* algo should be service-specific algorithms */
 	__le32 algo;
@@ -390,6 +456,16 @@ struct virtio_crypto_aead_data_req {
 	__u8 padding[32];
 };
 
+struct virtio_crypto_akcipher_para {
+	__le32 src_data_len;
+	__le32 dst_data_len;
+};
+
+struct virtio_crypto_akcipher_data_req {
+	struct virtio_crypto_akcipher_para para;
+	__u8 padding[40];
+};
+
 /* The request of the data virtqueue's packet */
 struct virtio_crypto_op_data_req {
 	struct virtio_crypto_op_header header;
@@ -399,16 +475,18 @@ struct virtio_crypto_op_data_req {
 		struct virtio_crypto_hash_data_req hash_req;
 		struct virtio_crypto_mac_data_req mac_req;
 		struct virtio_crypto_aead_data_req aead_req;
+		struct virtio_crypto_akcipher_data_req akcipher_req;
 		__u8 padding[48];
 	} u;
 };
 
-#define VIRTIO_CRYPTO_OK        0
-#define VIRTIO_CRYPTO_ERR       1
-#define VIRTIO_CRYPTO_BADMSG    2
-#define VIRTIO_CRYPTO_NOTSUPP   3
-#define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
-#define VIRTIO_CRYPTO_NOSPC     5 /* no free session ID */
+#define VIRTIO_CRYPTO_OK            0
+#define VIRTIO_CRYPTO_ERR           1
+#define VIRTIO_CRYPTO_BADMSG        2
+#define VIRTIO_CRYPTO_NOTSUPP       3
+#define VIRTIO_CRYPTO_INVSESS       4 /* Invalid session id */
+#define VIRTIO_CRYPTO_NOSPC         5 /* no free session ID */
+#define VIRTIO_CRYPTO_KEY_REJECTED  6 /* Signature verification failed */
 
 /* The accelerator hardware is ready */
 #define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
@@ -442,6 +520,7 @@ struct virtio_crypto_config {
 	__le32 reserve;
 	/* Maximum size of each crypto request's content */
 	__le64 max_size;
+	__le32 akcipher_algo;
 };
 
 struct virtio_crypto_inhdr {
-- 
2.25.1

