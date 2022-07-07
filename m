Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078A656A72B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 17:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiGGPk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 11:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiGGPk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 11:40:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C2620BCA;
        Thu,  7 Jul 2022 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657208455; x=1688744455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K98f2lGesm9VxtLvneIAOHDNuCUd/i45m2bxaKcd7VI=;
  b=DhMGcYdrk9xazsA4fEVbht71X7Pt9gWJiyvOFkXA7fwaYRFkzwl3XT45
   1QmR9OJo0aVD9EwBLwREAJ/irT5zBcf361etgwqOrt96zlHRwhwT1wrOC
   5GpRCixMBi8S0xTYLq4d0XZGSHaTWNlmeg0h/srp2sqBzCNY3v1s9Vwty
   +RzzzVds0VILnKGqpN0oB/3zqVrnQSLBfPWkj8DjXnqSIFNNdmWjL2UCk
   tPhxn358BDBHk1ClOwWMrWFWSIgMhHsq+PGVXnTIzu3GlwYnajpsnnogX
   GP2yjKrpET55JjJOgaRhCnLLwTH8w5RST2/LiR6paOYq1FNpCVsshAD6Y
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="282807844"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="282807844"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 08:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="661429543"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2022 08:40:50 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9TcY-000MBC-12;
        Thu, 07 Jul 2022 15:40:50 +0000
Date:   Thu, 7 Jul 2022 23:40:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        phone-devel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH v4 1/2] power: supply: add Qualcomm PMI8998 SMB2 Charger
 driver
