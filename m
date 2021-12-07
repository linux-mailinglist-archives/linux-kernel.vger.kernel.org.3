Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359A146B173
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhLGD0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbhLGD0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:26:05 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6E8C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 19:22:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b11so8432227pld.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 19:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=IDve8oEFAh3tm09aSKqqbG9jITENxqwhDiI+qaAmf2g=;
        b=f96WhxszXDg3XCQzRjBKhVEkoLn8amlNkO4xug1L9k/5SbcC2HgTGw7McJwH58DJAg
         jIW5pkNktzgJXHc1lxGyi+U4DA0YU6TbBpt/QZqFf+RysaxUrGxH0AJ3XMzD9qhv5Zqy
         /GpFKmXBUX7kNjzGFCuS12yNF+HalvKvMTKpiRGzSLK5s6zmWiKJtlgMg4XgGB8QaNfB
         Frg/rcHoVswQtgvCdwqz9PXg7Etup0uHLXSeIPMrfbcYOgpj2NhlWI/1/bEVtgBfWnaV
         O5pXmEIXCpXfPSY8C1zYrKh2Z3oPTb9LucFG/PPNWus5oTXaVDk0khCj5EmAAvmRL3Gz
         TWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IDve8oEFAh3tm09aSKqqbG9jITENxqwhDiI+qaAmf2g=;
        b=PVjrqipsN2GKL/dA3KCZvnnOMuYsH02XGII2/6s0Hd2c+t/QEzZFc5cxmajbxcYpCV
         pI7n57rsfGnIIAO9IAr4xk62tZGAHqsyFbjPoBqrVLbYKh/keZuVpe/nXafzb8bo25Qc
         QGaR/mtaFb+TegVivsdeK+NtVYPDkoEct91ICbtjMZYYm6hmqKttI0slFr1/xQmX1yfg
         l1jVGLxGLKb7XkDI1Pc9nSeEHEBXaiZtSVUeT9htTu/y1WDjIccGVJZyYiLRSt3vmU6j
         CkVjCszq1Al6DtxkW6T7yvISQMz55dPcfOUvM4SZTCkoLJESflZ8drOKvpgW/ap1TOaK
         +5Vg==
X-Gm-Message-State: AOAM531wUuk16J9l86OBZKgZLWbmmNigw/oG4JAxqQdrb8X6DArInJc3
        zigEFN1hR3NB9n9RLngelxo=
X-Google-Smtp-Source: ABdhPJxRwjbFyo302IU3D34soi4k1UchQ3L/ZcosJRvIwCAo8xh137yRc6FRdvHhnExWhNSW+SSAvQ==
X-Received: by 2002:a17:90a:17ef:: with SMTP id q102mr3375708pja.116.1638847355529;
        Mon, 06 Dec 2021 19:22:35 -0800 (PST)
Received: from monster.mioffice.cn ([2408:8607:1b00:7:82e8:2cff:fed2:80d9])
        by smtp.gmail.com with ESMTPSA id o124sm13707624pfb.177.2021.12.06.19.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 19:22:34 -0800 (PST)
From:   xf2017140389@gmail.com
X-Google-Original-From: xiaofeng5@xiaomi.com
To:     akpm@linux-foundation.org, christian@brauner.io
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhangcang@xiaomi.com, wangju@xiaomi.com, surenb@google.com,
        fangzhirong@xiaomi.com, xiaofeng <xiaofeng5@xiaomi.com>
Subject: [PATCH] mm/madvise: break reclaim when lock race
Date:   Tue,  7 Dec 2021 11:22:02 +0800
Message-Id: <20211207032202.6022-1-xiaofeng5@xiaomi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiaofeng <xiaofeng5@xiaomi.com>

When the process_madvise() system call is being used, it takes mmap_lock and blocks the application from allocating memory, leading to unreasonable delays. This patchset aims to fix it.

Signed-off-by: xiaofeng <xiaofeng5@xiaomi.com>
---
 mm/madvise.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8c927202bbe6..8f1e325873e0 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -322,6 +322,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
+	if (mmap_lock_is_contended(mm))
+		return -EINTR;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_trans_huge(*pmd)) {
 		pmd_t orig_pmd;
-- 
2.17.1

