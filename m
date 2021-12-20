Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B4D47AA20
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhLTNH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:07:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52064 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhLTNHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:07:55 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKD7lTe026049;
        Mon, 20 Dec 2021 07:07:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640005667;
        bh=ohMqcHmhPR2W84Kq5KfuGTpt5lRbxI9i5rlrzdyRZas=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=n5hnrovOsteBiBdxbOuGmyvO4gDTrEO0MFY7HxKjkvZge4C0ZEAZPQcT+ybwwR1Rg
         2NbKwiPKu74vqyw8M2kgBdUTJeYLvhcxYlA4DMznhiVYEbQjx4BvcTbEs9hWbfxk5c
         xgq/D6+uYd+W3rwT8BJ7AJ7COxAf2geMKFQeuaHo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKD7lUb050347
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 07:07:47 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 07:07:46 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 07:07:46 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKD7kI9128275;
        Mon, 20 Dec 2021 07:07:46 -0600
Date:   Mon, 20 Dec 2021 18:37:45 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <zhuohao@chromium.org>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: core: Remove partid and partname debugfs files
Message-ID: <20211220130743.jil62qbyb5lgds6p@ti.com>
References: <20211217122636.474976-1-tudor.ambarus@microchip.com>
 <20211217122636.474976-3-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211217122636.474976-3-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/21 02:26PM, Tudor Ambarus wrote:
> partid and partname debugfs file are no longer used in mtd, remove
> dead code.

Hmm, spi-nor was the only user? Quick grepping does confirm that.

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/mtdcore.c   | 35 +----------------------------------
>  include/linux/mtd/mtd.h |  3 ---
>  2 files changed, 1 insertion(+), 37 deletions(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 9186268d361b..1977755fc955 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -336,49 +336,16 @@ static const struct device_type mtd_devtype = {
>  	.release	= mtd_release,
>  };
>  
> -static int mtd_partid_debug_show(struct seq_file *s, void *p)
> -{
> -	struct mtd_info *mtd = s->private;
> -
> -	seq_printf(s, "%s\n", mtd->dbg.partid);
> -
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(mtd_partid_debug);
> -
> -static int mtd_partname_debug_show(struct seq_file *s, void *p)
> -{
> -	struct mtd_info *mtd = s->private;
> -
> -	seq_printf(s, "%s\n", mtd->dbg.partname);
> -
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(mtd_partname_debug);
> -
>  static struct dentry *dfs_dir_mtd;
>  
>  static void mtd_debugfs_populate(struct mtd_info *mtd)
>  {
> -	struct mtd_info *master = mtd_get_master(mtd);
>  	struct device *dev = &mtd->dev;
> -	struct dentry *root;
>  
>  	if (IS_ERR_OR_NULL(dfs_dir_mtd))
>  		return;
>  
> -	root = debugfs_create_dir(dev_name(dev), dfs_dir_mtd);
> -	mtd->dbg.dfs_dir = root;
> -
> -	if (master->dbg.partid)
> -		debugfs_create_file("partid", 0400, root, master,
> -				    &mtd_partid_debug_fops);
> -
> -	if (master->dbg.partname)
> -		debugfs_create_file("partname", 0400, root, master,
> -				    &mtd_partname_debug_fops);
> +	mtd->dbg.dfs_dir = debugfs_create_dir(dev_name(dev), dfs_dir_mtd);

What is the point of having creating the directory if there is not going 
to be anything in it at all? I think we should drop the entire thing if 
there is no intention of using it.

>  }
>  
>  #ifndef CONFIG_MMU
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index f5e7dfc2e4e9..00cb269d0261 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -188,9 +188,6 @@ struct module;	/* only needed for owner field in mtd_info */
>   */
>  struct mtd_debug_info {
>  	struct dentry *dfs_dir;
> -
> -	const char *partname;
> -	const char *partid;
>  };
>  
>  /**
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
