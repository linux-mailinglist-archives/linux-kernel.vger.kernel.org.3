Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2543757D06A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiGUP45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiGUP44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:56:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F8D74375;
        Thu, 21 Jul 2022 08:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658419015; x=1689955015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QwZO/Xjp3zERZ/KdehU+Hfcs6MWLQnHKtr7MnKEit28=;
  b=AuD0usq02OrfutEXe0VHlx8LDUAHQDMQPc4QBhxTEyhPyV/wf/nwDzrY
   UDoxOPKuSaPars11zWgRMC6gdqTB8mQp2R8J/CD9yJDcz5bgnT54wtSk2
   2DVLtfPxyCmvRi+AZSenaSryOmtAU8ol82kGVK9TmozbHzoi4qm+0xd6E
   9zUxBLaYQhhpItQwp/DyLs90/v7/nRZD+QbOjZ3CUd4cFUfBsDXjSVcTL
   bXPvqnZLM37jc923RPTporWt9QAhhuZT72kmiMelctrx7DcwkX4Vx6bhS
   9e0wiQs8un8RWuQv66zOIC+MvlwhSqASyNFmEXSSchJKspkw8zxmlCr0A
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267483757"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="267483757"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 08:56:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="631221043"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2022 08:56:38 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEYXW-0000JK-16;
        Thu, 21 Jul 2022 15:56:38 +0000
Date:   Thu, 21 Jul 2022 23:55:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, kishon@ti.com, dianders@chromium.org,
        s.shtylyov@omp.ru, mka@chromium.org, ming.lei@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, tonywwang@zhaoxin.com,
        weitaowang@zhaoxin.com, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com
Subject: Re: [PATCH] USB: HCD: Fix URB giveback issue in tasklet function
Message-ID: <202207212305.50JoL7V2-lkp@intel.com>
References: <20220721060833.4173-1-WeitaoWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721060833.4173-1-WeitaoWang-oc@zhaoxin.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weitao,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on linus/master v5.19-rc7 next-20220721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Weitao-Wang/USB-HCD-Fix-URB-giveback-issue-in-tasklet-function/20220721-144208
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220721/202207212305.50JoL7V2-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/302398ba5a76bb39957bad7a6a8cb9d0429cd43a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Weitao-Wang/USB-HCD-Fix-URB-giveback-issue-in-tasklet-function/20220721-144208
        git checkout 302398ba5a76bb39957bad7a6a8cb9d0429cd43a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/usb/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/core/hcd.c: In function 'usb_giveback_urb_bh':
>> drivers/usb/core/hcd.c:1694:2: warning: label 'restart' defined but not used [-Wunused-label]
    1694 |  restart:
         |  ^~~~~~~


vim +/restart +1694 drivers/usb/core/hcd.c

94dfd7edfd5c9b Ming Lei    2013-07-03  1686  
e71ea55a5b6f91 Allen Pais  2020-08-17  1687  static void usb_giveback_urb_bh(struct tasklet_struct *t)
94dfd7edfd5c9b Ming Lei    2013-07-03  1688  {
e71ea55a5b6f91 Allen Pais  2020-08-17  1689  	struct giveback_urb_bh *bh = from_tasklet(bh, t, bh);
94dfd7edfd5c9b Ming Lei    2013-07-03  1690  	struct list_head local_list;
94dfd7edfd5c9b Ming Lei    2013-07-03  1691  
94dfd7edfd5c9b Ming Lei    2013-07-03  1692  	spin_lock_irq(&bh->lock);
94dfd7edfd5c9b Ming Lei    2013-07-03  1693  	bh->running = true;
94dfd7edfd5c9b Ming Lei    2013-07-03 @1694   restart:
94dfd7edfd5c9b Ming Lei    2013-07-03  1695  	list_replace_init(&bh->head, &local_list);
94dfd7edfd5c9b Ming Lei    2013-07-03  1696  	spin_unlock_irq(&bh->lock);
94dfd7edfd5c9b Ming Lei    2013-07-03  1697  
94dfd7edfd5c9b Ming Lei    2013-07-03  1698  	while (!list_empty(&local_list)) {
94dfd7edfd5c9b Ming Lei    2013-07-03  1699  		struct urb *urb;
94dfd7edfd5c9b Ming Lei    2013-07-03  1700  
94dfd7edfd5c9b Ming Lei    2013-07-03  1701  		urb = list_entry(local_list.next, struct urb, urb_list);
94dfd7edfd5c9b Ming Lei    2013-07-03  1702  		list_del_init(&urb->urb_list);
c7ccde6eac6d3c Alan Stern  2013-09-03  1703  		bh->completing_ep = urb->ep;
94dfd7edfd5c9b Ming Lei    2013-07-03  1704  		__usb_hcd_giveback_urb(urb);
c7ccde6eac6d3c Alan Stern  2013-09-03  1705  		bh->completing_ep = NULL;
94dfd7edfd5c9b Ming Lei    2013-07-03  1706  	}
94dfd7edfd5c9b Ming Lei    2013-07-03  1707  
302398ba5a76bb Weitao Wang 2022-07-21  1708  	/* giveback new URBs next time to prevent this function from
302398ba5a76bb Weitao Wang 2022-07-21  1709  	 * not exiting for a long time.
302398ba5a76bb Weitao Wang 2022-07-21  1710  	 */
94dfd7edfd5c9b Ming Lei    2013-07-03  1711  	spin_lock_irq(&bh->lock);
302398ba5a76bb Weitao Wang 2022-07-21  1712  	if (!list_empty(&bh->head)) {
302398ba5a76bb Weitao Wang 2022-07-21  1713  		if (bh->hi_priority)
302398ba5a76bb Weitao Wang 2022-07-21  1714  			tasklet_hi_schedule(&bh->bh);
302398ba5a76bb Weitao Wang 2022-07-21  1715  		else
302398ba5a76bb Weitao Wang 2022-07-21  1716  			tasklet_schedule(&bh->bh);
302398ba5a76bb Weitao Wang 2022-07-21  1717  	}
94dfd7edfd5c9b Ming Lei    2013-07-03  1718  	bh->running = false;
94dfd7edfd5c9b Ming Lei    2013-07-03  1719  	spin_unlock_irq(&bh->lock);
94dfd7edfd5c9b Ming Lei    2013-07-03  1720  }
94dfd7edfd5c9b Ming Lei    2013-07-03  1721  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
