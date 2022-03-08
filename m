Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA8D4D1FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349378AbiCHSI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbiCHSIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:08:25 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C632B4C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:07:26 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cx5so75059pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pZliwmLm6S8tya/djJ5W/U/prHZbfOKsGwUj10OUIn0=;
        b=qpLtvuz0mEEMCmqJCiWKhn+xCPGesu6Pw3r09ZrgwzSL8mgKdriqPFXA9ih3Is4h9B
         SifskdlThgG6P5akCPbbqD9WE7XCGeo4X4REI2Xq16nnqJdjDh8Yg44L1Hb1N4TfG6tu
         n8UWwRuJGdgXt61SgxTM6sWov7sUP9PoJ1F6PcjaHjk4UA0ohjNiNuIFjIo8aiJ89BkM
         q1SFa5D5qa67somAsAgHXMVzggWN2AB2F3C/pooif71T2zLOfB4AZ8cqgO3NM+UdycIN
         16Jx9ckYs0lUPqmnO2OwYbtPAh5PCfrByZLDoRJaA15JjjaLtO055sKJPEXWxnVf+m35
         QGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=pZliwmLm6S8tya/djJ5W/U/prHZbfOKsGwUj10OUIn0=;
        b=S/eCHvnY7+K2/dzecnVuBVFhje3xZ7SFmwxV9GolhObQpfB1vDmncsACPeGM65FWy5
         lHCuuE1JxDZ9Qcvjmkd/N3yjPBjdMqtTXrFcGapSzHyGszKJjACHhHVTsBFT5rLQ+S6E
         hZSndtcP5L6HZcqyVIYInvmPt7j5zGOjSOy4DH6HWKQoZAAlnTXhNdwRWr8ZO+UekYGX
         Kj6hFFJicN30tOHLm5jyPkkM5BB/6zLvbhkFcjq1oFcYqFaBYTVIlYgBhPkpI4TrvpZa
         xxh8kUR8oCZbvWo+3ow0IkessBtZ6JR4N/i63m9Dyha/HA2yflRdBhTGZs4RBQbzG3fn
         ZKdA==
X-Gm-Message-State: AOAM53132LVStY8VuRf9Wu0na2eJWMSlyh2OvIVTZ4BL5a61cUO/SdO3
        zNb2Fql8Wlt2TTCXKyOIVJs=
X-Google-Smtp-Source: ABdhPJylFJEOWSaFFgHfIMPZ6Bg5gHKwdPIYqmxkknGO1e/TOEnJ+yqMzsCzV6dq5xLXIanBNwhu/g==
X-Received: by 2002:a17:902:758f:b0:14f:b5ee:cc5a with SMTP id j15-20020a170902758f00b0014fb5eecc5amr18930620pll.43.1646762846012;
        Tue, 08 Mar 2022 10:07:26 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:ec3e:a6ab:7b5b:ed81])
        by smtp.gmail.com with ESMTPSA id x23-20020a63fe57000000b0036490068f12sm15462368pgj.90.2022.03.08.10.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 10:07:12 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        John Dias <joaodias@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: fs: fix lru_cache_disabled race in bh_lru
Date:   Tue,  8 Mar 2022 10:07:09 -0800
Message-Id: <20220308180709.2017638-1-minchan@kernel.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check lru_cache_disabled under bh_lru_lock. Otherwise, it could
introduce race below and it fails to migrate pages containing
buffer_head.

   CPU 0					CPU 1

bh_lru_install
                                       lru_cache_disable
  lru_cache_disabled = false
                                       atomic_inc(&lru_disable_count);
				       invalidate_bh_lrus_cpu of CPU 0
				       bh_lru_lock
				       __invalidate_bh_lrus
				       bh_lru_unlock
  bh_lru_lock
  install the bh
  bh_lru_unlock

Fixes: 8cc621d2f45d (mm: fs: invalidate BH LRU during page migration)
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 fs/buffer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 8e112b6bd371..c76a8ef60a75 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1235,16 +1235,18 @@ static void bh_lru_install(struct buffer_head *bh)
 	int i;
 
 	check_irqs_on();
+	bh_lru_lock();
+
 	/*
 	 * the refcount of buffer_head in bh_lru prevents dropping the
 	 * attached page(i.e., try_to_free_buffers) so it could cause
 	 * failing page migration.
 	 * Skip putting upcoming bh into bh_lru until migration is done.
 	 */
-	if (lru_cache_disabled())
+	if (lru_cache_disabled()) {
+		bh_lru_unlock();
 		return;
-
-	bh_lru_lock();
+	}
 
 	b = this_cpu_ptr(&bh_lrus);
 	for (i = 0; i < BH_LRU_SIZE; i++) {
-- 
2.35.1.616.g0bdcbb4464-goog

