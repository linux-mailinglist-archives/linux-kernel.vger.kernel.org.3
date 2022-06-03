Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA053C8E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbiFCKqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiFCKqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:46:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318513BBDA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 921B3B822A7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AFCC385A9;
        Fri,  3 Jun 2022 10:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654253155;
        bh=l7xU9sHt2+uiI3DBEOlQgIyjk5rsySi51pAgmlrtEaY=;
        h=Date:From:To:Cc:Subject:From;
        b=lVRsovnDNSYQUEQ97NUIH4Fueq8XCc5GU1f6gHJprnxd8LEGbrSiQtgV2Z94NAJvQ
         9Nat+5ID9T4v6eVgN/7zjEy7ec0b1dIIHcpGm75GqKizzNXaJLfW11tk8bLp2lSOtO
         fiEs19Jh4BRVV+DGKPTXKO8b566c0tLGndHFnWUI=
Date:   Fri, 3 Jun 2022 12:45:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver updates 5.19-rc1
Message-ID: <YpnmYB8SN5dPweLV@kroah.com>
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

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc1

for you to fetch changes up to 90de6805267f8c79cd2b1a36805071e257c39b5c:

  habanalabs: use separate structure info for each error collect data (2022-05-22 21:01:21 +0200)

----------------------------------------------------------------
Char / Misc / Other smaller driver subsystem updates for 5.19-rc1

Here is the large set of char, misc, and other driver subsystem updates
for 5.19-rc1.  The merge request for this has been delayed as I wanted
to get lots of linux-next testing due to some late arrivals of changes
for the habannalabs driver.

Highlights of this merge are:
	- habanalabs driver updates for new hardware types and fixes and
	  other updates
	- IIO driver tree merge which includes loads of new IIO drivers
	  and cleanups and additions
	- PHY driver tree merge with new drivers and small updates to
	  existing ones
	- interconnect driver tree merge with fixes and updates
	- soundwire driver tree merge with some small fixes
	- coresight driver tree merge with small fixes and updates
	- mhi bus driver tree merge with lots of updates and new device
	  support
	- firmware driver updates
	- fpga driver updates
	- lkdtm driver updates (with a merge conflict, more on that
	  below)
	- extcon driver tree merge with small updates
	- lots of other tiny driver updates and fixes and cleanups, full
	  details in the shortlog.

All of these have been in linux-next for almost 2 weeks with no reported
problems.

Note, there are 3 merge conflicts when merging this with your tree:
	- MAINTAINERS, should be easy to resolve
	- drivers/slimbus/qcom-ctrl.c, should be straightforward
	  resolution
	- drivers/misc/lkdtm/stackleak.c, not an easy resolution.  This
	  has been noted in the linux-next tree for a while, and
	  resolved there, here's a link to the resolution that Stephen
	  came up with and that Kees says is correct:
	  	https://lore.kernel.org/r/20220509185344.3fe1a354@canb.auug.org.au

I will be glad to provide a merge point that contains these resolutions
if that makes things any easier for you.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhyuday Godhasara (2):
      driver: soc: xilinx: Add support of multiple callbacks for same event in event management driver
      driver: soc: xilinx: Update function prototype for xlnx_unregister_event

Alexander Vorwerk (1):
      iio: core: fix a few code style issues

Alexandru Tachici (5):
      iio: adc: ad7124: Remove shift from scan_type
      iio: adc: ad7124: Add update_scan_mode
      iio: adc: ad7192: Add update_scan_mode
      iio: adc: ad7124: add sequencer support
      iio: adc: ad7192: add sequencer support

Andy Shevchenko (25):
      iio: dac: ltc2688: Use temporary variable for struct device
      iio: multiplexer: Make use of device properties
      iio: temperature: ltc2983: Don't hard code defined constants in messages
      iio: temperature: ltc2983: Use single error path to put OF node
      iio: temperature: ltc2983: Make use of device properties
      iio: imu: bmi160: Make use of device properties
      iio: dac: vf610: Drop dependency on OF
      iio: dac: lpc18xx: Drop dependency on OF
      iio: dac: dpot: Drop dependency on OF
      iio: afe: rescale: Make use of device properties
      iio: accel: dmard06: Drop dependency on OF
      iio: temperature: max31856: Make use of device properties
      iio: light: cm3605: Drop dependency on OF
      iio: magnetometer: ak8974: Drop dependency on OF
      iio: proximity: ping: Replace OF specific code by device_get_match_data()
      iio: light: tsl2772: Make use of device properties
      iio: core: Convert to use firmware node handle instead of OF node
      iio: gyro: mpu3050: Make use of device properties
      iio: gyro: fxas21002c: Make use of device properties
      iio: imu: adis16480: Make use of device properties
      iio: imu: adis16480: Use temporary variable for struct device
      iio: imu: adis16480: Improve getting the optional clocks
      iio: proximity: mb1232: Switch to use fwnode_irq_get()
      iio: temperature: max31865: Make use of device properties
      iio: dac: ltc2632: Make use of device properties

AngeloGioacchino Del Regno (2):
      phy: mediatek: phy-mtk-mipi-dsi: Simplify with dev_err_probe()
      phy: mediatek: phy-mtk-hdmi: Simplify with dev_err_probe()

Arnaud Ferraris (2):
      dt-bindings: iio: light: stk33xx: Add proximity-near-level
      iio: proximity: stk3310: Export near level property for proximity sensor

Aswath Govindraju (1):
      phy: phy-can-transceiver: Add support for setting mux

Bhaumik Bhatt (2):
      bus: mhi: host: Bail on writing register fields if read fails
      bus: mhi: host: Optimize and update MMIO register write method

Biju Das (2):
      dt-bindings: iio: adc: Document Renesas RZ/V2L ADC
      dt-bindings: phy: renesas,usb2-phy: Document RZ/G2UL phy bindings

Bjorn Andersson (7):
      dt-bindings: interconnect: qcom: Add sc8280xp binding
      interconnect: qcom: Add SC8280XP interconnect provider
      dt-bindings: interconnect: Add SC8180X QUP0 virt provider
      interconnect: qcom: sc8180x: Modernize sc8180x probe
      interconnect: qcom: sc8180x: Fix QUP0 nodes
      interconnect: qcom: sc8180x: Mark some BCMs keepalive
      interconnect: qcom: sc8180x: Reformat node and bcm definitions

Bruce Chen (1):
      extcon: usb-gpio: Remove disable irq operation in system sleep

Carlos Llamas (8):
      binder: hold fd_install until allocating fds first
      binder: add failed transaction logging info
      binder: add BINDER_GET_EXTENDED_ERROR ioctl
      binderfs: add extended_error feature entry
      binder: convert logging macros into functions
      binder: additional transaction error logs
      binder: fix printk format for commands
      binder: fix potential UAF of target_{proc,thread}

Christian Vogel (1):
      w1/ds2490: remove dump from ds_recv_status, pr_ to dev_XXX logging.

