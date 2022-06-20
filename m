Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA555551DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiFTOHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353674AbiFTN6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A35D613D05
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655731381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lz3XrBbri+7W5yHDKSER/WjV40K7I0YZnro9o8f5k5U=;
        b=NOyK1YBJP0mBwDgDZbXVlbNTzn9zT2J87Gj1nUTIoRt5F5+Xd/el1cTgRE2RrbeXmYpByO
        heTnHp0w/M7o2BGn/MnOfJmrBRhnA/dSkpdpIveK+RpECxIQOOUShMAgAmfgUWuSz3I100
        1KPKoVnEdFdSnvAh8SKBfOcx5ubMDyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-Wi6EX5JEP9e9kOIYbUntbA-1; Mon, 20 Jun 2022 09:16:37 -0400
X-MC-Unique: Wi6EX5JEP9e9kOIYbUntbA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B652101AA4D;
        Mon, 20 Jun 2022 13:16:36 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.40.208.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26188492CA3;
        Mon, 20 Jun 2022 13:16:34 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladis Dronov <vdronov@redhat.com>, Simo Sorce <simo@redhat.com>
Subject: [PATCH] crypto: fips - make proc files report fips module name and version
Date:   Mon, 20 Jun 2022 15:16:18 +0200
Message-Id: <20220620131618.952133-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FIPS 140-3 introduced a requirement for the FIPS module to return
information about itself, specifically a name and a version. These
values must match the values reported on FIPS certificates.

This patch adds two files to read a name and a version from:

/proc/sys/crypto/fips_name
/proc/sys/crypto/fips_version

Signed-off-by: Simo Sorce <simo@redhat.com>
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 crypto/Kconfig       | 21 +++++++++++++++++++++
 crypto/fips.c        | 27 ++++++++++++++++++++++-----
 include/linux/fips.h |  9 +++++++++
 3 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 1d44893a997b..082ff03d9f6c 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -33,6 +33,27 @@ config CRYPTO_FIPS
 	  certification.  You should say no unless you know what
 	  this is.
 
+config CRYPTO_FIPS_NAME
+	string "FIPS Module Name"
+	default "Linux Kernel Cryptographic API"
+	depends on (CRYPTO_FIPS)
+	help
+	  This option sets the FIPS Module name reported by the Crypto API via
+	  the /proc/sys/crypto/fips_name file.
+
+config CRYPTO_FIPS_CUSTOM_VERSION
+	bool "Use Custom FIPS Module Version"
+	depends on (CRYPTO_FIPS)
+	default n
+
+config CRYPTO_FIPS_VERSION
+	string "FIPS Module Version"
+	default "(none)"
+	depends on (CRYPTO_FIPS_CUSTOM_VERSION)
+	help
+	  This option provides the ability to override the FIPS Module Version.
+	  By default the KERNELRELEASE value is used.
+
 config CRYPTO_ALGAPI
 	tristate
 	select CRYPTO_ALGAPI2
diff --git a/crypto/fips.c b/crypto/fips.c
index 7b1d8caee669..644895d23c9b 100644
--- a/crypto/fips.c
+++ b/crypto/fips.c
@@ -30,13 +30,30 @@ static int fips_enable(char *str)
 
 __setup("fips=", fips_enable);
 
+static char fips_name[] = FIPS_MODULE_NAME;
+static char fips_version[] = FIPS_MODULE_VERSION;
+
 static struct ctl_table crypto_sysctl_table[] = {
 	{
-		.procname       = "fips_enabled",
-		.data           = &fips_enabled,
-		.maxlen         = sizeof(int),
-		.mode           = 0444,
-		.proc_handler   = proc_dointvec
+		.procname	= "fips_enabled",
+		.data		= &fips_enabled,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= proc_dointvec
+	},
+	{
+		.procname	= "fips_name",
+		.data		= &fips_name,
+		.maxlen		= 64,
+		.mode		= 0444,
+		.proc_handler	= proc_dostring
+	},
+	{
+		.procname	= "fips_version",
+		.data		= &fips_version,
+		.maxlen		= 64,
+		.mode		= 0444,
+		.proc_handler	= proc_dostring
 	},
 	{}
 };
diff --git a/include/linux/fips.h b/include/linux/fips.h
index c6961e932fef..72d2e0e1d3ac 100644
--- a/include/linux/fips.h
+++ b/include/linux/fips.h
@@ -2,10 +2,19 @@
 #ifndef _FIPS_H
 #define _FIPS_H
 
+#include <generated/utsrelease.h>
+
 #ifdef CONFIG_CRYPTO_FIPS
 extern int fips_enabled;
 extern struct atomic_notifier_head fips_fail_notif_chain;
 
+#define FIPS_MODULE_NAME CONFIG_CRYPTO_FIPS_NAME
+#ifdef CONFIG_CRYPTO_FIPS_CUSTOM_VERSION
+#define FIPS_MODULE_VERSION CONFIG_CRYPTO_FIPS_VERSION
+#else
+#define FIPS_MODULE_VERSION UTS_RELEASE
+#endif
+
 void fips_fail_notify(void);
 
 #else
-- 
2.36.1

