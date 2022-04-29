Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E65514CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356954AbiD2O3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377257AbiD2O3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:29:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA5EA1471
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:26:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so8727495pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T+xkL3YWKNIwUvhcyT6Zc2yQzS0rBzFbHurjbmprYM8=;
        b=laYz416cOyIijfEQ+pVXTypoycAPoNCaBjiFp2ErDhoCqHrvU9sC6Xq1SEKRHCT5vK
         rchwEpxXSozP9Xnq07+2MlLlnCDZd3VqHfgrAwYi3GvcAOf/mcN/ae3HU0hC/UeTbfSW
         oro3O4iW0oH0MkXAFc3reyccrgWCR8LbWKWu5FIB5uRP464LJRHDEX26SVXpwgM3sUTt
         h3pwoOL3p/4eyF3dHBgxHbQhBGEylGN2GU4HfvD2gea+DcI3HvjuRVpEEbjvKruhbLFM
         j1/nBj8+dvlmBs/UvP/YCL+26jOspr/4lvcICuGTh49aCmIfAVn1eSDAhGB+pD4td6PJ
         05Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T+xkL3YWKNIwUvhcyT6Zc2yQzS0rBzFbHurjbmprYM8=;
        b=WQaBUfBABQTJ6UoNyEFU4KbhV1zQmyuBCylaOe884sfnpoBYk6xyNLMCHNsSlD9n/N
         l1kJl7m0BaMYwl17gXzTAfz6oywZuu14RJbjboPcUf9z6Ji9+JPTSJ8A0gCWMoq40Bn1
         Ukox88wlTER1AkK+/4l3AKieFOrFLFFoonfhtYmXAPwurR4WyeKWC3QPR0jx2qSA5Bl/
         rmRPiC21rimpcjz1lsqs2kh1xk30ByZ9B0C6C9J6ktglLJ8/4F/8QJAvwPuSUBdjX4W2
         eM5Arb3sfRm9uXgXEPscF9RxFX6cO3PINhYjIdGOoTyMUNc4PdGBQHFU7EvPitz0dGTM
         JP6A==
X-Gm-Message-State: AOAM5324R7PCT5HWD35CCkEGRfAPKakqpTQ3OjThT8UpQrayoKr8LRHq
        qpaCh/Wfu6um5mnzj2hozxKutA==
X-Google-Smtp-Source: ABdhPJz3haJXofXKco6B7+t0Ls+9sd0gtckJfaYdpRJH2uZO9g060KFNm7+1zgYdOuEcI+B3n7xNHA==
X-Received: by 2002:a17:902:f792:b0:153:1566:18 with SMTP id q18-20020a170902f79200b0015315660018mr38572615pln.115.1651242378746;
        Fri, 29 Apr 2022 07:26:18 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004fae885424dsm3494734pfx.72.2022.04.29.07.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 07:26:18 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 4/4] mm/memofy-failure.c: add hwpoison_filter for soft offline
Date:   Fri, 29 Apr 2022 22:22:06 +0800
Message-Id: <20220429142206.294714-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429142206.294714-1-pizhenwei@bytedance.com>
References: <20220429142206.294714-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Cc: Wu Fengguang <fengguang.wu@intel.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 mm/memory-failure.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a6a27c8b800f..6564f5a34658 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2313,7 +2313,9 @@ static void put_ref_page(struct page *page)
  * @pfn: pfn to soft-offline
  * @flags: flags. Same as memory_failure().
  *
- * Returns 0 on success, otherwise negated errno.
+ * Returns 0 on success
+ *         -EOPNOTSUPP for memory_filter() filtered the error event
+ *         < 0 otherwise negated errno.
  *
  * Soft offline a page, by migration or invalidation,
  * without killing anything. This is for the case when
@@ -2350,6 +2352,11 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return -EIO;
 	}
 
+	if (hwpoison_filter(page)) {
+		put_ref_page(ref_page);
+		return -EOPNOTSUPP;
+	}
+
 	mutex_lock(&mf_mutex);
 
 	if (PageHWPoison(page)) {
-- 
2.20.1

