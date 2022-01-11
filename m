Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904F548A5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbiAKCse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:48:34 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17336 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243811AbiAKCsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:48:33 -0500
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JXw8R2d0hz9s5k;
        Tue, 11 Jan 2022 10:47:19 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 10:48:26 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 10:48:25 +0800
Subject: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into
 'ai->fastmap' when fm->used_blocks>=2
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        "kirill shutemov" <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com>
 <20211227032246.2886878-13-chengzhihao1@huawei.com>
 <361758697.248157.1641857025490.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <6f7df7ba-9557-58a3-7978-e5d14a72f234@huawei.com>
Date:   Tue, 11 Jan 2022 10:48:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <361758697.248157.1641857025490.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,
> scan_ai->fastmap may contain also old fastmap PEBs.
> In the area < UBI_FM_MAX_START you can find outdated fastmap PEBs.
> e.g. after power-cut.
> That's why scan_ai->fastmap is copied into ai->fastmap.
> Later in ubi_wl_init() these outdated PEBs will get erased.
> So, you cannot remove this code.
I thought old fastmap PEBs(async erase works in ubi_update_fastmap()) 
will be counted into erase PEBs in the next attaching process, because I 
saw following code snippet in ubi_write_fastmap():
1260         list_for_each_entry(ubi_wrk, &ubi->works, list) { 

1261                 if (ubi_is_erase_work(ubi_wrk)) { 

1262                         wl_e = ubi_wrk->e; 

1263                         ubi_assert(wl_e); 

1264 

1265                         fec = (struct ubi_fm_ec *)(fm_raw + 
fm_pos);
1266 

1267                         fec->pnum = cpu_to_be32(wl_e->pnum); 

1268                         set_seen(ubi, wl_e->pnum, seen_pebs); 

1269                         fec->ec = cpu_to_be32(wl_e->ec); 

1270 

1271                         erase_peb_count++; 

1272                         fm_pos += sizeof(*fec); 

1273                         ubi_assert(fm_pos <= ubi->fm_size); 

1274                 } 

1275         } 

1276         fmh->erase_peb_count = cpu_to_be32(erase_peb_count);
Half-writing on fastmap will be recognized in scanning, and UBI 
fallbacks full scanning, So, I come up with two situations:
1. power-cut before new fastmap written, the old fastmap is completely 
saved until next attaching, and some free PEBs are written with new 
fastmap data. Luckly, fastmap anchor PEB's vid header is written first 
of all, bad fastmap will be returned by ubi_attach_fastmap() in next 
attaching.
2. power-cut after new fastmap written, the old fastmap PEBs will be 
added into 'ai->erase' list in next attaching.
Did I miss other possible circumstances?
> 
> But I fully agree with you that the fm->used_blocks > 1 case is not correct.
> I fear if scan_ai->fastmap contains old fastmap PEBs and fm->used_blocks is > 1
> we need to fall back to scanning mode while attaching.
