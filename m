Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A21B587A8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiHBKSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiHBKSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:18:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECBB4C616;
        Tue,  2 Aug 2022 03:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659435497; x=1690971497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l50721CoO65cvD9qwtVMJ23IicYwmfGIz60g+6zQApo=;
  b=IJPrU68SSESUsKoNSWh5lAv+vJ2ECanQkrSgu0RCrVVX+naWfl6Vbxh3
   8SOG5jEjKZ40tyfxqDflP31HYGj/gJHbPtpTL6YxBFOtfGL8gkUI+opZK
   1bUFoe7I8HRObD7+m8WIQCL3bXjARAqn64tuWaAhRKJhmR6v9UhMS5nbl
   LXqIg4qOGgtFaJ8GNi1lwKK6Decm0YfO01tcghtIyGqzwNlg8JfiQxGm8
   nGHLpgUts/OE9p8IqFr/WiTtn4PoVOhMqQVlI11o1U8aqDdO0ZZH0QA6O
   UjWVcuE5MIs2B6H/Sj3m8brxiUL75wLo8gaaZO3np1flPFbQyF1UTq2tb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="269142495"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="269142495"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 03:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="744616976"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2022 03:18:13 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oIoyb-000FwL-0t;
        Tue, 02 Aug 2022 10:18:13 +0000
Date:   Tue, 2 Aug 2022 18:17:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniil Lunev <dlunev@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Chu <chu.stanley@gmail.com>
Cc:     kbuild-all@lists.01.org, Daniil Lunev <dlunev@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3] ufs: core: ufshcd: use local_clock() for debugging
 timestamps
