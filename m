Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF9346DD31
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbhLHUjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbhLHUjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:39:35 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458AFC061D5F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:36:03 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id u16so3312597qvk.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TNgBFR2jfrvrXs2YyapfvQCLu5M2/StKJMmjuovUQTs=;
        b=omntkBN3Tfs3I1WBLg5+7c4phKsJBox+G8HICkXoS3kH+6yRdLxFcodJ9xKyl9IoiV
         tcjkm/7dOMBC+J7Y65mfQWP/VXOIqkIe1BYuVg0/UeqqgV14DIoWmhYOgqkvJ0dksWJM
         yhe24oVkmqp9IYnbA+WSyLvwzs/2ZXXEVDI9dgOsKtpHW9333ry5Y/tBjS02b3z53wAU
         hEg3UZCM2U/tNpwKAhlJ/g9l8ZB1Y1S4iGXr3Zb0/Dfe4/C4+U3+MqtYa+eWJW7GMml1
         4TFuNEidQCzNw1ubewJk7/mM2ZuFcSrJ7+DY7PfV/zzmlIOlmnjljJ5d7q05ATvysKul
         sd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNgBFR2jfrvrXs2YyapfvQCLu5M2/StKJMmjuovUQTs=;
        b=qlOEH72bOKz6dj/CwRzlQ64uOCI+l3t0WZMFDOxH9tzlCZN9YEfJfgleiL+W3OY+EW
         FmJnF/k+XVmUncIsFnr9SQ2CMYI0jAvG+vgWMIVYUoQCT/6tC5BoWm7B1jraji+OrvEl
         Gw8Dr89rwG0upT3HQqWch7IpqD06895BgGggK00d2rHqiuJKACt93EBEvhgdQPEzpoNf
         MPLGet3FEVplLck88N4v+63NBO3RxK2elltYbouOgJq1b5kxR2KopjvesB5LXip9N5Tm
         2pzROVS7zvY14CzBAF4gAE0sxoc/LuBQz7C8fLjf1UVOwWn0Qq1CjnjwmCDNNN8as35G
         wqAA==
X-Gm-Message-State: AOAM530e3E6+MddFkSwYGNP27xfdPAMTBr1JicyXr5j5oYTsvrIUqFcH
        /P40QLxBvXcis20/HD5cfQFbcA==
X-Google-Smtp-Source: ABdhPJzMR03yNKnGfrXlWyU1obhS7MOvT1xu4hAl3EjL7RVWQooSmoKydvdAqAFgx2q/dwK3dHYJEQ==
X-Received: by 2002:ad4:4ee4:: with SMTP id dv4mr10231097qvb.59.1638995762436;
        Wed, 08 Dec 2021 12:36:02 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 143sm1898710qkg.87.2021.12.08.12.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:36:01 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        anshuman.khandual@arm.com, willy@infradead.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com
Subject: [PATCH 10/10] mm: use atomic_cmpxchg_acquire in page_ref_freeze().
Date:   Wed,  8 Dec 2021 20:35:44 +0000
Message-Id: <20211208203544.2297121-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_ref_freeze and page_ref_unfreeze are designed to be used as a pair.
They protect critical sections where struct page can be modified.

page_ref_unfreeze() is protected by _release() atomic operation, but
page_ref_freeze() is not as it is assumed that cmpxch provides the full
barrier.

Instead, use the appropriate atomic_cmpxchg_acquire() to ensure that
memory model is excplicitly followed.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/page_ref.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 26676d3bcd58..ecd92d7f3eef 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -308,7 +308,8 @@ static inline bool folio_try_get_rcu(struct folio *folio)
 
 static inline int page_ref_freeze(struct page *page, int count)
 {
-	int ret = likely(atomic_cmpxchg(&page->_refcount, count, 0) == count);
+	int old_val = atomic_cmpxchg_acquire(&page->_refcount, count, 0);
+	int ret = likely(old_val == count);
 
 	if (page_ref_tracepoint_active(page_ref_freeze))
 		__page_ref_freeze(page, count, ret);
-- 
2.34.1.400.ga245620fadb-goog

