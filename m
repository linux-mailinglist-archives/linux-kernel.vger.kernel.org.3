Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE2C589D26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbiHDN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbiHDN6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:58:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4462E3DF15
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:58:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5974FB82449
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 13:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D0EC433C1;
        Thu,  4 Aug 2022 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659621495;
        bh=PLaBW7Nv1XRm528GVtA9qoqbbD6E6zwuF+AM9Apppmw=;
        h=Date:From:To:Cc:Subject:From;
        b=ZwZht3LIg9ZjHalOerFAPZrM0HQfLnTXqNn288HmTdKa/rl8eCaDVTCGJm7+jLRSP
         BFlSZXyNHCEK/ztHRho7wlmha60Qbd+UTX2jgbsOFIhRQRmOAL/ZjM0nnhY0Mbagbb
         IeaXuo08XC9F38hfuAWyLGtOdt74Bivsi8GswtyE=
Date:   Thu, 4 Aug 2022 15:58:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver changes for 6.0-rc1
Message-ID: <YuvQdHf3ySPA78/1@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.0-rc1

for you to fetch changes up to 87f600af59e8cf6abb04bac15328bcb517e26485:

  staging: r8188eu: fix potential uninitialised variable use in rtw_pwrctrl.c (2022-07-31 10:07:45 +0200)

----------------------------------------------------------------
Staging driver patches for 6.0-rc1

Here is the big set of staging driver patches for 6.0-rc1.

Another round where we removed more lines of code than added, always a
nice progression.  Some of that came from the movement of the vme code
back into staging, and removal of some other of the vme driver code as
there are no known users and it is very obsolete and unmaintained.  It
can be added back easily if someone offers to maintain it.

Other than that this merge has lots of little things:
	- huge cleanups for r8188eu driver
	- minor cleanups for other wifi drivers
	- tiny loop fixes for greybus code
	- other small coding style fixes

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adrien Thierry (9):
      staging: vchiq_arm: add reference to vchiq device in vchiq_state
      staging: vchiq_arm: get rid of global device structure
      staging: vchiq_arm: pass vchiq instance to service callbacks
      staging: vchiq_arm: pass vchiq instance to 'find_service_by_handle'
      staging: vchiq_arm: pass vchiq instance to 'vchiq_get_client_id'
      staging: vchiq_arm: pass vchiq instance to 'vchiq_get_service_userdata'
      staging: vchiq_arm: pass vchiq instance to 'handle_to_service'
      staging: vchiq_arm: use state from vchiq instance
      staging: vchiq_arm: remove global 'vchiq_states' array

Arnd Bergmann (2):
      vme: remove ca91cx42 Universe-II support
      vme: move back to staging

Arne Petersen (1):
      staging: sm750fb: fix CamelCase function parameter

Artur Bujdoso (1):
      staging: octeon-usb: move driver out of staging

Binyi Han (3):
      staging: qlge: Fix indentation issue under long for loop
      staging: qlge: Avoid multiplication while keep the same logic
      staging: qlge: refine variable name

Chang Yu (12):
      Staging: r8188eu: core: rtw_xmit: Fixed some whitespace coding style issues
      Staging: r8188eu: core: rtw_xmit: Fixed two indentation coding style issues.
      Staging: r8188eu: core: rtw_xmit: Fixed some spelling errors in the comments
      Staging: r8188eu: core: rtw_xmit: Fixed a brace coding style issue
      Staging: r8188eu: core: rtw_xmit: Fixed a coding style issue
      staging: r8188eu: Fixed a function declaration coding style issue
      staging: r8188eu: Fixed two brace coding style issues
      staging: r8188eu: Fixed two whitespace coding style issues
      staging: r8188eu: Fixed comment style
      staging: r8188eu: Fixed some blank line coding style issues
      staging: r8188eu: Make rtw_signal_stat_timer_hdl a static function
      staging: r8188eu: core/rtw_recv.c: clean up nested if statements

