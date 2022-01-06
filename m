Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4C486E13
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiAFXxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245661AbiAFXxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:53:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D48C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 15:53:22 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m21so15798832edc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=rM0V1t6rz7Wn3aVnr1iKuSTWQEuTbhBaKLndJKmrd4w=;
        b=Bp9y/kjxZY09njGXz0TEkwYO+BY+WHdctFdpJOhuitcZQEte49WDbCh1S8558si+x7
         m7ZFnJEGt91tLypw7LhGzax+vkz0DwhKKCbq2TYAMslMQ4rnioNMUa1xoBSbXQzc4/T8
         M+ZEy/tBQxiV279+pymaPkKSzNPB/6h/CWaewQuSMcy6FGrie8UQXOnfedasdMY+dHnj
         FRHYj1X7HhW4a93FIt4PhOHc0ry1Z+zLSsGwfno6COxyr1ocGsBqaYbqqaI7loOvlIx8
         ncep7janW/KYkuW1Ae7st80VzLhV9wxmoAnZpog1TjU1+pD0+w6TO6kVYnanE/kVknTz
         k2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rM0V1t6rz7Wn3aVnr1iKuSTWQEuTbhBaKLndJKmrd4w=;
        b=iZTTMz8QLw26WytZqQmfSP2TWxDKUKKTdkzV6xPPQuUFOaFass+Yl7Bostl1KUqM+d
         D4s5mbMR+CMmsCrnOuonbeVzN0yXaa6W3x72WhiCckRJj2xo5H8Qq5sEGCJEBk63jMFM
         fWe0fuUs8fQ5HzYq9ek2kypO9j4yxrmVBSwXEVdAwctBAdO36HD2DeVGOwN0liBjUO3y
         MGPO100bb173RLqtp0eTBr1lUK0kmGk8SbU/CxmAD2QG2otn0lveWVU0wYNO/TjlGyuk
         KiASgDdtKgQv7PU7GBHzrzek+GrMrJk3HZh1bzBt3CCaFQjWN5hfUnTm3YUoqS5HgdN/
         9yjw==
X-Gm-Message-State: AOAM530799VIaIGXfKzt01W6GTzX/6o8q8Jc/Tjgy4wR8oiqs3ATvOHK
        He1TRAjtmiAhE6q04zBgns8=
X-Google-Smtp-Source: ABdhPJwn7vOhfQnMXUaWykjHmlcBqa/7J6Cz04OfxhkAYTInn1U65teaR1f09pm0CtdMctxB3HYMzg==
X-Received: by 2002:a17:907:2d0c:: with SMTP id gs12mr48055621ejc.100.1641513201560;
        Thu, 06 Jan 2022 15:53:21 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id nd36sm880354ejc.196.2022.01.06.15.53.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jan 2022 15:53:21 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     peterz@infradead.org, akpm@linux-foundation.org, vbabka@suse.cz,
        willy@infradead.org, will@kernel.org, linyunsheng@huawei.com,
        richard.weiyang@gmail.com, aarcange@redhat.com,
        feng.tang@intel.com, ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm: remove offset check on page->compound_head and folio->lru
Date:   Thu,  6 Jan 2022 23:52:54 +0000
Message-Id: <20220106235254.19190-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FOLIO_MATCH() is used to make sure struct page and folio has identical
layout for the first several words.

The comparison of offset between page->compound_head and folio->lru is
more like an internal check in struct page.

This patch just removes it.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 include/linux/mm_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0a2de709fe40..087d6768bc78 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -289,7 +289,6 @@ static_assert(sizeof(struct page) == sizeof(struct folio));
 FOLIO_MATCH(flags, flags);
 FOLIO_MATCH(lru, lru);
 FOLIO_MATCH(mapping, mapping);
-FOLIO_MATCH(compound_head, lru);
 FOLIO_MATCH(index, index);
 FOLIO_MATCH(private, private);
 FOLIO_MATCH(_mapcount, _mapcount);
-- 
2.33.1

