Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2C04E5F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348344AbiCXHBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343622AbiCXHA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:00:59 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EAC53B48
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:59:25 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220324065924epoutp02e78070e8bf771eda50230a42f42746ed~fPuou0fqz1427814278epoutp02d
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:59:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220324065924epoutp02e78070e8bf771eda50230a42f42746ed~fPuou0fqz1427814278epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648105164;
        bh=PwBzPZxuTryly8gTU/4JXZYuZ8XrDmft5OHgh415hkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F72tEsEKFQcFMguq+1/A44KVgP/ON+Rt1KswvLfmxSsm9W4PLFAeCCzVGxZtsIEpm
         cAgjg5M9eyDkiIg5z45axkDZIqa6lvf0ajztqKtEbM9JV7nEXc9dzD6YSgPZxS8Sfb
         Y/vBgG5I8t39XKMTESa6XxX9gT7c8gnRpVpmS3Oo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220324065923epcas1p26fadde41347eda12b659c67ce636d567~fPuoPcYfB0342903429epcas1p2U;
        Thu, 24 Mar 2022 06:59:23 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.222]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KPGL213Fpz4x9QQ; Thu, 24 Mar
        2022 06:59:22 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.2B.28648.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epcas1p4b935c884aa3fde0917f6dff8bff128ed~fPukeTqKQ2463324633epcas1p4-;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220324065919epsmtrp2525e0b3bc0b06b141feab270e0fdde3d~fPukdoAAc2562225622epsmtrp2b;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
X-AuditID: b6c32a39-ff1ff70000006fe8-8f-623c16c756f9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.AD.03370.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epsmtip2fdb11aefb76992321248a719fdd451e8~fPukVfQeh3186531865epsmtip2f;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH 7/8] memblock: print memsize summary information
Date:   Thu, 24 Mar 2022 16:01:57 +0900
Message-Id: <20220324070158.22969-8-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324070158.22969-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmru5xMZskg+vdJhZz1q9hs+jePJPR
        ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgtHq/nduDw2DnrLrvHplWdbB6bPk1i9zgx4zeL
        R9+WVYweZxYcYff4vEkugD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEv
        MTfVVsnFJ0DXLTMH6CglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFZgV5xYm5x
        aV66Xl5qiZWhgYGRKVBhQnbGpUUPmQt+8lW87XnH2MB4kruLkZNDQsBEYufSA+xdjFwcQgI7
        GCXmPjzNBOF8YpSYcOgVM4TzmVGi42crI0zL7xdroVp2MUrMvLGCDcL5wSgx+ccmZpAqNgFt
        ifcLJrGC2CICdhLfZh9gBSliFuhilHjw4SALSEJYwEFizYIzYGNZBFQlTv/oArN5BWwleiaf
        gFonL7F6wwGwoZxAg1YuOcAIMkhC4B67xLe/rawQRS4SGzumskPYwhKvjm+BsqUkPr/bywZh
        Z0s8PXkEaBAHkJ0j0bBBFsK0l3h/yQLEZBbQlFi/Sx+iWFFi5++5YBcwC/BJvPvawwpRzSvR
        0SYEUaIm0fLsK9R+GYm//55BlXhILHrmCAmRiYwSd//eZZ7AKDcLYcECRsZVjGKpBcW56anF
        hgWm8AhLzs/dxAhOc1qWOxinv/2gd4iRiYPxEKMEB7OSCO/9y9ZJQrwpiZVVqUX58UWlOanF
        hxhNgSE3kVlKNDkfmGjzSuINTSwNTMyMTCyMLY3NlMR5V007nSgkkJ5YkpqdmlqQWgTTx8TB
        KdXAtJ3v0hrxTw5SFu/+XVZJvf7h60GNF9onq9v/Lj+TKPH95vPc075LbTXvT9ebr7eUf9/i
        vWtV618e2bHCedknRdst/Xc9Uj9ZBBw76PmYNXCuNNemqGNurcp5y1fc3G18c/XJRQqLN2g6
        6zwvfTO7/8cRKw9trrZ5FqbT/ppOMTjzQ/zrQtEPBSVvitQmZ5gu7vdM/jSjZ5aqSZDeKqNQ
        jfQU/dkff2r0SLkdS6jd4M+o7FdkzTKrJd9uWlvgkbvbMnuMJtj9rerq+lb1+ettH80rgVol
        0Vr7Ap12TZvCKHQsO3Xqfe/+fdm3bv5fLxi29nHJ9JQdiv9Xt3hGa4otyrk/+9S7rW5l1Rd/
        i0zUuKrEUpyRaKjFXFScCAD4RCRb/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvO5xMZskgw03FCzmrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHsUl01Kak5mWWqRvl0CV8alRQ+ZC37yVbztecfYwHiSu4uRk0NC
        wETi94u17F2MXBxCAjsYJU53z2WESMhIvDn/lKWLkQPIFpY4fLgYJCwk8I1RYt/bBBCbTUBb
        4v2CSawgtoiAk8SGK6tZQOYwC0xglFi57BMLSEJYwEFizYIzYDNZBFQlTv/oArN5BWwleiaf
        gNolL7F6wwFmEJtTwE5i5ZIDjBDLbCXOnjzANoGRbwEjwypGydSC4tz03GLDAqO81HK94sTc
        4tK8dL3k/NxNjOCA1NLawbhn1Qe9Q4xMHIyHGCU4mJVEeO9ftk4S4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgYnZaNEJtsvbnfb5zxaP6gle+tspY5tW
        kzSTlv8ky1bZfHE5jb8nNeNPNjnvTlN6EdW9+JzJ8RDnhzMl7CQv14W/27dr6+w3v00Zckpe
        3t7E0MjuyVexiENrkVjOCsO8x3/KNnBnsPOZnM5iin7BtLX4zqYQHX17g7/TNKTf3Sw+xvkw
        UfGhgeu/aCtjVpOri7gbtWTuOFQU3Z6nJ8bw4dD+nC3Ln5unFG1cxHTZjbf6J9t7hrl8M4Ss
        Enw8nkyd2teh2xoYqt2zsHblykTpz1M2fLC5rzut8dXyD9kBuxhXu5i5L/O/bVtmvPnuEYXH
        JTn3Xz5OzvrzI6Mouuje+2dLXnLr8UfUs6f+ZvHZo8RSnJFoqMVcVJwIACXlyq+3AgAA
