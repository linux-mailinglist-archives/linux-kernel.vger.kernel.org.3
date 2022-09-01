Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2025A9BF5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiIAPok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiIAPo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:44:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924D78B2C1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:44:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qh18so15290948ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sm81rFnMC95UT/sLYUuNGPmK2vB2Ge/WfYCIgeR1caI=;
        b=ZYilaImcLXiDpt5s0mImwJWlARkse5J910Tiofph6MltZYXKQN+QY5OWEAsC9WnOQx
         IOoU5OHcy8IC2Lk+jlGxguZCXy3mfuc61+dekre9oc0ZN+IBf1WTqLcoH3ceNiQB9VWA
         WqTqjz7HdtHkOIDrtlmnmcmEToZh+aMxB/3iT5wuzhPn+jiq238dTs797RjbgHmz2aJN
         BQndNJsOK+FEQMQQSxAK8x6AiJR6lG2wHyZzJedKE+vTh8nlQzU8UUbcvJoGJPvQguiD
         m7FQpPE7Ua+WtHbr8Y+sVX1bob9c2JBnOc4Mr4AkVuC3k7pq5bR4/abFDmZh97uWgxZm
         bL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sm81rFnMC95UT/sLYUuNGPmK2vB2Ge/WfYCIgeR1caI=;
        b=DdXIhdvd9qC3M/+WNlaM8JdI9xiGh4nistk7TavYnkWdwUnLgIyfQnU7cdDPJ2yqeA
         rY9f6+MPPq9Tq8yiLXDc2xT8zWOMOZ8/avRMinq7RP4ENwlZ5cxq17EBIornR/dQ+75w
         t7eCELIOl9p4Sq+bXBsPecrv8xvgMeZe/CLh65oRHMwFGpj5kAwkX3DU55tMMUfEJ57N
         7yMRMY29w/bsgUjZ0ewas5GDjfp9bsJS2vPRb2vWDDDY/p/i/odoLSMmKSVYoHZLS9Hi
         oNi+LN03hveJnhvj7dKnNtHdcgvuI5ky3C7/vR12d/PvQSctoEmM6N9gnqsflDmR0sv/
         mpYw==
X-Gm-Message-State: ACgBeo0aPRQfVvLbeKt4pnMiFClxq6lQJRyxv1mDbCgw5XpouGLb9Q5C
        I651PC5/QTFpXq76G6Gy1jE=
X-Google-Smtp-Source: AA6agR5HRM91GDph9126hEGDoQoFaqeifP7y1mhv3MDQkVYYSuLpvCyiqZdmsxzGln87BGqXoj289A==
X-Received: by 2002:a17:907:7283:b0:731:60a5:5fc9 with SMTP id dt3-20020a170907728300b0073160a55fc9mr23798439ejc.51.1662047058085;
        Thu, 01 Sep 2022 08:44:18 -0700 (PDT)
Received: from localhost.localdomain (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id g6-20020a170906198600b0073dc6def190sm8576682ejd.158.2022.09.01.08.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:44:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 2/2] misc/xilinx_sdfec: Replace kmap() with kmap_local_page()
Date:   Thu,  1 Sep 2022 17:44:08 +0200
Message-Id: <20220901154408.23984-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901154408.23984-1-fmdefrancesco@gmail.com>
References: <20220901154408.23984-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap() is being deprecated in favor of kmap_local_page().

There are two main problems with kmap(): (1) It comes with an overhead as
the mapping space is restricted and protected by a global lock for
synchronization and (2) it also requires global TLB invalidation when the
kmap’s pool wraps and it might block when the mapping space is fully
utilized until a slot becomes available.

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).
It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
the tasks can be preempted and, when they are scheduled to run again, the
kernel virtual addresses are restored and still valid.

Since its use in xilinx_sdfec.c is safe, replace kmap()i / kunmap() with
kmap_local_page() / kunmap_local().

Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/misc/xilinx_sdfec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 4b1d82ae7312..cb9506f9cbd0 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -636,7 +636,7 @@ static int xsdfec_table_write(struct xsdfec_dev *xsdfec, u32 offset,
 	}
 
 	for (i = 0; i < nr_pages; i++) {
-		addr = kmap(pages[i]);
+		addr = kmap_local_page(pages[i]);
 		do {
 			xsdfec_regwrite(xsdfec,
 					base_addr + ((offset + reg) *
@@ -645,7 +645,7 @@ static int xsdfec_table_write(struct xsdfec_dev *xsdfec, u32 offset,
 			reg++;
 		} while ((reg < len) &&
 			 ((reg * XSDFEC_REG_WIDTH_JUMP) % PAGE_SIZE));
-		kunmap(pages[i]);
+		kunmap_local(addr);
 		unpin_user_page(pages[i]);
 	}
 	return 0;
-- 
2.37.2

