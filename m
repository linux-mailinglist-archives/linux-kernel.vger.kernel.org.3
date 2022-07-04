Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E954564BEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiGDC42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGDC4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:56:25 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B22A2C3;
        Sun,  3 Jul 2022 19:56:25 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 754061E80CCF;
        Mon,  4 Jul 2022 10:54:31 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zgr4wSerIevz; Mon,  4 Jul 2022 10:54:28 +0800 (CST)
Received: from node1.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C33531E80C90;
        Mon,  4 Jul 2022 10:54:28 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@nfschina.com,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] keys/keyring: Fix typo in string
Date:   Mon,  4 Jul 2022 10:56:10 +0800
Message-Id: <20220704025610.3834-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated ',' from string

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 security/keys/keyring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5e6a90760753..c6c47ca9b57d 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -460,7 +460,7 @@ static int keyring_read_iterator(const void *object, void *data)
 	struct keyring_read_iterator_context *ctx = data;
 	const struct key *key = keyring_ptr_to_key(object);
 
-	kenter("{%s,%d},,{%zu/%zu}",
+	kenter("{%s,%d},{%zu/%zu}",
 	       key->type->name, key->serial, ctx->count, ctx->buflen);
 
 	if (ctx->count >= ctx->buflen)
@@ -484,7 +484,7 @@ static long keyring_read(const struct key *keyring,
 	struct keyring_read_iterator_context ctx;
 	long ret;
 
-	kenter("{%d},,%zu", key_serial(keyring), buflen);
+	kenter("{%d},%zu", key_serial(keyring), buflen);
 
 	if (buflen & (sizeof(key_serial_t) - 1))
 		return -EINVAL;
-- 
2.18.2

