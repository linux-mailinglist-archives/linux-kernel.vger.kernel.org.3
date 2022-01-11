Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C91248AEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbiAKN41 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jan 2022 08:56:27 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:49494 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241195AbiAKN40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:56:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 74D6962DA5E2;
        Tue, 11 Jan 2022 14:56:24 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YLrS9tLm1LzN; Tue, 11 Jan 2022 14:56:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2400C62DA609;
        Tue, 11 Jan 2022 14:56:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xPuhK_heLKGY; Tue, 11 Jan 2022 14:56:23 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id EC97562DA5E2;
        Tue, 11 Jan 2022 14:56:22 +0100 (CET)
Date:   Tue, 11 Jan 2022 14:56:22 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        kirill shutemov <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1492514284.249466.1641909382867.JavaMail.zimbra@nod.at>
In-Reply-To: <0a7a5cce-1ee1-70b6-d368-615dfa0a617a@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com> <20211227032246.2886878-13-chengzhihao1@huawei.com> <361758697.248157.1641857025490.JavaMail.zimbra@nod.at> <6f7df7ba-9557-58a3-7978-e5d14a72f234@huawei.com> <244238061.248369.1641886066066.JavaMail.zimbra@nod.at> <420c7567-8926-2e8b-4da0-a9bfc8379642@huawei.com> <11976804.249069.1641902225370.JavaMail.zimbra@nod.at> <0a7a5cce-1ee1-70b6-d368-615dfa0a617a@huawei.com>
Subject: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into
 'ai->fastmap' when fm->used_blocks>=2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2
Thread-Index: 86Vvr6wU5AK+5c62IIyzK5YFzlh8mg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "mcoquelin stm32"
> <mcoquelin.stm32@gmail.com>, "kirill shutemov" <kirill.shutemov@linux.intel.com>, "Sascha Hauer"
> <s.hauer@pengutronix.de>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Dienstag, 11. Januar 2022 14:23:52
> Betreff: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2

> 在 2022/1/11 19:57, Richard Weinberger 写道:
>> ubi_wl_init() is called in both cases, with and without fastmap.
> I agree.
> 
>> And ai->fastmap contains all anchor PEBs that scan_fast() found.
>> This can be the most recent but also outdated anchor PEBs.
> Is it exists a case that outdated fastmap PEBs are neither counted into
> 'fmhdr->erase_peb_count' nor scanned into 'ai->fastmap' after attaching
> by fastmap.
> 

[...]
 
> I think UBI attaches failed by fastmap if kernel goes here.
> 1870                         err = erase_aeb(ubi, aeb, sync);

Hmm, I think the paranoia check in fastmap.c is too strict these days.
        if (WARN_ON(count_fastmap_pebs(ai) != ubi->peb_count -
                    ai->bad_peb_count - fm->used_blocks))
                goto fail_bad;

It does not account ai->fastmap. So if ai->fastmap contains old anchor PEBs
this check will trigger and force falling back to scanning mode.
With this check fixed, ubi_wl_init() will erase all old PEBs from ai->fastmap.

So I agree that this code path is wonky and can be cleaned up. But please be
extremely careful and give all your changes excessive testing with real workload
and power-cuts.

Thanks,
//richard
