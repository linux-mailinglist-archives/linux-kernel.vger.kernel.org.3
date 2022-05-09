Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595D251FACE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiEILFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiEILFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:05:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69686223867
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:01:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso16701282pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tr6+NBI5Dp7/pv2IhiUO3+bTmtkrDRJXLmbHS2KDzto=;
        b=29UqZuhw9+M3t42ulPc2ZSmZykQBVXN33MMQFuKE/0R1Kyd39m/lC7COmCnwOidfAn
         Q267MfGBvY6H1Sqo7KBGDIh2ogS6Nvs0Vp2+NTBA6iHpGp0Vqv7b9wjdw20bZhaIhYme
         MUnYF0YnyGufZYUokA6v2jORmdAYEHKj1mZ4qiBRigG706w+qBN6N0Dj/pkxfuyl4sm1
         nvjZDHIZPMD2JDnE6iw3Cp709ZCkXTre51LDkijO2HYNDuzVH89m5rzNiWlI2QuBb6a3
         6H38ONV6LkPtY2fNEoyzRQnQFgZSjmYNH6A8j3Mez/Sp4GRaKiOv8V9Ck/XrnEg7jFXK
         XbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tr6+NBI5Dp7/pv2IhiUO3+bTmtkrDRJXLmbHS2KDzto=;
        b=yyC+mOP6HzRc1XH82i7Nf46JUM+kL5nue8sO6h8DeNK6liMlY/hbOBY5g5vRk2eUAh
         pm7GmqK43qsBQqTFJzJOCWbuBhg29dwuZrXFIHpoGkriHGvH1MNdMbh9lnwPIQ4CysV6
         jiO/WaA2JwPUXp5I2O9dUyaw/dxSMJhdquEfmy8zCh5sXALDi7xHZXqsUTprMpRiUyC2
         a3MHvr2Vtsmqve+U6khz39OSZPuTHnqLA2mGpeiMJ7WQilJCV6hzd/d94F860WqGv1ca
         x7f7O20PgFT9/VzBRkMNZAKy8A/mdddF6GHoJeF1UMvtmD1U/ixjCIzd8tcxHjlvgzLx
         o2Zw==
X-Gm-Message-State: AOAM5325L3IMo9OsjTO0/t4dAAyVOGIPaZRDpSJ0yNby9PbeBZhfHg+i
        uGnA/w/NaVisYsKOLCw6+mnrXA==
X-Google-Smtp-Source: ABdhPJyU6HCZrGSz6lqIXae9RRYvrGcjZLnJUViQxdva/SCNkBkiHGP9a4t1FymjNKczWy+XWRGMIw==
X-Received: by 2002:a17:90b:38c7:b0:1dc:77aa:e3d5 with SMTP id nn7-20020a17090b38c700b001dc77aae3d5mr25428577pjb.51.1652094071883;
        Mon, 09 May 2022 04:01:11 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902968c00b0015e8d4eb244sm6813303plp.142.2022.05.09.04.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:01:11 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 4/5] mm/hwpoison: disable hwpoison filter during removing
Date:   Mon,  9 May 2022 18:56:40 +0800
Message-Id: <20220509105641.491313-5-pizhenwei@bytedance.com>
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

hwpoison filter is enabled by hwpoison-inject module, after removing
this module, hwpoison filter still works. What is worse, user can not
find the debugfs entries to know this.

Disable the hwpoison filter during removing hwpoison-inject module.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 mm/hwpoison-inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index bb0cea5468cb..5c0cddd81505 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -65,6 +65,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(unpoison_fops, NULL, hwpoison_unpoison, "%lli\n");
 
 static void pfn_inject_exit(void)
 {
+	hwpoison_filter_enable = 0;
 	debugfs_remove_recursive(hwpoison_dir);
 }
 
-- 
2.20.1

