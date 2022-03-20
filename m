Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83284E1925
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 01:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244460AbiCTAaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 20:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiCTAaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 20:30:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AFDBF945
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 17:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647736132; x=1679272132;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sk+Jl2uyLb/5YInDvdg4DfBiqJe+0yEvXo3YA4uiDAQ=;
  b=VcP7FOqP5dMHjTp6d8dX/GdIWNXG7En8VTE7Wv39rnrYQwXD73yTVNOm
   FgrPQVP3SMS/P6fM1rDtU/byS/Jpn5eBKOva4Qp3TQRWnKj1m71AZSVMC
   stHVIax7euC962dkmRwm8l6lywPJYp9oeH5kBK0xNS/gcYwlzNkwbofy5
   6gg72MyIZxC7+8CdlFOFAlNP7wysnztmrxmRJWeaZiPa7sosQs9uk2iJF
   dWNC5UpUqcVitHkFmiNy9CzNL5DkO9+koti2KmylOgYAHnoEltZlsXzti
   AZW04GvB+m0DFJsGPsxTv5TgxT8qrhpqTPI34IctJzmHb5+idy1y7dHI/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="254905975"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="254905975"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 17:28:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="499741840"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2022 17:28:50 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVjRB-000GPB-Pd; Sun, 20 Mar 2022 00:28:49 +0000
Date:   Sun, 20 Mar 2022 08:28:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [amir73il:fsnotify-volatile 5/7] fs/notify/mark.c:709
 fsnotify_add_mark_locked() warn: inconsistent indenting
Message-ID: <202203200859.BcodfXSo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux fsnotify-volatile
head:   e477fc13ce51d96938aad656c53ca0a0e5dcc2be
commit: a41876bc2624aea256c40c2b3d7eff7fef383323 [5/7] fsnotify: allow adding an inode mark without pinning inode
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220320/202203200859.BcodfXSo-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
fs/notify/mark.c:709 fsnotify_add_mark_locked() warn: inconsistent indenting

vim +709 fs/notify/mark.c

   677	
   678	/*
   679	 * Attach an initialized mark to a given group and fs object.
   680	 * These marks may be used for the fsnotify backend to determine which
   681	 * event types should be delivered to which group.
   682	 */
   683	int fsnotify_add_mark_locked(struct fsnotify_mark *mark,
   684				     fsnotify_connp_t *connp, unsigned int obj_type,
   685				     int flags, __kernel_fsid_t *fsid)
   686	{
   687		struct fsnotify_group *group = mark->group;
   688		int ret = 0;
   689	
   690		BUG_ON(!mutex_is_locked(&group->mark_mutex));
   691	
   692		/*
   693		 * LOCKING ORDER!!!!
   694		 * group->mark_mutex
   695		 * mark->lock
   696		 * mark->connector->lock
   697		 */
   698		spin_lock(&mark->lock);
   699		mark->flags |= FSNOTIFY_MARK_FLAG_ALIVE | FSNOTIFY_MARK_FLAG_ATTACHED;
   700	
   701		list_add(&mark->g_list, &group->marks_list);
   702		fsnotify_get_mark(mark); /* for g_list */
   703		spin_unlock(&mark->lock);
   704	
   705		ret = fsnotify_add_mark_list(mark, connp, obj_type, flags, fsid);
   706		if (ret)
   707			goto err;
   708	
 > 709	       if (obj_type == FSNOTIFY_OBJ_TYPE_INODE &&
   710	           !(flags & FSNOTIFY_ADD_MARK_NO_IREF))
   711	               mark->flags |= FSNOTIFY_MARK_FLAG_WANT_IREF;
   712	
   713	       fsnotify_recalc_mask(mark->connector);
   714	
   715		return ret;
   716	err:
   717		spin_lock(&mark->lock);
   718		mark->flags &= ~(FSNOTIFY_MARK_FLAG_ALIVE |
   719				 FSNOTIFY_MARK_FLAG_ATTACHED);
   720		list_del_init(&mark->g_list);
   721		spin_unlock(&mark->lock);
   722	
   723		fsnotify_put_mark(mark);
   724		return ret;
   725	}
   726	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
