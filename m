Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412E948F639
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 11:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiAOKB4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 15 Jan 2022 05:01:56 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:34734 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiAOKBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 05:01:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B9B6D614E2CD;
        Sat, 15 Jan 2022 11:01:53 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P38YeyIdWJ2O; Sat, 15 Jan 2022 11:01:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8C229614E2D5;
        Sat, 15 Jan 2022 11:01:52 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JOwiyE1gdgNZ; Sat, 15 Jan 2022 11:01:52 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 62EB3614E2CD;
        Sat, 15 Jan 2022 11:01:52 +0100 (CET)
Date:   Sat, 15 Jan 2022 11:01:52 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        kirill shutemov <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <626252388.262848.1642240912242.JavaMail.zimbra@nod.at>
In-Reply-To: <face6dce-d860-a7e6-fe9c-39f59cef22c5@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com> <11976804.249069.1641902225370.JavaMail.zimbra@nod.at> <0a7a5cce-1ee1-70b6-d368-615dfa0a617a@huawei.com> <1492514284.249466.1641909382867.JavaMail.zimbra@nod.at> <6815e4af-9b5b-313f-5828-644722dd4d1f@huawei.com> <23886736.260777.1642185939371.JavaMail.zimbra@nod.at> <88df000c-97a6-ff3f-a1e2-10fa4da8c604@huawei.com> <face6dce-d860-a7e6-fe9c-39f59cef22c5@huawei.com>
Subject: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into
 'ai->fastmap' when fm->used_blocks>=2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF96 (Linux)/8.8.12_GA_3809)
Thread-Topic: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2
Thread-Index: UBVQ5o9CerPStr2kIoVVEmrYehXG8Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "mcoquelin stm32"
> <mcoquelin.stm32@gmail.com>, "kirill shutemov" <kirill.shutemov@linux.intel.com>, "Sascha Hauer"
> <s.hauer@pengutronix.de>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Samstag, 15. Januar 2022 09:46:07
> Betreff: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2

>>> Yes. But if you look into ubi_wl_init() you see that fastmap anchor PEBs
>>> get erases synchronously(!). The comment before the erasure explains why.
>> About erasing fastmap anchor PEB synchronously, I admit curreunt UBI
>> implementation cannot satisfy it, even with my fix applied. Wait, it
>> seems that UBI has never made it sure. Old fastmap PEBs could be erased
>> asynchronously, they could be counted into 'fmh->erase_peb_count' even
>> in early UBI implementation code, so old fastmap anchor PEB will be
>> added into 'ai->erase' and be erased asynchronously in next attaching.
> In next attaching old fastmap PEBs will be processed as following:
> ubi_attach_fastmap -> add_aeb(ai, &ai->erase...)
> ubi_wl_init
>   list_for_each_entry_safe(aeb, tmp, &ai->erase)
>     erase_aeb       // erase asynchronously
>       ubi->lookuptbl[e->pnum] = e
>   list_for_each_entry(aeb, &ai->fastmap, u.list)
>     e = ubi_find_fm_block(ubi, aeb->pnum)
>     if (e) {
>        ...
>     } else {
>       if (ubi->lookuptbl[aeb->pnum])     // old fastmap PEBs are
> assigned to 'ubi->lookuptbl'
>         continue;
>     }
>> But, I feel it is not a problem, find_fm_anchor() can help us find out
> > the right fastmap anchor PEB according seqnum.

FYI, I think I understand now our disagreement.
You assume that old Fastmap PEBs are *guaranteed* to be part of Fastmap's erase list.
That's okay and this is what Linux as of today does.

My point is that we need to be paranoid and check carefully for old Fastmap PEBs
which might be *not* on the erase list.
I saw such issues in the wild. These were causes by old and/or buggy Fastmap
implementations.
Keep in mind that Linux is not the only system that implements UBI (and fastmap).

So let me give the whole situation another thought on how to improve it.
I totally agree with you that currently there is a problem with fm->used_blocks > 1.
I'm just careful (maybe too careful) about changing Fastmap code.

Thanks,
//richard
