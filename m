Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7F4E5F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348413AbiCXHBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348292AbiCXHBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:01:01 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0278653A79
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:59:25 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220324065923epoutp03c9c0326ef82f10443d0dd296891d4612~fPuoLbpgJ2259122591epoutp03L
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:59:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220324065923epoutp03c9c0326ef82f10443d0dd296891d4612~fPuoLbpgJ2259122591epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648105163;
        bh=u2PvZFuDuPIcIAY1hJK/XTTeOGQZUldkV5e7lNDxAA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L3wXxW+6VhA7zj1NSHXfo5YgmI9n4AmSo8KRHuBwd/9veg2/bRKJE6y2XigLDEntJ
         5MT7NQWB2KF32mhDPP3PwIdTsIVOXcThu1IiA8vhPV3VrAu8f1JPYIkZwA+mwHk+OV
         nNfj2tqVqDki2W/r+vPEwHIQLnYyA43A4+cCBqEI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220324065923epcas1p2f77068faaac78c1d5d75ea1578fb839f~fPun0Z66l0552505525epcas1p2Y;
        Thu, 24 Mar 2022 06:59:23 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.249]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KPGL14rDzz4x9Q8; Thu, 24 Mar
        2022 06:59:21 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.5E.21932.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epcas1p46b5381b1b839d7076673c23e8f9b0bba~fPukhRbUE2719127191epcas1p4f;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220324065919epsmtrp1b9d08e69937ca6837a40816657b753d2~fPukgfiBF2225322253epsmtrp1P;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
X-AuditID: b6c32a38-93fff700000255ac-09-623c16c77173
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.AD.03370.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epsmtip2b1517ebb1eed97e0ddc2f6fd2c2abfa1~fPukYUhQY3186931869epsmtip2d;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH 8/8] memblock: print kernel internal size
Date:   Thu, 24 Mar 2022 16:01:58 +0900
Message-Id: <20220324070158.22969-9-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324070158.22969-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmge5xMZskg08/LCzmrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
        Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKzAr3ixNzi
        0rx0vbzUEitDAwMjU6DChOyMm692sBRslKg4e+EVcwPjH6EuRk4OCQETiU0bZrJ0MXJxCAns
        YJSYPvsrK0hCSOATo8SGTnOIxGdGiXuz77DDdNxde5MZIrGLUWL2hnOsEM4PRonPvx6ygVSx
        CWhLvF8wCWyUiICdxLfZB8CKmAW6GCUefDjIApIQFrCUWN+8lBHEZhFQlfhy9AAziM0rYCux
        7nIbK8Q6eYnVGyDinECDVi45wAgRv8cu0ddtB2G7SLS9vMoMYQtLvDq+BepUKYmX/W1QdrbE
        05NHgGo4gOwciYYNshCmvcT7SxYgJrOApsT6XfoQxYoSO3/PBVvELMAn8e5rDytENa9ERxs0
        4NQkWp59hbpRRuLvv2dQtofEx61dTJAQmcgo8WHaC9YJjHKzEDYsYGRcxSiWWlCcm55abFhg
        Ao+v5PzcTYzgJKdlsYNx7tsPeocYmTgYDzFKcDArifDev2ydJMSbklhZlVqUH19UmpNafIjR
        FBhyE5mlRJPzgWk2ryTe0MTSwMTMyMTC2NLYTEmct3fq6UQhgfTEktTs1NSC1CKYPiYOTqkG
        JsfoDOFwVVWVivhHqx18E50415VrL1y2+vM27yu/+nmObH1hteaDe6ZLgWXZxJOzBHx1tWvn
        yy332LvowNbcc+f7+9Im3eD/ZrT4VtjrjfMP7O0MurJNZNqG0ANvg2czt8yYuOGN2q7OSWqb
        PPYzS31UMGBU9L/Z0lB4o7jS88SiD62zZ69j3cClJOHS6Dtty8HiqHbDnavWZK2Kif9dkteX
        feFcpWvrujlLJ7rd8Pmr7ufUva9Kga95lezvpR/4nXf5LVD3WR10Pstv0b73GY4HPqwIcdh8
        r+9y7rNFSUbTJnVpB7wNdD3ilKCRvLJ+bh/jBu31yVqmc3YIKv8pydwueJrx0uMdRdJTdbk3
        7VRiKc5INNRiLipOBAASUyWX+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvO5xMZskg5knlC3mrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHsUl01Kak5mWWqRvl0CV8bNVztYCjZKVJy98Iq5gfGPUBcjJ4eE
        gInE3bU3mUFsIYEdjBKfflZAxGUk3px/ytLFyAFkC0scPlzcxcgFVPKNUWLWn2eMIDVsAtoS
        7xdMYgWxRQScJDZcWc0CUsQsMIFRYuWyTywgCWEBS4n1zUvBGlgEVCW+HD0AtoxXwFZi3eU2
        Vohl8hKrN0DEOQXsJFYuOcAIcZCtxNmTB9gmMPItYGRYxSiZWlCcm55bbFhglJdarlecmFtc
        mpeul5yfu4kRHJBaWjsY96z6oHeIkYmD8RCjBAezkgjv/cvWSUK8KYmVValF+fFFpTmpxYcY
        pTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwccodKFf7cSTBtm377f9ynmfup9TkdX9h
        lY46cdj41Z4HHKmt9cE+M97n3j1cc+lMylaZHzpRpqJrzHhCljVoHjl8ZauupPu6Pulb3Cbz
        L7zSrvRfUbvkvbQ/72su50+v7zPqmcrbWzF/0exZbBex4vKJB/vMVZk+JMlOiNmr++BmJs8l
        6813g1q3vMvuEutIPsLsZlrj9Ef6/Qy5/ivvQ+48NrxZoLF/svaZ0y5rOy4ea3tbY6BdtlJx
        6wydqH8RbxY07jn9akLwGSlRq1UFjt+3bbh9VrDiyYO8g4snBvCUywvM6a/KZUn75y+Wyd07
        yXjSlSNP50p9lv4tKzr/wGYhSUV7Fn51w13vzlyUUWIpzkg01GIuKk4EAEzqEgu3AgAA
