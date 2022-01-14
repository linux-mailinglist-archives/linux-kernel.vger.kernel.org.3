Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A148F016
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 19:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbiANSpn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jan 2022 13:45:43 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:53236 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiANSpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 13:45:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8538062DA5EE;
        Fri, 14 Jan 2022 19:45:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2yi8__Y-zI1Z; Fri, 14 Jan 2022 19:45:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B1DCB62DA5F5;
        Fri, 14 Jan 2022 19:45:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NHvsiMO3jAHb; Fri, 14 Jan 2022 19:45:39 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 850F462DA5EE;
        Fri, 14 Jan 2022 19:45:39 +0100 (CET)
Date:   Fri, 14 Jan 2022 19:45:39 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        kirill shutemov <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <23886736.260777.1642185939371.JavaMail.zimbra@nod.at>
In-Reply-To: <6815e4af-9b5b-313f-5828-644722dd4d1f@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com> <6f7df7ba-9557-58a3-7978-e5d14a72f234@huawei.com> <244238061.248369.1641886066066.JavaMail.zimbra@nod.at> <420c7567-8926-2e8b-4da0-a9bfc8379642@huawei.com> <11976804.249069.1641902225370.JavaMail.zimbra@nod.at> <0a7a5cce-1ee1-70b6-d368-615dfa0a617a@huawei.com> <1492514284.249466.1641909382867.JavaMail.zimbra@nod.at> <6815e4af-9b5b-313f-5828-644722dd4d1f@huawei.com>
Subject: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into
 'ai->fastmap' when fm->used_blocks>=2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF96 (Linux)/8.8.12_GA_3809)
Thread-Topic: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2
Thread-Index: qjDxBwu4U/Pr6n7nEomfbCBiAoFFQQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "mcoquelin stm32"
> <mcoquelin.stm32@gmail.com>, "kirill shutemov" <kirill.shutemov@linux.intel.com>, "Sascha Hauer"
> <s.hauer@pengutronix.de>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Mittwoch, 12. Januar 2022 04:46:28
> Betreff: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2

>>>> ubi_wl_init() is called in both cases, with and without fastmap.
>>> I agree.
>>>
>>>> And ai->fastmap contains all anchor PEBs that scan_fast() found.
>>>> This can be the most recent but also outdated anchor PEBs.
>>> Is it exists a case that outdated fastmap PEBs are neither counted into
>>> 'fmhdr->erase_peb_count' nor scanned into 'ai->fastmap' after attaching
>>> by fastmap.
>>>
>> 
>> [...]
>>   
>>> I think UBI attaches failed by fastmap if kernel goes here.
>>> 1870                         err = erase_aeb(ubi, aeb, sync);
>> 
>> Hmm, I think the paranoia check in fastmap.c is too strict these days.
>>          if (WARN_ON(count_fastmap_pebs(ai) != ubi->peb_count -
>>                      ai->bad_peb_count - fm->used_blocks))
>>                  goto fail_bad;
>> 
>> It does not account ai->fastmap. So if ai->fastmap contains old anchor PEBs
>> this check will trigger and force falling back to scanning mode.
>> With this check fixed, ubi_wl_init() will erase all old PEBs from ai->fastmap.
> Forgive my stubbornness, I think this strict check is good, could you
> show me a process to trigger this WARN_ON, it would be nice to provide a
> reproducer.

You can trigger this by interrupting UBI.
e.g. When UBI writes a new fastmap to the NAND, it schedules the old fastmap
PEBs for erasure. PEB erasure is asynchronous in UBI. So this can be delayed
for a very long time.
While developing UBI fastmap and performing powercut tests I saw this often
on targets.

> I still insist the point(after my fix patch applied): All outdated
> fastmap PEBs are added into 'ai->fastmap'(full scanning case) or counted
> into 'fmhdr->erase_peb_count'(fast attached case).

Yes. But if you look into ubi_wl_init() you see that fastmap anchor PEBs
get erases synchronously(!). The comment before the erasure explains why.
To complicate things, this code is currently unreachable because the WARN_ON()
is not right. I misses to count ai->fastmap.
So, when there are old fastmap PEBs found, the counter does not match
and UBI falls back to full scanning while it could to an attach by fastmap.

Fastmap is full with corner cases that have been found by massive amount of testing, sadly.

Thanks,
//richard
