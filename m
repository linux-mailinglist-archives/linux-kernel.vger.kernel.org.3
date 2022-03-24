Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF584E5F07
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348394AbiCXHB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346316AbiCXHBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:01:01 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00DE53A74
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:59:25 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220324065922epoutp0308448bb4fd2db3e272944c80c787bb4b~fPunOLpc_2275722757epoutp03F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:59:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220324065922epoutp0308448bb4fd2db3e272944c80c787bb4b~fPunOLpc_2275722757epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648105162;
        bh=YGpkejzEBgPEWiqqAXB1bDr6fxKfkieYcgxWNQ4BKdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIs+MnfaZdinj0I7IqYyE76A0LCYFOkrXDH0sxIEPxIUHJh7Eg2irIs9Ubs5DL1RH
         kWBQGWboIq6xZK3LM01to4nvxScEhsLvTMWZ1BXgpmTje2OSUaTDPBsz9/096KTnwv
         ntmUmlBIWi5kUjEAzy3b++WhHyqzDCHlSyBiTxYs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220324065922epcas1p401e2cf5f6906a46039fd08e4ecf3fd5e~fPumw-BJ02260522605epcas1p40;
        Thu, 24 Mar 2022 06:59:22 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.248]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KPGKz6PMjz4x9QF; Thu, 24 Mar
        2022 06:59:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.2B.28648.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epcas1p3429ec2c9595c54ffe4ee25f273febd1c~fPukVRPTh0544005440epcas1p36;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220324065919epsmtrp2654a6c9391ab508b7f30a149d7adbdae~fPukUkKYV2562325623epsmtrp2X;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
X-AuditID: b6c32a39-813e6a8000006fe8-8d-623c16c7a2f6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.AD.03370.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epsmtip2bcffa62f9f2f6596a2a156bca5ee78d9~fPukLbdZS3186531865epsmtip2d;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH 3/8] memblock: handle overlapped reserved memory region
Date:   Thu, 24 Mar 2022 16:01:53 +0900
Message-Id: <20220324070158.22969-4-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324070158.22969-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsWy7bCmvu5xMZskg1+bNC3mrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
        Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKzAr3ixNzi
        0rx0vbzUEitDAwMjU6DChOyM1s53bAUfFCrWfb/A3MC4Q6qLkZNDQsBEovX1UuYuRi4OIYEd
        jBJLdt9ngXA+MUps+jqfFcL5zCgx9/YPFpiWLRPXsUEkdjFK/Pr0mwnC+cEo8XbxL3aQKjYB
        bYn3CyaxgtgiAnYS32YfABvFLNDFKPHgw0GwUcIC7hLrZ24FK2IRUJW4MPEvWJxXwFbi8+KJ
        TBDr5CVWbzjADGJzAg1aueQAI8ggCYFH7BLTT/2EuslF4vXWs+wQtrDEq+NboGwpic/v9rJB
        2NkST08eARrEAWTnSDRskIUw7SXeX7IAMZkFNCXW79KHKFaU2Pl7LiOIzSzAJ/Huaw8rRDWv
        REebEESJmkTLs6+sELaMxN9/z6BKPCSm3+KEhMhERolPG8+zTWCUm4WwYAEj4ypGsdSC4tz0
        1GLDAlN4hCXn525iBKc5LcsdjNPfftA7xMjEwXiIUYKDWUmE9/5l6yQh3pTEyqrUovz4otKc
        1OJDjKbAkJvILCWanA9MtHkl8YYmlgYmZkYmFsaWxmZK4ryrpp1OFBJITyxJzU5NLUgtgulj
        4uCUamDSfdp4+uxnvrL3Nj2/pm79tuFcgPPtzQZfe3lmymdscD+g8fXDku4fP6uU2w6z/mS+
        rSkpMOv8mfouozkbE/ULDot8Yjc82sBe94ZbpPjIq6lRXW5C3xuW2Gpy2SzreBGo/2HLpcsV
        ZgKqmivtCrtiWxh2S+/cIeezh8NWlyexh30H74yfi4qOH2vNcLIpurBNJO+Rvd/8lKMTHKU0
        Nu5hWr/stH5pIesBO4Gld+p9WM04szsCXy7k9j1lr8//pMn2ZfOpuJh5oc/m8PHtz5WzfplQ
        euN7vNvZr/M2XVAp8lnyvow/XPb7xnmtL1c6fXR8crtwZ0BRzZWLrA/7LphLnlN3vdI8zUbO
        nuvuvB9KLMUZiYZazEXFiQD3dI1L/AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSvO5xMZskg8uHxCzmrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHsUl01Kak5mWWqRvl0CV0Zr5zu2gg8KFeu+X2BuYNwh1cXIySEh
        YCKxZeI6ti5GLg4hgR2MEhOPv2SCSMhIvDn/lKWLkQPIFpY4fLgYouYbo8TlGbNYQWrYBLQl
        3i+YBGaLCDhJbLiymgWkiFlgAqPEymWfWEASwgLuEutnbgUrYhFQlbgw8S9YnFfAVuLz4olQ
        y+QlVm84wAxicwrYSaxccoARxBYCqjl78gDbBEa+BYwMqxglUwuKc9Nziw0LjPJSy/WKE3OL
        S/PS9ZLzczcxgkNSS2sH455VH/QOMTJxMB5ilOBgVhLhvX/ZOkmINyWxsiq1KD++qDQntfgQ
        ozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpknXdkW5/wqx+CW7P4XBovWTbPGa45ey
        Hh3Ov2jwM7+C4ePDsGPTG8Vsoqsq9i9VC+o79Nn5dsZ/t//yV45/VO3NCvkn/+TnrW/TM1Se
        dvAIefHvE73997fXDE+LiMVH9RZcXlYl7XRHq+3qTPncl4VdfK/S5zyru7TsQo3lrNQvvP9c
        P9/O9Dtfdn+jkucs50M2rs4vGCSjRB9Nc5/sWxP57MPfrID3f9JZjU86/bnFssl4ldJ3pueS
        +aLn2TMzxGvOW350/iZc8vHdyRsxDz40XrS4N+9hiczMsPifix/nRCu5Of/VmCazS2lnxbFl
        thqTZDi/eaic3cwn94n3umXB2cWMHz6ovTsyfWXF45VKLMUZiYZazEXFiQChDOajuAIAAA==
