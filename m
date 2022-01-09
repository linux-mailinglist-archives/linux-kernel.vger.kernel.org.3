Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8563488AEF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbiAIRT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:19:57 -0500
Received: from m12-11.163.com ([220.181.12.11]:28515 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236161AbiAIRT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:19:56 -0500
X-Greylist: delayed 948 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jan 2022 12:19:55 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=/3u4u8Sx8RQrVhoBwH
        sSEkpcdFoYJP3wCDfinFuxldY=; b=iJUj2xn7ijz84WUkFgFVjRlU2wC2Bb4Ynt
        Jl7jR50ddLMEl/qkkqtcpMMcA6wq8GTFEERS77jDV2dvBHnoRAJy/iDpK9WU+8iL
        SjdaDwdNNq8vt8CkoXoyPE2J3dxN9agkQRZaXk6iopLzXOR2pUrRL+N+x20hewOO
        +a9sq3fsU=
Received: from ubuntu.localdomain (unknown [115.171.170.5])
        by smtp7 (Coremail) with SMTP id C8CowADnDMovFdthAi5jPQ--.10064S2;
        Mon, 10 Jan 2022 01:02:40 +0800 (CST)
From:   Peng Luo <wuhanluop@163.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        terrelln@fb.com, linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Luo <wuhanluop@163.com>
Subject: [PATCH] crypto: testmgr - fix some wrong vectors of aes-ccm
Date:   Mon, 10 Jan 2022 01:02:39 +0800
Message-Id: <20220109170239.4322-1-wuhanluop@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowADnDMovFdthAi5jPQ--.10064S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryrKFyDJFykCr15tw1DKFg_yoW8WrWDpr
        Z7JFWjyFWDWa4rKF1UJw4UGF47Wr9Ivws7u3W8J3s7GF13Gw1rZFW2kw10qF1DWFykCr45
        ArWUAry5uw43trDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul1v-UUUUU=
X-Originating-IP: [115.171.170.5]
X-CM-SenderInfo: pzxkt0hoxr1qqrwthudrp/1tbiEBCD9F8YI7XEFAAAs2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some vectors of aes-ccm are wrong.
This patch has been tested with kernel 4.9 and openssl1.1.1k.

Signed-off-by: Peng Luo <wuhanluop@163.com>
---
 crypto/testmgr.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index a253d66ba1c1..ff171fe53979 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -19865,8 +19865,8 @@ static const struct aead_testvec aes_ccm_tv_template[] = {
 			  "\xd0\xd1\x3d\x1a\xa3\x6d\xe4\x0a"
 			  "\x86\xb0\x87\x6b\x62\x33\x8c\x34"
 			  "\xce\xab\x57\xcc\x79\x0b\xe0\x6f"
-			  "\x5c\x3e\x48\x1f\x6c\x46\xf7\x51"
-			  "\x8b\x84\x83\x2a\xc1\x05\xb8\xc5",
+			  "\xCF\xE9\xF9\x21\x3C\x1A\xCE\x67"
+			  "\x62\x7B\x36\x3A\xEA\x19\xAC\x58",
 		.clen	= 48,
 		.novrfy	= 1,
 	}, {
@@ -19952,8 +19952,8 @@ static const struct aead_testvec aes_ccm_tv_template[] = {
 			  "\xc6\x0e\x6e\xe5\xd6\x98\xa6\x37"
 			  "\x8c\x26\x33\xc6\xb2\xa2\x17\xfa"
 			  "\x64\x19\xc0\x30\xd7\xfc\x14\x6b"
-			  "\xe3\x33\xc2\x04\xb0\x37\xbe\x3f"
-			  "\xa9\xb4\x2d\x68\x03\xa3\x44\xef",
+			  "\x08\x5A\x20\x4A\xB0\x2C\xF9\x49"
+			  "\x10\x1C\x9C\x85\x8C\x12\xE0\x3A",
 		.clen	= 48,
 		.novrfy	= 1,
 	}, {
@@ -19983,7 +19983,7 @@ static const struct aead_testvec aes_ccm_tv_template[] = {
 			  "\x3e\xaf\x70\x5e\xb2\x4d\xea\x39"
 			  "\x89\xd4\x75\x7a\x63\xb1\xda\x93",
 		.plen	= 32,
-		.ctext	= "\x48\x01\x5e\x02\x24\x04\x66\x47"
+		.ctext	= "\x14\x01\x5e\x02\x24\x04\x66\x47"
 			  "\xa1\xea\x6f\xaf\xe8\xfc\xfb\xdd"
 			  "\xa5\xa9\x87\x8d\x84\xee\x2e\x77"
 			  "\xbb\x86\xb9\xf5\x5c\x6c\xff\xf6"
-- 
2.17.1

