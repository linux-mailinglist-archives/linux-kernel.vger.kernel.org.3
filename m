Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B248A866
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiAKH1u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jan 2022 02:27:50 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:43618 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiAKH1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:27:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 59D8E614E2C4;
        Tue, 11 Jan 2022 08:27:47 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uuSnmgFaZ1C8; Tue, 11 Jan 2022 08:27:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 46CB0614E2CB;
        Tue, 11 Jan 2022 08:27:46 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YYWVwdluUz5c; Tue, 11 Jan 2022 08:27:46 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 201D2614E2C4;
        Tue, 11 Jan 2022 08:27:46 +0100 (CET)
Date:   Tue, 11 Jan 2022 08:27:46 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        kirill shutemov <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <244238061.248369.1641886066066.JavaMail.zimbra@nod.at>
In-Reply-To: <6f7df7ba-9557-58a3-7978-e5d14a72f234@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com> <20211227032246.2886878-13-chengzhihao1@huawei.com> <361758697.248157.1641857025490.JavaMail.zimbra@nod.at> <6f7df7ba-9557-58a3-7978-e5d14a72f234@huawei.com>
Subject: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into
 'ai->fastmap' when fm->used_blocks>=2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2
Thread-Index: CDXmZfwm9pTEbBCtB4asuKSA+LK6HQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "mcoquelin stm32"
> <mcoquelin.stm32@gmail.com>, "kirill shutemov" <kirill.shutemov@linux.intel.com>, "Sascha Hauer"
> <s.hauer@pengutronix.de>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Dienstag, 11. Januar 2022 03:48:24
> Betreff: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2

> Hi Richard,
>> scan_ai->fastmap may contain also old fastmap PEBs.
>> In the area < UBI_FM_MAX_START you can find outdated fastmap PEBs.
>> e.g. after power-cut.
>> That's why scan_ai->fastmap is copied into ai->fastmap.
>> Later in ubi_wl_init() these outdated PEBs will get erased.
>> So, you cannot remove this code.
> I thought old fastmap PEBs(async erase works in ubi_update_fastmap())
> will be counted into erase PEBs in the next attaching process, because I
> saw following code snippet in ubi_write_fastmap():
> 1260         list_for_each_entry(ubi_wrk, &ubi->works, list) {
> 
> 1261                 if (ubi_is_erase_work(ubi_wrk)) {
> 
> 1262                         wl_e = ubi_wrk->e;
> 
> 1263                         ubi_assert(wl_e);
> 
> 1264
> 
> 1265                         fec = (struct ubi_fm_ec *)(fm_raw +
> fm_pos);
> 1266
> 
> 1267                         fec->pnum = cpu_to_be32(wl_e->pnum);
> 
> 1268                         set_seen(ubi, wl_e->pnum, seen_pebs);
> 
> 1269                         fec->ec = cpu_to_be32(wl_e->ec);
> 
> 1270
> 
> 1271                         erase_peb_count++;
> 
> 1272                         fm_pos += sizeof(*fec);
> 
> 1273                         ubi_assert(fm_pos <= ubi->fm_size);
> 
> 1274                 }
> 
> 1275         }
> 
> 1276         fmh->erase_peb_count = cpu_to_be32(erase_peb_count);
> Half-writing on fastmap will be recognized in scanning, and UBI
> fallbacks full scanning, So, I come up with two situations:
> 1. power-cut before new fastmap written, the old fastmap is completely
> saved until next attaching, and some free PEBs are written with new
> fastmap data. Luckly, fastmap anchor PEB's vid header is written first
> of all, bad fastmap will be returned by ubi_attach_fastmap() in next
> attaching.
> 2. power-cut after new fastmap written, the old fastmap PEBs will be
> added into 'ai->erase' list in next attaching.
> Did I miss other possible circumstances?

In ubi_wl_init() there is another corner case documented:
                        /*
                         * The fastmap update code might not find a free PEB for
                         * writing the fastmap anchor to and then reuses the
                         * current fastmap anchor PEB. When this PEB gets erased
                         * and a power cut happens before it is written again we
                         * must make sure that the fastmap attach code doesn't
                         * find any outdated fastmap anchors, hence we erase the
                         * outdated fastmap anchor PEBs synchronously here.
                         */
                        if (aeb->vol_id == UBI_FM_SB_VOLUME_ID)
                                sync = true;

So ubi_wl_init() makes sure that all old fastmap anchors get erased before UBI
starts to operate. With your change this is no longer satisfied.

Thanks,
//richard
