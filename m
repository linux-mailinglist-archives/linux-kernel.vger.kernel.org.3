Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303564E5F03
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348305AbiCXHBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245425AbiCXHA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:00:59 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CCA53A66
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:59:25 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220324065923epoutp028a9a9f915923e411cbdfb3ecd3304724~fPuoY2XF01427814278epoutp02c
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:59:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220324065923epoutp028a9a9f915923e411cbdfb3ecd3304724~fPuoY2XF01427814278epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648105163;
        bh=RidzKqNjs5HOBkuuO6v6/5UvbzPkwAJOqwZxf+Nkf5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RLNsDx2RF6HSMQUXxTcrxoLsEUm7JYz44Q2WLX2wI+p+9InegBRNQ955YyCd3s0fh
         e8OerodeQx9FOPVKDn1jkXz+1C5oAU8Xc7ktIBz5b2nUk5YazIP9eGXk3bNxndfjyN
         HERqVYT8j+MS21z+CwLZTkwRv6u3iee+ywWKi6O4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220324065923epcas1p410186b7151a7c4ad59fee32272e82fe8~fPun-IGKB2463324633epcas1p4S;
        Thu, 24 Mar 2022 06:59:23 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.247]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KPGL23R0fz4x9Q8; Thu, 24 Mar
        2022 06:59:22 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.0A.64085.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epcas1p1058e2841b009d8c7d683bc0408f8a5a4~fPukbUYx22488924889epcas1p1G;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220324065919epsmtrp19ec153dd781008488dd7015f92b513f7~fPukafMFB2225222252epsmtrp1V;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
X-AuditID: b6c32a35-9adff7000000fa55-0d-623c16c7a91b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.AD.03370.7C61C326; Thu, 24 Mar 2022 15:59:19 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.100.104]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324065919epsmtip2bdc91d1127b721c804555b0fc29dcfcf~fPukSrsVT3063230632epsmtip29;
        Thu, 24 Mar 2022 06:59:19 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ytk.lee@samsung.com, jaewon31.kim@gmail.com,
        Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH 6/8] memblock: recognize late free by checking PageReserved
Date:   Thu, 24 Mar 2022 16:01:56 +0900
Message-Id: <20220324070158.22969-7-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324070158.22969-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmnu5xMZskg78nzCzmrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
        Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKzAr3ixNzi
        0rx0vbzUEitDAwMjU6DChOyMjs9bWAp+ClUcvdPO2sD4na+LkZNDQsBE4v3Mm6xdjFwcQgI7
        GCVWnX7CCpIQEvjEKHFjMQ9E4jOjxNtHU9lhOrYunsICkdjFKLFsej87hPODUWLH9XYmkCo2
        AW2J9wsmgY0SEbCT+Db7ANgOZoEuRokHHw4CtXNwCAt4S7x4bAJSwyKgKrFszSKwDbwCthJr
        l+5mgtgmL7F6wwFmEJsTaM7KJQcYQeZICNxjlzi9Zz3YHAkBF4lVd9Mg6oUlXh3fAnWplMTL
        /jYoO1vi6ckjzBDlORING2QhTHuJ95csQExmAU2J9bv0IYoVJXb+nssIYjML8Em8+9rDClHN
        K9HRJgRRoibR8uwrK4QtI/H33zMo20Pi2LGzTJAAmcgo8eTYYdYJjHKzEDYsYGRcxSiWWlCc
        m55abFhgCI+u5PzcTYzgFKdluoNx4tsPeocYmTgYDzFKcDArifDev2ydJMSbklhZlVqUH19U
        mpNafIjRFBhyE5mlRJPzgUk2ryTe0MTSwMTMyMTC2NLYTEmcd9W004lCAumJJanZqakFqUUw
        fUwcnFINTJr7Ez+9Tvxw+cHp4/+7K2W/TtMVlbu9xf/3lNW36p4ETzaxeFDKpd6uda2ZV+Jv
        l7fZqqwOH5td9sfzLxv9Wth4U/u78YMolWenJsdV+agc3fb4r7zgXBc5l5BTepO+WiwTe1qx
        PV3C/K1w8JKY+1mtDqbMH97zb7y9XzPmlklwZIRf5ceAqthlU7dzSBn3W0vs7te7+mjDvT5u
        I6YHjsCUarvHcEJf0uf704qY1O3lRA4ZrbI5EKxoPfOI4sz3Spcuhk94d2/WVwNutq+9pe0X
        1iqWvTb5E2p1WeCbW1s2S0/35mzm8lvn/1pbbl+y4kjWoWUnv52b3iYg8uzIFavCnRNmbmR1
        V/x0R/3VWyWW4oxEQy3mouJEAP8HVPv6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvO5xMZskg0sfZS3mrF/DZtG9eSaj
        Re/7V0wWl3fNYbO4t+Y/q8WR9duZLGY39jFaPF7P7cDhsXPWXXaPTas62Tw2fZrE7nFixm8W
        j74tqxg9ziw4wu7xeZNcAHsUl01Kak5mWWqRvl0CV0bH5y0sBT+FKo7eaWdtYPzO18XIySEh
        YCKxdfEUli5GLg4hgR2MEkvn/2eDSMhIvDn/FCjBAWQLSxw+XAxR841RYtW+PcwgNWwC2hLv
        F0xiBbFFBJwkNlxZDTaIWWACo8TKZZ/AmoUFvCVePDYBqWERUJVYtmYRO4jNK2ArsXbpbiaI
        XfISqzccAJvJKWAnsXLJAUYQWwio5uzJA2wTGPkWMDKsYpRMLSjOTc8tNiwwykst1ytOzC0u
        zUvXS87P3cQIDkgtrR2Me1Z90DvEyMTBeIhRgoNZSYT3/mXrJCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYdnl/VAs0e8t5Ruvz/nlHT9zk2v9cdUXI
        lkMTZFJDghbf++zHLxu/yDC2WLQ10L+YY4rQ2X+TOo8fLT24eXnaq29WrXsnnPnTtkxMpyz3
        Uesv7n2LrkabuTsWzMzf4CEWJG3vVp2bPIU966lnxCLt4K79i4+dnhby+3SluUpiamJkyi7V
        tYrMCpM+6czq2NqzWDfl77qbTqf2c3b/X/nG9DP3/YXhbitjxCsMRENnOxb7Hm9I1f6oF9XH
        HXh+5uTg/b4tto/tCsWcihKc0tbuN/jLzWS0xkJj63wOi8KvYTODtmxy+vlxvtvbL9c/Nh1c
        ssQmxLqsI1ztdlDy2pUBk29odK89dq1b6nLQBaZZSizFGYmGWsxFxYkATpK1hLcCAAA=
