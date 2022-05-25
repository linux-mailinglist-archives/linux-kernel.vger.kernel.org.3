Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D485533C33
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241421AbiEYMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243220AbiEYMCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:02:06 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3510421B2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:02:05 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 00E763F6F9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653480124;
        bh=NBsh7HLtz477jQnNDrBziTrv34OGyGgoiBBMRY6NAL0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Z+7F95BuEO5qS0MUGB6bJCpsHC16BvlpykDL/lIApjrEwm/rIZZ1/p90EFtWf/Q7Y
         vfLehfzWxRM9xXtu9+J2s9ukqN5Vg9zmYWgCiW86rqdyHnoQbqFkTIJIfa8/1eOODJ
         dOdHjbZ0+2L8zOykShjZCeAp5Mz97tzTrHT4EnaMHISo4fP/ngieV2Vku1SpDcp7LH
         YB1cv2pmcT5CtmCq00dbpMNrXcx4VYxmjN6ca4s8d7RqVxAAo7GvybotXIB4HrFchS
         OUu5qtEAk1VI+bolglcOGroncEN8GIeF36tZnvie1J7s3pAMqkZAO6nP5CVVT5WV0p
         Tft+XyO8cedow==
Received: by mail-ed1-f71.google.com with SMTP id w14-20020a50fa8e000000b0042ab142d677so14762620edr.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBsh7HLtz477jQnNDrBziTrv34OGyGgoiBBMRY6NAL0=;
        b=i89YeWwaAs7NVLMc0zZtlgeogOB/kLjPWBT0mXCb8eko7kErYGZeD/kOCgAs/ElMAs
         xz+MpsFfm30sZ5f3PiqkpMYglOiwegOcSGnn1KikDVkNYyNFvIQfvGB0wwx6ZHKf94r7
         Sb1EI0ns92kt6/AdjtHfsVXsHo85p+NGzuKWYwRy0ACbk4oSON4HMn4r2ooW2bBErOMq
         U5WQ7mvj/Cyy5uWutKajK4ZGkZx5I89T57vgG8JESZCvAy+7h8GL9+m13k63ik7qcQXw
         bo7hHMIvqy9J0qLz1QOOyHwricNOGpmIZzVtQRDjfua5+FAIsAwn+010Z9IWjg0R+pDq
         rfXw==
X-Gm-Message-State: AOAM530oMiaZS7qZ8/8MWnPlOYa6MWYLtKE1UM1jo6wCNEhOOTJpLbr9
        l9oXS1TOO9Pa17CJoBNviSfPbrgBD74gO8de+OFWAgq1kKbRg+qtomLjS2LbGgxnZBzR6yYhqoi
        /I7tTIOw/BcdPOQNt1C6hY/x+MDXvA6sjRyHYIXQVTQ==
X-Received: by 2002:a17:907:168d:b0:6fe:e7b7:e52 with SMTP id hc13-20020a170907168d00b006fee7b70e52mr12642948ejc.330.1653480123565;
        Wed, 25 May 2022 05:02:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpvixsysiEX+Ix2v/02GfvLL2dSaTMPsnBQpmjhjxCD60aAsLOQcfH+i2i6OLjU0n30H0Dpw==
X-Received: by 2002:a17:907:168d:b0:6fe:e7b7:e52 with SMTP id hc13-20020a170907168d00b006fee7b70e52mr12642928ejc.330.1653480123364;
        Wed, 25 May 2022 05:02:03 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id hh15-20020a170906a94f00b006fec41b21e1sm4257609ejb.171.2022.05.25.05.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:02:02 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 2/2 v2] s390: Kconfig.debug: Fix indentation
Date:   Wed, 25 May 2022 14:01:51 +0200
Message-Id: <20220525120151.39594-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <Yo35NdfKlGwu5Trd@osiris>
References: <Yo35NdfKlGwu5Trd@osiris>
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

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
v2:
 Change author and sob email addresses to match sender email address.

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