Message-ID: <202208021848.n995UITS-lkp@intel.com>
References: <20220802103230.v3.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802103230.v3.1.I699244ea7efbd326a34a6dfd9b5a31e78400cf68@changeid>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniil,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jejb-scsi/for-next]
[also build test ERROR on mkp-scsi/for-next linus/master v5.19 next-20220728]
[cannot apply to bvanassche/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniil-Lunev/ufs-core-ufshcd-use-local_clock-for-debugging-timestamps/20220802-083420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
config: i386-randconfig-a013-20220801 (https://download.01.org/0day-ci/archive/20220802/202208021848.n995UITS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c72f82f12e7c9f361f0d13d4ab583f9834384464
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Daniil-Lunev/ufs-core-ufshcd-use-local_clock-for-debugging-timestamps/20220802-083420
        git checkout c72f82f12e7c9f361f0d13d4ab583f9834384464
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/ufs/core/ufshcd.o: in function `ufshcd_print_evt':
>> drivers/ufs/core/ufshcd.c:460: undefined reference to `__udivdi3'
   ld: drivers/ufs/core/ufshcd.o: in function `ufshcd_print_host_state':
   drivers/ufs/core/ufshcd.c:568: undefined reference to `__udivdi3'
>> ld: drivers/ufs/core/ufshcd.c:572: undefined reference to `__udivdi3'
   ld: drivers/ufs/core/ufshcd.o: in function `ufshcd_print_trs':
   drivers/ufs/core/ufshcd.c:505: undefined reference to `__udivdi3'
   ld: drivers/ufs/core/ufshcd.c:507: undefined reference to `__udivdi3'


vim +460 drivers/ufs/core/ufshcd.c

ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  442  
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  443  static void ufshcd_print_evt(struct ufs_hba *hba, u32 id,
35d11ec239e099 drivers/ufs/core/ufshcd.c Krzysztof Kozlowski 2022-06-23  444  			     const char *err_name)
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  445  {
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  446  	int i;
27752647f88a1b drivers/scsi/ufs/ufshcd.c Stanley Chu         2019-01-28  447  	bool found = false;
35d11ec239e099 drivers/ufs/core/ufshcd.c Krzysztof Kozlowski 2022-06-23  448  	const struct ufs_event_hist *e;
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  449  
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  450  	if (id >= UFS_EVT_CNT)
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  451  		return;
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  452  
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  453  	e = &hba->ufs_stats.event[id];
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  454  
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  455  	for (i = 0; i < UFS_EVENT_HIST_LENGTH; i++) {
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  456  		int p = (i + e->pos) % UFS_EVENT_HIST_LENGTH;
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  457  
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  458  		if (e->tstamp[p] == 0)
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  459  			continue;
c5397f13fc744b drivers/scsi/ufs/ufshcd.c Stanley Chu         2019-07-10 @460  		dev_err(hba->dev, "%s[%d] = 0x%x at %lld us\n", err_name, p,
c72f82f12e7c9f drivers/ufs/core/ufshcd.c Daniil Lunev        2022-08-02  461  			e->val[p], e->tstamp[p] / 1000);
27752647f88a1b drivers/scsi/ufs/ufshcd.c Stanley Chu         2019-01-28  462  		found = true;
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  463  	}
27752647f88a1b drivers/scsi/ufs/ufshcd.c Stanley Chu         2019-01-28  464  
27752647f88a1b drivers/scsi/ufs/ufshcd.c Stanley Chu         2019-01-28  465  	if (!found)
fd1fb4d5562a87 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-01-04  466  		dev_err(hba->dev, "No record of %s\n", err_name);
bafd09f8d8ec0a drivers/scsi/ufs/ufshcd.c DooHyun Hwang       2021-02-03  467  	else
bafd09f8d8ec0a drivers/scsi/ufs/ufshcd.c DooHyun Hwang       2021-02-03  468  		dev_err(hba->dev, "%s: total cnt=%llu\n", err_name, e->cnt);
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  469  }
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  470  
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  471  static void ufshcd_print_evt_hist(struct ufs_hba *hba)
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  472  {
ba80917d9932da drivers/scsi/ufs/ufshcd.c Tomas Winkler       2018-06-14  473  	ufshcd_dump_regs(hba, 0, UFSHCI_REG_SPACE_SIZE, "host_regs: ");
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  474  
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  475  	ufshcd_print_evt(hba, UFS_EVT_PA_ERR, "pa_err");
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  476  	ufshcd_print_evt(hba, UFS_EVT_DL_ERR, "dl_err");
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  477  	ufshcd_print_evt(hba, UFS_EVT_NL_ERR, "nl_err");
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  478  	ufshcd_print_evt(hba, UFS_EVT_TL_ERR, "tl_err");
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  479  	ufshcd_print_evt(hba, UFS_EVT_DME_ERR, "dme_err");
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  480  	ufshcd_print_evt(hba, UFS_EVT_AUTO_HIBERN8_ERR,
d3c615bf586f27 drivers/scsi/ufs/ufshcd.c Stanley Chu         2019-07-10  481  			 "auto_hibern8_err");
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  482  	ufshcd_print_evt(hba, UFS_EVT_FATAL_ERR, "fatal_err");
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  483  	ufshcd_print_evt(hba, UFS_EVT_LINK_STARTUP_FAIL,
8808b4e9dcdc90 drivers/scsi/ufs/ufshcd.c Stanley Chu         2019-07-10  484  			 "link_startup_fail");
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  485  	ufshcd_print_evt(hba, UFS_EVT_RESUME_ERR, "resume_fail");
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  486  	ufshcd_print_evt(hba, UFS_EVT_SUSPEND_ERR,
8808b4e9dcdc90 drivers/scsi/ufs/ufshcd.c Stanley Chu         2019-07-10  487  			 "suspend_fail");
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  488  	ufshcd_print_evt(hba, UFS_EVT_DEV_RESET, "dev_reset");
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  489  	ufshcd_print_evt(hba, UFS_EVT_HOST_RESET, "host_reset");
e965e5e00b23c4 drivers/scsi/ufs/ufshcd.c Stanley Chu         2020-12-05  490  	ufshcd_print_evt(hba, UFS_EVT_ABORT, "task_abort");
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  491  
7c486d91f3d191 drivers/scsi/ufs/ufshcd.c Stanley Chu         2019-12-24  492  	ufshcd_vops_dbg_register_dump(hba);
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  493  }
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  494  
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  495  static
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  496  void ufshcd_print_trs(struct ufs_hba *hba, unsigned long bitmap, bool pr_prdt)
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  497  {
35d11ec239e099 drivers/ufs/core/ufshcd.c Krzysztof Kozlowski 2022-06-23  498  	const struct ufshcd_lrb *lrbp;
7fabb77b3aa016 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  499  	int prdt_length;
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  500  	int tag;
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  501  
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  502  	for_each_set_bit(tag, &bitmap, hba->nutrs) {
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  503  		lrbp = &hba->lrb[tag];
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  504  
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  505  		dev_err(hba->dev, "UPIU[%d] - issue time %lld us\n",
c72f82f12e7c9f drivers/ufs/core/ufshcd.c Daniil Lunev        2022-08-02  506  				tag, lrbp->issue_time_stamp_local_clock / 1000);
090171885f505e drivers/scsi/ufs/ufshcd.c Zang Leigang        2017-09-27  507  		dev_err(hba->dev, "UPIU[%d] - complete time %lld us\n",
c72f82f12e7c9f drivers/ufs/core/ufshcd.c Daniil Lunev        2022-08-02  508  				tag, lrbp->compl_time_stamp_local_clock / 1000);
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  509  		dev_err(hba->dev,
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  510  			"UPIU[%d] - Transfer Request Descriptor phys@0x%llx\n",
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  511  			tag, (u64)lrbp->utrd_dma_addr);
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  512  
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  513  		ufshcd_hex_dump("UPIU TRD: ", lrbp->utr_descriptor_ptr,
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  514  				sizeof(struct utp_transfer_req_desc));
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  515  		dev_err(hba->dev, "UPIU[%d] - Request UPIU phys@0x%llx\n", tag,
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  516  			(u64)lrbp->ucd_req_dma_addr);
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  517  		ufshcd_hex_dump("UPIU REQ: ", lrbp->ucd_req_ptr,
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  518  				sizeof(struct utp_upiu_req));
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  519  		dev_err(hba->dev, "UPIU[%d] - Response UPIU phys@0x%llx\n", tag,
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  520  			(u64)lrbp->ucd_rsp_dma_addr);
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  521  		ufshcd_hex_dump("UPIU RSP: ", lrbp->ucd_rsp_ptr,
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  522  				sizeof(struct utp_upiu_rsp));
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  523  
7fabb77b3aa016 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  524  		prdt_length = le16_to_cpu(
7fabb77b3aa016 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  525  			lrbp->utr_descriptor_ptr->prd_table_length);
cc770ce34aeeff drivers/scsi/ufs/ufshcd.c Eric Biggers        2020-08-25  526  		if (hba->quirks & UFSHCD_QUIRK_PRDT_BYTE_GRAN)
cc770ce34aeeff drivers/scsi/ufs/ufshcd.c Eric Biggers        2020-08-25  527  			prdt_length /= sizeof(struct ufshcd_sg_entry);
cc770ce34aeeff drivers/scsi/ufs/ufshcd.c Eric Biggers        2020-08-25  528  
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  529  		dev_err(hba->dev,
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  530  			"UPIU[%d] - PRDT - %d entries  phys@0x%llx\n",
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  531  			tag, prdt_length,
ff8e20c6624921 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  532  			(u64)lrbp->ucd_prdt_dma_addr);
7fabb77b3aa016 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  533  
7fabb77b3aa016 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  534  		if (pr_prdt)
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  535  			ufshcd_hex_dump("UPIU PRDT: ", lrbp->ucd_prdt_ptr,
7fabb77b3aa016 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  536  				sizeof(struct ufshcd_sg_entry) * prdt_length);
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  537  	}
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  538  }
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  539  
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  540  static void ufshcd_print_tmrs(struct ufs_hba *hba, unsigned long bitmap)
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  541  {
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  542  	int tag;
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  543  
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  544  	for_each_set_bit(tag, &bitmap, hba->nutmrs) {
391e388f853dad drivers/scsi/ufs/ufshcd.c Christoph Hellwig   2018-10-07  545  		struct utp_task_req_desc *tmrdp = &hba->utmrdl_base_addr[tag];
391e388f853dad drivers/scsi/ufs/ufshcd.c Christoph Hellwig   2018-10-07  546  
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  547  		dev_err(hba->dev, "TM[%d] - Task Management Header\n", tag);
391e388f853dad drivers/scsi/ufs/ufshcd.c Christoph Hellwig   2018-10-07  548  		ufshcd_hex_dump("", tmrdp, sizeof(*tmrdp));
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  549  	}
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  550  }
66cc820f9cbf12 drivers/scsi/ufs/ufshcd.c Dolev Raviv         2016-12-22  551  
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  552  static void ufshcd_print_host_state(struct ufs_hba *hba)
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  553  {
35d11ec239e099 drivers/ufs/core/ufshcd.c Krzysztof Kozlowski 2022-06-23  554  	const struct scsi_device *sdev_ufs = hba->ufs_device_wlun;
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09  555  
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  556  	dev_err(hba->dev, "UFS Host state=%d\n", hba->ufshcd_state);
7252a3603015f1 drivers/scsi/ufs/ufshcd.c Bart Van Assche     2019-12-09  557  	dev_err(hba->dev, "outstanding reqs=0x%lx tasks=0x%lx\n",
7252a3603015f1 drivers/scsi/ufs/ufshcd.c Bart Van Assche     2019-12-09  558  		hba->outstanding_reqs, hba->outstanding_tasks);
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  559  	dev_err(hba->dev, "saved_err=0x%x, saved_uic_err=0x%x\n",
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  560  		hba->saved_err, hba->saved_uic_err);
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  561  	dev_err(hba->dev, "Device power mode=%d, UIC link state=%d\n",
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  562  		hba->curr_dev_pwr_mode, hba->uic_link_state);
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  563  	dev_err(hba->dev, "PM in progress=%d, sys. suspended=%d\n",
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  564  		hba->pm_op_in_progress, hba->is_sys_suspended);
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  565  	dev_err(hba->dev, "Auto BKOPS=%d, Host self-block=%d\n",
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  566  		hba->auto_bkops_enabled, hba->host->host_self_blocked);
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  567  	dev_err(hba->dev, "Clk gate=%d\n", hba->clk_gating.state);
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09  568  	dev_err(hba->dev,
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09  569  		"last_hibern8_exit_tstamp at %lld us, hibern8_exit_cnt=%d\n",
c72f82f12e7c9f drivers/ufs/core/ufshcd.c Daniil Lunev        2022-08-02  570  		hba->ufs_stats.last_hibern8_exit_tstamp / 1000,
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09  571  		hba->ufs_stats.hibern8_exit_cnt);
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09 @572  	dev_err(hba->dev, "last intr at %lld us, last intr status=0x%x\n",
c72f82f12e7c9f drivers/ufs/core/ufshcd.c Daniil Lunev        2022-08-02  573  		hba->ufs_stats.last_intr_ts / 1000,
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09  574  		hba->ufs_stats.last_intr_status);
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  575  	dev_err(hba->dev, "error handling flags=0x%x, req. abort count=%d\n",
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  576  		hba->eh_flags, hba->req_abort_count);
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09  577  	dev_err(hba->dev, "hba->ufs_version=0x%x, Host capabilities=0x%x, caps=0x%x\n",
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09  578  		hba->ufs_version, hba->capabilities, hba->caps);
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  579  	dev_err(hba->dev, "quirks=0x%x, dev. quirks=0x%x\n", hba->quirks,
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  580  		hba->dev_quirks);
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09  581  	if (sdev_ufs)
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09  582  		dev_err(hba->dev, "UFS dev info: %.8s %.16s rev %.4s\n",
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09  583  			sdev_ufs->vendor, sdev_ufs->model, sdev_ufs->rev);
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09  584  
3f8af6044713fa drivers/scsi/ufs/ufshcd.c Can Guo             2020-08-09  585  	ufshcd_print_clk_freqs(hba);
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  586  }
6ba65588381d59 drivers/scsi/ufs/ufshcd.c Gilad Broner        2017-02-03  587  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
