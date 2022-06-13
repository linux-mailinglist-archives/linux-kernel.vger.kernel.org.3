Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7154A1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbiFMV5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346283AbiFMV5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB08F21251
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655157426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ErIisdD0lSY1B5KC6LvkzYL6COmxq7gEAPwuIIRZ77M=;
        b=Q6uXqq2Y2sf0JuAq+DWW0zHCsJ+pcOmR4RpdSmxyViDrI8yqX6APy2CT445CIgZ3w2pyCm
        tRE2BBPuUAKfZJyWM/fTNUfZ6ffEt4sFA3ojPqY1uzi3DYYCAurZ1CkvslkYkfwxHQBIez
        2m3u6PxRdSbVY25xmDojY1N3q/zmaVg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-riefXtgqPM6Z-8Xw_HWQlQ-1; Mon, 13 Jun 2022 17:57:03 -0400
X-MC-Unique: riefXtgqPM6Z-8Xw_HWQlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27843185A79C;
        Mon, 13 Jun 2022 21:57:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10AEC40CFD0A;
        Mon, 13 Jun 2022 21:57:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/2] certs: Move load_certificate_list() to be with the
 asymmetric keys code
From:   David Howells <dhowells@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     dhowells@redhat.com, simo@redhat.com,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jun 2022 22:57:01 +0100
Message-ID: <165515742145.1554877.13488098107542537203.stgit@warthog.procyon.org.uk>
In-Reply-To: <165515741424.1554877.9363755381201121213.stgit@warthog.procyon.org.uk>
References: <165515741424.1554877.9363755381201121213.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move load_certificate_list(), which loads a series of binary X.509
certificates from a blob and inserts them as keys into a keyring, to be
with the asymmetric keys code that it drives.

This makes it easier to add FIPS selftest code in which we need to load up
a private keyring for the tests to use.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 certs/Makefile                       |    4 +-
 certs/blacklist.c                    |    8 ++---
 certs/common.c                       |   57 ----------------------------------
 certs/common.h                       |    9 -----
 certs/system_keyring.c               |    6 ++--
 crypto/asymmetric_keys/Makefile      |    1 +
 crypto/asymmetric_keys/x509_loader.c |   57 ++++++++++++++++++++++++++++++++++
 include/keys/asymmetric-type.h       |    3 ++
 8 files changed, 70 insertions(+), 75 deletions(-)
 delete mode 100644 certs/common.c
 delete mode 100644 certs/common.h
 create mode 100644 crypto/asymmetric_keys/x509_loader.c

diff --git a/certs/Makefile b/certs/Makefile
index cb1a9da3fc58..3aac9f33ee22 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -3,8 +3,8 @@
 # Makefile for the linux kernel signature checking certificates.
 #
 
-obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o common.o
-obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
+obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o
+obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o
 obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
 ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
 quiet_cmd_check_blacklist_hashes = CHECK   $(patsubst "%",%,$(2))
diff --git a/certs/blacklist.c b/certs/blacklist.c
index 25094ea73600..41f10601cc72 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -15,10 +15,9 @@
 #include <linux/err.h>
 #include <linux/seq_file.h>
 #include <linux/uidgid.h>
-#include <linux/verification.h>
+#include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include "blacklist.h"
-#include "common.h"
 
 /*
  * According to crypto/asymmetric_keys/x509_cert_parser.c:x509_note_pkey_algo(),
@@ -365,8 +364,9 @@ static __init int load_revocation_certificate_list(void)
 	if (revocation_certificate_list_size)
 		pr_notice("Loading compiled-in revocation X.509 certificates\n");
 
-	return load_certificate_list(revocation_certificate_list, revocation_certificate_list_size,
-				     blacklist_keyring);
+	return x509_load_certificate_list(revocation_certificate_list,
+					  revocation_certificate_list_size,
+					  blacklist_keyring);
 }
 late_initcall(load_revocation_certificate_list);
 #endif
diff --git a/certs/common.c b/certs/common.c
deleted file mode 100644
index 16a220887a53..000000000000
--- a/certs/common.c
+++ /dev/null
@@ -1,57 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-#include <linux/kernel.h>
-#include <linux/key.h>
-#include "common.h"
-
-int load_certificate_list(const u8 cert_list[],
-			  const unsigned long list_size,
-			  const struct key *keyring)
-{
-	key_ref_t key;
-	const u8 *p, *end;
-	size_t plen;
-
-	p = cert_list;
-	end = p + list_size;
-	while (p < end) {
-		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
-		 * than 256 bytes in size.
-		 */
-		if (end - p < 4)
-			goto dodgy_cert;
-		if (p[0] != 0x30 &&
-		    p[1] != 0x82)
-			goto dodgy_cert;
-		plen = (p[2] << 8) | p[3];
-		plen += 4;
-		if (plen > end - p)
-			goto dodgy_cert;
-
-		key = key_create_or_update(make_key_ref(keyring, 1),
-					   "asymmetric",
-					   NULL,
-					   p,
-					   plen,
-					   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-					   KEY_USR_VIEW | KEY_USR_READ),
-					   KEY_ALLOC_NOT_IN_QUOTA |
-					   KEY_ALLOC_BUILT_IN |
-					   KEY_ALLOC_BYPASS_RESTRICTION);
-		if (IS_ERR(key)) {
-			pr_err("Problem loading in-kernel X.509 certificate (%ld)\n",
-			       PTR_ERR(key));
-		} else {
-			pr_notice("Loaded X.509 cert '%s'\n",
-				  key_ref_to_ptr(key)->description);
-			key_ref_put(key);
-		}
-		p += plen;
-	}
-
-	return 0;
-
-dodgy_cert:
-	pr_err("Problem parsing in-kernel X.509 certificate list\n");
-	return 0;
-}
diff --git a/certs/common.h b/certs/common.h
deleted file mode 100644
index abdb5795936b..000000000000
--- a/certs/common.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-#ifndef _CERT_COMMON_H
-#define _CERT_COMMON_H
-
-int load_certificate_list(const u8 cert_list[], const unsigned long list_size,
-			  const struct key *keyring);
-
-#endif
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 05b66ce9d1c9..5042cc54fa5e 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -16,7 +16,6 @@
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include <crypto/pkcs7.h>
-#include "common.h"
 
 static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
