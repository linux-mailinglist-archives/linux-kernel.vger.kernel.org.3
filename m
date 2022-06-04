Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0D953D6FB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 15:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348218AbiFDNPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 09:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiFDNPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 09:15:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B7F1AD8C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 06:15:09 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g186so437878pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 06:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x3E9KYBkGOld27+OrZZguQP5b56zIidZNbEieX3S8t0=;
        b=N09CVVeQjw952tka9UQ6obnKsG0XJy1Speri0PzxQXWvhN2p8F6g8e2xBXdmHaWDMp
         iq7Sv4eEyfnOOHUVNq+xG4JMFUScfpBEplif+rJ+ib6YxTIOGr2ZsEYxt2+OdnUkU5ls
         P84+6T9ZfojXHpHX7KbcSfrTNExm2xudZL4VH3VhqQOzrriwGLvhyfImAfM4Gw3SGzyX
         LTlCl9ZUAekA2uVy8F8sgqwor0xByAnDwDomK4mE93nQSSkzRCCwxFgFFxDlFDY3tzJm
         tccNHgjcC5ae4NUlRtUt4d+C9N4slfFPTecVvCeFsgj8kU7IZhcW4/fvGSu67n9qr1lV
         Rtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x3E9KYBkGOld27+OrZZguQP5b56zIidZNbEieX3S8t0=;
        b=GoZr1tOG2ppruCRH25ibqBU2vvjjuPs5lXOM/okMgv9ZqmiZIgfj92cfQ3SJe5W/cT
         1GMtyZLsX1JPru4jcIKegylyk+EcJKGNxLG/Hb8hAHKMuDAABnpw6zMRitlSpFAIVWbq
         t6DuwxfZAPmfXaFKMegBuQE74RHgw7HMLUFy8f53M7LbgJoLJmIZad+6cX8BSg/sK4DI
         lx0yQyTM3n0Q1mKSwwpawAHhx5vv1v6Y504sikxonbiXtJ/2mrQp4UtqTauZRHt33u1t
         km97EpyrcssKHVtOm9q9pjSvxkO5djoxmDmGYUyrxLzDh0NWJFQCM90RN9+doJbtN+IJ
         +fOg==
X-Gm-Message-State: AOAM5302UvOBUmxuEHQ50zzb/qTJZt41owLlZbUl9VN4hL6KBSlcYJCz
        USl6QsIOshFqBAgK0dZmn92WLpGI6/DL/g==
X-Google-Smtp-Source: ABdhPJzBKQTDr/JEJwEv3ecuCk2TMS82TwMeuBgThfaSC6uJBahhPW2fpFKwxtsILPHpX+G6x8dWLg==
X-Received: by 2002:a63:e905:0:b0:3fa:ec8c:9013 with SMTP id i5-20020a63e905000000b003faec8c9013mr12841441pgh.599.1654348508532;
        Sat, 04 Jun 2022 06:15:08 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id f1-20020a635101000000b003fba1a97c49sm7128026pgb.61.2022.06.04.06.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 06:15:07 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     jack@suse.cz, hch@lst.de
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: [PATCH] lib/flex_proportions.c: Remove local_irq_ops in fprop_new_period()
Date:   Sat,  4 Jun 2022 21:15:02 +0800
Message-Id: <20220604131502.5190-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit <e78d4833c03e28> (lib: Fix possible deadlock in flexible
proportion code) adds the local_irq_ops because percpu_counter_{sum
|add} ops'lock can cause deadlock by interrupts. Now percpu_counter
_{sum|add} ops use raw_spin_(un)lock_irq*, so revert the commit and
resolve the conflict.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 lib/flex_proportions.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 53e7eb1dd76c..05cccbcf1661 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -63,18 +63,13 @@ void fprop_global_destroy(struct fprop_global *p)
  */
 bool fprop_new_period(struct fprop_global *p, int periods)
 {
-	s64 events;
-	unsigned long flags;
+	s64 events = percpu_counter_sum(&p->events);
 
-	local_irq_save(flags);
-	events = percpu_counter_sum(&p->events);
 	/*
 	 * Don't do anything if there are no events.
 	 */
-	if (events <= 1) {
-		local_irq_restore(flags);
+	if (events <= 1)
 		return false;
-	}
 	write_seqcount_begin(&p->sequence);
 	if (periods < 64)
 		events -= events >> periods;
@@ -82,7 +77,6 @@ bool fprop_new_period(struct fprop_global *p, int periods)
 	percpu_counter_add(&p->events, -events);
 	p->period += periods;
 	write_seqcount_end(&p->sequence);
-	local_irq_restore(flags);
 
 	return true;
 }
-- 
2.20.1