Christophe Leroy (1):
      lkdtm/bugs: Don't expect thread termination without CONFIG_UBSAN_TRAP

Cixi Geng (7):
      dt-bindings:iio:adc: add sprd,ump9620-adc dt-binding
      iio: adc: sc27xx: fix read big scale voltage not right
      iio: adc: sc27xx: Fine tune the scale calibration values
      iio: adc: sc27xx: structure adjustment and optimization
      iio: adc: sc27xx: refactor some functions for support more PMiCs
      iio: adc: sc27xx: add support for PMIC sc2720 and sc2721
      iio: adc: sc27xx: add support for PMIC sc2730

Colin Ian King (1):
      staging: iio: ad2s1210: remove redundant assignment to variable negative

Cristian Ciocaltea (1):
      scripts/tags.sh: Invoke 'realpath' via 'xargs'

Dafna Hirschfeld (6):
      habanalabs/gaudi: Use correct sram size macro for debugfs
      habanalabs: add callback and field to be used for debugfs refactor
      habanalabs: unify code for memory access from debugfs
      habanalabs: enforce alignment upon registers access through debugfs
      habanalabs: remove debugfs read/write callbacks
      habanalabs: add device memory scrub ability through debugfs

Dan Carpenter (2):
      soundwire: qcom: fix an error message in swrm_wait_for_frame_gen_enabled()
      extcon: Fix extcon_get_extcon_dev() error handling

Dani Liberman (2):
      habanalabs: use get_task_pid() to take PID
      habanalabs: handle race in driver fini

Daniele Palmas (2):
      bus: mhi: host: pci_generic: add Telit FN980 v1 hardware revision
      bus: mhi: host: pci_generic: add Telit FN990

Fabio M. De Francesco (3):
      binder: Use memset_page() in binder_alloc_clear_buf()
      binder: Use kmap_local_page() in binder_alloc_copy_user_to_buffer()
      binder: Use memcpy_{to,from}_page() in binder_alloc_do_buffer_copy()

Georgi Djakov (5):
      Merge branch 'icc-sc8280xp' into icc-next
      Merge branch 'icc-sdx65' into icc-next
      Merge branch 'icc-const' into icc-next
      Merge branch 'icc-sc8180x' into icc-next
      Merge branch 'icc-rpm' into icc-next

Greg Kroah-Hartman (12):
      Merge tag 'lkdtm-next' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into char-misc-next
      Merge 5.18-rc5 into char-misc-next
      Merge tag 'iio-for-5.19a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      Merge tag 'mhi-for-v5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-work-next
      Merge tag 'phy-for-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into char-work-next
      Merge tag 'soundwire-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire into char-misc-next
      Merge tag 'extcon-next-for-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      Merge tag 'coresight-next-v5.19' of gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux into char-misc-next
      Merge tag 'fpga-for-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next
      Merge tag 'lkdtm-next' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into char-misc-next
      Merge tag 'icc-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-next
      Revert "speakup: Generate speakupmap.h automatically"

Guilherme G. Piccoli (2):
      misc/pvpanic: Convert regular spinlock into trylock on panic path
      coresight: cpu-debug: Replace mutex with mutex_trylock on panic notifier

Guo Zhengkui (2):
      drivers/virt/fsl_hypervisor: remove unneeded `ret` variable in `fsl_hv_open()`
      drivers: comedi: replace ternary operator with min()

Gustavo A. R. Silva (1):
      extcon: usbc-cros-ec: Use struct_size() helper in kzalloc()

H. Nikolaus Schaller (1):
      iio: palmas: shut up warning about calibration mismatch (due to noise)

Hangyu Hua (1):
      char: xillybus: fix a refcount leak in cleanup_dev()

Hans de Goede (4):
      extcon: int3496: Make the driver a bit less verbose
      extcon: int3496: Request non-exclusive access to the ID GPIO
      extcon: int3496: Add support for binding to plain platform devices
      extcon: int3496: Add support for controlling Vbus through a regulator

Haowen Bai (1):
      tty: synclink_cs: Use bitwise instead of arithmetic operator for flags

Jakob Koschel (8):
      iio: buffer: remove usage of list iterator variable for list_for_each_entry_continue_reverse()
      iio: ssp_sensors: replace usage of found with dedicated list iterator variable
      iio: sysfs-trigger: replace usage of found with dedicated list iterator variable
      char: misc: remove usage of list iterator past the loop body
      misc: vmw_vmci: replace usage of found with dedicated list iterator variable
      char: xillybus: replace usage of found with dedicated list iterator variable
      misc: bcm-vk: replace usage of found with dedicated list iterator variable
      habanalabs: replace usage of found with dedicated list iterator variable

James Clark (15):
      coresight: etm4x: Cleanup TRCIDR0 register accesses
      coresight: etm4x: Cleanup TRCIDR2 register accesses
      coresight: etm4x: Cleanup TRCIDR3 register accesses
      coresight: etm4x: Cleanup TRCIDR4 register accesses
      coresight: etm4x: Cleanup TRCIDR5 register accesses
      coresight: etm4x: Cleanup TRCCONFIGR register accesses
      coresight: etm4x: Cleanup TRCEVENTCTL1R register accesses
      coresight: etm4x: Cleanup TRCSTALLCTLR register accesses
      coresight: etm4x: Cleanup TRCVICTLR register accesses
      coresight: etm3x: Cleanup ETMTECR1 register accesses
      coresight: etm4x: Cleanup TRCACATRn register accesses
      coresight: etm4x: Cleanup TRCSSCCRn and TRCSSCSRn register accesses
      coresight: etm4x: Cleanup TRCSSPCICRn register accesses
      coresight: etm4x: Cleanup TRCBBCTLR register accesses
      coresight: etm4x: Cleanup TRCRSCTLRn register accesses

Jason A. Donenfeld (1):
      /dev/mem: make reads and writes interruptible

Jeffrey Hugo (3):
      bus: mhi: host: Use cached values for calculating the shared write pointer
      bus: mhi: host: Add soc_reset sysfs
      bus: mhi: host: Wait for ready state after reset

Jiapeng Chong (2):
      phy: rockchip-inno-usb2: Clean up some inconsistent indenting
      altera-stapl: Use swap() instead of open coding it

Jiasheng Jiang (1):
      lkdtm/bugs: Check for the NULL pointer after calling kmalloc

Johan Hovold (6):
      phy: qcom-qmp: fix phy-descriptor kernel-doc typo
      phy: qcom-qmp: fix struct clk leak on probe errors
      phy: qcom-qmp: fix reset-controller leak on probe errors
      phy: qcom-qmp: switch to explicit reset helpers
      phy: qcom-qmp: fix pipe-clock imbalance on power-on failure
      phy: qcom-qmp: rename error labels

Jonathan Cameron (1):
      iio: accel: mma8452: Add missing documentation for name element of chip_info

