Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040EC5956B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiHPJiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbiHPJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:38:07 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E592D8E1D
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:59:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ha11so9087834pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kvxJ31pMs7iubHIwtBMkPHRJw222fpBj25ImczwoxRk=;
        b=g1OnjbncFfK2BW8/IezCZRmKlCi1L4tXB4x0I02Mld2WTywa9Vf9KiTHGp+NOdhRKH
         pYy6Ne4MeQnU50Q5KeX6liGhp2EEKXA4x19KhxYZTKKi5kEzzNABlhepnkpBZSIqwsVN
         k9zLt2SvCwPaDrNmF+QIwsE8sAkTx1bd8otp+6EiuhnsENZzBDLUCgrxB8kbh1AM/KnJ
         eSmzVO0uLyxnUeYkh1m6kwARgVnqIZcX/KKXXX8e+CdLHbSSYS2i6/8TdAUOrqF+On2y
         F3F6ONZVP5DRBlbqAyKyu9+rIy88XUBKOHkgFwbI0aibsyTol/tDHrTItrgjgBDxAtdj
         t+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kvxJ31pMs7iubHIwtBMkPHRJw222fpBj25ImczwoxRk=;
        b=VNYni2d9p4XsckoptithdcGMq5y9sSf8EoPl33pe8CiuK794C3D3XjrVhc7xj0ar8+
         bh9LqLT42P0beOSz8mzxeEKCz47d7IPeOo73+k51MoYYDodRY+vJOCta+YUvJzcJLd8L
         8eD/ej06qBTUSlYKXj/qrPxHcKTGltbEjrsjgKExPMciuozSTIj63U3JdoZYFtpzCuI4
         oXQSqMhxEbJcPy0fs8iETIM4CfIFioPV/LnhdGhsaM6NHE8UY9KJjnS3S0AZOf7e75hx
         Hn3VXJ1n426UM+Ay59jAl3rnkxOZ0x/r1W/JlVRg69loxH6B43anudi33CJY6U48pKDj
         gu5g==
X-Gm-Message-State: ACgBeo2nSl/Hcb1ohW8gOJWzf2lpE5rvH4zj8NK8xpz+3E98T0YH672w
        GQRs0YOmLdMy0ipj3KbxDkhIzQ==
X-Google-Smtp-Source: AA6agR6q1iuy02bAx0HwOXInhdES5zIFbm3q7tFNcVwrq2sakYMaYPpShkuoobkVem5XFJBpgs8skQ==
X-Received: by 2002:a17:90b:164b:b0:1f5:15ae:3206 with SMTP id il11-20020a17090b164b00b001f515ae3206mr21921654pjb.140.1660636786654;
        Tue, 16 Aug 2022 00:59:46 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090a454200b001f280153b4dsm5631276pjm.47.2022.08.16.00.59.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Aug 2022 00:59:46 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     arei.gonglei@huawei.com, herbert@gondor.apana.org.au
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com, lei he <helei.sig11@bytedance.com>
Subject: [PATCH] crypto-virtio: fix memory-leak
Date:   Tue, 16 Aug 2022 15:59:16 +0800
Message-Id: <20220816075916.23651-1-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
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

Fix memory-leak for virtio-crypto akcipher request, this problem is
introduced by 59ca6c93387d3(virtio-crypto: implement RSA algorithm).
The leak can be reproduced and tested with the following script
inside virtual machine:

#!/bin/bash

LOOP_TIMES=10000

# required module: pkcs8_key_parser, virtio_crypto
modprobe pkcs8_key_parser # if CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
modprobe virtio_crypto # if CONFIG_CRYPTO_DEV_VIRTIO=m
rm -rf /tmp/data
dd if=/dev/random of=/tmp/data count=1 bs=230

# generate private key and self-signed cert
openssl req -nodes -x509 -newkey rsa:2048 -keyout key.pem \
		-outform der -out cert.der  \
		-subj "/C=CN/ST=GD/L=SZ/O=vihoo/OU=dev/CN=always.com/emailAddress=yy@always.com"
# convert private key from pem to der
openssl pkcs8 -in key.pem -topk8 -nocrypt -outform DER -out key.der

# add key
PRIV_KEY_ID=`cat key.der | keyctl padd asymmetric test_priv_key @s`
echo "priv key id = "$PRIV_KEY_ID
PUB_KEY_ID=`cat cert.der | keyctl padd asymmetric test_pub_key @s`
echo "pub key id = "$PUB_KEY_ID

# query key
keyctl pkey_query $PRIV_KEY_ID 0
keyctl pkey_query $PUB_KEY_ID 0

# here we only run pkey_encrypt becasuse it is the fastest interface
function bench_pub() {
	keyctl pkey_encrypt $PUB_KEY_ID 0 /tmp/data enc=pkcs1 >/tmp/enc.pub
}

# do bench_pub in loop to obtain the memory leak
for (( i = 0; i < ${LOOP_TIMES}; ++i )); do
	bench_pub
done

Signed-off-by: lei he <helei.sig11@bytedance.com>

# Please enter the commit message for your changes. Lines starting
# with '#' will be kept; you may remove them yourself if you want to.
# An empty message aborts the commit.
#
# Date:      Tue Aug 16 11:53:30 2022 +0800
#
# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
#   (use "git push" to publish your local commits)
#
# Changes to be committed:
#	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
#
# Untracked files:
#	cert.der
#	key.der
#	key.pem
#

# Please enter the commit message for your changes. Lines starting
# with '#' will be kept; you may remove them yourself if you want to.
# An empty message aborts the commit.
#
# Date:      Tue Aug 16 11:53:30 2022 +0800
#
# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
#   (use "git push" to publish your local commits)
#
# Changes to be committed:
#	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
#
# Untracked files:
#	cert.der
#	key.der
#	key.pem
#

# Please enter the commit message for your changes. Lines starting
# with '#' will be kept; you may remove them yourself if you want to.
# An empty message aborts the commit.
#
# Date:      Tue Aug 16 11:53:30 2022 +0800
#
# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
#   (use "git push" to publish your local commits)
#
# Changes to be committed:
#	modified:   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
#
# Untracked files:
#	cert.der
#	key.der
#	key.pem
#
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 2a60d0525cde..168195672e2e 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -56,6 +56,10 @@ static void virtio_crypto_akcipher_finalize_req(
 	struct virtio_crypto_akcipher_request *vc_akcipher_req,
 	struct akcipher_request *req, int err)
 {
+	kfree(vc_akcipher_req->src_buf);
+	kfree(vc_akcipher_req->dst_buf);
+	vc_akcipher_req->src_buf = NULL;
+	vc_akcipher_req->dst_buf = NULL;
 	virtcrypto_clear_request(&vc_akcipher_req->base);
 
 	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
-- 
2.20.1

