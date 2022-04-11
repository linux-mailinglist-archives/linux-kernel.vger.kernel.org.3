Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57094FC693
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344561AbiDKVSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiDKVSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:18:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B320180;
        Mon, 11 Apr 2022 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649711758; x=1681247758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5x2VQ9HU/v0yZ3qoFFue9KWN+qZAjMg8ZLZUP+AvOiA=;
  b=jeO0oh61AIp1WSWjnIoLILZj7HGluWtiCk8HqQvBnD7R74D+Co79d291
   4IR5MSTJOV8Pn6dxKS2x6r0Kdbx/Zl8gfO/fiCmk5HF7x5/ADSamh5i2/
   i2HSSoa72lLKJ1zbv0wzfibYHrOU0rxOFQlyqh2A+YL+dhdB5ppu8LZr/
   Zim6RSYDM4VXyjbVGyQCg4Uw8NmVmAocCXluF0WRJIyg7aetzzuoha36G
   Qn1A9JjU/OgaRCOyK6Ek4jnaSghFQ7gKX5qT36ObpjVtigfx57GUXvJCT
   hCr0FQrhHASr6YFIpLEuxv522nFk57zqXF9P5MOGN3sPMZPna5pU66RuI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261064049"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261064049"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 14:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="854082902"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Apr 2022 14:15:54 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne1O5-0002DR-Th;
        Mon, 11 Apr 2022 21:15:53 +0000
Date:   Tue, 12 Apr 2022 05:15:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     kbuild-all@lists.01.org, Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 04/10] drm/sun4i: Allow building the driver on RISC-V
Message-ID: <202204120528.TRFC7Ywj-lkp@intel.com>
References: <20220411043423.37333-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411043423.37333-5-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

I love your patch! Yet something to improve:

