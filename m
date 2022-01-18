Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B698149312B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350190AbiARXFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346425AbiARXFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:05:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16610C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:05:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a62-20020a25ca41000000b00612ba8ecfcdso1087619ybg.17
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=l6hbRAzMlKkhDXyQqtvv9DAL8rlD+/FgUl4MA5CnPm8=;
        b=nKkhAP96OCYA4M4x80g28cPG8G8ErsxJaS13Ynx/835zUQOktZxpfEllu14SNaW6ZN
         qXjKLzaRdYhy9PJXVwbP+2Jf1b9hP+lSMPoBwidlUYmXQWDyTWVpJInj3fq7WDafuxTa
         iIoMeNcwjnN6Ys6MwD+AtzizkCx/n3FuS7igc6T6IDDeJFG6FQ777u1Qd2e2Lzw62juQ
         5JRnEs8RrSNVwLs7Y+HjIBoRj9LPNtc4cLGAxoZ+I0F6hnJ9Xco3AK9rmu4dY5TIwj4G
         GtXcDJ7/CuGC+07RaUPJ0D9cxTZnpUu/BKnZULfy5igYqfOQlEk7iMU8tfsSEEyXIhRU
         O4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=l6hbRAzMlKkhDXyQqtvv9DAL8rlD+/FgUl4MA5CnPm8=;
        b=3KkX9CqdaCQMRVMCo7+xaYDIScf9aCGsZXlbmTcNwht9nFFGAPKpJgnJ+sNAh76N2u
         ufq33/e5B3RXf/Di35WqzsQUMWWllTimaLWeQEi+GZrlGF1fxOzPlXU7zbaZNyP6mrkd
         gz37mmfqguw72kK7sCuS3X3769RyiOdoiMnQpe2mq1OuEfan+nz84dT8xeUK/2ucgSz5
         Cc2J+Yk4jPwJvs7gwmCs9KkqRCnTqK2CzlhySe0KaPZfGm/aG7bS7SCui5DheQSfwUaJ
         nirztvQyzzC93ya3CZFa0jR1etJ14B9P7g0jGr/hLAS/P+1mOSeAK+HDO4JEvY1BhqRe
         zpcA==
X-Gm-Message-State: AOAM5327W39C7Vw4iTVWzHxICUQAA8Wxnl49TOI62u6IwRZ+JkStBmTG
        nKXqIC90fKXX+ECj7XARMnD2fEU=
X-Google-Smtp-Source: ABdhPJyPdrj4Y716RGRIKh5U4LkCBP0FlJ7hNEnEfsKuQQvudDZBs5KtsbgYz/GzyiJmv9fnRvg5DBM=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:1443:965d:6393:cd60])
 (user=pcc job=sendgmr) by 2002:a25:a047:: with SMTP id x65mr37555287ybh.370.1642547151356;
 Tue, 18 Jan 2022 15:05:51 -0800 (PST)
Date:   Tue, 18 Jan 2022 15:05:39 -0800
Message-Id: <20220118230539.323058-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] mm/mmzone.c: fix page_cpupid_xchg_last() to READ_ONCE() the
 page flags
From:   Peter Collingbourne <pcc@google.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After submitting a patch with a compare-exchange loop similar to this
one to set the KASAN tag in the page flags, Andrey Konovalov pointed
out that we should be using READ_ONCE() to read the page flags. Fix
it here.

Fixes: 75980e97dacc ("mm: fold page->_last_nid into page->flags where possible")
Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I2e1f5b5b080ac9c4e0eb7f98768dba6fd7821693
Cc: stable@vger.kernel.org
---
 mm/mmzone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index eb89d6e018e2..f84b84b0d3fc 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -90,7 +90,7 @@ int page_cpupid_xchg_last(struct page *page, int cpupid)
 	int last_cpupid;
 
 	do {
-		old_flags = flags = page->flags;
+		old_flags = flags = READ_ONCE(page->flags);
 		last_cpupid = page_cpupid_last(page);
 
 		flags &= ~(LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT);
-- 
2.34.1.703.g22d0c6ccf7-goog

