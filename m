Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21604BDED6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381199AbiBUQrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:47:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245115AbiBUQrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:47:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24C01EAD4;
        Mon, 21 Feb 2022 08:47:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 621B06135D;
        Mon, 21 Feb 2022 16:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E7DC340E9;
        Mon, 21 Feb 2022 16:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645462036;
        bh=AKWS2/X5VCCVXLw6Gqauj6ebOImrQ8nyklKgb7ms/BI=;
        h=From:To:Cc:Subject:Date:From;
        b=jrEafFtRqa2vcSWXzwuY2at2+LbMEdHx+ixkaIVJU9zH8JAYY2YoMFCIZPkzPgBjs
         rJB8/MMfWmi0awr8EKZUvqN6u+agFKl4PtvLZyJ3CEbePJPQs1ShDxTwPkId8ghLum
         +0GCiy6cR76rSBuiMApMuVz0b6ayp9l/T+jNenU94EKHPgJL9P9tOIKtsrC+tIC5vt
         6fco/2XXMo3Xv0/8ej/dhJAKppcbZSDQhRD3RothUC+oHFvIvBNvuMvToRrIWjL+vR
         W4MfDYhkQZmYfWtaFtVUxkwUi00uT8gxxQCZPgjtXhA+NlN0hrBpqWq6CLLLZNwrdu
         ivb6mMTdaYDOA==
From:   broonie@kernel.org
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Satya Tangirala <satyat@google.com>
Subject: linux-next: manual merge of the block tree with the fscrypt tree
Date:   Mon, 21 Feb 2022 16:47:13 +0000
Message-Id: <20220221164713.2475459-1-broonie@kernel.org>
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

Today's linux-next merge of the block tree got a conflict in:

  fs/iomap/direct-io.c

between commit:

  489734ef94f4f ("iomap: support direct I/O with fscrypt using blk-crypto")

from the fscrypt tree and commit:

  07888c665b405 ("block: pass a block_device and opf to bio_alloc")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc fs/iomap/direct-io.c
index 20325b3926fa3,e2ba13645ef28..0000000000000
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@@ -185,10 -183,7 +185,9 @@@ static void iomap_dio_zero(const struc
  	int flags = REQ_SYNC | REQ_IDLE;
  	struct bio *bio;
  
- 	bio = bio_alloc(GFP_KERNEL, 1);
+ 	bio = bio_alloc(iter->iomap.bdev, 1, REQ_OP_WRITE | flags, GFP_KERNEL);
 +	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 +				  GFP_KERNEL);
- 	bio_set_dev(bio, iter->iomap.bdev);
  	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
  	bio->bi_private = dio;
  	bio->bi_end_io = iomap_dio_bio_end_io;
@@@ -313,10 -307,7 +311,9 @@@ static loff_t iomap_dio_bio_iter(const 
  			goto out;
  		}
  
- 		bio = bio_alloc(GFP_KERNEL, nr_pages);
+ 		bio = bio_alloc(iomap->bdev, nr_pages, bio_opf, GFP_KERNEL);
 +		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
 +					  GFP_KERNEL);
- 		bio_set_dev(bio, iomap->bdev);
  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
  		bio->bi_write_hint = dio->iocb->ki_hint;
  		bio->bi_ioprio = dio->iocb->ki_ioprio;
