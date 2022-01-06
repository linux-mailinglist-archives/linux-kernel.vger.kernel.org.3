Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C282486B85
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244063AbiAFVBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:01:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:5325 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244010AbiAFVBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641502893; x=1673038893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MExrm/ErUuEdtAK9P7TMNk3mOSTTZQ4Fo8qfxxOVe5E=;
  b=AJ7SOiwh9OI44LYoGdIyMtpxvC0ERbqdxlt4ZuL/P76vUKEEUt9BWL+X
   Floj+Ag/vsfwzVuvnHSfUdskTXQqn+Xjt9fH7b1jDxa4yJJyf2V8bFZMj
   K/5WIAmOipl5c5pvE+Al4cRWWm3oUUCiHI8+rED+r9g9tswJbtBrs1C5O
   dg58uLPNlJLLVTKKxxXHYrb/R3rfync/SFvE7hafdKaTqptv5knhs/nu0
   14lfLmqn1f7pEI5MBQDk6X+uGu9KKVFXbETEnUXBYp+SEA8DHAfFozuIZ
   qzj5Y9qQfPRQnajs36jYM9GvcDtTbeWJCGhDkZHsmAv74Fde7X/E289Fe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241553896"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="241553896"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 13:01:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="557044627"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Jan 2022 13:01:30 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5Zt3-000Hxc-CF; Thu, 06 Jan 2022 21:01:29 +0000
Date:   Fri, 7 Jan 2022 05:00:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, dan.carpenter@oracle.com,
        hdegoede@redhat.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtl8723bs: fix memory leak error
Message-ID: <202201070423.WeoyORXE-lkp@intel.com>
References: <20220105123447.24674-1-asha.16@itfac.mrt.ac.lk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105123447.24674-1-asha.16@itfac.mrt.ac.lk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "F.A.Sulaiman",

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v5.16-rc8 next-20220106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/F-A-Sulaiman/rtl8723bs-fix-memory-leak-error/20220105-203752
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 0640d18b15d86ab76275e63f36f5841db5f52e74
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220107/202201070423.WeoyORXE-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1a1faafe5fcac0069aad1036ce1757e87ba847d3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review F-A-Sulaiman/rtl8723bs-fix-memory-leak-error/20220105-203752
        git checkout 1a1faafe5fcac0069aad1036ce1757e87ba847d3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/mmc/host/ drivers/staging/rtl8723bs/ fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:421:1: warning: unused label 'release_fw1' [-Wunused-label]
   release_fw1:
   ^~~~~~~~~~~~
   drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:957:5: warning: variable 'hoffset' set but not used [-Wunused-but-set-variable]
           u8 hoffset = 0, hworden = 0;
              ^
   drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c:1050:5: warning: variable 'hoffset' set but not used [-Wunused-but-set-variable]
           u8 hoffset = 0, hworden = 0;
              ^
   3 warnings generated.


vim +/release_fw1 +421 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c

