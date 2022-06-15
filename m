Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB6654CFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349861AbiFOR3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349966AbiFOR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:29:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE8D45ADB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:29:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e11so12049417pfj.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQUColGb/PRKYuEV4lE8XSFjbzf2io5XZTvMnHxGXf0=;
        b=P5PSssOdjWY/xPZ7jddHeQPn8UutJ5m9TF+K4vzKHaQtM6cE/Mf+NE4GoAnGSxi3Io
         Y2LlfpoNzzarjkEPUOBBbK2VNLV6QvrkCU0YgZMxegJsia53STwh6Di/GzL3gsyqzoFP
         rUAxM+SHTD3Ks6z6Onsi/In0Mrk2HzetpwpKANFN1OqsGo2AHjr6/haWrWg2TS12egTu
         1PKdIZyzPNk09Cs6fGAidY2XEJ/VqNbV78o1QLo7kcwS7nDaVKeKv77VuBXpQHOqqTvl
         KFl4JRX1TJx3TG4Jb+1vv779H0J6hBCcUH2+m3wdmfheRWs69YXkaQK77FyCnII6PT7d
         qqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQUColGb/PRKYuEV4lE8XSFjbzf2io5XZTvMnHxGXf0=;
        b=QanER3wHNGcdcSBqsvIEpwmZz/dVF4GWaYln0rnml30fGCMtlymuNtOqtQeVlvUOjy
         vuATArUKpXSKkSS8EOfXO/WqjoodzlSMPMXvloo35gC9RkUTyVrMPlahd+apLzbqQ3WY
         Kv7ZzM/1032OCiT3zaqxaS4mozrY/HvlZHaPwKlFPAjGnMnC8oGejFDPQqXaCHLaYABt
         cDx2LlXOkUfXaPKmIRymgDSirPVJVAns3TWLF95ZYIRYtlFbApnlTPf4gXu4UkHRWh8J
         WaDk8WHdd96s0tHf4yz4DzLgtOjPAlfavidcdcmJtogOPYcusDWjefi8f+ZTuaBr47fw
         4WjA==
X-Gm-Message-State: AJIora8WLbYUYCHw0HU7dcJoOVDp+UeEvzMdL5armqpQSdWe9KKOQ8gg
        BCpNa4effXdBRpipVy27BNKFANZE6FY=
X-Google-Smtp-Source: AGRyM1s1Cazz5Rcz0v51mDmvba3KC32sP5s7r0OCDu88q+Oc50uuWQFdSzmqKeUrPH3UKttvAQA9+w==
X-Received: by 2002:a63:ec0f:0:b0:3fd:e23d:b9f9 with SMTP id j15-20020a63ec0f000000b003fde23db9f9mr747614pgh.612.1655314174419;
        Wed, 15 Jun 2022 10:29:34 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b001676f87473fsm9552244plp.302.2022.06.15.10.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:29:33 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 1/7] mm: khugepaged: check THP flag in hugepage_vma_check()
Date:   Wed, 15 Jun 2022 10:29:20 -0700
Message-Id: <20220615172926.546974-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220615172926.546974-1-shy828301@gmail.com>
References: <20220615172926.546974-1-shy828301@gmail.com>
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

Currently the THP flag check in hugepage_vma_check() will fallthrough if
the flag is NEVER and VM_HUGEPAGE is set.  This is not a problem for now
since all the callers have the flag checked before or can't be invoked if
the flag is NEVER.

However, the following patch will call hugepage_vma_check() in more
places, for example, page fault, so this flag must be checked in
hugepge_vma_check().

Reviewed-by: Zach O'Keefe <zokeefe@google.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 476d79360101..b1dab94c0f1e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -458,6 +458,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 	if (shmem_file(vma->vm_file))
 		return shmem_huge_enabled(vma);
 
+	if (!khugepaged_enabled())
+		return false;
+
 	/* THP settings require madvise. */
 	if (!(vm_flags & VM_HUGEPAGE) && !khugepaged_always())
 		return false;
-- 
2.26.3

