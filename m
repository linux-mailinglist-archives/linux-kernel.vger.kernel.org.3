Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED1858472F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 22:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiG1Upq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 16:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiG1Upe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 16:45:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BCD6B248
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:30 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 72so2469930pge.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=PxrkjbDitHfD1d97Y8UhQKa79eOpeGRQUks9O/4b63c=;
        b=n16KoPlvBzd95MUn2w14Fg7+fI/TRVKK4xnSvA1Ck0fepbOeZl/M1zr2wzFKrwzRoq
         hgiUJNCFAhbYqljsgcuOFgUMTqg2+GGDVdxORVxkRtRM5ukuktVVziFfmfOiI1dDDILQ
         n308kWjnEH/SwP73po2piDXPGtObpbKY0zQLIu0bNzlHTs+TIt4545L7oDmfDKOmsb0C
         XTM7XFMODx5xPDR18Ao7XwDiOQ51/ooNyCvekRdjy0WNutaBFsNfvk+XVar9aHhoib09
         FfYr3yRD0X8UgeNpPGScXUD9sMNcjHqLVvRQ4o3MhqABKodGl6F3wZKKcJ8vytC4mWjU
         LGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=PxrkjbDitHfD1d97Y8UhQKa79eOpeGRQUks9O/4b63c=;
        b=rQjgAk1+S7EKmt1/Df3muvdtzuOTBr4b65z350Sn7VIoDwRYfTr43bcDO1AfRb85wY
         px5i8moZ8BgTdc/c47Q1A6a0lxZq1k7cqZbHVrOkTw1bqIUOsJDsDytyec2OirIfZvc7
         kBrYj5YFo2RK8hIlx1uzqY6j8ZrriUz5g//bGXuMq5quwqSOIC2lAmyodUEKHN5hG6aU
         zvQUDwe+rMVbIoY4LBEuJjXzrpgair+C9hRzhmA5JMR6jODGCuUKbLbML7eYFUO1RBtC
         B0aU8L4pr2pU1QzXcDlXs3gFGkK4oTmz0ARwOBMTdSUolFUD4HnN1j1cI84hBQshg+iz
         eokw==
X-Gm-Message-State: AJIora+/I3lpTPsdkF2i7NhSStqtlZ/iJ8qsCwAcEaAbBDiRnITx5Es8
        45p2YJs2N4iPQ+i7IKIjbZw=
X-Google-Smtp-Source: AGRyM1tXOVFNxoBFYbFBHG8eOFa0LJHrKzg+SUCMnYmaLeI2rBEw1bFu/iUgd6WGY5hnPF0K96m9AQ==
X-Received: by 2002:a63:4004:0:b0:41b:64ff:7fe2 with SMTP id n4-20020a634004000000b0041b64ff7fe2mr419118pga.172.1659041129567;
        Thu, 28 Jul 2022 13:45:29 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([114.254.3.190])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c40f8cb58sm1787304pli.81.2022.07.28.13.45.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Jul 2022 13:45:29 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 5/7] mm: try use fast path for pmd setting as well
Date:   Fri, 29 Jul 2022 04:45:09 +0800
Message-Id: <20220728204511.56348-6-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220728204511.56348-1-ryncsn@gmail.com>
References: <20220728204511.56348-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

Use the per-CPU RSS cache helper as much as possible.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index f00f302143b6..09d7d193da51 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4419,7 +4419,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (write)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
-	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
+	add_mm_counter_fast(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
 	page_add_file_rmap(page, vma, true);
 
 	/*
-- 
2.35.2

