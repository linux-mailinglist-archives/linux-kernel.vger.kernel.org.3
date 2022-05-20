Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7372852EB51
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348825AbiETL5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348809AbiETL5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:57:17 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01573EAA4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:57:15 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 895D23F20F
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653047834;
        bh=IrJRmi5AylxlMjpRypcc8BFU8eV/I3jeS/028ygI84I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=RhTkoxraEsoflh7mwk9eRzcbaBrfnyYGQ2/olUkcns0c6+O8IdmRtfZGJVdWsc7B8
         5ocLWeP6bmEPxoJ21rz4TLGrwlL1oImePOn9q0dIKYzEGjUBOjE32CrAtWMKIPimal
         J6pgeETpjPfp9fBRjCMT2y4uia2fLcoF/NHTd7vwkfPgGYZhm/GIHaN0pE78R4RZsI
         5ot0NBWQDzsi4cNKthFszfUYzyHoD3Qj3WJJcCBpiIl8YmEZFpsEMykJ4iymH/0TPd
         leqJJO0pIvOGYR+bSXXhHiRYYJzFKOveoq7OtaxwEjTzWEvDdghGrxxgBlLhx78FPb
         rJ8fylPKdHewg==
Received: by mail-ej1-f69.google.com with SMTP id s4-20020a170906500400b006feaccb3a0eso828580ejj.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrJRmi5AylxlMjpRypcc8BFU8eV/I3jeS/028ygI84I=;
        b=7O4eFDBgRlA+klpBmGtQZeUKbzbos1IzbhJjs36cU9oYe8TdnW6C/1zuyTNuZelfIU
         jeCloSxXvsxUWaxdTV62Yq1UE2rMnSlMXYjQLbCdFMvHIagIC7WqCl3z5uNLG7tDPTTG
         vmcUBNQHZ/SgE/2R1tQXpM7fsFi7wrfyIPveTI/Ab73amJJcuZVvc7i8cmuTGHCBGLZz
         /kOI/FTBzeelJlvTwnsce9Qxovezp5NH+tgGk1vzipAhMAg8BknWIHm+vT20Kz2TKMlJ
         56s7l8r3gPtzkAw7Er7A+pwIvhkrjXiFIZNveA5jEz6ZqAnc49pEatOxNW3QlbCpI6sI
         a3Og==
X-Gm-Message-State: AOAM530QMLHh0W1wtxY1PnWyilfSZQcBjXhQI48ks4spPrypfLFLaL0v
        Bkm2pSfgYfF/e0gj10a6dlCxp0jHV8JdeIhnXD8uBt9zxC350eP5V2I1NJyQCuFACxwfhliJBSb
        qYUQj5P9UW5xy3p7U6edlqqkl0vxZK3CwlwYKtCJ7pg==
X-Received: by 2002:a05:6402:34c2:b0:42a:f4da:5aa0 with SMTP id w2-20020a05640234c200b0042af4da5aa0mr10262569edc.260.1653047833820;
        Fri, 20 May 2022 04:57:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2s0EaRhVoMr9T7xvlSBA3I2jqCC/ZSF868KNzlmYWVfHrBmT0n59jDqNhraJB/bedEh2XMg==
X-Received: by 2002:a05:6402:34c2:b0:42a:f4da:5aa0 with SMTP id w2-20020a05640234c200b0042af4da5aa0mr10262556edc.260.1653047833614;
        Fri, 20 May 2022 04:57:13 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b006fe88802203sm2946451ejb.46.2022.05.20.04.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:57:13 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 2/2] s390: Kconfig.debug: Fix indentation
Date:   Fri, 20 May 2022 13:57:08 +0200
Message-Id: <20220520115708.147841-3-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220520115708.147841-1-juergh@canonical.com>
References: <20220520115708.147841-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 arch/s390/Kconfig.debug | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/Kconfig.debug b/arch/s390/Kconfig.debug
index e94a2a7f6bf4..c4300ea4abf8 100644
--- a/arch/s390/Kconfig.debug
+++ b/arch/s390/Kconfig.debug
@@ -14,9 +14,9 @@ config DEBUG_ENTRY
 	  If unsure, say N.
 
 config CIO_INJECT
-       bool "CIO Inject interfaces"
-       depends on DEBUG_KERNEL && DEBUG_FS
-       help
-	This option provides a debugging facility to inject certain artificial events
-	and instruction responses to the CIO layer of Linux kernel. The newly created
-	debugfs user-interfaces will be at /sys/kernel/debug/s390/cio/*
+	bool "CIO Inject interfaces"
+	depends on DEBUG_KERNEL && DEBUG_FS
+	help
+	  This option provides a debugging facility to inject certain artificial events
+	  and instruction responses to the CIO layer of Linux kernel. The newly created
+	  debugfs user-interfaces will be at /sys/kernel/debug/s390/cio/*
-- 
2.32.0

