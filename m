Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73DB4BECDB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiBUV7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:59:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiBUV7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:59:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584D122BD9;
        Mon, 21 Feb 2022 13:59:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F17F3B8179E;
        Mon, 21 Feb 2022 21:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0852C340E9;
        Mon, 21 Feb 2022 21:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645480757;
        bh=Y9EBJMBOb1MRmHPeo2PIe4iMaumaEzn/v6ZKpHrdCqk=;
        h=From:To:Cc:Subject:Date:From;
        b=KUzFhgwLAqAxLKEj/mzdeQTBr02mQOWZOetFNzw9mSGrMWOOFmtQCrSRbKS5UI+vw
         VMRmRYiCpzCra9dhFKCOrte2twahoS7XKLkWiIX6WGGUmTLFUsJvPWN3hRNY3UhVsA
         ahFdz1MiJ6/roGP6z2806uzxQoHEG9UZ8YXpu7Tbnt7dNjO1cmzxVm/viQ129d3+1e
         SMfdtDkJpZxLrARn8LJEIIjS6LewhJuy1Da9MwO2jUjwFLTLVG7/s/XQ+mZb7FLgxm
         zJvcny6Ry0LIHjkwiaCaKsa3Ues4hoPs1d/aubtR2rqFtKEUQXQtVjHcakTA9NYim2
         EHeYy1DyzhKIQ==
From:   broonie@kernel.org
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Gioh Kim <gi-oh.kim@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Md Haris Iqbal <haris.iqbal@ionos.com>
Subject: linux-next: manual merge of the scsi-mkp tree with the block tree
Date:   Mon, 21 Feb 2022 21:59:11 +0000
Message-Id: <20220221215911.2948692-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/block/rnbd/rnbd-clt.c

between commit:

  448025c103938 ("block/rnbd: client device does not care queue/rotational")

from the block tree and commit:

  e8e9884730b36 ("scsi: rnbd: Remove WRITE_SAME support")

from the scsi-mkp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/block/rnbd/rnbd-clt.c
index 1f63f308eb394,dc192d2738854..0000000000000
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@@ -1606,13 -1607,13 +1603,13 @@@ struct rnbd_clt_dev *rnbd_clt_map_devic
  	}
  
  	rnbd_clt_info(dev,
- 		       "map_device: Device mapped as %s (nsectors: %zu, logical_block_size: %d, physical_block_size: %d, max_write_same_sectors: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n",
 -		       "map_device: Device mapped as %s (nsectors: %zu, logical_block_size: %d, physical_block_size: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, rotational: %d, wc: %d, fua: %d)\n",
++		       "map_device: Device mapped as %s (nsectors: %zu, logical_block_size: %d, physical_block_size: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n",
  		       dev->gd->disk_name, dev->nsectors,
  		       dev->logical_block_size, dev->physical_block_size,
- 		       dev->max_write_same_sectors, dev->max_discard_sectors,
+ 		       dev->max_discard_sectors,
  		       dev->discard_granularity, dev->discard_alignment,
  		       dev->secure_discard, dev->max_segments,
 -		       dev->max_hw_sectors, dev->rotational, dev->wc, dev->fua);
 +		       dev->max_hw_sectors, dev->wc, dev->fua);
  
  	mutex_unlock(&dev->lock);
  	rnbd_clt_put_sess(sess);
