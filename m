Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B15153DC83
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350816AbiFEPO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349656AbiFEPOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:14:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FDB4D258;
        Sun,  5 Jun 2022 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654442092; x=1685978092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5vqv0WrGsXvXky938K71INLLwMDCpzXiMJBpNJggeF4=;
  b=USWH+d8ekBlS+cXJ8CpUcvyNPWr2whRLlcG5Hr56cxkx2BUakNfpEloR
   tSDFaWItdsjWCwKl7MxDh/kLhEBNmaGjhGQIUYUIzNY8schPWPxQ0Dv/4
   OYWDDPfmbs2GIt3bjoiNaQXCtQXQOqJwRQdgMgh39XeeTAXvdVqX5G0+R
   LI4dnhfkj0fZQ1EtTR592jyOg5XkAM9wXNPulyI+v5eN93tU1/BcZ4QqR
   jhqvVs8yJI9YSxKHiW58acm44GyA/o7BPpBQ1Y1W1OWklxmxZZLqQQt0W
   bamfuShCcUGGjgSi9dk7EEoOyBFIdpT5vSIc5wbI4sA8czptPRFZ936nC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276625882"
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="276625882"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 08:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="554045783"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Jun 2022 08:14:47 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxrxm-000C0j-M3;
        Sun, 05 Jun 2022 15:14:46 +0000
Date:   Sun, 5 Jun 2022 23:13:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, lars@metafoo.de,
        rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] power: supply: axp20x_usb_power: Add support for
 AXP192
Message-ID: <202206052337.XAGi8JAq-lkp@intel.com>
References: <20220603135714.12007-10-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603135714.12007-10-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on linusw-pinctrl/devel broonie-regmap/for-next jic23-iio/togreg sre-power-supply/for-next v5.18 next-20220603]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Aidan-MacDonald/Add-support-for-AXP192-PMIC/20220605-165501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: riscv-randconfig-r023-20220605 (https://download.01.org/0day-ci/archive/20220605/202206052337.XAGi8JAq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 416a5080d89066029f9889dc23f94de47c2fa895)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/1eaea00a34314bd851023b9feeea16d1219174a3
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aidan-MacDonald/Add-support-for-AXP192-PMIC/20220605-165501
        git checkout 1eaea00a34314bd851023b9feeea16d1219174a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/power/supply/axp20x_usb_power.c:13:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/power/supply/axp20x_usb_power.c:13:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/power/supply/axp20x_usb_power.c:13:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> drivers/power/supply/axp20x_usb_power.c:300:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                   default:
                   ^
   drivers/power/supply/axp20x_usb_power.c:300:3: note: insert 'break;' to avoid fall-through
                   default:
                   ^
                   break; 
   8 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for RISCV_SBI_CPUIDLE
   Depends on CPU_IDLE && RISCV && RISCV_SBI
   Selected by
   - SOC_VIRT && CPU_IDLE


vim +300 drivers/power/supply/axp20x_usb_power.c

   198	
   199	static int axp20x_usb_power_get_property(struct power_supply *psy,
   200		enum power_supply_property psp, union power_supply_propval *val)
   201	{
   202		struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
   203		unsigned int input, v, reg;
   204		int ret;
   205	
   206		switch (psp) {
   207		case POWER_SUPPLY_PROP_VOLTAGE_MIN:
   208			ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
   209			if (ret)
   210				return ret;
   211	
   212			val->intval = AXP20X_VBUS_VHOLD_uV(v);
   213			return 0;
   214		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
   215			if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
   216				ret = iio_read_channel_processed(power->vbus_v,
   217								 &val->intval);
   218				if (ret)
   219					return ret;
   220	
   221				/*
   222				 * IIO framework gives mV but Power Supply framework
   223				 * gives uV.
   224				 */
   225				val->intval *= 1000;
   226				return 0;
   227			}
   228	
   229			ret = axp20x_read_variable_width(power->regmap,
   230							 AXP20X_VBUS_V_ADC_H, 12);
   231			if (ret < 0)
   232				return ret;
   233	
   234			val->intval = ret * 1700; /* 1 step = 1.7 mV */
   235			return 0;
   236		case POWER_SUPPLY_PROP_CURRENT_MAX:
   237			if (power->axp20x_id == AXP813_ID)
   238				return axp813_get_current_max(power, &val->intval);
   239			else if (power->axp20x_id == AXP192_ID)
   240				return axp192_get_current_max(power, &val->intval);
   241			return axp20x_get_current_max(power, &val->intval);
   242		case POWER_SUPPLY_PROP_CURRENT_NOW:
   243			if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
   244				ret = iio_read_channel_processed(power->vbus_i,
   245								 &val->intval);
   246				if (ret)
   247					return ret;
   248	
   249				/*
   250				 * IIO framework gives mA but Power Supply framework
   251				 * gives uA.
   252				 */
   253				val->intval *= 1000;
   254				return 0;
   255			}
   256	
   257			ret = axp20x_read_variable_width(power->regmap,
   258							 AXP20X_VBUS_I_ADC_H, 12);
   259			if (ret < 0)
   260				return ret;
   261	
   262			val->intval = ret * 375; /* 1 step = 0.375 mA */
   263			return 0;
   264		default:
   265			break;
   266		}
   267	
   268		/* All the properties below need the input-status reg value */
   269		ret = regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &input);
   270		if (ret)
   271			return ret;
   272	
   273		switch (psp) {
   274		case POWER_SUPPLY_PROP_HEALTH:
   275			if (!(input & AXP20X_PWR_STATUS_VBUS_PRESENT)) {
   276				val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
   277				break;
   278			}
   279	
   280			val->intval = POWER_SUPPLY_HEALTH_GOOD;
   281	
   282			switch (power->axp20x_id) {
   283			case AXP192_ID:
   284				/* Same layout as the AXP202, but different address */
   285				reg = AXP192_USB_OTG_STATUS;
   286				fallthrough;
   287	
   288			case AXP202_ID:
   289				if (power->axp20x_id == AXP202_ID)
   290					reg = AXP20X_USB_OTG_STATUS;
   291	
   292				ret = regmap_read(power->regmap, reg, &v);
   293				if (ret)
   294					return ret;
   295	
   296				if (!(v & AXP20X_USB_STATUS_VBUS_VALID))
   297					val->intval =
   298						POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
   299	
 > 300			default:
   301				break;
   302			}
   303			break;
   304		case POWER_SUPPLY_PROP_PRESENT:
   305			val->intval = !!(input & AXP20X_PWR_STATUS_VBUS_PRESENT);
   306			break;
   307		case POWER_SUPPLY_PROP_ONLINE:
   308			val->intval = !!(input & AXP20X_PWR_STATUS_VBUS_USED);
   309			break;
   310		default:
   311			return -EINVAL;
   312		}
   313	
   314		return 0;
   315	}
   316	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
