Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CF954E8D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbiFPRtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiFPRs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:48:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09C33ED23
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:48:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o7-20020a17090a0a0700b001ebad897457so1015301pjo.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVDYrUdqiRm9UcRbpXweUBj4/hDRVoO4CK1KpBPozys=;
        b=YoZ1bssMZl0ds5wLwIPKg0IItqCPaKU17iyetjJF+hT+7KvhMVimEkgRt95TZkLAxO
         FnqS18PmPzsWKkIght4RbuqwygilGASy2GLKqKg6k/vzT6t+DtM4UxAQl5b7P9A3TNNf
         eNO3UdSwBlFGrUig73CtXZrfbbh+sfQ3yu/6CT/tziWSALK5brivuz9r9Oul1PmCzrfZ
         vwzv81Kzs6hCvJuSzDap1wEz3A/BmNXbZucyPTub2avd33WiHFdjm29e8KsZtbG6Ob56
         R8nESRo3DArWhf+2Xo28r7HWLmRlqKlf75OJ1nRX8ig9JYoj6D/6DI+3HTWP9r+gSf7n
         AW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVDYrUdqiRm9UcRbpXweUBj4/hDRVoO4CK1KpBPozys=;
        b=fAxnUT3pQhUL/BqM7oEfVsrGILpoB9jRYSJ21l0lmNvFEFvcA34rXWhsW2LOazWNug
         LltnyDY00IqhsTTtV0e0I9eeCTL8yPgkCrenobQc/W40x4xFSDUc+qqIkr/S3DkA8oIH
         ecYp7aWV6KSDnlchfDPiGWDYuEUdklvqS/MI7AreFY+a4irJofgsBEHQPSQm/FQ6LM/Z
         gAm9rLRHeg10dHeDR1cRQxJl667cM3f8c12OTTOY+XTQjHM/ntfaNRux9PThXyCxhp/C
         sQsG5YCYubz0Ek9tX8hnf5BySHhFUqAhNZwaQHNzgQMTWkoHXRxG7f3cPIy9jX1DYZFI
         w1hQ==
X-Gm-Message-State: AJIora8IHb2PHcKkV7PxZMv+JWN9DMkoHUQ99r0Wa83k3rMer2WU8agg
        H4a5T2h0iBzuGrQmkzDWl0Q=
X-Google-Smtp-Source: AGRyM1vxGK17GWzftPYeur/8Me6GEPOXRVJXvmUbi9GWcVUiu6WhWb2FJDsYzyvI0N7smHaYh/uyEg==
X-Received: by 2002:a17:902:c403:b0:167:4a9f:2799 with SMTP id k3-20020a170902c40300b001674a9f2799mr5716030plk.56.1655401732435;
        Thu, 16 Jun 2022 10:48:52 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090a8b9500b001e8520b211bsm1818289pjn.53.2022.06.16.10.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 10:48:51 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v5 PATCH 3/7] mm: khugepaged: better comments for anon vma check in hugepage_vma_revalidate
Date:   Thu, 16 Jun 2022 10:48:36 -0700
Message-Id: <20220616174840.1202070-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220616174840.1202070-1-shy828301@gmail.com>
References: <20220616174840.1202070-1-shy828301@gmail.com>
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

The hugepage_vma_revalidate() needs to check if the vma is still
anonymous vma or not since the address may be unmapped then remapped to
file before khugepaged reaquired the mmap_lock.

The old comment is not quite helpful, elaborate this with better
comment.

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index db0b334a7d1f..5baa394e34c8 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -960,7 +960,13 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 		return SCAN_ADDRESS_RANGE;
 	if (!hugepage_vma_check(vma, vma->vm_flags))
 		return SCAN_VMA_CHECK;
-	/* Anon VMA expected */
+	/*
+	 * Anon VMA expected, the address may be unmapped then
+	 * remapped to file after khugepaged reaquired the mmap_lock.
+	 *
+	 * hugepage_vma_check may return true for qualified file
+	 * vmas.
+	 */
 	if (!vma->anon_vma || !vma_is_anonymous(vma))
 		return SCAN_VMA_CHECK;
 	return 0;
-- 
2.26.3

