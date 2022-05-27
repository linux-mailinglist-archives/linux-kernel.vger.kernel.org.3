Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30666536291
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245013AbiE0M2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355044AbiE0M1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:27:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B147414CDF8
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:05:40 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BF83F3F19E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 12:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653653076;
        bh=oOCTsXFRjJ2XlQZekYMt58Ab+xoHPAvZsZMQKS0jhWk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CWlhWRZPrDnF3xdWYhX8UHy0fHsHDcTPSXkcQacWWEDdapa3AGV/+DJccLMZEsqQW
         PHnjyB13GY6oABn4fs7jDBqWUCzcluGT3qeoJjyuKi+IoKQfdutyo3FlsTYllavW62
         BzgJyQ4RIIzlUFaguHuFmdU3n1vlAzbKpLyW11f1ZK9eGGxLZ4sMXGVX7v/sZczIHG
         VxpVTCIfAD8Na9iRmRgY58JOqBVX/tY0xNqsePK+9C4qFd6vJlTtzcYjiggWklg5CJ
         uJcba6lMOkH5XXgI9wBbgyRSOZns2gGcAPgiZ1STMk98GGSQXo2xznBmgD8HPi+hqx
         QP/9hlXfeNwGg==
Received: by mail-ej1-f69.google.com with SMTP id ks1-20020a170906f84100b006fee53b22c2so2309687ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOCTsXFRjJ2XlQZekYMt58Ab+xoHPAvZsZMQKS0jhWk=;
        b=LV8yWUbg01h+DEXZ/AOhQ/2TJYod9FuTZMY2jhZ8rsh+t8Wi+xNl4ej//oilgLq8Sx
         mCZOVN9Jy02WEbMSeVjLrg3AQP3PrPSXpvbCrlOq57FbM/m2bv/ci5S0aHmku6Um5QEo
         sfQ2FqOCOaQ93EZWGP+Ff0mq8joKznZ8FE6gHBgT5+tuPjxUXWn2OSEF9WZO7UY0iBc6
         n+2Va7VF3/WnDwNTXHOrX+oejcgdzcUyUq5efVn2hmLXE3082kuuMNrtxCWK3fwJLZl1
         7z9hm1t7cistTdxYjbMF0/eGTN0z2oUMbBs0buPAnq+iRhGT55sLAAfbVrzJddVis5yl
         YDgg==
X-Gm-Message-State: AOAM532yIs2fucd3JwZktUjCNiDJAR0P1AZjweVNwwunHFkDSfBRGsbM
        wsqI0dxoYvxfpUJYfKAR008oVODR5Q518aQITMj2vO7oF7LXVJ3GeoWtb6LdQ29gBpx7WU5AzmO
        p6w/ZM1l+ZFZd/Sq/7DNhjojKK8yVJ00dLbtPKf/Y6Q==
X-Received: by 2002:a05:6402:528f:b0:42a:c778:469e with SMTP id en15-20020a056402528f00b0042ac778469emr44092650edb.404.1653653075193;
        Fri, 27 May 2022 05:04:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzebqk4x0v1u6z1D5wE6Tcbj7WIsf2nELITM9fcePdJZJWGLK19jFqy0txhZTtOE+1rguS0lw==
X-Received: by 2002:a05:6402:528f:b0:42a:c778:469e with SMTP id en15-20020a056402528f00b0042ac778469emr44092623edb.404.1653653075022;
        Fri, 27 May 2022 05:04:35 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id bw12-20020a170906c1cc00b006f3ef214dc3sm1413242ejb.41.2022.05.27.05.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:04:33 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, sergei.shtylyov@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 3/4 v2] sh/boards: Kconfig: Fix indentation and remove trailing whitespaces
Date:   Fri, 27 May 2022 14:04:30 +0200
Message-Id: <20220527120430.459187-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <c371fcc7-08ad-7de7-cb9a-aa316a98047c@gmail.com>
References: <c371fcc7-08ad-7de7-cb9a-aa316a98047c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two spaces. Fix the lines that violate
these rules.

While at it, remove trailing whitespaces.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
v2:
  Update commit message and subject per review comments.
---
 arch/sh/boards/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 83bcb6d2daca..fbdb3fbfb976 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -36,7 +36,7 @@ config SH_SOLUTION_ENGINE
 	select CPU_HAS_IPR_IRQ
 	depends on CPU_SUBTYPE_SH7705 || CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7710 || \
 	  CPU_SUBTYPE_SH7712 || CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7750S || \
-	  CPU_SUBTYPE_SH7750R 
+	  CPU_SUBTYPE_SH7750R
 	help
 	  Select SolutionEngine if configuring for a Hitachi SH7705, SH7709,
 	  SH7710, SH7712, SH7750, SH7750S or SH7750R evaluation board.
@@ -56,7 +56,7 @@ config SH_7619_SOLUTION_ENGINE
 	help
 	  Select 7619 SolutionEngine if configuring for a Hitachi SH7619
 	  evaluation board.
-	
+
 config SH_7721_SOLUTION_ENGINE
 	bool "SolutionEngine7721"
 	select SOLUTION_ENGINE
@@ -94,7 +94,7 @@ config SH_7751_SOLUTION_ENGINE
 	help
 	  Select 7751 SolutionEngine if configuring for a Hitachi SH7751
 	  evaluation board.
-	  
+
 config SH_7780_SOLUTION_ENGINE
 	bool "SolutionEngine7780"
 	select SOLUTION_ENGINE
@@ -167,8 +167,8 @@ config SH_RSK
 	  CPU_SUBTYPE_SH7264 || CPU_SUBTYPE_SH7269
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
-	 Select this option if configuring for any of the RSK+ MCU
-	 evaluation platforms.
+	  Select this option if configuring for any of the RSK+ MCU
+	  evaluation platforms.
 
 config SH_SDK7780
 	bool "SDK7780R3"
@@ -236,7 +236,7 @@ config SH_MIGOR
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Migo-R if configuring for the SH7722 Migo-R platform
-          by Renesas System Solutions Asia Pte. Ltd.
+	  by Renesas System Solutions Asia Pte. Ltd.
 
 config SH_AP325RXA
 	bool "AP-325RXA"
-- 
2.32.0

