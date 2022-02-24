Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0264C2D85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbiBXNqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiBXNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:46:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5026F4E6;
        Thu, 24 Feb 2022 05:46:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD74561B38;
        Thu, 24 Feb 2022 13:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4884C340E9;
        Thu, 24 Feb 2022 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645710365;
        bh=jnbdT8UDAZtAA54FrGhoPcolloNf7HRAUDbtYfwfctw=;
        h=From:To:Cc:Subject:Date:From;
        b=IZrqtq2kceQS0Sq/mXjgWYuG/quLzDYr5v0h0g4VvsREdaekkp+FMtShpRfUNSGTS
         1WIqmWBTkrWPqKLKuhDqisz1YeQJzLkCq9IMN8xPFgeBAuAkmMNf32u0ApbO9Wr0DX
         Pl7/dtQrhGSKQHkybcvZ7OOwIJuQjLOE8xZW0+VxTxtoHcVI0AJRUVajJGJhBtIFsR
         csu01x5+6DlNYc7zKoL1WvSkbfmfD8KDPeuU7qMlVuq0Ba4DovHY8mEvaq//wKnbNt
         g8W5tHvwc4RvGnOq2Q3yUs1gasJVOI3PvnzmhDdWpa0XqYK/zLC0oOy14LvyTFMOh1
         t6SBPIzc2LkPQ==
From:   broonie@kernel.org
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>,
        =?UTF-8?q?D=C4=81vis=20Mos=C4=81ns?= <davispuh@gmail.com>
Subject: linux-next: manual merge of the btrfs tree with the btrfs-fixes tree
Date:   Thu, 24 Feb 2022 13:44:27 +0000
Message-Id: <20220224134427.3208381-1-broonie@kernel.org>
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

Today's linux-next merge of the btrfs tree got conflicts in:

  fs/btrfs/ctree.h
  fs/btrfs/file.c
  fs/btrfs/inode.c
  fs/btrfs/ioctl.c
  fs/btrfs/lzo.c

between commit:

  2ac3e062af024 ("btrfs: reduce extent threshold for autodefrag")
  741b23a970a79 ("btrfs: prevent copying too big compressed lzo segment")
  26fbac2517fca ("btrfs: autodefrag: only scan one inode once")
  966d879bafaaf ("btrfs: defrag: allow defrag_one_cluster() to skip large extent which is not a target")
  d5633b0dee02d ("btrfs: defrag: bring back the old file extent search behavior")

from the btrfs-fixes tree and commit:

  13b2f7ab699a5 ("btrfs: close the gap between inode_should_defrag() and autodefrag extent size threshold")
  48b433a2ef82a ("btrfs: add lzo workspace buffer length constants")
  db360c49d476f ("btrfs: autodefrag: only scan one inode once")
  e6c69fcbee7ef ("btrfs: defrag: use control structure in btrfs_defrag_file()")
  6b17743d934ec ("btrfs: defrag: bring back the old file extent search behavior")

from the btrfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc fs/btrfs/ctree.h
index 947f04789389e,5a569bc756c3c..0000000000000
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
diff --cc fs/btrfs/file.c
index 01111ee06e1ef,8815981447034..0000000000000
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
diff --cc fs/btrfs/inode.c
index 76e530f76e3cf,44e8d28182b7f..0000000000000
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
diff --cc fs/btrfs/ioctl.c
index 8d47ec5fc4f44,998bf48e5ce29..0000000000000
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@@ -1435,16 -1460,16 +1461,23 @@@ static int defrag_collect_targets(struc
  			goto add;
  
  		/* Skip too large extent */
- 		if (range_len >= extent_thresh)
+ 		if (range_len >= ctrl->extent_thresh)
+ 			goto next;
+ 
+ 		/*
+ 		 * Skip extents already at its max capacity, this is mostly for
+ 		 * compressed extents, which max cap is only 128K.
+ 		 */
+ 		if (em->len >= get_extent_max_capacity(em))
  			goto next;
  
 +		/*
 +		 * Skip extents already at its max capacity, this is mostly for
 +		 * compressed extents, which max cap is only 128K.
 +		 */
 +		if (em->len >= get_extent_max_capacity(em))
 +			goto next;
 +
  		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
  							  locked);
  		if (!next_mergeable) {
@@@ -1683,19 -1715,11 +1723,20 @@@ static int defrag_one_cluster(struct bt
  			break;
  		}
  
- 		if (max_sectors)
+ 		if (ctrl->max_sectors_to_defrag)
  			range_len = min_t(u32, range_len,
- 				(max_sectors - *sectors_defragged) * sectorsize);
+ 					  (ctrl->max_sectors_to_defrag -
+ 					   ctrl->sectors_defragged) * sectorsize);
  
 +		/*
 +		 * If defrag_one_range() has updated last_scanned_ret,
 +		 * our range may already be invalid (e.g. hole punched).
 +		 * Skip if our range is before last_scanned_ret, as there is
 +		 * no need to defrag the range anymore.
 +		 */
 +		if (entry->start + range_len <= *last_scanned_ret)
 +			continue;
 +
  		if (ra)
  			page_cache_sync_readahead(inode->vfs_inode.i_mapping,
  				ra, NULL, entry->start >> PAGE_SHIFT,
@@@ -1834,13 -1879,11 +1898,10 @@@ int btrfs_defrag_file(struct inode *ino
  			break;
  		}
  		if (do_compress)
- 			BTRFS_I(inode)->defrag_compress = compress_type;
- 		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
- 				cluster_end + 1 - cur, extent_thresh,
- 				newer_than, do_compress, &sectors_defragged,
- 				max_to_defrag, &last_scanned);
 -			BTRFS_I(inode)->defrag_compress = ctrl->compress;
+ 		ret = defrag_one_cluster(BTRFS_I(inode), ra, ctrl, cur,
+ 					 cluster_end + 1 - cur);
  
- 		if (sectors_defragged > prev_sectors_defragged)
+ 		if (ctrl->sectors_defragged > prev_sectors_defragged)
  			balance_dirty_pages_ratelimited(inode->i_mapping);
  
  		btrfs_inode_unlock(inode, 0);
diff --cc fs/btrfs/lzo.c
index e6e28a9c79877,430ad36b8b080..0000000000000
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c


diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7d3542893a165..5ef7c08b24b89 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1734,7 +1734,7 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 		 * Skip if our range is before last_scanned_ret, as there is
 		 * no need to defrag the range anymore.
 		 */
-		if (entry->start + range_len <= *last_scanned_ret)
+		if (entry->start + range_len <= ctrl->last_scanned)
 			continue;
 
 		if (ra)
@@ -1760,7 +1760,7 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 		kfree(entry);
 	}
 	if (ret >= 0)
-		*last_scanned_ret = max(*last_scanned_ret, start + len);
+		ctrl->last_scanned = max(ctrl->last_scanned, start + len);
 	return ret;
 }
 