Jules Maselbas (3):
      phy: core: Add documentation of phy operation order
      phy: core: Update documentation syntax
      phy: core: Warn when phy_power_on is called before phy_init

Kees Cook (9):
      lkdtm/heap: Note conditions for SLAB_LINEAR_OVERFLOW
      lkdtm/usercopy: Expand size of "out of frame" object
      lkdtm: Move crashtype definitions into each category
      lkdtm: Add CFI_BACKWARD to test ROP mitigations
      lkdtm: cfi: Fix type width for masking PAC bits
      lkdtm: cfi: Fix type width for masking PAC bits
      lkdtm/usercopy: Rename "heap" to "slab"
      lkdtm/usercopy: Check vmalloc and >0-order folios
      lkdtm/heap: Hide allocation size from -Warray-bounds

Krzysztof Kozlowski (11):
      interconnect: qcom: constify qcom_icc_desc
      interconnect: qcom: constify icc_node pointers
      interconnect: qcom: constify qcom_icc_bcm pointers
      nvmem: bcm-ocotp: mark ACPI device ID table as maybe unused
      nvmem: sunplus-ocotp: staticize sp_otp_v0
      nvmem: sunplus-ocotp: drop useless probe confirmation
      interconnect: qcom: sc8280xp: constify qcom_icc_desc
      interconnect: qcom: sc8280xp: constify icc_node pointers
      interconnect: qcom: sc8280xp: constify qcom_icc_bcm pointers
      iio: stmpe-adc: use of_device_id for OF matching
      iio: ti-ads8688: use of_device_id for OF matching

Kunihiko Hayashi (5):
      dt-bindings: phy: uniphier-usb2: Add vbus-supply
      dt-bindings: phy: uniphier-usb3ss: Treat vbus-supply as optional
      dt-bindings: phy: uniphier-ahci: Fix missing reset-names
      dt-bindings: phy: uniphier-usb3hs: Fix incorrect clock-names and reset-names
      dt-bindings: phy: uniphier: Clean up clocks, resets, and their names using compatible string

Lad Prabhakar (2):
      iio: adc: Kconfig: Make RZG2L_ADC depend on ARCH_RZG2L
      slimbus: qcom-ngd-ctrl: Use platform_get_irq() to get the interrupt

Lars-Peter Clausen (2):
      iio: adc: ad_sigma_delta: Add sequencer support
      iio: Replace strtobool() with kstrtobool()

Leo Yan (2):
      interconnect: qcom: icc-rpm: Fix for cached clock rate
      interconnect: qcom: icc-rpm: Cache every clock rate

Li Jun (2):
      extcon: ptn5150: Add queue work sync before driver release
      extcon: ptn5150: Add usb role class support

Liu Ying (4):
      phy: Add LVDS configuration options
      dt-bindings: phy: Convert mixel,mipi-dsi-phy to json-schema
      dt-bindings: phy: mixel: mipi-dsi-phy: Add Mixel combo PHY support for i.MX8qxp
      phy: freescale: phy-fsl-imx8-mipi-dphy: Add i.MX8qxp LVDS PHY mode support

Lorenzo Bianconi (3):
      MAINTAINERS: updated Lorenzo's email address
      iio: imu: st_lsm6dsx: add support to ASM330LHHX
      dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx device bindings

Luca Weiss (2):
      dt-bindings: phy: qcom,qmp: Add SM6350 UFS PHY bindings
      phy: qcom-qmp: Add SM6350 UFS PHY support

Manivannan Sadhasivam (38):
      bus: mhi: ep: Add support for registering MHI endpoint controllers
      bus: mhi: ep: Add support for registering MHI endpoint client drivers
      bus: mhi: ep: Add support for creating and destroying MHI EP devices
      bus: mhi: ep: Add support for managing MMIO registers
      bus: mhi: ep: Add support for ring management
      bus: mhi: ep: Add support for sending events to the host
      bus: mhi: ep: Add support for managing MHI state machine
      bus: mhi: ep: Add support for processing MHI endpoint interrupts
      bus: mhi: ep: Add support for powering up the MHI endpoint stack
      bus: mhi: ep: Add support for powering down the MHI endpoint stack
      bus: mhi: ep: Add support for handling MHI_RESET
      bus: mhi: ep: Add support for handling SYS_ERR condition
      bus: mhi: ep: Add support for processing command rings
      bus: mhi: ep: Add support for reading from the host
      bus: mhi: ep: Add support for processing channel rings
      bus: mhi: ep: Add support for queueing SKBs to the host
      bus: mhi: ep: Add support for suspending and resuming channels
      bus: mhi: ep: Add uevent support for module autoloading
      MAINTAINERS: Update Hemant's email id
      bus: mhi: host: pci_generic: Sort mhi_pci_id_table based on the PID
      bus: mhi: ep: Add support for registering MHI endpoint controllers
      bus: mhi: ep: Add support for registering MHI endpoint client drivers
      bus: mhi: ep: Add support for creating and destroying MHI EP devices
      bus: mhi: ep: Add support for managing MMIO registers
      bus: mhi: ep: Add support for ring management
      bus: mhi: ep: Add support for sending events to the host
      bus: mhi: ep: Add support for managing MHI state machine
      bus: mhi: ep: Add support for processing MHI endpoint interrupts
      bus: mhi: ep: Add support for powering up the MHI endpoint stack
      bus: mhi: ep: Add support for powering down the MHI endpoint stack
      bus: mhi: ep: Add support for handling MHI_RESET
      bus: mhi: ep: Add support for handling SYS_ERR condition
      bus: mhi: ep: Add support for processing command rings
      bus: mhi: ep: Add support for reading from the host
      bus: mhi: ep: Add support for processing channel rings
      bus: mhi: ep: Add support for queueing SKBs to the host
      bus: mhi: ep: Add support for suspending and resuming channels
      bus: mhi: ep: Add uevent support for module autoloading

Mao Jinlong (1):
      coresight: core: Fix coresight device probe failure issue

Marek Vasut (12):
      iio: core: Print error and fail iio_device_register() in case sample bits do not fit storage bits
      dt-bindings: iio: adc: ti,ads1015: Add missing ADS1115 compatible string
      dt-bindings: iio: adc: ti,ads1015: Add TLA2024 compatible string
      iio: adc: ti-ads1015: Switch to static const writeable ranges table
      iio: adc: ti-ads1015: Deduplicate channel macros
      iio: adc: ti-ads1015: Make channel event_spec optional
      iio: adc: ti-ads1015: Add TLA2024 support
      iio: adc: ti-ads1015: Add static assert to test if shifted realbits fit into storagebits
      iio: adc: ti-ads1015: Convert to OF match data
      iio: adc: ti-ads1015: Replace data_rate with chip data struct ads1015_data
      iio: adc: ti-ads1015: Switch to read_avail
      phy: freescale: imx8m-pcie: Handle IMX8_PCIE_REFCLK_PAD_UNUSED

