Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3EE4B0910
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbiBJJCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:02:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiBJJCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:02:20 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD0C103B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:02:21 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id l19so3284681pfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=RyMXcmrUxlp04QWvabDBbFsJJhMaqMCO3oplSNl+rTQ=;
        b=aLkF+h17Wqr9ZAVsc/OAh2DjU+/8OAwb7nQ1EDkqxvD6TxJRI6IyTXcm6jHYINvk8r
         4kWarW/zxXH+j4g2SGqxOQHtnw1rfw2LjeYkHHOFZ2S1xgAAiOZq/bXhTc9hCAqFyQ4B
         TTDfkHYgRcVPe8P5G3R0o9/8zHH/ZtwawRu3j8U9ASIM8qLKgNOPFP2+RFQ0tibxGnCb
         TULMfwhFjsMwn/CHggR6hTIuE13YHwbfprcPEm0nHPnM4QtHfEELkjxOKDDgsqjuBdJN
         oH5HE4RtwR4APFOx8nnMeZQSTMLMfjlESuU9ZGurMcZJrPVy8NaiHmu1GZUNqK+R+QFJ
         kKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=RyMXcmrUxlp04QWvabDBbFsJJhMaqMCO3oplSNl+rTQ=;
        b=JNCsDEvPbMiMs1wKcs17NFEsdhlHS9kOlLXG9exsOolsh4dTdF2Rx2CsSL3HaKysR2
         E+W3/F1mFtvZLhHJQ8Tmit72WAEYtU6CrpznVsmP6+HMx2c1ENHg137m0e3nXT07+8mF
         E6jsGvJl9cLsjZBuutbFjuv6phaT1hPN/yJjQFn9fPazzE8FX+cg4jPC7sG9gg+DlEwI
         r70UOu7LE2qTCUR21kByHXKUAiFoFuflKS+Aavs979JrBX7Wd/WkjP/1Xik2uFRJS5kT
         ghQerDisCdhA4ZkFBOnDycbJpnt09K917ruR/MyjQjLsZ6xo19/9399AYO/jFtFdCCOV
         fytQ==
X-Gm-Message-State: AOAM530N4lzwvPMkF9rIYl0I+lxALeVYkzj0GUKdWIxus4Uc/+n1rmce
        /Mu5k73kdDtcXMTYxPxYhJm7hcuykdM=
X-Google-Smtp-Source: ABdhPJzuoRO/xMvCBLpBnqGP2BDYMPld/CiWnVx2cR+TvEs9MZShpo6H8uWGEVHIkfuoXbEnSO07jQ==
X-Received: by 2002:a63:d07:: with SMTP id c7mr696505pgl.311.1644483741098;
        Thu, 10 Feb 2022 01:02:21 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w12sm9854109pgl.64.2022.02.10.01.02.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Feb 2022 01:02:20 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: record context on page->mapping
Date:   Thu, 10 Feb 2022 17:01:55 +0800
Message-Id: <1644483715-7981-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Since page->mapping is vacant in the pages which used by kernel(drivers etc)
Have it record current context to help tracking the page's owner in system
memory dump.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c595274..2757d10 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2430,6 +2430,8 @@ static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags
 		set_page_pfmemalloc(page);
 	else
 		clear_page_pfmemalloc(page);
+
+	page->mapping = (struct address_space *)current;
 }
 
 /*
-- 
1.9.1

