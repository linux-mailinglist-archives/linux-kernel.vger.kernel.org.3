Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F134F47099A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245714AbhLJTDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:03:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:54482 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237589AbhLJTDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639162819; x=1670698819;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CnTlDxz1/sH4dBADN+Rg7wetQcW+/sxhCFUXF0b01Ys=;
  b=nmKZSzUxQqjp0+KZUykTK7ca3Rncddil9+YkzLVuxHSO+td/ZcbzjBuA
   Jl1WZ8VIFYJi57iTXVPA7kZho7DzUeZimLAAG4rg+zi68cB8i7ppdPDvn
   oJluWUrMeH2m1xtzExVn59SejpS16+X8Q8MtW0ppULf+WDC3L6x4kpyLC
   BmFgI1toVZw2LFfALITGUoVqiaoJcaipp0KFQ0YjJVECndwNJUP1aiusz
   IpC4fGwzJeYraW01MIJVQ1iZh2kJZCCDHh4engV3MyTqUrfBU9VDCH0gU
   ip5amDkJNxYBm2RCHrU6Lbk4sWHHdalX7/QkXgN7N7r+0U3UM9Dz/BgNc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="235931591"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="235931591"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 11:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="462640231"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Dec 2021 11:00:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvl7v-0003Zx-EZ; Fri, 10 Dec 2021 19:00:15 +0000
Date:   Sat, 11 Dec 2021 02:59:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: [RFC PATCH] ext4: ext4_modify_primary_sb() can be static
Message-ID: <20211210185943.GA39725@eb09551c7cec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/ext4/ioctl.c:45:5: warning: symbol 'ext4_modify_primary_sb' was not declared. Should it be static?
fs/ext4/ioctl.c:165:5: warning: symbol 'ext4_modify_superblocks_fn' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 ioctl.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 285862288ecb5..5f5c0e62e4d3d 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -42,9 +42,9 @@ static void ext4_sb_setlabel(struct ext4_super_block *es, const void *arg)
 	memcpy(es->s_volume_name, (char *)arg, EXT4_LABEL_MAX);
 }
 
-int ext4_modify_primary_sb(struct super_block *sb, handle_t *handle,
-			   ext4_modify_sb_callback func,
-			   const void *arg)
+static int ext4_modify_primary_sb(struct super_block *sb, handle_t *handle,
+				  ext4_modify_sb_callback func,
+				  const void *arg)
 {
 	int err = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -162,9 +162,9 @@ static int ext4_update_backup_sb(struct super_block *sb, handle_t *handle,
  * This is safe because e2fsck will re-write them if there is a problem,
  * and we're very unlikely to ever need more than two backups.
  */
-int ext4_modify_superblocks_fn(struct super_block *sb,
-			       ext4_modify_sb_callback func,
-			       const void *arg)
+static int ext4_modify_superblocks_fn(struct super_block *sb,
+				      ext4_modify_sb_callback func,
+				      const void *arg)
 {
 	handle_t *handle;
 	ext4_group_t ngroups;
