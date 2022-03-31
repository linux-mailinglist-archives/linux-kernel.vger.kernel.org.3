Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5444EE01D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiCaSG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiCaSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:06:57 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FDB1B9885
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:05:10 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id h189-20020a1c21c6000000b0038c8655c40eso150599wmh.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=15hcCIpQC0VqBDHPsAp6yPhi35cw6G3wETqd2cbLIoY=;
        b=Wc1HwmentiHv/fZuGFoLTitGkoma0Q5v01UFXMR7/jicGlIN4bTu6dLbZZcrqP/mdO
         SHe+9LAq+3wxREIb8cGnq4EXg+wo0+q+w+6NGCQCeXBvjbMoHmn1VFYqgXwX9U+R2dcx
         NTuUV3WQHqsFt3JmpdPEYvhVbviL1S+ED005wJ5tY26C+RHq5feJBxI8Th8BsWYX7NiC
         2Z6sJ6fxESSv2NFx+jRbtvHoDBgNlzpgKSeW1zxNiZVe9pjyNYn5QWUJqdteJvw9QNeu
         d66rz+8umDoB55OjgrpYOKIZ/VTaXlkGoA8ugqBbXi415tGEdkYA2IcbG3R2BfazgfMr
         BG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=15hcCIpQC0VqBDHPsAp6yPhi35cw6G3wETqd2cbLIoY=;
        b=cFRogckj7bwVNeFri/Vwj9g7Fi21PbEHrTsrQddJD8Y594CMZwAzUGXFFtRgUxD8Ma
         7fyeVuank8AI5t/QhFGC5sCww4owCFXdLyqBwoADY47M8bqHYeor81h9aqjm5lcd9rFM
         iMCPljMPY1xp4G762VmjdiXe6PQ1kA5KvlDWErAbIXh5K1RwKXhWG7Pp3evsxY+/PNwO
         +wuaWBsW2aMMHXQHSgn5e4obF3oqFRYHqBfFR3rjHewEpbSiKuF/GJayfjgJ0AgwNFsa
         AsTgMZtm6IOzBfHpXf7HZZDPT9eOKjDYUUUJjZ2T+NFW+ZncoQJJpAPG5rdbn6Ne9HBq
         ecVQ==
X-Gm-Message-State: AOAM5330hWK4bvDBsL38zcOCdHJAE5ddzjjUMStPj9xPGzLo4dRdRtbk
        feVOH4bF0AkrxejmcsWw0wdeR8ecq1I=
X-Google-Smtp-Source: ABdhPJyIkd32mBAt+ICL2+5Bry6jgZsgBb55VJ3mAd28zIkHSit68TD3B8qhMSxBXRQ3kjL66+0lM8MZid8=
X-Received: from nogikh-hp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:200d])
 (user=nogikh job=sendgmr) by 2002:adf:f78e:0:b0:205:85d3:fa33 with SMTP id
 q14-20020adff78e000000b0020585d3fa33mr4966519wrp.675.1648749908645; Thu, 31
 Mar 2022 11:05:08 -0700 (PDT)
Date:   Thu, 31 Mar 2022 18:05:01 +0000
Message-Id: <20220331180501.4130549-1-nogikh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH] kcov: don't generate a warning on vm_insert_page()'s failure
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
---
 kernel/kcov.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 475524bd900a..961536a03127 100644
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
+			pr_warn_once("kcov: vm_insert_page() failed");
+			return res;
+		}
 	}
 	return 0;
 exit:
-- 
2.35.1.1094.g7c7d902a7c-goog

