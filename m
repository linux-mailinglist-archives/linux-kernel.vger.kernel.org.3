Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC05A5621
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiH2V0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiH2V0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:20 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B5E8C470
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:59 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id m5-20020a170902f64500b0016d313f3ce7so6864671plg.23
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=TWnM2nl+IWV2Xsj5xnZFMNMq0JvYeydCw4P9njL7O34=;
        b=QxyTYU3FERVCw2VziTt0AktgHLl//+1LB6ej8pZ2s1TWfQT3cvsAWfnuU7caTHeT9p
         cUZ3ty459UM3cwcXwNVqpzu7fZxDdvEiQ7oppDRkd/R2+Ilj86/8iy+0q3ZJXoZ4hnye
         zLhHEgIO/fbjIHEiSfoXxsUyX6O+Z8dic5XVruk2KEpor5fjgGmf4uNln1+WOsbYbTO8
         1++i5QRJ3Dh2yxyVyOmY5Dm8Y1A3ze3Xt4uhd4NBeKcnHbK+ENDvs3AO4SaOBTp9Wi+f
         EGkkrDdrwisqruuTTVNnHMbKcZefZFlW3jnAC7mX9edrYOzqBxLpV3pgyWig/2c0mbAr
         sZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=TWnM2nl+IWV2Xsj5xnZFMNMq0JvYeydCw4P9njL7O34=;
        b=qfOf+APAbzS0pxkYmRjhl2XSWCmGK0n7PHkNW5n/V1FRvkRcHvSxVe/pp0s3XfjCbO
         UAV+XV36Kpfnxi9ZLwqpJ9XGWBRzqtfyRbFRvswHmS4tyZCuaEvvNHpB/GaqxSDbhEE+
         P7FSt+qQA0YgqICg+Rx1lvvpFux6EgrYbuGmOK7Besc6WAUVBSZ+juFBgAmGWw5qCUv1
         YQKUWcLvnLfZHAqbHKEkqxUIdLtq1Jg7uyuWDMYPngVQDYqs68euL3ZHPtQnUddeAxqM
         oFS73/zAcCJe+ZL1mVKUjBx+Vifkgr496qnItJItD1TaCYQDfgS9EGSqRyUYLMreuK11
         O1dQ==
X-Gm-Message-State: ACgBeo2Ka2o95WGiO3F/6X/U9ZaCTmq9ya/ZlszOUctY+CzEojWxP7xp
        NUgnfN+CftnjswHku7/52TcBEMmRp3A=
X-Google-Smtp-Source: AA6agR76cA5Bw6pPdfILXZxKwAftwtVJj++YaWYUCk6VRMlDSa2HJ+OTsxxi3Jretb4HksKEr9YwTk9TbU4=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:903:18b:b0:16e:f09c:919b with SMTP id
 z11-20020a170903018b00b0016ef09c919bmr18604991plg.135.1661808358173; Mon, 29
 Aug 2022 14:25:58 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:15 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-13-surenb@google.com>
Subject: [RFC PATCH 12/28] mm/mremap: mark VMA as locked while remapping it to
 a new address range
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
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

Mark VMA as locked before copying it and when copy_vma produces a new VMA.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c   | 1 +
 mm/mremap.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index ade3909c89b4..121544fd90de 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3248,6 +3248,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
+		vma_mark_locked(new_vma);
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		*need_rmap_locks = false;
 	}
diff --git a/mm/mremap.c b/mm/mremap.c
index b522cd0259a0..bdbf96254e43 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -620,6 +620,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 			return -ENOMEM;
 	}
 
+	vma_mark_locked(vma);
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
 			   &need_rmap_locks);
-- 
2.37.2.672.g94769d06f0-goog