X-CMS-MailID: 20220324065919epcas1p1058e2841b009d8c7d683bc0408f8a5a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324065919epcas1p1058e2841b009d8c7d683bc0408f8a5a4
References: <20220324070158.22969-1-jaewon31.kim@samsung.com>
        <CGME20220324065919epcas1p1058e2841b009d8c7d683bc0408f8a5a4@epcas1p1.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some cases in which reserved pages are freed late after the
initial memblock_free_all of mem_init. We'd like to recognize this
late free pages, and update the memsize information.

Because additional job is needed to a no-map or reusable region, the
late free is usually done to a map and unusable region. So only for map
and unusable region, check if some pages within the region is freed. The
freed pages can be recoginzed by checking if PageReserved flag is clear.
To be fast, let's skip other pages within 1 MB range. And this check is
done when a user wants to see the memsize information.

This is an example. If all pages are freed the region size will be 0.

Before
0x0a2300000-0x0a2400000 0x00100000 (    1024 KB )   map unusable latefree

After
0x0a2300000-0x0a2300000 0x00000000 (       0 KB )   map unusable latefree

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/memblock.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index aee22dbc2500..597ec7fb5bb2 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2455,6 +2455,39 @@ static int memsize_rgn_cmp(const void *a, const void *b)
 	return 0;
 }
 
+/* assume that freed size is always MB aligned */
+static inline void memblock_memsize_check_size(struct memsize_rgn_struct *rgn)
+{
+	phys_addr_t phy, end, freed = 0;
+	bool has_freed = false;
+	struct page *page;
+
+	if (rgn->reusable || rgn->nomap)
+		return;
+
+	/* check the first page of each 1 MB */
+	phy = rgn->base;
+	end = rgn->base + rgn->size;
+	while (phy < end) {
+		unsigned long pfn = __phys_to_pfn(phy);
+
+		if (!pfn_valid(pfn))
+			return;
+		page = pfn_to_page(pfn);
+		if (!has_freed && !PageReserved(page)) {
+			has_freed = true;
+			freed = phy;
+		} else if (has_freed && PageReserved(page)) {
+			has_freed = false;
+			memblock_memsize_free(freed, phy - freed);
+		}
+
+		if (has_freed && (phy + SZ_1M >= end))
+			memblock_memsize_free(freed, end - freed);
+		phy += SZ_1M;
+	}
+}
+
 static int memblock_memsize_show(struct seq_file *m, void *private)
 {
 	int i;
@@ -2468,6 +2501,7 @@ static int memblock_memsize_show(struct seq_file *m, void *private)
 		long size;
 
 		rgn = &memsize_rgn[i];
+		memblock_memsize_check_size(rgn);
 		base = rgn->base;
 		size = rgn->size;
 		end = base + size;
-- 
2.17.1

