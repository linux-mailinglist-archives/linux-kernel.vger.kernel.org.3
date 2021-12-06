Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3FE469997
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344755AbhLFO7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343709AbhLFO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:59:21 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B72C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 06:55:52 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id n8so7225333plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 06:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=emz0kTddmhcEiWiR/ZQaPHErMqrIjWnJCX7XLC9vu60=;
        b=Iks6yavBR1J/nZdiCyht+KoWmGtn4HqcF6QXBsSBWdlkjDeMuMNzd3wle93jiVcD4p
         ltPqH9H4JneRJJPl6bcDyqWf/cDdCCc5XTRXFr9yLp4xW3h/yVtvByb3B97ylWT/nXai
         yhR1Sp3qpMW/Kq9knOL28ZsJSO4eKanKkkA6tpyGVn1/4Mic9CpiIUZZQxofGlOFXbRi
         oZuhGJYhxGu8Vd1J1Ch6uk1z18Z/ldKo4uonUhhWHiq+XVizvsK80+vbtCDRWFUjWpKX
         wElP31fU/kNmwi6S4Gar0/w2dtjKIOeUnQGAgWAZn8wWwVZTNsk/ICROjxzfS+KK5Zi/
         jqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=emz0kTddmhcEiWiR/ZQaPHErMqrIjWnJCX7XLC9vu60=;
        b=PX5OoAxTRGG+D5oLsclXBBwXtgfUhYplkASOuXTPOJGsjL+LrvKeBTDdaopIkE/TX9
         aenmSeLOkpIpj0OEi/It+iwe8YR4jp8kmJB9Z5FU8c6iFo2gpIs9K4vUpPmloL4XGn93
         aSWDRay+HGfAWNfvFjFzy3Iil1GkD2bB5Vg4wx+kX8QI9aPNnBq4GaTI0ZqVKUCF7CES
         9o3k6wFNhZwiPWI2KxDC9vRCz6HOCc3WmG7AIzwsExOZWgxCLS2tBR7HBG1AmDDDMlEB
         c3mvR4+dyy2r0utuF42uUmaaOifAhI+oZ5AKVgNLWsIvwBY6X7VJYzRUE699LKFi/I69
         5J+w==
X-Gm-Message-State: AOAM532BUV4OTLjV/DOYyXz97qW0wNg+7b/e2EnmsmN8A4kP6u9jYX5N
        bGbEuoDaeqFuBUmuML/jZMw2E4cY3pz9Ng==
X-Google-Smtp-Source: ABdhPJy2HihX0YNanUIWglIygyZmlEz2hYa1AZTDv7nX6NQ0hUEFyF9dhr6UuR4Ik6TKPn/M06x96A==
X-Received: by 2002:a17:90b:4d0a:: with SMTP id mw10mr38021099pjb.89.1638802552019;
        Mon, 06 Dec 2021 06:55:52 -0800 (PST)
Received: from monster.mioffice.cn ([2408:8607:1b00:7:82e8:2cff:fed2:80d9])
        by smtp.gmail.com with ESMTPSA id 130sm12395839pfu.13.2021.12.06.06.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 06:55:51 -0800 (PST)
From:   xf2017140389@gmail.com
X-Google-Original-From: xiaofeng5@xiaomi.com
To:     akpm@linux-foundation.org, christian@brauner.io
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhangcang@xiaomi.com, wangju@xiaomi.com, fangzhirong@xiaomi.com,
        xiaofeng <xiaofeng5@xiaomi.com>
Subject: [PATCH] mm/madvise: break reclaim when lock race
Date:   Mon,  6 Dec 2021 22:55:16 +0800
Message-Id: <20211206145516.23760-1-xiaofeng5@xiaomi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiaofeng <xiaofeng5@xiaomi.com>

In Android phones, the recycling thread is likely to hold the mmap_lock to reclaim the memory of the application When the top-App is switched to the background. Once the user switches the application to the top during the recycling process, there is a high possibility that the memory will be allocated due to the inability to obtain the lock, which may cause lag or other problem.

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

