Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64489596C43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 11:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiHQJqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 05:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHQJqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 05:46:25 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D086E69F49
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:46:23 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BB3B83F1A1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660729581;
        bh=zWk9eESY3hoq2s8dqa8GbXA1GpkjD42C4QlCGio8uuU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Of6y1LGtLSRo/z/UOqdLieVSWh6iis9UM14n3dH6gHifPNgSH4mRge65lcW21iNKM
         ofsRckN7430PvOzre4lbWkUTayWXZ8BTae/x2eRAoF1ra1+IakstbVu1qxc8KvQGiq
         70EeX+Trp2TTDS44oXY7OO29K56U3sqjqstw0D+owO5S9o6SPvVArzEqKKPJKg7v57
         6zRcHwfu5EpBKwnyQsBuZqLdZVixdERpaybq/WLetdIFCKvtcSx09YEfd3m+Zyek8V
         OHU17+PxKZ/86kGOVeClNF7fOOj3uhA12evp7Nv+0BQ2Qquiymq8e/NtwWqZIbLk6d
         L6W2vzT4u39iA==
Received: by mail-ed1-f72.google.com with SMTP id r12-20020a05640251cc00b00440647ec649so8555027edd.21
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 02:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zWk9eESY3hoq2s8dqa8GbXA1GpkjD42C4QlCGio8uuU=;
        b=Zw81e5MFsp39kgXSZzj+Q+f5W/xBJzgK4LkFACkL9P1O/InzACmiSiYht6SBTCixc/
         pwBheRZ7GFx0NSu207CjceP0yyYduDOG2SeXehD4flslHrN76kSWgWlKrqbLP/4KNVC/
         RlFtvqwwHN8t0ZCJtFZhrrXr9YXehMWrraE6o0LP/j/I9obE3ghZn5a8fZlmh/6u3y2W
         d0Xy9wON03JSjnxsenIJ5ky98LD0H0SNqhOhfCYJNX1NnhSqS+7y/NWF99Mu0u4GJDxo
         4fzC20+NFk0kkG5MBJzcQXydqQ2h5Y5qUbGdP2VJYIbpuIKE5VBM+hLhsCA05oKpPQXV
         +5Og==
X-Gm-Message-State: ACgBeo2HJYdXWQdNPIIRbv9WWFbBnuyXBCErRyT0PIUmEViFbpMedlYw
        ok+DRJ7sYXAPKY91wbBkYmmGG25geNnv5II3vwPM5Q+ZWPOZrmWagsHxYQCMeUg5mKLqUYhmUup
        LeLH+xtO5YEDe29MI1gYIeFoVeVB/Vm99WvY3cj5+Dg==
X-Received: by 2002:a17:907:16ab:b0:731:55c0:e7a1 with SMTP id hc43-20020a17090716ab00b0073155c0e7a1mr16272427ejc.154.1660729581472;
        Wed, 17 Aug 2022 02:46:21 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4DfMZFHDMrpKNWCsqeIPxkCdcSUM6u88VTs4Jyu8uGmM8Gri7CTeefNWkn88XWIY0fP9pr+w==
X-Received: by 2002:a17:907:16ab:b0:731:55c0:e7a1 with SMTP id hc43-20020a17090716ab00b0073155c0e7a1mr16272409ejc.154.1660729581274;
        Wed, 17 Aug 2022 02:46:21 -0700 (PDT)
Received: from arighi-desktop.homenet.telecomitalia.it ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id el13-20020a056402360d00b00443d657d8a4sm4778826edb.61.2022.08.17.02.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 02:46:20 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: head: rely on CONFIG_RANDOM_TRUST_CPU
Date:   Wed, 17 Aug 2022 11:46:18 +0200
Message-Id: <20220817094618.67063-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_ARCH_RANDOM .config option has been removed by
commit 9592eef7c16e ("random: remove CONFIG_ARCH_RANDOM").

Depend on CONFIG_RANDOM_TRUST_CPU to determine whether we can rely on
__arm64_rndr() to initialize the seed for kaslr.

Fixes: 9592eef7c16e ("random: remove CONFIG_ARCH_RANDOM")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 arch/arm64/kernel/pi/kaslr_early.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
index 6c3855e69395..a1e6f90cb6e2 100644
--- a/arch/arm64/kernel/pi/kaslr_early.c
+++ b/arch/arm64/kernel/pi/kaslr_early.c
@@ -94,7 +94,7 @@ asmlinkage u64 kaslr_early_init(void *fdt)
 
 	seed = get_kaslr_seed(fdt);
 	if (!seed) {
-#ifdef CONFIG_ARCH_RANDOM
+#ifdef CONFIG_RANDOM_TRUST_CPU
 		 if (!__early_cpu_has_rndr() ||
 		     !__arm64_rndr((unsigned long *)&seed))
 #endif
-- 
2.34.1

