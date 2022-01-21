Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD323495BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379420AbiAUIO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379400AbiAUIOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:14:25 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA392C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 00:14:24 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 128so8179959pfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 00:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38VL4JgcBpGSLu1kgAnwix0Q4byRwiwO3nHQUNRDRD4=;
        b=TeH+wuy/sIByEsJTcwZrBFYB5QaT0ECx/o59mjNK7uXIQVrp2mmuNPss+jPXLoW7Xk
         8n/yD8ycbHPAk6b6Ch1Uv1iMrCkP7vf6JSBDZJ6ZK/CDp1X+2WFaEma7BFGBTW7eJMw2
         MCjFgSBYMfkdydmiLILChev6ara/m07z6wGgLtTwyJa2JMVwvYAIhBo8OHnBZSeUhO4P
         k0pwQfXVUPGnxKjnZd4EZjJQfWHksweHXG4AZgg1sRffRCvcybAv5DpABW6Ooaw57mzQ
         ztYC2w4W+iHQU9l2cs0FX14aDo3TzA2U/IIihBhiYBTwUfp2+beboggHts3x1khxFXTu
         QdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38VL4JgcBpGSLu1kgAnwix0Q4byRwiwO3nHQUNRDRD4=;
        b=sOXJDB339RQH7tUPQg4dYItpmY6lwyDpPMnbKLo7DDZ4ii1RtDcWCkFt9QDgzPpz2r
         7CixyTRAfPLuKi8eGcYUspq/8YciMiifMWQrx0geA30HAVITDDHJtuXgeauE3LO9DwkO
         lhgRMvot6ZosnxYy6Obb4Nk2Ldns88O/bZ4Cgga7muJr11tqH2LfojbLxwqCq/hcDyPZ
         3w7NkC/5z1NosKPeAk6ZP7tRb2CJy42bX7sToMppg/9aHoO4eJgBg+q7ZJMozpYRs9I5
         +M0IcTxSHidpui0140ZY9WFCETmuAIlxq3yQHUav+RGp2d/hVI0wEJdw1WyRhpej5CTv
         fPWg==
X-Gm-Message-State: AOAM533qVSuf7Ddn/V6e2E/AxShT0pscVr9eQS60t4fSKzatlGHkMx16
        tW0dTlIQpH8yjNStn4UT3gXAOw==
X-Google-Smtp-Source: ABdhPJy3K7BYJwww5r2mm9TNQZ5iQeFX7+vTN2yRiawQCHbeqre5JvBHtpZXCBQ38l+v2inwkVS7fg==
X-Received: by 2002:a63:710f:: with SMTP id m15mr2193712pgc.40.1642752864519;
        Fri, 21 Jan 2022 00:14:24 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id q9sm6191010pfk.137.2022.01.21.00.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 00:14:24 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/2] mm: fix missing cache flush for all tail pages of THP
Date:   Fri, 21 Jan 2022 16:13:45 +0800
Message-Id: <20220121081345.80320-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220121081345.80320-1-songmuchun@bytedance.com>
References: <20220121081345.80320-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The D-cache maintenance inside move_to_new_page() only consider one page,
there is still D-cache maintenance issue for tail pages of THP. Fix this
by using flush_dcache_folio().

Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/migrate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c9296d63878d..daf2b3508670 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -934,8 +934,7 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 			page->mapping = NULL;
 
 		if (likely(!is_zone_device_page(newpage)))
-			flush_dcache_page(newpage);
-
+			flush_dcache_folio(page_folio(newpage));
 	}
 out:
 	return rc;
-- 
2.11.0