Markuss Broks (3):
      dt-bindings: extcon: bindings for SM5703
      extcon: sm5502: Add support for SM5703
      extcon: sm5502: Clarify SM5703's i2c device ID

Matthew Gerlach (2):
      uio: dfl: add HSSI subsystem feature id
      fpga: dfl: Allow Port to be linked to FME's DFL

Maíra Canal (1):
      iio: adc: ad7266: convert probe to full device-managed

Miaoqian Lin (4):
      iio: adc: stmpe-adc: Fix wait_for_completion_timeout return value check
      iio: proximity: vl53l0x: Fix return value check of wait_for_completion_timeout
      slimbus: qcom: Fix IRQ check in qcom_slim_probe
      firmware: dmi-sysfs: Fix memory leak in dmi_sysfs_register_handle

Michael Srba (2):
      dt-bindings: iio: imu: mpu6050: Document invensense,icm20608d
      iio: imu: inv_mpu6050: Add support for ICM-20608-D

Minghao Chi (1):
      nvmem: qfprom: using pm_runtime_resume_and_get instead of pm_runtime_get_sync

Minghao Chi (CGEL ZTE) (2):
      phy/rockchip: Use of_device_get_match_data()
      phy/rockchip: Use of_device_get_match_data()

Miquel Raynal (13):
      iio: core: Enhance the kernel doc of modes and currentmodes iio_dev entries
      iio: magnetometer: rm3100: Stop abusing the ->currentmode
      iio: adc: stm32-dfsdm: Avoid dereferencing ->currentmode
      iio: st_sensors: Return as early as possible from the _write_raw() callbacks
      iio: st_sensors: Drop the protection on _avail functions
      iio: st_sensors: Add a local lock for protecting odr
      iio: st_sensors: Stop abusing mlock to ensure internal coherency
      iio: st_sensors: Use iio_device_claim/release_direct_mode() when relevant
      iio: Un-inline iio_buffer_enabled()
      iio: core: Hide read accesses to iio_dev->currentmode
      iio: core: Move the currentmode entry to the opaque structure
      iio: core: Simplify the registration of kfifo buffers
      iio: core: Clarify the modes

Moritz Fischer (1):
      MAINTAINERS: Update linux-fpga repository location

Moti Haimovski (1):
      habanalabs: support debugfs Byte access to device DRAM

Muhammad Usama Anjum (1):
      selftests/lkdtm: Add configs for stackleak and "after free" tests

Nadav Amit (1):
      vmw_balloon: Print errors on reset only once

Nava kishore Manne (4):
      fpga: fix for coding style issues
      fpga: fpga-mgr: fix kernel-doc warnings
      fpga: Use tab instead of space indentation
      fpga: fpga-region: fix kernel-doc formatting issues

Nuno Sá (2):
      dt-bindings: iio: dac: change ad3552r maintainer
      MAINTAINERS: add ad3552r

Oded Gabbay (7):
      habanalabs: remove redundant info print
      habanalabs: change a reset print to debug level
      habanalabs: don't print normal reset operations
      habanalabs: remove user interrupt debug print
      habanalabs: update firmware header
      habanalabs: use NULL for eventfd
      habanalabs: return -EFAULT on copy_to_user error

Ofir Bitton (6):
      habanalabs: add new return code to device fd open
      habanalabs: expose compute ctx status through info ioctl
      habanalabs/gaudi: increase submission resources
      habanalabs: parse full firmware versions
      habanalabs: save f/w preboot major version
      habanalabs/gaudi: set arbitration timeout to a high value

Ohad Sharabi (13):
      habanalabs: set non-0 value in dram default page size
      habanalabs: add DRAM default page size to HW info
      habanalabs: change mmu_get_real_page_size to be ASIC-specific
      habanalabs: convert all MMU masks/shifts to arrays
      habanalabs: add user API to get valid DRAM page sizes
      habanalabs: add MMU prefetch to ASIC-specific code
      habanalabs: rephrase device out-of-memory message
      habanalabs/gaudi: add debugfs to fetch internal sync status
      habanalabs: refactor HOP functions in MMU V1
      habanalabs: use for_each_sgtable_dma_sg for dma sgt
      habanalabs: add prefetch flag to the MAP operation
      habanalabs: do MMU prefetch as deferred work
      habanalabs: remove hdev from hl_ctx_get args

Paul Kocialkowski (2):
      dt-bindings: sun6i-a31-mipi-dphy: Add optional direction property
      phy: allwinner: phy-sun6i-mipi-dphy: Support D-PHY Rx mode for MIPI CSI-2

Paul Lemmermann (2):
      iio: accel: dmard09: fixed code styling issues
      iio: accel: kxsd9-spi: changed leading spaces to tabs

Pierre-Louis Bossart (9):
      soundwire: cadence: recheck device0 attachment after status change
      soundwire: intel: prevent pm_runtime resume prior to system suspend
      soundwire: intel: disable WAKEEN in pm_runtime resume
      soundwire: bus: pm_runtime_request_resume on peripheral attachment
      soundwire: qcom: return error when pm_runtime_get_sync fails
      soundwire: bus: use pm_runtime_resume_and_get()
      soundwire: cadence: use pm_runtime_resume_and_get()
      soundwire: intel: use pm_runtime_resume_and_get()
      soundwire: qcom: use pm_runtime_resume_and_get()

Puranjay Mohan (1):
      iio: accel: adxl355: use fwnode_irq_get_byname()

Rafał Miłecki (2):
      nvmem: core: support passing DT node in cell info
      nvmem: brcm_nvram: find Device Tree nodes for NVMEM cells

Rajaravi Krishna Katta (2):
      habanalabs: fix comments according to kernel-doc
      habanalabs/gaudi: use lower_32_bits() for casting

Ricky WU (1):
      misc: rtsx: add rts5261 efuse function

Rob Herring (2):
      dt-bindings: iio: Fix incorrect compatible strings in examples
      dt-bindings: phy: marvell,armada-3700-utmi-host-phy: Fix incorrect compatible in example

Robin Murphy (1):
      habanalabs: Stop using iommu_present()

Rohit Agarwal (4):
      dt-bindings: phy: qcom,qmp: Add SDX65 USB PHY binding
      phy: qcom-qmp: Add support for SDX65 QMP PHY
      dt-bindings: interconnect: Add Qualcomm SDX65 DT bindings
      interconnect: qcom: Add SDX65 interconnect provider driver

Ronak Jain (4):
      firmware: xilinx: add support for IOCTL and QUERY ID feature check
      firmware: xilinx: add new function for do_feature_check_call
      firmware: xilinx: always check API version for IOCTL/QUERY
      firmware: xilinx: enable feature check for ZynqMP

