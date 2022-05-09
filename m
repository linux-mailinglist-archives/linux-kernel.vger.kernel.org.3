Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E0251FAB5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiEILFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiEILFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:05:06 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49446224040
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:01:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n18so13502226plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lgBugjMBjpGQ7xeNvhxji4XO8XtdFmxbyx8qWXB/d1E=;
        b=Pj3odeW7eWCV6Y3wbzSEpD8iLoimaxAI1ooehshks8JT1P+ojlGgtSlicuvorjqyuO
         kT/iSH9IeTlMksEU/xWsoNwYko7rqXxxjzmm7oEHy9uBn+PwWOaxTT/EMhftkdQSxcNs
         eGk5ULQ2fgZEg9dJac5mZduPWbV1z0FGFUj8xKI7mox5vPPrbdfNxmtVi1H3bZwnCcgR
         E4bjgy+vFNnAUACAkd4XWb2qxrFBOJ1RYP1wyhLjvM97E3+yfhHY3zIHCohiu5BeTRVE
         IE3l1JXhD1BJyLIUALFNepOCs3HyemnMQzn2YuOIZ/1ccCAkhgRSWZN+uw75l01f5aGc
         7Qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lgBugjMBjpGQ7xeNvhxji4XO8XtdFmxbyx8qWXB/d1E=;
        b=SDiyQLa0nchMPvNrcbnGWspUrju9llIrZpIZrKdH8Cb3wH2guJrlXkIshLPRtpkai9
         qlYu4vSOKn0TZBnBVtmJ6nhy+UoIWWeyqSwPBx85gpCiXqvncX5PsClwgMPQcKY4heMH
         DZQqwXvLuUacMqn/U6FLb7ugLivcPxXpdVnsd4302d1wbh3WzDMuK5umXFMn2+CDEyBH
         jwH8EqWhFSuPwpTGiuJ0CrwT52qiMU0OeN4w7C8eMugarKy5pE4x5JXHxj+Tv41mxPKW
         q7enWILy3LdWQUJabkUKogpf1sv77ckh9Up4qB53U/bTBonRnPTquVPL7jPHUvnyiYyf
         lhbg==
X-Gm-Message-State: AOAM533EHzZdoce9RSxCIXqjJjLA9lrQgad7D78kTX9H3288acgEJPg3
        gAM9YBVcuz37noeAcHtdA0IzxA==
X-Google-Smtp-Source: ABdhPJzX90hgfGWeg918bEYrTW1cS8gQltC1OktUE0gYPnZCoiRblOWmhlkao5W1SGi61URQ7uy4sQ==
X-Received: by 2002:a17:903:210:b0:15e:f139:f901 with SMTP id r16-20020a170903021000b0015ef139f901mr14084732plh.66.1652094068623;
        Mon, 09 May 2022 04:01:08 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902968c00b0015e8d4eb244sm6813303plp.142.2022.05.09.04.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:01:08 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 3/5] mm/memory-failure.c: add hwpoison_filter for soft offline
Date:   Mon,  9 May 2022 18:56:39 +0800
Message-Id: <20220509105641.491313-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509105641.491313-1-pizhenwei@bytedance.com>
References: <20220509105641.491313-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hwpoison_filter is missing in the soft offline path, this leads an
issue: after enabling the corrupt filter, the user process still has
a chance to inject hwpoison fault by
madvise(addr, len, MADV_SOFT_OFFLINE) at PFN which is expected to
reject.

Also do a minor change in comment of memory_failure().

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 mm/memory-failure.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ece05858568f..ed280ef5473d 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1762,7 +1762,7 @@ static DEFINE_MUTEX(mf_mutex);
  * enabled and no spinlocks hold.
  *
  * Return: 0 for successfully handled the memory error,
- *         -EOPNOTSUPP for memory_filter() filtered the error event,
+ *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
  *         < 0(except -EOPNOTSUPP) on failure.
  */
 int memory_failure(unsigned long pfn, int flags)
@@ -2317,7 +2317,9 @@ static void put_ref_page(struct page *page)
  * @pfn: pfn to soft-offline
  * @flags: flags. Same as memory_failure().
  *
- * Returns 0 on success, otherwise negated errno.
+ * Returns 0 on success
+ *         -EOPNOTSUPP for hwpoison_filter() filtered the error event
+ *         < 0 otherwise negated errno.
  *
  * Soft offline a page, by migration or invalidation,
  * without killing anything. This is for the case when
@@ -2368,6 +2370,16 @@ int soft_offline_page(unsigned long pfn, int flags)
 	ret = get_hwpoison_page(page, flags | MF_SOFT_OFFLINE);
 	put_online_mems();
 
+	if (hwpoison_filter(page)) {
+		if (ret > 0)
+			put_page(page);
+		else
+			put_ref_page(ref_page);
+
+		mutex_unlock(&mf_mutex);
+		return -EOPNOTSUPP;
+	}
+
 	if (ret > 0) {
 		ret = soft_offline_in_use_page(page);
 	} else if (ret == 0) {
-- 
2.20.1

