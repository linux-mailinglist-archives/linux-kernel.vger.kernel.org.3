Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0995E4974C4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbiAWSnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiAWSmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:42:32 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D508BC061794
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:31 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id e28so9334233pfj.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=85CEHLzivVSDPv5NoUUHMFbNwsVpSDhXVe4Dokl88jA=;
        b=UzLV4ACAW1Zy650aoKKKtti7eIYU39SU4smwBi6B3avNAIj+XR/PLCLBZK7l8VFZGd
         GOy2eGmfswc9be1FqLvOFJQ9k4AveCVBGC9efdwLQ/Ntp/+55BTmI5Wx6A1/VNWY4rKL
         f//7wEMw7b/7dWk9eXodLjfhTVgj7bWk//YBPIJptJPcK7+kqhioGoP0gZtSiBe9mT8Q
         FUrvSqGgkNljkIUpAVSAm6jqntWWFFJ8C7/aXlmsCAywzSh7xfUTuxF6RBVnzcyq6J8S
         bOkE/gKUxJf09SuXz0WQHQ6tjK3FC8HTY4bDHghjLZ6GOodD8DCQuZWaqY4aPyB0qjfg
         Zf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85CEHLzivVSDPv5NoUUHMFbNwsVpSDhXVe4Dokl88jA=;
        b=7iv2NlAonKsZJiw2KZI5EroDG4mx4fGxfwJZGEQDL5uX8o8C4iN4KaHU9YCBmfoktu
         p2MYfSyVhkCfJf2NizGVBtr5/rSYnS2aqYQZjFKobwg9puwuhooOZFSRGmLijqi3v7rZ
         cAn69EhxErqSgz42gQCXQyj2qoeIo1tlZDv2omdpTDdFHzTCv73DlWidJaYHj6RuCbDN
         gYsTA2zVnrnp7iCezlfroGkXm9FMDXC8mXNSqCLKOSEraZZC4N418uL/1OFUyRwzyLEn
         1lhmChvBD216LBa2jZz5S7S4O7e4YbL34/pemearvf7uVPRKHCXjtvbFV5UNCFyHlFoy
         3OBQ==
X-Gm-Message-State: AOAM5333C+E1m6nCnV7v3Srt1iJwROWgDOZZmwgt16aP2z2X2Dka8lSY
        V6LiqXZo3omVgEHQrC6worI=
X-Google-Smtp-Source: ABdhPJzbT2vRHTzHp9RDGT6tMM884pEgiTMl6MSvk/izz/msw8mIEJTAbh58Y/esUmn/X7IAMRDKxg==
X-Received: by 2002:a05:6a00:1407:b0:4c3:3ab:1467 with SMTP id l7-20020a056a00140700b004c303ab1467mr11218233pfu.22.1642963351381;
        Sun, 23 Jan 2022 10:42:31 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id k13sm14218413pfc.176.2022.01.23.10.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:42:31 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 52/54] lib/nodemask: add num_node_state_eq()
Date:   Sun, 23 Jan 2022 10:39:23 -0800
Message-Id: <20220123183925.1052919-53-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel code uses num_node_state() to compare number of nodes with a given
number. The underlying code calls bitmap_weight(), and we can do it more
efficiently with num_node_state_eq because conditional nodes_weight may
stop traversing the nodemask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/nodemask.h | 5 +++++
 mm/page_alloc.c          | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 197598e075e9..c5014dbf3cce 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -466,6 +466,11 @@ static inline int num_node_state(enum node_states state)
 	return nodes_weight(node_states[state]);
 }
 
+static inline int num_node_state_eq(enum node_states state, int num)
+{
+	return nodes_weight_eq(node_states[state], num);
+}
+
 #define for_each_node_state(__node, __state) \
 	for_each_node_mask((__node), node_states[__state])
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8dd6399bafb5..37496d764643 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8328,7 +8328,7 @@ void __init page_alloc_init(void)
 	int ret;
 
 #ifdef CONFIG_NUMA
-	if (num_node_state(N_MEMORY) == 1)
+	if (num_node_state_eq(N_MEMORY, 1))
 		hashdist = 0;
 #endif
 
-- 
2.30.2

