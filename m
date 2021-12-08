Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE446DD29
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbhLHUj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbhLHUjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:39:24 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B03C061A32
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:35:52 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id kl8so3314205qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 12:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=foMj7rdrqKExpuW/5b2/9AtW6rfu8q0fYE86wv94MNg=;
        b=Usqr6WHfajDNAQvGjwiUgRjegcPmoT8iAYMVVkdTi17iBAWK6NqycYpldReeX4Kp/X
         CLophKDJ0Fzd92y2a34OoBrtYFRDQQ+v2E/Y73DMFzLVtH9dZ59Qalshv02NEdQtVF2f
         +unp2bAFPXD4y8jz4D1R08C2Vbp7ZeWRtuxqkn2NJX1QMqw4fOzaRmIGAGXldbZXm2nU
         nkeiZhh/VTopJ2LwKrEb0RyOL933F/SdVt9trRx8fexaJjRvxKvvRPBYCNef9558SVt3
         oYU/C2wyyUTd4VFb7fBh9j68V+Ctwww/JRUiEQXzzjHLK2VKyWGEuUa2l5gxHKOlHYeu
         nqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=foMj7rdrqKExpuW/5b2/9AtW6rfu8q0fYE86wv94MNg=;
        b=vwKEF0EIxAPDJ9VsFfCOtZ8UQ8CXiYJoGb3VOmEk7zJ6nmc58s19x+VB8gCAAgm7dB
         1/DNee4U4O64lBnO1IG/4h7Lvy7Yq1ohN6paK0JFVWHWzRjP8rGqftwAykyHrCbi6Qal
         t4+A14eIsF8PBh0fr5TZDab45xcFbYerM0Zcj7EQaYYLV1eynnIqhtuT2VqeM39OETQX
         fHu7MpHcitmKUBwZ/3arzqx6Dara97DzqQCWa6wZNUwE7RrrDx0TNGoS5ua2FNZgGafu
         K1lFgwI/fuO4CWUSBj05+pcYbbjpV6TS/jp9h3chfz1dN+dX/6t0DoAdYJZVk8sxqWmV
         yr6A==
X-Gm-Message-State: AOAM5313R+QHKvBW2kWSpW9nWLNGLGriBxMPbgBXJsJ5uNu5CIAqWibe
        CQYLR0CxWXKKtqpS6G2WKQ3lKQ==
X-Google-Smtp-Source: ABdhPJyH976re0ArjKDAQ3EQSjXztAKBneGw7A3SAjIUjHZgPDdUMU9iIx+yXRn1v6AZEDQ6IjlXfw==
X-Received: by 2002:a05:6214:20e4:: with SMTP id 4mr10695770qvk.95.1638995751606;
        Wed, 08 Dec 2021 12:35:51 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 143sm1898710qkg.87.2021.12.08.12.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:35:51 -0800 (PST)
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
Subject: [PATCH 03/10] mm: Avoid using set_page_count() in set_page_recounted()
Date:   Wed,  8 Dec 2021 20:35:37 +0000
Message-Id: <20211208203544.2297121-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_page_refcounted() converts a non-refcounted page that has
(page->_refcount == 0) into a refcounted page by setting _refcount to
1.

The current apporach uses the following logic:

VM_BUG_ON_PAGE(page_ref_count(page), page);
set_page_count(page, 1);

However, if _refcount changes from 0 to 1 between the VM_BUG_ON_PAGE()
and set_page_count() we can break _refcount, which can cause other
problems such as memory corruptions.

Instead, use a safer method: increment _refcount first and verify
that at increment time it was indeed 1.

refcnt = page_ref_inc_return(page);
VM_BUG_ON_PAGE(refcnt != 1, page);

Use page_ref_inc_return() to avoid unconditionally overwriting
the _refcount value with set_page_count(), and check the return value.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/internal.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 94909fcce671..47d1d3c892fb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -132,9 +132,11 @@ static inline bool page_evictable(struct page *page)
  */
 static inline void set_page_refcounted(struct page *page)
 {
+	int refcnt;
+
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	VM_BUG_ON_PAGE(page_ref_count(page), page);
-	set_page_count(page, 1);
+	refcnt = page_ref_inc_return(page);
+	VM_BUG_ON_PAGE(refcnt != 1, page);
 }
 
 extern unsigned long highest_memmap_pfn;
-- 
2.34.1.400.ga245620fadb-goog