X-CMS-MailID: 20220324065919epcas1p3429ec2c9595c54ffe4ee25f273febd1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p3429ec2c9595c54ffe4ee25f273febd1c
References: <20220324070158.22969-1-jaewon31.kim@samsung.com>
        <CGME20220324065919epcas1p3429ec2c9595c54ffe4ee25f273febd1c@epcas1p3.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not common, but defining an overlapped region is possible.
Actually memblock_add_range allows to overlap with existing ones.

The memsize currently does not handle this overlapped case. But this
patch tries to handle one overlapped case.

Here's the case.

There is an unknown memsize region, which means the region was removed
and not passed at bootloader stage. And there is a reserved memory
region defined in device tree which is overlapped with the unknown
region.

We expect that information in device tree make the unknown region clear.
This patch handle the overlapped region with following conditions.

1) The already existing overlapped region should be unknown and no-map.
2) The newly added region should have a name, and its region should be
same with or part of the existing one.

Here is an example.

Before this patch, memsize shows both overlapped region.

0x0ea000000-0x0ed900000 0x03900000 (   58368 KB ) nomap unusable overlapped
0x0ea000000-0x0f1400000 0x07400000 (  118784 KB ) nomap unusable unknown

After this patch, the overlapped region is named.

0x0ea000000-0x0ed900000 0x03900000 (   58368 KB ) nomap unusable overlapped
0x0e9b00000-0x0ea000000 0x00500000 (    5120 KB ) nomap unusable unknown

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/memblock.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 8e032f44eb57..9195a51bfa5d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1944,6 +1944,75 @@ struct memsize_rgn_struct {
 static struct memsize_rgn_struct memsize_rgn[MAX_MEMSIZE_RGN] __initdata_memblock;
 static int memsize_rgn_count __initdata_memblock;
 
+static inline struct memsize_rgn_struct * __init_memblock memsize_get_new_rgn(void)
+{
+	if (memsize_rgn_count == ARRAY_SIZE(memsize_rgn)) {
+		pr_err("not enough space on memsize_rgn\n");
+		return NULL;
+	}
+	return &memsize_rgn[memsize_rgn_count++];
+}
+
+static bool __init_memblock memsize_update_nomap_region(const char *name, phys_addr_t base,
+					phys_addr_t size, bool nomap)
+{
+	int i;
+	struct memsize_rgn_struct *rmem_rgn, *new_rgn;
+
+	if (!name)
+		return false;
+
+	for (i = 0; i < memsize_rgn_count; i++)	{
+		rmem_rgn = &memsize_rgn[i];
+
+		if (!rmem_rgn->nomap)
+			continue;
+		if (strcmp(rmem_rgn->name, "unknown"))
+			continue;
+		if (base < rmem_rgn->base)
+			continue;
+		if (base + size > rmem_rgn->base + rmem_rgn->size)
+			continue;
+
+		if (base == rmem_rgn->base && size == rmem_rgn->size) {
+			strncpy(new_rgn->name, name, NAME_SIZE);
+			new_rgn->name[NAME_SIZE - 1] = '\0';
+			return true;
+		}
+
+		new_rgn = memsize_get_new_rgn();
+		if (!new_rgn)
+			return true;
+		new_rgn->base = base;
+		new_rgn->size = size;
+		new_rgn->nomap = nomap;
+		new_rgn->reusable = false;
+		strncpy(new_rgn->name, name, NAME_SIZE);
+		new_rgn->name[NAME_SIZE - 1] = '\0';
+
+		if (base == rmem_rgn->base && size < rmem_rgn->size) {
+			rmem_rgn->base = base + size;
+			rmem_rgn->size -= size;
+		} else if (base + size == rmem_rgn->base + rmem_rgn->size) {
+			rmem_rgn->size -= size;
+		} else {
+			new_rgn = memsize_get_new_rgn();
+			if (!new_rgn)
+				return true;
+			new_rgn->base = base + size;
+			new_rgn->size = (rmem_rgn->base + rmem_rgn->size)
+					- (base + size);
+			new_rgn->nomap = nomap;
+			new_rgn->reusable = false;
+			strcpy(new_rgn->name, "unknown");
+			rmem_rgn->size = base - rmem_rgn->base;
+		}
+		return true;
+	}
+
+	return false;
+}
+
 void __init_memblock memblock_memsize_record(const char *name, phys_addr_t base,
 			     phys_addr_t size, bool nomap, bool reusable)
 {
@@ -1954,7 +2023,14 @@ void __init_memblock memblock_memsize_record(const char *name, phys_addr_t base,
 		pr_err("not enough space on memsize_rgn\n");
 		return;
 	}
-	rgn = &memsize_rgn[memsize_rgn_count++];
+
+	if (memsize_update_nomap_region(name, base, size, nomap))
+		return;
+
+	rgn = memsize_get_new_rgn();
+	if (!rgn)
+		return;
+
 	rgn->base = base;
 	rgn->size = size;
 	rgn->nomap = nomap;
-- 
2.17.1

