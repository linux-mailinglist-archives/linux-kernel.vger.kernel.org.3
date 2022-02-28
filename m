Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D84C74CE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbiB1Rrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbiB1RoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:44:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC89D4F1;
        Mon, 28 Feb 2022 09:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646069786; x=1677605786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cGOfW2D/IgbYKpicSNs2f28FE08ecgJ11Y9ztjKulYE=;
  b=P/3XOmEFzzddyD5QsKvPOk/+i0GzLlTU/G4eJM3VoTdZuFfiSiDtHC2a
   ScYnSRCVeE0dI8fhXYgPNjF5w+P/5TqRZMj0A3xpn8Esj1C+ZukudEfYK
   88WzEBFH53/E6TLo0FsQpAz9I3zzvgr45MbbaHdWfvwJ6PxTrfi5Skhub
   zBLfSfAoLk/2QHUbFKglzZs874iPaeyHifDpNXZKKZTr2NC6JwylfgBhv
   SbXlXCqgRiKsXNqlpbSrfIUvn51gVXYddXOjkJ5QDYjCe0S1okM4vcW0h
   AuVqlOJNLFO9AvoTQwGItuVg0JGkbas9w+Y29AE/wTZylXILTdVkCUdcO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="236446046"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="236446046"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="510174501"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2022 09:36:15 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOjwU-0007b3-Ej; Mon, 28 Feb 2022 17:36:14 +0000
Date:   Tue, 1 Mar 2022 01:35:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Potin Lai <potin.lai@quantatw.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Patrick Williams <patrick@stwcx.xyz>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Potin Lai <potin.lai@quantatw.com>
Subject: Re: [PATCH v3 1/2] hwmon: (adm1275) Allow setting sample averaging
Message-ID: <202202282133.tDaIrm2N-lkp@intel.com>
References: <20220228103716.10774-2-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228103716.10774-2-potin.lai@quantatw.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Potin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on robh/for-next v5.17-rc6 next-20220225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Potin-Lai/hwmon-adm1275-Add-sample-averaging-binding-support/20220228-183914
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: i386-randconfig-a003-20220228 (https://download.01.org/0day-ci/archive/20220228/202202282133.tDaIrm2N-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e64fc74c4ca9f31e72265039c6bce3497169c8a2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Potin-Lai/hwmon-adm1275-Add-sample-averaging-binding-support/20220228-183914
        git checkout e64fc74c4ca9f31e72265039c6bce3497169c8a2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/hwmon/pmbus/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwmon/pmbus/adm1275.c:767:4: warning: format specifies type 'unsigned int' but the argument has type 'unsigned long' [-Wformat]
                           BIT(ilog2(avg)));
                           ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                    ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   include/vdso/bits.h:7:19: note: expanded from macro 'BIT'
   #define BIT(nr)                 (UL(1) << (nr))
                                   ^~~~~~~~~~~~~~~
   drivers/hwmon/pmbus/adm1275.c:784:4: warning: format specifies type 'unsigned int' but the argument has type 'unsigned long' [-Wformat]
                           BIT(ilog2(avg)));
                           ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:150:67: note: expanded from macro 'dev_info'
           dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                    ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   include/vdso/bits.h:7:19: note: expanded from macro 'BIT'
   #define BIT(nr)                 (UL(1) << (nr))
                                   ^~~~~~~~~~~~~~~
   2 warnings generated.


