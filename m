Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3008E55C4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240760AbiF0TwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbiF0Tv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FD071BE83
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656359515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiwuO61xqDYsAatAV0xcjY2AT3XPbcqJO2ZheElIFe4=;
        b=UGI9V8UrnzcIqVB9s28fpog6u5GzuVM8i32paLNcov0EfJuHwcEwlPgzka3xm/AhdvCX9P
        JJRHPUxWvgoLtNbIKhujmHTcpf6R8MnSHol8xMTRuIHdUPfXOsCu98M2XDAws/0tWIk+Zx
        xz8zjQbgN8JiqXIflnncQpx3R03ZSIQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-OIXhawpzPVS0ihlNq5O2Mw-1; Mon, 27 Jun 2022 15:51:52 -0400
X-MC-Unique: OIXhawpzPVS0ihlNq5O2Mw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8F7A801233;
        Mon, 27 Jun 2022 19:51:51 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.40.208.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 250BD2026D64;
        Mon, 27 Jun 2022 19:51:49 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladis Dronov <vdronov@redhat.com>, Simo Sorce <simo@redhat.com>
Subject: [PATCH v3] crypto: fips - make proc files report fips module name and version
Date:   Mon, 27 Jun 2022 21:51:44 +0200
Message-Id: <20220627195144.976741-1-vdronov@redhat.com>
In-Reply-To: <20220620131618.952133-1-vdronov@redhat.com>
References: <20220620131618.952133-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

v2: removed redundant parentheses in config entries.
v3: move FIPS_MODULE_* defines to fips.c where they are used.

Signed-off-by: Simo Sorce <simo@redhat.com>
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 crypto/Kconfig | 21 +++++++++++++++++++++
 crypto/fips.c  | 34 +++++++++++++++++++++++++++++-----
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 1d44893a997b..3891c331f2e7 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -33,6 +33,27 @@ config CRYPTO_FIPS
 	  certification.  You should say no unless you know what
 	  this is.
 
+config CRYPTO_FIPS_NAME
+	string "FIPS Module Name"
+	default "Linux Kernel Cryptographic API"
+	depends on CRYPTO_FIPS
+	help
+	  This option sets the FIPS Module name reported by the Crypto API via
+	  the /proc/sys/crypto/fips_name file.
+
+config CRYPTO_FIPS_CUSTOM_VERSION
+	bool "Use Custom FIPS Module Version"
+	depends on CRYPTO_FIPS
+	default n
+
+config CRYPTO_FIPS_VERSION
+	string "FIPS Module Version"
+	default "(none)"
+	depends on CRYPTO_FIPS_CUSTOM_VERSION
+	help
+	  This option provides the ability to override the FIPS Module Version.
+	  By default the KERNELRELEASE value is used.
+
 config CRYPTO_ALGAPI
 	tristate
 	select CRYPTO_ALGAPI2
diff --git a/crypto/fips.c b/crypto/fips.c
index 7b1d8caee669..d820f83cb878 100644
--- a/crypto/fips.c
+++ b/crypto/fips.c
@@ -30,13 +30,37 @@ static int fips_enable(char *str)
 
 __setup("fips=", fips_enable);
 
+#define FIPS_MODULE_NAME CONFIG_CRYPTO_FIPS_NAME
+#ifdef CONFIG_CRYPTO_FIPS_CUSTOM_VERSION
+#define FIPS_MODULE_VERSION CONFIG_CRYPTO_FIPS_VERSION
+#else
+#define FIPS_MODULE_VERSION UTS_RELEASE
+#endif
+
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
-- 
2.36.1