Daniel Watson (7):
      staging: r8188eu: fix declaration to match 'foo *bar'
      staging: rtl8723bs: uninitialize static variable
      staging: r8188eu: call rtw_IOL_append_WB_cmd directly
      staging: r8188eu: call rtw_IOL_append_WW_cmd directly
      staging: r8188eu: call rtw_IOL_append_WD_cmd directly
      staging: r8188eu: call rtw_IOL_append_WRF_cmd directly
      staging: rtl8723bs: remove trailing whitespace

Dongliang Mu (1):
      staging: r8188eu: remove NULL check before vfree

Duoming Zhou (1):
      staging: rtl8192u: Fix sleep in atomic context bug in dm_fsync_timer_callback

Felix Schlepper (9):
      Staging: rtl8192e: Use struct_size
      Staging: rtl8192e: Using kzalloc and delete memset
      Staging: rtl8192e: Cleaning up error handling
      Staging: rtl8192e: Refactored rtllib_modes
      Staging: rtl8192e: Avoid multiple assignments
      Staging: rtl8192e: Remove unnecessary parentheses
      Staging: rtl8192e: Added braces around else
      Staging: rtl8192e: Remove unnecessary blank line
      Staging: rtl8192e: Added spaces around '+'

Greg Kroah-Hartman (3):
      Merge 5.19-rc3 into staging-next
      Merge branch 'staging-octeon' of gitolite.kernel.org:/pub/scm/linux/kernel/git/gregkh/staging into staging-next
      Merge 5.19-rc6 into staging-next

Hannes Braun (1):
      staging: rtl8723bs: fix placement of braces

Haowen Bai (1):
      staging: r8188eu: Drop redundant memset overwritten by memcpy

Jakub Kicinski (1):
      staging: switch to netif_napi_add_weight()

Jared Kangas (1):
      staging: greybus: audio: fix loop cursor use after iteration

Johan Hovold (1):
      staging: greybus: audio: replace safe list iteration

Julia Lawall (1):
      staging: qlge: fix typo in comment

Martin Kaiser (60):
      staging: r8188eu: remove unnecessary category check
      staging: r8188eu: use defines for the block action codes
      staging: r8188eu: use ieee80211_mgmt in issue_action_BA
      staging: r8188eu: use mgmt to set the addresses
      staging: r8188eu: use mgmt to set the sequence number
      staging: r8188eu: use mgmt to set the category
      staging: r8188eu: use mgmt to set the action codes
      staging: r8188eu: use mgmt to set the dialog token
      staging: r8188eu: use mgmt to set the timeout
      staging: r8188eu: use ieee80211 to set addba capabilities
      staging: r8188eu: use mgmt to set start sequence number
      staging: r8188eu: calculate the addba request length
      staging: r8188eu: use ieee80211 defines for back action codes
      staging: r8188eu: fix the declaration of process_pwrbit_data
      staging: r8188eu: use mgmt to set resp dialog token
      staging: r8188eu: use mgmt to set the addba resp status
      staging: r8188eu: use mgmt to set the addba resp timeout
      staging: r8188eu: use ieee80211 to set addba resp capabilities
      staging: r8188eu: calculate the addba response length
      staging: r8188eu: use mgmt to set the delba reason code
      staging: r8188eu: use mgmt to set delba params
      staging: r8188eu: clarify the contents of the delba params
      staging: r8188eu: calculate the delba length
      staging: r8188eu: remove the pframe variable
      staging: r8188eu: use u8, u16 in issue_action_BA prototype
      staging: r8188eu: remove rtw_usleep_os
      staging: r8188eu: merge two led structs
      staging: r8188eu: make power sequences static
      staging: r8188eu: drop return value from receive_disconnect
      staging: r8188eu: move pwr seq defines to HalPwrSeqCmd.c
      staging: r8188eu: support only us in PWR_CMD_DELAY
      staging: r8188eu: read pwr seq length, remove PWR_CMD_END
      staging: r8188eu: remove sdio definitions
      staging: r8188eu: mac addr len is unused
      staging: r8188eu: set bssid only once
      staging: r8188eu: don't set pattrib->dst again
      staging: r8188eu: don't set pattrib->ra again
      staging: r8188eu: don't set pattrib->ta again
      staging: r8188eu: remove a misleading comment
      staging: r8188eu: use ieee80211 helper to check for nullfunc frame
      staging: r8188eu: remove sta2sta_data_frame prototype
      staging: r8188eu: pattrib addresses were already set by the caller
      staging: r8188eu: remove unused eeprom defines
      staging: r8188eu: remove EepromOrEfuse from struct eeprom_priv
      staging: r8188eu: remove eeprom function prototypes
      staging: r8188eu: merge EFUSE_ShadowMapUpdate with its caller
      staging: r8188eu: use a local buffer for efuse data
      staging: r8188eu: always initialise efuse buffer with 0xff
      staging: r8188eu: use memcpy for fallback mac address
      staging: r8188eu: merge ReadEFuseByIC into rtl8188e_ReadEFuse
      staging: r8188eu: txpktbuf_bndy is always 0
      staging: r8188eu: offset is always 0 in rtl8188e_ReadEFuse
      staging: r8188eu: offset is always 0 in iol_read_efuse
      staging: r8188eu: _offset is always 0 in efuse_phymap_to_logical
      staging: r8188eu: efuse_utilized is never read
      staging: r8188eu: the bcnhead parameter is always 0
      staging: r888eu: use dynamic allocation for efuse buffer
      staging: r8188eu: fall back to random mac address
      staging: r8188eu: remove OnAtim prototype
      staging: r8188eu: remove DoReserved prototype

