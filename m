Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4825D5B0C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiIGSDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiIGSCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:02:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2434CC00E0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 11:01:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pj10so4873669pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=eU/KWFZN5UecQ8lbzprnvq1q98iyrbbNqlvylwkyiHU=;
        b=GtwBMc6EL/iXg66DLvtx19O/9lfPfRbzA8mc4+Xi+LrbcSCdAPV5vLH4lpomv4ciNM
         fIYzkt3IS2BPGL2ih6bmDimjFB5SB4q2SuKHQwAlcbzYHpoVNaDYxuZdsVuFFX/3T/Uc
         YXF7Rny2ZEEGby9c57HmCFy9pg3z5r8m4VTNcZVG97Uv8KyUzy/Bnxo5Um52ZTTyeAVW
         G0qCz8OCaLUh7ICyMGSrI1Jh/Jswa1I086oJypMirhyA+vvor74uUAxXhbsk+gINCKbU
         HC9fT6qRKh58VoKTe1FnhEu84oA7FZip2zriqLGw9iKZGl+voSYJs7XVmVRxS1swZU7R
         JKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eU/KWFZN5UecQ8lbzprnvq1q98iyrbbNqlvylwkyiHU=;
        b=bIcvrTLw3xkn8KF29Low6MY1PgzFdjRMFy33e+T/Xn04lJmiu0GKmufC2tH1wGCTIl
         qiM6DSEE1+p4h3E3yKx70HigESYPEt9X3fcaU4VZP0Ud/vbO7ko0Q9wEeCFj0bY23DtD
         8Mo9PJ9IrOsjN09BNvU0oDjMQmXQkrLRAi6wQInC1sZGYn0rNlrpv+E03C+X9FKetqBn
         dwxmqZhB3JoQnCedB5YucoAjDcDvWtFjfiiSOhSIScVXKvCo9G1gzKwaeQvTJhpZBjBa
         CX9vTqlGhI/pt6754P9MCK2Et5kULOfMwyqNgTyMZd5UzKTvn6fHITILwFdQHJudI129
         V9kw==
X-Gm-Message-State: ACgBeo0ZWaCSyiDdq3fmWjkxtVANUYvo4HD3x12y8LKjaHrtKs38gY9N
        YQHI050e9gv1vTwGlPEjnz4=
X-Google-Smtp-Source: AA6agR4jQu9kTFMCgKbNUddUbVeBrjOtp6VteymiGZOmYpTK0JnXVpNi96p1AWx0nYhR3UmigAXkAQ==
X-Received: by 2002:a17:90a:d150:b0:1fd:9336:5db3 with SMTP id t16-20020a17090ad15000b001fd93365db3mr5322933pjw.242.1662573709955;
        Wed, 07 Sep 2022 11:01:49 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e85100b0017312bfca95sm12801664plg.253.2022.09.07.11.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:01:49 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     david@redhat.com, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, jhubbard@nvidia.com,
        jgg@nvidia.com, hughd@google.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/2] powerpc/64s/radix: don't need to broadcast IPI for radix pmd collapse flush
Date:   Wed,  7 Sep 2022 11:01:44 -0700
Message-Id: <20220907180144.555485-2-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220907180144.555485-1-shy828301@gmail.com>
References: <20220907180144.555485-1-shy828301@gmail.com>
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

The IPI broadcast is used to serialize against fast-GUP, but fast-GUP
will move to use RCU instead of disabling local interrupts in fast-GUP.
Using an IPI is the old-styled way of serializing against fast-GUP
although it still works as expected now.

And fast-GUP now fixed the potential race with THP collapse by checking
whether PMD is changed or not.  So IPI broadcast in radix pmd collapse
flush is not necessary anymore.  But it is still needed for hash TLB.

Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 698274109c91..e712f80fe189 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -937,15 +937,6 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
 	pmd = *pmdp;
 	pmd_clear(pmdp);
 
-	/*
-	 * pmdp collapse_flush need to ensure that there are no parallel gup
-	 * walk after this call. This is needed so that we can have stable
-	 * page ref count when collapsing a page. We don't allow a collapse page
-	 * if we have gup taken on the page. We can ensure that by sending IPI
-	 * because gup walk happens with IRQ disabled.
-	 */
-	serialize_against_pte_lookup(vma->vm_mm);
-
 	radix__flush_tlb_collapsed_pmd(vma->vm_mm, address);
 
 	return pmd;
-- 
2.26.3

