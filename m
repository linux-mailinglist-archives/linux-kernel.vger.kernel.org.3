Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745134DAE35
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355124AbiCPK1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbiCPK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:27:43 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2025748D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 03:26:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 17so2501788lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 03:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZ8EHIBzmOyeWvKgy0ZYkrJEoe2rL78XJxOVNyg56hs=;
        b=AGdot4lN7nfcJfBeLT6Ld2ZE71bnWdLlZxePtqX8WUBQeFH1CSKRlloc26tuKdVPef
         TM/NFS9rfikGYs6YiK0Zw/RXAnISjmnt2XpIddVhWGUcABPKaML5kgCkj0Xsav0Vf0Ch
         csre2Iy+NNgIdvwSVHs5E7fajEWxEVk++GIx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JZ8EHIBzmOyeWvKgy0ZYkrJEoe2rL78XJxOVNyg56hs=;
        b=1JyVQnJ2O3jEUuwGLsagCvPstWZ/PgIQVdruT1DmOVvDsz82rsjQfmFyRkh6jFe3wU
         dz6fxyCxgox3QCtyxx7q05vWiZFvVvbNlsEnghUn3w3OFSHFjiH4BIlO2eJrHQAnwFPx
         pW7EI9Z8eqQPN3hFlvzbxa3x0M8pgiI58HwsBxC/5uWPhFprTQyBU4nkREpfS1cuzOCb
         32suCJtJJgN/bdAYTLkKbsYmfwWX/h60acAQPlyCtphWFYrOvBD4V4epH58LP6xrS2fs
         jS1Eh7TW8VgW6zY+EYrswGf3qqyIAPJc4cYawk69xTqK+ZqCPBD3vUZnNP28kPbyKGG7
         MXBQ==
X-Gm-Message-State: AOAM531ziCf+z4p52tCcZMNVUWca7RG0O8WhgztxnLyumPUMlv166Vqd
        VCrFfXI6SXFS3yQ9yv7BeL6W6Q==
X-Google-Smtp-Source: ABdhPJxReci0Y1M/kl0TZiMK9Ql/NpCDfs/OiPp95bf5pXykHDmtkjaEYhrO7I4VJS5ptGi52k93Ug==
X-Received: by 2002:a2e:9b8b:0:b0:234:38f3:e85c with SMTP id z11-20020a2e9b8b000000b0023438f3e85cmr19785045lji.452.1647426385725;
        Wed, 16 Mar 2022 03:26:25 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u16-20020ac25190000000b004433b80c1d3sm145062lfi.182.2022.03.16.03.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 03:26:25 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kyle McMartin <kmcmarti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/panic.c: remove CONFIG_PANIC_ON_OOPS_VALUE indirection
Date:   Wed, 16 Mar 2022 11:26:22 +0100
Message-Id: <20220316102622.562572-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have the helper IS_ENABLED(). Use that instead of having an
unnecessary hidden config option.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/panic.c    | 2 +-
 lib/Kconfig.debug | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 55b50e052ec3..304957f5b3c4 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -46,7 +46,7 @@
 unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
 #endif /* CONFIG_SMP */
 
-int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
+int panic_on_oops = IS_ENABLED(CONFIG_PANIC_ON_OOPS);
 static unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_GCC_PLUGIN_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
 static int pause_on_oops;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14b89aa37c5c..40211c343a14 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -995,12 +995,6 @@ config PANIC_ON_OOPS
 
 	  Say N if unsure.
 
-config PANIC_ON_OOPS_VALUE
-	int
-	range 0 1
-	default 0 if !PANIC_ON_OOPS
-	default 1 if PANIC_ON_OOPS
-
 config PANIC_TIMEOUT
 	int "panic timeout"
 	default 0
-- 
2.31.1

