Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A83753DC92
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbiFEPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345344AbiFEPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:25:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AAB2715B
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 08:25:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v25so15793094eda.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBSo6LhPKNDFYlpKsrymkakMP0nVeotmS2LDUe++2Ag=;
        b=MI2W98/bl4fvsuc7EA8n3jW7RtyXsolzKl8iYKGjUKHxpV+xI4yWBh9si/SfGcnemX
         Wp8Z6Ka4sKIw3ARIJrGTE81BjutbjE8F98r+5LHsywIlLVbH8ZT9BpS2oa3MAZ3Rs2gu
         AdGWx4erG8ZpDjcF3eYxvJR82Nlg41YU9S044=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBSo6LhPKNDFYlpKsrymkakMP0nVeotmS2LDUe++2Ag=;
        b=tty+BkKK3j0bo8m4G3O8i8BeAX+wfBhfG6FkWyhYD0sGEmk1b2hlwDWTh1U4kR2PAl
         KJIY8r8PbaIspieoGQCrJNU1CBhzBYXIvmlmprZIcEktpQ7+yPlJ5M8KxohhvATlXwKo
         szeXcqaVxFZC5LcEDZhIyoMSMnHt/Y2Iq12HvK1ivMiulaDhyl2VWgDgQTPUnikqUI3C
         5VBL/FvtCHqMB1RfkGkuhmO3okfwjA2u4yMbtEjFykem92Ql/p+jQpvv7QnmQXoZgoOM
         9BUomn/yTCTkGxIT2f4pKUy6Urq8aq4YaWtPpddSWJBXqElE1Llultvv5HWQv2HYw/Lo
         6zOQ==
X-Gm-Message-State: AOAM5307O5lvNkt0Lk5JjCbhnDXSRNuS2ivu6P1x1Wv5bYbQmVhV8Kas
        Me5XZmiuan4BYiH12igQy5pW/KIZutkZZg==
X-Google-Smtp-Source: ABdhPJyz+DCsoFSlGZIktlTYtkVTK8pml1UNEzc+5GGMb5RBEfVAt3+lSGDPBsrviNR+kw3jH8t97w==
X-Received: by 2002:a05:6402:42d4:b0:412:c26b:789 with SMTP id i20-20020a05640242d400b00412c26b0789mr21414271edc.232.1654442745494;
        Sun, 05 Jun 2022 08:25:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402125500b0042dddaa8af3sm7051499edw.37.2022.06.05.08.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 08:25:44 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 1/3] mm/page_alloc: use might_alloc()
Date:   Sun,  5 Jun 2022 17:25:37 +0200
Message-Id: <20220605152539.3196045-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... instead of open codding it. Completely equivalent code, just
a notch more meaningful when reading.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/page_alloc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2db95780e003..277774d170cb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5177,10 +5177,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 			*alloc_flags |= ALLOC_CPUSET;
 	}
 
-	fs_reclaim_acquire(gfp_mask);
-	fs_reclaim_release(gfp_mask);
-
-	might_sleep_if(gfp_mask & __GFP_DIRECT_RECLAIM);
+	might_alloc(gfp_mask);
 
 	if (should_fail_alloc_page(gfp_mask, order))
 		return false;
-- 
2.36.0

