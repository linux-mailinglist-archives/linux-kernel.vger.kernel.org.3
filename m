Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D732533E09
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbiEYNj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbiEYNjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:39:55 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9642289AB
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:39:54 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D35C3FD8F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653485993;
        bh=YxMHNNo7yhfXfhg4oP8VVxFgO1u9JXBVrJrSswFRrJY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=luXaulxSoQQR9C5zOY2xinXYME3xPQbSb79b8iDd9YyAbv/lWWdBFhjjihV9fbtxB
         /APy3jVdR7WHfsIUiTMx6IOw4VtfIB2HnxgsIeVxULlg7u7k8W1jXnZI6yVcauQrO0
         JyMRafwv4LUqhP+Y4ostEYRv/cAMJEYXEScFmT8q06q1WattDrdCT9ne3FIo3mFptD
         BZsJ3hqmKtKbgR7GtkCWLkBx8aG4i5dLePkhYwSgveQJzQ1SsBXH5ukLEIkMc3P27p
         tzjt6ePNZIXN7Gq6/T5xdwKGe5umerqI7qW40iJUJWpYGnWNZnrnP1ZSx3MPNUExg0
         ZeKGlgWMMloVw==
Received: by mail-ej1-f72.google.com with SMTP id gr1-20020a170906e2c100b006fefea3ec0aso3388866ejb.14
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxMHNNo7yhfXfhg4oP8VVxFgO1u9JXBVrJrSswFRrJY=;
        b=o18ewGogNBybJDx/ohUA93AgcfbfPJUA7Y5icizTVSKpEYDB2lPXp6xTid2Mes6fhP
         EkV0w6ZlI27SNuMxcUzWnAEw2oaYALg0zHxXkwRsV3PmJyuNzA8ssiKWovaJgFZDdk6V
         u/4B27hafNOthOPGKpZxPLW0PM09LN+okmRREny08ciQ7Ax+ZFH5Af1slDeR+pFmF7rr
         KmH30FAQFvmEdyccgQhJkUL1Chl6C5j1OoxXJp4SaFjUFyxNCAtENwFRXDVYmvzcVeZO
         b0Jzg/YCEgOBs+nXVQfXypc2nrm8z3dhdwumofMNAKA6lzXdcPS3EQgLLe23S5kIRtNk
         yn/Q==
X-Gm-Message-State: AOAM531BwSkq+m0Vm7x6fy6oB2X8dtKJb00zaPa/h4OfAS0r1u50CIT/
        iuyljFC5YTbWhTEK1gSPKZkAoNuCmWxQaC2/GHat90uuA+I084FC0Z3tqf2DBL8j0mU9+WptqYs
        TRthMnaQDDLUpdbGbtNsAK/06Ep57ObD0UdTAV2Demw==
X-Received: by 2002:a17:907:948a:b0:6ff:14dc:2fe7 with SMTP id dm10-20020a170907948a00b006ff14dc2fe7mr2353534ejc.299.1653485992587;
        Wed, 25 May 2022 06:39:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2axYjo493ViwTotKYqEg/RE3TxvUkH76euuzDljStK+89C0yRXXkrtYPcybPJyXiOnDYmGg==
X-Received: by 2002:a17:907:948a:b0:6ff:14dc:2fe7 with SMTP id dm10-20020a170907948a00b006ff14dc2fe7mr2353512ejc.299.1653485992400;
        Wed, 25 May 2022 06:39:52 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906150c00b006ff045d7c9bsm1689131ejd.173.2022.05.25.06.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 06:39:51 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] x86/events: Kconfig: Fix indentation
Date:   Wed, 25 May 2022 15:39:49 +0200
Message-Id: <20220525133949.53730-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
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
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/x86/events/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index d6cdfe631674..6b5df277ed58 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -6,24 +6,24 @@ config PERF_EVENTS_INTEL_UNCORE
 	depends on PERF_EVENTS && CPU_SUP_INTEL && PCI
 	default y
 	help
-	Include support for Intel uncore performance events. These are
-	available on NehalemEX and more modern processors.
+	  Include support for Intel uncore performance events. These are
+	  available on NehalemEX and more modern processors.
 
 config PERF_EVENTS_INTEL_RAPL
 	tristate "Intel/AMD rapl performance events"
 	depends on PERF_EVENTS && (CPU_SUP_INTEL || CPU_SUP_AMD) && PCI
 	default y
 	help
-	Include support for Intel and AMD rapl performance events for power
-	monitoring on modern processors.
+	  Include support for Intel and AMD rapl performance events for power
+	  monitoring on modern processors.
 
 config PERF_EVENTS_INTEL_CSTATE
 	tristate "Intel cstate performance events"
 	depends on PERF_EVENTS && CPU_SUP_INTEL && PCI
 	default y
 	help
-	Include support for Intel cstate performance events for power
-	monitoring on modern processors.
+	  Include support for Intel cstate performance events for power
+	  monitoring on modern processors.
 
 config PERF_EVENTS_AMD_POWER
 	depends on PERF_EVENTS && CPU_SUP_AMD
-- 
2.32.0