@@ -183,7 +182,8 @@ __init int load_module_cert(struct key *keyring)
 
 	pr_notice("Loading compiled-in module X.509 certificates\n");
 
-	return load_certificate_list(system_certificate_list, module_cert_size, keyring);
+	return x509_load_certificate_list(system_certificate_list,
+					  module_cert_size, keyring);
 }
 
 /*
@@ -204,7 +204,7 @@ static __init int load_system_certificate_list(void)
 	size = system_certificate_list_size - module_cert_size;
 #endif
 
-	return load_certificate_list(p, size, builtin_trusted_keys);
+	return x509_load_certificate_list(p, size, builtin_trusted_keys);
 }
 late_initcall(load_system_certificate_list);
 
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index c38424f55b08..0f190500dd87 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -20,6 +20,7 @@ x509_key_parser-y := \
 	x509.asn1.o \
 	x509_akid.asn1.o \
 	x509_cert_parser.o \
+	x509_loader.o \
 	x509_public_key.o
 
 $(obj)/x509_cert_parser.o: \
diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
new file mode 100644
index 000000000000..1bc169dee22e
--- /dev/null
+++ b/crypto/asymmetric_keys/x509_loader.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/kernel.h>
+#include <linux/key.h>
+#include <keys/asymmetric-type.h>
+
+int x509_load_certificate_list(const u8 cert_list[],
+			       const unsigned long list_size,
+			       const struct key *keyring)
+{
+	key_ref_t key;
+	const u8 *p, *end;
+	size_t plen;
+
+	p = cert_list;
+	end = p + list_size;
+	while (p < end) {
+		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
+		 * than 256 bytes in size.
+		 */
+		if (end - p < 4)
+			goto dodgy_cert;
+		if (p[0] != 0x30 &&
+		    p[1] != 0x82)
+			goto dodgy_cert;
+		plen = (p[2] << 8) | p[3];
+		plen += 4;
+		if (plen > end - p)
+			goto dodgy_cert;
+
+		key = key_create_or_update(make_key_ref(keyring, 1),
+					   "asymmetric",
+					   NULL,
+					   p,
+					   plen,
+					   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
+					   KEY_USR_VIEW | KEY_USR_READ),
+					   KEY_ALLOC_NOT_IN_QUOTA |
+					   KEY_ALLOC_BUILT_IN |
+					   KEY_ALLOC_BYPASS_RESTRICTION);
+		if (IS_ERR(key)) {
+			pr_err("Problem loading in-kernel X.509 certificate (%ld)\n",
+			       PTR_ERR(key));
+		} else {
+			pr_notice("Loaded X.509 cert '%s'\n",
+				  key_ref_to_ptr(key)->description);
+			key_ref_put(key);
+		}
+		p += plen;
+	}
+
+	return 0;
+
+dodgy_cert:
+	pr_err("Problem parsing in-kernel X.509 certificate list\n");
+	return 0;
+}
diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index 6c5d4963e15b..69a13e1e5b2e 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -84,6 +84,9 @@ extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_2,
 				       bool partial);
 
+int x509_load_certificate_list(const u8 cert_list[], const unsigned long list_size,
+			       const struct key *keyring);
+
 /*
  * The payload is at the discretion of the subtype.
  */