[auto build test ERROR on sunxi/sunxi/for-next]
[also build test ERROR on drm/drm-next linus/master v5.18-rc2 next-20220411]
[cannot apply to mripard/sunxi/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/drm-sun4i-Allwinner-D1-Display-Engine-2-0-Support/20220411-123701
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220412/202204120528.TRFC7Ywj-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/829dac8ee2cbb6d1b7bda1c513cc2ad1939fca53
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Samuel-Holland/drm-sun4i-Allwinner-D1-Display-Engine-2-0-Support/20220411-123701
        git checkout 829dac8ee2cbb6d1b7bda1c513cc2ad1939fca53
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c: In function 'fifo_transfer':
>> drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c:59:17: error: implicit declaration of function 'readsb'; did you mean 'readb'? [-Werror=implicit-function-declaration]
      59 |                 readsb(hdmi->base + hdmi->variant->ddc_fifo_reg, buf, len);
         |                 ^~~~~~
         |                 readb
>> drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c:61:17: error: implicit declaration of function 'writesb'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
      61 |                 writesb(hdmi->base + hdmi->variant->ddc_fifo_reg, buf, len);
         |                 ^~~~~~~
         |                 writeb
   cc1: some warnings being treated as errors


vim +59 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c

f0a3dd33ba685b Jonathan Liu 2017-07-02  24  
f0a3dd33ba685b Jonathan Liu 2017-07-02  25  static int fifo_transfer(struct sun4i_hdmi *hdmi, u8 *buf, int len, bool read)
f0a3dd33ba685b Jonathan Liu 2017-07-02  26  {
f0a3dd33ba685b Jonathan Liu 2017-07-02  27  	/*
f0a3dd33ba685b Jonathan Liu 2017-07-02  28  	 * 1 byte takes 9 clock cycles (8 bits + 1 ACK) = 90 us for 100 kHz
f0a3dd33ba685b Jonathan Liu 2017-07-02  29  	 * clock. As clock rate is fixed, just round it up to 100 us.
f0a3dd33ba685b Jonathan Liu 2017-07-02  30  	 */
f0a3dd33ba685b Jonathan Liu 2017-07-02  31  	const unsigned long byte_time_ns = 100;
f0a3dd33ba685b Jonathan Liu 2017-07-02  32  	const u32 mask = SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK |
f0a3dd33ba685b Jonathan Liu 2017-07-02  33  			 SUN4I_HDMI_DDC_INT_STATUS_FIFO_REQUEST |
f0a3dd33ba685b Jonathan Liu 2017-07-02  34  			 SUN4I_HDMI_DDC_INT_STATUS_TRANSFER_COMPLETE;
f0a3dd33ba685b Jonathan Liu 2017-07-02  35  	u32 reg;
939d749ad6649c Chen-Yu Tsai 2017-10-10  36  	/*
939d749ad6649c Chen-Yu Tsai 2017-10-10  37  	 * If threshold is inclusive, then the FIFO may only have
939d749ad6649c Chen-Yu Tsai 2017-10-10  38  	 * RX_THRESHOLD number of bytes, instead of RX_THRESHOLD + 1.
939d749ad6649c Chen-Yu Tsai 2017-10-10  39  	 */
939d749ad6649c Chen-Yu Tsai 2017-10-10  40  	int read_len = RX_THRESHOLD +
939d749ad6649c Chen-Yu Tsai 2017-10-10  41  		(hdmi->variant->ddc_fifo_thres_incl ? 0 : 1);
f0a3dd33ba685b Jonathan Liu 2017-07-02  42  
939d749ad6649c Chen-Yu Tsai 2017-10-10  43  	/*
939d749ad6649c Chen-Yu Tsai 2017-10-10  44  	 * Limit transfer length by FIFO threshold or FIFO size.
939d749ad6649c Chen-Yu Tsai 2017-10-10  45  	 * For TX the threshold is for an empty FIFO.
939d749ad6649c Chen-Yu Tsai 2017-10-10  46  	 */
939d749ad6649c Chen-Yu Tsai 2017-10-10  47  	len = min_t(int, len, read ? read_len : SUN4I_HDMI_DDC_FIFO_SIZE);
f0a3dd33ba685b Jonathan Liu 2017-07-02  48  
f0a3dd33ba685b Jonathan Liu 2017-07-02  49  	/* Wait until error, FIFO request bit set or transfer complete */
939d749ad6649c Chen-Yu Tsai 2017-10-10  50  	if (regmap_field_read_poll_timeout(hdmi->field_ddc_int_status, reg,
939d749ad6649c Chen-Yu Tsai 2017-10-10  51  					   reg & mask, len * byte_time_ns,
939d749ad6649c Chen-Yu Tsai 2017-10-10  52  					   100000))
f0a3dd33ba685b Jonathan Liu 2017-07-02  53  		return -ETIMEDOUT;
f0a3dd33ba685b Jonathan Liu 2017-07-02  54  
f0a3dd33ba685b Jonathan Liu 2017-07-02  55  	if (reg & SUN4I_HDMI_DDC_INT_STATUS_ERROR_MASK)
f0a3dd33ba685b Jonathan Liu 2017-07-02  56  		return -EIO;
f0a3dd33ba685b Jonathan Liu 2017-07-02  57  
f0a3dd33ba685b Jonathan Liu 2017-07-02  58  	if (read)
939d749ad6649c Chen-Yu Tsai 2017-10-10 @59  		readsb(hdmi->base + hdmi->variant->ddc_fifo_reg, buf, len);
f0a3dd33ba685b Jonathan Liu 2017-07-02  60  	else
939d749ad6649c Chen-Yu Tsai 2017-10-10 @61  		writesb(hdmi->base + hdmi->variant->ddc_fifo_reg, buf, len);
f0a3dd33ba685b Jonathan Liu 2017-07-02  62  
939d749ad6649c Chen-Yu Tsai 2017-10-10  63  	/* Clear FIFO request bit by forcing a write to that bit */
939d749ad6649c Chen-Yu Tsai 2017-10-10  64  	regmap_field_force_write(hdmi->field_ddc_int_status,
939d749ad6649c Chen-Yu Tsai 2017-10-10  65  				 SUN4I_HDMI_DDC_INT_STATUS_FIFO_REQUEST);
f0a3dd33ba685b Jonathan Liu 2017-07-02  66  
f0a3dd33ba685b Jonathan Liu 2017-07-02  67  	return len;
f0a3dd33ba685b Jonathan Liu 2017-07-02  68  }
f0a3dd33ba685b Jonathan Liu 2017-07-02  69  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
