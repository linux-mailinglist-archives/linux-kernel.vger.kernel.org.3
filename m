Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81A1536290
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbiE0M22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355143AbiE0M1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:27:24 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3906614E2E4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:06:05 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 32A173F325
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653653144;
        bh=ELHJEY2eK+muvmAqygYYF3QcvcVcGsf6LdaPdx8n1nw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=c2y9ErVISxnurLKUWuvbA4e3MXhyStRC/4XRKhJios0Rm8vFBkmI+qVlRy+62PCp2
         IWeLLpU97k59fXSjNGZFuW44VH9Nh+8YGYGCoo3x749bJYibBa4A3rlGYEO0Uyk9P+
         H0m4Kj6dIcMA6TlTz+aznjpLfGw0YWg97RjHY0rjukUmjUIMzAOG4SUSiZ4im7huOB
         WQhT8ulzVkyq39WNENHHk5QzjSV7JKU3vj/Bmcsv+zgY2NByZmltS4/6Wx/lLwOHK7
         A/nX9QiIHFAMPIE+QRY++dGqkqppv7edq3TkKr+n0k3tkU76rIgCS57B51ChspZ1OK
         t7qYnSYXpkN3Q==
Received: by mail-ej1-f69.google.com with SMTP id lf18-20020a170906ae5200b006fec8de9f0cso2329964ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ELHJEY2eK+muvmAqygYYF3QcvcVcGsf6LdaPdx8n1nw=;
        b=eHqRxIaQIsEt7n3fFYeE2ZIA0inHlq2aXT1q/+U3U+OlPWblcFPXDkBcYe8weAlkKb
         ikR/JeoqAiJyh8A0fW2laq6eJJBYrRD0GwfG3JU1VYpGn4RBcenU5NrN1R2vQwB5RZYS
         ERaennHNbAbO2PlybSw7F40gEmala0damsoG2CnPWPOTlDbC580y77exqumZPQjIr18b
         wda1fNgBPMKhDsXDYymEzdlzc6FeoGrFndC4lshVmEOv+1V7vMTC2uzaaBYK1i2inwmi
         k9E41Bz7eLGjdu/sHLhl9fxz80VAgiB/+FKnEmdGwu4WeUuRGLZNNFXTEI+Q+4UP/ocl
         yBAg==
X-Gm-Message-State: AOAM531yGKkpTv9VR6c0oKOIefs1FKHWsI1axlvs6JRyydsS7Gn2fuuz
        Jt/dacHTgPPPik0ZdZtL+fe0JmTo3EDT+th7uVSs3Orz5NZ3ZVBoE0BopgYEHQN13lYr4yW4S0M
        aW4ZwNDEV37Ym5ZnQIH28cYoH4y9xK8Eq0UovkJE7cw==
X-Received: by 2002:a05:6402:1706:b0:42b:d175:1ef4 with SMTP id y6-20020a056402170600b0042bd1751ef4mr11066738edu.10.1653653143860;
        Fri, 27 May 2022 05:05:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKkQu4vwex1CUmBeJ9KoXEu4mtwoV5MbQHQl3N2T9xbM71iOZbr2cqRkGUGMbhsI+DOreR0A==
X-Received: by 2002:a05:6402:1706:b0:42b:d175:1ef4 with SMTP id y6-20020a056402170600b0042bd1751ef4mr11066724edu.10.1653653143714;
        Fri, 27 May 2022 05:05:43 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id j20-20020a1709062a1400b006f3ef214dcdsm1401927eje.51.2022.05.27.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:05:43 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, sergei.shtylyov@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 4/4 v2] sh/mm: Kconfig: Fix indentation
Date:   Fri, 27 May 2022 14:05:40 +0200
Message-Id: <20220527120540.459462-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <be49dcae-af31-c825-6ab4-05c59deec9d8@gmail.com>
References: <be49dcae-af31-c825-6ab4-05c59deec9d8@gmail.com>
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

The convention for indentation seems to be a single tab. Fix the lines
that violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
v2:
  Update commit message per review comments.
---
 arch/sh/mm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index ba569cfb4368..a563211aeb63 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -2,7 +2,7 @@
 menu "Memory management options"
 
 config MMU
-        bool "Support for memory management hardware"
+	bool "Support for memory management hardware"
 	depends on !CPU_SH2
 	default y
 	help
@@ -141,8 +141,8 @@ config ARCH_MEMORY_PROBE
 	depends on MEMORY_HOTPLUG
 
 config IOREMAP_FIXED
-       def_bool y
-       depends on X2TLB
+	def_bool y
+	depends on X2TLB
 
 config UNCACHED_MAPPING
 	bool
-- 
2.32.0

