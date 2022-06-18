Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0F2550381
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 10:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiFRIZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiFRIZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 04:25:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006BD1A3A6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 01:25:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h1so5645949plf.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 01:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CUqY0KQJSAqLYg1982TnxRNCeqrK/zdBJWWoYUnxhyQ=;
        b=PtyWILc3Wk3qBPynLrNxXpvgXI1HCGX0Z0RIW5qLPSqeTbB3Vi4rCpBwCpKRHCd8mZ
         M3xnFBaNBoYj2KfXoOR/KlU3Jmm0AWhI9dzZSp3WxstyuE47gkcuZyxo3un5omcgLrxR
         kXViI9PWvVjcI80qHsm9oOCcIaHZxoXDp5HSOPD10FWjdSMt4vlSqhC43h2yQT4JwIPJ
         HAzB8vi/t7/Vsd9CJuMKpQKWIOFz7Z17X0K1MILfgbXGLmHDQTzIS72nHoVSSySBYs+a
         wNT2G1KALXWegFVWmfflKbm5wfAOm0kX7Ctg1x774uAgKN6amfC6qeQTzf0sM9MbwEAu
         9KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CUqY0KQJSAqLYg1982TnxRNCeqrK/zdBJWWoYUnxhyQ=;
        b=eAVyF87vKU3+WB65xINNm0oAtnDynFf14cEGIO8gGcD/ozi0lVQwFFmsd3uApOgTgX
         aR3ngWEukHHCAKJdMyGZLdnapPXupCuSGuuzmNpEvuehsHLZAPYfvRMa1rBLeY4QTwsm
         3MSAeod8s93bdTCYMHeHsfsBAUscFMJ4xjPXsYL7VdG/7fpbXjWbeZvVF/ranT0YgK2n
         PUhXsRCmDzYr+unbkwENIRMimsmd3j7OuPgA72IUbgwAtATryufIp4fLoQQjroa1J1R1
         5xpm4wewTpwByIPlJ3Vi3eyVGfireqQPN58zI1rrwJ5dajCYq97KlN15X8gzGrOXrIXt
         RAyw==
X-Gm-Message-State: AJIora/2PkT9+VwJjuz3q3d8BWjE3fjCUaToYnyJ5+Viks9ylxL/Z3rA
        vfMF/KSIjKqTQqrlyCNA6hB+8lSwDSA0IDc2
X-Google-Smtp-Source: AGRyM1tSV4qKvA7HA5K553RN7QOgKX9vpuPJI022UzleZDyOATcziE6kFzEZZOJmM8ktQJw8RIZmXA==
X-Received: by 2002:a17:90b:4b90:b0:1e8:48bd:453 with SMTP id lr16-20020a17090b4b9000b001e848bd0453mr25793990pjb.86.1655540727424;
        Sat, 18 Jun 2022 01:25:27 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id n2-20020a170903110200b001679a4711e5sm1761545plh.108.2022.06.18.01.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 01:25:26 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/lru_cache: Fix error free handing in lc_create.
Date:   Sat, 18 Jun 2022 16:25:21 +0800
Message-Id: <20220618082521.7082-1-wuchi.zero@gmail.com>
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

When kmem_cache_alloc in function lc_create returns null, we will
free the memory already allocated. The loop of kmem_cache_free
is wrong, especially:
  i = 0  ==> do wrong loop
  i > 0  ==> do not free element[0]

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 lib/lru_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index 52313acbfa62..dc35464216d3 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -147,8 +147,8 @@ struct lru_cache *lc_create(const char *name, struct kmem_cache *cache,
 		return lc;
 
 	/* else: could not allocate all elements, give up */
-	for (i--; i; i--) {
-		void *p = element[i];
+	while (i) {
+		void *p = element[--i];
 		kmem_cache_free(cache, p - e_off);
 	}
 	kfree(lc);
-- 
2.20.1

