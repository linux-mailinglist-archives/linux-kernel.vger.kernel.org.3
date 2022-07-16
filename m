Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F418957716A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 22:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiGPUjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 16:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPUjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 16:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54797BF74
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658003971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mhSFEuZeknUQVfzPSwX5MfJdkj3OYdP96/1A6PpGU/U=;
        b=gJcWSynuam2e3m2iT24E58qFO4E/o1gYgrdrBLhgNhrD9YltwtM7yuFzROAIvbgUMwi7W6
        tv2M9KRC+GXiECXL7pGisWAkVHRqqCH2x6HL0ERhfEJj0umc3dEU3tmHfqrFC8/c+RG9H3
        U08szdqqg0Y73Tut2aCVLc7P+Xi5SVE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-7kFC5uK8NE-sV3jdNI_jNA-1; Sat, 16 Jul 2022 16:39:30 -0400
X-MC-Unique: 7kFC5uK8NE-sV3jdNI_jNA-1
Received: by mail-qk1-f199.google.com with SMTP id s9-20020a05620a254900b006b54dd4d6deso6154691qko.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 13:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhSFEuZeknUQVfzPSwX5MfJdkj3OYdP96/1A6PpGU/U=;
        b=viC7V3wOK4kUuP5XjRtOHSEPhchRa46V7wpM4V2HzAje7dtHX+ZxP4BYKpFuNoNnMG
         ChmQI+VGcyYlS3r9V6FW7gaestPKQDjLtYqTRYXmElDtXZr8/V1Y8PGrNIbbGo3tfz5L
         CVlKRaEgf/tUV+5LrS54hQcM7MimSFXINo8ANg+w/+RJoRLdU2YugwyUyDw636Wcn4hW
         NbKGOdO6dX5SisQRGW0IlmR/tiiIypKKoAktmR9y3gJbnW9tzxul5cA8FT8fRhcafriC
         BWVMHQq/CPMQzJKInbYOkR8B1JGMqclfmSbFMgRbl0+lgHy0wrYRogvnpllVzQQrsXo8
         /+ag==
X-Gm-Message-State: AJIora/ap8qh0KpA+PoWspfViW2ElOZdQN6ZCCKHnoCAJxbZfYUluwye
        /1IURfFkC4BvyUqmMMMpqWoNs3uBFSZLbBWk27mRlrIDAtFilWLTDXX5x3BrYV18d+C6KoIjJ2X
        RltgmuWgsGRBrnQO2Wf7Ta36E
X-Received: by 2002:a05:620a:2a10:b0:6b5:e07b:427f with SMTP id o16-20020a05620a2a1000b006b5e07b427fmr1674267qkp.398.1658003969673;
        Sat, 16 Jul 2022 13:39:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sB76mCLZRt/21ZXI6v1fh8xyd739UV3uY6W+wFcWGPj9yOrUUwer2A0FmdnFEZjO2sE337kQ==
X-Received: by 2002:a05:620a:2a10:b0:6b5:e07b:427f with SMTP id o16-20020a05620a2a1000b006b5e07b427fmr1674258qkp.398.1658003969432;
        Sat, 16 Jul 2022 13:39:29 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a404a00b006b2849cdd37sm7716477qko.113.2022.07.16.13.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 13:39:29 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     nathan@kernel.org, ndesaulniers@google.com, sagi@grimberg.me,
        hare@suse.de
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nvme-auth: fix input checking
Date:   Sat, 16 Jul 2022 16:39:24 -0400
Message-Id: <20220716203924.2248841-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang build fails with this representative error
drivers/nvme/common/auth.c:59:31: error: address of array 'dhgroup_map[dhgroup_id].name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
            !dhgroup_map[dhgroup_id].name ||
            ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~

Input is checked with this pattern
  if (i > ARRAY_SIZE(a))
    fail
  return a[i].x