X-CMS-MailID: 20220324065919epcas1p4b935c884aa3fde0917f6dff8bff128ed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p4b935c884aa3fde0917f6dff8bff128ed
References: <20220324070158.22969-1-jaewon31.kim@samsung.com>
        <CGME20220324065919epcas1p4b935c884aa3fde0917f6dff8bff128ed@epcas1p4.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the previous patches, now we can print summary information.

Here's an example of 4GB DRAM device.

Reserved    :  746924 KB
 .kernel    :  137027 KB
 .unusable  :  609897 KB
System      : 3447380 KB
 .common    : 3152468 KB
 .reusable  :  294912 KB
Total       : 4194304 KB (  4096.00 MB )

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/memblock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 597ec7fb5bb2..ef8cec6242d2 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2492,7 +2492,8 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 {
 	int i;
 	struct memsize_rgn_struct *rgn;
-	unsigned long reserved = 0, reusable = 0;
+	unsigned long reserved = 0, reusable = 0, total;
+	unsigned long system = totalram_pages() << PAGE_SHIFT;
 
 	sort(memsize_rgn, memsize_rgn_count,
 	     sizeof(memsize_rgn[0]), memsize_rgn_cmp, NULL);
@@ -2518,13 +2519,24 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 			reserved += (unsigned long)rgn->size;
 	}
 
+	total = kernel_init_size + reserved + system;
+
 	seq_printf(m, "\n");
+	seq_printf(m, "Reserved    : %7lu KB\n",
+		   DIV_ROUND_UP(kernel_init_size + reserved, SZ_1K));
 	seq_printf(m, " .kernel    : %7lu KB\n",
 		   DIV_ROUND_UP(kernel_init_size, SZ_1K));
 	seq_printf(m, " .unusable  : %7lu KB\n",
 		   DIV_ROUND_UP(reserved, SZ_1K));
+	seq_printf(m, "System      : %7lu KB\n",
+		   DIV_ROUND_UP(system, SZ_1K));
+	seq_printf(m, " .common    : %7lu KB\n",
+		   DIV_ROUND_UP(system - reusable, SZ_1K));
 	seq_printf(m, " .reusable  : %7lu KB\n",
 		   DIV_ROUND_UP(reusable, SZ_1K));
+	seq_printf(m, "Total       : %7lu KB ( %5lu.%02lu MB )\n",
+		   DIV_ROUND_UP(total, SZ_1K),
+		   total >> 20, ((total % SZ_1M) * 100) >> 20);
 	return 0;
 }
 
-- 
2.17.1

