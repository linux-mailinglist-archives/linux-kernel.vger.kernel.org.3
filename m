Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83AA4DD7F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiCRKgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiCRKgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE3A325278A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647599685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e6SFRMKes32y2Epjb9bRfBHy+sHjP48gM2WVhKsacmY=;
        b=MZtl9cnYEuydwSh1G3DkaGCt7GDKSAdJ+3CaXJeRLI69K7TfF9TSUuLVEaBuNgYSIX+4dB
        yjAbMtACeQRaUjYD2FnVaa/M8aekW5kMOHzs1pKbUy/nPGgOcVRbUkSjnC50hwOZdkp8jR
        CALtG+nJn1YrBtil98lGS35V3j807mg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-q8hOKRhAOai4pS1PjarNVg-1; Fri, 18 Mar 2022 06:34:44 -0400
X-MC-Unique: q8hOKRhAOai4pS1PjarNVg-1
Received: by mail-pj1-f70.google.com with SMTP id bv2-20020a17090af18200b001c63c69a774so4850251pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e6SFRMKes32y2Epjb9bRfBHy+sHjP48gM2WVhKsacmY=;
        b=L3QTjApdqEP/KofCX/omuxNySnGPqKal7jUfq6kEliMK60lKMEuuqoXn7xnxFup0D1
         rKY5dWvapx7v2qJti+sS0ZPtTiN6eQY5/301nfO6500tP+R0F964ngz17WNFmYhQJN5c
         4I1lRYcJ9lXjZvUcSJ3TF6KIsj5TfMcJ5W0crygRHE74vo2agACLwqRhktxYozO7CwKc
         OyzwazT9DWipWjnzFjl2gfB2/xoWvvCy6gXDl9xnT3oH8MQxU/N0/UxkUo3eYp1i0jcG
         tEBZv8V8fwcyZ91AO0YzrPJ4aPIj05iItlGeFzXzdPkElhZeaL70sY/D1F2xmky2HtjT
         NPSw==
X-Gm-Message-State: AOAM5339nbostwd40kIcdmX+nlco6geuUFej9yRjWrddWgfAhSUgIWmh
        HMjeZ+lZj+i/N+jVW8QHpCrYXcdZwZUP9XuaQyvl3qk7QkkklsbtG9wn4andj+De9Fyo2pZ9J1V
        oVT4QRWXzTDISNwme7Y8ZqF2t
X-Received: by 2002:a17:902:a5c7:b0:14f:e424:3579 with SMTP id t7-20020a170902a5c700b0014fe4243579mr9761883plq.74.1647599683229;
        Fri, 18 Mar 2022 03:34:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwydLGW4oyMokHqUNqgiEVlQJ73WsUZSlWeUuNnFSrLoT8M8+9OxbPejRrRKRSgMpl8ZFsEyw==
X-Received: by 2002:a17:902:a5c7:b0:14f:e424:3579 with SMTP id t7-20020a170902a5c700b0014fe4243579mr9761859plq.74.1647599682974;
        Fri, 18 Mar 2022 03:34:42 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id o24-20020a17090a5b1800b001c6aaafa5fbsm1575423pji.24.2022.03.18.03.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:34:42 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     kexec@lists.infradead.org
Cc:     Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>
Subject: [RFC 4/4] dm-crypt: reuse LUKS master key in kdump kernel
Date:   Fri, 18 Mar 2022 18:34:23 +0800
Message-Id: <20220318103423.286410-5-coxu@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318103423.286410-1-coxu@redhat.com>
References: <20220318103423.286410-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When libcryptsetup passes key string starting with ":kdump", dm-crypt
will interpret it as reusing the LUKS master key in kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/md/dm-crypt.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 41f9ca377312..f3986036ec40 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -42,6 +42,7 @@
 
 #include <linux/device-mapper.h>
 #include <linux/kexec.h>
+#include <linux/crash_dump.h>
 
 #include "dm-audit.h"
 
@@ -2602,13 +2603,17 @@ static int crypt_set_key(struct crypt_config *cc, char *key)
 {
 	int r = -EINVAL;
 	int key_string_len = strlen(key);
+	bool retrieve_kdump_key = false;
+
+	if (is_kdump_kernel() && !strncmp(key, ":kdump", 5))
+		retrieve_kdump_key = true;
 
 	/* Hyphen (which gives a key_size of zero) means there is no key. */
-	if (!cc->key_size && strcmp(key, "-"))
+	if (!retrieve_kdump_key && !cc->key_size && strcmp(key, "-"))
 		goto out;
 
 	/* ':' means the key is in kernel keyring, short-circuit normal key processing */
-	if (key[0] == ':') {
+	if (!retrieve_kdump_key && key[0] == ':') {
 		r = crypt_set_keyring_key(cc, key + 1);
 		goto out;
 	}
@@ -2620,9 +2625,15 @@ static int crypt_set_key(struct crypt_config *cc, char *key)
 	kfree_sensitive(cc->key_string);
 	cc->key_string = NULL;
 
-	/* Decode key from its hex representation. */
-	if (cc->key_size && hex2bin(cc->key, key, cc->key_size) < 0)
-		goto out;
+	if (retrieve_kdump_key) {
+		r = retrive_kdump_luks_master_key(cc->key, &cc->key_size);
+		if (r < 0)
+			goto out;
+	} else {
+		/* Decode key from its hex representation. */
+		if (cc->key_size && hex2bin(cc->key, key, cc->key_size) < 0)
+			goto out;
+	}
 
 	r = crypt_setkey(cc);
 	if (!r)
-- 
2.34.1

