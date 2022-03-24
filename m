Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0444E5F04
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348324AbiCXHBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbiCXHA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:00:59 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CF853A6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:59:25 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220324065922epoutp02f83061aa187f53dc8ea4f43225075a8c~fPunCN5cE1323613236epoutp02g
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:59:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220324065922epoutp02f83061aa187f53dc8ea4f43225075a8c~fPunCN5cE1323613236epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648105162;
        bh=04++ejy5/yIf+QVT4m1oQmzMNHrje9zF1MhViQLha2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKNtYeZ0d13TzxYZ6nir9OU9mDYAaeIQRgOPACiwmFkZx2JKmG7vl77+xIioF1AHO
         8GQv2kEKrsN+24cnMwXD4uP91Rzah0Ruhvju+h3Fyak3hYhXkSF5Mj+ulSd8IIoxto
         HV1Kp9YTkH94CbnJNFyhClITZTcNaCoZKdqBoi3Y=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220324065921epcas1p470d911984edf8b239256e90b1c145648~fPump5zYj2719127191epcas1p4r;
        Thu, 24 Mar 2022 06:59:21 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.248]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KPGKz5PQ0z4x9QJ; Thu, 24 Mar
        2022 06:59:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.2B.28648.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epcas1p1b30eabc8bbe01da1ef90280b6ee8bcea~fPukRm-t23006230062epcas1p1U;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220324065919epsmtrp20497a364e1b0f1aacf11b10546c2b47a~fPukQ0VTV2562325623epsmtrp2W;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
X-AuditID: b6c32a39-ff1ff70000006fe8-8c-623c16c79bb9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.AD.03370.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epsmtip2c96f2e23e1233729ba054029a3a09905~fPukJGmsT3186931869epsmtip2b;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH 2/8] memblock: detect hidden memory hole size
Date:   Thu, 24 Mar 2022 16:01:52 +0900
Message-Id: <20220324070158.22969-3-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324070158.22969-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmvu5xMZskg9YOdYs569ewWXRvnslo
        0fv+FZPF5V1z2CzurfnPanFk/XYmi9mNfYwWj9dzO3B47Jx1l91j06pONo9Nnyaxe5yY8ZvF
        o2/LKkaPMwuOsHt83iQXwB6VbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCX
        mJtqq+TiE6DrlpkDdJSSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CsQK84Mbe4
        NC9dLy+1xMrQwMDIFKgwITvj8rfrbAUHZCt2zOFsYLws3sXIySEhYCLxd1EDexcjF4eQwA5G
        ie1fjrFAOJ8YJZY9b4LKfGaUONbwihmm5eafy1CJXYwSp1/0M0M4Pxgl3m+4BVbFJqAt8X7B
        JFYQW0TATuLb7AOsIEXMAl2MEg8+HGQBSQgL2Eo03nkPVsQioCox7980NhCbFyh+YdpbNoh1
        8hKrNxwAG8oJNGjlkgOMEPFH7BLTt0J94SJxYekKdghbWOLV8S1QtpTE53d7oeZkSzw9eQRo
        DgeQnSPRsEEWwrSXeH/JAsRkFtCUWL9LH6JYUWLn77lgi5gF+CTefe1hhajmlehoE4IoUZNo
        efaVFcKWkfj77xmU7SEx5eQEaIhMZJTo2/WOeQKj3CyEDQsYGVcxiqUWFOempxYbFpjC4ys5
        P3cTIzjJaVnuYJz+9oPeIUYmDsZDjBIczEoivPcvWycJ8aYkVlalFuXHF5XmpBYfYjQFhtxE
        ZinR5Hxgms0riTc0sTQwMTMysTC2NDZTEuddNe10opBAemJJanZqakFqEUwfEwenVAOTTNUW
        +Y/nouU1XjlHa8U6nNm51S3m31kX34PPXhvvdj+70rKKz1bTR+bko9ZTspt8v37edlRbv+X2
        k9s/Zj06zS246oJPtsDj9f/Sfma0ppZ2LVIUnmEWs31fRs5U+c1hd4P3bZjBteZIeOzV9/Lv
        V+8VqVXdv9Oy7sjJAJ1Zgg2u4qzsy13Z5V/8YvjfLiWz5sibpvoeHuaq63MrrLbOdBJZ1LG0
        /lX8hxIWsTCbVTvPVe/+vWPCWtHa07kf8jbHa11Tfi2e3XdWK1HXcuZ8xZuO+p7bZk5xjYra
        5HMuKn3G8caIKVsFfKJSDJlzvwq/qHEUSZGbk/Hw9uaN4bNWZT+aybloQuqy2xJHvW3OK7EU
        ZyQaajEXFScCAD52gV77AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvO5xMZskg+39IhZz1q9hs+jePJPR
        ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgtHq/nduDw2DnrLrvHplWdbB6bPk1i9zgx4zeL
        R9+WVYweZxYcYff4vEkugD2KyyYlNSezLLVI3y6BK+Pyt+tsBQdkK3bM4WxgvCzexcjJISFg
        InHzz2X2LkYuDiGBHYwSnx58YYJIyEi8Of+UpYuRA8gWljh8uBii5hujxLb1s1lAatgEtCXe
        L5jECmKLCDhJbLiymgWkiFlgAqPEymWfwIqEBWwlGu+8BytiEVCVmPdvGhuIzQsUvzDtLRvE
        MnmJ1RsOMIPYnAJ2EiuXHGAEsYWAas6ePMA2gZFvASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi
        0rx0veT83E2M4IDU0trBuGfVB71DjEwcjIcYJTiYlUR471+2ThLiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBSeji2oy5s/QmMT6VMrtom/3l2jqL791P
        +g6+tpA4fmGjUhz3s4+Rm6Ok1qbdnm5o/WSCg6JMUEJDf/31zavYC6at+62sfLc4/nC6wfY1
        s3+8q/zD+nafTukd3i1XckM3+0lP2rTo8796FZlW61sXmN4cf3D9xMuP+89IB3iKmV748fb9
        593LDwlUXmANDmOTYk5IcM6SXv8i/dOy63+f8d5PmOdSOturdMI69lqrqw/5lZdsvq+ZJm5R
        cJJxe4aEsPX2p2fj47hk5+sXfbNbytWtd3wLY0/JCy1BH6t6zeknlV2E/gU8PXw177R9zv7v
        P15NfRTE754YmTR9kduvFadv2qbqZfK/Cn7UorCKv0WJpTgj0VCLuag4EQBzrkittwIAAA==
