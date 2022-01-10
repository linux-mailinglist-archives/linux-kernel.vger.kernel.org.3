Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F41E48A38A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbiAJXXu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 18:23:50 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:37904 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiAJXXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:23:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A39DB62DA5E9;
        Tue, 11 Jan 2022 00:23:46 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BniRRL-__YE9; Tue, 11 Jan 2022 00:23:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C774F62DA5FB;
        Tue, 11 Jan 2022 00:23:45 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g8Rg32oBvwvf; Tue, 11 Jan 2022 00:23:45 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 98F0862DA5E9;
        Tue, 11 Jan 2022 00:23:45 +0100 (CET)
Date:   Tue, 11 Jan 2022 00:23:45 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        mcoquelin stm32 <mcoquelin.stm32@gmail.com>,
        kirill shutemov <kirill.shutemov@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <361758697.248157.1641857025490.JavaMail.zimbra@nod.at>
In-Reply-To: <20211227032246.2886878-13-chengzhihao1@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com> <20211227032246.2886878-13-chengzhihao1@huawei.com>
Subject: Re: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into
 'ai->fastmap' when fm->used_blocks>=2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2
Thread-Index: 51VyhLwOOPkpCJ1OyaFQh0d2LFOdvw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> "mcoquelin stm32" <mcoquelin.stm32@gmail.com>, "kirill shutemov" <kirill.shutemov@linux.intel.com>, "Sascha Hauer"
> <s.hauer@pengutronix.de>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Montag, 27. Dezember 2021 04:22:43
> Betreff: [PATCH v6 12/15] ubi: fastmap: Add all fastmap pebs into 'ai->fastmap' when fm->used_blocks>=2

> Fastmap pebs(pnum >= UBI_FM_MAX_START) won't be added into 'ai->fastmap'
> while attaching ubi device if 'fm->used_blocks' is greater than 2, which
> may cause warning from 'ubi_assert(ubi->good_peb_count == found_pebs)':
> 
>  UBI assert failed in ubi_wl_init at 1878 (pid 2409)
>  Call Trace:
>    ubi_wl_init.cold+0xae/0x2af [ubi]
>    ubi_attach+0x1b0/0x780 [ubi]
>    ubi_init+0x23a/0x3ad [ubi]
>    load_module+0x22d2/0x2430
> 
> Reproduce:
>  ID="0x20,0x33,0x00,0x00" # 16M 16KB PEB, 512 page
>  modprobe nandsim id_bytes=$ID
>  modprobe ubi mtd="0,0" fm_autoconvert  # Fastmap takes 2 pebs
>  rmmod ubi
>  modprobe ubi mtd="0,0" fm_autoconvert  # Attach by fastmap
> 
> Add all used fastmap pebs into list 'ai->fastmap' to make sure they can
> be counted into 'found_pebs'.
> 
> Fixes: fdf10ed710c0aa ("ubi: Rework Fastmap attach base code")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
> drivers/mtd/ubi/fastmap.c | 35 +++++------------------------------
> 1 file changed, 5 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
> index 6b5f1ffd961b..01dcdd94c9d2 100644
> --- a/drivers/mtd/ubi/fastmap.c
> +++ b/drivers/mtd/ubi/fastmap.c
> /**
>  * ubi_scan_fastmap - scan the fastmap.
>  * @ubi: UBI device object
> @@ -865,7 +847,6 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct
> ubi_attach_info *ai,
> 	struct ubi_vid_hdr *vh;
> 	struct ubi_ec_hdr *ech;
> 	struct ubi_fastmap_layout *fm;
> -	struct ubi_ainf_peb *aeb;
> 	int i, used_blocks, pnum, fm_anchor, ret = 0;
> 	size_t fm_size;
> 	__be32 crc, tmp_crc;
> @@ -875,17 +856,6 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct
> ubi_attach_info *ai,
> 	if (fm_anchor < 0)
> 		return UBI_NO_FASTMAP;
> 
> -	/* Copy all (possible) fastmap blocks into our new attach structure. */
> -	list_for_each_entry(aeb, &scan_ai->fastmap, u.list) {
> -		struct ubi_ainf_peb *new;
> -
> -		new = clone_aeb(ai, aeb);
> -		if (!new)
> -			return -ENOMEM;
> -
> -		list_add(&new->u.list, &ai->fastmap);
> -	}
> -

scan_ai->fastmap may contain also old fastmap PEBs.
In the area < UBI_FM_MAX_START you can find outdated fastmap PEBs.
e.g. after power-cut.
That's why scan_ai->fastmap is copied into ai->fastmap.
Later in ubi_wl_init() these outdated PEBs will get erased.
So, you cannot remove this code.

But I fully agree with you that the fm->used_blocks > 1 case is not correct.
I fear if scan_ai->fastmap contains old fastmap PEBs and fm->used_blocks is > 1
we need to fall back to scanning mode while attaching.

Thanks,
//richard
