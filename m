Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018294982CE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbiAXPBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:01:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:43317 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234477AbiAXPBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036510; x=1674572510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U5+2B1K3W3IFZkkkXP6UpfPqyxgzDs+3P45zPwQ+azc=;
  b=JVxSvAaMv19vdFJgwcx3QNVgm6jqtLteVmJoPkR91rvNjRQ6Boj6qfbg
   xlv1NjjcPv8k2XAgrGsQimIcBhh7vamQrATPTEAo/lBKzeXBZXaSdofX9
   z/g4CF9OTpm0d2TudWgAAsozimK/zXdL66lKSbRd6NWmIjPFZpdy4sTg3
   u82NibTUkN7sZ9VPgDTcNj79Y4VVIVk4WjtqHYG2pDZxJrCcpLuf40u5D
   RJYm9fuYXDfL2tBKgqd1e87pw4iUj7AvbHxt1VAyJBG/Xr30Q9oLK2rnR
   3keLh21690l/CIVDV1D1mTMXMDWpGU05bxf9iftxIjLrohq2zL9/v9+xR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246280006"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246280006"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476742920"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2022 07:01:47 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC0qo-000IUc-GH; Mon, 24 Jan 2022 15:01:46 +0000
Date:   Mon, 24 Jan 2022 23:01:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: Re: [PATCH V1 3/6] iio: accel: sca3300: modified to support multi
 chips