554c0a3abf216c Hans de Goede  2017-03-29  286  
554c0a3abf216c Hans de Goede  2017-03-29  287  /*  */
554c0a3abf216c Hans de Goede  2017-03-29  288  /* 	Description: */
554c0a3abf216c Hans de Goede  2017-03-29  289  /* 		Download 8192C firmware code. */
554c0a3abf216c Hans de Goede  2017-03-29  290  /*  */
554c0a3abf216c Hans de Goede  2017-03-29  291  /*  */
554c0a3abf216c Hans de Goede  2017-03-29  292  s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
554c0a3abf216c Hans de Goede  2017-03-29  293  {
554c0a3abf216c Hans de Goede  2017-03-29  294  	s32 rtStatus = _SUCCESS;
554c0a3abf216c Hans de Goede  2017-03-29  295  	u8 write_fw = 0;
554c0a3abf216c Hans de Goede  2017-03-29  296  	unsigned long fwdl_start_time;
554c0a3abf216c Hans de Goede  2017-03-29  297  	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
554c0a3abf216c Hans de Goede  2017-03-29  298  	struct rt_firmware *pFirmware;
554c0a3abf216c Hans de Goede  2017-03-29  299  	struct rt_firmware *pBTFirmware;
554c0a3abf216c Hans de Goede  2017-03-29  300  	struct rt_firmware_hdr *pFwHdr = NULL;
554c0a3abf216c Hans de Goede  2017-03-29  301  	u8 *pFirmwareBuf;
554c0a3abf216c Hans de Goede  2017-03-29  302  	u32 FirmwareLen;
554c0a3abf216c Hans de Goede  2017-03-29  303  	const struct firmware *fw;
554c0a3abf216c Hans de Goede  2017-03-29  304  	struct device *device = dvobj_to_dev(padapter->dvobj);
554c0a3abf216c Hans de Goede  2017-03-29  305  	u8 *fwfilepath;
554c0a3abf216c Hans de Goede  2017-03-29  306  	struct dvobj_priv *psdpriv = padapter->dvobj;
554c0a3abf216c Hans de Goede  2017-03-29  307  	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
554c0a3abf216c Hans de Goede  2017-03-29  308  	u8 tmp_ps;
554c0a3abf216c Hans de Goede  2017-03-29  309  
554c0a3abf216c Hans de Goede  2017-03-29  310  	pFirmware = kzalloc(sizeof(struct rt_firmware), GFP_KERNEL);
7e2b0aaec63351 Larry Finger   2017-04-08  311  	if (!pFirmware)
7e2b0aaec63351 Larry Finger   2017-04-08  312  		return _FAIL;
554c0a3abf216c Hans de Goede  2017-03-29  313  	pBTFirmware = kzalloc(sizeof(struct rt_firmware), GFP_KERNEL);
7e2b0aaec63351 Larry Finger   2017-04-08  314  	if (!pBTFirmware) {
7e2b0aaec63351 Larry Finger   2017-04-08  315  		kfree(pFirmware);
7e2b0aaec63351 Larry Finger   2017-04-08  316  		return _FAIL;
554c0a3abf216c Hans de Goede  2017-03-29  317  	}
554c0a3abf216c Hans de Goede  2017-03-29  318  	tmp_ps = rtw_read8(padapter, 0xa3);
554c0a3abf216c Hans de Goede  2017-03-29  319  	tmp_ps &= 0xf8;
554c0a3abf216c Hans de Goede  2017-03-29  320  	tmp_ps |= 0x02;
554c0a3abf216c Hans de Goede  2017-03-29  321  	/* 1. write 0xA3[:2:0] = 3b'010 */
554c0a3abf216c Hans de Goede  2017-03-29  322  	rtw_write8(padapter, 0xa3, tmp_ps);
554c0a3abf216c Hans de Goede  2017-03-29  323  	/* 2. read power_state = 0xA0[1:0] */
554c0a3abf216c Hans de Goede  2017-03-29  324  	tmp_ps = rtw_read8(padapter, 0xa0);
554c0a3abf216c Hans de Goede  2017-03-29  325  	tmp_ps &= 0x03;
709c8e49b51c37 Fabio Aiuto    2021-04-07  326  	if (tmp_ps != 0x01)
554c0a3abf216c Hans de Goede  2017-03-29  327  		pdbgpriv->dbg_downloadfw_pwr_state_cnt++;
554c0a3abf216c Hans de Goede  2017-03-29  328  
554c0a3abf216c Hans de Goede  2017-03-29  329  	fwfilepath = "rtlwifi/rtl8723bs_nic.bin";
554c0a3abf216c Hans de Goede  2017-03-29  330  
b388285205609c Colin Ian King 2017-04-11  331  	pr_info("rtl8723bs: acquire FW from file:%s\n", fwfilepath);
554c0a3abf216c Hans de Goede  2017-03-29  332  
554c0a3abf216c Hans de Goede  2017-03-29  333  	rtStatus = request_firmware(&fw, fwfilepath, device);
554c0a3abf216c Hans de Goede  2017-03-29  334  	if (rtStatus) {
554c0a3abf216c Hans de Goede  2017-03-29  335  		pr_err("Request firmware failed with error 0x%x\n", rtStatus);
554c0a3abf216c Hans de Goede  2017-03-29  336  		rtStatus = _FAIL;
554c0a3abf216c Hans de Goede  2017-03-29  337  		goto exit;
554c0a3abf216c Hans de Goede  2017-03-29  338  	}
554c0a3abf216c Hans de Goede  2017-03-29  339  
554c0a3abf216c Hans de Goede  2017-03-29  340  	if (!fw) {
554c0a3abf216c Hans de Goede  2017-03-29  341  		pr_err("Firmware %s not available\n", fwfilepath);
554c0a3abf216c Hans de Goede  2017-03-29  342  		rtStatus = _FAIL;
554c0a3abf216c Hans de Goede  2017-03-29  343  		goto exit;
554c0a3abf216c Hans de Goede  2017-03-29  344  	}
554c0a3abf216c Hans de Goede  2017-03-29  345  
554c0a3abf216c Hans de Goede  2017-03-29  346  	if (fw->size > FW_8723B_SIZE) {
554c0a3abf216c Hans de Goede  2017-03-29  347  		rtStatus = _FAIL;
554c0a3abf216c Hans de Goede  2017-03-29  348  		goto exit;
554c0a3abf216c Hans de Goede  2017-03-29  349  	}
554c0a3abf216c Hans de Goede  2017-03-29  350  
93998817a169c0 Quytelda Kahja 2018-05-22  351  	pFirmware->fw_buffer_sz = kmemdup(fw->data, fw->size, GFP_KERNEL);
93998817a169c0 Quytelda Kahja 2018-05-22  352  	if (!pFirmware->fw_buffer_sz) {
554c0a3abf216c Hans de Goede  2017-03-29  353  		rtStatus = _FAIL;
554c0a3abf216c Hans de Goede  2017-03-29  354  		goto exit;
554c0a3abf216c Hans de Goede  2017-03-29  355  	}
554c0a3abf216c Hans de Goede  2017-03-29  356  
93998817a169c0 Quytelda Kahja 2018-05-22  357  	pFirmware->fw_length = fw->size;
554c0a3abf216c Hans de Goede  2017-03-29  358  	release_firmware(fw);
93998817a169c0 Quytelda Kahja 2018-05-22  359  	if (pFirmware->fw_length > FW_8723B_SIZE) {
554c0a3abf216c Hans de Goede  2017-03-29  360  		rtStatus = _FAIL;
79df841b435018 Fabio Aiuto    2021-04-15  361  		netdev_emerg(padapter->pnetdev,
79df841b435018 Fabio Aiuto    2021-04-15  362  			     "Firmware size:%u exceed %u\n",
79df841b435018 Fabio Aiuto    2021-04-15  363  			     pFirmware->fw_length, FW_8723B_SIZE);
1a1faafe5fcac0 F.A.Sulaiman   2022-01-05  364  		goto exit;
554c0a3abf216c Hans de Goede  2017-03-29  365  	}
554c0a3abf216c Hans de Goede  2017-03-29  366  
93998817a169c0 Quytelda Kahja 2018-05-22  367  	pFirmwareBuf = pFirmware->fw_buffer_sz;
93998817a169c0 Quytelda Kahja 2018-05-22  368  	FirmwareLen = pFirmware->fw_length;
554c0a3abf216c Hans de Goede  2017-03-29  369  
554c0a3abf216c Hans de Goede  2017-03-29  370  	/*  To Check Fw header. Added by tynli. 2009.12.04. */
554c0a3abf216c Hans de Goede  2017-03-29  371  	pFwHdr = (struct rt_firmware_hdr *)pFirmwareBuf;
554c0a3abf216c Hans de Goede  2017-03-29  372  
699ad73456d6c9 Quytelda Kahja 2018-05-22  373  	pHalData->FirmwareVersion =  le16_to_cpu(pFwHdr->version);
699ad73456d6c9 Quytelda Kahja 2018-05-22  374  	pHalData->FirmwareSubVersion = le16_to_cpu(pFwHdr->subversion);
699ad73456d6c9 Quytelda Kahja 2018-05-22  375  	pHalData->FirmwareSignature = le16_to_cpu(pFwHdr->signature);
554c0a3abf216c Hans de Goede  2017-03-29  376  
554c0a3abf216c Hans de Goede  2017-03-29  377  	if (IS_FW_HEADER_EXIST_8723B(pFwHdr)) {
554c0a3abf216c Hans de Goede  2017-03-29  378  		/*  Shift 32 bytes for FW header */
554c0a3abf216c Hans de Goede  2017-03-29  379  		pFirmwareBuf = pFirmwareBuf + 32;
554c0a3abf216c Hans de Goede  2017-03-29  380  		FirmwareLen = FirmwareLen - 32;
554c0a3abf216c Hans de Goede  2017-03-29  381  	}
554c0a3abf216c Hans de Goede  2017-03-29  382  
554c0a3abf216c Hans de Goede  2017-03-29  383  	/*  Suggested by Filen. If 8051 is running in RAM code, driver should inform Fw to reset by itself, */
554c0a3abf216c Hans de Goede  2017-03-29  384  	/*  or it will cause download Fw fail. 2010.02.01. by tynli. */
554c0a3abf216c Hans de Goede  2017-03-29  385  	if (rtw_read8(padapter, REG_MCUFWDL) & RAM_DL_SEL) { /* 8051 RAM code */
554c0a3abf216c Hans de Goede  2017-03-29  386  		rtw_write8(padapter, REG_MCUFWDL, 0x00);
554c0a3abf216c Hans de Goede  2017-03-29  387  		rtl8723b_FirmwareSelfReset(padapter);
554c0a3abf216c Hans de Goede  2017-03-29  388  	}
554c0a3abf216c Hans de Goede  2017-03-29  389  
554c0a3abf216c Hans de Goede  2017-03-29  390  	_FWDownloadEnable(padapter, true);
554c0a3abf216c Hans de Goede  2017-03-29  391  	fwdl_start_time = jiffies;
554c0a3abf216c Hans de Goede  2017-03-29  392  	while (
554c0a3abf216c Hans de Goede  2017-03-29  393  		!padapter->bDriverStopped &&
554c0a3abf216c Hans de Goede  2017-03-29  394  		!padapter->bSurpriseRemoved &&
554c0a3abf216c Hans de Goede  2017-03-29  395  		(write_fw++ < 3 || jiffies_to_msecs(jiffies - fwdl_start_time) < 500)
554c0a3abf216c Hans de Goede  2017-03-29  396  	) {
554c0a3abf216c Hans de Goede  2017-03-29  397  		/* reset FWDL chksum */
554c0a3abf216c Hans de Goede  2017-03-29  398  		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL)|FWDL_ChkSum_rpt);
554c0a3abf216c Hans de Goede  2017-03-29  399  
554c0a3abf216c Hans de Goede  2017-03-29  400  		rtStatus = _WriteFW(padapter, pFirmwareBuf, FirmwareLen);
554c0a3abf216c Hans de Goede  2017-03-29  401  		if (rtStatus != _SUCCESS)
554c0a3abf216c Hans de Goede  2017-03-29  402  			continue;
554c0a3abf216c Hans de Goede  2017-03-29  403  
554c0a3abf216c Hans de Goede  2017-03-29  404  		rtStatus = polling_fwdl_chksum(padapter, 5, 50);
554c0a3abf216c Hans de Goede  2017-03-29  405  		if (rtStatus == _SUCCESS)
554c0a3abf216c Hans de Goede  2017-03-29  406  			break;
554c0a3abf216c Hans de Goede  2017-03-29  407  	}
554c0a3abf216c Hans de Goede  2017-03-29  408  	_FWDownloadEnable(padapter, false);
554c0a3abf216c Hans de Goede  2017-03-29  409  	if (_SUCCESS != rtStatus)
554c0a3abf216c Hans de Goede  2017-03-29  410  		goto fwdl_stat;
554c0a3abf216c Hans de Goede  2017-03-29  411  
554c0a3abf216c Hans de Goede  2017-03-29  412  	rtStatus = _FWFreeToGo(padapter, 10, 200);
554c0a3abf216c Hans de Goede  2017-03-29  413  	if (_SUCCESS != rtStatus)
554c0a3abf216c Hans de Goede  2017-03-29  414  		goto fwdl_stat;
554c0a3abf216c Hans de Goede  2017-03-29  415  
554c0a3abf216c Hans de Goede  2017-03-29  416  fwdl_stat:
554c0a3abf216c Hans de Goede  2017-03-29  417  
554c0a3abf216c Hans de Goede  2017-03-29  418  exit:
93998817a169c0 Quytelda Kahja 2018-05-22  419  	kfree(pFirmware->fw_buffer_sz);
554c0a3abf216c Hans de Goede  2017-03-29  420  	kfree(pFirmware);
7e2b0aaec63351 Larry Finger   2017-04-08 @421  release_fw1:
554c0a3abf216c Hans de Goede  2017-03-29  422  	kfree(pBTFirmware);
554c0a3abf216c Hans de Goede  2017-03-29  423  	return rtStatus;
554c0a3abf216c Hans de Goede  2017-03-29  424  }
554c0a3abf216c Hans de Goede  2017-03-29  425  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