vim +767 drivers/hwmon/pmbus/adm1275.c

   464	
   465	static int adm1275_probe(struct i2c_client *client)
   466	{
   467		s32 (*config_read_fn)(const struct i2c_client *client, u8 reg);
   468		u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
   469		int config, device_config;
   470		int ret;
   471		struct pmbus_driver_info *info;
   472		struct adm1275_data *data;
   473		const struct i2c_device_id *mid;
   474		const struct coefficients *coefficients;
   475		int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
   476		int tindex = -1;
   477		u32 shunt;
   478		u32 avg;
   479	
   480		if (!i2c_check_functionality(client->adapter,
   481					     I2C_FUNC_SMBUS_READ_BYTE_DATA
   482					     | I2C_FUNC_SMBUS_BLOCK_DATA))
   483			return -ENODEV;
   484	
   485		ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, block_buffer);
   486		if (ret < 0) {
   487			dev_err(&client->dev, "Failed to read Manufacturer ID\n");
   488			return ret;
   489		}
   490		if (ret != 3 || strncmp(block_buffer, "ADI", 3)) {
   491			dev_err(&client->dev, "Unsupported Manufacturer ID\n");
   492			return -ENODEV;
   493		}
   494	
   495		ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, block_buffer);
   496		if (ret < 0) {
   497			dev_err(&client->dev, "Failed to read Manufacturer Model\n");
   498			return ret;
   499		}
   500		for (mid = adm1275_id; mid->name[0]; mid++) {
   501			if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
   502				break;
   503		}
   504		if (!mid->name[0]) {
   505			dev_err(&client->dev, "Unsupported device\n");
   506			return -ENODEV;
   507		}
   508	
   509		if (strcmp(client->name, mid->name) != 0)
   510			dev_notice(&client->dev,
   511				   "Device mismatch: Configured %s, detected %s\n",
   512				   client->name, mid->name);
   513	
   514		if (mid->driver_data == adm1272 || mid->driver_data == adm1278 ||
   515		    mid->driver_data == adm1293 || mid->driver_data == adm1294)
   516			config_read_fn = i2c_smbus_read_word_data;
   517		else
   518			config_read_fn = i2c_smbus_read_byte_data;
   519		config = config_read_fn(client, ADM1275_PMON_CONFIG);
   520		if (config < 0)
   521			return config;
   522	
   523		device_config = config_read_fn(client, ADM1275_DEVICE_CONFIG);
   524		if (device_config < 0)
   525			return device_config;
   526	
   527		data = devm_kzalloc(&client->dev, sizeof(struct adm1275_data),
   528				    GFP_KERNEL);
   529		if (!data)
   530			return -ENOMEM;
   531	
   532		if (of_property_read_u32(client->dev.of_node,
   533					 "shunt-resistor-micro-ohms", &shunt))
   534			shunt = 1000; /* 1 mOhm if not set via DT */
   535	
   536		if (shunt == 0)
   537			return -EINVAL;
   538	
   539		data->id = mid->driver_data;
   540	
   541		info = &data->info;
   542	
   543		info->pages = 1;
   544		info->format[PSC_VOLTAGE_IN] = direct;
   545		info->format[PSC_VOLTAGE_OUT] = direct;
   546		info->format[PSC_CURRENT_OUT] = direct;
   547		info->format[PSC_POWER] = direct;
   548		info->format[PSC_TEMPERATURE] = direct;
   549		info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
   550				PMBUS_HAVE_SAMPLES;
   551	
   552		info->read_word_data = adm1275_read_word_data;
   553		info->read_byte_data = adm1275_read_byte_data;
   554		info->write_word_data = adm1275_write_word_data;
   555	
   556		switch (data->id) {
   557		case adm1075:
   558			if (device_config & ADM1275_IOUT_WARN2_SELECT)
   559				data->have_oc_fault = true;
   560			else
   561				data->have_uc_fault = true;
   562			data->have_pin_max = true;
   563			data->have_vaux_status = true;
   564	
   565			coefficients = adm1075_coefficients;
   566			vindex = 0;
   567			switch (config & ADM1075_IRANGE_MASK) {
   568			case ADM1075_IRANGE_25:
   569				cindex = 1;
   570				pindex = 3;
   571				break;
   572			case ADM1075_IRANGE_50:
   573				cindex = 2;
   574				pindex = 4;
   575				break;
   576			default:
   577				dev_err(&client->dev, "Invalid input current range");
   578				break;
   579			}
   580	
   581			info->func[0] |= PMBUS_HAVE_VIN | PMBUS_HAVE_PIN
   582			  | PMBUS_HAVE_STATUS_INPUT;
   583			if (config & ADM1275_VIN_VOUT_SELECT)
   584				info->func[0] |=
   585				  PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
   586			break;
   587		case adm1272:
   588			data->have_vout = true;
   589			data->have_pin_max = true;
   590			data->have_temp_max = true;
   591			data->have_power_sampling = true;
   592	
   593			coefficients = adm1272_coefficients;
   594			vindex = (config & ADM1275_VRANGE) ? 1 : 0;
   595			cindex = (config & ADM1272_IRANGE) ? 3 : 2;
   596			/* pindex depends on the combination of the above */
   597			switch (config & (ADM1275_VRANGE | ADM1272_IRANGE)) {
   598			case 0:
   599			default:
   600				pindex = 4;
   601				break;
   602			case ADM1275_VRANGE:
   603				pindex = 5;
   604				break;
   605			case ADM1272_IRANGE:
   606				pindex = 6;
   607				break;
   608			case ADM1275_VRANGE | ADM1272_IRANGE:
   609				pindex = 7;
   610				break;
   611			}
   612			tindex = 8;
   613	
   614			info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
   615				PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
   616				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
   617	
   618			/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
   619			if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) !=
   620			    (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
   621				config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
   622				ret = i2c_smbus_write_byte_data(client,
   623								ADM1275_PMON_CONFIG,
   624								config);
   625				if (ret < 0) {
   626					dev_err(&client->dev,
   627						"Failed to enable VOUT monitoring\n");
   628					return -ENODEV;
   629				}
   630			}
   631			if (config & ADM1278_VIN_EN)
   632				info->func[0] |= PMBUS_HAVE_VIN;
   633			break;
   634		case adm1275:
   635			if (device_config & ADM1275_IOUT_WARN2_SELECT)
   636				data->have_oc_fault = true;
   637			else
   638				data->have_uc_fault = true;
   639			data->have_vout = true;
   640	
   641			coefficients = adm1275_coefficients;
   642			vindex = (config & ADM1275_VRANGE) ? 0 : 1;
   643			cindex = 2;
   644	
   645			if (config & ADM1275_VIN_VOUT_SELECT)
   646				info->func[0] |=
   647				  PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
   648			else
   649				info->func[0] |=
   650				  PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT;
   651			break;
   652		case adm1276:
   653			if (device_config & ADM1275_IOUT_WARN2_SELECT)
   654				data->have_oc_fault = true;
   655			else
   656				data->have_uc_fault = true;
   657			data->have_vout = true;
   658			data->have_pin_max = true;
   659	
   660			coefficients = adm1276_coefficients;
   661			vindex = (config & ADM1275_VRANGE) ? 0 : 1;
   662			cindex = 2;
   663			pindex = (config & ADM1275_VRANGE) ? 3 : 4;
   664	
   665			info->func[0] |= PMBUS_HAVE_VIN | PMBUS_HAVE_PIN
   666			  | PMBUS_HAVE_STATUS_INPUT;
   667			if (config & ADM1275_VIN_VOUT_SELECT)
   668				info->func[0] |=
   669				  PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
   670			break;
   671		case adm1278:
   672			data->have_vout = true;
   673			data->have_pin_max = true;
   674			data->have_temp_max = true;
   675			data->have_power_sampling = true;
   676	
   677			coefficients = adm1278_coefficients;
   678			vindex = 0;
   679			cindex = 1;
   680			pindex = 2;
   681			tindex = 3;
   682	
   683			info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
   684				PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
   685				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
   686	
   687			/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
   688			if ((config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) !=
   689			    (ADM1278_VOUT_EN | ADM1278_TEMP1_EN)) {
   690				config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
   691				ret = i2c_smbus_write_byte_data(client,
   692								ADM1275_PMON_CONFIG,
   693								config);
   694				if (ret < 0) {
   695					dev_err(&client->dev,
   696						"Failed to enable VOUT monitoring\n");
   697					return -ENODEV;
   698				}
   699			}
   700	
   701			if (config & ADM1278_VIN_EN)
   702				info->func[0] |= PMBUS_HAVE_VIN;
   703			break;
   704		case adm1293:
   705		case adm1294:
   706			data->have_iout_min = true;
   707			data->have_pin_min = true;
   708			data->have_pin_max = true;
   709			data->have_mfr_vaux_status = true;
   710			data->have_power_sampling = true;
   711	
   712			coefficients = adm1293_coefficients;
   713	
   714			voindex = 0;
   715			switch (config & ADM1293_VIN_SEL_MASK) {
   716			case ADM1293_VIN_SEL_012:	/* 1.2V */
   717				vindex = 0;
   718				break;
   719			case ADM1293_VIN_SEL_074:	/* 7.4V */
   720				vindex = 1;
   721				break;
   722			case ADM1293_VIN_SEL_210:	/* 21V */
   723				vindex = 2;
   724				break;
   725			default:			/* disabled */
   726				break;
   727			}
   728	
   729			switch (config & ADM1293_IRANGE_MASK) {
   730			case ADM1293_IRANGE_25:
   731				cindex = 3;
   732				break;
   733			case ADM1293_IRANGE_50:
   734				cindex = 4;
   735				break;
   736			case ADM1293_IRANGE_100:
   737				cindex = 5;
   738				break;
   739			case ADM1293_IRANGE_200:
   740				cindex = 6;
   741				break;
   742			}
   743	
   744			if (vindex >= 0)
   745				pindex = 7 + vindex * 4 + (cindex - 3);
   746	
   747			if (config & ADM1293_VAUX_EN)
   748				info->func[0] |=
   749					PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
   750	
   751			info->func[0] |= PMBUS_HAVE_PIN |
   752				PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT;
   753	
   754			break;
   755		default:
   756			dev_err(&client->dev, "Unsupported device\n");
   757			return -ENODEV;
   758		}
   759	
   760		if (data->have_power_sampling &&
   761		    of_property_read_u32(client->dev.of_node,
   762					"adi,power-sample-average", &avg) == 0) {
   763			if (avg > ADM1275_SAMPLES_AVG_MAX || avg < 1)
   764				return -EINVAL;
   765			dev_info(&client->dev,
   766				"Setting power sample averaging number to %u",
 > 767				BIT(ilog2(avg)));
   768			ret = adm1275_write_pmon_config(data, client, true,
   769							ilog2(avg));
   770			if (ret < 0) {
   771				dev_err(&client->dev,
   772					"Setting power sample averaging failed with error %d",
   773					ret);
   774				return ret;
   775			}
   776		}
   777	
   778		if (of_property_read_u32(client->dev.of_node,
   779					"adi,volt-curr-sample-average", &avg) == 0) {
   780			if (avg > ADM1275_SAMPLES_AVG_MAX || avg < 1)
   781				return -EINVAL;
   782			dev_info(&client->dev,
   783				"Setting voltage and current sample averaging number to %u",
   784				BIT(ilog2(avg)));
   785			ret = adm1275_write_pmon_config(data, client, false,
   786							ilog2(avg));
   787			if (ret < 0) {
   788				dev_err(&client->dev,
   789					"Setting voltage and current sample averaging failed with error %d",
   790					ret);
   791				return ret;
   792			}
   793		}
   794	
   795		if (voindex < 0)
   796			voindex = vindex;
   797		if (vindex >= 0) {
   798			info->m[PSC_VOLTAGE_IN] = coefficients[vindex].m;
   799			info->b[PSC_VOLTAGE_IN] = coefficients[vindex].b;
   800			info->R[PSC_VOLTAGE_IN] = coefficients[vindex].R;
   801		}
   802		if (voindex >= 0) {
   803			info->m[PSC_VOLTAGE_OUT] = coefficients[voindex].m;
   804			info->b[PSC_VOLTAGE_OUT] = coefficients[voindex].b;
   805			info->R[PSC_VOLTAGE_OUT] = coefficients[voindex].R;
   806		}
   807		if (cindex >= 0) {
   808			/* Scale current with sense resistor value */
   809			info->m[PSC_CURRENT_OUT] =
   810				coefficients[cindex].m * shunt / 1000;
   811			info->b[PSC_CURRENT_OUT] = coefficients[cindex].b;
   812			info->R[PSC_CURRENT_OUT] = coefficients[cindex].R;
   813		}
   814		if (pindex >= 0) {
   815			info->m[PSC_POWER] =
   816				coefficients[pindex].m * shunt / 1000;
   817			info->b[PSC_POWER] = coefficients[pindex].b;
   818			info->R[PSC_POWER] = coefficients[pindex].R;
   819		}
   820		if (tindex >= 0) {
   821			info->m[PSC_TEMPERATURE] = coefficients[tindex].m;
   822			info->b[PSC_TEMPERATURE] = coefficients[tindex].b;
   823			info->R[PSC_TEMPERATURE] = coefficients[tindex].R;
   824		}
   825	
   826		return pmbus_do_probe(client, info);
   827	}
   828	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
