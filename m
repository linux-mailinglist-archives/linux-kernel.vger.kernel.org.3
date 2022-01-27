Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190FD49E72C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbiA0QOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:14:06 -0500
Received: from mga18.intel.com ([134.134.136.126]:21232 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231837AbiA0QOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643300044; x=1674836044;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9sBRbPhGRh+5zTGkUtnpvYVAFT73r07rWof8d3nlFx8=;
  b=VOqBGWz0Sdu6OpuSnr0iY2odrXfIRaijcEsNhmhRck3zAakzW5yVdzxn
   c4x/zGJp8yKPM5/KwmTRbp3eECGroOVwpHIlie02LuncfHFBIvj82Ld9l
   ENBNB08TASkP0cmkGOlSWES7/j4uTmD0oMccSPAKMnt2yWNZkHm51rvF+
   drnyRP+CK2GcwTtdJG2dAoB8MwPERDhe8P0i6ASwxy7Z0gUEhanLI0DGK
   I1UEUCIfpU/o08aP4QcK6UczK4HonkbC0OaXFH9fnf+Ff2JXs91bkY4an
   fT/Kb34c2UOA3tCBRdZ58GLpOk+PbKsUsXu4ovn8TuCmi7mdXZHNWKVJb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230473640"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="230473640"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 08:14:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="581520083"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jan 2022 08:14:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD7PN-000Mm2-VF; Thu, 27 Jan 2022 16:14:01 +0000
Date:   Fri, 28 Jan 2022 00:13:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/ath/wcn36xx/smd.c:2921
 wcn36xx_smd_gtk_offload_get_info_rsp() warn: inconsistent indenting
Message-ID: <202201280013.Y65nbcSD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
commit: bedf1169bcae2f762b37d40dc9db648fe7ad1952 wcn36xx: Add GTK offload info to WoWLAN resume
date:   8 months ago
config: microblaze-randconfig-m031-20220127 (https://download.01.org/0day-ci/archive/20220128/202201280013.Y65nbcSD-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/net/wireless/ath/wcn36xx/smd.c:2921 wcn36xx_smd_gtk_offload_get_info_rsp() warn: inconsistent indenting

Old smatch warnings:
drivers/net/wireless/ath/wcn36xx/smd.c:525 wcn36xx_smd_load_nv() error: we previously assumed 'wcn->nv' could be null (see line 516)
drivers/net/wireless/ath/wcn36xx/smd.c:1908 wcn36xx_smd_send_beacon() warn: potential spectre issue 'msg_body.beacon' [w]
arch/microblaze/include/asm/thread_info.h:91 current_thread_info() error: uninitialized symbol 'sp'.

vim +2921 drivers/net/wireless/ath/wcn36xx/smd.c

  2896	
  2897	static int wcn36xx_smd_gtk_offload_get_info_rsp(struct wcn36xx *wcn,
  2898							struct ieee80211_vif *vif)
  2899	{
  2900		struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
  2901		struct wcn36xx_hal_gtk_offload_get_info_rsp_msg *rsp;
  2902		__be64 replay_ctr;
  2903	
  2904		if (wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len))
  2905			return -EIO;
  2906	
  2907		rsp = (struct wcn36xx_hal_gtk_offload_get_info_rsp_msg *)wcn->hal_buf;
  2908	
  2909		if (rsp->bss_index != vif_priv->bss_index) {
  2910			wcn36xx_err("gtk_offload_info invalid response bss index %d\n",
  2911				    rsp->bss_index);
  2912			return -ENOENT;
  2913		}
  2914	
  2915		if (vif_priv->rekey_data.replay_ctr != cpu_to_le64(rsp->key_replay_counter)) {
  2916			replay_ctr = cpu_to_be64(rsp->key_replay_counter);
  2917			vif_priv->rekey_data.replay_ctr =
  2918				cpu_to_le64(rsp->key_replay_counter);
  2919			ieee80211_gtk_rekey_notify(vif, vif->bss_conf.bssid,
  2920						   (void *)&replay_ctr, GFP_KERNEL);
> 2921			 wcn36xx_dbg(WCN36XX_DBG_HAL,
  2922				     "GTK replay counter increment %llu\n",
  2923				     rsp->key_replay_counter);
  2924		}
  2925	
  2926		wcn36xx_dbg(WCN36XX_DBG_HAL,
  2927			    "gtk offload info status %d last_rekey_status %d "
  2928			    "replay_counter %llu total_rekey_count %d gtk_rekey_count %d "
  2929			    "igtk_rekey_count %d bss_index %d\n",
  2930			    rsp->status, rsp->last_rekey_status,
  2931			    rsp->key_replay_counter, rsp->total_rekey_count,
  2932			    rsp->gtk_rekey_count, rsp->igtk_rekey_count,
  2933			    rsp->bss_index);
  2934	
  2935		return 0;
  2936	}
  2937	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
