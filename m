Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF13584732
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiG1UqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiG1Upl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:45:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D136D3A49A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id t2so2814295ply.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=gfO26u2xpyVmEWxjONFXEHf40ylM6r3kRxMGtINMS28=;
        b=CqUpKZVcHUdGhidYMYjokkBi17q5SK18jd7MhWe5pwlpQrL2nQqeN19YTR0WYDAFbP
         CMXhllFoexuWnVPLj4OetWCIXeI9nvG6zUlojn7oUojsxyNpgy7iF7r1rfVjsYa0ze71
         xnb7t4vhiEViH6GAuV16Z31aSTVXUb5Gw00YwzsqcVrbtgZvjF3zYtKzugy+OFOVYce+
         XTYTpiiV5Uqu8E6hZ+/VnjofZ9wyy0blnM4F2o3or+2R2ISS15tzVuSyLZVzFLexsber
         PTxe/D7DN/AFX9JYEBisHhtlBriUSIZuluLk2DWot1+vXvb6yB/2/At1UPMkYKaOwcLm
         PJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=gfO26u2xpyVmEWxjONFXEHf40ylM6r3kRxMGtINMS28=;
        b=rsbrXMRyv+3XHimQxr8lVsKB7iMOtZ4jcSmk2cfPoIlkz3U9RaN+j4DZCFv2ZalpLs
         9jkAR5ZACTZFCxZm3j/Sm6ZIIHGdP0lqFzHlXY/WPcNb9f8CdRkyxsZL69hEnfpIARak
         xvepQcFNWoB+PlbrKCWSL1z4aZAeI7k1g0sSMV8hrCt8Ao5nz73YHVrR6jCkiWKtksXs
         7BsFxW6lg+8HAdng7fiqx0Q3NQ+dv9cM/R8fUce1H+wmRxTSY6uFhJu9RQjXjKo1B3v8
         TcWLwQHqqOLmW03QJCkUZlTAjaH4FUua2kAAE+b5LX/QEC9OR6yq9R0ke3tewy6nGnm4
         9XEA==
X-Gm-Message-State: ACgBeo3+5auZg/vkoVjZDVS6zHVNcdxoHWG5o/UqIPetTKUih+QHRaJG
        NAC95y+23ZgTBU8QTBDnVh0=
X-Google-Smtp-Source: AA6agR65b9BvIPJJ2aIA34xLNFyBah7YuqJvpKELG7QwV25Vml1sxFR036NxwJ4Xi5LcGcZNJFfljw==
X-Received: by 2002:a17:90a:17e1:b0:1f2:2ff2:6cae with SMTP id q88-20020a17090a17e100b001f22ff26caemr1175172pja.196.1659041134124;
        Thu, 28 Jul 2022 13:45:34 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([114.254.3.190])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c40f8cb58sm1787304pli.81.2022.07.28.13.45.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 13:45:33 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 7/7] x86_64/tlb, mm: enable cpumask optimzation for RSS cache
Date:   Fri, 29 Jul 2022 04:45:11 +0800
Message-Id: <20220728204511.56348-8-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220728204511.56348-1-ryncsn@gmail.com>
References: <20220728204511.56348-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

Enable CONFIG_ARCH_PCP_RSS_USE_CPUMASK for x86_64, we do a
RSS cache switch in switch_mm_irqs_off. On x86_64 this is the unified
routine for switching a mm, so hook into this can make sure any dead mm
will have their cache invalidated in time, and cpumask is synced with
cache state.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 arch/x86/Kconfig  | 1 +
 arch/x86/mm/tlb.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52a7f91527fe..15e2b29ba972 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -125,6 +125,7 @@ config X86
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
+	select ARCH_PCP_RSS_USE_CPUMASK		if X86_64
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
 	select CLOCKSOURCE_VALIDATE_LAST_CYCLE
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d400b6d9d246..614865f94d85 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -597,6 +597,11 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 */
 		cond_mitigation(tsk);
 
+		/*
+		 * Flush RSS cache before clear up the bitmask
+		 */
+		switch_pcp_rss_cache_no_irq(next);
+
 		/*
 		 * Stop remote flushes for the previous mm.
 		 * Skip kernel threads; we never send init_mm TLB flushing IPIs,
-- 
2.35.2

