Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0784F4EE9E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 10:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbiDAIpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 04:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDAIpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 04:45:30 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B221028
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 01:43:38 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id o10-20020a1c4d0a000000b0038c6e5fcbaeso886148wmh.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 01:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cRmPyw1GBLL8aytQSQtFb31y0EvOTxlHrPZR5cT2j5s=;
        b=NBeky6Jc7NCL1W8rQHYkeLZ7nAxICvgRTsb0x1+8Goejcx89xP3rduQy7iAQN51Uno
         +K7dyLJBj7Fo8E7pmSjPu/ux81xWF3AeNcNAJ/dhFZ3AFVU1UrqseYlhwBxqm939Sv0F
         esJLUA4JTGDJavave5jcpeTHVggckvzJ554j+Zf/43G+sv3o1SDhpxxCHuWGa1YOKfot
         cfNPD3v+qdyoXaWHcsP7fLgM6y6+ZFLV8maHhYXUYBrl2RyHuMtN46sP9/RhQHGnpwpy
         PTTK82zTyUR6OkVBsXEfpBo9A6wzePWURq4F0+ydejGM8jL3h20VTP5rC27aA+FNDTUM
         sRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cRmPyw1GBLL8aytQSQtFb31y0EvOTxlHrPZR5cT2j5s=;
        b=OTdA6feXpAQNs8/Sjn4GtF5LVJXDJlGSA0ihJY/nk+27p8UsdVI0CisI58yf2omczq
         9k+fh1CB5akFWJapvT1F4ECGD1OBQoVxjF7VulZpZUGyeZ+TWFks5TjiTno8C8XFNEKa
         1tgzPN6oma9hH3L7H3+dtdYusRWVRplpV+9GWD5xO/1ktqH5K96g2I+KfcRAvSA+E0Sh
         ik7NoC5PNG3/u7EqmdENcZTcBmB3OMiMbK3mdoT0yBh7Z8QA1kMjtN+e36bVfqz5CI0l
         hsonvRh3A3uK1s+J9eqkAiybuw1z71Vd7t+5GZ471sXVtCPnSI6aLzqSDHsSfjduM1aX
         4B1w==
X-Gm-Message-State: AOAM531Z16A67/xHu7CLCsta52Nz9JyDFtg1Q8SV4fDnEq3nOga0P6SH
        6BtDhtxwSBPhybVb6Z/S8S7k4BUnIFM=
X-Google-Smtp-Source: ABdhPJzq80Z37tgVjIvfIzmx98HPrYV9U/3uBXjysLACE0Y665iIcnJuGYrAOnhRFY9x0CLjpdOCWsFL2tg=
X-Received: from nogikh-hp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:200d])
 (user=nogikh job=sendgmr) by 2002:a5d:55c7:0:b0:204:5ff7:74e2 with SMTP id
 i7-20020a5d55c7000000b002045ff774e2mr6876908wrw.50.1648802616396; Fri, 01 Apr
 2022 01:43:36 -0700 (PDT)
Date:   Fri,  1 Apr 2022 08:43:33 +0000
Message-Id: <20220401084333.85616-1-nogikh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v2] kcov: don't generate a warning on vm_insert_page()'s failure
From:   Aleksandr Nogikh <nogikh@google.com>
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     dvyukov@google.com, andreyknvl@gmail.com, elver@google.com,
        glider@google.com, tarasmadan@google.com, bigeasy@linutronix.de,
        nogikh@google.com
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

vm_insert_page()'s failure is not an unexpected condition, so don't do
WARN_ONCE() in such a case.

Instead, print a kernel message and just return an error code.

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>

PATCH v2:
* Added a newline at the end of pr_warn_once().

PATCH v1: https://lkml.org/lkml/2022/3/31/909

---
 kernel/kcov.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 475524bd900a..b3732b210593 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -475,8 +475,11 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_DONTEXPAND;
 	for (off = 0; off < size; off += PAGE_SIZE) {
 		page = vmalloc_to_page(kcov->area + off);
-		if (vm_insert_page(vma, vma->vm_start + off, page))
-			WARN_ONCE(1, "vm_insert_page() failed");
+		res = vm_insert_page(vma, vma->vm_start + off, page);
+		if (res) {
+			pr_warn_once("kcov: vm_insert_page() failed\n");
+			return res;
+		}
 	}
 	return 0;
 exit:
-- 
2.35.1.1094.g7c7d902a7c-goog

