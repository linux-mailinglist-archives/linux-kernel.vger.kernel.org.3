Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB648AD22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbiAKL5K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jan 2022 06:57:10 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:47536 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239328AbiAKL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:57:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C077C62DA5F1;
        Tue, 11 Jan 2022 12:57:06 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8N8Bh8g4hSgT; Tue, 11 Jan 2022 12:57:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AE98862DA607;
        Tue, 11 Jan 2022 12:57:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K3l-nBqFw9Lo; Tue, 11 Jan 2022 12:57:05 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 83EFC62DA5F1;
        Tue, 11 Jan 2022 12:57:05 +0100 (CET)
Date:   Tue, 11 Jan 2022 12:57:05 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        kirill shutemov <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <11976804.249069.1641902225370.JavaMail.zimbra@nod.at>
In-Reply-To: <420c7567-8926-2e8b-4da0-a9bfc8379642@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com> <20211227032246.2886878-13-chengzhihao1@huawei.com> <361758697.248157.1641857025490.JavaMail.zimbra@nod.at> <6f7df7ba-9557-58a3-7978-e5d14a72f234@huawei.com> <244238061.248369.1641886066066.JavaMail.zimbra@nod.at> <420c7567-8926-2e8b-4da0-a9bfc8379642@huawei.com>
Subject: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into
 'ai->fastmap' when fm->used_blocks>=2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2
Thread-Index: rCOpT4sWmQTdmQnL93nvG0YJPXMarw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "mcoquelin stm32"
> <mcoquelin.stm32@gmail.com>, "kirill shutemov" <kirill.shutemov@linux.intel.com>, "Sascha Hauer"
> <s.hauer@pengutronix.de>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Dienstag, 11. Januar 2022 12:44:49
> Betreff: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2

> Hi Richard,
>> In ubi_wl_init() there is another corner case documented:
>>                          /*
>>                           * The fastmap update code might not find a free PEB for
>>                           * writing the fastmap anchor to and then reuses the
>>                           * current fastmap anchor PEB. When this PEB gets erased
>>                           * and a power cut happens before it is written again we
>>                           * must make sure that the fastmap attach code doesn't
>>                           * find any outdated fastmap anchors, hence we erase the
>>                           * outdated fastmap anchor PEBs synchronously here.
>>                           */
>>                          if (aeb->vol_id == UBI_FM_SB_VOLUME_ID)
>>                                  sync = true;
>> 
>> So ubi_wl_init() makes sure that all old fastmap anchors get erased before UBI
>> starts to operate. With your change this is no longer satisfied
> I seem to understand the another case. But I'm still confused that why
> outdated fastmap PEBs cannot be erased. When UBI comes to this point, it
> means UBI is attached by **full scanning mode**, scan_fast() returns two
> values:
>   UBI_NO_FASTMAP: scan all pebs from pnum UBI_FM_MAX_START, ai is
> assigned with scan_ai, at last, all fastmap pebs are added into
> 'ai->fastmap'
>   UBI_BAD_FASTMAP: scan all pebs from pnum 0, all fastmap pebs are
> added into 'ai->fastmap'

I fear, I'm unable to follow your thoughts.
ubi_wl_init() is called in both cases, with and without fastmap.
And ai->fastmap contains all anchor PEBs that scan_fast() found.
This can be the most recent but also outdated anchor PEBs.

Thanks,
//richard