Michael Straube (16):
      staging: r8188eu: remove HW_VAR_SLOT_TIME from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_H2C_MEDIA_STATUS_RPT from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_AMPDU_FACTOR from SetHwReg8188EU()
      staging: r8188eu: make ffaddr2pipehdl() static
      staging: r8188eu: remove HW_VAR_BASIC_RATE from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_DM_FUNC_OP from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_DM_FLAG from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_DM_FUNC_RESET from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_DM_FUNC_CLR from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_MLME_SITESURVEY from SetHwReg8188EU()
      staging: r8188eu: remove HW_VAR_SET_OPMODE from SetHwReg8188EU()
      staging: r8188eu: remove unused parameter from correct_TSF()
      staging: r8188eu: remove unused parameter from update_TSF()
      staging: r8188eu: make update_TSF() and correct_TSF() static
      staging: r8188eu: remove SetHwReg8188EU()
      staging: r8188eu: make dump_chip_info() static

Nam Cao (7):
      staging: sm750fb: fix camelCase function name
      staging: vt6655: Update function description
      staging: r8188eu: replace FIELD_OFFSET with offsetof
      staging: r8188eu: replace confusing macros
      staging: r8188eu: remove unused macros
      staging: r8188eu: replace N_BYTE_ALIGMENT with ALIGN
      staging: r8188eu: remove basic_types.h

Pavel Skripkin (4):
      staging: r8188eu: add error handling of rtw_read8
      staging: r8188eu: add error handling of rtw_read16
      staging: r8188eu: add error handling of rtw_read32
      MAINTAINERS: add myself as r8188eu reviewer

Peter Suti (1):
      staging: fbtft: core: set smem_len before fb_deferred_io_init call

Phil Elwell (1):
      staging: vchiq_arm: Add missing memory barrier comments

