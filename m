Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B857E5A41AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 06:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiH2ECW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 00:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiH2ECT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:02:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8CF1705D;
        Sun, 28 Aug 2022 21:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661745738; x=1693281738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ji19rslU4rniauVOHdPnDgStDkvaEobZo4E38szj3X0=;
  b=e8Wp3CYD+p05LqfzneJ0zJJCMFMxy5Ngbnv0JJIZloOngTM7H3G534ZZ
   vL6afB0ga4pfib7BuW03p8BhzaQqo0DRKTb1GL3zE4AU6pFCv/fcfxqQU
   b7eKuQs2THaaVhl6Pa4q8WAyXNRMLNYbIThVIR5PqQ+tARcnDPZP1O5yr
   QkNNCwnf1gHE12OdnoUcjQPjNC7WEYYsb7Edd0YFpVRblyZWF9oRIzSAn
   ZCJlGDKC1gMGc0GRqJTnzZxWKlViBIajhTK8faJYxo5knJUyOXiem+5ww
   lsRjjRiFWfjsF8u8GDl9OUFhsuSf233tFao29RS3J8ASfNKsFz0PcShub
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="358767010"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="358767010"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 21:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="679489758"
Received: from lkp-server01.sh.intel.com (HELO b2bbdd52f619) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2022 21:02:16 -0700
Received: from kbuild by b2bbdd52f619 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSVyZ-00009q-1R;
        Mon, 29 Aug 2022 04:02:15 +0000
Date:   Mon, 29 Aug 2022 12:02:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Zhong <floridsleeves@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, mturquette@baylibre.com, sboyd@kernel.org,
        lily <floridsleeves@gmail.com>
Subject: Re: [PATCH v1] drivers/clk/clk: check return value of
 clk_pm_runtime_get()
Message-ID: <202208291148.JSEXDM4l-lkp@intel.com>
References: <20220828202025.1948848-1-floridsleeves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828202025.1948848-1-floridsleeves@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.0-rc3 next-20220826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Zhong/drivers-clk-clk-check-return-value-of-clk_pm_runtime_get/20220829-042043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220829/202208291148.JSEXDM4l-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/clk/clk.c:3014 clk_summary_show_subtree() warn: inconsistent indenting
drivers/clk/clk.c:3016 clk_summary_show_subtree() warn: curly braces intended?

Old smatch warnings:
drivers/clk/clk.c:3802 clk_hw_create_clk() warn: passing zero to 'ERR_CAST'

vim +3014 drivers/clk/clk.c

  3006	
  3007	static void clk_summary_show_subtree(struct seq_file *s, struct clk_core *c,
  3008					     int level)
  3009	{
  3010		struct clk_core *child;
  3011		int ret;
  3012		
  3013		ret = clk_pm_runtime_get(c);
> 3014	    if (ret)
  3015	        return;
> 3016		clk_summary_show_one(s, c, level);
  3017		clk_pm_runtime_put(c);
  3018	
  3019		hlist_for_each_entry(child, &c->children, child_node)
  3020			clk_summary_show_subtree(s, child, level + 1);
  3021	}
  3022	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
