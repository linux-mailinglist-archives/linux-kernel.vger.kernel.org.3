Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28C049005B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 03:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiAQCwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 21:52:45 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31093 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiAQCwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 21:52:44 -0500
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jcbvc3twnz1FCgc;
        Mon, 17 Jan 2022 10:49:00 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 10:52:42 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 17 Jan 2022 10:52:41 +0800
Subject: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into
 'ai->fastmap' when fm->used_blocks>=2
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        "kirill shutemov" <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com>
 <11976804.249069.1641902225370.JavaMail.zimbra@nod.at>
 <0a7a5cce-1ee1-70b6-d368-615dfa0a617a@huawei.com>
 <1492514284.249466.1641909382867.JavaMail.zimbra@nod.at>
 <6815e4af-9b5b-313f-5828-644722dd4d1f@huawei.com>
 <23886736.260777.1642185939371.JavaMail.zimbra@nod.at>
 <88df000c-97a6-ff3f-a1e2-10fa4da8c604@huawei.com>
 <face6dce-d860-a7e6-fe9c-39f59cef22c5@huawei.com>
 <626252388.262848.1642240912242.JavaMail.zimbra@nod.at>
 <89fd8bab-3c12-f76d-b23f-f41ea8fc2dd7@huawei.com>
Message-ID: <e5f5093e-bddc-21d6-df96-d62654cf5b4f@huawei.com>
Date:   Mon, 17 Jan 2022 10:52:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <89fd8bab-3c12-f76d-b23f-f41ea8fc2dd7@huawei.com>
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
>> FYI, I think I understand now our disagreement.
>> You assume that old Fastmap PEBs are *guaranteed* to be part of 
>> Fastmap's erase list.
>> That's okay and this is what Linux as of today does.
>>
>> My point is that we need to be paranoid and check carefully for old 
>> Fastmap PEBs
>> which might be *not* on the erase list.
>> I saw such issues in the wild. These were causes by old and/or buggy 
>> Fastmap
>> implementations.
>> Keep in mind that Linux is not the only system that implements UBI 
>> (and fastmap).
> Uh, that is really a point, I met UBI implemented in Vxworks ever. Now, 
> you convinced me, we should process fastmap with considering bad 
> images(caused by other implementations). Let's keep this wonky assertion 
> until a better fix.
>>
>> So let me give the whole situation another thought on how to improve it.
>> I totally agree with you that currently there is a problem with 
>> fm->used_blocks > 1.
>> I'm just careful (maybe too careful) about changing Fastmap code.
>>I reconsider the WARNON, it can recognize the bad images and fall back 
full scanning mode early. If linux kernel encounters the WARNON, it 
means something wrong with your image(caused by bad UBI implementation). 
I begin to like this strict check.
After comparing WARNON with the assertion:
   WARN_ON(count_fastmap_pebs(ai) != ubi->peb_count - ai->bad_peb_count 
- fm->used_blocks)
   ubi_assert(ubi->good_peb_count == found_pebs)
The 'found_pebs' consists of 'ai->erase', 'ai->free', 'ai->volumes' and 
'ai->fastmap'. The count_fastmap_pebs() includes 'ai->erase', 'ai->free' 
and 'ai->volumes'. This means the number of 'ai->fastmap' equals to 
'fm->used_blocks'. So, the 'ai->fastmap' adding position in my fix is right.
In a word, can you accept the point that 'WARNON' can help us recognize 
the bad fastmap images?
