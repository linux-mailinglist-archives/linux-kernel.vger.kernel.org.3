Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E4959B526
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiHUPmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHUPmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:42:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F099E1CB15
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:42:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e19so7550159pju.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NH92h/s4Soe5U4MYFnUhteYLROiSYWktF09/ofBtT24=;
        b=EEpjWqUAEIYey8Vx3R4wQW1i+pIpveVzAYWhkuJVyzMlMcYSksW42gb9vVxdbdwtVt
         h0QEo2JaXKj7FU6/xva+F4kSIYiLdF1RlPh/v1ovJdDoR4aWPIM8ix203wijGolDJes+
         N3aLkmyJDEIc3b5LOxUfHX4o9QCqrL3M8+KtFOMIDFxmjLEO4IP4w+l6uG9kesJTVH4A
         dNcBowT5h6WgyP/0KLj50U/ZvHFCdjWczm1URgw2IGtTJtRSDXvxLLzPIleWL8RcKPmT
         NuKzmIqtNvIginOpZUS0A9NMmF1A9R03GCZ8O35qY3GNAq9iTo8FC6+2wPuTKZUuCXtm
         XF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NH92h/s4Soe5U4MYFnUhteYLROiSYWktF09/ofBtT24=;
        b=arV2ZLAApZdA6CoPC8IFdeCysGyma8leuQsQXLYdsVH48NmexTuai8H86QwJUYgkq8
         TWt8rzeu/6sM3F/urzpsFSjlkb+7gYOJgoGtQWVXT25ICOig9EUVUev8J2H9FgpDzrAD
         RQoQWMtHxS+Ttx9Sh3QJPwkatjP7fMZbqfg7zY82CqRDfIujsXwKL8NUv5AWq/BunjPk
         76oSgUqzsMw5cs+N61A1BuGz8atvfp2Rfq0IUT8ytGfi9C87e1rVCPm2jP6u7CHuISbS
         mPBh5IE5WXJObtMGm6DL0fp6fLnA5v1OlyivLNk7sZ3nE4h8pX0VZtcyJUWqpEBRZpLm
         Bh8g==
X-Gm-Message-State: ACgBeo1Jgz6IwEOQsU3RR49cteZ53ERedrTrIN3rofXRPN5RRuRZbQju
        ZYeHUtmjFTh12FYmRG6nyp7NHBt14sI=
X-Google-Smtp-Source: AA6agR6l42SoHMuJQdAcYlj27AjNpDt8CSJhgvwnKOIkUXvOvez9Pi4r8WAwKc2GqOGP9PiY45ZX5A==
X-Received: by 2002:a17:902:ba96:b0:170:9f15:b997 with SMTP id k22-20020a170902ba9600b001709f15b997mr15889474pls.34.1661096523078;
        Sun, 21 Aug 2022 08:42:03 -0700 (PDT)
Received: from localhost.localdomain ([113.172.183.227])
        by smtp.googlemail.com with ESMTPSA id s10-20020aa78bca000000b00534e9aadbf7sm6857796pfd.182.2022.08.21.08.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 08:42:02 -0700 (PDT)
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bui Quang Minh <minhquangbui99@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH] mm: Skip retry when new limit is not below old one in page_counter_set_max
Date:   Sun, 21 Aug 2022 22:40:55 +0700
Message-Id: <20220821154055.109635-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In page_counter_set_max, we want to make sure the new limit is not below
the concurrently-changing counter value. We read the counter and check that
the limit is not below the counter before the swap. After the swap, we read
the counter again and retry in case the counter is incremented as this may
violate the requirement. Even though the page_counter_try_charge can see
the old limit, it is guaranteed that the counter is not above the old limit
after the increment. So in case the new limit is not below the old limit,
the counter is guaranteed to be not above the new limit too. We can skip
the retry in this case to optimize a little bit.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 mm/page_counter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index eb156ff5d603..8a0cc24b60dd 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -193,7 +193,7 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
 
 		old = xchg(&counter->max, nr_pages);
 
-		if (page_counter_read(counter) <= usage)
+		if (page_counter_read(counter) <= usage || nr_pages >= old)
 			return 0;
 
 		counter->max = old;
-- 
2.25.1

