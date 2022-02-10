Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11BA4B1A7A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbiBKAde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:33:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242517AbiBKAdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:33:31 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0AC5F66
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:33:31 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y84so9661062iof.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r/11QztAgc7p887H2JROAx8muQu/2OLTeRvuBg6maFg=;
        b=ok4tnMvC7LNlEY46BePrt8wMU+Xygc1lZ1J4h61Xtojbzh341QW8CBnitkhh5WqB3/
         XQn5p4hMW9VVGbkJ9OqMDwRUWIdHv5YGA1+MudlaHItROlN0ZWP+huOqrDwFHv9Z8QR6
         kAQBAsudTSUpOAzB8WSpovQie3Y9Oejz4Ny6jolkns7yygmDKtkLzivE4oMh3a2eFa0Q
         blKT0mttPX3VUmJXZcZg9AeE3k4/82VYbeWrmKV+2djpYxOF+Z8FLRVT7aZJzk3HNEyf
         zId6ynUThngQhyEuB4bOApoKZZXjGDOOJNdj8JSWbzBBA7Maj1PC2m2E0xgnM+DZdPL7
         xKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/11QztAgc7p887H2JROAx8muQu/2OLTeRvuBg6maFg=;
        b=b1M2xL5LsNNBu0N7g2/nGI0bQDHXua6lhm19sRHWftvLYWxFpRQQRHs2ySDHkLdUxr
         zOtnEfFxwEmUWv3I55v3YHQ4kcgQSdMABIbU95lmIdwOHPoLOI9jN0bt4PL5pgibAzS4
         2PBWVQZl8nX9jl5F8neQ6iCAtzrdAbSseB4JXYMmaoUw9rDj4zlrIaOApd5W/yiPVc4o
         lYdEnkwsOFlwM8wu5Wo4ItYq8MpkNJZRw4uF24Ua9t6Q4jC7o7iqGJguTX3vL5ApqpmX
         ayfIKgsK8wKdTq3S8Gt9bf1rHgl7hFkcx18htmZ1MaLEdUA2S//54ox/5+a/WryzrAok
         5vUQ==
X-Gm-Message-State: AOAM530Ep/13JvtDF+TJWG2/vfZeGROSEXqMdQ/HoAMTb4yS4bABDqQg
        V7dCvwWG/nSi9Rj4h3XnWBo=
X-Google-Smtp-Source: ABdhPJyzos5XlKp1kunYx0r5VshfNF8Q0FlI8L2FzcjJPMYDnSfr0hH9Cw5PSnXX0u86MmWYjJr03Q==
X-Received: by 2002:a02:3f2f:: with SMTP id d47mr5568535jaa.228.1644539611330;
        Thu, 10 Feb 2022 16:33:31 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id 193sm3856876iob.17.2022.02.10.16.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:33:31 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 46/49] mm/mempolicy: replace nodes_weight with nodes_weight_eq
Date:   Thu, 10 Feb 2022 14:49:30 -0800
Message-Id: <20220210224933.379149-47-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
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

do_migrate_pages() calls nodes_weight() to compare the weight
of nodemask with a given number. We can do it more efficiently with
nodes_weight_eq() because conditional nodes_weight() may stop
traversing the nodemask earlier, as soon as condition is (or is not)
met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 7c852793d9e8..56efd00b1b6e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1154,7 +1154,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 			 *          [0-7] - > [3,4,5] moves only 0,1,2,6,7.
 			 */
 
-			if ((nodes_weight(*from) != nodes_weight(*to)) &&
+			if (!nodes_weight_eq(*from, nodes_weight(*to)) &&
 						(node_isset(s, *to)))
 				continue;
 
-- 
2.32.0

