Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B770C53C893
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243517AbiFCKWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiFCKW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:22:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB4164C6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:22:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 083DCB8229E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F85EC385A9;
        Fri,  3 Jun 2022 10:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654251742;
        bh=Sd4dd5FMmY6l5Rg2xb6Zh6CsTRLXRTpAiijNyhWrFX8=;
        h=Date:From:To:Cc:Subject:From;
        b=K4osx+w+f2W9zoN+7lqT4mzr1UMYn2kTlr8xP3f2mwp0Kl0T8bChcKLoT753MDJ7I
         Rjv7F1tE6gUEE6aVIKbhJUKF0+clymusydG6ffnrKutHoAnnZwRln4hoPkKxtYqr3N
         Oag0ewZgJxZP1/T2tk4fyf4BD4NFZU2XqG0KEJrM=
Date:   Fri, 3 Jun 2022 12:22:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver updates for 5.19-rc1
Message-ID: <Ypng29bf0vGJ20fo@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.19-rc1

for you to fetch changes up to 6a31a95135da0bb2c5349e49e37d76e9909ab7ea:

  staging: r8188eu: remove include/rtw_debug.h (2022-05-20 01:16:35 +0200)

----------------------------------------------------------------
Staging driver updates for 5.19-rc1

Here is the big set of staging driver updates for 5.19-rc1.

Lots of forward progress happened this development cycle, one driver
(wfx wireless driver) got merged into the real portion of the kernel,
and another one (unisys) was removed as no one is around anymore to take
care of it and no one has the hardware.  Combined with loads of tiny
driver cleanups overall we removed 13k lines of code from the tree, a
nice improvement.

Other than the wfx and unisys driver changes the major points of this
merge is:
	- r8188eu driver cleanups.  So many cleanups.  It's amazing just
	  how many things have been cleaned up here, and yet, how many
	  remain to go.  Lots of work happened here, and it doesn't look
	  to slow down any time soon.
	- other wifi driver cleanups.  Not as many as the r8188eu
	  driver, but still pretty impressive from a janitorial point of
	  view.
	- bcm2853 driver cleanups
	- other very minor driver cleanups

All of these have been in the linux-next tree for weeks with no reported
issues.

Note, you will have a merge conflict in the
drivers/net/wireless/silabs/wfx/sta.c file, please just take the change
that came in from the wifi tree.  We thought as I had pulled the same
merge point from the wifi developers this type of conflict wouldn't have
happened, but for some reason git flags it as something to pay attention
to and couldn't resolve it itself.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adrien Thierry (7):
      staging: bcm2835-audio: remove compat ALSA card
      staging: bcm2835-audio: fully describe config symbol
      staging: bcm2835-audio: fix line ending with '('
      staging: bcm2835-audio: fix unnecessary space after cast
      staging: bcm2835-audio: fix mutex definition without comment
      staging: bcm2835-audio: fix mutex definition without comment
      staging: bcm2835-audio: delete TODO

