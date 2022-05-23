Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ABA530A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiEWHcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiEWHcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:32:15 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620D228729
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:29:50 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D09873F210
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653288179;
        bh=yEO41M4QEwl2GHy1OyiRTroQlrDw56y+j0EhDtN4chM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=iIfNQShDEF29KNrc/FaqJ0CZa+RTAY/yg2QJVfCkwU+tfPNaMNV3RN+s6ym2uJm9o
         zXM+Fe74T2SI7yDTlWEi3QN9BFAHxLzEG4CXw2zveq1jT8JwECeSGrFl709MGxDq2B
         8f+fRW9Suj7zfCOwwCSihHyE1j6pPe0iLACXP0GLPRo6K+yhBwfTPDGsg7LuXgMVtF
         GcMCE+X9+tEf4VxGmUribAzCIuo8IEnUPujNjxX606b600p6RQ8xEZLQzeacsxQqZI
         jNRicit1fyGSG/TgrZ2Ko81WQquQLJ5M54R/VA7JFJ7A9iiwRBauYbPZGHfF0wTX4U
         GDUmuRQQ4Wy2Q==
Received: by mail-ed1-f71.google.com with SMTP id w23-20020aa7da57000000b0042acd76347bso9981303eds.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yEO41M4QEwl2GHy1OyiRTroQlrDw56y+j0EhDtN4chM=;
        b=64WA1rrzh/ZQ4FB6x+yR6rCoUayj86EHVcwwjX8fZBFe1dOIUehooSKDFN1M6MK+FM
         XjITfX7dGtHwjQAlPglVrg3DEqR82zbWmMgZ8EthJXa8z3ifwsPe68YZVDqYXeyNh/Jo
         xjgXa0NCob73FO3uzQpBNqbta3mS0I3xKE0O0tn9waxeiYaI7xan4FTxgQAs3OOp+9uc
         rsNuI+vJ28fZ6hYurKPUsr6uaUuIUQL4nn8z7SWtPdj3DILFORbfI3UhB1DqW8xvif/n
         Bk4kVmrMJXiSCG5sSTgUYQxm7noXm7+nPCvfzH5WzP6G5hJoDnMlccnySof84oAp3xBh
         mnTQ==
X-Gm-Message-State: AOAM530w2DKfUJE7bI32WqupeWAoISINZVb9PGhGWXEjCIuvjLVxujRr
        Ti5jMX4lxpwbXhzY+/UH2mdlt2W8HxEzqzKEbzazRkAcgysDr8DmZjfkeAr/aXd9TV/9+9hkDfb
        nDqAg1nStOoOSbEI7q+os4VIJ9lXiNegO8CPGR033bw==
X-Received: by 2002:a05:6402:5415:b0:42b:228:5cf with SMTP id ev21-20020a056402541500b0042b022805cfmr19522531edb.245.1653288178044;
        Sun, 22 May 2022 23:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJ7ytld9I2P8mL8R1KS+HF6d7ge2qDH3qWflgznfKAeHOLzLYMEmXjk7V+OZ0SsEf9b43icQ==
X-Received: by 2002:a05:6402:5415:b0:42b:228:5cf with SMTP id ev21-20020a056402541500b0042b022805cfmr19522520edb.245.1653288177859;
        Sun, 22 May 2022 23:42:57 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id p3-20020a056402074300b0042617ba63a5sm7792416edy.47.2022.05.22.23.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:42:57 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 1/3] ARM: s3c: Kconfig: Fix indentation
Date:   Mon, 23 May 2022 08:42:50 +0200
Message-Id: <20220523064252.11938-2-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220523064252.11938-1-juergh@canonical.com>
References: <20220523064252.11938-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/mach-s3c/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s3c/Kconfig b/arch/arm/mach-s3c/Kconfig
index 1899fc3f44fd..860df703f696 100644
--- a/arch/arm/mach-s3c/Kconfig
+++ b/arch/arm/mach-s3c/Kconfig
@@ -43,12 +43,12 @@ config SAMSUNG_ATAGS
 	def_bool n
 	depends on ATAGS
 	help
-	   This option enables ATAGS based boot support code for
-	   Samsung platforms, including static platform devices, legacy
-	   clock, timer and interrupt initialization, etc.
+	  This option enables ATAGS based boot support code for
+	  Samsung platforms, including static platform devices, legacy
+	  clock, timer and interrupt initialization, etc.
 
-	   Platforms that support only DT based boot need not to select
-	   this option.
+	  Platforms that support only DT based boot need not to select
+	  this option.
 
 if SAMSUNG_ATAGS
 
@@ -102,7 +102,7 @@ config S3C_DEV_HSMMC3
 config S3C_DEV_HWMON
 	bool
 	help
-	    Compile in platform device definitions for HWMON
+	  Compile in platform device definitions for HWMON
 
 config S3C_DEV_I2C1
 	bool
@@ -194,7 +194,7 @@ config S3C64XX_DEV_SPI0
 config SAMSUNG_DEV_TS
 	bool
 	help
-	    Common in platform device definitions for touchscreen device
+	  Common in platform device definitions for touchscreen device
 
 config SAMSUNG_DEV_KEYPAD
 	bool
-- 
2.32.0

