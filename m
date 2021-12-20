Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8FC47B36A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbhLTTGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:06:03 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60766 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhLTTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:06:01 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKJ5sku026183;
        Mon, 20 Dec 2021 13:05:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640027154;
        bh=UfAsvJvzGobRHWOzTq52zbMaISk7igct9boBOIHzTg8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=KEIsXT/xlC8/bM+CkvvlLnDfNxo1P2ywNq6L1ATSEfow0qZD2KAYAQINyeNKiynlh
         0J8kfzoZDkdIwxv/ZHTmK/ehrcccnUs5wINzVz0C+tCg4FhD4VHJ3RRApYgDpelydg
         oso6RPdvbT7os9p/WsgNc3AQl/VJPek2ERhAyY2I=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKJ5sOX080372
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 13:05:54 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 13:05:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 13:05:53 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKJ5qU7015235;
        Mon, 20 Dec 2021 13:05:53 -0600
Date:   Tue, 21 Dec 2021 00:35:52 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <zhuohao@chromium.org>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: core: Remove partid and partname debugfs files
Message-ID: <20211220190550.rejayqmhem5gwq5d@ti.com>
References: <20211217122636.474976-1-tudor.ambarus@microchip.com>
 <20211217122636.474976-3-tudor.ambarus@microchip.com>
 <20211220130743.jil62qbyb5lgds6p@ti.com>
 <25999218-8985-03fc-c53d-21bd2a25d365@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <25999218-8985-03fc-c53d-21bd2a25d365@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/21 01:23PM, Tudor.Ambarus@microchip.com wrote:
> On 12/20/21 3:07 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 17/12/21 02:26PM, Tudor Ambarus wrote:
> >> partid and partname debugfs file are no longer used in mtd, remove
> 
> s/file/files
> 
> >> dead code.
> > 
> > Hmm, spi-nor was the only user? Quick grepping does confirm that.
> 
> Yes.
> 
> > 
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >>  drivers/mtd/mtdcore.c   | 35 +----------------------------------
> >>  include/linux/mtd/mtd.h |  3 ---
> >>  2 files changed, 1 insertion(+), 37 deletions(-)
> >>
> >> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> >> index 9186268d361b..1977755fc955 100644
> >> --- a/drivers/mtd/mtdcore.c
> >> +++ b/drivers/mtd/mtdcore.c
> >> @@ -336,49 +336,16 @@ static const struct device_type mtd_devtype = {
> >>       .release        = mtd_release,
> >>  };
> >>
> >> -static int mtd_partid_debug_show(struct seq_file *s, void *p)
> >> -{
> >> -     struct mtd_info *mtd = s->private;
> >> -
> >> -     seq_printf(s, "%s\n", mtd->dbg.partid);
> >> -
> >> -     return 0;
> >> -}
> >> -
> >> -DEFINE_SHOW_ATTRIBUTE(mtd_partid_debug);
> >> -
> >> -static int mtd_partname_debug_show(struct seq_file *s, void *p)
> >> -{
> >> -     struct mtd_info *mtd = s->private;
> >> -
> >> -     seq_printf(s, "%s\n", mtd->dbg.partname);
> >> -
> >> -     return 0;
> >> -}
> >> -
> >> -DEFINE_SHOW_ATTRIBUTE(mtd_partname_debug);
> >> -
> >>  static struct dentry *dfs_dir_mtd;
> >>
> >>  static void mtd_debugfs_populate(struct mtd_info *mtd)
> >>  {
> >> -     struct mtd_info *master = mtd_get_master(mtd);
> >>       struct device *dev = &mtd->dev;
> >> -     struct dentry *root;
> >>
> >>       if (IS_ERR_OR_NULL(dfs_dir_mtd))
> >>               return;
> >>
> >> -     root = debugfs_create_dir(dev_name(dev), dfs_dir_mtd);
> >> -     mtd->dbg.dfs_dir = root;
> >> -
> >> -     if (master->dbg.partid)
> >> -             debugfs_create_file("partid", 0400, root, master,
> >> -                                 &mtd_partid_debug_fops);
> >> -
> >> -     if (master->dbg.partname)
> >> -             debugfs_create_file("partname", 0400, root, master,
> >> -                                 &mtd_partname_debug_fops);
> >> +     mtd->dbg.dfs_dir = debugfs_create_dir(dev_name(dev), dfs_dir_mtd);
> > 
> > What is the point of having creating the directory if there is not going
> > to be anything in it at all? I think we should drop the entire thing if
> There will be files in it: mtdswap_stats, nandsim_wear_report, docg3 files.
> 
> $ git grep dbg.dfs_dir drivers/mtd/
> drivers/mtd/devices/docg3.c:    struct dentry *root = floor->dbg.dfs_dir;
> drivers/mtd/mtdcore.c:  mtd->dbg.dfs_dir = root;
> drivers/mtd/mtdcore.c:          debugfs_remove_recursive(mtd->dbg.dfs_dir);
> drivers/mtd/mtdswap.c:  struct dentry *root = d->mtd->dbg.dfs_dir;
> drivers/mtd/nand/raw/nandsim.c: struct dentry *root = nsmtd->dbg.dfs_dir;
> drivers/mtd/ubi/debug.c:                debugfs_remove_recursive(ubi->dbg.dfs_dir);

Ok, I didn't see that. In that case,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
