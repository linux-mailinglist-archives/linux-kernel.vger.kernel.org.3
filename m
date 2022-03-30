Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0704EBCBB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244338AbiC3IaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiC3IaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:30:00 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5EDF1;
        Wed, 30 Mar 2022 01:28:15 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id i4so17456964qti.7;
        Wed, 30 Mar 2022 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1H14edHrexPdZSsbFfB5+DKs6PQ4z+rHst+0leIL3Cw=;
        b=i7x2SIOEfBJv2Erzs9AxsTqiUf701YydhIxCj1fTKKaFN0qYV0gp/MQNT9h3UwXKRC
         xV3XDXqW2EXCiJT9G9Rx5Cfobn95y2WQGBxAbcWtdnQNRSrzwrgG8ehwxdMpmYdX6okR
         wGGjBO3V/Mjme2aJdXwoU4Yx/vJOx6NU6lYb44qpk9ECHH1Dd9Gg4GcoLI1B8DCz7/ed
         3yqMS0E+FdhP96QjyLPbuPbBHg5aAZnYXOwEShyTBpLqLf+hyOxLxTWPexM+xgI5hyk6
         kNGAhLDIDcfC1zu7pt05sUI+npHrSPPemlweu5duUlRSmEb0ZCjHtCGekZ+SiH6GbPfX
         YvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1H14edHrexPdZSsbFfB5+DKs6PQ4z+rHst+0leIL3Cw=;
        b=NyAHjcG7WyVE1/q6vDII3oJbgQ47gavSFLArRKvhu/jlvidkQHQ6PRi9/CCYJsh8pK
         tZpX0VjICHIssH4tWg0Cs34h/foYg3Jr4umG9RCCDmQHZn5e1K1U/XsewkC21SAxEYn0
         Y2kb4X92bvNiDxYJ+SBLQi1+ZWDBvcruLhHC+a9SmmYwdZIwk4lL43ANByYJCAosI37A
         jpaLmw/KTUqXbfs1vqh2wHkKd1mb+dgAMcCVW1uMNxihZIk/mYe6TPXD5VOrpM/oRLsK
         eBV3PLB2HnxYikRiwpuO+Ha/1Zliu54T/Wxdl+rjZp3DHKnA6IqW+AKIIkPFlFN0xzm9
         0DZQ==
X-Gm-Message-State: AOAM532BaGPKLhLIvrL6nka3+Qokttp/Ff/sA1lSs+zhxkw1ZA6YCg5G
        35kP215WSRkKO8dg6aOaVdQ=
X-Google-Smtp-Source: ABdhPJwRlfo0Y8TA4yle0PUfqmJwdRVeb7L11mlOl/AfeZ/BE1DHPAj/1gDlLvVv3D8gTQB9emF2UQ==
X-Received: by 2002:ac8:5787:0:b0:2e1:c837:64ed with SMTP id v7-20020ac85787000000b002e1c83764edmr31903754qta.98.1648628894609;
        Wed, 30 Mar 2022 01:28:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d11-20020a05620a166b00b0067e380258e7sm10403966qko.73.2022.03.30.01.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 01:28:13 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, david@redhat.com, willy@infradead.org
Cc:     corbet@lwn.net, yang.yang29@zte.com.cn, yang.shi@linux.alibaba.com,
        dave.hansen@linux.intel.com, jhubbard@nvidia.com,
        saravanand@fb.com, minchan@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH v4] mm/vmstat: add events for ksm cow
Date:   Wed, 30 Mar 2022 08:26:41 +0000
Message-Id: <20220330082640.2381401-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
to save memory, it's a tradeoff by suffering delay on ksm cow. Users can
get to know how much memory ksm saved by reading
/sys/kernel/mm/ksm/pages_sharing, but they don't know what's the costs
of ksm cow, and this is important of some delay sensitive tasks.

So add ksm cow events to help users evaluate whether or how to use ksm.
Also update /Documentation/admin-guide/mm/ksm.rst with new added events.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
v2:
- fix compile error when CONFIG_KSM is not set
v3:
- delete KSM_COW_FAIL event
v4:
- modify /Documentation/admin-guide/mm/ksm.rst. And let cow_ksm before
- ksm_swpin_copy, so if new cow_* event could add before cow_ksm.
---
 Documentation/admin-guide/mm/ksm.rst | 18 ++++++++++++++++++
 include/linux/vm_event_item.h        |  1 +
 mm/memory.c                          |  4 ++++
 mm/vmstat.c                          |  1 +
 4 files changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
index 97d816791aca..b244f0202a03 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -184,6 +184,24 @@ The maximum possible ``pages_sharing/pages_shared`` ratio is limited by the
 ``max_page_sharing`` tunable. To increase the ratio ``max_page_sharing`` must
 be increased accordingly.
 
+Monitoring KSM events
+=====================
+
+There are some counters in /proc/vmstat that may be used to monitor KSM events.
+KSM might help save memory, it's a tradeoff by may suffering delay on KSM COW
+or on swapping in copy. Those events could help users evaluate whether or how
+to use KSM. For example, if cow_ksm increases too fast, user may decrease the
+range of madvise(, , MADV_MERGEABLE).
+
+cow_ksm
+	is incremented every time a KSM page triggers copy on write (COW)
+	when users try to write to a KSM page, we have to make a copy.
+
+ksm_swpin_copy
+	is incremented every time a KSM page is copied when swapping in
+	note that KSM page might be copied when swapping in because do_swap_page()
+	cannot do all the locking needed to reconstitute a cross-anon_vma KSM page.
+
 --
 Izik Eidus,
 Hugh Dickins, 17 Nov 2009
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 16a0a4fd000b..74ec4b6a9ed0 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -130,6 +130,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		SWAP_RA,
 		SWAP_RA_HIT,
 #ifdef CONFIG_KSM
+		COW_KSM,
 		KSM_SWPIN_COPY,
 #endif
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 4111f97c91a0..12925ceaf745 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3339,6 +3339,10 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 	get_page(vmf->page);
 
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+#ifdef CONFIG_KSM
+	if (PageKsm(vmf->page))
+		count_vm_event(COW_KSM);
+#endif
 	return wp_page_copy(vmf);
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d5cc8d739fac..250ae0652740 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1389,6 +1389,7 @@ const char * const vmstat_text[] = {
 	"swap_ra",
 	"swap_ra_hit",
 #ifdef CONFIG_KSM
+	"cow_ksm",
 	"ksm_swpin_copy",
 #endif
 #endif
-- 
2.25.1