Samuel Holland (6):
      phy: rockchip-inno-usb2: Fix muxed interrupt support
      phy: rockchip-inno-usb2: Do not check bvalid twice
      phy: rockchip-inno-usb2: Do not lock in bvalid IRQ handler
      phy: rockchip-inno-usb2: Support multi-bit mask properties
      phy: rockchip-inno-usb2: Handle bvalid falling
      phy: rockchip-inno-usb2: Handle ID IRQ

Samuel Thibault (1):
      speakup: Generate speakupmap.h automatically

Schspa Shi (1):
      binder: fix atomic sleep when get extended error

Sean Anderson (6):
      dt-bindings: nvmem: sfp: Fix typo
      dt-bindings: nvmem: sfp: Add clock properties
      dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
      dt-bindings: nvmem: sfp: Add compatible binding for TA 2.1 SFPs
      nvmem: sfp: Use regmap
      nvmem: sfp: Add support for TA 2.1 devices

Shuah Khan (2):
      misc: rtsx: set NULL intfdata when probe fails
      misc: alcor_pci: set NULL intfdata and clear pci master

Sicelo A. Mhlongo (3):
      dt-bindings: iio: st,st-sensors add LIS302DL
      iio: accel: Remove unused enum in st_accel
      iio: accel: add support for LIS302DL variant

Slark Xiao (2):
      bus: mhi: host: Add support for Cinterion MV32-WA/MV32-WB
      bus: mhi: host: Add support for Foxconn T99W373 and T99W368

Srinivas Kandagatla (2):
      soundwire: qcom: adjust autoenumeration timeout
      misc: fastrpc: fix list iterator in fastrpc_req_mem_unmap_impl

Srinivasa Rao Mandadapu (2):
      soundwire: qcom: Add compatible name for v1.6.0
      dt-bindings: soundwire: qcom: Add bindings for audio clock reset control property

Stephen Boyd (1):
      dt-bindings: interconnect: Remove sc7180/sdx55 ipa compatibles

Sven Peter (3):
      MAINTAINERS: Add apple efuses nvmem files to ARM/APPLE MACHINE
      dt-bindings: nvmem: Add apple,efuses
      nvmem: Add Apple eFuse driver

Swapnil Jakhade (1):
      phy: cadence: Sierra: Add TI J721E specific PCIe multilink lane configuration

Tal Cohen (2):
      habanalabs: add support for notification via eventfd
      habanalabs: use separate structure info for each error collect data

Tianfei zhang (2):
      fpga: dfl: check feature type before parse irq info
      Documentation: fpga: dfl: add link address of feature id table

Tom Rix (1):
      accessiblity: speakup: cleanup comments

Tomer Tayar (2):
      habanalabs/gaudi: avoid resetting max power in hard reset
      habanalabs: modify dma_mask to be ASIC specific property

Tony Lindgren (1):
      bus: ti-sysc: Fix warnings for unbind for serial

Uwe Kleine-König (1):
      iio: gyro: mpu3050: Make mpu3050_common_remove() return void

Vishnu Dasa (1):
      VMCI: Add support for ARM64

Wan Jiabing (1):
      bus: mhi: replace snprintf with sysfs_emit

Wang Wensheng (1):
      soundwire: stream: Fix error return code in do_bank_switch()

Xiaoke Wang (1):
      iio: dummy: iio_simple_dummy: check the return value of kstrdup()

Xiaomeng Tong (2):
      misc: fastrpc: fix an incorrect NULL check on list iterator
      firmware: stratix10-svc: fix a missing check on list iterator

Yang Li (2):
      extcon: Fix some kernel-doc comments
      slimbus: qcom: Remove unnecessary print function dev_err()

Yang Yingliang (2):
      drivers: dio: add missing iounmap() in dio_init()
      edd: simplify the check of 'attr->test' in edd_populate_dir()

Yuri Nudelman (10):
      habanalabs: unified memory manager infrastructure
      habanalabs: convert ts to use unified memory manager
      habanalabs: wrong handle removal in memory manager
      habanalabs: hide memory manager page shift
      habanalabs: add put by handle method to memory manager
      habanalabs: unified memory manager new code for CB flow
      habanalabs: use unified memory manager for CB flow
      habanalabs: add topic to memory manager buffer
      habanalabs: order memory manager messages
      habanalabs: fix missing handle shift during mmap

Zheng Bin (1):
      accessiblity: speakup: Add missing misc_deregister in softsynth_probe

bumwoo lee (1):
      extcon: Modify extcon device to be created after driver data is set

farah kassabri (1):
      habanalabs: Add separate poll interval value for protocol

