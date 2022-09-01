Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A345A8F06
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiIAHBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiIAHAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:00:47 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38DA237FB;
        Thu,  1 Sep 2022 00:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662015621; x=1693551621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CY1iO3BM8UNn7xnUwBW3HOrJ71N81smEewSeDB8vwsg=;
  b=j4A3DYMzba/1Vz7x0n/ESOUo5oUyF0k/sHOJDZ3qwPhCm84W/bhCiYG0
   S1ZCR8z9Vu8H48LRHE0X95e02kM5HBaWL145gLRS2skmrzQkYva3Gs2+f
   53csgkkzsBgAm1xUNObataL1+tERN1S6rt90F8PEjTk3KyUjTEKLzwIbf
   VWUS6/T3DzzsKAJgwZmKbekTNPcGaBGMiXKe4zqrKFwh9t8keCFxJMhzg
   Sj3zztqt2CE6nBIgIQmszWcInuKUSXlXI968Djn+RsRceSGFtOeZlFkns
   CixO1DXXAuVWyDtNqY6utddOg2i9zsKfHEj6hGuNCyZ8QmdBG1bPCLZfV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="278651604"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="278651604"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 23:59:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="680728921"
Received: from lkp-server02.sh.intel.com (HELO 811e2ceaf0e5) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2022 23:59:54 -0700
Received: from kbuild by 811e2ceaf0e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTeB7-0001Gs-19;
        Thu, 01 Sep 2022 06:59:53 +0000
Date:   Thu, 1 Sep 2022 14:59:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     shravan kumar <shravan.chippa@microchip.com>,
        paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shravan Chippa <shravan.chippa@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Prakash Battu <Prakash.Battu@microchip.com>
Subject: Re: [PATCH v2] media: i2c: imx334: support lower bandwidth mode
Message-ID: <202209011420.aFw0x1Jm-lkp@intel.com>
References: <20220830060613.11335-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830060613.11335-1-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi shravan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v6.0-rc3]
[also build test WARNING on linus/master next-20220831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shravan-kumar/media-i2c-imx334-support-lower-bandwidth-mode/20220830-140816
base:    b90cb1053190353cc30f0fef0ef1f378ccc063c5
config: openrisc-randconfig-m031-20220830 (https://download.01.org/0day-ci/archive/20220901/202209011420.aFw0x1Jm-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/media/i2c/imx334.c:832 imx334_set_pad_format() warn: unsigned 'code' is never less than zero.

vim +/code +832 drivers/media/i2c/imx334.c

   811	
   812	/**
   813	 * imx334_set_pad_format() - Set subdevice pad format
   814	 * @sd: pointer to imx334 V4L2 sub-device structure
   815	 * @sd_state: V4L2 sub-device state
   816	 * @fmt: V4L2 sub-device format need to be set
   817	 *
   818	 * Return: 0 if successful, error code otherwise.
   819	 */
   820	static int imx334_set_pad_format(struct v4l2_subdev *sd,
   821					 struct v4l2_subdev_state *sd_state,
   822					 struct v4l2_subdev_format *fmt)
   823	{
   824		struct imx334 *imx334 = to_imx334(sd);
   825		const struct imx334_mode *mode;
   826		int ret = 0;
   827		u32 code;
   828	
   829		mutex_lock(&imx334->mutex);
   830	
   831		code = imx219_get_format_code(imx334, fmt);
 > 832		if (code < 0)
   833			return -EINVAL;
   834	
   835		imx334->cur_code = code;
   836	
   837		mode = v4l2_find_nearest_size(supported_modes,
   838					      ARRAY_SIZE(supported_modes),
   839					      width, height,
   840					      fmt->format.width, fmt->format.height);
   841	
   842		imx334_fill_pad_format(imx334, mode, fmt);
   843	
   844		if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
   845			struct v4l2_mbus_framefmt *framefmt;
   846	
   847			framefmt = v4l2_subdev_get_try_format(sd, sd_state, fmt->pad);
   848			*framefmt = fmt->format;
   849		} else if (imx334->cur_mode != mode) {
   850			ret = imx334_update_controls(imx334, mode);
   851			if (!ret)
   852				imx334->cur_mode = mode;
   853		}
   854	
   855		mutex_unlock(&imx334->mutex);
   856	
   857		return ret;
   858	}
   859	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
