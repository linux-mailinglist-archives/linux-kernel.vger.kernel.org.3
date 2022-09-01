Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F875A9E28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiIARhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbiIARgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:36:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F3931F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:35:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-335420c7bfeso234906047b3.16
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=SOzt98PYJdog9tZtODUdaF02HJMaRj5G7nUIc+/7MKg=;
        b=kTPvKd0Pj/2ICi2JaJbj4mvw83rGSI8D/7SpSALxOaZxZxYULx54dkMykzJllj/oUS
         acc8cAwohzpv9TG/117+M7kDarZ4pbcDRJw9kbqISJMHllJVQJpNPTnmGZHaFtdhW7jV
         te5Y1eTVCGFOLeMRtGhakQSv/C95dQTatvR3jNPFepOpi9BM4A2IDo4sHrk/Ld/IusAA
         C91XyLoa1Kj543iPIZk7cC0y8cEUyAun26iVaV/jukaSDh0nNNy3USNMwmiwPC/u6rrR
         uYxoBw75emQZr0TAylDwoEOSkfchxb9rhKIYoM9w58cv+ILGWIFbRnVoqe89UuzvgGW7
         /7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=SOzt98PYJdog9tZtODUdaF02HJMaRj5G7nUIc+/7MKg=;
        b=E6hWTYeA23lEVeeNmiQ4/DHYzrTxGs/c6xwk7uX3LvJrcfrQQ+3mxseErXXfwPy0GT
         9AkyhQonYfvIy8VNqgwmrrFEpWOXkoK0gZXFhNM3IuPdNpPRG4lKLU45SuSs0MOv6Tq6
         EQLhsFrggZXOmSu7mH/Z51eCL/DuB2iETsFBUjWze0MwqkI6fdcik5nHiBI3Q/xzvnoO
         1jmULgoqLm3Vf2X/bhnfYHGScI1juqHEwvUdtr40KTX669vRFNaNg1aA1n/VgyDZHKYS
         8u3ErqL/DCQMR7oFg+g+/CN4FWqLuXmElIogTBz7u4bzitCWkFexyNORIbopJgctKb2I
         GuGQ==
X-Gm-Message-State: ACgBeo21lQmTvRY5l5dhSiuwA1zfKB8vwSNfRZAXUcjlFpnMxUKBm0ve
        Uv+dGF0WPZUkRH2Gmq0mc9WhHk6Vl8I=
X-Google-Smtp-Source: AA6agR6YY4L9oqUniRiEloavxF9b7QDLSzaw7mgfeu4Gq//fIM/XBjFxGsDu3HVa5YMmDCpCvrS70nu4RUs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a25:3746:0:b0:69b:a100:521f with SMTP id
 e67-20020a253746000000b0069ba100521fmr16650279yba.135.1662053753176; Thu, 01
 Sep 2022 10:35:53 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:00 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-13-surenb@google.com>
Subject: [RFC PATCH RESEND 12/28] mm/mremap: mark VMA as locked while
 remapping it to a new address range
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
2.37.2.789.g6183377224-goog

