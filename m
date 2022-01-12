Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8701B48BDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349246AbiALDqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:46:33 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16702 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiALDqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:46:32 -0500
Received: from kwepemi100007.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JYYL55rV8zZdY4;
        Wed, 12 Jan 2022 11:42:53 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100007.china.huawei.com (7.221.188.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 11:46:29 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 11:46:29 +0800
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
 <0a7a5cce-1ee1-70b6-d368-615dfa0a617a@huawei.com>
 <1492514284.249466.1641909382867.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <6815e4af-9b5b-313f-5828-644722dd4d1f@huawei.com>
Date:   Wed, 12 Jan 2022 11:46:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1492514284.249466.1641909382867.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> ubi_wl_init() is called in both cases, with and without fastmap.
>> I agree.
>>
>>> And ai->fastmap contains all anchor PEBs that scan_fast() found.
>>> This can be the most recent but also outdated anchor PEBs.
>> Is it exists a case that outdated fastmap PEBs are neither counted into
>> 'fmhdr->erase_peb_count' nor scanned into 'ai->fastmap' after attaching
>> by fastmap.
>>
> 
> [...]
>   
>> I think UBI attaches failed by fastmap if kernel goes here.
>> 1870                         err = erase_aeb(ubi, aeb, sync);
> 
> Hmm, I think the paranoia check in fastmap.c is too strict these days.
>          if (WARN_ON(count_fastmap_pebs(ai) != ubi->peb_count -
>                      ai->bad_peb_count - fm->used_blocks))
>                  goto fail_bad;
> 
> It does not account ai->fastmap. So if ai->fastmap contains old anchor PEBs
> this check will trigger and force falling back to scanning mode.
> With this check fixed, ubi_wl_init() will erase all old PEBs from ai->fastmap.
Forgive my stubbornness, I think this strict check is good, could you 
show me a process to trigger this WARN_ON, it would be nice to provide a 
reproducer.
I still insist the point(after my fix patch applied): All outdated 
fastmap PEBs are added into 'ai->fastmap'(full scanning case) or counted 
into 'fmhdr->erase_peb_count'(fast attached case).
> 
> So I agree that this code path is wonky and can be cleaned up. But please be
> extremely careful and give all your changes excessive testing with real workload
> and power-cuts.Let's list all power-cut cases during fastmap updateing(I tried to 
simulate some of them on nandsim), in theory, I think the WARN_ON check 
is okay and all outdated fastmap PEBs can be erased in next attaching:

ubi_update_fastmap:
1565         for (i = 1; i < new_fm->used_blocks; i++) {
1570                 if (!tmp_e) {
1571                         if (old_fm && old_fm->e[i]) {
                              /* sync erase old fm data PEBs */
power-cut!!!
1585                         } else {
                              /* async erase old fm data PEBs */
power-cut!!!
1595                         }
1596                 } else {
1599                         if (old_fm && old_fm->e[i]) {
			     /* async erase old fm data PEBs */
power-cut!!!
1603                         }
1604                 }
1605         }
1621         if (old_fm) {
1623                 if (!tmp_e) {
  		     /* sync erase old fm anchor PEB */
power-cut!!!
1638                 } else {
		     /* async erase old fm anchor PEB */
power-cut!!!
1644                 }
1645         } else {
1658         }
1660         ret = ubi_write_fastmap(ubi, new_fm);

ubi_write_fastmap:
1324         ret = ubi_io_write_vid_hdr(ubi, new_fm->e[0]->pnum, avbuf);
power-cut!!!
1345         for (i = 1; i < new_fm->used_blocks; i++) {
1350                 ret = ubi_io_write_vid_hdr(...);
power-cut!!!
1356         }

1358         for (i = 0; i < new_fm->used_blocks; i++) {
1359                 ret = ubi_io_write_data(...),
power-cut!!!
1366         }
