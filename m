Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE6F53DC63
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348476AbiFEO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245476AbiFEO6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:58:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1182A1AF;
        Sun,  5 Jun 2022 07:58:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e24so10970399pjt.0;
        Sun, 05 Jun 2022 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lMEEVMlhwqTlA7tCinHR3Gvr2O+regL9vfqAnwRJIa0=;
        b=poko1HFW6rmaAXfQD645qOGZYFwI5bum7h+1v1sVPUUIiARKXRxZ03Lvtmv0QbiNhs
         EYyUYquwzyVEXlnrlD+VCAlkqClWH20PH1H6aLCl96Qp2xBDmcqq/OqMFqrZxKCHM9mf
         Ui1B4SI+ryxLgKD8UBY/PSr1PDD4+14Jyaq5Lk393LXH9j9rTV3Htoo4E++Hcz+zTbXt
         +8ZU/MslQtIsM6kxVni7roz+ulUF6sz3e4zNRmGikOTmr3Iy9nWFfDr5UAeKSAbjiy/t
         wJ9bfFP5lrHT9lIyPoTF6XnXccmLPWHXBQsiorHjFrF4TL6aPVAw7JVKk+z2NljiJD/i
         Hwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lMEEVMlhwqTlA7tCinHR3Gvr2O+regL9vfqAnwRJIa0=;
        b=oNyf1EaTqLz/oAqwBNf1oNtqqyaxbZzy8D0AEMDDYIUapE28cRbBMiZrRdCaMl90sF
         Xc2aAvGAIjLGmEKSNhD7ZDSm+G6ffBol82jU3W620C6JX4O/rAPzzx6a05VfTjJTo40W
         T5tEUdQQxIq02U9zTzneL0jhcUy4Kax0RqkQ7dL3pO4AVvvFUKevHzhB1g0pniw2eQk3
         sKOIhIl16Z9CKN4CtvE28si1G/AFTBds5hlspKrByrWOy63FEcHUDXqLW3CIHpj4m5NX
         nEE5XfOZjEgO9yC0pqctu3BK6V5BwtXyn2stzR+Nw5ZRMsBOfr7j0AyX2Cxpy6cNrMYR
         BtiA==
X-Gm-Message-State: AOAM531Hg2Q/w71mLxXFHlP2yn4HV177VJWzCQwvGiuJMJCDpFwyDz0Q
        P9CHHLmvRssIFT2Yq9Ieu5w=
X-Google-Smtp-Source: ABdhPJxTe6EGKnPxoZKD1wkZXV94nm3ICaocamehZO3A5gAjNloZyQ6RwQfxd4ZP89go1D9Uh7xwuw==
X-Received: by 2002:a17:902:d490:b0:167:49df:6e37 with SMTP id c16-20020a170902d49000b0016749df6e37mr13066881plg.50.1654441121406;
        Sun, 05 Jun 2022 07:58:41 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902e2d100b0015e9f45c1f4sm8746521plc.186.2022.06.05.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:58:41 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     axboe@kernel.dk, mwilck@suse.com, andriy.shevchenko@linux.intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch()
Date:   Sun,  5 Jun 2022 22:58:35 +0800
Message-Id: <20220605145835.26916-1-wuchi.zero@gmail.com>
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

1. Getting next index before continue branch.
2. Checking free bits when setting the target bits. Otherwise,
it may reuse the busying bits.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 lib/sbitmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index ae4fd4de9ebe..29eb0484215a 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -528,7 +528,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 
 		sbitmap_deferred_clear(map);
 		if (map->word == (1UL << (map_depth - 1)) - 1)
-			continue;
+			goto next;
 
 		nr = find_first_zero_bit(&map->word, map_depth);
 		if (nr + nr_tags <= map_depth) {
@@ -539,6 +539,8 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 			get_mask = ((1UL << map_tags) - 1) << nr;
 			do {
 				val = READ_ONCE(map->word);
+				if ((val & ~get_mask) != val)
+					goto next;
 				ret = atomic_long_cmpxchg(ptr, val, get_mask | val);
 			} while (ret != val);
 			get_mask = (get_mask & ~ret) >> nr;
@@ -549,6 +551,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
 				return get_mask;
 			}
 		}
+next:
 		/* Jump to next index. */
 		if (++index >= sb->map_nr)
 			index = 0;
-- 
2.20.1

