Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CFC490008
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 02:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbiAQBkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 20:40:31 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16713 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiAQBka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 20:40:30 -0500
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JcZJG1SYXzZdwP;
        Mon, 17 Jan 2022 09:36:46 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 09:40:28 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 09:40:27 +0800
Subject: Re: [PATCH v6 15/15] ubi: fastmap: Fix high cpu usage of ubi_bgt by
 making sure wl_pool not empty
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>,
        <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com>
 <20211227032246.2886878-16-chengzhihao1@huawei.com>
Message-ID: <e37980e5-962a-1223-cd46-b793a2caac6c@huawei.com>
Date:   Mon, 17 Jan 2022 09:40:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20211227032246.2886878-16-chengzhihao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,
> Fix it by:
>    1) Adding 2 PEBs reserved for fm_anchor and fm_next_anchor.
>    2) Abandoning filling wl_pool until free count belows beb_rsvd_pebs.
> Then, there are at least 2(EBA_RESERVED_PEBS + MIN_FASTMAP_RESERVED_PEBS -
> MIN_FASTMAP_TAKEN_PEBS[1]) PEBs in pool and 1(WL_RESERVED_PEBS) PEB in
> wl_pool after calling ubi_refill_pools() with all erase works done.
> 
> This modification will cause a compatibility problem with old UBI image.
> If UBI volumes take the maximun number of PEBs for one certain UBI device,
> there are no available PEBs to satisfy 2 new reserved PEBs, bad reserved
> PEBs are taken firstly, if still not enough, ENOSPC will returned from ubi
> initialization.
> 
Can you come up with a better solution that can be compatible with old 
images? In other words, can we solve this problem not by adding new 
reserved PEBs?
