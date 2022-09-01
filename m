Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F45A9E31
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiIARgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiIARfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:35:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFCD5A82A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h9-20020a256c09000000b0069671af62ecso4907321ybc.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=sXPRs4un8Hv1KgYmIkiOTpDZHlwje1UN18vDRt/znXA=;
        b=LBJTSzoCXGb4iiWKyO0OEdlY4M2wMr4mJ5fdr9ss+SWylmfoHLBZ3bDcjUEYCuu5eS
         feBNbsez+RUGQT+LSEIL3jhNfGQ3mzrdU70gDdYtaUSlqG4c3zRWe4jgoZRdVjvHQEvZ
         SPCTeif98/8TgsTaO2lykBXQO/Ydnr0/XtxYChsH6bMYMfoCTEgHM9QVPOJS0Mu1k2UR
         t6jxn7uXNz4Ix/YY107csqUZ1FzpL1YUPLT0wcSHa5tJ7jOlfkB6DfkgR6ONkj0xZI4Q
         CdDjSBazMRaOu6i4p9xpWVSdGu4/KGHF+Yxu3Dy4GMEd28lc2vp55tWuelmW724hNsiA
         vxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=sXPRs4un8Hv1KgYmIkiOTpDZHlwje1UN18vDRt/znXA=;
        b=mgRCSTCRiT2tihJCfTtEl9jXBxTnTLftq1dD5hcQM5LBXpXf35Ef6P2cUxt41idXBM
         oSyHiX4HAWIJ7t9AQMZpGcv0O8czgzG7cGImJufUxYXFGSLjjelxMDPqiiRrJtu9Uodd
         xE7R8cPaHGT1w0/x2K1ijdVuLIj6bTAmu6eH9GMR2sxD4+tGVDb0qoXjIh1IynCCjjP7
         8+XWgaXldCcVSq66dGkY75IUNPwSlODZ//zBoM/Q8vD0OSxcKwuLPFxZZyxPfuOZC10F
         ns3QcebLYXL4jyuv7o6s/tiVNqrthklb8jxD57rfmVlSto42MsAyWOsu3eTpBIRmUmUh
         5m5w==
X-Gm-Message-State: ACgBeo1huL1JoFiL3yuYGnNwoWGbbWSi4hoq4Sd79GZaQHbs/qULK1mw
        uOionelHSOYfmO9btHUx9xPcdwzhpyM=
X-Google-Smtp-Source: AA6agR4Ppy4TlAx5Lt/45OnUgJ5yxX2999apq2x6zNaCId6+AMBNoDmW6LxkNrA1Ax704mp9y4OtGqUy/dg=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a05:6902:120f:b0:676:aaa4:8434 with SMTP id
 s15-20020a056902120f00b00676aaa48434mr20939193ybu.218.1662053742565; Thu, 01
 Sep 2022 10:35:42 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:34:56 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-9-surenb@google.com>
Subject: [RFC PATCH RESEND 08/28] mm/khugepaged: mark VMA as locked while
 collapsing a hugepage
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protect VMA from concurrent page fault handler while modifying it in
collapse_huge_page.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/khugepaged.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 01f71786d530..030680633989 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1072,6 +1072,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 	if (mm_find_pmd(mm, address) != pmd)
 		goto out_up_write;
 
+	vma_mark_locked(vma);
 	anon_vma_lock_write(vma->anon_vma);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
-- 
2.37.2.789.g6183377224-goog

