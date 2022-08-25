Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9205A0D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbiHYKLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240998AbiHYKLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:11:44 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E358B980
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:11:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p9-20020a17090a2d8900b001fb86ec43aaso4030468pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=SFdsSjWAQONAyj0B4BGWWGxwj5pOAu9AOlwRQ0TgC5A=;
        b=TctdZfIB9N0zQ09kkMlDWP+Kr7s/oP2QOFrEA8cG2q9SH3cDPtW2Xm2qtLCu0ZF1Ie
         1cUD++3IFC9j8HSTyFV/pRd4U1vDay6piC5UoSjKLxTr6kc80Lf5dVy8/65A5EzAXWiF
         YMBmiu4+p+0A/8rJdD5MLJdpOay+sCeIwrpr6v7Su66828TBlx27Q2fM06Ep3JN4IfU9
         0hmRqRattiBx+fp4aSQX6w7soFQ4ZKtwWmtlgH2Thaf0C9I0j2gDoTqFdYSpCFOPl9oE
         6RdNvpO9I+k0yShSBe6PWhEeJBrKGzdMUel3hRhbBF7mg/X5dUX8vUVwYjWo8giRUEAl
         xdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=SFdsSjWAQONAyj0B4BGWWGxwj5pOAu9AOlwRQ0TgC5A=;
        b=qINdmvQuh4T226QqectFJE/WdJwhceJSu7P/rFA/vHN+kF/msL0HpSDhZZOyZ7EB01
         w3DL0YdZBfPMAQ0GXbuV+HH8YIM0WIsW2IljObXxxr51F4+4lKPZmc8fP1d/iKzKQxNu
         EY9KCF4t4QSDOrUXO9HuUagtLIqWD2Cxu85hOux/qf5ObUQ9N9nKLllh+oobv+szpBix
         hOMi5BIA4hyhstUlvzkuuA/M/kGW4a/L8Y8vkoEWSr3yvppvMmJE8JX7rrM7MnN3uTR1
         uRHL5mrH8dTf6+p8YeeZF7Xs7SU8vKcIzaz6lGL1A00QjyfVEe7WA0RrC9A0OmRgSRkU
         Evzg==
X-Gm-Message-State: ACgBeo2/dSCR9fBmqpq+iPVZ5THMjJk3P0H2NnhBpzHfMXCXCy6ZbbR5
        LtqE5MnyzFvi1pPXqg6SFMElUw==
X-Google-Smtp-Source: AA6agR4nupyddDVBBxbVHoklijRwE4BfvVlD41bJo7HEk5T2gjgiaqdFrpkQmsyV98KPMM8cpv+8MQ==
X-Received: by 2002:a17:902:f641:b0:172:9642:1bf1 with SMTP id m1-20020a170902f64100b0017296421bf1mr3175044plg.36.1661422301791;
        Thu, 25 Aug 2022 03:11:41 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001714c36a6e7sm8477581plh.284.2022.08.25.03.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 03:11:40 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@redhat.com,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        jgg@nvidia.com, tglx@linutronix.de, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 2/7] mm: introduce CONFIG_FREE_USER_PTE
Date:   Thu, 25 Aug 2022 18:10:32 +0800
Message-Id: <20220825101037.96517-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
References: <20220825101037.96517-1-zhengqi.arch@bytedance.com>
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

This configuration variable will be used to build the code needed to
free user PTE page table pages.

The PTE page table setting and clearing functions(such as set_pte_at())
are in the architecture's files, and these functions will be hooked to
implement FREE_USER_PTE, so the architecture support is needed.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 169e64192e48..d2a5a24cee2d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1130,6 +1130,17 @@ config PTE_MARKER_UFFD_WP
 	  purposes.  It is required to enable userfaultfd write protection on
 	  file-backed memory types like shmem and hugetlbfs.
 
+config ARCH_SUPPORTS_FREE_USER_PTE
+	def_bool n
+
+config FREE_USER_PTE
+	bool "Free user PTE page table pages"
+	default y
+	depends on ARCH_SUPPORTS_FREE_USER_PTE && MMU && SMP
+	help
+	  Try to free user PTE page table page when its all entries are none or
+	  mapped shared zero page.
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.20.1

