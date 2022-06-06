Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9D053E868
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbiFFOCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbiFFOC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:02:28 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E3B13D30
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:02:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VFZTyX5_1654524138;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VFZTyX5_1654524138)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Jun 2022 22:02:20 +0800
Date:   Mon, 6 Jun 2022 22:02:18 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        Xiang Gao <xiang@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [xiang:erofs/initrd-fsdax 2/3] drivers/block/brd.c:466
 brd_alloc() warn: missing error code 'err'
Message-ID: <Yp4I6i5mFB1aHo62@B-P7TQMD6M-0146.local>
References: <202206062100.MJhGyCcE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202206062100.MJhGyCcE-lkp@intel.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Mon, Jun 06, 2022 at 04:56:13PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git erofs/initrd-fsdax
> head:   e04a723ce39c31ea57edfbfd70c867a2025910e3
> commit: a610c807a6b52cbce515911dba9b9cc316a6c117 [2/3] brd: support FSDAX
> config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220606/202206062100.MJhGyCcE-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/block/brd.c:466 brd_alloc() warn: missing error code 'err'

This still has many remaining works to do, many thanks for pointing
out!

Thanks,
Gao Xiang
 
> 
> vim +/err +466 drivers/block/brd.c
> 
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  407  static int brd_alloc(int i)
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  408  {
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  409  	struct brd_device *brd;
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  410  	struct gendisk *disk;
> f4be591f1436af Calvin Owens      2021-04-16  411  	char buf[DISK_NAME_LEN];
> e1528830bd4ebf Luis Chamberlain  2021-10-15  412  	int err = -ENOMEM;
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  413  
> 00358933f66c44 Tetsuo Handa      2022-01-06  414  	list_for_each_entry(brd, &brd_devices, brd_list)
> 00358933f66c44 Tetsuo Handa      2022-01-06  415  		if (brd->brd_number == i)
> f7bf35862477d6 Tetsuo Handa      2021-09-07  416  			return -EEXIST;
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  417  	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
> 00358933f66c44 Tetsuo Handa      2022-01-06  418  	if (!brd)
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  419  		return -ENOMEM;
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  420  	brd->brd_number		= i;
> f7bf35862477d6 Tetsuo Handa      2021-09-07  421  	list_add_tail(&brd->brd_list, &brd_devices);
> f7bf35862477d6 Tetsuo Handa      2021-09-07  422  
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  423  	spin_lock_init(&brd->brd_lock);
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  424  	INIT_RADIX_TREE(&brd->brd_pages, GFP_ATOMIC);
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  425  
> f4be591f1436af Calvin Owens      2021-04-16  426  	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
> f4be591f1436af Calvin Owens      2021-04-16  427  	if (!IS_ERR_OR_NULL(brd_debugfs_dir))
> f4be591f1436af Calvin Owens      2021-04-16  428  		debugfs_create_u64(buf, 0444, brd_debugfs_dir,
> f4be591f1436af Calvin Owens      2021-04-16  429  				&brd->brd_nr_pages);
> f4be591f1436af Calvin Owens      2021-04-16  430  
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  431  	disk = brd->brd_disk = blk_alloc_disk(NUMA_NO_NODE);
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  432  	if (!disk)
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  433  		goto out_free_dev;
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  434  
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  435  	disk->major		= RAMDISK_MAJOR;
> 937af5ecd0591e Boaz Harrosh      2015-01-07  436  	disk->first_minor	= i * max_part;
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  437  	disk->minors		= max_part;
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  438  	disk->fops		= &brd_fops;
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  439  	disk->private_data	= brd;
> f4be591f1436af Calvin Owens      2021-04-16  440  	strlcpy(disk->disk_name, buf, DISK_NAME_LEN);
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  441  	set_capacity(disk, rd_size * 2);
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  442  	
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  443  	/*
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  444  	 * This is so fdisk will align partitions on 4k, because of
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  445  	 * direct_access API needing 4k alignment, returning a PFN
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  446  	 * (This is only a problem on very small devices <= 4M,
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  447  	 *  otherwise fdisk will align on 1M. Regardless this call
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  448  	 *  is harmless)
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  449  	 */
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  450  	blk_queue_physical_block_size(disk->queue, PAGE_SIZE);
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  451  
> 316ba5736c9caa SeongJae Park     2018-05-03  452  	/* Tell the block layer that this is not a rotational device */
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  453  	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  454  	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
> a610c807a6b52c Gao Xiang         2022-06-05  455  
> a610c807a6b52c Gao Xiang         2022-06-05  456  	if (enable_fsdax)
> a610c807a6b52c Gao Xiang         2022-06-05  457  		blk_queue_flag_set(QUEUE_FLAG_DAX, disk->queue);
> e1528830bd4ebf Luis Chamberlain  2021-10-15  458  	err = add_disk(disk);
> e1528830bd4ebf Luis Chamberlain  2021-10-15  459  	if (err)
> e1528830bd4ebf Luis Chamberlain  2021-10-15  460  		goto out_cleanup_disk;
> 316ba5736c9caa SeongJae Park     2018-05-03  461  
> a610c807a6b52c Gao Xiang         2022-06-05  462  	if (enable_fsdax) {
> a610c807a6b52c Gao Xiang         2022-06-05  463  		brd->dax_dev = alloc_dax(brd, &brd_dax_ops);
> a610c807a6b52c Gao Xiang         2022-06-05  464  		if (IS_ERR(brd->dax_dev)) {
> 
> err = PTR_ERR(brd->dax_dev)
> 
> a610c807a6b52c Gao Xiang         2022-06-05  465  			brd->dax_dev = NULL;
> a610c807a6b52c Gao Xiang         2022-06-05 @466  			goto out_del_gendisk;
> a610c807a6b52c Gao Xiang         2022-06-05  467  		}
> a610c807a6b52c Gao Xiang         2022-06-05  468  		set_dax_nocache(brd->dax_dev);
> a610c807a6b52c Gao Xiang         2022-06-05  469  		set_dax_nomc(brd->dax_dev);
> a610c807a6b52c Gao Xiang         2022-06-05  470  		run_dax(brd->dax_dev);
> a610c807a6b52c Gao Xiang         2022-06-05  471  		if (dax_add_host(brd->dax_dev, disk))
> a610c807a6b52c Gao Xiang         2022-06-05  472  			goto out_del_gendisk;
> 
> 
> err = dax_add_host(brd->dax_dev, disk);
> if (err)
> 	goto out_del_gendisk;
> 
> a610c807a6b52c Gao Xiang         2022-06-05  473  	}
> 7f9b348cb5e942 Christoph Hellwig 2021-05-21  474  	return 0;
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  475  
> a610c807a6b52c Gao Xiang         2022-06-05  476  out_del_gendisk:
> a610c807a6b52c Gao Xiang         2022-06-05  477  	del_gendisk(disk);
> e1528830bd4ebf Luis Chamberlain  2021-10-15  478  out_cleanup_disk:
> e1528830bd4ebf Luis Chamberlain  2021-10-15  479  	blk_cleanup_disk(disk);
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  480  out_free_dev:
> f7bf35862477d6 Tetsuo Handa      2021-09-07  481  	list_del(&brd->brd_list);
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  482  	kfree(brd);
> e1528830bd4ebf Luis Chamberlain  2021-10-15  483  	return err;
> 9db5579be4bb53 Nicholas Piggin   2008-02-08  484  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
