Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB6D53E0DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiFFFst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFFFsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:48:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3702A2C67C
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:48:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1BA9ACE09FE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96641C385A9;
        Mon,  6 Jun 2022 05:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654494516;
        bh=uV/W8JteRjqRHYI32yt1pSM0IYiEtvvT1A3Efee1q3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPGGboD1qyTaHHj9PbxeODPmN3mPjIN8wfFuOv1cCdiIjFyeX/BEaXZQHoHy5mj8h
         USMS352yHJ7+0Mn/AZeVD4yG73n6U6NJ8FJv67HSBNokejiD+ubpi6aPbQrEQACOIs
         pPffF5M4Hs7EEmiR9W5Gjf6pMuPW5/Q3fExhZ9h4=
Date:   Mon, 6 Jun 2022 07:48:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/4] staging: r8188eu: add error handling of rtw_read8
Message-ID: <Yp2VMecmrET9Mu3P@kroah.com>
References: <cover.1652994483.git.paskripkin@gmail.com>
 <541ab3341093a8f6bff1cf8e8aa0c7e247ff4833.1652994483.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <541ab3341093a8f6bff1cf8e8aa0c7e247ff4833.1652994483.git.paskripkin@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:09:47AM +0300, Pavel Skripkin wrote:
> rtw_read8() reads data from device via USB API which may fail. In case
> of any failure previous code returned stack data to callers, which is
> wrong.
> 
> Fix it by changing rtw_read8() prototype and prevent caller from
> touching random stack data
> 
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
> 
> Changes since v1:
> 	- Fix build error reported by kernel test robot
> 	- Fix res/ret confusion in rtl8188e_firmware_download
> 	- Fix possible infinity loop in rtl8188e_firmware_download
> 	- Undo unrelated white-space Changes
> 	- Fix wront return value in c2h_evt_read
> 
> ---
>  drivers/staging/r8188eu/core/rtw_efuse.c      |  13 +-
>  drivers/staging/r8188eu/core/rtw_fw.c         |  56 ++++--
>  drivers/staging/r8188eu/core/rtw_led.c        |  16 +-
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  49 +++++-
>  drivers/staging/r8188eu/core/rtw_wlan_util.c  |  20 ++-
>  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  18 +-
>  drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   9 +-
>  drivers/staging/r8188eu/hal/hal_com.c         |  27 ++-
>  drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  37 +++-
>  drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   6 +-
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  69 ++++++--
>  drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  10 +-
>  drivers/staging/r8188eu/hal/usb_halinit.c     | 160 ++++++++++++++----
>  drivers/staging/r8188eu/hal/usb_ops_linux.c   |   7 +-
>  drivers/staging/r8188eu/include/rtw_io.h      |   2 +-
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  11 +-
>  16 files changed, 410 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
> index 0e0e60638880..a2691c7f96f6 100644
> --- a/drivers/staging/r8188eu/core/rtw_efuse.c
> +++ b/drivers/staging/r8188eu/core/rtw_efuse.c
> @@ -28,14 +28,21 @@ ReadEFuseByte(
>  	u32 value32;
>  	u8 readbyte;
>  	u16 retry;
> +	int res;
>  
>  	/* Write Address */
>  	rtw_write8(Adapter, EFUSE_CTRL + 1, (_offset & 0xff));
> -	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 2);
> +	res = rtw_read8(Adapter, EFUSE_CTRL + 2, &readbyte);
> +	if (res)
> +		return;
> +
>  	rtw_write8(Adapter, EFUSE_CTRL + 2, ((_offset >> 8) & 0x03) | (readbyte & 0xfc));
>  
>  	/* Write bit 32 0 */
> -	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 3);
> +	res = rtw_read8(Adapter, EFUSE_CTRL + 3, &readbyte);
> +	if (res)
> +		return;
> +
>  	rtw_write8(Adapter, EFUSE_CTRL + 3, (readbyte & 0x7f));
>  
>  	/* Check bit 32 read-ready */
> @@ -54,6 +61,8 @@ ReadEFuseByte(
>  	value32 = rtw_read32(Adapter, EFUSE_CTRL);
>  
>  	*pbuf = (u8)(value32 & 0xff);
> +
> +	/* FIXME: return an error to caller */
>  }
>  
>  /*-----------------------------------------------------------------------------
> diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
> index bf077876ed3d..638dc3ddfbcc 100644
> --- a/drivers/staging/r8188eu/core/rtw_fw.c
> +++ b/drivers/staging/r8188eu/core/rtw_fw.c
> @@ -44,18 +44,28 @@ static_assert(sizeof(struct rt_firmware_hdr) == 32);
>  static void fw_download_enable(struct adapter *padapter, bool enable)
>  {
>  	u8 tmp;
> +	int res;
>  
>  	if (enable) {
>  		/*  MCU firmware download enable. */
> -		tmp = rtw_read8(padapter, REG_MCUFWDL);
> +		res = rtw_read8(padapter, REG_MCUFWDL, &tmp);
> +		if (res)
> +			return;
> +
>  		rtw_write8(padapter, REG_MCUFWDL, tmp | 0x01);
>  
>  		/*  8051 reset */
> -		tmp = rtw_read8(padapter, REG_MCUFWDL + 2);
> +		res = rtw_read8(padapter, REG_MCUFWDL + 2, &tmp);
> +		if (res)
> +			return;
> +
>  		rtw_write8(padapter, REG_MCUFWDL + 2, tmp & 0xf7);
>  	} else {
>  		/*  MCU firmware download disable. */
> -		tmp = rtw_read8(padapter, REG_MCUFWDL);
> +		res = rtw_read8(padapter, REG_MCUFWDL, &tmp);
> +		if (res)
> +			return;
> +
>  		rtw_write8(padapter, REG_MCUFWDL, tmp & 0xfe);
>  
>  		/*  Reserved for fw extension. */
> @@ -125,8 +135,13 @@ static int page_write(struct adapter *padapter, u32 page, u8 *buffer, u32 size)
>  {
>  	u8 value8;
>  	u8 u8Page = (u8)(page & 0x07);
> +	int res;
> +
> +	res = rtw_read8(padapter, REG_MCUFWDL + 2, &value8);
> +	if (res)
> +		return _FAIL;
>  
> -	value8 = (rtw_read8(padapter, REG_MCUFWDL + 2) & 0xF8) | u8Page;
> +	value8 = (value8 & 0xF8) | u8Page;
>  	rtw_write8(padapter, REG_MCUFWDL + 2, value8);
>  
>  	return block_write(padapter, buffer, size);
> @@ -165,8 +180,12 @@ static int write_fw(struct adapter *padapter, u8 *buffer, u32 size)
>  void rtw_reset_8051(struct adapter *padapter)
>  {
>  	u8 val8;
> +	int res;
> +
> +	res = rtw_read8(padapter, REG_SYS_FUNC_EN + 1, &val8);
> +	if (res)
> +		return;
>  
> -	val8 = rtw_read8(padapter, REG_SYS_FUNC_EN + 1);
>  	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, val8 & (~BIT(2)));
>  	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, val8 | (BIT(2)));
>  }
> @@ -239,7 +258,7 @@ static int load_firmware(struct rt_firmware *rtfw, struct device *device)
>  int rtl8188e_firmware_download(struct adapter *padapter)
>  {
>  	int ret = _SUCCESS;
> -	u8 write_fw_retry = 0;
> +	u8 reg;
>  	unsigned long fwdl_timeout;
>  	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
>  	struct device *device = dvobj_to_dev(dvobj);
> @@ -269,23 +288,34 @@ int rtl8188e_firmware_download(struct adapter *padapter)
>  
>  	/*  Suggested by Filen. If 8051 is running in RAM code, driver should inform Fw to reset by itself, */
>  	/*  or it will cause download Fw fail. 2010.02.01. by tynli. */
> -	if (rtw_read8(padapter, REG_MCUFWDL) & RAM_DL_SEL) { /* 8051 RAM code */
> +	ret = rtw_read8(padapter, REG_MCUFWDL, &reg);
> +	if (ret) {
> +		ret = _FAIL;
> +		goto exit;
> +	}
> +
> +	if (reg & RAM_DL_SEL) { /* 8051 RAM code */
>  		rtw_write8(padapter, REG_MCUFWDL, 0x00);
>  		rtw_reset_8051(padapter);
>  	}
>  
>  	fw_download_enable(padapter, true);
>  	fwdl_timeout = jiffies + msecs_to_jiffies(500);
> -	while (1) {
> +	do {
>  		/* reset the FWDL chksum */
> -		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_CHKSUM_RPT);
> +		ret = rtw_read8(padapter, REG_MCUFWDL, &reg);
> +		if (ret) {
> +			ret = _FAIL;
> +			continue;
> +		}
>  
> -		ret = write_fw(padapter, fw_data, fw_size);
> +		rtw_write8(padapter, REG_MCUFWDL, reg | FWDL_CHKSUM_RPT);
>  
> -		if (ret == _SUCCESS ||
> -		    (time_after(jiffies, fwdl_timeout) && write_fw_retry++ >= 3))
> +		ret = write_fw(padapter, fw_data, fw_size);
> +		if (ret == _SUCCESS)
>  			break;
> -	}
> +	} while (!time_after(jiffies, fwdl_timeout));
> +
>  	fw_download_enable(padapter, false);
>  	if (ret != _SUCCESS)
>  		goto exit;
> diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
> index 2f3000428af7..25989acf5259 100644
> --- a/drivers/staging/r8188eu/core/rtw_led.c
> +++ b/drivers/staging/r8188eu/core/rtw_led.c
> @@ -35,11 +35,15 @@ static void ResetLedStatus(struct LED_871x *pLed)
>  static void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
>  {
>  	u8	LedCfg;
> +	int res;
>  
>  	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
>  		return;
>  
> -	LedCfg = rtw_read8(padapter, REG_LEDCFG2);
> +	res = rtw_read8(padapter, REG_LEDCFG2, &LedCfg);
> +	if (res)
> +		return;
> +
>  	rtw_write8(padapter, REG_LEDCFG2, (LedCfg & 0xf0) | BIT(5) | BIT(6)); /*  SW control led0 on. */
>  	pLed->bLedOn = true;
>  }
> @@ -47,15 +51,21 @@ static void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
>  static void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
>  {
>  	u8	LedCfg;
> +	int res;
>  
>  	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
>  		goto exit;
>  
> -	LedCfg = rtw_read8(padapter, REG_LEDCFG2);/* 0x4E */
> +	res = rtw_read8(padapter, REG_LEDCFG2, &LedCfg);/* 0x4E */
> +	if (res)
> +		goto exit;
>  
>  	LedCfg &= 0x90; /*  Set to software control. */
>  	rtw_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3)));
> -	LedCfg = rtw_read8(padapter, REG_MAC_PINMUX_CFG);
> +	res = rtw_read8(padapter, REG_MAC_PINMUX_CFG, &LedCfg);
> +	if (res)
> +		goto exit;
> +
>  	LedCfg &= 0xFE;
>  	rtw_write8(padapter, REG_MAC_PINMUX_CFG, LedCfg);
>  exit:
> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 848b5051aa13..d4e59fab367c 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -5672,14 +5672,28 @@ unsigned int send_beacon(struct adapter *padapter)
>  
>  bool get_beacon_valid_bit(struct adapter *adapter)
>  {
> +	int res;
> +	u8 reg;
> +
> +	res = rtw_read8(adapter, REG_TDECTRL + 2, &reg);
> +	if (res)
> +		return false;
> +
>  	/* BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2 */
> -	return BIT(0) & rtw_read8(adapter, REG_TDECTRL + 2);
> +	return BIT(0) & reg;
>  }
>  
>  void clear_beacon_valid_bit(struct adapter *adapter)
>  {
> +	int res;
> +	u8 reg;
> +
> +	res = rtw_read8(adapter, REG_TDECTRL + 2, &reg);
> +	if (res)
> +		return;
> +
>  	/* BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
> -	rtw_write8(adapter, REG_TDECTRL + 2, rtw_read8(adapter, REG_TDECTRL + 2) | BIT(0));
> +	rtw_write8(adapter, REG_TDECTRL + 2, reg | BIT(0));
>  }
>  
>  /****************************************************************************
> @@ -6007,7 +6021,8 @@ static void rtw_set_bssid(struct adapter *adapter, u8 *bssid)
>  static void mlme_join(struct adapter *adapter, int type)
>  {
>  	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
> -	u8 retry_limit = 0x30;
> +	u8 retry_limit = 0x30, reg;
> +	int res;
>  
>  	switch (type) {
>  	case 0:
> @@ -6032,7 +6047,11 @@ static void mlme_join(struct adapter *adapter, int type)
>  	case 2:
>  		/* sta add event call back */
>  		/* enable update TSF */
> -		rtw_write8(adapter, REG_BCN_CTRL, rtw_read8(adapter, REG_BCN_CTRL) & (~BIT(4)));
> +		res = rtw_read8(adapter, REG_BCN_CTRL, &reg);
> +		if (res)
> +			return;
> +
> +		rtw_write8(adapter, REG_BCN_CTRL, reg & (~BIT(4)));
>  
>  		if (check_fwstate(mlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE))
>  			retry_limit = 0x7;
> @@ -6753,6 +6772,9 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
>  
>  static void mlme_disconnect(struct adapter *adapter)
>  {
> +	int res;
> +	u8 reg;
> +
>  	/* Set RCR to not to receive data frame when NO LINK state */
>  	/* reject all data frames */
>  	rtw_write16(adapter, REG_RXFLTMAP2, 0x00);
> @@ -6761,7 +6783,12 @@ static void mlme_disconnect(struct adapter *adapter)
>  	rtw_write8(adapter, REG_DUAL_TSF_RST, (BIT(0) | BIT(1)));
>  
>  	/* disable update TSF */
> -	rtw_write8(adapter, REG_BCN_CTRL, rtw_read8(adapter, REG_BCN_CTRL) | BIT(4));
> +
> +	res = rtw_read8(adapter, REG_BCN_CTRL, &reg);
> +	if (res)
> +		return;
> +
> +	rtw_write8(adapter, REG_BCN_CTRL, reg | BIT(4));
>  }
>  
>  void mlmeext_sta_del_event_callback(struct adapter *padapter)
> @@ -6818,11 +6845,15 @@ static u8 chk_ap_is_alive(struct sta_info *psta)
>  static void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
>  {
>  	u32 rx_dma_status =  rtw_read32(padapter, REG_RXDMA_STATUS);
> +	int res;
> +	u8 reg;
>  
>  	if (rx_dma_status != 0x00)
>  		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
>  
> -	rtw_read8(padapter, REG_FMETHR);
> +	/* FIXME: should this read be removed? */
> +	res = rtw_read8(padapter, REG_FMETHR, &reg);
> +	(void)res;

What is that?  We don't do "empty" lines like this in the kernel for no
good reason.  If the return value must be checked, then that's fine, but
don't do it this way.  Shouldn't the function itself return an error?

And reading a value is sometimes required by hardware in order to have
the write call go through.  But that's for PCI devices, not normally USB
devices, but we could be wrong.  I wouldn't put a FIXME in here unless
you have some plan for how to eventually solve it, otherwise someone
might just drop it without knowing why the FIXME was ever added.




>  }
>  
>  void linked_status_chk(struct adapter *padapter)
> @@ -7224,6 +7255,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
>  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
>  	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
>  	u8 val8;
> +	int res;
>  
>  	if (is_client_associated_to_ap(padapter))
>  		issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms / 100, 100);
> @@ -7236,7 +7268,10 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
>  
>  	if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE)) {
>  		/* Stop BCN */
> -		val8 = rtw_read8(padapter, REG_BCN_CTRL);
> +		res = rtw_read8(padapter, REG_BCN_CTRL, &val8);
> +		if (res)
> +			return H2C_DROPPED;
> +
>  		rtw_write8(padapter, REG_BCN_CTRL, val8 & (~(EN_BCN_FUNCTION | EN_TXBCN_RPT)));
>  	}
>  
> diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> index 27035eac6e61..f5002c88a5ac 100644
> --- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
> +++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
> @@ -279,8 +279,13 @@ void Restore_DM_Func_Flag(struct adapter *padapter)
>  void Set_MSR(struct adapter *padapter, u8 type)
>  {
>  	u8 val8;
> +	int res;
>  
> -	val8 = rtw_read8(padapter, MSR) & 0x0c;
> +	res = rtw_read8(padapter, MSR, &val8);
> +	if (res)
> +		return;
> +
> +	val8 &= 0x0c;
>  	val8 |= type;
>  	rtw_write8(padapter, MSR, val8);
>  }
> @@ -505,7 +510,11 @@ int WMM_param_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
>  
>  static void set_acm_ctrl(struct adapter *adapter, u8 acm_mask)
>  {
> -	u8 acmctrl = rtw_read8(adapter, REG_ACMHWCTRL);
> +	u8 acmctrl;
> +	int res = rtw_read8(adapter, REG_ACMHWCTRL, &acmctrl);
> +
> +	if (res)
> +		return;
>  
>  	if (acm_mask > 1)
>  		acmctrl = acmctrl | 0x1;
> @@ -763,6 +772,7 @@ void HT_info_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
>  static void set_min_ampdu_spacing(struct adapter *adapter, u8 spacing)
>  {
>  	u8 sec_spacing;
> +	int res;
>  
>  	if (spacing <= 7) {
>  		switch (adapter->securitypriv.dot11PrivacyAlgrthm) {
> @@ -784,8 +794,12 @@ static void set_min_ampdu_spacing(struct adapter *adapter, u8 spacing)
>  		if (spacing < sec_spacing)
>  			spacing = sec_spacing;
>  
> +		res = rtw_read8(adapter, REG_AMPDU_MIN_SPACE, &sec_spacing);
> +		if (res)
> +			return;
> +
>  		rtw_write8(adapter, REG_AMPDU_MIN_SPACE,
> -			   (rtw_read8(adapter, REG_AMPDU_MIN_SPACE) & 0xf8) | spacing);
> +			   (sec_spacing & 0xf8) | spacing);
>  	}
>  }
>  
> diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> index b944c8071a3b..a5b7980dfcee 100644
> --- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> +++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
> @@ -463,6 +463,7 @@ void _PHY_SaveADDARegisters(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup
>  	}
>  }
>  
> +/* FIXME: return an error to caller */

When are these FIXME going to be resolved?  I don't like adding them for
no good reason.

thanks,

greg k-h
