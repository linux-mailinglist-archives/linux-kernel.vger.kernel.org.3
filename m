Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3444E9874
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243333AbiC1NmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiC1NmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:42:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD13525E8A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EE46B810CC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406FAC004DD;
        Mon, 28 Mar 2022 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648474834;
        bh=nsDVTcLJAlDEdPtl9wXiY/SFJsjHJkvi1jMTA8Tjinw=;
        h=Date:From:To:Cc:Subject:From;
        b=R5sfbbvm1XCZkuGS3fcYO7DwsHou/TR3JKS2DTbVQIssERljQROXux+CK/BuXHF0y
         D2mnETMe+b3tlpMyqPnVnDOky9nBR3KVGNMUo0PcisLu+ETH33Ju/ouhVLWYnGHvJn
         JhQAvktry1ST6v1+DSfq44mCX8paat4W4nUjoWOw=
Date:   Mon, 28 Mar 2022 15:40:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver changes for 5.18-rc1
Message-ID: <YkG60GW9QJ8OCWjd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 09688c0166e76ce2fb85e86b9d99be8b0084cdf9:

  Linux 5.17-rc8 (2022-03-13 13:23:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.18-rc1

for you to fetch changes up to 41197a5f11a4b2d11ac19bc62552022153032811:

  staging: r8188eu: remove unnecessary memset in r8188eu (2022-03-18 13:45:09 +0100)

----------------------------------------------------------------
Staging driver update for 5.18-rc1

Here is the big set of staging driver updates for 5.18-rc1.

Loads of tiny cleanups for almost all staging drivers in here, nothing
major at all.  Highlights include:
	- remove the ashmem Android driver.  It is long-dead and if
	  there are any legacy userspace applications still using it,
	  the Android kernel images will maintain it, the community
	  shouldn't care about it anymore
	- wfx wifi driver major cleanups.  Should be ready to merge out
	  of staging soon, and will coordinate with the wifi maintainers
	  after -rc1 is out
	- major cleanups and unwinding of the layers of the r8188eu
	  driver.  It's amazing just how many unneeded layers of
	  abstraction is in there, just when we think it's done, another
	  is found...
	- lots of tiny coding style cleanups in many other staging
	  drivers.

There will be merge conflict with a fbtft change and the spi driver
changes in your tree, but it's pretty obvious what to do (the function
shouldn't return anything.)

All have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abdun Nihaal (41):
      staging: r8188eu: remove unneeded variable in rtw_wx_get_essid
      staging: r8188eu: remove unneeded variable in rtw_wx_get_enc
      staging: r8188eu: remove unneeded variable in rtw_p2p_get
      staging: r8188eu: remove unneeded variable in rtw_p2p_get_wps_configmethod
      staging: r8188eu: remove unneeded variable in rtw_p2p_get_go_device_address
      staging: r8188eu: remove unneeded variable in rtw_p2p_get_device_type
      staging: r8188eu: remove unneeded variable in rtw_p2p_get_device_name
      staging: r8188eu: remove unneeded variable in rtw_p2p_get_invitation_procedure
      staging: r8188eu: propagate error code in rtw_p2p_get2
      staging: r8188eu: convert rtw_p2p_set_go_nego_ssid to return void
      staging: r8188eu: convert rtw_p2p_setDN to return void
      staging: r8188eu: convert rtw_p2p_get_status to return void
      staging: r8188eu: convert rtw_p2p_get_req_cm to return void
      staging: r8188eu: convert rtw_p2p_get_role to return void
      staging: r8188eu: convert rtw_p2p_get_peer_ifaddr to return void
      staging: r8188eu: convert rtw_p2p_get_peer_devaddr to return void
      staging: r8188eu: convert rtw_p2p_get_peer_devaddr_by_invitation to return void
      staging: r8188eu: convert rtw_p2p_get_groupid to return void
      staging: r8188eu: convert rtw_p2p_get_op_ch to return void
      staging: r8188eu: convert rtw_p2p_invite_req to return void
      staging: r8188eu: convert rtw_p2p_set_persistent to return void
      staging: r8188eu: convert rtw_p2p_prov_disc to return void
      staging: r8188eu: convert rtw_p2p_got_wpsinfo to return void
      staging: r8188eu: remove unused struct zero_bulkout_context
      staging: r8188eu: remove empty function rtw_get_encrypt_decrypt_from_registrypriv
      staging: r8188eu: remove empty function rtw_mfree_mlme_priv_lock
      staging: r8188eu: remove empty function _InitOperationMode
      staging: r8188eu: remove empty function __nat25_db_print
      staging: r8188eu: remove unused argument in __nat25_has_expired
      staging: r8188eu: remove unused argument in on_action_public_default
      staging: r8188eu: remove unused argument in chk_ap_is_alive
      staging: r8188eu: remove unused macros in sta_info.h
      staging: r8188eu: remove unused field list
      staging: r8188eu: remove unused field recvbuf_lock
      staging: r8188eu: remove unused fields in struct recv_buf
      staging: r8188eu: remove unused field phead
      staging: r8188eu: remove unused field ptail
      staging: r8188eu: remove unused field pend
      staging: r8188eu: remove unused field pdata
      staging: r8188eu: remove unneeded field pbuf
      staging: r8188eu: remove unused fields in struct recv_buf

Andy Shevchenko (2):
      staging: fbtft: Constify buf parameter in fbtft_dbg_hex()
      staging: fbtft: Consider type of init sequence values in fbtft_init_display()

Arınç ÜNAL (10):
      staging: mt7621-dts: fix formatting
      staging: mt7621-dts: fix switch0@0 warnings
      staging: mt7621-dts: use trgmii on gmac0 and enable flow control on port@6
      staging: mt7621-dts: fix pinctrl properties for ethernet
      staging: mt7621-dts: fix pinctrl-0 items to be size-1 items on ethernet
      staging: mt7621-dts: do not use rgmii2_pins for ethernet on GB-PC1
      staging: mt7621-dts: fix LEDs and pinctrl on GB-PC1 devicetree
      staging: mt7621-dts: fix GB-PC2 devicetree
      staging: mt7621-dts: fix cpuintc and fixedregulator dtc warnings, fix xhci
      mips: dts: ralink: add MT7621 SoC

Ayan Choudhary (1):
      Staging: nvec: Fix ending in '(' error

Cai Huoqing (2):
      staging: most: video: Make use of the helper macro LIST_HEAD()
      staging: most: net: Make use of the helper macro LIST_HEAD()

Charlie Sands (1):
      staging: rts5208: Resolve checkpatch.pl issues.

Christoph Hellwig (1):
      staging: remove ashmem

Colin Ian King (5):
      staging: wfx: Fix spelling mistake "unexpectly" -> "unexpectedly"
      staging: r8188eu: remove redundant variable reg_0x143
      staging: gdm724x: remove redundant assignment of pointer w
      staging: vt6655: remove redundant assignment of pointer tx_key
      staging: rtl8192e: Fix spelling mistake "RESQUEST" -> "REQUEST"

Fabio M. De Francesco (1):
      staging: r8188eu: Use sizeof dereferenced pointer in kzalloc()

Gaston Gonzalez (3):
      staging: vc04_services: remove unneeded MODULE_VERSION() usage
      staging: vc04_services: use KBUILD_MODNAME instead of own module name definition
      staging: vchiq_arm: make vchiq_platform_get_arm_state() static

Greg Kroah-Hartman (3):
      Merge 5.17-rc4 into staging-testing
      Merge 5.17-rc6 into staging-next
      Merge 5.17-rc8 into staging-next

Gustavo A. R. Silva (3):
      staging: unisys: visorinput: Use struct_size() helper in kzalloc()
      staging: r8188eu: Silence out-of-bounds warning in HT_caps_handler()
      staging: gdm724x: Replace one-element array with flexible-array member

Hangyu Hua (1):
      staging: qlge: add unregister_netdev in qlge_probe

Haowen Bai (1):
      staging: rtl8723bs: Use min() instead of doing it manually

Jagath Jog J (3):
      Staging: rtl8723bs: Placing opening { braces in previous line
      Staging: rtl8723bs: Removed extra spaces between datatype and variable
      Staging: rtl8723bs: Inserting blank line after declaration

Jiapeng Chong (1):
      staging: r8188eu: remove useless if else

Julia Lawall (1):
      staging: rtl8723bs: fix typos in comments

Jérôme Pouiller (46):
      staging: wfx: fix Makefile and Kconfig licenses
      staging: wfx: fix HIF API license
      staging: wfx: fix missing headers
      staging: wfx: fix comment correctness
      staging: wfx: explain uncommon Makefile statement
      staging: wfx: remove unnecessary braces
      staging: wfx: remove useless #ifdef
      staging: wfx: use IS_ALIGNED()
      staging: wfx: replace magic value by WFX_HIF_BUFFER_SIZE
      stagigg: wfx: replace magic number by HIF_ID_IS_INDICATION
      staging: wfx: preserve endianness of struct hif_ind_startup
      staging: wfx: fix ambiguous function name
      staging: wfx: fix ambiguous function name
      staging: wfx: prefix functions from hif_*.h with wfx_
      staging: wfx: prefix functions from hwio.h with wfx_
      staging: wfx: prefix functions from debug.h with wfx_
      staging: wfx: prefix tx_policy_is_equal() with wfx_
      staging: wfx: prefix structs hif_* with wfx_
      staging: wfx: prefix structs tx_policy and hwbus_ops with wfx_
      staging: wfx: reformat code on 100 columns
      staging: wfx: reformat comments on 100 columns
      staging: wfx: fix structs alignments
      staging: wfx: use explicit labels for errors
      staging: wfx: replace compiletime_assert() by BUILD_BUG_ON_MSG()
      staging: wfx: do not display functions names in logs
      staging: wfx: remove force_ps_timeout
      staging: wfx: map 'compatible' attribute with board name
      staging: wfx: fix firmware location
      staging: wfx: drop legacy compatible values
      staging: wfx: rename "config-file" DT attribute
      staging: wfx: do not probe the device if not in the DT
      staging: wfx: allow new PDS format
      staging: wfx: remove support for legacy PDS format
      staging: wfx: WF200 has no official SDIO IDs
      staging: wfx: apply the necessary SDIO quirks for the Silabs WF200
      staging: wfx: fix DT bindings location
      staging: wfx: sta.o was linked twice
      staging: wfx: fix struct alignment
      staging: wfx: format comments on 100 columns
      staging: wfx: format code on 100 columns
      staging: wfx: remove useless variable
      staging: wfx: drop useless include
      staging: wfx: remove duplicated code in wfx_cmd_send()
      staging: wfx: prefer to wait for an event instead to sleep
      staging: wfx: ensure HIF request has been sent before polling
      staging: wfx: flags for SPI IRQ were ignored

Kees Cook (3):
      staging: r8188eu: Drop get_recvframe_data()
      staging: rtl8723bs: Drop get_recvframe_data()
      staging: rtl8712: Drop get_recvframe_data()

Leonardo Araujo (2):
      Staging: unisys: visorhba: alignment should match open parenthesis
      Staging: r8188eu: core: 'associcated' may be misspelled - perhaps 'associated'?

Lukas Bulwahn (1):
      MAINTAINERS: remove the obsolete file entry for staging in ANDROID DRIVERS

Marcelo Aloisio da Silva (5):
      staging: r8188eu: remove unnecessary braces in rtw_xmit.c
      staging: r8188eu: remove unconditional if statement
      staging: r8188eu: move out assignment in if condition
      staging: r8188eu: move open brace to the previous line
      staging: r8188eu: remove unnecessary braces in if statements

Martin Kaiser (110):
      staging: r8188eu: ODM_MAC_EDCA_TURBO is always set
      staging: r8188eu: ODM_BB_FA_CNT is always set
      staging: r8188eu: ODM_BB_CCK_PD is always set
      staging: r8188eu: remove unused chip type settings
      staging: r8188eu: remove obsolete defines and comments
      staging: r8188eu: CurrentBW4024GTxPwrIdx is set but not used
      staging: r8188eu: CurrentBW2024GTxPwrIdx is set but not used
      staging: r8188eu: CurrentOfdm24GTxPwrIdx is set but not used
      staging: r8188eu: CurrentCckTxPwrIdx is set but not used
      staging: r8188eu: HW_VAR_MEDIA_STATUS1 is never set
      staging: r8188eu: remove HAL_*_ENABLE defines
      staging: r8188eu: we always enqueue in rtw_set_chplan_cmd
      staging: r8188eu: fix phy_RF6052_Config_ParaFile error handling
      staging: r8188eu: remove a constant variable
      staging: r8188eu: remove unused function parameter
      staging: r8188eu: remove constant function parameter
      staging: r8188eu: replace the READ_AND_CONFIG
      staging: r8188eu: relay errors from ODM_ReadAndConfig_...
      staging: r8188eu: merge ODM_ConfigMACWithHeaderFile into PHY_MACConfig8188E
      staging: r8188eu: remove unused cck, ofdm and mcs rate defines
      staging: r8188eu: merge ODM_ConfigBBWithHeaderFile with its callers
      staging: r8188eu: remove unused externl variables
      staging: r8188eu: remove unused macros
      staging: r8188eu: remove unused bitshift function
      staging: r8188eu: remove unused PATH_LENGTH_MAX define
      staging: r8188eu: remove rtw_list_delete wrapper
      staging: r8188eu: remove _cancel_timer wrapper
      staging: r8188eu: call msecs_to_jiffies in _set_timer
      staging: r8188eu: remove rtw_netif_wake_queue wrapper
      staging: r8188eu: remove rtw_netif_start_queue wrapper
      staging: r8188eu: remove rtw_netif_stop_queue wrapper
      staging: r8188eu: EntryMaxUndecoratedSmoothedPWDB is set but not used
      staging: r8188eu: ODM_RF_TX_PWR_TRACK is always set
      staging: r8188eu: ODM_RF_CALIBRATION is always set
      staging: r8188eu: merge Init_ODM_ComInfo_88E and rtl8188e_init_dm_priv
      staging: r8188eu: remove unnecessary error check
      staging: r8188eu: simplify error handling in phy_BB8188E_Config_ParaFile
      staging: r8188eu: remove constant parameter of phy_LCCalibrate_8188E
      staging: r8188eu: remove dead code for tx power tracking
      staging: r8188eu: remove constant parameter of odm_ConfigRFReg_8188E
      staging: r8188eu: remove constant variable eRFPath
      staging: r8188eu: TXPowercount is set but not used
      staging: r8188eu: TXPowerTrackingCallbackCnt is set but not used
      staging: r8188eu: bTXPowerTrackingInit is set but not used
      staging: r8188eu: bTXPowerTracking is set but not used
      staging: r8188eu: remove constant rf variable
      staging: r8188eu: RfRegChnlVal[1] is set but not used
      staging: r8188eu: use a define for the radio path
      staging: r8188eu: limit rf register writes to path a
      staging: r8188eu: only OFDM_index_old[0] is used
      staging: r8188eu: only OFDM_index[0] is used
      staging: r8188eu: replace local OFDM_index with single variable
      staging: r8188eu: remove debug code to bypass LC calibration
      staging: r8188eu: remove debug code to bypass IQ calibration
      staging: r8188eu: move local definitions into rtw_fw.h
      staging: r8188eu: remove unused enum _IFACE_TYPE
      staging: r8188eu: remove unused enum _ADAPTER_TYPE
      staging: r8188eu: remove the global DriverState
      staging: r8188eu: remove unused struct adapter components
      staging: r8188eu: in_cta_test is always 0
      staging: r8188eu: irq_alloc is not used
      staging: r8188eu: not_indic_disco is unused
      staging: r8188eu: remove unused struct hostapd_priv
      staging: r8188eu: usb_vendor_req_mutex is not used
      staging: r8188eu: dvobj_priv's signal_strength is not used
      staging: r8188eu: RegUsbSS is not used
      staging: r8188eu: usb_suspend_sema is initialised but not used
      staging: r8188eu: remove ishighspeed from dvobj_priv
      staging: r8188eu: set path a explicitly
      staging: r8188eu: write only path a registers in rtw_dbg_port
      staging: r8188eu: remove path parameter from rtl8188e_PHY_SetRFReg
      staging: r8188eu: remove path parameter from phy_RFSerialWrite
      staging: r8188eu: clarify that bb_reg_dump uses only path a
      staging: r8188eu: limit rtw_wx_read_rf to path a
      staging: r8188eu: limit rtw_dbg_port to path a
      staging: r8188eu: remove path parameter from rtl8188e_PHY_QueryRFReg
      staging: r8188eu: remove path parameter from phy_RFSerialRead
      staging: r8188eu: we only need one struct bb_reg_def for path a
      staging: r8188eu: evt_allocated_buf is not used
      staging: r8188eu: evt_done_cnt is set but not used
      staging: r8188eu: struct usb_suspend_parm is not used
      staging: r8188eu: RxMIMOSignalQuality is set but not used
      staging: r8188eu: RxSNR is set but not used
      staging: r8188eu: NumQryPhyStatusCCK is set but not used
      staging: r8188eu: NumQryPhyStatusOFDM is set but not used
      staging: r8188eu: smooth_rssi_data is not used
      staging: r8188eu: irq_prepare_beacon_tasklet is unused
      staging: r8188eu: fix endless loop in recv_func
      staging: r8188eu: cnt is set but not used
      staging: r8188eu: recvframe_push is not used
      staging: r8188eu: get_rx_status is not used
      staging: r8188eu: remove unused define
      staging: r8188eu: use ieee80211 define for management frame type
      staging: r8188eu: use ieee80211 helpers to check the frame type
      staging: r8188eu: refactor validate_recv_frame's error handling
      staging: r8188eu: use ieee80211 helper for qos bit
      staging: r8188eu: use ieee80211 helper to check for more fragments
      staging: r8188eu: use ieee80211 helper to read "more data"
      staging: r8188eu: use ieee80211 helper to read the protected bit
      staging: r8188eu: use ieee80211 helper to read the "order" bit
      staging: r8188eu: remove tmp variable in update_recvframe_attrib_88e
      staging: r8188eu: summarize declaration and assignment
      staging: r8188eu: don't initialize drvinfo_sz to 0
      staging: r8188eu: remove unnecessary casts
      staging: r8188eu: remove comments in update_recvframe_attrib_88e
      staging: r8188eu: remove unnecessary initializations
      staging: r8188eu: remove three unused receive defines
      staging: r8188eu: remove unused function prototype
      staging: r8188eu: make rtl8188e_process_phy_info static
      staging: r8188eu: remove some unused local ieee80211 macros

Michael Straube (87):
      staging: r8188eu: remove Firmware* from struct hal_data_8188e
      staging: r8188eu: remove rtl8188e_InitializeFirmwareVars()
      staging: r8188eu: release_firmware is not called if allocation fails
      staging: r8188eu: rename Exit label in load_firmware()
      staging: r8188eu: rename rtStatus in load_firmware()
      staging: r8188eu: convert type of return variable in load_firmware()
      staging: r8188eu: rename parameter pFirmware of load_firmware()
      staging: r8188eu: rename fields of struct rt_firmware
      staging: r8188eu: use kmemdup instead of kzalloc and memcpy
      staging: r8188eu: rename fw related functions to avoid camel case
      staging: r8188eu: clean up rtw_reset_8051()
      staging: r8188eu: convert two functions from s32 to int
      staging: r8188eu: rename Exit label in rtl8188e_firmware_download()
      staging: r8188eu: rename rtSatus in rtl8188e_firmware_download()
      staging: r8188eu: rename FWDL_ChkSum_rpt
      staging: r8188eu: rename writeFW_retry
      staging: r8188eu: rename pFwHdr in rtl8188e_firmware_download()
      staging: r8188eu: rename pFirmwareBuf and FirmwareLen
      staging: r8188eu: move firmware loading code out of the hal layer
      staging: r8188eu: rename _pFwHdr in IS_FW_HEADER_EXIST
      staging: r8188eu: add spaces around & operator in IS_FW_HEADER_EXIST
      staging: r8188eu: move firmware related macros to rtw_fw.h
      staging: r8188eu: remove HW_VAR_BASIC_RATE from GetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_TXPAUSE
      staging: r8188eu: remove HW_VAR_CURRENT_ANTENNA from GetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_EFUSE_BYTES from GetHwReg8188EU()
      staging: r8188eu: EfuseUsedBytes is set but never used
      staging: r8188eu: remove HW_VAR_APFM_ON_MAC
      staging: r8188eu: rtw_hostapd_mlme_rx() is empty
      staging: r8188eu: convert switch to if statement in mgt_dispatcher()
      staging: r8188eu: rtw_os_recv_resource_free() is empty
      staging: r8188eu: rtw_os_recv_resource_init() does nothing
      staging: r8188eu: remove rtw_os_recv_resource_alloc()
      staging: r8188eu: rx_packet_offset and max_recvbuf_sz are write-only
      staging: r8188eu: remove unused cases from GetHalDefVar8188EUsb()
      staging: r8188eu: max_rx_ampdu_factor is always MAX_AMPDU_FACTOR_64K
      staging: r8188eu: convert GetHalDefVar8188EUsb() to void
      staging: r8188eu: convert SetHalDefVar8188EUsb() to void
      staging: r8188eu: remove IS_*_CUT macros
      staging: r8188eu: remove c2h_evt_clear()
      staging: r8188eu: remove unused parameter from hw_var_set_*
      staging: r8188eu: remove hal_init_macaddr()
      staging: r8188eu: remove HW_VAR_BEACON_INTERVAL
      staging: r8188eu: remove HW_VAR_SEC_CFG
      staging: r8188eu: remove HW_VAR_CAM_INVALID_ALL
      staging: r8188eu: remove HW_VAR_AC_PARAM_VO
      staging: r8188eu: remove HW_VAR_AC_PARAM_VI
      staging: r8188eu: remove HW_VAR_AC_PARAM_BK
      staging: r8188eu: remove HW_VAR_MEDIA_STATUS
      staging: r8188eu: merge Set_NETYPE0_MSR() and Set_MSR()
      staging: r8188eu: remove HW_VAR_CAM_WRITE
      staging: r8188eu: remove HW_VAR_BCN_FUNC
      staging: r8188eu: remove HW_VAR_CHECK_BSSID
      staging: r8188eu: remove HW_VAR_CAM_EMPTY_ENTRY
      staging: r8188eu: ExternalPA is read-only
      staging: r8188eu: remove PGMaxGroup from struct hal_data_8188e
      staging: r8188eu: remove ReceiveConfig from struct hal_data_8188e
      staging: r8188eu: BasicRateSet is set but never used
      staging: r8188eu: remove UsbTxAggDescNum from struct hal_data_8188e
      staging: r8188eu: remove UsbTxAggMode from struct hal_data_8188e
      staging: r8188eu: remove UsbRxAggMode from struct hal_data_8188e
      staging: r8188eu: remove UsbRxAggBlock* from struct hal_data_8188e
      staging: r8188eu: remove UsbRxAggPage* from struct hal_data_8188e
      staging: r8188eu: move struct rt_firmware_hdr to rtw_fw.h
      staging: r8188eu: remove UsbBulkOutSize from struct hal_data_8188e
      staging: r8188eu: remove unused enum
      staging: r8188eu: clean up enum hw_variables
      staging: r8188eu: remove unused structs from ieee80211.h
      staging: r8188eu: remove unused enums from ieee80211.h
      staging: r8188eu: remove unused enum
      staging: r8188eu: bCCKinCH14 is read-only
      staging: r8188eu: rename CCKSwingTable_Ch1_Ch13
      staging: r8188eu: remove ODM_CmnInfoHook()
      staging: r8188eu: convert two u8 variables to bool
      staging: r8188eu: remove enum odm_bw
      staging: r8188eu: convert type of pBandWidth in odm_dm_struct
      staging: r8188eu: remove ODM_CmnInfoUpdate()
      staging: r8188eu: remove unused macros from rtw_security.h
      staging: r8188eu: remove unused aes tables from rtw_security.c
      staging: r8188eu: remove 5 GHz channels from ch_freq_map
      staging: r8188eu: refactor rtw_ch2freq()
      staging: r8188eu: clean up rtw_rf.c
      staging: r8188eu: EepromAddressSize is set but not used
      staging: r8188eu: remove unused function prototype
      staging: r8188eu: remove update_bcn_p2p_ie()
      staging: r8188eu: remove ETH_ALEN from ieee80211.h
      staging: r8188eu: remove _linked_rx_signal_strength_display()

Minghao Chi (1):
      staging: rtl8723bs: remove redundant result variable

Minghao Chi (CGEL ZTE) (2):
      staging/ks7010: Remove redundant 'flush_workqueue()' calls
      staging: greybus: Remove redundant 'flush_workqueue()' calls

Moses Christopher Bollavarapu (1):
      staging: rtl8192e: use BIT macro instead of left shifting

Muhammad Usama Anjum (1):
      staging: rt8188eu: Remove dead code

Nam Cao (1):
      staging: sm750fb: fix naming style

Paulo Miguel Almeida (17):
      staging: pi433: move get version func to where all other functions are
      staging: pi433: fix validation for min bit rate supported by the device
      staging: pi433: change order in which driver config the rf69 chip
      staging: pi433: validate max bit_rate based on modulation used
      staging: pi433: enforce tx_cfg to be set before any message can be sent
      staging: pi433: add missing register contants
      staging: pi433: remove coding style item from the TODO file
      staging: pi433: add debugfs interface
      staging: pi433: remove register debug dev_dbg stmts using DEBUG_VALUES
      staging: pi433: standardize use of line escape chars in dev_dbg stmts
      staging: pi433: remove need to recompile code to debug fifo content
      staging: pi433: add index value to write dev_dbg statement
      staging: pi433: remove TODOs-related item from the TODO file
      staging: pi433: remove rf69_get_flag function resolving enum conflict
      staging: pi433: prevent uninitialized data from being printed out
      staging: pi433: remove hardcoded mask value for easier readability
      staging: pi433: formatting improvement for multi-line bitwise statement

Philipp Hortmann (18):
      staging: vt6656: Fix crash when WLAN is turned off
      staging: vt6656: Fix CamelCase warnings in mac.h and mac.c
      staging: vt6656: Add comment for locks
      staging: vt6656: Fix CamelCase warnings in macro
      staging: vt6656: Change macro to function and moved to better file
      staging: vt6656: Remove ftrace-like logging
      staging: vt6656: Remove unnecessary line breaks
      staging: vt6655: Remove unused byRFType in channel.c
      staging: vt6655: Remove unused byRFType in baseband.c
      staging: vt6655: Remove unused byRFType in rf.c
      staging: vt6655: Remove unused byRFType in card.c
      staging: vt6656: Remove unused rf_type in channel.c
      staging: vt6656: Remove unused rf_type in baseband.c
      staging: vt6656: Remove unused rf_type in rf.c; top level
      staging: vt6656: Remove unused rf_type in rf.c; unused variables
      staging: vt6656: Remove unused rf_type in card.c
      staging: vt6656: Removed unused variable bb_vga_0
      staging: vt6656: Removed unused variable vt3342_vnt_threshold

Phillip Potter (28):
      staging: r8188eu: convert/remove DBG_88E calls in core/rtw_ap.c
      staging: r8188eu: convert DBG_88E calls in os_dep/xmit_linux.c
      staging: r8188eu: remove DBG_88E call from os_dep/osdep_service.c
      staging: r8188eu: convert DBG_88E call in core/rtw_cmd.c
      staging: r8188eu: convert/remove DBG_88E calls in os_dep/usb_ops_linux.c
      staging: r8188eu: convert DBG_88E calls in core/rtw_ieee80211.c
      staging: r8188eu: convert DBG_88E calls in core/rtw_xmit.c
      staging: r8188eu: convert DBG_88E calls in core/rtw_iol.c
      staging: r8188eu: convert DBG_88E calls in core/rtw_mlme.c
      staging: r8188eu: convert DBG_88E calls in core/rtw_ioctl_set.c
      staging: r8188eu: convert DBG_88E calls in core/rtw_mlme_ext.c
      staging: r8188eu: convert DBG_88E calls in core/rtw_sta_mgt.c
      staging: r8188eu: remove previously converted DBG_88E_LEVEL calls
      staging: r8188eu: remove smaller sets of converted DBG_88E calls
      staging: r8188eu: remove converted DBG_88E calls from core/rtw_mlme_ext.c
      staging: r8188eu: remove DBG_88E calls from core subdir
      staging: r8188eu: remove DBG_88E calls from hal subdir
      staging: r8188eu: remove DBG_88E calls from os_dep/ioctl_linux.c
      staging: r8188eu: remove remaining DBG_88E calls from os_dep subdir
      staging: r8188eu: remove remaining DBG_88E call from include/usb_ops.h
      staging: r8188eu: remove all aliased DBG_88E calls
      staging: r8188eu: remove DBG_88E macro definition
      staging: r8188eu: remove rtw_debug module parameter
      staging: r8188eu: fix lines modified by DBG_88E cleanup
      staging: r8188eu: remove rtw_sctx_chk_waring_status function
      staging: r8188eu: remove padapter param from aes_decipher function
      staging: r8188eu: correct long line warnings near prior DBG_88E calls
      staging: r8188eu: remove unused variable from UpdateHalRAMask8188EUsb

Riccardo Ferrazzo (1):
      staging: wfx: fix scan with WFM200 and WW regulation

Samuel Sjöberg (1):
      staging: rts5208: fix Lines should not end with a '('.

Sergio Paracuellos (4):
      dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
      staging: mt7621-dts: align resets with binding documentation
      dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
      clk: ralink: make system controller node a reset provider

Song Chen (1):
      staging: greybus: introduce pwm_ops::apply

Stefan Wahren (18):
      staging: vchiq_core: fix indentation in vchiq_log_dump_mem
      staging: vchiq_debugfs: get the rid of n_log_entries
      staging: vchiq_arm: introduce is_adjacent_block
      staging: vchiq: convert TODOs into unordered list
      staging: vchiq: drop completed tasks from TODO
      staging: vchiq: add message handling to TODO list
      staging: vchiq_core: fix type of parameter localport
      staging: vchiq_core: simplify vchiq_add_service_internal
      staging: vchiq_core: align return statements in msg_type_str
      staging: vchiq_core: drop prefix of vchiq_set_service_state
      staging: vchiq_core: reduce multi-line statements
      staging: vchiq_core: fix alignment
      staging: vchiq_core: avoid ternary operator for set_service_state
      staging: vchiq_core: use min_t macro
      staging: vchiq_arm: make vchiq_get_state return early
      staging: vchiq_arm: Avoid NULL ptr deref in vchiq_dump_platform_instances
      staging: vchiq_core: handle NULL result of find_service_by_handle
      staging: vchiq_dev: Avoid unnecessary alloc in vchiq_ioc_create_service

Tong Zhang (4):
      staging: drop fpgaboot driver
      staging: rtl8192u: fix broken debug macro
      staging: rtl8192u: add empty debug functions
      staging: rtl8192u: rework init and exit function

Uwe Kleine-König (1):
      staging: fbtft: Deduplicate driver registration macros

Vihas Mak (1):
      staging: r8188eu: handle rtw_init_netdev_name() failure appropriately

Vihas Makwana (20):
      staging: r8188eu: keep the success path and error path separate
      staging: r8188eu: mark _rtw_free_sta_priv as void
      staging: r8188eu: mark rtw_is_cckrates_included as bool
      staging: r8188eu: mark rtw_is_cckratesonly_included as bool
      staging: r8188eu: mark rtw_is_desired_network as bool
      staging: r8188eu: mark PS_RDY_CHECK as bool
      staging: r8188eu: mark check_indicate_seq as bool
      staging: r8188eu: mark enqueue_reorder_recvframe as bool
      staging: r8188eu: mark recv_indicatepkts_in_order as bool
      staging: r8188eu: mark cckrates_included as bool
      staging: r8188eu: mark cckratesonly_included as bool
      staging: r8188eu: mark is_basicrate as bool
      staging: r8188eu: mark is_ap_in_tkip as bool
      staging: r8188eu: mark rtl8188eu_xmitframe_complete as bool
      staging: r8188eu: mark check_fwstate as bool
      staging: r8188eu: mark IS_MCAST as bool
      staging: r8188eu: mark IsFrameTypeCtrl as bool
      staging: r8188eu: mark rtw_endofpktfile as bool
      staging: r8188eu: call _cancel_timer_ex from _rtw_free_recv_priv
      staging: r8188eu: proper error handling in rtw_init_drv_sw

Wan Jiabing (1):
      staging: r8188eu: remove unnecessary memset in r8188eu

Xiaoke Wang (3):
      staging: wfx: fix an error handling in wfx_init_common()
      staging: wfx: check the return value of devm_kmalloc()
      staging: mmal-vchiq: clear redundant item named bulk_scratch

 .../bindings/clock/mediatek,mt7621-sysc.yaml       |  12 +
 .../bindings/staging}/net/wireless/silabs,wfx.yaml |  82 +-
 MAINTAINERS                                        |   9 +-
 arch/mips/boot/dts/ralink/Makefile                 |   4 +
 .../mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts  |  44 +-
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts | 122 +++
 .../mips/boot/dts/ralink}/mt7621.dtsi              |  59 +-
 arch/mips/ralink/Kconfig                           |   5 +
 drivers/clk/ralink/clk-mt7621.c                    |  92 +-
 drivers/mmc/core/quirks.h                          |   5 +
 drivers/staging/Kconfig                            |   6 -
 drivers/staging/Makefile                           |   3 -
 drivers/staging/android/Kconfig                    |  19 -
 drivers/staging/android/Makefile                   |   4 -
 drivers/staging/android/TODO                       |   8 -
 drivers/staging/android/ashmem.c                   | 970 ---------------------
 drivers/staging/android/ashmem.h                   |  24 -
 drivers/staging/android/uapi/ashmem.h              |  43 -
 drivers/staging/fbtft/fbtft-core.c                 |   9 +-
 drivers/staging/fbtft/fbtft.h                      |  95 +-
 drivers/staging/gdm724x/gdm_lte.c                  |   1 -
 drivers/staging/gdm724x/hci_packet.h               |   2 +-
 drivers/staging/greybus/pwm.c                      |  64 +-
 drivers/staging/greybus/sdio.c                     |   1 -
 drivers/staging/gs_fpgaboot/Kconfig                |   8 -
 drivers/staging/gs_fpgaboot/Makefile               |   3 -
 drivers/staging/gs_fpgaboot/README                 |  70 --
 drivers/staging/gs_fpgaboot/TODO                   |   7 -
 drivers/staging/gs_fpgaboot/gs_fpgaboot.c          | 394 ---------
 drivers/staging/gs_fpgaboot/gs_fpgaboot.h          |  41 -
 drivers/staging/gs_fpgaboot/io.c                   | 105 ---
 drivers/staging/gs_fpgaboot/io.h                   |  73 --
 drivers/staging/ks7010/ks7010_sdio.c               |   4 +-
 drivers/staging/most/net/net.c                     |   2 +-
 drivers/staging/most/video/video.c                 |   2 +-
 drivers/staging/mt7621-dts/Kconfig                 |  11 -
 drivers/staging/mt7621-dts/Makefile                |   5 -
 drivers/staging/mt7621-dts/TODO                    |   5 -
 drivers/staging/mt7621-dts/gbpc2.dts               |  22 -
 drivers/staging/nvec/nvec.c                        |   4 +-
 drivers/staging/pi433/TODO                         |   4 +-
 drivers/staging/pi433/pi433_if.c                   | 176 +++-
 drivers/staging/pi433/pi433_if.h                   |   2 -
 drivers/staging/pi433/rf69.c                       | 169 +---
 drivers/staging/pi433/rf69.h                       |   3 +-
 drivers/staging/pi433/rf69_enum.h                  |  20 -
 drivers/staging/pi433/rf69_registers.h             |   2 +
 drivers/staging/qlge/qlge_main.c                   |  11 +-
 drivers/staging/r8188eu/Makefile                   |   2 +-
 drivers/staging/r8188eu/core/rtw_ap.c              | 240 ++---
 drivers/staging/r8188eu/core/rtw_br_ext.c          |  82 +-
 drivers/staging/r8188eu/core/rtw_cmd.c             |  49 +-
 drivers/staging/r8188eu/core/rtw_fw.c              | 314 +++++++
 drivers/staging/r8188eu/core/rtw_ieee80211.c       |  41 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c       |  10 -
 drivers/staging/r8188eu/core/rtw_iol.c             |  14 +-
 drivers/staging/r8188eu/core/rtw_mlme.c            | 106 +--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c        | 439 +---------
 drivers/staging/r8188eu/core/rtw_p2p.c             |  73 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c         |  47 +-
 drivers/staging/r8188eu/core/rtw_recv.c            | 146 +---
 drivers/staging/r8188eu/core/rtw_rf.c              |  62 +-
 drivers/staging/r8188eu/core/rtw_security.c        | 193 +---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c         |  14 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c       | 129 +--
 drivers/staging/r8188eu/core/rtw_xmit.c            |  99 +--
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c       | 185 +---
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c         |   4 +-
 drivers/staging/r8188eu/hal/hal_com.c              |  36 +-
 drivers/staging/r8188eu/hal/hal_intf.c             |   3 -
 drivers/staging/r8188eu/hal/odm.c                  | 118 +--
 drivers/staging/r8188eu/hal/odm_HWConfig.c         |  44 +-
 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c   |   7 +-
 drivers/staging/r8188eu/hal/odm_debug.c            |   6 -
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c         |  46 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c          |  52 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c    | 403 +--------
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c      | 150 +---
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c      |  24 +-
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c      |  82 +-
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c       |  26 -
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c       |  22 +-
 drivers/staging/r8188eu/hal/usb_halinit.c          | 432 ++-------
 drivers/staging/r8188eu/hal/usb_ops_linux.c        |  60 +-
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h   |   6 +-
 drivers/staging/r8188eu/include/HalVerDef.h        |  23 -
 drivers/staging/r8188eu/include/drv_types.h        |  46 +-
 drivers/staging/r8188eu/include/hal_com.h          |   3 -
 drivers/staging/r8188eu/include/hal_intf.h         |  48 +-
 drivers/staging/r8188eu/include/ieee80211.h        | 271 +-----
 drivers/staging/r8188eu/include/odm.h              |  50 +-
 drivers/staging/r8188eu/include/odm_HWConfig.h     |  39 +-
 drivers/staging/r8188eu/include/osdep_service.h    |  50 +-
 drivers/staging/r8188eu/include/recv_osdep.h       |   5 -
 drivers/staging/r8188eu/include/rtl8188e_dm.h      |   3 +-
 drivers/staging/r8188eu/include/rtl8188e_hal.h     |  97 +--
 drivers/staging/r8188eu/include/rtl8188e_recv.h    |   8 -
 drivers/staging/r8188eu/include/rtl8188e_spec.h    |   2 +-
 drivers/staging/r8188eu/include/rtl8188e_xmit.h    |   4 +-
 drivers/staging/r8188eu/include/rtw_br_ext.h       |   5 -
 drivers/staging/r8188eu/include/rtw_cmd.h          |  16 +-
 drivers/staging/r8188eu/include/rtw_debug.h        |   8 -
 drivers/staging/r8188eu/include/rtw_fw.h           |  12 +
 drivers/staging/r8188eu/include/rtw_mlme.h         |  11 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h     |   6 +-
 drivers/staging/r8188eu/include/rtw_pwrctrl.h      |   2 +-
 drivers/staging/r8188eu/include/rtw_recv.h         |  61 +-
 drivers/staging/r8188eu/include/rtw_security.h     | 112 ---
 drivers/staging/r8188eu/include/sta_info.h         |  48 +-
 drivers/staging/r8188eu/include/usb_ops.h          |   8 +-
 drivers/staging/r8188eu/include/wifi.h             |  70 +-
 drivers/staging/r8188eu/include/wlan_bssdef.h      |   2 +-
 drivers/staging/r8188eu/include/xmit_osdep.h       |   2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c       | 558 ++----------
 drivers/staging/r8188eu/os_dep/mlme_linux.c        |   4 -
 drivers/staging/r8188eu/os_dep/os_intfs.c          |  91 +-
 drivers/staging/r8188eu/os_dep/osdep_service.c     |   2 -
 drivers/staging/r8188eu/os_dep/recv_linux.c        |  35 -
 drivers/staging/r8188eu/os_dep/usb_intf.c          | 125 +--
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c     |  24 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c        |   8 +-
 drivers/staging/rtl8192e/rtllib_debug.h            |  54 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |   2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211.h     |   9 +-
 .../staging/rtl8192u/ieee80211/ieee80211_crypt.c   |   2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      |   2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c      |   2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c       |   2 +-
 .../staging/rtl8192u/ieee80211/ieee80211_module.c  |   2 +-
 drivers/staging/rtl8192u/r8192U_core.c             |  45 +-
 drivers/staging/rtl8712/rtl871x_recv.c             |   4 +-
 drivers/staging/rtl8712/rtl871x_recv.h             |   8 -
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |  54 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |   2 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c          |  11 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c          |   5 +-
 drivers/staging/rtl8723bs/hal/hal_intf.c           |   5 +
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c     |   3 +-
 drivers/staging/rtl8723bs/include/rtw_recv.h       |  11 -
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  98 +--
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |   6 +-
 drivers/staging/rts5208/ms.c                       |   9 +-
 drivers/staging/rts5208/rtsx.c                     |   8 -
 drivers/staging/sm750fb/ddk750_dvi.c               |  68 +-
 drivers/staging/sm750fb/ddk750_dvi.h               |  64 +-
 drivers/staging/unisys/visorhba/visorhba_main.c    |   2 +-
 drivers/staging/unisys/visorinput/visorinput.c     |   3 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |  10 +-
 drivers/staging/vc04_services/interface/TODO       |  56 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  37 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c | 137 ++-
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |   2 +-
 .../interface/vchiq_arm/vchiq_debugfs.c            |   4 +-
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |   7 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |   7 -
 drivers/staging/vt6655/baseband.c                  |  80 --
 drivers/staging/vt6655/card.c                      |  56 +-
 drivers/staging/vt6655/channel.c                   |  85 +-
 drivers/staging/vt6655/rf.c                        | 404 +--------
 drivers/staging/vt6655/rxtx.c                      |   2 -
 drivers/staging/vt6656/baseband.c                  |  40 +-
 drivers/staging/vt6656/card.c                      |  18 -
 drivers/staging/vt6656/channel.c                   |  96 +-
 drivers/staging/vt6656/device.h                    |  11 +-
 drivers/staging/vt6656/mac.c                       |  14 +-
 drivers/staging/vt6656/mac.h                       |  22 +-
 drivers/staging/vt6656/rf.c                        | 413 +--------
 drivers/staging/vt6656/rxtx.c                      |   8 +-
 drivers/staging/vt6656/usbpipe.c                   |   4 +-
 drivers/staging/vt6656/wcmd.c                      |  13 +-
 drivers/staging/wfx/Kconfig                        |   5 +
 drivers/staging/wfx/Makefile                       |   4 +-
 drivers/staging/wfx/bh.c                           |  68 +-
 drivers/staging/wfx/bh.h                           |   1 +
 drivers/staging/wfx/bus.h                          |   8 +-
 drivers/staging/wfx/bus_sdio.c                     | 105 +--
 drivers/staging/wfx/bus_spi.c                      | 126 +--
 drivers/staging/wfx/data_rx.c                      |  10 +-
 drivers/staging/wfx/data_rx.h                      |   5 +-
 drivers/staging/wfx/data_tx.c                      | 152 ++--
 drivers/staging/wfx/data_tx.h                      |  20 +-
 drivers/staging/wfx/debug.c                        |  80 +-
 drivers/staging/wfx/debug.h                        |   6 +-
 drivers/staging/wfx/fwio.c                         | 116 ++-
 drivers/staging/wfx/hif_api_cmd.h                  | 152 ++--
 drivers/staging/wfx/hif_api_general.h              |  64 +-
 drivers/staging/wfx/hif_api_mib.h                  |  68 +-
 drivers/staging/wfx/hif_rx.c                       | 171 ++--
 drivers/staging/wfx/hif_tx.c                       | 201 ++---
 drivers/staging/wfx/hif_tx.h                       |  67 +-
 drivers/staging/wfx/hif_tx_mib.c                   | 201 ++---
 drivers/staging/wfx/hif_tx_mib.h                   |  67 +-
 drivers/staging/wfx/hwio.c                         | 168 ++--
 drivers/staging/wfx/hwio.h                         |  35 +-
 drivers/staging/wfx/key.c                          |  84 +-
 drivers/staging/wfx/key.h                          |   5 +-
 drivers/staging/wfx/main.c                         | 267 +++---
 drivers/staging/wfx/main.h                         |  12 +-
 drivers/staging/wfx/queue.c                        |  60 +-
 drivers/staging/wfx/queue.h                        |  13 +-
 drivers/staging/wfx/scan.c                         |  27 +-
 drivers/staging/wfx/sta.c                          | 201 ++---
 drivers/staging/wfx/sta.h                          |  21 +-
 drivers/staging/wfx/traces.h                       |  33 +-
 drivers/staging/wfx/wfx.h                          | 102 ++-
 include/dt-bindings/reset/mt7621-reset.h           |  37 +
 206 files changed, 3371 insertions(+), 9849 deletions(-)
 rename {drivers/staging/wfx/Documentation/devicetree/bindings => Documentation/devicetree/bindings/staging}/net/wireless/silabs,wfx.yaml (59%)
 rename drivers/staging/mt7621-dts/gbpc1.dts => arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts (74%)
 create mode 100644 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
 rename {drivers/staging/mt7621-dts => arch/mips/boot/dts/ralink}/mt7621.dtsi (93%)
 delete mode 100644 drivers/staging/android/Kconfig
 delete mode 100644 drivers/staging/android/Makefile
 delete mode 100644 drivers/staging/android/TODO
 delete mode 100644 drivers/staging/android/ashmem.c
 delete mode 100644 drivers/staging/android/ashmem.h
 delete mode 100644 drivers/staging/android/uapi/ashmem.h
 delete mode 100644 drivers/staging/gs_fpgaboot/Kconfig
 delete mode 100644 drivers/staging/gs_fpgaboot/Makefile
 delete mode 100644 drivers/staging/gs_fpgaboot/README
 delete mode 100644 drivers/staging/gs_fpgaboot/TODO
 delete mode 100644 drivers/staging/gs_fpgaboot/gs_fpgaboot.c
 delete mode 100644 drivers/staging/gs_fpgaboot/gs_fpgaboot.h
 delete mode 100644 drivers/staging/gs_fpgaboot/io.c
 delete mode 100644 drivers/staging/gs_fpgaboot/io.h
 delete mode 100644 drivers/staging/mt7621-dts/Kconfig
 delete mode 100644 drivers/staging/mt7621-dts/Makefile
 delete mode 100644 drivers/staging/mt7621-dts/TODO
 delete mode 100644 drivers/staging/mt7621-dts/gbpc2.dts
 create mode 100644 drivers/staging/r8188eu/core/rtw_fw.c
 delete mode 100644 drivers/staging/r8188eu/hal/odm_debug.c
 create mode 100644 drivers/staging/r8188eu/include/rtw_fw.h
 create mode 100644 include/dt-bindings/reset/mt7621-reset.h