Philipp Hortmann (34):
      staging: vt6655: Replace MACvSetCurrBCNLength with VNSvOutPortW
      staging: vt6655: Replace VNSvOutPortW with iowrite16
      staging: vt6655: Replace MACvWriteISR with VNSvOutPortD
      staging: vt6655: Replace MACvIntEnable with VNSvOutPortD
      staging: vt6655: Replace MACvIntDisable with VNSvOutPortD
      staging: vt6655: Replace MACvSetCurrBCNTxDescAddr with VNSvOutPortD
      staging: vt6655: Replace MACvRx0PerPktMode with VNSvOutPortD
      staging: vt6655: Replace MACvRx1PerPktMode with VNSvOutPortD
      staging: vt6655: Replace VNSvOutPortD with iowrite32
      staging: vt6655: Add missing BE support on 2x iowrite32
      staging: vt6655: Delete upc.h
      staging: vt6655: Rename pbyEtherAddr to mac_addr
      staging: vt6655: Rename MACvWriteBSSIDAddress
      staging: vt6655: Rename MACvReadEtherAddress
      staging: vt6655: Move two macros to file where those are used
      staging: vt6655: Convert macro vt6655_mac_write_bssid_addr to function
      staging: vt6655: Convert macro vt6655_mac_read_ether_addr to function
      staging: vt6655: Use loop in vt6655_mac_write_bssid_addr
      staging: vt6655: Use loop in vt6655_mac_read_ether_addr
      staging: vt6655: Rename byRegOfs to reg_offset in four macros
      staging: vt6655: Rename byBits to bit_mask in two macros
      staging: vt6655: Rename wBits to bit_mask in two macros
      staging: vt6655: Rename byData to reg_value in two macros
      staging: vt6655: Rename wData to reg_value in two macros
      staging: vt6655: Rename MACvRegBitsOn
      staging: vt6655: Rename MACvWordRegBitsOn
      staging: vt6655: Rename MACvRegBitsOff
      staging: vt6655: Rename MACvWordRegBitsOff
      staging: vt6655: Convert macro vt6655_mac_reg_bits_on to function
      staging: vt6655: Convert macro vt6655_mac_word_reg_bits_on to function
      staging: vt6655: Convert macro vt6655_mac_reg_bits_off to function
      staging: vt6655: Convert macro vt6655_mac_word_reg_bits_off to function
      staging: vt6655: Rename MACvClearStckDS
      staging: vt6655: Convert macro vt6655_mac_clear_stck_ds to function

Phillip Potter (4):
      staging: r8188eu: convert pr_info_once call in core/rtw_fw.c
      staging: r8188eu: convert rtw_pwr_wakeup to correct error code semantics
      staging: r8188eu: remove initializer from ret in rtw_pwr_wakeup
      staging: r8188eu: fix potential uninitialised variable use in rtw_pwrctrl.c

Rommel Rodriguez Perez (2):
      staging: r8188eu: Add blank line after declarations
      staging: r8188eu: Block comments use * on subsequent lines

Sidong Yang (1):
      staging: pi433: remove duplicated comments

Srivathsan Sivakumar (2):
      staging: rts5208: spi.c: fix codestyle error in dynamic debug code
      staging: qlge: qlge_main.c: rewrite do-while loops into more compact for loops

Stefan Wahren (1):
      staging: vchiq: provide testing instructions

Stephen Kitt (2):
      staging: olpc_dcon: Use backlight helper
      staging: ftbft: Use backlight helper

Steve Lemuel (1):
      staging: greybus: loopback: fix a spelling error.

Tetsuo Handa (1):
      staging: olpc_dcon: Replace flush_scheduled_work() with flush_work().

Uri Arev (1):
      staging: greybus: Fix indentation in fw-management.c

Xiang wangx (1):
      staging: rtl8192u: Fix syntax errors in comments

