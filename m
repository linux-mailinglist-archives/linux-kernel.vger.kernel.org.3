Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90564533CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbiEYMkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiEYMkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:40:20 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590577B9C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:40:17 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 023493F6FF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653482416;
        bh=qDDIAAvUt7blo3PUroyBqBlIiFZ/YuR5nco8lmMiCCY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Vfj4zYCBMbdXroeQGFFnTD8ciSjsZSqiuVtFK0MJbep28PQoO9ka0/29EE5nPPwcA
         CAP8Mg4yxpa6VPiThNrwAHRZyA1vFhZiqbt/FlXGxw7ZeIRpmKyvyUkYuMKk284af4
         9RioV1gXcFfSUkRhIYlD2otTSSa8YYpsOxFGhzt5k/Iviq8kt7sk2fODXrxafG59f3
         9zuBFWfzFgLVrtPICYaq/v4BIF9ucWEec0wDtvnqT6XO5+vXBG7gPLCwqpJmJ9HVG6
         MoBmPeMlt8zg0K0MqMEO9Raf8AsNLWATjx3c1C/MgqVLq6E3R+SEIvu53P4lmgSicP
         ap1QCdiz3mUTg==
Received: by mail-ed1-f71.google.com with SMTP id l18-20020aa7d952000000b0042ab7be9adaso14775873eds.21
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDDIAAvUt7blo3PUroyBqBlIiFZ/YuR5nco8lmMiCCY=;
        b=A30vUaNodJpN/FoiUlKMO9xfFED2MqXHezRI5AIp/gB8IK/SSiBcLICFeFRYIDpM5e
         Vy+Pi3lDmEw3MNsGUfqhnMvscUMqrLFW9AHdZgn+lNqLlwZ9v0JN+tpqKonx6BnVz6vu
         X0f0yNBvy4EoOaMVH4VrjuHU0Tf+13U4tWcGCrK18GzovgVmd/alc6AXvUP1cG+9pD2Y
         M2DxFFOD6cef/3z9Txxw9HUinAviEM7crCkhlxzdvxNGtxP7C0JKUY9rQrALuttPRBw5
         9fHR1/uXc3GkIWX/s3q2VvQdM6DfJ9l3l6fiT/MGi0eSslHLQ9BkTtZqjLMVO8FdaKNz
         CgqA==
X-Gm-Message-State: AOAM530Nx1P/0lrEB9WkDGS8PLoY/acMSTySECi31u4UbDNbz8cWKz4E
        8FuPwHlXaZRauB3rbIYiLscSKzUyw554O53yxylldOmJjLpfS/kJpsyiJn7yzKDuOjoA4d2JDtC
        9pt1IEQEyTdfiOMD2GXHE9StZc2EaBScroJ0HrhUXrg==
X-Received: by 2002:a05:6402:40cc:b0:42b:3327:d699 with SMTP id z12-20020a05640240cc00b0042b3327d699mr25863283edb.380.1653482415600;
        Wed, 25 May 2022 05:40:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfaCyBUXVQDvxQHJs2/wsF8PEzAocgngbhZDSaAmeNaGiWhQpkkOgFhOVssls3a9B2ozPozA==
X-Received: by 2002:a05:6402:40cc:b0:42b:3327:d699 with SMTP id z12-20020a05640240cc00b0042b3327d699mr25863266edb.380.1653482415378;
        Wed, 25 May 2022 05:40:15 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b0042617ba63c4sm10632614edr.78.2022.05.25.05.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:40:14 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 1/4] sh: Kconfig: Fix indentation
Date:   Wed, 25 May 2022 14:40:04 +0200
Message-Id: <20220525124007.45328-2-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220525124007.45328-1-juerg.haefliger@canonical.com>
References: <20220525124007.45328-1-juerg.haefliger@canonical.com>
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

While at it, remove stray spaces from seemingly empty lines.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/sh/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5f220e903e5a..fc15fd6b719e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -200,9 +200,9 @@ config ARCH_SHMOBILE
 	select PM
 
 config CPU_HAS_PMU
-       depends on CPU_SH4 || CPU_SH4A
-       default y
-       bool
+	depends on CPU_SH4 || CPU_SH4A
+	default y
+	bool
 
 choice
 	prompt "Processor sub-type selection"
@@ -231,7 +231,7 @@ config CPU_SUBTYPE_SH7201
 	select CPU_SH2A
 	select CPU_HAS_FPU
 	select SYS_SUPPORTS_SH_MTU2
- 
+
 config CPU_SUBTYPE_SH7203
 	bool "Support SH7203 processor"
 	select CPU_SH2A
@@ -493,7 +493,7 @@ config CPU_SUBTYPE_SH7366
 endchoice
 
 source "arch/sh/mm/Kconfig"
- 
+
 source "arch/sh/Kconfig.cpu"
 
 source "arch/sh/boards/Kconfig"
@@ -644,7 +644,7 @@ config GUSA
 	  This is the default implementation for both UP and non-ll/sc
 	  CPUs, and is used by the libc, amongst others.
 
-	  For additional information, design information can be found 
+	  For additional information, design information can be found
 	  in <http://lc.linux.or.jp/lc2002/papers/niibe0919p.pdf>.
 
 	  This should only be disabled for special cases where alternate
@@ -775,12 +775,12 @@ config MAPLE
 	bool "Maple Bus support"
 	depends on SH_DREAMCAST
 	help
-	 The Maple Bus is SEGA's serial communication bus for peripherals
-	 on the Dreamcast. Without this bus support you won't be able to
-	 get your Dreamcast keyboard etc to work, so most users
-	 probably want to say 'Y' here, unless you are only using the
-	 Dreamcast with a serial line terminal or a remote network
-	 connection.
+	  The Maple Bus is SEGA's serial communication bus for peripherals
+	  on the Dreamcast. Without this bus support you won't be able to
+	  get your Dreamcast keyboard etc to work, so most users
+	  probably want to say 'Y' here, unless you are only using the
+	  Dreamcast with a serial line terminal or a remote network
+	  connection.
 
 endmenu
 
-- 
2.32.0