Alaa Mohamed (10):
      staging: rtl8723bs: remove code suspect indent
      staging: rtl8723bs: Fix No space before tabs
      staging: wlan-ng: Fix Lines shouldn't end with '('
      staging: wlan-ng: Fix Alignment with parenthesis
      staging: r8188eu: Add line after declarations
      staging: r8188eu: remove unnecessary blank lines
      staging: rtl8712: Fix multiple line dereference
      staging: rtl8712: remove Unnecessary parentheses
      staging: rtl8712: remove unnecessary parentheses
      staging: rtl8192e: remove multiple blank lines

Aliya Rahmani (4):
      staging: rtl8712: efuse: code style - avoid macro argument precedence issues
      staging: rtl8712: cmd: remove redundant space after cast
      staging: rtl8712: Remove unnecessary parentheses
      staging: ks7010: coding style fix: use tabs for indent

Andy Shevchenko (1):
      staging: vc04_services: Re-use generic struct s32_fract

Artur Bujdoso (1):
      staging: rtl8723bs: remove leftover code for other chips

Bruno Moreira-Guedes (4):
      staging: vme_user: Fixed typo in the MODULE_AUTHOR
      staging: vme: Move vme_user to staging KConfig
      staging: vme: Add VME_BUS dependency to Kconfig
      staging: vme: Move 'vme/devices/' to 'vme_user/'

Charlie Sands (2):
      staging: r8188eu: Fix sparse endianness warnings.
      staging: r8188eu: Remove broken rtw_p2p_get function.

Chris Morgan (1):
      staging: rtl8723bs: Change rtw_ndev_notifier_call message to dbg

Christophe JAILLET (1):
      staging: fieldbus: Fix the error handling path in anybuss_host_common_probe()

Colin Ian King (3):
      staging: rtl8192u: make read-only array EWC11NHTCap static const
      staging: iio: ad2s1210: remove redundant assignment to variable negative
      staging: rtl8192u: make const array queuetopipe const, reduces object code size

Dan Carpenter (1):
      staging: r8188eu: delete rtw_wx_read/write32()

Davidlohr Bueso (6):
      staging/most, dim2: convert dim2_tasklet to threaded irq
      staging/wlan-ng, prism2usb: replace reaper_bh tasklet with work
      staging/wlan-ng, prism2usb: replace completion_bh tasklet with work
      staging/ks7010: replace SME taslet with work
      staging/rtl8712: remove event_tasklet
      staging/rtl8192e,ieee80211: replace ps tasklet with work

Denis Efremov (1):
      staging: r8188eu: prevent ->Ssid overflow in rtw_wx_set_scan()

Duoming Zhou (5):
      drivers: staging: rtl8723bs: Fix deadlock in rtw_surveydone_event_callback()
      drivers: staging: rtl8192bs: Fix deadlock in rtw_joinbss_event_prehandle()
      drivers: staging: rtl8192eu: Fix deadlock in rtw_joinbss_event_prehandle
      drivers: staging: rtl8192u: Fix deadlock in ieee80211_beacons_stop()
      drivers: staging: rtl8192e: Fix deadlock in rtllib_beacons_stop()

Fabio M. De Francesco (7):
      staging: rts5208: Convert kmap() to kmap_local_page()
      staging: unisys: Remove "struct dentry *eth_debugfs_dir"
      staging: vc04_services: Convert kmap() to kmap_local_page()
      staging: r8188eu: Remove redundant code from rtw_free_netdev()
      staging: r8188eu: Use the ARRAY_SIZE() macro
      staging: sm750fb: Call iounmap() to free mapped bus memory
      staging: Remove the drivers for the Unisys s-Par

Gaston Gonzalez (1):
      staging: vc04_services: remove unused macro

Geert Uytterhoeven (1):
      staging: vc04_services: Re-add dependency on HAS_DMA to BCM2835_VCHIQ

Greg Kroah-Hartman (2):
      Merge branch 'wfx-move-out-of-staging' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next into staging-next
      Merge 5.18-rc2 into staging-next

Haowen Bai (9):
      staging: r8188eu: Directly return _SUCCESS instead of using local ret variable
      staging: r8188eu: Fix misspelling in comment "Tranceiver" -> "Transceiver"
      staging: r8188eu: Fix misspelling in comment "writting" -> "writing"
      staging: r8188eu: Drop redundant memset
      staging: rtl8192e: Fix signedness bug in rtllib_rx_assoc_resp()
      staging: rtl8192u: Fix signedness bug in ieee80211_check_auth_response()
      staging: ks7010: remove null check after call container_of()
      staging: rtl8192e: remove null check after call container_of()
      staging: rtl8192u: remove null check after call container_of()

Ivan Safonov (1):
      r8188eu: remove unused urbs from struct xmit_buf

Jaehee Park (10):
      staging: wfx: remove space at the start of the line
      staging: wfx: change variable name to be consistent
      staging: greybus: correct typo in comment
      staging: greybus: remove empty callback function
      staging: r8188eu: remove unnecessary braces in single statement block
      staging: r8188eu: remove spaces before tabs
      staging: r8188eu: remove 'added by' author comments
      staging: r8188eu: replace spaces with tabs
      staging: r8188eu: correct typo in comments
      staging: r8188eu: remove unused else condition

Jakob Koschel (3):
      staging: greybus: codecs: use dedicated list iterator variable
      staging: greybus: codecs: fix type confusion of list iterator variable
      staging: vchiq: replace usage of found with dedicated list iterator variable

Jiasheng Jiang (1):
      staging: r8188eu: add check for kzalloc

Jérôme Pouiller (1):
      wfx: get out from the staging area

Mahak Gupta (4):
      staging: rtl8712: fix camel case in function r8712_generate_ie
      staging: r8188eu: remove else after return and break statements
      staging: r8188eu: add space around operators
      staging: r8188eu: place constants in right side in a comparison

Martin Kaiser (102):
      staging: r8188eu: remove local BIT macro
      staging: r8188eu: remove two limit defines
      staging: r8188eu: remove unused defines for dynamic functions
      staging: r8188eu: DYNAMIC_BB_DYNAMIC_TXPWR is not used
      staging: r8188eu: DYNAMIC_BB_ANT_DIV is not used
      staging: r8188eu: DYNAMIC_RF_CALIBRATION is not used
      staging: r8188eu: refactor dm func set and clear
      staging: r8188eu: make _rtw_init_mlme_priv static
      staging: r8188eu: the MCS_rate_2R array is not used
      staging: r8188eu: remove empty rtw_dummy_event_callback
      staging: r8188eu: remove empty rtw_fwdbg_event_callback
      staging: r8188eu: use ieee80211 define for version check
      staging: r8188eu: use ieee80211 helper to read the pwr bit
      staging: r8188eu: use standard mechanisms for control frames
      staging: r8188eu: use standard mechanisms for data frames
      staging: r8188eu: use standard mechanisms for qos data frames
      staging: r8188eu: remove unused data frame subtypes
      staging: r8188eu: remove unused control frame subtypes
      staging: r8188eu: use ieee80211 macro for sequence number
      staging: r8188eu: use ieee80211 define for fragment number
      staging: r8188eu: remove the "dump rx packet" fragments
      staging: r8188eu: remove the "dump tx packet" fragments
      staging: r8188eu: remove unnecessary jump
      staging: r8188eu: remove constant variable
      staging: r8188eu: make validate_recv_mgnt_frame return void
      staging: r8188eu: use ieee80211 helpers in validate_recv_mgnt_frame
      staging: r8188eu: make validate_recv_ctrl_frame return void
      staging: r8188eu: use ieee80211 helper to check for pspoll
      staging: r8188eu: exit straight away if we have no pspoll frame
      staging: r8188eu: use ieee80211 structs for addresses
      staging: r8188eu: use ieee80211 struct for aid
      staging: r8188eu: use ieee80211 helper for source address
      staging: r8188eu: use ieee80211 helper for destination address
      staging: r8188eu: use ieee80211 helper for retry bit
      staging: r8188eu: simplify error handling
      staging: r8188eu: to_fr_ds cannot be 3 here
      staging: r8188eu: don't copy ra and ta before we fail
      staging: r8188eu: remove to_fr_ds from struct rx_pkt_attrib
      staging: r8188eu: ra and ta do not depend on to_ds, from_ds
      staging: r8188eu: remove psa, pda
      staging: r8188eu: don't call get_hdr_bssid
      staging: r8188eu: remove the bretry variable
      staging: r8188eu: no need for an else after return
      staging: r8188eu: remove unnecessary rtw_get_passing_time_ms call
      staging: r8188eu: summarize two if statements
      staging: r8188eu: improve timeout handling in rtl8188e_firmware_download
      staging: r8188eu: improve timeout handling in rtw_check_join_candidate
      staging: r8188eu: make LPS_RF_ON_check static
      staging: r8188eu: improve timeout handling in LPS_RF_ON_check
      staging: r8188eu: improve timeout handling in iol_execute
      staging: r8188eu: improve timeout handling in efuse_read_phymap_from_txpktbuf
      staging: r8188eu: simplify delay conditions in rtw_pwr_wakeup
      staging: r8188eu: make return values consistent
      staging: r8188eu: simplify the ps_processing check
      staging: r8188eu: summarize two if statements
      staging: r8188eu: use kernel functions for timeout handling
      staging: r8188eu: clean up the code to set ips_deny_time
      staging: r8188eu: remove the bInSuspend loop
      staging: r8188eu: remove unused timer functions
      staging: r8188eu: use ieee80211 helper to read the qos tid
      staging: r8188eu: merge _mgt_dispatcher into mgt_dispatcher
      staging: r8188eu: use ieee80211 helpers in mgt_dispatcher
      staging: r8188eu: pkt_newalloc is not used
      staging: r8188eu: check receiver address only once
      staging: r8188eu: replace the GetFrameSubType call
      staging: r8188eu: the frame type is shifted out
      staging: r8188eu: replace mlme_handler with function pointer
      staging: r8188eu: don't call empty DoReserved function
      staging: r8188eu: use ARRAY_SIZE for mlme_sta_tbl
      staging: r8188eu: remove OnAtim
      staging: r8188eu: remove dummy entries from OnAction_tbl
      staging: r8188eu: on_action_spct does nothing
      staging: r8188eu: remove OnAction_qos
      staging: r8188eu: remove OnAction_dls
      staging: r8188eu: fix the index check in mgt_dispatcher
      staging: r8188eu: action category ht is not used
      staging: r8188eu: action category wmm is not used
      staging: r8188eu: remove unused action handler prototypes
      staging: r8188eu: remove action_handler string
      staging: r8188eu: remove an unused category define
      staging: r8188eu: replace OnAction_tbl with switch-case
      staging: r8188eu: use ieee80211_mgmt for action category
      staging: r8188eu: use standard category defines
      staging: r8188eu: remove unused IEEE_* defines
      staging: r8188eu: read addr2 from ieee80211_mgmt
      staging: r8188eu: don't check the category in OnAction_back
      staging: r8188eu: read destination address from ieee80211_mgmt
      staging: r8188eu: use back action codes from ieee80211.h
      staging: r8188eu: read back action code from ieee80211_mgmt
      staging: r8188eu: get addba resp status from ieee80211_mgmt
      staging: r8188eu: read addba resp tid from ieee80211_mgmt
      staging: r8188eu: merge process_addba_req into OnAction_back
      staging: r8188eu: replace if with ternary operator
      staging: r8188eu: use BIT(tid) instead of manual shift
      staging: r8188eu: check for initiator vs recipient
      staging: r8188eu: use the tid in delba processing
      staging: r8188eu: use defines for addba response status
      staging: r8188eu: use ieee80211 helper to check for beacon
      staging: r8188eu: remove obsolete comments
      staging: r8188eu: simplify error handling in recv_func_prehandle
      staging: r8188eu: last_rx_mgnt_pkts is set but not used
      staging: r8188eu: assoc_rsp and assoc_rsp_len are not used

Michael Straube (77):
      staging: r8188eu: refactor rtw_usb_bulk_size_boundary()
      staging: r8188eu: refactor rtw_inc_and_chk_continual_urb_error()
      staging: r8188eu: convert rtw_usb_bulk_size_boundary() to bool
      staging: r8188eu: convert rtw_inc_and_chk_continual_urb_error() to bool
      staging: r8188eu: remove HW_VAR_RESP_SIFS from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_MLME_DISCONNECT from SetHwReg8188EU()
      staging: r8188eu: rename some macros to upper case
      staging: r8188eu: remove HW_VAR_ACM_CTRL from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_RXDMA_AGG_PG_TH from SetHwReg8188EU()
      staging: r8188eu: simplify if-else statement
      staging: r8188eu: remove HW_VAR_TX_RPT_MAX_MACID from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_BCN_VALID from SetHwReg8188EU()
      staging: r8188eu: rename clear_bacon_valid_bit()
      staging: r8188eu: remove HW_VAR_BCN_VALID from GetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_CHK_HI_QUEUE_EMPTY from GetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_FWLPS_RF_ON from GetHwReg8188EU()
      staging: r8188eu: remove GetHwReg8188EU()
      staging: rtl8723bs: remove 5 GHz channels from ch_freq_map
      staging: rtl8723bs: refactor rtw_ch2freq()
      staging: r8188eu: remove HW_VAR_BSSID from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_ACK_PREAMBLE from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_AMPDU_MIN_SPACE from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_ANTENNA_DIVERSITY_SELECT from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_RPT_TIMER_SETTING from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_H2C_FW_JOINBSSRPT from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_H2C_FW_P2P_PS_OFFLOAD from SetHwReg8188EU()
      staging: r8188eu: remove unused parameter from _rtw_pwr_wakeup()
      staging: r8188eu: remove constant parameter from _rtw_pwr_wakeup()
      staging: r8188eu: remove macro rtw_pwr_wakeup()
      staging: r8188eu: clean up comment for rtw_pwr_wakeup()
      staging: r8188eu: remove unused fields from struct pwrctrl_priv
      staging: r8188eu: reg_rfoff is never set
      staging: r8188eu: pnp_bstop_trx is never set
      staging: r8188eu: pwr_state_check_cnts is always zero
      staging: r8188eu: ps_flag is never set
      staging: r8188eu: remove unncessary ternary operator
      staging: r8188eu: remove unused macros from ieee80211.h
      staging: r8188eu: cur_ant is set but never used
      staging: r8188eu: remove HAL_DEF_IS_SUPPORT_ANT_DIV
      staging: r8188eu: remove HAL_DEF_CURRENT_ANTENNA
      staging: r8188eu: remove GetHalDefVar8188EUsb()
      staging: r8188eu: use PTR_ALIGN() instead of RND4()
      staging: r8188eu: use round_up() instead of _RND4()
      staging: r8188eu: use round_up() instead of _RND8()
      staging: r8188eu: use round_up() instead of _RND128()
      staging: r8188eu: remove unused _RND* from osdep_service.h
      staging: rtl8723bs: remove header rtw_ioctl.h
      staging: r8188eu: remove unused macros from basic_types.h
      staging: r8188eu: move struct rt_firmware to rtw_fw.h
      staging: r8188eu: ROMVer is always zero
      staging: r8188eu: remove unused fields from struct eeprom_priv
      staging: r8188eu: remove unused enums from odm.h
      staging: r8188eu: remove unused prototype usbvendorrequest()
      staging: r8188eu: remove header usb_vendor_req.h
      staging: r8188eu: clean up rtw_ioctl.h
      staging: r8188eu: remove SetHalDefVar8188EUsb()
      staging: r8188eu: convert else if to else in rtw_led.c
      staging: r8188eu: remove HW_VAR_INITIAL_GAIN
      staging: r8188eu: remove HW_VAR_MLME_JOIN
      staging: r8188eu: remove HW_VAR_FIFO_CLEARN_UP
      staging: r8188eu: remove HW_VAR_H2C_FW_PWRMODE
      staging: r8188eu: correct macro spelling mistake
      staging: r8188eu: rename parameter of block_write()
      staging: r8188eu: change void parameters to u8
      staging: r8188eu: reduce variables in block_write()
      staging: r8188eu: remove unneeded initializations
      staging: r8188eu: clean up long lines in block_write()
      staging: r8188eu: fix struct rt_firmware_hdr
      staging: r8188eu: convert u32 fields of rt_firmware_hdr to __le32
      staging: r8188eu: clean up comments in struct rt_firmware_hdr
      staging: r8188eu: rename fields of struct rt_firmware_hdr
      staging: r8188eu: use sizeof instead of hardcoded firmware header size
      staging: r8188eu: remove variables from rtl8188e_firmware_download()
      staging: r8188eu: use pr_info_once() to log the firmware version
      staging: r8188eu: check firmware header existence before access
      staging: r8188eu: use in-kernel ieee80211 header structures
      staging: r8188eu: remove HW_VAR_AC_PARAM_BE from SetHwReg8188EU()

Nickalas Cason (1):
      staging: greybus: correct typo in comment

Philipp Hortmann (16):
      staging: vt6655: Remove unused macros in mac.h
      staging: vt6655: Rename constant definitions with CamelCase
      staging: vt6655: Remove macro PCAvDelayByIO
      staging: vt6655: Delete tmacro.h
      staging: vt6655: Replace MACvGPIOIn with VNSvInPortB
      staging: vt6655: Replace VNSvInPortB with ioread8
      staging: vt6655: Replace VNSvInPortW with ioread16
      staging: vt6655: Replace MACvReadMIBCounter with VNSvInPortD
      staging: vt6655: Replace MACvReadISR with VNSvInPortD
      staging: vt6655: Replace VNSvInPortD with ioread32
      staging: vt6655: Added missing BE support in CARDbGetCurrentTSF
      staging: vt6655: Rename function CARDbGetCurrentTSF
      staging: vt6655: Replace unused return value of vt6655_get_current_tsf
      staging: vt6655: Replace MACvStart with VNSvOutPortB
      staging: vt6655: Replace MACvTransmitBCN with VNSvOutPortB
      staging: vt6655: Replace VNSvOutPortB with iowrite8

Phillip Potter (2):
      staging: r8188eu: remove _drv_ defines from include/rtw_debug.h
      staging: r8188eu: remove include/rtw_debug.h

Rebecca Mckeever (23):
      staging: r8188eu: fix suspect code indent for conditional statements
      staging: r8188eu: remove unnecessary spaces
      staging: r8188eu: use sizeof(*pvar) for allocating structs
      staging: r8188eu: remove handlerOS independent comment
      staging: r8188eu: place constants on the right side of tests
      staging: r8188eu: remove else after return
      staging: r8188eu: correct misspelling in comment "conider" -> "consider"
      staging: r8188eu: format block comments
      staging: r8188eu: remove unnecessary braces in conditional statements
      staging: r8188eu: remove spaces before tabs
      staging: r8188eu: remove handlerOS independent comment
      staging: r8188eu: combine both sides of conditional statement
      staging: r8188eu: add blank line between functions
      staging: rtl8723bs: remove handlerOS independent comment
      staging: rtl8723bs: combine both sides of conditional statement
      staging: r8188eu: format comments in drivers/net style
      staging: r8188eu: remove extra 'the'
      staging: r8188eu: correct misspelling in comment 'tppe' -> 'type'
      staging: r8188eu: use sizeof(*pvar) for allocating structs
      staging: rtl8192u: replace ternary statement with if and assignment
      staging: rtl8192u: use min_t/max_t macros instead of if else
      staging: rtl8192u: compare strcmp result to zero
      staging: rtl8192u: change get_key functions to return 0 instead of -1

Sathish Kumar (4):
      staging: rtl8712: Use completions for signaling
      staging: vt6656: Fix multiple blank lines warning
      staging: rtl8712: Fix multiple blank lines warning from .h files
      staging: rtl8712: Fix multiple blank lines warning from .c files

Sevinj Aghayeva (13):
      staging: rtl8723bs: Remove redundant else branches.
      staging: rtl8723bs: place constants on the right side of tests
      staging: rtl8723bs: place constants on the right side of tests
      staging: rtl8723bs: remove redundant braces in if statements
      staging: rtl8723bs: simplify control flow
      staging: r8188eu: simplify control flow
      staging: rtl8712: simplify control flow
      staging: rtl8723bs: simplify control flow
      staging: rtl8723bs: remove redundant braces in if statements
      staging: rtl8723bs: remove return from a function returning void
      staging: rtl8723bs: remove redundant else branches
      staging: rtl8723bs: remove space after function name
      staging: rtl8723bs: fix indentation

Solomon Tan (11):
      staging: rtl8712: Remove unnecessary int typecast
      staging: rtl8192e: Remove space after cast
      staging: r8188eu: use in-kernel ieee channel
      Revert "staging: r8188eu: use in-kernel ieee channel"
      staging: rtl8192e: Remove unnecessary u8 assignment cast
      staging: rtl8192e: Remove unnecessary u8 argument cast
      staging: rtl8192e: Remove unnecessary u8 cast in comparison
      staging: rtl8192e: Remove unnecessary u16 assignment cast
      staging: rtl8192e: Remove unnecessary u16 argument cast
      staging: rtl8192e: Remove u16 cast for u32 parameter
      staging: rtl8192e: Remove u16 cast for u16 return value

Soumya Negi (4):
      staging: qlge: add blank line after function declaration
      staging: rtl8723bs: Fix alignment to match open parenthesis
      staging: r8188eu: Fix block comment format
      staging: r8188eu: Remove multiple assignments

Uwe Kleine-König (1):
      staging: greybus: pwm: Drop assignment to struct pwm_chip::base

Vaibhav Nagare (1):
      staging: greybus: tools: fix spelling

Vihas Makwana (14):
      staging: r8188eu: drop redundant if check in IS_MCAST
      staging: r8188eu: drop unnecessary wrapper _rtw_free_cmd_priv
      staging: r8188eu: drop unnecessary wrapper _rtw_init_cmd_priv
      staging: r8188eu: drop unnecessary wrapper _rtw_init_evt_priv
      staging: r8188eu: drop unnecessary wrapper _rtw_init_mlme_priv
      staging: r8188eu: drop unnecessary wrapper _rtw_free_mlme_priv
      staging: r8188eu: drop unnecessary wrapper _rtw_alloc_network
      staging: r8188eu: drop unnecessary wrapper _rtw_dequeue_cmd
      staging: r8188eu: remove unused semaphore "allrxreturnevt"
      staging: r8188eu: drop redundant check in _rtw_free_mlme_priv
      staging: r8188eu: drop redundant if check
      staging: r8188eu: fix warnings in rtw_p2p
      staging: r8188eu: fix warnings in rtw_pwrctrl
      staging: r8188eu: fix warnings in rtw_wlan_util

Wan Jiabing (1):
      staging: r8188eu: Remove unneeded variable ret in rtw_suspend()

Wang Cheng (3):
      staging: rtl8712: add error handler in r8712_usbctrl_vendorreq()
      staging: rtl8712: fix uninit-value in usb_read8() and friends
      staging: rtl8712: fix uninit-value in r871xu_drv_init()

Wang Qing (1):
      staging: r8188eu: remove duplicate assignment

Xiaoke Wang (2):
      staging: r8188eu: add a check for rtw_cbuf_alloc()
      staging: rtl8712: fix a potential memory leak in r871xu_drv_init()

Yihao Han (1):
      staging: rtl8723bs: tidy up error handling

ran jianping (1):
      staging: vchiq:remove unneeded flush_workqueue

白浩文 (1):
      staging: r8188eu: Fix misspelling in comment "cacluated" -> "calculated"

 .../{staging => }/net/wireless/silabs,wfx.yaml     |    2 +-
 MAINTAINERS                                        |   14 +-
 drivers/Kconfig                                    |    2 -
 drivers/Makefile                                   |    1 -
 drivers/net/wireless/Kconfig                       |    1 +
 drivers/net/wireless/Makefile                      |    1 +
 drivers/net/wireless/silabs/Kconfig                |   18 +
 .../{staging/vme => net/wireless/silabs}/Makefile  |    3 +-
 .../{staging => net/wireless/silabs}/wfx/Kconfig   |    0
 .../{staging => net/wireless/silabs}/wfx/Makefile  |    0
 drivers/{staging => net/wireless/silabs}/wfx/bh.c  |    0
 drivers/{staging => net/wireless/silabs}/wfx/bh.h  |    0
 drivers/{staging => net/wireless/silabs}/wfx/bus.h |    0
 .../wireless/silabs}/wfx/bus_sdio.c                |    0
 .../{staging => net/wireless/silabs}/wfx/bus_spi.c |    0
 .../{staging => net/wireless/silabs}/wfx/data_rx.c |    0
 .../{staging => net/wireless/silabs}/wfx/data_rx.h |    0
 .../{staging => net/wireless/silabs}/wfx/data_tx.c |    0
 .../{staging => net/wireless/silabs}/wfx/data_tx.h |    0
 .../{staging => net/wireless/silabs}/wfx/debug.c   |    0
 .../{staging => net/wireless/silabs}/wfx/debug.h   |    0
 .../{staging => net/wireless/silabs}/wfx/fwio.c    |    0
 .../{staging => net/wireless/silabs}/wfx/fwio.h    |    0
 .../wireless/silabs}/wfx/hif_api_cmd.h             |    0
 .../wireless/silabs}/wfx/hif_api_general.h         |    0
 .../wireless/silabs}/wfx/hif_api_mib.h             |    0
 .../{staging => net/wireless/silabs}/wfx/hif_rx.c  |    0
 .../{staging => net/wireless/silabs}/wfx/hif_rx.h  |    0
 .../{staging => net/wireless/silabs}/wfx/hif_tx.c  |   10 +-
 .../{staging => net/wireless/silabs}/wfx/hif_tx.h  |    0
 .../wireless/silabs}/wfx/hif_tx_mib.c              |    0
 .../wireless/silabs}/wfx/hif_tx_mib.h              |    0
 .../{staging => net/wireless/silabs}/wfx/hwio.c    |    0
 .../{staging => net/wireless/silabs}/wfx/hwio.h    |    0
 drivers/{staging => net/wireless/silabs}/wfx/key.c |    0
 drivers/{staging => net/wireless/silabs}/wfx/key.h |    0
 .../{staging => net/wireless/silabs}/wfx/main.c    |    2 +-
 .../{staging => net/wireless/silabs}/wfx/main.h    |    0
 .../{staging => net/wireless/silabs}/wfx/queue.c   |    0
 .../{staging => net/wireless/silabs}/wfx/queue.h   |    0
 .../{staging => net/wireless/silabs}/wfx/scan.c    |    0
 .../{staging => net/wireless/silabs}/wfx/scan.h    |    0
 drivers/{staging => net/wireless/silabs}/wfx/sta.c |   20 +-
 drivers/{staging => net/wireless/silabs}/wfx/sta.h |    0
 .../{staging => net/wireless/silabs}/wfx/traces.h  |    0
 drivers/{staging => net/wireless/silabs}/wfx/wfx.h |    0
 drivers/staging/Kconfig                            |    4 +-
 drivers/staging/Makefile                           |    4 +-
 drivers/staging/fieldbus/anybuss/host.c            |    2 +-
 drivers/staging/greybus/arche-apb-ctrl.c           |    2 +-
 drivers/staging/greybus/arche-platform.c           |    2 +-
 drivers/staging/greybus/audio_codec.c              |   32 +-
 drivers/staging/greybus/pwm.c                      |    1 -
 drivers/staging/greybus/tools/loopback_test.c      |    2 +-
 drivers/staging/iio/resolver/ad2s1210.c            |    1 -
 drivers/staging/ks7010/ks_hostif.c                 |   19 +-
 drivers/staging/ks7010/ks_wlan.h                   |    2 +-
 drivers/staging/most/dim2/dim2.c                   |   29 +-
 drivers/staging/qlge/qlge.h                        |    1 +
 drivers/staging/r8188eu/core/rtw_ap.c              |    3 -
 drivers/staging/r8188eu/core/rtw_br_ext.c          |   76 +-
 drivers/staging/r8188eu/core/rtw_cmd.c             |  337 ++-
 drivers/staging/r8188eu/core/rtw_fw.c              |  163 +-
 drivers/staging/r8188eu/core/rtw_ieee80211.c       |   45 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c       |    4 +-
 drivers/staging/r8188eu/core/rtw_iol.c             |    4 +-
 drivers/staging/r8188eu/core/rtw_led.c             |   10 +-
 drivers/staging/r8188eu/core/rtw_mlme.c            |  321 ++-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c        |  755 ++++---
 drivers/staging/r8188eu/core/rtw_p2p.c             |   70 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c         |  109 +-
 drivers/staging/r8188eu/core/rtw_recv.c            |  319 ++-
 drivers/staging/r8188eu/core/rtw_security.c        |    6 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c         |    4 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c       |  135 +-
 drivers/staging/r8188eu/core/rtw_xmit.c            |  104 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c     |    6 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c    |    2 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c     |    2 +-
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c         |   22 -
 drivers/staging/r8188eu/hal/hal_com.c              |    4 +-
 drivers/staging/r8188eu/hal/odm_HWConfig.c         |    8 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c         |   49 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c    |   15 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c      |    8 +-
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c      |    7 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c       |    8 +-
 drivers/staging/r8188eu/hal/usb_halinit.c          |  355 +---
 drivers/staging/r8188eu/hal/usb_ops_linux.c        |   10 +-
 drivers/staging/r8188eu/include/HalVerDef.h        |    5 +-
 drivers/staging/r8188eu/include/basic_types.h      |   73 +-
 drivers/staging/r8188eu/include/drv_types.h        |    7 +-
 drivers/staging/r8188eu/include/hal_intf.h         |   34 +-
 drivers/staging/r8188eu/include/ieee80211.h        |   63 -
 drivers/staging/r8188eu/include/odm.h              |   29 -
 drivers/staging/r8188eu/include/osdep_service.h    |   47 -
 drivers/staging/r8188eu/include/rtl8188e_hal.h     |    3 -
 drivers/staging/r8188eu/include/rtl8188e_spec.h    |   10 +-
 drivers/staging/r8188eu/include/rtw_debug.h        |   55 -
 drivers/staging/r8188eu/include/rtw_eeprom.h       |    3 -
 drivers/staging/r8188eu/include/rtw_fw.h           |    5 +
 drivers/staging/r8188eu/include/rtw_ioctl.h        |   79 -
 drivers/staging/r8188eu/include/rtw_mlme.h         |   11 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h     |   62 +-
 drivers/staging/r8188eu/include/rtw_pwrctrl.h      |   23 +-
 drivers/staging/r8188eu/include/rtw_recv.h         |    3 -
 drivers/staging/r8188eu/include/rtw_xmit.h         |    4 +-
 drivers/staging/r8188eu/include/sta_info.h         |    2 -
 drivers/staging/r8188eu/include/usb_ops.h          |   22 +-
 drivers/staging/r8188eu/include/usb_osintf.h       |    4 -
 drivers/staging/r8188eu/include/usb_vendor_req.h   |   35 -
 drivers/staging/r8188eu/include/wifi.h             |   60 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c       |  295 +--
 drivers/staging/r8188eu/os_dep/mlme_linux.c        |    1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c          |   45 +-
 drivers/staging/r8188eu/os_dep/osdep_service.c     |   27 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c          |    5 +-
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c     |   19 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c        |   16 +-
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c |    8 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c  |    2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |   52 +-
 .../staging/rtl8192e/rtl8192e/r8192E_firmware.c    |    3 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     |   22 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         |   20 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |    5 +-
 drivers/staging/rtl8192e/rtllib.h                  |    2 +-
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c       |   10 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |   38 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |   22 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          |   63 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |    4 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |    2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211.h     |    2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      |    2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c      |    2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c       |    2 +-
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c |   30 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c  |    8 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    |   15 +-
 drivers/staging/rtl8192u/r8192U_core.c             |    2 +-
 drivers/staging/rtl8712/drv_types.h                |    3 +-
 drivers/staging/rtl8712/ieee80211.c                |    4 +-
 drivers/staging/rtl8712/os_intfs.c                 |    1 -
 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h   |    1 -
 drivers/staging/rtl8712/rtl8712_efuse.h            |    4 +-
 .../staging/rtl8712/rtl8712_macsetting_bitdef.h    |    3 -
 .../staging/rtl8712/rtl8712_macsetting_regdef.h    |    2 -
 drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h  |    1 -
 drivers/staging/rtl8712/rtl8712_recv.c             |   16 +-
 drivers/staging/rtl8712/rtl8712_security_bitdef.h  |    1 -
 drivers/staging/rtl8712/rtl8712_spec.h             |    3 -
 drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h    |    4 -
 drivers/staging/rtl8712/rtl8712_syscfg_regdef.h    |    2 -
 drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h  |    1 -
 drivers/staging/rtl8712/rtl8712_wmac_bitdef.h      |    1 -
 drivers/staging/rtl8712/rtl871x_cmd.c              |    4 +-
 drivers/staging/rtl8712/rtl871x_cmd.h              |    3 -
 drivers/staging/rtl8712/rtl871x_ioctl.h            |    1 -
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c      |   24 +-
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.c        |    1 -
 drivers/staging/rtl8712/rtl871x_ioctl_set.c        |    3 +-
 drivers/staging/rtl8712/rtl871x_mlme.c             |  102 +-
 drivers/staging/rtl8712/rtl871x_mp_ioctl.h         |    1 -
 drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h    |    3 -
 drivers/staging/rtl8712/rtl871x_recv.c             |    1 -
 drivers/staging/rtl8712/rtl871x_security.c         |    1 -
 drivers/staging/rtl8712/sta_info.h                 |    1 -
 drivers/staging/rtl8712/usb_intf.c                 |   14 +-
 drivers/staging/rtl8712/usb_ops.c                  |   27 +-
 drivers/staging/rtl8712/usb_ops_linux.c            |   21 +-
 drivers/staging/rtl8712/wifi.h                     |    1 -
 drivers/staging/rtl8712/xmit_linux.c               |    8 +-
 drivers/staging/rtl8723bs/core/rtw_ap.c            |   24 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |   12 +-
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |   54 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |   44 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |   66 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |  194 +-
 drivers/staging/rtl8723bs/core/rtw_rf.c            |   56 +-
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h       |   11 -
 drivers/staging/rtl8723bs/hal/hal_btcoex.c         |    8 -
 drivers/staging/rtl8723bs/hal/sdio_ops.c           |   15 +-
 drivers/staging/rtl8723bs/include/HalVerDef.h      |   10 -
 drivers/staging/rtl8723bs/include/drv_types.h      |    1 -
 drivers/staging/rtl8723bs/include/hal_com_reg.h    |  295 ---
 drivers/staging/rtl8723bs/include/rtw_ioctl.h      |   72 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |    2 +-
 drivers/staging/rts5208/rtsx_transport.c           |   12 +-
 drivers/staging/sm750fb/sm750_hw.c                 |    1 +
 .../Documentation/ABI/sysfs-platform-visorchipset  |   89 -
 drivers/staging/unisys/Documentation/overview.txt  |  337 ---
 drivers/staging/unisys/Kconfig                     |   16 -
 drivers/staging/unisys/MAINTAINERS                 |    5 -
 drivers/staging/unisys/Makefile                    |    7 -
 drivers/staging/unisys/TODO                        |   16 -
 drivers/staging/unisys/include/iochannel.h         |  571 ------
 drivers/staging/unisys/visorhba/Kconfig            |   15 -
 drivers/staging/unisys/visorhba/Makefile           |   10 -
 drivers/staging/unisys/visorhba/visorhba_main.c    | 1142 -----------
 drivers/staging/unisys/visorinput/Kconfig          |   16 -
 drivers/staging/unisys/visorinput/Makefile         |    7 -
 drivers/staging/unisys/visorinput/visorinput.c     |  788 -------
 drivers/staging/unisys/visornic/Kconfig            |   16 -
 drivers/staging/unisys/visornic/Makefile           |   10 -
 drivers/staging/unisys/visornic/visornic_main.c    | 2148 --------------------
 drivers/staging/vc04_services/Kconfig              |    1 +
 .../staging/vc04_services/bcm2835-audio/Kconfig    |    8 +-
 drivers/staging/vc04_services/bcm2835-audio/TODO   |   10 -
 .../vc04_services/bcm2835-audio/bcm2835-ctl.c      |   86 +-
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      |    5 +-
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |    2 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  |   33 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.h  |    2 +-
 .../staging/vc04_services/bcm2835-camera/Kconfig   |    4 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |   24 +-
 .../vc04_services/bcm2835-camera/controls.c        |   33 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   26 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |    1 -
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |   13 +-
 .../vc04_services/vchiq-mmal/mmal-msg-common.h     |    7 +-
 .../vc04_services/vchiq-mmal/mmal-msg-format.h     |    6 +-
 .../vc04_services/vchiq-mmal/mmal-parameters.h     |   15 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |   11 +-
 drivers/staging/{vme/devices => vme_user}/Kconfig  |    2 +-
 drivers/staging/{vme/devices => vme_user}/Makefile |    0
 .../staging/{vme/devices => vme_user}/vme_user.c   |    2 +-
 .../staging/{vme/devices => vme_user}/vme_user.h   |    0
 drivers/staging/vt6655/baseband.c                  |   15 +-
 drivers/staging/vt6655/card.c                      |   38 +-
 drivers/staging/vt6655/card.h                      |    2 +-
 drivers/staging/vt6655/channel.c                   |    6 +-
 drivers/staging/vt6655/device_main.c               |   37 +-
 drivers/staging/vt6655/key.c                       |    1 -
 drivers/staging/vt6655/mac.c                       |    1 -
 drivers/staging/vt6655/mac.h                       |  271 +--
 drivers/staging/vt6655/rf.c                        |   10 +-
 drivers/staging/vt6655/rxtx.c                      |    6 +-
 drivers/staging/vt6655/srom.c                      |   19 +-
 drivers/staging/vt6655/tmacro.h                    |   43 -
 drivers/staging/vt6655/upc.h                       |   25 -
 drivers/staging/vt6656/channel.c                   |    1 -
 drivers/staging/vt6656/rf.c                        |    1 -
 drivers/staging/wfx/TODO                           |    6 -
 drivers/staging/wlan-ng/cfg80211.c                 |   10 +-
 drivers/staging/wlan-ng/hfa384x.h                  |    4 +-
 drivers/staging/wlan-ng/hfa384x_usb.c              |   34 +-
 drivers/staging/wlan-ng/prism2usb.c                |    8 +-
 drivers/visorbus/Kconfig                           |   15 -
 drivers/visorbus/Makefile                          |   10 -
 drivers/visorbus/controlvmchannel.h                |  650 ------
 drivers/visorbus/vbuschannel.h                     |   95 -
 drivers/visorbus/visorbus_main.c                   | 1234 -----------
 drivers/visorbus/visorbus_private.h                |   48 -
 drivers/visorbus/visorchannel.c                    |  434 ----
 drivers/visorbus/visorchipset.c                    | 1691 ---------------
 drivers/vme/Kconfig                                |    2 -
 257 files changed, 2117 insertions(+), 13723 deletions(-)
 rename Documentation/devicetree/bindings/{staging => }/net/wireless/silabs,wfx.yaml (98%)
 create mode 100644 drivers/net/wireless/silabs/Kconfig
 rename drivers/{staging/vme => net/wireless/silabs}/Makefile (52%)
 rename drivers/{staging => net/wireless/silabs}/wfx/Kconfig (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/Makefile (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/bh.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/bh.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/bus.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/bus_sdio.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/bus_spi.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/data_rx.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/data_rx.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/data_tx.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/data_tx.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/debug.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/debug.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/fwio.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/fwio.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/hif_api_cmd.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/hif_api_general.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/hif_api_mib.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/hif_rx.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/hif_rx.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/hif_tx.c (98%)
 rename drivers/{staging => net/wireless/silabs}/wfx/hif_tx.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/hif_tx_mib.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/hif_tx_mib.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/hwio.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/hwio.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/key.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/key.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/main.c (99%)
 rename drivers/{staging => net/wireless/silabs}/wfx/main.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/queue.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/queue.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/scan.c (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/scan.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/sta.c (98%)
 rename drivers/{staging => net/wireless/silabs}/wfx/sta.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/traces.h (100%)
 rename drivers/{staging => net/wireless/silabs}/wfx/wfx.h (100%)
 delete mode 100644 drivers/staging/r8188eu/include/rtw_debug.h
 delete mode 100644 drivers/staging/r8188eu/include/usb_vendor_req.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_ioctl.h
 delete mode 100644 drivers/staging/unisys/Documentation/ABI/sysfs-platform-visorchipset
 delete mode 100644 drivers/staging/unisys/Documentation/overview.txt
 delete mode 100644 drivers/staging/unisys/Kconfig
 delete mode 100644 drivers/staging/unisys/MAINTAINERS
 delete mode 100644 drivers/staging/unisys/Makefile
 delete mode 100644 drivers/staging/unisys/TODO
 delete mode 100644 drivers/staging/unisys/include/iochannel.h
 delete mode 100644 drivers/staging/unisys/visorhba/Kconfig
 delete mode 100644 drivers/staging/unisys/visorhba/Makefile
 delete mode 100644 drivers/staging/unisys/visorhba/visorhba_main.c
 delete mode 100644 drivers/staging/unisys/visorinput/Kconfig
 delete mode 100644 drivers/staging/unisys/visorinput/Makefile
 delete mode 100644 drivers/staging/unisys/visorinput/visorinput.c
 delete mode 100644 drivers/staging/unisys/visornic/Kconfig
 delete mode 100644 drivers/staging/unisys/visornic/Makefile
 delete mode 100644 drivers/staging/unisys/visornic/visornic_main.c
 delete mode 100644 drivers/staging/vc04_services/bcm2835-audio/TODO
 rename drivers/staging/{vme/devices => vme_user}/Kconfig (93%)
 rename drivers/staging/{vme/devices => vme_user}/Makefile (100%)
 rename drivers/staging/{vme/devices => vme_user}/vme_user.c (99%)
 rename drivers/staging/{vme/devices => vme_user}/vme_user.h (100%)
 delete mode 100644 drivers/staging/vt6655/tmacro.h
 delete mode 100644 drivers/staging/wfx/TODO
 delete mode 100644 drivers/visorbus/Kconfig
 delete mode 100644 drivers/visorbus/Makefile
 delete mode 100644 drivers/visorbus/controlvmchannel.h
 delete mode 100644 drivers/visorbus/vbuschannel.h
 delete mode 100644 drivers/visorbus/visorbus_main.c
 delete mode 100644 drivers/visorbus/visorbus_private.h
 delete mode 100644 drivers/visorbus/visorchannel.c
 delete mode 100644 drivers/visorbus/visorchipset.c
