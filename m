Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5134CCC96
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 05:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbiCDEh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 23:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiCDEh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:37:27 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BA017EDAD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 20:36:40 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id j24so6801723oii.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 20:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=ubRT/I2CUv/CzU15sag0BpLExw0Z36MhxpinxaZMddo=;
        b=YugMkUli8LsdB9nS9HQQQosFcFUTuoqbdLGjwTuiOUuwjBA5Sp2FiTvHOlv8NwcSV/
         TJjcptFoAXLc9DKWb5AIuNzuGcI80pdxp0yOMjcQazOLY0PiRncTn0z6NtoTFm2BDDwp
         ZlHMnYBowB22BPxfNxxwxr4gejxB4xnxJnTsduKgWKc1H7TzYmqfaBIThrtCOL6l9Td3
         bjQbsvh5d13H9MgTwUgiHIkkWiplOGhXXmsYURs3ybPJou9WvzRsJ/ggf96v06xC+yFg
         KZnCbkIpmJOai64bQCC1jNEbyZlKWsZ1e3QAOymaAUq5EuDJXIm45gTp12/gei6J8CrD
         fmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=ubRT/I2CUv/CzU15sag0BpLExw0Z36MhxpinxaZMddo=;
        b=pYhMD8W2ViuhxAl5FRFGIEwjcCQ6c2ka/17w7LVbbp8PZiCzPipjk73HkWvUgLc/eq
         Njl0n6ou6opopfmSMRTRXP17eZy64Xjb8mI/MTMULg2BBvN1pxfANwKwJPcKGXSF+mQE
         XUf9iY27xB713BaV6xR5Uj5U+ggY+jAKRbDEk9tkiHX3Xb1Y+TaBsPm/O1JpNyiaDumF
         iJDD2vWwhD97CrQwWkZnL94zHFMolYROpRFkiWI4efPJfRmqxCabhQyaX6SZYuDjOQ0c
         uzLPuTzFc2DGx1GCs5x3w5m1kGYSbbEUv+b1+xK8uV+ywXg6nT6WIBegX1HnZdmEQ6Jy
         RB1Q==
X-Gm-Message-State: AOAM533g2HYbdnAZKMs9zkINPwO4n1TGRtJrBd+mVkv97Bz8SPksPYw5
        kd0MjM4swPD/Axgb0cDb3/9Ejw==
X-Google-Smtp-Source: ABdhPJzDzlnRtq19dk5gPif9sFxsnduzhWmgwCGwUxyPHc1RvGhdM80t5mtiNsm/vCrKANLzMTSpqA==
X-Received: by 2002:a05:6808:308f:b0:2d4:c4e4:9a66 with SMTP id bl15-20020a056808308f00b002d4c4e49a66mr7480347oib.50.1646368599319;
        Thu, 03 Mar 2022 20:36:39 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i3-20020a056820138300b0031c0d227905sm1829839oow.19.2022.03.03.20.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 20:36:38 -0800 (PST)
Date:   Thu, 3 Mar 2022 20:36:37 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Oleg Nesterov <oleg@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
Message-ID: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2.6.34 commit 9d8cebd4bcd7 ("mm: fix mbind vma merge problem")
introduced vma_merge() to mbind_range(); but unlike madvise, mlock and
mprotect, it put a "continue" to next vma where its precedents go to
update flags on current vma before advancing: that left vma with the
wrong setting in the infamous vma_merge() case 8.

v3.10 commit 1444f92c8498 ("mm: merging memory blocks resets mempolicy")
tried to fix that in vma_adjust(), without fully understanding the issue.

v3.11 commit 3964acd0dbec ("mm: mempolicy: fix mbind_range() &&
vma_adjust() interaction") reverted that, and went about the fix in the
right way, but chose to optimize out an unnecessary mpol_dup() with a
prior mpol_equal() test.  But on tmpfs, that also pessimized out the
vital call to its ->set_policy(), leaving the new mbind unenforced.

Just delete that optimization now (though it could be made conditional
on vma not having a set_policy).  Also remove the "next" variable:
it turned out to be blameless, but also pointless.

Fixes: 3964acd0dbec ("mm: mempolicy: fix mbind_range() && vma_adjust() interaction")
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/mempolicy.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -786,7 +786,6 @@ static int vma_replace_policy(struct vm_area_struct *vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
-	struct vm_area_struct *next;
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err = 0;
@@ -801,8 +800,7 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 	if (start > vma->vm_start)
 		prev = vma;
 
-	for (; vma && vma->vm_start < end; prev = vma, vma = next) {
-		next = vma->vm_next;
+	for (; vma && vma->vm_start < end; prev = vma, vma = vma->vm_next) {
 		vmstart = max(start, vma->vm_start);
 		vmend   = min(end, vma->vm_end);
 
@@ -817,10 +815,6 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 				 anon_vma_name(vma));
 		if (prev) {
 			vma = prev;
-			next = vma->vm_next;
-			if (mpol_equal(vma_policy(vma), new_pol))
-				continue;
-			/* vma_merge() joined vma && vma->next, case 8 */
 			goto replace;
 		}
 		if (vma->vm_start != vmstart) {