Yang Li (1):
      staging: r8188eu: remove unneeded semicolon

 Documentation/driver-api/vme.rst                   |    4 +-
 MAINTAINERS                                        |    5 +-
 arch/mips/configs/cavium_octeon_defconfig          |    2 +-
 drivers/Kconfig                                    |    2 -
 drivers/Makefile                                   |    1 -
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/fbtft/fb_ssd1351.c                 |    3 +-
 drivers/staging/fbtft/fbtft-core.c                 |    5 +-
 drivers/staging/greybus/audio_helper.c             |   14 +-
 drivers/staging/greybus/fw-management.c            |    6 +-
 drivers/staging/greybus/loopback.c                 |    2 +-
 drivers/staging/octeon-usb/Kconfig                 |   11 -
 drivers/staging/octeon-usb/Makefile                |    2 -
 drivers/staging/octeon-usb/TODO                    |    8 -
 drivers/staging/octeon/ethernet-rx.c               |    4 +-
 drivers/staging/olpc_dcon/olpc_dcon.c              |    7 +-
 drivers/staging/pi433/pi433_if.c                   |    2 +-
 drivers/staging/qlge/qlge_main.c                   |   40 +-
 drivers/staging/r8188eu/Makefile                   |    1 -
 drivers/staging/r8188eu/core/rtw_ap.c              |   23 +-
 drivers/staging/r8188eu/core/rtw_cmd.c             |   15 +-
 drivers/staging/r8188eu/core/rtw_efuse.c           |   61 +-
 drivers/staging/r8188eu/core/rtw_fw.c              |   78 +-
 drivers/staging/r8188eu/core/rtw_ieee80211.c       |    1 +
 drivers/staging/r8188eu/core/rtw_ioctl_set.c       |    1 -
 drivers/staging/r8188eu/core/rtw_iol.c             |    8 +-
 drivers/staging/r8188eu/core/rtw_led.c             |   43 +-
 drivers/staging/r8188eu/core/rtw_mlme.c            |    6 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c        |  464 +++--
 drivers/staging/r8188eu/core/rtw_p2p.c             |   13 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c         |   25 +-
 drivers/staging/r8188eu/core/rtw_recv.c            |   80 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c       |  145 +-
 drivers/staging/r8188eu/core/rtw_xmit.c            |   34 +-
 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c       |   45 -
 drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c |   33 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c       |   21 +-
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c         |  118 +-
 drivers/staging/r8188eu/hal/hal_com.c              |   66 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c         |   37 +-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c          |    6 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c    |  204 ++-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c      |   30 +-
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c       |    2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c          |  476 ++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c        |   33 +-
 drivers/staging/r8188eu/include/Hal8188EPwrSeq.h   |   13 -
 .../staging/r8188eu/include/Hal8188ERateAdaptive.h |   13 -
 drivers/staging/r8188eu/include/HalPwrSeqCmd.h     |   51 +-
 drivers/staging/r8188eu/include/basic_types.h      |   52 -
 drivers/staging/r8188eu/include/hal_com.h          |    3 -
 drivers/staging/r8188eu/include/hal_intf.h         |   20 +-
 drivers/staging/r8188eu/include/ieee80211.h        |    7 -
 drivers/staging/r8188eu/include/osdep_service.h    |    3 -
 drivers/staging/r8188eu/include/rtl8188e_hal.h     |    5 -
 drivers/staging/r8188eu/include/rtl8188e_spec.h    |  143 --
 drivers/staging/r8188eu/include/rtw_eeprom.h       |   10 -
 drivers/staging/r8188eu/include/rtw_efuse.h        |    2 -
 drivers/staging/r8188eu/include/rtw_io.h           |    8 +-
 drivers/staging/r8188eu/include/rtw_iol.h          |   24 +-
 drivers/staging/r8188eu/include/rtw_led.h          |    9 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h     |   19 +-
 drivers/staging/r8188eu/include/usb_ops_linux.h    |    2 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c       |   83 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c          |   19 +-
 drivers/staging/r8188eu/os_dep/osdep_service.c     |    8 -
 drivers/staging/r8188eu/os_dep/usb_intf.c          |    2 +-
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c     |    2 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c        |    2 +-
 drivers/staging/rtl8192e/rtllib_tx.c               |   24 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |   37 +-
 drivers/staging/rtl8192u/r8192U.h                  |    2 +-
 drivers/staging/rtl8192u/r8192U_dm.c               |   40 +-
 drivers/staging/rtl8192u/r8192U_dm.h               |    2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |    2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  225 +--
 drivers/staging/rts5208/spi.c                      |    6 +-
 drivers/staging/sm750fb/ddk750_dvi.c               |    2 +-
 drivers/staging/sm750fb/ddk750_power.h             |    2 +-
 drivers/staging/sm750fb/ddk750_sii164.c            |    6 +-
 drivers/staging/sm750fb/ddk750_sii164.h            |    2 +-
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |   40 +-
 .../include/linux/raspberrypi/vchiq.h              |   48 +-
 drivers/staging/vc04_services/interface/TESTING    |   82 +
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   96 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |    8 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |  106 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |   38 +-
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |   40 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |   63 +-
 drivers/staging/vme_user/Kconfig                   |   27 +
 drivers/staging/vme_user/Makefile                  |    3 +
 drivers/{vme => staging/vme_user}/vme.c            |    2 +-
 {include/linux => drivers/staging/vme_user}/vme.h  |    0
 drivers/{vme => staging/vme_user}/vme_bridge.h     |    2 +-
 .../{vme/bridges => staging/vme_user}/vme_fake.c   |    4 +-
 .../{vme/bridges => staging/vme_user}/vme_tsi148.c |    4 +-
 .../{vme/bridges => staging/vme_user}/vme_tsi148.h |    0
 drivers/staging/vme_user/vme_user.c                |    2 +-
 drivers/staging/vt6655/baseband.c                  |   10 +-
 drivers/staging/vt6655/card.c                      |  103 +-
 drivers/staging/vt6655/channel.c                   |    2 +-
 drivers/staging/vt6655/device_main.c               |   88 +-
 drivers/staging/vt6655/mac.c                       |   55 +-
 drivers/staging/vt6655/mac.h                       |  120 +-
 drivers/staging/vt6655/power.c                     |   25 +-
 drivers/staging/vt6655/rf.c                        |   20 +-
 drivers/staging/vt6655/rxtx.c                      |    6 +-
 drivers/staging/vt6655/srom.c                      |    2 +-
 drivers/staging/vt6655/upc.h                       |   35 -
 drivers/usb/host/Kconfig                           |   10 +
 drivers/usb/host/Makefile                          |    1 +
 .../{staging/octeon-usb => usb/host}/octeon-hcd.c  |    0
 .../{staging/octeon-usb => usb/host}/octeon-hcd.h  |    0
 drivers/vme/Kconfig                                |   18 -
 drivers/vme/Makefile                               |    8 -
 drivers/vme/boards/Kconfig                         |   10 -
 drivers/vme/boards/Makefile                        |    6 -
 drivers/vme/boards/vme_vmivme7805.c                |  106 --
 drivers/vme/boards/vme_vmivme7805.h                |   33 -
 drivers/vme/bridges/Kconfig                        |   24 -
 drivers/vme/bridges/Makefile                       |    4 -
 drivers/vme/bridges/vme_ca91cx42.c                 | 1928 --------------------
 drivers/vme/bridges/vme_ca91cx42.h                 |  579 ------
 125 files changed, 2059 insertions(+), 4739 deletions(-)
 delete mode 100644 drivers/staging/octeon-usb/Kconfig
 delete mode 100644 drivers/staging/octeon-usb/Makefile
 delete mode 100644 drivers/staging/octeon-usb/TODO
 delete mode 100644 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
 delete mode 100644 drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
 delete mode 100644 drivers/staging/r8188eu/include/basic_types.h
 create mode 100644 drivers/staging/vc04_services/interface/TESTING
 rename drivers/{vme => staging/vme_user}/vme.c (99%)
 rename {include/linux => drivers/staging/vme_user}/vme.h (100%)
 rename drivers/{vme => staging/vme_user}/vme_bridge.h (99%)
 rename drivers/{vme/bridges => staging/vme_user}/vme_fake.c (99%)
 rename drivers/{vme/bridges => staging/vme_user}/vme_tsi148.c (99%)
 rename drivers/{vme/bridges => staging/vme_user}/vme_tsi148.h (100%)
 delete mode 100644 drivers/staging/vt6655/upc.h
 rename drivers/{staging/octeon-usb => usb/host}/octeon-hcd.c (100%)
 rename drivers/{staging/octeon-usb => usb/host}/octeon-hcd.h (100%)
 delete mode 100644 drivers/vme/Kconfig
 delete mode 100644 drivers/vme/Makefile
 delete mode 100644 drivers/vme/boards/Kconfig
 delete mode 100644 drivers/vme/boards/Makefile
 delete mode 100644 drivers/vme/boards/vme_vmivme7805.c
 delete mode 100644 drivers/vme/boards/vme_vmivme7805.h
 delete mode 100644 drivers/vme/bridges/Kconfig
 delete mode 100644 drivers/vme/bridges/Makefile
 delete mode 100644 drivers/vme/bridges/vme_ca91cx42.c
 delete mode 100644 drivers/vme/bridges/vme_ca91cx42.h
