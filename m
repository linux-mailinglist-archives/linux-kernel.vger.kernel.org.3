Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA52B497475
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbiAWSk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbiAWSkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:40:12 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F200C06173B;
        Sun, 23 Jan 2022 10:40:11 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h23so13121408pgk.11;
        Sun, 23 Jan 2022 10:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5dgQylvVki0nkzDnS/+Po4tisaRNHjVIflYn4fyQ95A=;
        b=NPOFz183ei2daEpofKHSZlIolbNFGvjJd0bvuAgxnQXa1mbuzsB8hvhkTyioW5ltoS
         y5sMMuWjyvc6kDKU9Jy9RUasJPQQydggdGhHkwIb35VXWo1CaSQ0zCd9mdEPpwTnH9lE
         TQqSWzrtUY0GJOlgUr5T7TRU7USi2tfNg0iPTHfbRBNkqvnNmL37z4Z3nE/duk/GdyQ5
         cmvTi8PRmdLMbpY5nfSMCDbv/xdK/q2iKEIs8W5TKJvzZ6qlATNv/wm7uCbiAn1dPBU1
         +aM82cX+6IPqeayXYKuA7LfBX8rP3SzfEyhASY6EF68X1T6Es8PNFrBgcehKUkL4wkcD
         DEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dgQylvVki0nkzDnS/+Po4tisaRNHjVIflYn4fyQ95A=;
        b=C1XnGtuLZ+5b+jIpOZs8MkATAvPQ8EfJaC9z5s2FLWazeDtrPzD6gsXUmVACzVD5iD
         wOlJTT0C24+OwJPhf+xdAXqmVtWgi2ZKhVbt0mphnHRb5D0LaO8Me9g9wrDp5KX+nxPF
         8QQwkas0RbsxMUINecOQJUediEutlqfByXCscoFJCF2rt3Qjj5ywrDNpTlclv8ZavaFP
         BrkNxGXCIQ1KqYH5ffVB4A1jDiyhWiKgfzzn0yQeB3/yRR1KJcYu3sz3y4Latirfu9Rt
         sg69Cb+5i0APwX31C5aQ6+SdXepuT9r+RJDeSBXhOADiiRW4bLuJ2bQti2+jH9zwC3B/
         J1yg==
X-Gm-Message-State: AOAM531AGLPoGrgMg+bghXOb31wb/ViO1NGjg5EbTC0EAUllEVJUoJJg
        l8RRJPpQjWR+kBuaDu2hwz0=
X-Google-Smtp-Source: ABdhPJzsBbCwcI8UQ9QtXW6uxvo0U0RHWhtm06Iz8OLFP8vkslwU6MYNdswa+/Z1sC5DBYGMC9d39A==
X-Received: by 2002:a05:6a00:23cc:b0:4c6:d3b8:29ea with SMTP id g12-20020a056a0023cc00b004c6d3b829eamr11191897pfc.78.1642963211024;
        Sun, 23 Jan 2022 10:40:11 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id a3sm10460879pfk.73.2022.01.23.10.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:10 -0800 (PST)
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
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 07/54] gpu: drm: replace bitmap_weight with bitmap_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:38 -0800
Message-Id: <20220123183925.1052919-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_request_block() in drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c calls
bitmap_weight() to check if any bit of a given bitmap is set. It's
better to use bitmap_empty() in that case because bitmap_empty() stops
traversing the bitmap as soon as it finds first set bit, while
bitmap_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
index d7fa2c49e741..56a3063545ec 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
@@ -68,7 +68,7 @@ static int smp_request_block(struct mdp5_smp *smp,
 	uint8_t reserved;
 
 	/* we shouldn't be requesting blocks for an in-use client: */
-	WARN_ON(bitmap_weight(cs, cnt) > 0);
+	WARN_ON(!bitmap_empty(cs, cnt));
 
 	reserved = smp->reserved[cid];
 
-- 
2.30.2

