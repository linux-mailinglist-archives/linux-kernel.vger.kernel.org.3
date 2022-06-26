Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C129255B308
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiFZREY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZREW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:04:22 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8B365B0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 10:04:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id jb13so6219454plb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFSj1F+cvrzuMgRbVJtsNeMg49O8qOKUhwSEI2b4t3A=;
        b=AAAVJXiWm0mI22Obyyka3npjSQpUd0V4kOn5WabIA9uexHD2iTu3QRHzp4QbMeRPrY
         X1lHSwmTz4tXsZL218ctZS6l08r5yvdfO79xjCzGMZKi/EbMWxOTF471l7B6s5VAv6xb
         m0h2G4w8s88tfp3W4cIJdui34XiqWjNlGz+DdRMw+WyYQjmadhkfI+kszeXaYXwr4Xeh
         kOrKCGuSaCwLCqE+1uHDi1xpcO3xOIgmMZf4ULVqH6D2tjTHLDO/dD7uFPbwPfhqw+dJ
         ptuuH7q6STg3Yc5UP966PHv2uy2qmMM4VrabzcQE/rH6dk0i66AcW6hTFT4ZwzgJrSlM
         ugNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oFSj1F+cvrzuMgRbVJtsNeMg49O8qOKUhwSEI2b4t3A=;
        b=TtUq2N2T/4HPwsh0c+OOcFCz2bePGUP6UZ7mRqQmyOcMzUX9zPsJbpEgFYuSA4e2OY
         5vSfHlOnmlG15WQ4HdfqhYutbLsI8d2QSg/uvczzmu3HrBfKnls85LWONgJQ6iMaHpZy
         klJc3TlelqL5DA8B+XUWrwkNA+2iglJdDo9tnbdLZQNhUWeZVZyV9BbKgrhBk8ysFv9I
         9I/SmNbPEz+Nsv7yo8KnjnhPXTwAWzDyo31RZY+hOPcbQObbdPDVPRJny0EnVVeqwj5R
         bRDnrErEdqlgSMwHrE/lNQL4wI7YWQ8PWO1TGz7mQPGua7vbENRrqH7L7qe8mqDcMx/k
         HRyg==
X-Gm-Message-State: AJIora8Et4gskF/TWxb3KUFHTf+u9V+jGcs7UtRkJOXrP/mDmNWyTO6T
        9jo0jBMgUEM4uyxAb9GhHag=
X-Google-Smtp-Source: AGRyM1tKL2KuV8DoR1i9GFOsuCXwvQGfLQ8tkqPLgkBnj6SuZzWxtHs6KKsGDaOdbLnlj+dlimVHKQ==
X-Received: by 2002:a17:90a:5b0d:b0:1ea:d1ed:186e with SMTP id o13-20020a17090a5b0d00b001ead1ed186emr10676962pji.240.1656263059833;
        Sun, 26 Jun 2022 10:04:19 -0700 (PDT)
Received: from fedora.. ([103.230.148.188])
        by smtp.gmail.com with ESMTPSA id ms3-20020a17090b234300b001ead46e77e2sm5450642pjb.13.2022.06.26.10.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 10:04:18 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: [PATCH] mm/kasan: Fix null pointer dereference warning in qlink_to_cache()
Date:   Sun, 26 Jun 2022 22:33:55 +0530
Message-Id: <20220626170355.198913-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function virt_to_slab() declared in slab.h can return NULL if the
address does not belong to a slab. This case is not handled in the
function qlink_to_cache() in the file quarantine.c, which can cause a
NULL pointer dereference in "virt_to_slab(qlink)->slab_cache". 
This issue was discovered by fanalyzer (my gcc version: 12.1.1 20220507)

Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 mm/kasan/quarantine.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 75585077eb6d..c7554f5b9fb6 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -128,7 +128,13 @@ static unsigned long quarantine_batch_size;
 
 static struct kmem_cache *qlink_to_cache(struct qlist_node *qlink)
 {
-	return virt_to_slab(qlink)->slab_cache;
+	struct slab *folio_slab = virt_to_slab(qlink);
+
+	if (!folio_slab) {
+		pr_warn("The address %p does not belong to a slab", qlink);
+		return NULL;
+	}
+	return folio_slab->slab_cache;
 }
 
 static void *qlink_to_object(struct qlist_node *qlink, struct kmem_cache *cache)
-- 
2.36.1

