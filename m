Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B054505E38
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347563AbiDRTHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347547AbiDRTHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:07:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5588E0F9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650308690; x=1681844690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J9VvQL42SpJnRvPSS6QEDjgJIqaeva7Wxmt6WTX2J60=;
  b=AKiTB815VsSbRxekVexXbsg0i34+xW7pKCn4wFNO2sCK1nOwGCwfyn5q
   TTKmB1//lYNMqlVWsO6X24R5XDltNH5avw4eEgihkbEmt4NoGrY3s2JRH
   +psl89qJ8LZWMstoOyrXW98eX2UwwC6GB2rKBQV8TsRXJmZJLyI/NP0Qz
   uRjj+niQXz3DnlGnM7Cv4ZLVps73NmfhEsTbRs/MdGAfx2E1yiq/6fujI
   sX/u7CPr70A/e1A8EExDRfYH/EFhW7PWrIwTw8/flPaFvgTCF2csegdzW
   QexFcvaaSls5ajILzWHqiZkbOYRARp+YExQfm/v5WJ54nZaf6G6MEQLno
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="324033163"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="324033163"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 12:04:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="646970194"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Apr 2022 12:04:47 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngWg2-0004tu-UD;
        Mon, 18 Apr 2022 19:04:46 +0000
Date:   Tue, 19 Apr 2022 03:03:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, jasowang@redhat.com
Cc:     kbuild-all@lists.01.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, si-wei.liu@oracle.com,
        Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v2 2/2] vdpa/mlx5: Add support for reading descriptor
 statistics
Message-ID: <202204190335.6x3ZxWPL-lkp@intel.com>
References: <20220412130402.46945-3-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412130402.46945-3-elic@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eli,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.18-rc3 next-20220414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Eli-Cohen/Show-statistics-for-a-vdpa-device/20220412-212129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
config: i386-randconfig-s001-20220418 (https://download.01.org/0day-ci/archive/20220419/202204190335.6x3ZxWPL-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/3d9eba4c8d59370c862469b93e157cd72a49d6ad
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eli-Cohen/Show-statistics-for-a-vdpa-device/20220412-212129
        git checkout 3d9eba4c8d59370c862469b93e157cd72a49d6ad
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/vdpa/mlx5/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/vdpa/mlx5/net/mlx5_vnet.c:2583:19: sparse: sparse: cast to restricted __le16
>> drivers/vdpa/mlx5/net/mlx5_vnet.c:2583:19: sparse: sparse: cast from restricted __virtio16

vim +2583 drivers/vdpa/mlx5/net/mlx5_vnet.c

  2542	
  2543	static int mlx5_vdpa_get_vendor_vq_stats(struct vdpa_device *vdev, u16 idx,
  2544						 struct sk_buff *msg,
  2545						 struct netlink_ext_ack *extack)
  2546	{
  2547		struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
  2548		struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
  2549		struct mlx5_vdpa_virtqueue *mvq;
  2550		struct mlx5_control_vq *cvq;
  2551		u64 received_desc;
  2552		u64 completed_desc;
  2553		int err = 0;
  2554		u16 max_vqp;
  2555	
  2556		mutex_lock(&ndev->numq_lock);
  2557		if (!is_index_valid(mvdev, idx)) {
  2558			NL_SET_ERR_MSG_MOD(extack, "virtqueue index is not valid");
  2559			err = -EINVAL;
  2560			goto out_err;
  2561		}
  2562	
  2563		if (idx == ctrl_vq_idx(mvdev)) {
  2564			cvq = &mvdev->cvq;
  2565			received_desc = cvq->received_desc;
  2566			completed_desc = cvq->completed_desc;
  2567			goto out;
  2568		}
  2569	
  2570		mvq = &ndev->vqs[idx];
  2571		err = counter_set_query(ndev, mvq, &received_desc, &completed_desc);
  2572		if (err) {
  2573			NL_SET_ERR_MSG_MOD(extack, "failed to query hardware");
  2574			goto out_err;
  2575		}
  2576	
  2577	out:
  2578		err = -EMSGSIZE;
  2579		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
  2580				      mvdev->actual_features, VDPA_ATTR_PAD))
  2581			goto out_err;
  2582	
> 2583		max_vqp = le16_to_cpu(ndev->config.max_virtqueue_pairs);
  2584		if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
  2585			goto out_err;
  2586	
  2587		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "received_desc"))
  2588			goto out_err;
  2589	
  2590		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, received_desc,
  2591				      VDPA_ATTR_PAD))
  2592			goto out_err;
  2593	
  2594		if (nla_put_string(msg, VDPA_ATTR_DEV_VENDOR_ATTR_NAME, "completed_desc"))
  2595			goto out_err;
  2596	
  2597		if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_ATTR_VALUE, completed_desc,
  2598				      VDPA_ATTR_PAD))
  2599			goto out_err;
  2600	
  2601		err = 0;
  2602	out_err:
  2603		mutex_unlock(&ndev->numq_lock);
  2604		return err;
  2605	}
  2606	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
