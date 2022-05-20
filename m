Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5252EB50
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348818AbiETL5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348810AbiETL5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:57:17 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF92837A36
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:57:15 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 37F653F208
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653047833;
        bh=1CO8KzxClB5nlE/5DYEJ5RBOK51FcaAi8ttXMoNqVVY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=iApajo/rnsakQPmX2St4KN4hnlj50V/Y5Ok23SP08z5tf4ZDCbqxgsFb20xvsR0Q7
         mU74HoKpEnn7qDrK2iNYFhIlW2ZDRezLQJPB31ayHWDOOsl+GrQYjPPGwxn4McZtkF
         eKbP8WQt1Iy2vwubTDmvaQOsS9EwN3c8LyiRk8cw9xobJI4rTAD5KPf14ETvFz3hJm
         REa3dPDiYTtfEsMruzO2GzCfRCCCM88GGTcW8GPUW5F7yd936rBJVzWNV8qTWUepW5
         q5XBso02B0gqaPUz37TjDH6SdpnGGvgKI/Gilf5wsK0EQXY++BIGMIDY/zNTei3ME0
         pnD7ofbSYGYbA==
Received: by mail-ed1-f69.google.com with SMTP id n9-20020aa7d049000000b0042aab725949so5514841edo.23
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1CO8KzxClB5nlE/5DYEJ5RBOK51FcaAi8ttXMoNqVVY=;
        b=ZgfycHnS6LYbhbrSRvyvoGbHEJw2cuudV5Jfew6PDTCHNjRPISB//lbjoW+snwRPrq
         3Rl6uJfmxtcfV4Bzc/es37nEmg5KrWAfMU7R/cRSpNOqpLddE3f7D+bAOWNXT82z8cym
         KXE2EIYpGyco0eEw0yJQakz0LT5Lj+DJx312WNYg5HWtZ7hOo/hEWtRp0bUMmEsiYSnc
         JItwnCVbUhdUxUjo3dap8RicFchwjI6B68WhAgROMU8P4OrzU71eZfdO26sHBvVGf+2G
         9Ffe1DfxVY03aSjBuGUAZjS/D2haS6hx1iKi3/WWL+5q+71+65alwBlkJ0uRcAIT5Ve0
         NhIw==
X-Gm-Message-State: AOAM531QxTBVzJBD8R/FRL5yLh/yq3WSItHtbhsPBw0zMOkjAWBjyfdj
        vqkAiQhnpA0XTDJIF2lONIpfxgJVjFZy7mMamiF70B01mjfOYKfZ2EODJOI1+0fJ67W4zv7cOgA
        uovkoE1Oi0/qs0KiLR1CgsAgW9QiC5vMDLCh0TOgY1Q==
X-Received: by 2002:a17:906:7944:b0:6da:b834:2f3e with SMTP id l4-20020a170906794400b006dab8342f3emr8565551ejo.353.1653047832851;
        Fri, 20 May 2022 04:57:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNIMcgPyCKVvSGFnNFVuiIKgdy04+FaNv8RjMQgn24l3JbCESZH8P4C2v/HyUvoXEtNMzZ+w==
X-Received: by 2002:a17:906:7944:b0:6da:b834:2f3e with SMTP id l4-20020a170906794400b006dab8342f3emr8565535ejo.353.1653047832656;
        Fri, 20 May 2022 04:57:12 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id ze16-20020a170906ef9000b006fe88802203sm2946451ejb.46.2022.05.20.04.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 04:57:12 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 1/2] s390: Kconfig: Fix indentation and add comments
Date:   Fri, 20 May 2022 13:57:07 +0200
Message-Id: <20220520115708.147841-2-juergh@canonical.com>
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

While add it, add trailing comments to endmenu statements for better
readability.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/s390/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e084c72104f8..ae871569dcd6 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -607,7 +607,7 @@ config RANDOMIZE_BASE
 	  as a security feature that deters exploit attempts relying on
 	  knowledge of the location of kernel internals.
 
-endmenu
+endmenu # "Processor type and features"
 
 menu "Memory setup"
 
@@ -655,7 +655,7 @@ config STACK_GUARD
 	  The minimum size for the stack guard should be 256 for 31 bit and
 	  512 for 64 bit.
 
-endmenu
+endmenu # "Memory setup"
 
 menu "I/O subsystem"
 
@@ -736,13 +736,13 @@ config VFIO_AP
 	depends on S390_AP_IOMMU && VFIO_MDEV && KVM
 	depends on ZCRYPT
 	help
-		This driver grants access to Adjunct Processor (AP) devices
-		via the VFIO mediated device interface.
+	  This driver grants access to Adjunct Processor (AP) devices
+	  via the VFIO mediated device interface.
 
-		To compile this driver as a module, choose M here: the module
-		will be called vfio_ap.
+	  To compile this driver as a module, choose M here: the module
+	  will be called vfio_ap.
 
-endmenu
+endmenu # "I/O subsystem"
 
 menu "Dump support"
 
@@ -758,7 +758,7 @@ config CRASH_DUMP
 	  This option also enables s390 zfcpdump.
 	  See also <file:Documentation/s390/zfcpdump.rst>
 
-endmenu
+endmenu # "Dump support"
 
 config CCW
 	def_bool y
@@ -902,7 +902,7 @@ config S390_GUEST
 	  Select this option if you want to run the kernel as a guest under
 	  the KVM hypervisor.
 
-endmenu
+endmenu # "Virtualization"
 
 config S390_MODULES_SANITY_TEST_HELPERS
 	def_bool n
@@ -945,4 +945,4 @@ config S390_MODULES_SANITY_TEST
 	  kernel developers working on architecture code.
 
 	  Say N if you are unsure.
-endmenu
+endmenu # "Selftests"
-- 
2.32.0

