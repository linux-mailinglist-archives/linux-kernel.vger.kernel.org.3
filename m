Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80A0530A77
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiEWHj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiEWHjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:39:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828E81ADB7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:39:50 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 716BE3F175
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653288321;
        bh=Gs7nkhQpjKgLYfigMkBppO9/Q0SxQAi+BOTu7LkmDEk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Q3FRq/S64K3ocwrKVDP/h+7kTfyiPMbUDN5bLeEaQri7YW75k9+1LENny/7lAyqqh
         gZR/trzltQiZBv0ZUTA/zA+qs/NNnSenDdQqwO7TR1V58vzwlFSz5RxqUG3xiShQE8
         lpNEXRm0/SjI1sb97tBPtQC3oYD0/QVkxC/J8GIhlXRDXlVDeBsINVpZ2i8BRnPgyn
         01t/kwngOkvfRR8WjEdAe4BJbx1y8VI/C3eooErlKAk6h4VRMsy9hWi2AKIDGKQIiV
         CjtpP0Y36OFLRRjIDnN23NKxjSgrnFO/UnEpLQEu+AZZ8x1I9d/7XjPRt2ow9tGwBX
         qylmI7CuxP4gg==
Received: by mail-ej1-f69.google.com with SMTP id gs6-20020a170906f18600b006fe7a9ffacbso5422613ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 23:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gs7nkhQpjKgLYfigMkBppO9/Q0SxQAi+BOTu7LkmDEk=;
        b=ae8suNJcAWaZYalZnH5nzKLdcfoHR/+jE/dWI244XHX21M0n2hYVbl8dQ+7HqzuJfi
         dzHqto+jNj7BXB+6ChXzPLyys6huMFYOaRnLT8BaN/mR59SEWytioutJroxCNaqJ9Q/v
         S0qoNCqCSgISkQuLZ7FOGYGtbkMWzQP4ysm1BY8XmpHPKLSUtX3oAB6wZPUhOHQRl2IK
         AS79FYAJYDnkqqW08PbuhkhG2OfXR954qxO3jOO3H9v1k8XjSOF5479aQ9QN6pwk/gJG
         B6prvfjRppLc8/Ih6/dDyG6Po/UybKWl+s87aRXqU7ooHIizaQ8JfXJYdL+cA3xZchVD
         /XmQ==
X-Gm-Message-State: AOAM530v3o/xKpgxpFez2T1uo2/4aXR3+QYcGNUk3vvAOFYGAkBGqm/u
        WqCKRdLqSAmrMEI8TQc4eC0r2eGYCoWGKXB3frEN64NcnLlPeK8imMDeN6O3BOH1TCWQu8G+i/l
        H7lpG6g2IKo/MdWJ5RnUg3KJ+RGv0T6xtpSDo8JA6XA==
X-Received: by 2002:a17:906:5941:b0:6fe:9277:8fe with SMTP id g1-20020a170906594100b006fe927708femr18208133ejr.749.1653288321108;
        Sun, 22 May 2022 23:45:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxQ5t8hnZvZAibglgBrx6pCuhjRthEKjfwHqEG1khpI628VBjfFTFTpluxVJOUTUBtdAHrVA==
X-Received: by 2002:a17:906:5941:b0:6fe:9277:8fe with SMTP id g1-20020a170906594100b006fe927708femr18208123ejr.749.1653288320946;
        Sun, 22 May 2022 23:45:20 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id u15-20020a170906068f00b006febc86b8besm2366194ejb.117.2022.05.22.23.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 23:45:20 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] ARM: mm: Kconfig: Fix indentation
Date:   Mon, 23 May 2022 08:45:18 +0200
Message-Id: <20220523064518.12327-1-juergh@canonical.com>
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

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/mm/Kconfig | 48 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index d30ee26ccc87..950f67220caf 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -123,13 +123,13 @@ config CPU_ARM925T
 	select CPU_PABRT_LEGACY
 	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V4WBI if MMU
- 	help
- 	  The ARM925T is a mix between the ARM920T and ARM926T, but with
+	help
+	  The ARM925T is a mix between the ARM920T and ARM926T, but with
 	  different instruction and data caches. It is used in TI's OMAP
- 	  device family.
+	  device family.
 
- 	  Say Y if you want support for the ARM925T processor.
- 	  Otherwise, say N.
+	  Say Y if you want support for the ARM925T processor.
+	  Otherwise, say N.
 
 # ARM926T
 config CPU_ARM926T
@@ -838,19 +838,19 @@ config HARDEN_BRANCH_PREDICTOR
 	depends on CPU_SPECTRE
 	default y
 	help
-	   Speculation attacks against some high-performance processors rely
-	   on being able to manipulate the branch predictor for a victim
-	   context by executing aliasing branches in the attacker context.
-	   Such attacks can be partially mitigated against by clearing
-	   internal branch predictor state and limiting the prediction
-	   logic in some situations.
+	  Speculation attacks against some high-performance processors rely
+	  on being able to manipulate the branch predictor for a victim
+	  context by executing aliasing branches in the attacker context.
+	  Such attacks can be partially mitigated against by clearing
+	  internal branch predictor state and limiting the prediction
+	  logic in some situations.
 
-	   This config option will take CPU-specific actions to harden
-	   the branch predictor against aliasing attacks and may rely on
-	   specific instruction sequences or control bits being set by
-	   the system firmware.
+	  This config option will take CPU-specific actions to harden
+	  the branch predictor against aliasing attacks and may rely on
+	  specific instruction sequences or control bits being set by
+	  the system firmware.
 
-	   If unsure, say Y.
+	  If unsure, say Y.
 
 config HARDEN_BRANCH_HISTORY
 	bool "Harden Spectre style attacks against branch history" if EXPERT
@@ -1005,14 +1005,14 @@ if CACHE_L2X0
 config PL310_ERRATA_588369
 	bool "PL310 errata: Clean & Invalidate maintenance operations do not invalidate clean lines"
 	help
-	   The PL310 L2 cache controller implements three types of Clean &
-	   Invalidate maintenance operations: by Physical Address
-	   (offset 0x7F0), by Index/Way (0x7F8) and by Way (0x7FC).
-	   They are architecturally defined to behave as the execution of a
-	   clean operation followed immediately by an invalidate operation,
-	   both performing to the same memory location. This functionality
-	   is not correctly implemented in PL310 prior to r2p0 (fixed in r2p0)
-	   as clean lines are not invalidated as a result of these operations.
+	  The PL310 L2 cache controller implements three types of Clean &
+	  Invalidate maintenance operations: by Physical Address
+	  (offset 0x7F0), by Index/Way (0x7F8) and by Way (0x7FC).
+	  They are architecturally defined to behave as the execution of a
+	  clean operation followed immediately by an invalidate operation,
+	  both performing to the same memory location. This functionality
+	  is not correctly implemented in PL310 prior to r2p0 (fixed in r2p0)
+	  as clean lines are not invalidated as a result of these operations.
 
 config PL310_ERRATA_727915
 	bool "PL310 errata: Background Clean & Invalidate by Way operation can cause data corruption"
-- 
2.32.0