X-CMS-MailID: 20220324065919epcas1p46b5381b1b839d7076673c23e8f9b0bba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p46b5381b1b839d7076673c23e8f9b0bba
References: <20220324070158.22969-1-jaewon31.kim@samsung.com>
        <CGME20220324065919epcas1p46b5381b1b839d7076673c23e8f9b0bba@epcas1p4.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel internal size information is also useful to compare with other
binary. This patch print kernel text, rwdata, rodata, bss, and others.

Here's an example.

Reserved    :  746924 KB
 .kernel    :  137027 KB
  .text     :   28158 KB
  .rwdata   :    3238 KB
  .rodata   :   13468 KB
  .bss      :   12570 KB
  .etc      :   79593 KB
 .unusable  :  609897 KB
System      : 3447380 KB
 .common    : 3152468 KB
 .reusable  :  294912 KB
Total       : 4194304 KB (  4096.00 MB )

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 include/linux/mm.h |  3 +++
 mm/memblock.c      | 17 +++++++++++++++++
 mm/page_alloc.c    |  6 +++---
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7a3dd7e617e4..6b874c602b3b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3387,4 +3387,7 @@ madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 }
 #endif
 
+extern unsigned long physpages, codesize, datasize, rosize, bss_size;
+extern unsigned long init_code_size, init_data_size;
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index ef8cec6242d2..083d19b1d061 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2494,6 +2494,13 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 	struct memsize_rgn_struct *rgn;
 	unsigned long reserved = 0, reusable = 0, total;
 	unsigned long system = totalram_pages() << PAGE_SHIFT;
+	unsigned long text, rw, ro, bss, etc;
+
+	text = codesize;
+	rw = datasize;
+	ro = rosize;
+	bss = bss_size;
+	etc = kernel_init_size - text - rw - ro - bss;
 
 	sort(memsize_rgn, memsize_rgn_count,
 	     sizeof(memsize_rgn[0]), memsize_rgn_cmp, NULL);
@@ -2526,6 +2533,16 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 		   DIV_ROUND_UP(kernel_init_size + reserved, SZ_1K));
 	seq_printf(m, " .kernel    : %7lu KB\n",
 		   DIV_ROUND_UP(kernel_init_size, SZ_1K));
+	seq_printf(m, "  .text     : %7lu KB\n"
+		      "  .rwdata   : %7lu KB\n"
+		      "  .rodata   : %7lu KB\n"
+		      "  .bss      : %7lu KB\n"
+		      "  .etc      : %7lu KB\n",
+			DIV_ROUND_UP(text, SZ_1K),
+			DIV_ROUND_UP(rw, SZ_1K),
+			DIV_ROUND_UP(ro, SZ_1K),
+			DIV_ROUND_UP(bss, SZ_1K),
+			DIV_ROUND_UP(etc, SZ_1K));
 	seq_printf(m, " .unusable  : %7lu KB\n",
 		   DIV_ROUND_UP(reserved, SZ_1K));
 	seq_printf(m, "System      : %7lu KB\n",
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bbbe314850b0..2bf75ba3c66d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8243,11 +8243,11 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 	return pages;
 }
 
+unsigned long physpages, codesize, datasize, rosize, bss_size;
+unsigned long init_code_size, init_data_size;
+
 void __init mem_init_print_info(void)
 {
-	unsigned long physpages, codesize, datasize, rosize, bss_size;
-	unsigned long init_code_size, init_data_size;
-
 	physpages = get_num_physpages();
 	codesize = _etext - _stext;
 	datasize = _edata - _sdata;
-- 
2.17.1

