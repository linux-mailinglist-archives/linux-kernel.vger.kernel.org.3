Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5A853BDFD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 20:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbiFBSWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 14:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiFBSWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 14:22:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB5CA1BC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 11:22:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so5495461pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 11:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TeR+saO9bGVSVDYLkT6whuJkztc98Y7uqJRw9Zwr6CA=;
        b=lox+mE5DUQIYDSINDMGLvp+f+4p6bG1alTdnY/p5yaPQT5MhcSCKJI+8s/kk/vYrgz
         FmcQS7G4CMRDlFwl2en89XVTfwF/hAIbYQkKoMHAdDWhFIaHkqtdpSXvA6PBc63CpxCI
         QdpyQZOXfOltvUHMi4sMlFeaVN4KN8g5IAllCh/D2rckkxATCgwcej4OmeqCVYOwgUG6
         Hp6eQFXuIu0CX2Z+YMXbCI3f+zfr9qllgXYuEBQxqBuLFGxngc/1cMy4KaQscxiRzwMg
         gUYcE+aF5Qyi06JBD45s6qomtBFmAr3AdtDn3TQFbQkrcOfkcvp4efLZuD1aC1dcrnxH
         AqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TeR+saO9bGVSVDYLkT6whuJkztc98Y7uqJRw9Zwr6CA=;
        b=XXHYxXMNHRpe3TGiAt3gY3tHW+LK195YBJdOMRELtK0oaTOGRKQPq4saUGEso9A4nq
         EODAo3rBWr39wQ/RiYrjVVhIzRz2qoEwOskeMdArlD/LNcfEa9QoliaHoHeV5hH6VcfA
         ilq2PdTiKk7eAFxOQc+nf1+VZnsAjiibn0J7Flx15Dtna7M9gQzkyWje+DWK7Ym9zS3G
         K2li2z/4BeHgdHSPnuz9GCaRtk5QUyMEQ+pTNhzqL2LSlAwmi+oqHTZPcHX+WjnIHFr1
         m1IM/qDX5pYUbbqlMdg6p+iLj/SN6BEKCN0PBqWpxAtfn5QYf8wM2ua59VPjeUYtgbpX
         wPSA==
X-Gm-Message-State: AOAM530oEv6IbcTpJdpVxDM1gDoYefrmC5ZLAIRUvTiWz1esWhui5n6d
        Q/526T6zxGS9akFUOKflyiMgJiPKrOI=
X-Google-Smtp-Source: ABdhPJwUloxNPQ1Kt3swhvWRsLalZE4j17qsysUEVMeRb96vd1+i3T7NbIkG0a3KYeFbHoyp7u9MwA==
X-Received: by 2002:a17:90b:3b4c:b0:1e0:3354:5e5d with SMTP id ot12-20020a17090b3b4c00b001e033545e5dmr41812977pjb.239.1654194127979;
        Thu, 02 Jun 2022 11:22:07 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709027fca00b0015f2d549b46sm3866779plb.237.2022.06.02.11.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 11:22:07 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 3/7] mm: khugepaged: remove the redundant anon vma check
Date:   Thu,  2 Jun 2022 11:21:55 -0700
Message-Id: <20220602182159.248387-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220602182159.248387-1-shy828301@gmail.com>
References: <20220602182159.248387-1-shy828301@gmail.com>
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

The hugepage_vma_check() already checked it, so remove the redundant
check.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d0f8020164fc..7a5d1c1a1833 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -966,9 +966,6 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 		return SCAN_ADDRESS_RANGE;
 	if (!hugepage_vma_check(vma, vma->vm_flags))
 		return SCAN_VMA_CHECK;
-	/* Anon VMA expected */
-	if (!vma->anon_vma || !vma_is_anonymous(vma))
-		return SCAN_VMA_CHECK;
 	return 0;
 }
 
-- 
2.26.3

