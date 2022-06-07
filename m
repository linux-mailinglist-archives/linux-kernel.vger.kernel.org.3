Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9EC53F495
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiFGDe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbiFGDeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:34:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F0A54BC9;
        Mon,  6 Jun 2022 20:34:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so3518112pjg.5;
        Mon, 06 Jun 2022 20:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=j+34dCcukf9PXBWCiMpVOcSYINlnf3l4rEt7ntPmdrM=;
        b=T7dVKrPWaArlqWFPtXdPN46rXROBdTVOo5l/rYHknGNV/FeJAi9nNXNWgc1A4rRP7m
         lHCzVjjk6P8oviwW4TDuCOc66NxLYY+NkxpUBwlazjj9HMghUEUXrMCnko9vBpKnVG9b
         /MfbVxcnohjXqQsSKpzmApheZsimHG8bg1XShXDAZ5GGXPqbkQdYowJS0hrBoCd1vtxB
         hHtduI0ODIEWOgt7f4GOnDBIxIfAU7JNxihKyS9a9Mg4Rlo0lo9+Fo2qNxwysU7VH0r6
         uDOwfTfKn0C2lxeJkVLAd38LMbCKuJVpiWFKdbc0dGNNg7bki8Urm8NuC+9AWFM2Vgmq
         v+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+34dCcukf9PXBWCiMpVOcSYINlnf3l4rEt7ntPmdrM=;
        b=mGEspK8QSV14g8msQwlzKBg4QJLS/JVcEapIyhzJq0jUXDFAmPE9+ov3chl7IeHiZn
         eZXZyN3ScHxHndf6gtLXA80IYf5OyX26lFMOJLN9Hjq6wgXFiUXmOs8dEDw+a8rOiqZz
         X54CBoAAdq3BJVWz4zioqh1tEHEMbK+wawX/MOwu21MJhYYxG62fEZ0mRx9OIteOATfc
         hfvEY2ZCFlfkymSGpx0AkQNcOb/rTL2jOGKtM5un6EnmcyuZRZWNJglEOa5Ak7x8lXsC
         vlepsY4n70pI7qVlr6kXGKFLMCneQJrZn6OWF7zPgaFiroA3FTyupRFQB5fQJHFcG3Rq
         dUlw==
X-Gm-Message-State: AOAM530eIEM7KcKB5/eLYte3ObIFz5odozeo4GaMGjfPgxjQsFCFtzAx
        yy3LobRErSJCQwXXupDFPMm0aw8BkiB5T1V9
X-Google-Smtp-Source: ABdhPJwSLHAeo7lN00jNfnGhP55M1g9EKYv/MW1lkiSbIWe/ZZ69cpjnyqMKJOn9ZWKLz+560qg/lQ==
X-Received: by 2002:a17:90b:3841:b0:1e2:f16a:a117 with SMTP id nl1-20020a17090b384100b001e2f16aa117mr49309179pjb.130.1654572859379;
        Mon, 06 Jun 2022 20:34:19 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id l24-20020a17090ac59800b001e25e3ba05csm16700350pjt.2.2022.06.06.20.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 20:34:18 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Miaoqian Lin <linmq006@gmail.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] sparc: prom: Fix reference leak in of_console_init
Date:   Tue,  7 Jun 2022 07:32:59 +0400
Message-Id: <20220607033306.688-2-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607033306.688-1-linmq006@gmail.com>
References: <20220607033306.688-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() returns a node pointer with
refcount incremented, we should use of_node_put() on it when not need
anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: c73fcc846c91 ("[SPARC]: Fix serial console device detection.")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/sparc/kernel/prom_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index 3df960c137f7..7fc1c2dc31d5 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -295,6 +295,7 @@ void __init of_console_init(void)
 
 			dp = of_find_node_by_path("/");
 			path = of_get_property(dp, "stdout-path", NULL);
+			of_node_put(dp);
 			if (!path) {
 				prom_printf("No stdout-path in root node.\n");
 				prom_halt();
-- 
2.25.1

