Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D909C4839B3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 02:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiADBSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 20:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiADBSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 20:18:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE86C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 17:18:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id bm14so142139642edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 17:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=vPYPylu/98Q2wZZM/w4rmZqUVAQ2nljv0sqImxSuceg=;
        b=d92KZIw6WlZk4JdgfgUo2VTokdvlLPXVuRKZqp2CNyeBkNtu2iPfRHxRD2kgEiNE6x
         p0jgYEoOrFFkO90g9hkFyJimYi3F6QfmKVZtwg5uDeSqr8hpAdQPjpEDmSPVwCRsZIdc
         kxdrf/fOwCzELLFTc2IY2760Wy4cR2oi64cOb9J5b+6+g5nzmI0ZKyGRzIqC+6YI6ZtW
         onsAtoi2P80xS8UT7VGih1vj+CoMnsr1Pg/B7zmubnPTmTKhjVok7KARwi/YJiUsd5Lg
         fTRKDB8Akaom2VDNq4FCons65TEJJa0T15AMlZAIrU0sdQ6EW9pWglphIZ207xwJeOmb
         x3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vPYPylu/98Q2wZZM/w4rmZqUVAQ2nljv0sqImxSuceg=;
        b=u9DXvNmI0BG1PjcZWWWbNyTGjm1Rdot1eKCOJa5q+DBq21PTkeo5MEwsjjk5s1uwSW
         LGvDRzoltxDDj7T9oht2iK6aZ+VQhS7LniONtb9UzYb/tWmHKbzDaHMKhnaJAQbQbIWz
         c5MQHSwBY8TTqgTDiOz2JAWiEHegTYC8PxKMVGptJSyads8Jp8LZKWP/hJadPD+4ETud
         erTmvRdNB/byeuhbt27wsHj3r1EC32V25Vu+DU43pLu/sV/OOnCKdPB2e6ptfTLbFdnb
         3emanGCbdUb1O4+7OHX6OvXMLuqBaRQs0AdtSGKe3oBMqbGn1uF2f1gURkcXwTQ7mb7n
         3q6A==
X-Gm-Message-State: AOAM530V0T9oSKTrfYvP3eD8wuAD4kvfS8Qda8I6HJMHPKH4GfRpuh7P
        vS9zERsPGxRWtcmRiKbtKsI=
X-Google-Smtp-Source: ABdhPJwgt+MODMBZgINs9djin/8PBnZ4GXCekRJyf4Pg81ul64tILeYeSSJ3WzTZH1OEnX7nTRJ4rg==
X-Received: by 2002:a17:906:6d0e:: with SMTP id m14mr2922762ejr.37.1641259123911;
        Mon, 03 Jan 2022 17:18:43 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id he13sm11007383ejc.221.2022.01.03.17.18.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jan 2022 17:18:43 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     peterz@infradead.org, willy@infradead.org, vbabka@suse.cz,
        akpm@linux-foundation.org, dhowells@redhat.com, will@kernel.org,
        linyunsheng@huawei.com, feng.tang@intel.com, ebiederm@xmission.com,
        aarcange@redhat.com
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] mm: page->mapping folio->mapping should have the same offset
Date:   Tue,  4 Jan 2022 01:17:34 +0000
Message-Id: <20220104011734.21714-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 7b230db3b8d3 ("mm: Introduce struct folio"), folio is
introduced. This is a folio of page, so we need to make sure those
members of folio should be at the same offset in page.

The offset of mapping is not checked. This patch just add it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
BYW, I am not sure why we compare ->compound_head and ->lru?
---
 include/linux/mm_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c3a6e6209600..0a2de709fe40 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -288,6 +288,7 @@ static_assert(sizeof(struct page) == sizeof(struct folio));
 	static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
 FOLIO_MATCH(flags, flags);
 FOLIO_MATCH(lru, lru);
+FOLIO_MATCH(mapping, mapping);
 FOLIO_MATCH(compound_head, lru);
 FOLIO_MATCH(index, index);
 FOLIO_MATCH(private, private);
-- 
2.33.1