This is an off-by-one bug.  Change to
  if (i < ARRAY_SIZE(a)
    return a[i].x
  return fail

By specifying the 'name' element of the nvme_auth_dhgroup_map struct as
a constant, pre sized array, it will be never be NULL.  So this and similar
pointer checks are not needed.

By inspection, none of the strings are zero length.  So the strlen() check
is also not needed.

The array dhgroup_map[] is unchanging so it should have a const type
qualifier.

The hash_map[] array has an additional problem.  The zeroth element of the
array is not explicitly initialized so it is implicitly zero initialized.
The pointer will be valid but be empty strings.  Instead of calling strlen(),
check for the zeroth element.

Fixes: a476416bb57b ("nvme: implement In-Band authentication")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/nvme/common/auth.c | 54 +++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 0c86ebce59d2..b7f7ab37786c 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -35,7 +35,7 @@ u32 nvme_auth_get_seqnum(void)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_get_seqnum);
 
-static struct nvme_auth_dhgroup_map {
+static const struct nvme_auth_dhgroup_map {
 	const char name[16];
 	const char kpp[16];
 } dhgroup_map[] = {
@@ -55,21 +55,17 @@ static struct nvme_auth_dhgroup_map {
 
 const char *nvme_auth_dhgroup_name(u8 dhgroup_id)
 {
-	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
-	    !dhgroup_map[dhgroup_id].name ||
-	    !strlen(dhgroup_map[dhgroup_id].name))
-		return NULL;
-	return dhgroup_map[dhgroup_id].name;
+	if (dhgroup_id < ARRAY_SIZE(dhgroup_map))
+		return dhgroup_map[dhgroup_id].name;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
 
 const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id)
 {
-	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
-	    !dhgroup_map[dhgroup_id].kpp ||
-	    !strlen(dhgroup_map[dhgroup_id].kpp))
-		return NULL;
-	return dhgroup_map[dhgroup_id].kpp;
+	if (dhgroup_id < ARRAY_SIZE(dhgroup_map))
+		return dhgroup_map[dhgroup_id].kpp;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_kpp);
 
@@ -78,9 +74,6 @@ u8 nvme_auth_dhgroup_id(const char *dhgroup_name)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
-		if (!dhgroup_map[i].name ||
-		    !strlen(dhgroup_map[i].name))
-			continue;
 		if (!strncmp(dhgroup_map[i].name, dhgroup_name,
 			     strlen(dhgroup_map[i].name)))
 			return i;
@@ -89,7 +82,7 @@ u8 nvme_auth_dhgroup_id(const char *dhgroup_name)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_id);
 
-static struct nvme_dhchap_hash_map {
+static const struct nvme_dhchap_hash_map {
 	int len;
 	const char hmac[15];
 	const char digest[8];
@@ -113,21 +106,19 @@ static struct nvme_dhchap_hash_map {
 
 const char *nvme_auth_hmac_name(u8 hmac_id)
 {
-	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
-	    !hash_map[hmac_id].hmac ||
-	    !strlen(hash_map[hmac_id].hmac))
-		return NULL;
-	return hash_map[hmac_id].hmac;
+	if ((hmac_id > 0) &&
+	    (hmac_id < ARRAY_SIZE(hash_map)))
+		return hash_map[hmac_id].hmac;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_hmac_name);
 
 const char *nvme_auth_digest_name(u8 hmac_id)
 {
-	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
-	    !hash_map[hmac_id].digest ||
-	    !strlen(hash_map[hmac_id].digest))
-		return NULL;
-	return hash_map[hmac_id].digest;
+	if ((hmac_id > 0) &&
+	    (hmac_id < ARRAY_SIZE(hash_map)))
+		return hash_map[hmac_id].digest;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_digest_name);
 
@@ -135,9 +126,7 @@ u8 nvme_auth_hmac_id(const char *hmac_name)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(hash_map); i++) {
-		if (!hash_map[i].hmac || !strlen(hash_map[i].hmac))
-			continue;
+	for (i = 1; i < ARRAY_SIZE(hash_map); i++) {
 		if (!strncmp(hash_map[i].hmac, hmac_name,
 			     strlen(hash_map[i].hmac)))
 			return i;
@@ -148,11 +137,10 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_id);
 
 size_t nvme_auth_hmac_hash_len(u8 hmac_id)
 {
-	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
-	    !hash_map[hmac_id].hmac ||
-	    !strlen(hash_map[hmac_id].hmac))
-		return 0;
-	return hash_map[hmac_id].len;
+	if ((hmac_id > 0) &&
+	    (hmac_id < ARRAY_SIZE(hash_map)))
+		return hash_map[hmac_id].len;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
 
-- 
2.27.0