X-CMS-MailID: 20220324065919epcas1p1b30eabc8bbe01da1ef90280b6ee8bcea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p1b30eabc8bbe01da1ef90280b6ee8bcea
References: <20220324070158.22969-1-jaewon31.kim@samsung.com>
        <CGME20220324065919epcas1p1b30eabc8bbe01da1ef90280b6ee8bcea@epcas1p1.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bootloader knows the actual memory size, but bootloader may reserve some
memory for a specific purpose and pass the only remaining memory region
to kernel.

Even though kernel does not know what it is, we need to detect those
regions to sum up all reserved memory. Let me call it memory hole. To
expect the hole size, this patch assume two things. One is that each
physical memory has 1GB aligned size and address. And the hole is less
than 1GB. For the hole, let it be shown as unknown in memsize logic.

This is an example.
0x0bf000000-0x0c0000000 0x01000000 (   16384 KB ) nomap unusable unknown

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 drivers/of/fdt.c         |  2 ++
 include/linux/memblock.h |  2 ++
 mm/memblock.c            | 45 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ec2f60a78f8f..9721a3d7b7ae 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1294,6 +1294,8 @@ void __init early_init_dt_scan_nodes(void)
 
 	/* Handle linux,usable-memory-range property */
 	early_init_dt_check_for_usable_mem_range();
+
+	memblock_memsize_detect_hole();
 }
 
 bool __init early_init_dt_scan(void *params)
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 468b016e179b..201f8723dfd8 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -608,10 +608,12 @@ static inline void early_memtest(phys_addr_t start, phys_addr_t end)
 extern void memblock_memsize_record(const char *name, phys_addr_t base,
 				    phys_addr_t size, bool nomap,
 				    bool reusable);
+extern void memblock_memsize_detect_hole(void);
 #else
 static inline void memblock_memsize_record(const char *name, phys_addr_t base,
 				    phys_addr_t size, bool nomap,
 				    bool reusable) { }
+static inline void memblock_memsize_detect_hole(void) { }
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/mm/memblock.c b/mm/memblock.c
index 8492757f7192..8e032f44eb57 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1970,6 +1970,51 @@ void __init_memblock memblock_memsize_record(const char *name, phys_addr_t base,
 	memblock_dbg("%s %pa..%pa nomap:%d reusable:%d\n",
 		     __func__, &base, &end, nomap, reusable);
 }
+
+/* This function will be called to by early_init_dt_scan_nodes */
+void __init memblock_memsize_detect_hole(void)
+{
+	phys_addr_t base, end;
+	phys_addr_t prev_end, hole_sz;
+	int idx;
+	struct memblock_region *rgn;
+	int memblock_cnt = (int)memblock.memory.cnt;
+
+	/* assume that the hole size is less than 1 GB */
+	for_each_memblock_type(idx, (&memblock.memory), rgn) {
+		prev_end = (idx == 0) ? round_down(rgn->base, SZ_1G) : end;
+		base = rgn->base;
+		end = rgn->base + rgn->size;
+
+		/* only for the last region, check a hole after the region */
+		if (idx + 1 == memblock_cnt) {
+			hole_sz = round_up(end, SZ_1G) - end;
+			if (hole_sz)
+				memblock_memsize_record(NULL, end, hole_sz,
+							true, false);
+		}
+
+		/* for each region, check a hole prior to the region */
+		hole_sz = base - prev_end;
+		if (!hole_sz)
+			continue;
+		if (hole_sz < SZ_1G) {
+			memblock_memsize_record(NULL, prev_end, hole_sz, true,
+						false);
+		} else {
+			phys_addr_t hole_sz1, hole_sz2;
+
+			hole_sz1 = round_up(prev_end, SZ_1G) - prev_end;
+			if (hole_sz1)
+				memblock_memsize_record(NULL, prev_end,
+							hole_sz1, true, false);
+			hole_sz2 = base % SZ_1G;
+			if (hole_sz2)
+				memblock_memsize_record(NULL, base - hole_sz2,
+							hole_sz2, true, false);
+		}
+	}
+}
 #endif /* MEMBLOCK_MEMSIZE */
 
 static void __init free_memmap(unsigned long start_pfn, unsigned long end_pfn)
-- 
2.17.1