kernel test robot (1):
      habanalabs: hl_ts_behavior can be static

 Documentation/ABI/stable/sysfs-bus-mhi             |   10 +
 .../ABI/testing/debugfs-driver-habanalabs          |   38 +
 .../bindings/extcon/siliconmitus,sm5502-muic.yaml  |    5 +-
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml        |    3 +-
 .../bindings/iio/adc/sprd,sc2720-adc.yaml          |   60 +-
 .../devicetree/bindings/iio/adc/ti,ads1015.yaml    |    7 +-
 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |    2 +-
 .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml  |    2 +-
 .../bindings/iio/imu/invensense,mpu6050.yaml       |   34 +-
 .../devicetree/bindings/iio/imu/st,lsm6dsx.yaml    |   38 +-
 .../devicetree/bindings/iio/light/stk33xx.yaml     |    6 +
 .../iio/potentiometer/microchip,mcp4131.yaml       |    2 +-
 .../devicetree/bindings/iio/st,st-sensors.yaml     |    1 +
 .../bindings/interconnect/qcom,rpmh.yaml           |   18 +-
 .../devicetree/bindings/nvmem/apple,efuses.yaml    |   50 +
 .../bindings/nvmem/fsl,layerscape-sfp.yaml         |   30 +-
 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml         |   12 +
 .../bindings/phy/marvell,armada-3700-utmi-phy.yaml |    2 +-
 .../devicetree/bindings/phy/mixel,mipi-dsi-phy.txt |   29 -
 .../bindings/phy/mixel,mipi-dsi-phy.yaml           |  107 +
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |    4 +
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  |    1 +
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |   91 +-
 .../bindings/phy/socionext,uniphier-pcie-phy.yaml  |   47 +-
 .../bindings/phy/socionext,uniphier-usb2-phy.yaml  |    3 +
 .../phy/socionext,uniphier-usb3hs-phy.yaml         |   89 +-
 .../phy/socionext,uniphier-usb3ss-phy.yaml         |   98 +-
 .../devicetree/bindings/soundwire/qcom,sdw.txt     |   14 +
 Documentation/fpga/dfl.rst                         |    5 +
 MAINTAINERS                                        |   18 +-
 drivers/accessibility/speakup/fakekey.c            |    4 +-
 drivers/accessibility/speakup/serialio.c           |    2 +-
 drivers/accessibility/speakup/speakup_acntpc.c     |    2 +-
 drivers/accessibility/speakup/speakup_acntsa.c     |    2 +-
 drivers/accessibility/speakup/speakup_apollo.c     |    2 +-
 drivers/accessibility/speakup/speakup_audptr.c     |    2 +-
 drivers/accessibility/speakup/speakup_bns.c        |    2 +-
 drivers/accessibility/speakup/speakup_decext.c     |    2 +-
 drivers/accessibility/speakup/speakup_dectlk.c     |    2 +-
 drivers/accessibility/speakup/speakup_dtlk.c       |    2 +-
 drivers/accessibility/speakup/speakup_dummy.c      |    2 +-
 drivers/accessibility/speakup/speakup_keypc.c      |    2 +-
 drivers/accessibility/speakup/speakup_ltlk.c       |    2 +-
 drivers/accessibility/speakup/speakup_soft.c       |    3 +-
 drivers/accessibility/speakup/speakup_spkout.c     |    2 +-
 drivers/accessibility/speakup/speakup_txprt.c      |    2 +-
 drivers/android/binder.c                           |  197 +-
 drivers/android/binder_alloc.c                     |   22 +-
 drivers/android/binder_internal.h                  |    5 +
 drivers/android/binderfs.c                         |    8 +
 drivers/bus/mhi/Kconfig                            |    1 +
 drivers/bus/mhi/Makefile                           |    3 +
 drivers/bus/mhi/common.h                           |   22 +
 drivers/bus/mhi/ep/Kconfig                         |   10 +
 drivers/bus/mhi/ep/Makefile                        |    2 +
 drivers/bus/mhi/ep/internal.h                      |  218 ++
 drivers/bus/mhi/ep/main.c                          | 1591 +++++++++++++
 drivers/bus/mhi/ep/mmio.c                          |  273 +++
 drivers/bus/mhi/ep/ring.c                          |  207 ++
 drivers/bus/mhi/ep/sm.c                            |  148 ++
 drivers/bus/mhi/host/boot.c                        |   22 +-
 drivers/bus/mhi/host/init.c                        |   89 +-
 drivers/bus/mhi/host/internal.h                    |    7 +-
 drivers/bus/mhi/host/main.c                        |   18 +-
 drivers/bus/mhi/host/pci_generic.c                 |  133 +-
 drivers/bus/mhi/host/pm.c                          |   24 +-
 drivers/bus/ti-sysc.c                              |    4 +-
 drivers/char/mem.c                                 |    2 +-
 drivers/char/misc.c                                |   24 +-
 drivers/char/pcmcia/synclink_cs.c                  |    2 +-
 drivers/char/xillybus/xillybus_class.c             |   26 +-
 drivers/char/xillybus/xillyusb.c                   |    1 +
 drivers/comedi/drivers.c                           |    2 +-
 drivers/dio/dio.c                                  |    5 +-
 drivers/extcon/Kconfig                             |    3 +-
 drivers/extcon/extcon-axp288.c                     |    4 +-
 drivers/extcon/extcon-intel-int3496.c              |   54 +-
 drivers/extcon/extcon-ptn5150.c                    |   36 +
 drivers/extcon/extcon-sm5502.c                     |    2 +
 drivers/extcon/extcon-usb-gpio.c                   |   15 -
 drivers/extcon/extcon-usbc-cros-ec.c               |    2 +-
 drivers/extcon/extcon.c                            |   37 +-
 drivers/firmware/dmi-sysfs.c                       |    2 +-
 drivers/firmware/edd.c                             |    3 +-
 drivers/firmware/stratix10-svc.c                   |   12 +-
 drivers/firmware/xilinx/zynqmp.c                   |  131 +-
 drivers/fpga/Makefile                              |    6 +-
 drivers/fpga/dfl-pci.c                             |    9 +
 drivers/fpga/dfl.c                                 |   38 +-
 drivers/fpga/dfl.h                                 |    1 +
 drivers/fpga/fpga-mgr.c                            |   13 +-
 drivers/fpga/fpga-region.c                         |    6 +-
 drivers/fpga/of-fpga-region.c                      |   22 +-
 drivers/hwtracing/coresight/coresight-core.c       |   33 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |    7 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c |    2 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |    2 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  136 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  180 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |  120 +-
 drivers/iio/accel/Kconfig                          |    1 -
 drivers/iio/accel/adxl355_core.c                   |    7 +-
 drivers/iio/accel/adxl367.c                        |    1 -
 drivers/iio/accel/bmc150-accel-core.c              |    4 +-
 drivers/iio/accel/dmard09.c                        |    2 +-
 drivers/iio/accel/fxls8962af-core.c                |    1 -
 drivers/iio/accel/kxsd9-spi.c                      |    4 +-
 drivers/iio/accel/mma8452.c                        |    1 +
 drivers/iio/accel/sca3000.c                        |    1 -
 drivers/iio/accel/ssp_accel_sensor.c               |    1 -
 drivers/iio/accel/st_accel.h                       |   28 +-
 drivers/iio/accel/st_accel_core.c                  |   14 +-
 drivers/iio/accel/st_accel_i2c.c                   |    5 +
 drivers/iio/accel/st_accel_spi.c                   |    5 +
 drivers/iio/adc/Kconfig                            |    2 +-
 drivers/iio/adc/ad7124.c                           |   86 +-
 drivers/iio/adc/ad7192.c                           |   68 +-
 drivers/iio/adc/ad7266.c                           |   44 +-
 drivers/iio/adc/ad7280a.c                          |    2 +-
 drivers/iio/adc/ad_sigma_delta.c                   |  143 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |    4 +-
 drivers/iio/adc/ina2xx-adc.c                       |    3 +-
 drivers/iio/adc/palmas_gpadc.c                     |    3 +-
 drivers/iio/adc/sc27xx_adc.c                       |  470 +++-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |    5 +-
 drivers/iio/adc/stmpe-adc.c                        |   21 +-
 drivers/iio/adc/ti-ads1015.c                       |  398 ++--
 drivers/iio/adc/ti-ads8688.c                       |    1 +
 drivers/iio/adc/ti_am335x_adc.c                    |    4 +-
 drivers/iio/afe/Kconfig                            |    1 -
 drivers/iio/afe/iio-rescale.c                      |    5 +-
 drivers/iio/buffer/kfifo_buf.c                     |   10 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |    5 +-
 drivers/iio/common/scmi_sensors/scmi_iio.c         |    1 -
 drivers/iio/common/ssp_sensors/ssp_spi.c           |   13 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |   50 +-
 drivers/iio/dac/Kconfig                            |    4 +-
 drivers/iio/dac/ad5064.c                           |    2 +-
 drivers/iio/dac/ad5360.c                           |    2 +-
 drivers/iio/dac/ad5380.c                           |    2 +-
 drivers/iio/dac/ad5446.c                           |    2 +-
 drivers/iio/dac/ad5504.c                           |    2 +-
 drivers/iio/dac/ad5624r_spi.c                      |    2 +-
 drivers/iio/dac/ad5686.c                           |    2 +-
 drivers/iio/dac/ad5755.c                           |    2 +-
 drivers/iio/dac/ad5791.c                           |    2 +-
 drivers/iio/dac/ad7303.c                           |    2 +-
 drivers/iio/dac/ltc2632.c                          |    8 +-
 drivers/iio/dac/ltc2688.c                          |   19 +-
 drivers/iio/dac/max5821.c                          |    2 +-
 drivers/iio/dac/mcp4725.c                          |    4 +-
 drivers/iio/dac/stm32-dac.c                        |    2 +-
 drivers/iio/dac/ti-dac082s085.c                    |    2 +-
 drivers/iio/dac/ti-dac5571.c                       |    2 +-
 drivers/iio/dac/ti-dac7311.c                       |    2 +-
 drivers/iio/dummy/iio_simple_dummy.c               |   20 +-
 drivers/iio/frequency/ad9523.c                     |    2 +-
 drivers/iio/gyro/fxas21002c_core.c                 |    8 +-
 drivers/iio/gyro/mpu3050-core.c                    |   14 +-
 drivers/iio/gyro/mpu3050-i2c.c                     |    4 +-
 drivers/iio/gyro/mpu3050.h                         |    2 +-
 drivers/iio/gyro/ssp_gyro_sensor.c                 |    1 -
 drivers/iio/gyro/st_gyro_core.c                    |   15 +-
 drivers/iio/health/max30100.c                      |    1 -
 drivers/iio/health/max30102.c                      |    1 -
 drivers/iio/imu/adis16480.c                        |   91 +-
 drivers/iio/imu/bmi160/bmi160_core.c               |   27 +-
 drivers/iio/imu/bmi160/bmi160_i2c.c                |   13 +-
 drivers/iio/imu/bmi160/bmi160_spi.c                |   18 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |    1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |    1 -
 drivers/iio/imu/inv_mpu6050/Kconfig                |    4 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |    9 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    6 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |    2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    5 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    6 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |    4 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |    6 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    5 +
 drivers/iio/industrialio-buffer.c                  |   42 +-
 drivers/iio/industrialio-core.c                    |   46 +-
 drivers/iio/industrialio-event.c                   |    2 +-
 drivers/iio/industrialio-trigger.c                 |    2 +-
 drivers/iio/light/Kconfig                          |    1 -
 drivers/iio/light/apds9960.c                       |    1 -
 drivers/iio/light/stk3310.c                        |   25 +
 drivers/iio/light/tsl2772.c                        |   25 +-
 drivers/iio/magnetometer/Kconfig                   |    1 -
 drivers/iio/magnetometer/rm3100-core.c             |   15 +-
 drivers/iio/magnetometer/st_magn_core.c            |   15 +-
 drivers/iio/multiplexer/Kconfig                    |    1 -
 drivers/iio/multiplexer/iio-mux.c                  |   49 +-
 drivers/iio/pressure/st_pressure_core.c            |    8 +-
 drivers/iio/proximity/mb1232.c                     |    8 +-
 drivers/iio/proximity/ping.c                       |    5 +-
 drivers/iio/proximity/vl53l0x-i2c.c                |    7 +-
 drivers/iio/temperature/ltc2983.c                  |  236 +-
 drivers/iio/temperature/max31856.c                 |    6 +-
 drivers/iio/temperature/max31865.c                 |    4 +-
 drivers/iio/trigger/iio-trig-sysfs.c               |   11 +-
 drivers/interconnect/qcom/Kconfig                  |   18 +
 drivers/interconnect/qcom/Makefile                 |    4 +
 drivers/interconnect/qcom/icc-rpm.c                |   16 +-
 drivers/interconnect/qcom/icc-rpm.h                |    6 +-
 drivers/interconnect/qcom/icc-rpmh.c               |    2 +-
 drivers/interconnect/qcom/icc-rpmh.h               |    6 +-
 drivers/interconnect/qcom/msm8916.c                |   12 +-
 drivers/interconnect/qcom/msm8939.c                |   16 +-
 drivers/interconnect/qcom/msm8974.c                |   28 +-
 drivers/interconnect/qcom/msm8996.c                |   16 +-
 drivers/interconnect/qcom/osm-l3.c                 |   16 +-
 drivers/interconnect/qcom/qcm2290.c                |   24 +-
 drivers/interconnect/qcom/qcs404.c                 |   12 +-
 drivers/interconnect/qcom/sc7180.c                 |   66 +-
 drivers/interconnect/qcom/sc7280.c                 |   72 +-
 drivers/interconnect/qcom/sc8180x.c                | 1895 ++++++++++++---
 drivers/interconnect/qcom/sc8180x.h                |    7 +
 drivers/interconnect/qcom/sc8280xp.c               | 2438 ++++++++++++++++++++
 drivers/interconnect/qcom/sc8280xp.h               |  209 ++
 drivers/interconnect/qcom/sdm660.c                 |   24 +-
 drivers/interconnect/qcom/sdm845.c                 |   32 +-
 drivers/interconnect/qcom/sdx55.c                  |   12 +-
 drivers/interconnect/qcom/sdx65.c                  |  231 ++
 drivers/interconnect/qcom/sdx65.h                  |   65 +
 drivers/interconnect/qcom/sm8150.c                 |   66 +-
 drivers/interconnect/qcom/sm8250.c                 |   66 +-
 drivers/interconnect/qcom/sm8350.c                 |   60 +-
 drivers/interconnect/qcom/sm8450.c                 |   68 +-
 drivers/misc/altera-stapl/altera.c                 |   56 +-
 drivers/misc/bcm-vk/bcm_vk_msg.c                   |   29 +-
 drivers/misc/cardreader/alcor_pci.c                |    6 +-
 drivers/misc/cardreader/rts5261.c                  |  115 +-
 drivers/misc/cardreader/rtsx_usb.c                 |    1 +
 drivers/misc/fastrpc.c                             |   18 +-
 drivers/misc/habanalabs/common/Makefile            |    2 +-
 drivers/misc/habanalabs/common/command_buffer.c    |  413 ++--
 .../misc/habanalabs/common/command_submission.c    |   89 +-
 drivers/misc/habanalabs/common/context.c           |    4 +-
 drivers/misc/habanalabs/common/debugfs.c           |  304 ++-
 drivers/misc/habanalabs/common/device.c            |  280 ++-
 drivers/misc/habanalabs/common/firmware_if.c       |   86 +-
 drivers/misc/habanalabs/common/habanalabs.h        |  415 ++--
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   44 +-
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |  108 +-
 drivers/misc/habanalabs/common/irq.c               |   14 +-
 drivers/misc/habanalabs/common/memory.c            |  289 +--
 drivers/misc/habanalabs/common/memory_mgr.c        |  349 +++
 drivers/misc/habanalabs/common/mmu/mmu.c           |  296 +--
 drivers/misc/habanalabs/common/mmu/mmu_v1.c        |  297 +--
 drivers/misc/habanalabs/common/pci/pci.c           |   10 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              |  412 +---
 drivers/misc/habanalabs/gaudi/gaudiP.h             |    4 +-
 drivers/misc/habanalabs/goya/goya.c                |  363 +--
 drivers/misc/habanalabs/include/common/cpucp_if.h  |   70 +-
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |   10 +
 drivers/misc/lkdtm/bugs.c                          |   96 +-
 drivers/misc/lkdtm/cfi.c                           |  145 +-
 drivers/misc/lkdtm/core.c                          |  138 +-
 drivers/misc/lkdtm/fortify.c                       |   17 +-
 drivers/misc/lkdtm/heap.c                          |   48 +-
 drivers/misc/lkdtm/lkdtm.h                         |  142 +-
 drivers/misc/lkdtm/perms.c                         |   47 +-
 drivers/misc/lkdtm/powerpc.c                       |   11 +-
 drivers/misc/lkdtm/refcount.c                      |   65 +-
 drivers/misc/lkdtm/stackleak.c                     |   11 +-
 drivers/misc/lkdtm/usercopy.c                      |  146 +-
 drivers/misc/pvpanic/pvpanic.c                     |   10 +-
 drivers/misc/vmw_balloon.c                         |    4 +-
 drivers/misc/vmw_vmci/Kconfig                      |    2 +-
 drivers/misc/vmw_vmci/vmci_context.c               |   15 +-
 drivers/misc/vmw_vmci/vmci_guest.c                 |    4 +
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |   12 +
 drivers/nvmem/Kconfig                              |   13 +
 drivers/nvmem/Makefile                             |    2 +
 drivers/nvmem/apple-efuses.c                       |   80 +
 drivers/nvmem/bcm-ocotp.c                          |    2 +-
 drivers/nvmem/brcm_nvram.c                         |    2 +
 drivers/nvmem/core.c                               |    1 +
 drivers/nvmem/layerscape-sfp.c                     |   36 +-
 drivers/nvmem/qfprom.c                             |    3 +-
 drivers/nvmem/sunplus-ocotp.c                      |    4 +-
 drivers/phy/Kconfig                                |    1 +
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c        |  166 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |  193 +-
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c     |  276 ++-
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c         |   10 +-
 drivers/phy/mediatek/phy-mtk-hdmi.c                |   50 +-
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c            |   29 +-
 drivers/phy/phy-can-transceiver.c                  |   24 +-
 drivers/phy/phy-core.c                             |   44 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  124 +-
 drivers/phy/rockchip/phy-rockchip-dphy-rx0.c       |    7 +-
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |  129 +-
 drivers/phy/rockchip/phy-rockchip-typec.c          |    6 +-
 drivers/power/supply/axp288_charger.c              |   17 +-
 drivers/power/supply/charger-manager.c             |    7 +-
 drivers/power/supply/max8997_charger.c             |    8 +-
 drivers/slimbus/qcom-ctrl.c                        |    6 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    |   10 +-
 drivers/soc/xilinx/xlnx_event_manager.c            |  203 +-
 drivers/soc/xilinx/zynqmp_power.c                  |    7 +-
 drivers/soundwire/bus.c                            |   27 +-
 drivers/soundwire/cadence_master.c                 |   42 +-
 drivers/soundwire/intel.c                          |   11 +-
 drivers/soundwire/qcom.c                           |   22 +-
 drivers/soundwire/stream.c                         |    1 +
 drivers/staging/iio/cdc/ad7746.c                   |    2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    1 -
 drivers/staging/iio/resolver/ad2s1210.c            |    1 -
 drivers/uio/uio_dfl.c                              |    2 +
 drivers/usb/dwc3/drd.c                             |    9 +-
 drivers/usb/phy/phy-omap-otg.c                     |    4 +-
 drivers/usb/typec/tcpm/fusb302.c                   |    4 +-
 drivers/virt/fsl_hypervisor.c                      |    3 +-
 drivers/w1/masters/ds2490.c                        |  124 +-
 include/dt-bindings/interconnect/qcom,sc8180x.h    |    7 +
 include/dt-bindings/interconnect/qcom,sc8280xp.h   |  232 ++
 include/dt-bindings/interconnect/qcom,sdx65.h      |   67 +
 include/linux/extcon.h                             |    2 +-
 include/linux/firmware/xlnx-event-manager.h        |    4 +-
 include/linux/firmware/xlnx-zynqmp.h               |   11 +
 include/linux/fpga/fpga-region.h                   |    6 +-
 include/linux/iio/adc/ad_sigma_delta.h             |   38 +
 include/linux/iio/common/st_sensors.h              |    3 +
 include/linux/iio/iio-opaque.h                     |    4 +
 include/linux/iio/iio.h                            |   70 +-
 include/linux/iio/kfifo_buf.h                      |    5 +-
 include/linux/mhi_ep.h                             |  277 +++
 include/linux/mod_devicetable.h                    |    2 +
 include/linux/nvmem-consumer.h                     |    1 +
 include/linux/phy/phy-lvds.h                       |   32 +
 include/linux/phy/phy.h                            |    4 +
 include/linux/rtsx_pci.h                           |    3 +
 include/uapi/linux/android/binder.h                |   16 +
 include/uapi/misc/habanalabs.h                     |   87 +-
 scripts/mod/file2alias.c                           |   10 +
 scripts/tags.sh                                    |   11 +-
 .../selftests/filesystems/binderfs/binderfs_test.c |    1 +
 tools/testing/selftests/lkdtm/config               |    4 +
 tools/testing/selftests/lkdtm/tests.txt            |    9 +-
 343 files changed, 15534 insertions(+), 4634 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.yaml
 create mode 100644 drivers/bus/mhi/ep/Kconfig
 create mode 100644 drivers/bus/mhi/ep/Makefile
 create mode 100644 drivers/bus/mhi/ep/internal.h
 create mode 100644 drivers/bus/mhi/ep/main.c
 create mode 100644 drivers/bus/mhi/ep/mmio.c
 create mode 100644 drivers/bus/mhi/ep/ring.c
 create mode 100644 drivers/bus/mhi/ep/sm.c
 create mode 100644 drivers/interconnect/qcom/sc8280xp.c
 create mode 100644 drivers/interconnect/qcom/sc8280xp.h
 create mode 100644 drivers/interconnect/qcom/sdx65.c
 create mode 100644 drivers/interconnect/qcom/sdx65.h
 create mode 100644 drivers/misc/habanalabs/common/memory_mgr.c
 create mode 100644 drivers/nvmem/apple-efuses.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sc8280xp.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx65.h
 create mode 100644 include/linux/mhi_ep.h
 create mode 100644 include/linux/phy/phy-lvds.h