Message-ID: <202207072358.2odInqXi-lkp@intel.com>
References: <20220706194125.1861256-2-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706194125.1861256-2-caleb.connolly@linaro.org>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Caleb,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sre-power-supply/for-next]
[also build test WARNING on robh/for-next linus/master v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Caleb-Connolly/power-supply-introduce-support-for-the-Qualcomm-smb2-charger/20220707-034307
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220707/202207072358.2odInqXi-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/a6b315467a158024bb1af7fed00c9a5227c9b293
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Caleb-Connolly/power-supply-introduce-support-for-the-Qualcomm-smb2-charger/20220707-034307
        git checkout a6b315467a158024bb1af7fed00c9a5227c9b293
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/power/supply/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/power/supply/qcom_pmi8998_charger.c:425:5: warning: no previous prototype for function 'smb2_get_prop_usb_online' [-Wmissing-prototypes]
   int smb2_get_prop_usb_online(struct smb2_chip *chip, int *val)
       ^
   drivers/power/supply/qcom_pmi8998_charger.c:425:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int smb2_get_prop_usb_online(struct smb2_chip *chip, int *val)
   ^
   static 
>> drivers/power/supply/qcom_pmi8998_charger.c:486:5: warning: no previous prototype for function 'smb2_get_prop_status' [-Wmissing-prototypes]
   int smb2_get_prop_status(struct smb2_chip *chip, int *val)
       ^
   drivers/power/supply/qcom_pmi8998_charger.c:486:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int smb2_get_prop_status(struct smb2_chip *chip, int *val)
   ^
   static 
>> drivers/power/supply/qcom_pmi8998_charger.c:565:6: warning: no previous prototype for function 'smb2_status_change_work' [-Wmissing-prototypes]
   void smb2_status_change_work(struct work_struct *work)
        ^
   drivers/power/supply/qcom_pmi8998_charger.c:565:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void smb2_status_change_work(struct work_struct *work)
   ^
   static 
>> drivers/power/supply/qcom_pmi8998_charger.c:614:5: warning: no previous prototype for function 'smb2_get_iio_chan' [-Wmissing-prototypes]
   int smb2_get_iio_chan(struct smb2_chip *chip, struct iio_channel *chan,
       ^
   drivers/power/supply/qcom_pmi8998_charger.c:614:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int smb2_get_iio_chan(struct smb2_chip *chip, struct iio_channel *chan,
   ^
   static 
>> drivers/power/supply/qcom_pmi8998_charger.c:635:5: warning: no previous prototype for function 'smb2_get_prop_health' [-Wmissing-prototypes]
   int smb2_get_prop_health(struct smb2_chip *chip, int *val)
       ^
   drivers/power/supply/qcom_pmi8998_charger.c:635:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int smb2_get_prop_health(struct smb2_chip *chip, int *val)
   ^
   static 
>> drivers/power/supply/qcom_pmi8998_charger.c:736:13: warning: no previous prototype for function 'smb2_handle_batt_overvoltage' [-Wmissing-prototypes]
   irqreturn_t smb2_handle_batt_overvoltage(int irq, void *data)
               ^
   drivers/power/supply/qcom_pmi8998_charger.c:736:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   irqreturn_t smb2_handle_batt_overvoltage(int irq, void *data)
   ^
   static 
>> drivers/power/supply/qcom_pmi8998_charger.c:754:13: warning: no previous prototype for function 'smb2_handle_usb_plugin' [-Wmissing-prototypes]
   irqreturn_t smb2_handle_usb_plugin(int irq, void *data)
               ^
   drivers/power/supply/qcom_pmi8998_charger.c:754:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   irqreturn_t smb2_handle_usb_plugin(int irq, void *data)
   ^
   static 
>> drivers/power/supply/qcom_pmi8998_charger.c:766:13: warning: no previous prototype for function 'smb2_handle_usb_icl_change' [-Wmissing-prototypes]
   irqreturn_t smb2_handle_usb_icl_change(int irq, void *data)
               ^
   drivers/power/supply/qcom_pmi8998_charger.c:766:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   irqreturn_t smb2_handle_usb_icl_change(int irq, void *data)
   ^
   static 
>> drivers/power/supply/qcom_pmi8998_charger.c:775:13: warning: no previous prototype for function 'smb2_handle_wdog_bark' [-Wmissing-prototypes]
   irqreturn_t smb2_handle_wdog_bark(int irq, void *data)
               ^
   drivers/power/supply/qcom_pmi8998_charger.c:775:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   irqreturn_t smb2_handle_wdog_bark(int irq, void *data)
   ^
   static 
   drivers/power/supply/qcom_pmi8998_charger.c:896:12: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
             .addr = 1950000 / 25000 },
                     ^~~~~~~~~~~~~~~
   drivers/power/supply/qcom_pmi8998_charger.c:894:12: note: previous initialization is here
           { .addr = FAST_CHARGE_CURRENT_CFG,
                     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/qcom_pmi8998_charger.c:76:36: note: expanded from macro 'FAST_CHARGE_CURRENT_CFG'
   #define FAST_CHARGE_CURRENT_CFG                         0x61
                                                           ^~~~
   10 warnings generated.


vim +/smb2_get_prop_usb_online +425 drivers/power/supply/qcom_pmi8998_charger.c

   424	
 > 425	int smb2_get_prop_usb_online(struct smb2_chip *chip, int *val)
   426	{
   427		unsigned int stat;
   428		int rc;
   429	
   430		rc = regmap_read(chip->regmap, chip->base + POWER_PATH_STATUS, &stat);
   431		if (rc < 0) {
   432			dev_err(chip->dev, "Couldn't read POWER_PATH_STATUS! ret=%d\n",
   433				rc);
   434			return rc;
   435		}
   436	
   437		*val = (stat & P_PATH_USE_USBIN_BIT) &&
   438		       (stat & P_PATH_VALID_INPUT_POWER_SOURCE_STS_BIT);
   439		return 0;
   440	}
   441	
   442	/*
   443	 * Qualcomm "automatic power source detection" aka APSD
   444	 * tells us what type of charger we're connected to.
   445	 */
   446	static int smb2_apsd_get_charger_type(struct smb2_chip *chip, int *val)
   447	{
   448		int rc;
   449		unsigned int apsd_stat, stat;
   450		int usb_online;
   451	
   452		rc = smb2_get_prop_usb_online(chip, &usb_online);
   453		if (rc < 0 || !usb_online) {
   454			*val = POWER_SUPPLY_USB_TYPE_UNKNOWN;
   455			return 0;
   456		}
   457	
   458		rc = regmap_read(chip->regmap, chip->base + APSD_STATUS, &apsd_stat);
   459		if (rc < 0) {
   460			dev_err(chip->dev, "Failed to read apsd status, rc = %d", rc);
   461			return rc;
   462		}
   463		if (!(apsd_stat & APSD_DTC_STATUS_DONE_BIT)) {
   464			dev_err(chip->dev, "Apsd not ready");
   465			return -EAGAIN;
   466		}
   467	
   468		rc = regmap_read(chip->regmap, chip->base + APSD_RESULT_STATUS, &stat);
   469		if (rc < 0) {
   470			dev_err(chip->dev, "Failed to read apsd result, rc = %d", rc);
   471			return rc;
   472		}
   473	
   474		stat &= APSD_RESULT_STATUS_MASK;
   475	
   476		if (stat & CDP_CHARGER_BIT)
   477			*val = POWER_SUPPLY_USB_TYPE_CDP;
   478		else if (stat & (DCP_CHARGER_BIT | OCP_CHARGER_BIT | FLOAT_CHARGER_BIT))
   479			*val = POWER_SUPPLY_USB_TYPE_DCP;
   480		else /* SDP_CHARGER_BIT (or others) */
   481			*val = POWER_SUPPLY_USB_TYPE_SDP;
   482	
   483		return 0;
   484	}
   485	
 > 486	int smb2_get_prop_status(struct smb2_chip *chip, int *val)
   487	{
   488		int usb_online_val;
   489		unsigned char stat[2];
   490		int rc;
   491	
   492		rc = smb2_get_prop_usb_online(chip, &usb_online_val);
   493		if (rc < 0) {
   494			dev_err(chip->dev, "Couldn't get usb online property rc = %d\n",
   495				rc);
   496			return rc;
   497		}
   498	
   499		if (!usb_online_val) {
   500			*val = POWER_SUPPLY_STATUS_DISCHARGING;
   501			return rc;
   502		}
   503	
   504		rc = regmap_bulk_read(chip->regmap,
   505				      chip->base + BATTERY_CHARGER_STATUS_1, &stat, 2);
   506		if (rc < 0) {
   507			dev_err(chip->dev, "Failed to read charging status ret=%d\n",
   508				rc);
   509			return rc;
   510		}
   511	
   512		if (stat[1] & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
   513			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
   514			return 0;
   515		}
   516	
   517		stat[0] = stat[0] & BATTERY_CHARGER_STATUS_MASK;
   518	
   519		switch (stat[0]) {
   520		case TRICKLE_CHARGE:
   521		case PRE_CHARGE:
   522		case FAST_CHARGE:
   523		case FULLON_CHARGE:
   524		case TAPER_CHARGE:
   525			*val = POWER_SUPPLY_STATUS_CHARGING;
   526			return rc;
   527		case DISABLE_CHARGE:
   528			*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
   529			return rc;
   530		case TERMINATE_CHARGE:
   531			*val = POWER_SUPPLY_STATUS_FULL;
   532			return rc;
   533		case INHIBIT_CHARGE:
   534		default:
   535			*val = POWER_SUPPLY_STATUS_UNKNOWN;
   536			return rc;
   537		}
   538	}
   539	
   540	static inline int smb2_get_current_limit(struct smb2_chip *chip,
   541						 unsigned int *val)
   542	{
   543		int rc = regmap_read(chip->regmap, chip->base + ICL_STATUS, val);
   544	
   545		if (rc >= 0)
   546			*val *= 25000;
   547		return rc;
   548	}
   549	
   550	static int smb2_set_current_limit(struct smb2_chip *chip, unsigned int val)
   551	{
   552		unsigned char val_raw;
   553	
   554		if (val > 4800000) {
   555			dev_err(chip->dev,
   556				"Can't set current limit higher than 4800000uA");
   557			return -EINVAL;
   558		}
   559		val_raw = val / 25000;
   560	
   561		return regmap_write(chip->regmap, chip->base + USBIN_CURRENT_LIMIT_CFG,
   562				    val_raw);
   563	}
   564	
 > 565	void smb2_status_change_work(struct work_struct *work)
   566	{
   567		struct smb2_chip *chip =
   568			container_of(work, struct smb2_chip, status_change_work.work);
   569		unsigned int charger_type, current_ua;
   570		int usb_online, count, rc;
   571	
   572		smb2_get_prop_usb_online(chip, &usb_online);
   573		if (usb_online == 0) {
   574			chip->default_curr_limit = 0;
   575			return;
   576		}
   577	
   578		for (count = 0; count < 3; count++) {
   579			dev_dbg(chip->dev, "get charger type retry %d\n", count);
   580			rc = smb2_apsd_get_charger_type(chip, &charger_type);
   581			if (rc == 0)
   582				break;
   583			msleep(100);
   584		}
   585	
   586		if (rc < 0) {
   587			rc = regmap_update_bits(chip->regmap, chip->base + CMD_APSD,
   588						APSD_RERUN_BIT, APSD_RERUN_BIT);
   589			schedule_delayed_work(&chip->status_change_work,
   590					      msecs_to_jiffies(1500));
   591			dev_dbg(chip->dev, "get charger type failed, rerun apsd\n");
   592			return;
   593		}
   594	
   595		switch (charger_type) {
   596		case POWER_SUPPLY_USB_TYPE_CDP:
   597			current_ua = CDP_CURRENT_UA;
   598			break;
   599		case POWER_SUPPLY_USB_TYPE_DCP:
   600			current_ua = DCP_CURRENT_UA;
   601			break;
   602		case POWER_SUPPLY_USB_TYPE_SDP:
   603		default:
   604			current_ua = SDP_CURRENT_UA;
   605			break;
   606		}
   607	
   608		chip->default_curr_limit = current_ua;
   609	
   610		smb2_set_current_limit(chip, current_ua);
   611		power_supply_changed(chip->chg_psy);
   612	}
   613	
 > 614	int smb2_get_iio_chan(struct smb2_chip *chip, struct iio_channel *chan,
   615			      int *val)
   616	{
   617		int rc;
   618		union power_supply_propval status;
   619	
   620		rc = power_supply_get_property(chip->chg_psy, POWER_SUPPLY_PROP_STATUS,
   621					       &status);
   622		if (rc < 0 || status.intval != POWER_SUPPLY_STATUS_CHARGING) {
   623			*val = 0;
   624			return 0;
   625		}
   626	
   627		if (IS_ERR(chan)) {
   628			dev_err(chip->dev, "Failed to chan, err = %li", PTR_ERR(chan));
   629			return PTR_ERR(chan);
   630		}
   631	
   632		return iio_read_channel_processed(chan, val);
   633	}
   634	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
