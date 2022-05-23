Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DC7530AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiEWHuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiEWHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:49:58 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5B222B0B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:49:50 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2EC743F1BA
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653286977;
        bh=vfrKW/A5HDmGcRcNkOTm1gnC8MOayzaLWlH/+N9bMYQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=dmtr/ggiaQW4TZUgNKdbkE1vKkptUlJhFnND4opcUHuvIIp6IYtVKlLWiZwzl/MX3
         C5gYW7P9Pqu68XvzQUjdIeG88F3WYJiYHQX8bIXVuhsPT/DG6i6cMR8yLsa1nKIwtV
         cJJPfHQi6FSoUMDa8DwrkAEOmb3ZV2z4O8+iClPA83LaFYVc1wT8XioLMAQoiHam32
         Q3fmhw6Q/wdJ108UzgLRe2unE9LIXILsyipx5Cf7EDTZ3aXKh5ir0R5VgnGuES4SOq
         tlserqJr6xC4uHvxtXPjHfsXk1gkP40jYf9tp+pZb6fTIsDVEuXgwyAX9amCM6adIL
         tucR2LbAJMxKA==
Received: by mail-ej1-f69.google.com with SMTP id qa15-20020a170907868f00b006f4c89bf2e3so5386663ejc.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfrKW/A5HDmGcRcNkOTm1gnC8MOayzaLWlH/+N9bMYQ=;
        b=O+xgw6nehlPWUlpQjCEKvFU9L2V7/oCQUpwaNJrulqojN4Q2kIYslcq0puKjpc0xqe
         es4UUCxArpeF/VZtEetdNvdD3LB9gQKsieCajnlFuHFNyLitwASndWU5gqQtBJ54kj7Y
         6a3Hv9FR05sC7zbjSI7xun8EIwCn1HTf6eqPdWBUcL7Hq3TsHzef/DyyomiPMS52sL4g
         cuBhDDFKPgePQxxeh0m2fk6XKwE+YBYd7TizDbOb7FIlh+HYrmZwwYkEHCZn3qJeH1XE
         MdJFrpRRXLiq6KpqxPfeBd8SCGTp7YFv1WMibvhqBIiZD7k1Y6Oz58caz9Mg4bWgIH9P
         B6vg==
X-Gm-Message-State: AOAM530voQju7ZBQEmSymJwDZxh41xr/XCDuOpaR7tljEXmZm6Hobuvo
        lFxP2RDHvl+1r9u1L3gw/Su35dZ3frQXrN5ep/q/v/nuu64ZHaqGYRXWibgFnv+cKgfHzM8bgKB
        Q8PCvXFTYynvQfqVKzsiq/fYaOJjVs7b/zrRuwmLm6A==
X-Received: by 2002:a05:6402:390b:b0:42a:acb3:bb5 with SMTP id fe11-20020a056402390b00b0042aacb30bb5mr21543348edb.236.1653286976011;
        Sun, 22 May 2022 23:22:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkZGaoVm79irxOTj6+qyoiib2JpTyZ+j7Rses0mZa1rONxUwfDg6fZL7Y0JR1Ygaxypg5jmw==
X-Received: by 2002:a05:6402:390b:b0:42a:acb3:bb5 with SMTP id fe11-20020a056402390b00b0042aacb30bb5mr21543339edb.236.1653286975859;
        Sun, 22 May 2022 23:22:55 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7dcc7000000b0042617ba6383sm7793432edu.13.2022.05.22.23.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:22:55 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH RESEND] ARM: imx: Kconfig: Fix indentation
Date:   Mon, 23 May 2022 08:22:52 +0200
Message-Id: <20220523062252.9710-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
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

While at it, replace separator tabs with whitespaces.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
RESEND:
  Use correct list of recipients.
  
---
 arch/arm/mach-imx/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c5a59158722b..e27232aa3d34 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -96,7 +96,7 @@ config SOC_IMX5
 	select HAVE_IMX_SRC
 	select MXC_TZIC
 
-config	SOC_IMX50
+config SOC_IMX50
 	bool "i.MX50 support"
 	select PINCTRL_IMX50
 	select SOC_IMX5
@@ -111,7 +111,7 @@ config SOC_IMX51
 	help
 	  This enables support for Freescale i.MX51 processor
 
-config	SOC_IMX53
+config SOC_IMX53
 	bool "i.MX53 support"
 	select PINCTRL_IMX53
 	select SOC_IMX5
@@ -216,7 +216,7 @@ config SOC_IMX7D
 	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
 	select ARM_ERRATA_814220 if ARCH_MULTI_V7
 	help
-		This enables support for Freescale i.MX7 Dual processor.
+	  This enables support for Freescale i.MX7 Dual processor.
 
 config SOC_IMX7ULP
 	bool "i.MX7ULP support"
-- 
2.32.0

