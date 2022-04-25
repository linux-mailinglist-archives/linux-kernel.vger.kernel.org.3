Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6145950E7C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244215AbiDYSJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbiDYSJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:09:04 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B41137A9C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:05:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so107843pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dZjxS8fBZfnR3tUEX7Fr5ztB4W2O+gimFL+bSmgOq2s=;
        b=kfCDV3l8Tzq8EH4ez/sUJPhWAElJ73hf6OfXyLuBr/woeGMaWpnAT75qaBBeO7ZT1j
         +EcBOxDilOCDErNMCZgX76g9JNLgfeyFiX46m0UuZDTaAAi7IAqhb5e32imp1iTgJq9e
         471hpfCybYAtAITF6Eq2yfYNJnvCbN74XVaMKONa6BFFAl5Y646B/5oExF4BhFIMTlSH
         jn9oH9hZQxD8hZ3k8T2JeLtu6PAKCWDAMX/wOa/hYw22aXcf8WheT3E3SGuVRp/1++6Y
         mrMNXRy88KWiD6kM7VYGa816h9SGkok9z96WCBLbsqjBMQfEjT3BX02ZL87ASGEFhcYO
         4GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dZjxS8fBZfnR3tUEX7Fr5ztB4W2O+gimFL+bSmgOq2s=;
        b=HHItoVPT2iazxgDP4YBvyE3z6zl8zCoYMb8plH/LNfjLuURbZCDtNsSXNgVYyVxilz
         tJmXClVrvJpFpp6Z+wzfNsnRoE8D8fIXDOSk9ogsw6cwGqoUONrjOmWuTtY68WLtYPbe
         ljECNopL6vmJa0ASO0wJ1y9FrLMXgJex28fpV3tsE/Sl7Kmd+gvj5ssVzgoEQEo/BPtw
         BZzoD9CjL88+o1dZH74iNkIqT4pByU/SfctkLA/Eb6zVqlELM1b4wZLT6gjf81w+PiN7
         jk9HVNfIjJkL95Ol58RFg0HsNNMgKIcOYsdqCWb/eZBbd6/6Rjvi0BnYKI/AEBN2qPRL
         ctVw==
X-Gm-Message-State: AOAM532V6P72+QzvizcLE1WuHoo3ylhL2/ueVF4K/sYP0XUAZl2ECPpz
        DjQ/j3IQ/cMyOQElfHPt5fU=
X-Google-Smtp-Source: ABdhPJz9EIG5URy5xH6gweblXRtHIbe0/OQUnlnhnyJTsFIZd3E8d/59I0zMBGiFt/Zn3EjtUL0j9A==
X-Received: by 2002:a17:903:28c:b0:15d:1fc6:8fcd with SMTP id j12-20020a170903028c00b0015d1fc68fcdmr3786908plr.20.1650909958599;
        Mon, 25 Apr 2022 11:05:58 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:ddfa:cc28:10d9:30b5])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm12227096pfb.185.2022.04.25.11.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:05:57 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: enable ARCH_HAS_DEBUG_VM_PGTABLE
Date:   Mon, 25 Apr 2022 11:05:40 -0700
Message-Id: <20220425180540.880632-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xtensa kernels successfully build and run with
CONFIG_DEBUG_VM_PGTABLE=y, enable arch support for it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 Documentation/features/debug/debug-vm-pgtable/arch-support.txt | 2 +-
 arch/xtensa/Kconfig                                            | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
index 83eafe1a7f68..ff21a83abe62 100644
--- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
+++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
@@ -27,5 +27,5 @@
     |       sparc: | TODO |
     |          um: | TODO |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 2ed897299f19..903b910ebc10 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -4,6 +4,7 @@ config XTENSA
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
+	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if MMU
-- 
2.30.2

