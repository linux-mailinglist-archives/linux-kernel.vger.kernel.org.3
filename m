Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B63A48AE5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbiAKNX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:23:56 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34896 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiAKNXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:23:55 -0500
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JYBGC3qzVzccRY;
        Tue, 11 Jan 2022 21:23:15 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 21:23:53 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 21:23:53 +0800
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
 <6f7df7ba-9557-58a3-7978-e5d14a72f234@huawei.com>
 <244238061.248369.1641886066066.JavaMail.zimbra@nod.at>
 <420c7567-8926-2e8b-4da0-a9bfc8379642@huawei.com>
 <11976804.249069.1641902225370.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <0a7a5cce-1ee1-70b6-d368-615dfa0a617a@huawei.com>
Date:   Tue, 11 Jan 2022 21:23:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <11976804.249069.1641902225370.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/1/11 19:57, Richard Weinberger 写道:
> ubi_wl_init() is called in both cases, with and without fastmap.
I agree.

> And ai->fastmap contains all anchor PEBs that scan_fast() found.
> This can be the most recent but also outdated anchor PEBs.
Is it exists a case that outdated fastmap PEBs are neither counted into 
'fmhdr->erase_peb_count' nor scanned into 'ai->fastmap' after attaching 
by fastmap.

1853                         if (ubi->lookuptbl[aeb->pnum]) 

1854                                 continue; 

1855 

1856                         /* 

1857                          * The fastmap update code might not find a 
free PEB for
1858                          * writing the fastmap anchor to and then 
reuses the
1859                          * current fastmap anchor PEB. When this 
PEB gets erased
1860                          * and a power cut happens before it is 
written again we
1861                          * must make sure that the fastmap attach 
code doesn't
1862                          * find any outdated fastmap anchors, hence 
we erase the
1863                          * outdated fastmap anchor PEBs 
synchronously here.
1864                          */ 

1865                         if (aeb->vol_id == UBI_FM_SB_VOLUME_ID) 

1866                                 sync = true;

I think UBI attaches failed by fastmap if kernel goes here.
1870                         err = erase_aeb(ubi, aeb, sync);