Message-ID: <202201242207.0V8eUHu2-lkp@intel.com>
References: <20220124093912.2429190-4-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124093912.2429190-4-Qing-wu.Li@leica-geosystems.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LI,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on v5.17-rc1 next-20220124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/LI-Qingwu/i-iio-accel-sca3300-add-compitible-for-scl3300/20220124-174021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: hexagon-randconfig-r033-20220124 (https://download.01.org/0day-ci/archive/20220124/202201242207.0V8eUHu2-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2e58a18910867ba6795066e044293e6daf89edf5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7dc3bc68cdfcb252dd79fea28a5e944d76784fe8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review LI-Qingwu/i-iio-accel-sca3300-add-compitible-for-scl3300/20220124-174021
        git checkout 7dc3bc68cdfcb252dd79fea28a5e944d76784fe8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iio/accel/sca3300.c:74:53: error: too few arguments provided to function-like macro invocation
           IIO_ENUM_AVAILABLE("op_mode", &sca3300_op_mode_enum),
                                                              ^
   include/linux/iio/iio.h:112:9: note: macro 'IIO_ENUM_AVAILABLE' defined here
   #define IIO_ENUM_AVAILABLE(_name, _shared, _e) \
           ^
   drivers/iio/accel/sca3300.c:74:2: error: use of undeclared identifier 'IIO_ENUM_AVAILABLE'
           IIO_ENUM_AVAILABLE("op_mode", &sca3300_op_mode_enum),
           ^
>> drivers/iio/accel/sca3300.c:185:17: warning: incompatible pointer to integer conversion initializing 'unsigned long' with an expression of type 'const unsigned long[2]' [-Wint-conversion]
                   .scan_masks = sca3300_scan_masks,
                                 ^~~~~~~~~~~~~~~~~~
>> drivers/iio/accel/sca3300.c:307:13: warning: comparison between pointer and integer ('int' and 'const int *') [-Wpointer-integer-compare]
                           if ((val == sca3300_accel_scale[data->chip_info->chip_type][0]) &&
                                ~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/accel/sca3300.c:308:14: warning: comparison between pointer and integer ('int' and 'const int *') [-Wpointer-integer-compare]
                               (val2 == sca3300_accel_scale[data->chip_info->chip_type][1]))
                                ~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/accel/sca3300.c:422:36: warning: incompatible integer to pointer conversion assigning to 'const unsigned long *' from 'const unsigned long'; take the address with & [-Wint-conversion]
                           indio_dev->available_scan_masks = sca3300_chip_info_tbl[i].scan_masks;
                                                           ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                                             &
   4 warnings and 2 errors generated.


vim +185 drivers/iio/accel/sca3300.c

   177	
   178	static const struct sca3300_chip_info sca3300_chip_info_tbl[] = {
   179		[CHIP_SCA3300] = {
   180			.chip_type = CHIP_SCA3300,
   181			.name = "sca3300",
   182			.chip_id = 0x51,
   183			.channels = sca3300_channels,
   184			.num_channels = ARRAY_SIZE(sca3300_channels),
 > 185			.scan_masks = sca3300_scan_masks,
   186		},
   187	};
   188	
   189	DECLARE_CRC8_TABLE(sca3300_crc_table);
   190	
   191	static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
   192	{
   193		/* Consecutive requests min. 10 us delay (Datasheet section 5.1.2) */
   194		struct spi_delay delay = { .value = 10, .unit = SPI_DELAY_UNIT_USECS };
   195		int32_t ret;
   196		int rs;
   197		u8 crc;
   198		struct spi_transfer xfers[2] = {
   199			{
   200				.tx_buf = sca_data->txbuf,
   201				.len = ARRAY_SIZE(sca_data->txbuf),
   202				.delay = delay,
   203				.cs_change = 1,
   204			},
   205			{
   206				.rx_buf = sca_data->rxbuf,
   207				.len = ARRAY_SIZE(sca_data->rxbuf),
   208				.delay = delay,
   209			}
   210		};
   211	
   212		/* inverted crc value as described in device data sheet */
   213		crc = ~crc8(sca3300_crc_table, &sca_data->txbuf[0], 3, CRC8_INIT_VALUE);
   214		sca_data->txbuf[3] = crc;
   215	
   216		ret = spi_sync_transfer(sca_data->spi, xfers, ARRAY_SIZE(xfers));
   217		if (ret) {
   218			dev_err(&sca_data->spi->dev,
   219				"transfer error, error: %d\n", ret);
   220			return -EIO;
   221		}
   222	
   223		crc = ~crc8(sca3300_crc_table, &sca_data->rxbuf[0], 3, CRC8_INIT_VALUE);
   224		if (sca_data->rxbuf[3] != crc) {
   225			dev_err(&sca_data->spi->dev, "CRC checksum mismatch");
   226			return -EIO;
   227		}
   228	
   229		/* get return status */
   230		rs = sca_data->rxbuf[0] & SCA3300_MASK_RS_STATUS;
   231		if (rs == SCA3300_VALUE_RS_ERROR)
   232			ret = -EINVAL;
   233	
   234		*val = sign_extend32(get_unaligned_be16(&sca_data->rxbuf[1]), 15);
   235	
   236		return ret;
   237	}
   238	
   239	static int sca3300_error_handler(struct sca3300_data *sca_data)
   240	{
   241		int ret;
   242		int val;
   243	
   244		mutex_lock(&sca_data->lock);
   245		sca_data->txbuf[0] = SCA3300_REG_STATUS << 2;
   246		ret = sca3300_transfer(sca_data, &val);
   247		mutex_unlock(&sca_data->lock);
   248		/*
   249		 * Return status error is cleared after reading status register once,
   250		 * expect EINVAL here.
   251		 */
   252		if (ret != -EINVAL) {
   253			dev_err(&sca_data->spi->dev,
   254				"error reading device status: %d\n", ret);
   255			return ret;
   256		}
   257	
   258		dev_err(&sca_data->spi->dev, "device status: 0x%lx\n",
   259			val & SCA3300_STATUS_MASK);
   260	
   261		return 0;
   262	}
   263	
   264	static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
   265	{
   266		int ret;
   267	
   268		mutex_lock(&sca_data->lock);
   269		sca_data->txbuf[0] = reg << 2;
   270		ret = sca3300_transfer(sca_data, val);
   271		mutex_unlock(&sca_data->lock);
   272		if (ret != -EINVAL)
   273			return ret;
   274	
   275		return sca3300_error_handler(sca_data);
   276	}
   277	
   278	static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
   279	{
   280		int reg_val = 0;
   281		int ret;
   282	
   283		mutex_lock(&sca_data->lock);
   284		/* BIT(7) for write operation */
   285		sca_data->txbuf[0] = BIT(7) | (reg << 2);
   286		put_unaligned_be16(val, &sca_data->txbuf[1]);
   287		ret = sca3300_transfer(sca_data, &reg_val);
   288		mutex_unlock(&sca_data->lock);
   289		if (ret != -EINVAL)
   290			return ret;
   291	
   292		return sca3300_error_handler(sca_data);
   293	}
   294	
   295	static int sca3300_write_raw(struct iio_dev *indio_dev,
   296				     struct iio_chan_spec const *chan,
   297				     int val, int val2, long mask)
   298	{
   299		struct sca3300_data *data = iio_priv(indio_dev);
   300		int reg_val;
   301		int ret;
   302		int i;
   303	
   304		switch (mask) {
   305		case IIO_CHAN_INFO_SCALE:
   306			for (i = 0; i < OP_MOD_CNT; i++) {
 > 307				if ((val == sca3300_accel_scale[data->chip_info->chip_type][0]) &&
   308				    (val2 == sca3300_accel_scale[data->chip_info->chip_type][1]))
   309					return sca3300_write_reg(data, SCA3300_REG_MODE, i);
   310			}
   311			return -EINVAL;
   312		case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
   313			ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
   314			if (ret)
   315				return ret;
   316			/* freq. change is possible only for mode 3 and 4 */
   317			if (reg_val == 2 && val == sca3300_lp_freq[data->chip_info->chip_type][3])
   318				return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
   319			if (reg_val == 3 && val == sca3300_lp_freq[data->chip_info->chip_type][2])
   320				return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
   321			return -EINVAL;
   322		default:
   323			return -EINVAL;
   324		}
   325	}
   326	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
