Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BE44C355F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiBXTJu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Feb 2022 14:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiBXTJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:09:49 -0500
X-Greylist: delayed 284 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 11:09:15 PST
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C831C664B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:09:15 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 5AD592061832
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Denis Glazkov <d.glazkov@omp.ru>
CC:     Denis Glazkov <d.glazkov@omp.ru>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] PKCS#7: fix a possible memory leak when calculating the
 digest
Thread-Topic: [PATCH] PKCS#7: fix a possible memory leak when calculating the
 digest
Thread-Index: AQHYKbICJzAkgBxFjE+vdE8nJ6DgIg==
Date:   Thu, 24 Feb 2022 19:09:12 +0000
Message-ID: <20220224190838.144388-1-d.glazkov@omp.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.11.137]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MISSING_HEADERS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function `pkcs7_digest`, if there is an error allocating memory
for the `shash_desc` structure, the public key signature digest
remains unfreed.

Signed-off-by: Denis Glazkov <d.glazkov@omp.ru>
---
 crypto/asymmetric_keys/pkcs7_verify.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 0b4d07aa8811..e6f648dcc02a 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -50,7 +50,7 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 	ret = -ENOMEM;
 	sig->digest = kmalloc(sig->digest_size, GFP_KERNEL);
 	if (!sig->digest)
-		goto error_no_desc;
+		goto error_no_digest;
 
 	desc = kzalloc(desc_size, GFP_KERNEL);
 	if (!desc)
@@ -117,6 +117,8 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 error:
 	kfree(desc);
 error_no_desc:
+	kfree(sig->digest);
+error_no_digest:
 	crypto_free_shash(tfm);
 	kleave(" = %d", ret);
 	return ret;
-- 
2.25.1
