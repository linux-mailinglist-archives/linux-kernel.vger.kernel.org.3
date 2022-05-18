Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5952B736
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiERKAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiERKAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:00:31 -0400
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 May 2022 03:00:27 PDT
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639525C37E;
        Wed, 18 May 2022 03:00:26 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4L37lW4Kdzz9sbL;
        Wed, 18 May 2022 12:00:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.msdigital.de;
        s=MBO0001; t=1652868023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D34DYWzksfioVmYjqu6nUB7/+bJa7ZOqlOHYYb11HUc=;
        b=WlVCACB0Y7iKNTGIn9RFzzMdHtqqxjOnYBagmpYQkxEVg+iu6XiNwrn4QKUpwTtsJqDwEG
        8TnI3vekr61uFP3XrN5aGIknDB6vWxlt2VL/eQnkQadSVkNyQXwevPPJUeJnvH2JEzl90l
        NYwJ4lcRsp6TtCSBtIWnWmNHgm8FXRQ5q1j6hCUrg9trq+U6ynaU+UBOGNdzNm/xcgyciP
        OUo4awH1b7WcJAxeFuOwNnMoJ5vIq5iM+U/JfyTS7Eln36J0gy7PZLDRPwVTA8NAsAi6sN
        k9g4TxPYUKAXHPhnee5J1oO975tMafSbjuItkv3VaORyvEnufAT/vMwiMzpEEg==
Message-ID: <234059a9-0616-532f-bddc-1aec9759d024@mail.msdigital.de>
Date:   Wed, 18 May 2022 12:00:22 +0200
MIME-Version: 1.0
From:   Maximilian Senftleben <kernel@mail.msdigital.de>
Subject: Re: PROBLEM: No static MAC address for usb gadget ethernet via kernel
 parameter any more.
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <dfaa54ab-1b03-7aec-5927-d52a4233e56a@msdigital.de>
 <6c0eb462-3fab-473d-8989-b56e5748e5f7@mutex.one>
Content-Language: de-DE
In-Reply-To: <6c0eb462-3fab-473d-8989-b56e5748e5f7@mutex.one>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4L37lW4Kdzz9sbL
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- During debugging and testing we noticed that while 
"dev_set_mac_address" used to set "addr_assign_type" to NET_ADDR_SET, 
the mentioned commit directly sets "addr_assign_type" to NET_ADDR_RANDOM 
and the called "eth_hw_addr_set" does not modify the type afterwards.
If I change line 874 "net->addr_assign_type = NET_ADDR_RANDOM;" to 
"net->addr_assign_type = NET_ADDR_SET;" then the issue seems to be solved.


- Regarding bootargs and defconfig, we encountered the issue with our 
custom board and some own/modified drivers and additional patches, which 
might make it difficult to reproduce the issue outside of our setup.

bootargs:
"root=ubi0:userspace0 ubi.mtd=ubi_volumes rootfstype=ubifs 
consoleblank=0 vt.global_cursor_default=0 console=ttyS0 
g_ether.dev_addr=46:A2:73:A9:44:56 g_ether.host_addr=46:A2:73:A9:44:55"

defconfig:

CONFIG_KERNEL_XZ=y
CONFIG_SYSVIPC=y
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=18
CONFIG_CGROUPS=y
CONFIG_RELAY=y
CONFIG_BOOT_CONFIG=y
CONFIG_EXPERT=y
CONFIG_PERF_EVENTS=y
# CONFIG_SLUB_DEBUG is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_ARCH_MULTI_V6=y
CONFIG_ARCH_MXC=y
CONFIG_SOC_IMX6Q=y
# CONFIG_HARDEN_BRANCH_HISTORY is not set
CONFIG_ARM_ERRATA_814220=y
CONFIG_SMP=y
CONFIG_SCHED_MC=y
CONFIG_HAVE_ARM_ARCH_TIMER=y
CONFIG_HOTPLUG_CPU=y
CONFIG_ARM_PSCI=y
CONFIG_HIGHMEM=y
CONFIG_ZBOOT_ROM_TEXT=0
CONFIG_ZBOOT_ROM_BSS=0
CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
CONFIG_ARM_IMX6Q_CPUFREQ=y
CONFIG_CPU_IDLE=y
CONFIG_VFP=y
CONFIG_NEON=y
# CONFIG_SUSPEND is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_ACMEINC_SPI_CLRC663=y
# CONFIG_MXC_GPU_VIV is not set
CONFIG_U_DMA_BUF=y
CONFIG_MXC_VPU=y
CONFIG_WILC_SDIO=y
# CONFIG_SECCOMP is not set
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_MPTCP=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_EGRESS is not set
CONFIG_BRIDGE=y
CONFIG_CFG80211=y
# CONFIG_CFG80211_DEFAULT_PS is not set
CONFIG_CFG80211_DEBUGFS=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=y
CONFIG_MAC80211_DEBUGFS=y
CONFIG_RFKILL=y
CONFIG_RFKILL_INPUT=y
CONFIG_PCI=y
CONFIG_UEVENT_HELPER=y
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
CONFIG_EXTRA_FIRMWARE="mchp/wilc1000_wifi_firmware.bin 
imx/sdma/sdma-imx6q.bin vpu_fw_imx6d.bin brcm/brcmfmac43455-sdio.bin 
brcm/brcmfmac43455-sdio.acmeinc,imx6q-doorvision.txt vpu_fw_imx6q.bin"
CONFIG_EXTRA_FIRMWARE_DIR="drivers/base/firmware_loader/builtin"
CONFIG_IMX_WEIM=y
CONFIG_CONNECTOR=y
CONFIG_MTD=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_SST25L=y
CONFIG_MTD_RAW_NAND=y
CONFIG_MTD_NAND_GPMI_NAND=y
CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_BLOCK=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=65536
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set
CONFIG_BLK_DEV_SD=y
# CONFIG_BLK_DEV_BSG is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y
# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_NETDEVICES=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ASIX is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CIRRUS is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_ENGLEDER is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_FARADAY is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
# CONFIG_NET_VENDOR_HISILICON is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETERION is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VERTEXCOM is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
CONFIG_DP83867_PHY=y
CONFIG_USB_USBNET=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
# CONFIG_WLAN_VENDOR_ATH is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
CONFIG_BRCMFMAC=y
# CONFIG_WLAN_VENDOR_CISCO is not set
# CONFIG_WLAN_VENDOR_INTEL is not set
# CONFIG_WLAN_VENDOR_INTERSIL is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
# CONFIG_WLAN_VENDOR_MICROCHIP is not set
# CONFIG_WLAN_VENDOR_RALINK is not set
# CONFIG_WLAN_VENDOR_REALTEK is not set
# CONFIG_WLAN_VENDOR_RSI is not set
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
# CONFIG_WLAN_VENDOR_QUANTENNA is not set
CONFIG_INPUT_EVDEV=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_IMX=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_INPUT_MISC=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_IMX=y
CONFIG_SERIAL_IMX_CONSOLE=y
# CONFIG_SERIAL_IMX_EARLYCON is not set
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX_GPIO=y
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_IMX=y
CONFIG_SPI=y
CONFIG_SPI_FSL_QUADSPI=y
CONFIG_SPI_IMX=y
CONFIG_SPI_SPIDEV=y
CONFIG_PINCTRL_MICROCHIP_SGPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_MXC=y
CONFIG_GPIO_PCA953X=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_POWER_SUPPLY=y
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_IIO_HWMON=y
CONFIG_CPU_THERMAL=y
CONFIG_IMX_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=y
CONFIG_IMX2_WDT=y
CONFIG_MFD_RN5T618=y
CONFIG_REGULATOR=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_RN5T618=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
# CONFIG_DVB_NET is not set
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_VIDEO_MUX=y
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_CODA=y
CONFIG_VIDEO_IMX_PXP=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=y
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX415=y
CONFIG_IMX_IPUV3_CORE=y
CONFIG_DRM=y
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_LVDS_CODEC=y
CONFIG_DRM_IMX=y
CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
CONFIG_DRM_IMX_TVE=y
CONFIG_DRM_IMX_LDB=y
CONFIG_DRM_IMX_HDMI=y
CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_MXSFB=y
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_GPIO=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_PCI is not set
# CONFIG_SND_USB is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SPDIF=y
CONFIG_SND_IMX_SOC=y
CONFIG_SND_SOC_IMX_ZL38060=y
CONFIG_SND_SOC_FSL_ASOC_CARD=y
CONFIG_SND_SOC_TLV320AIC3X_I2C=y
CONFIG_SND_SIMPLE_CARD=y
CONFIG_SND_AUDIO_GRAPH_CARD=y
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_CHIPIDEA=y
CONFIG_USB_CHIPIDEA_UDC=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_NOP_USB_XCEIV=y
CONFIG_USB_MXS_PHY=y
CONFIG_USB_GADGET=y
CONFIG_USB_ETH=y
CONFIG_MMC=y
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_PLTFM=y
CONFIG_MMC_SDHCI_ESDHC_IMX=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_PWM=y
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_MXC=y
CONFIG_RTC_DRV_MXC_V2=y
CONFIG_RTC_DRV_SNVS=y
CONFIG_DMADEVICES=y
CONFIG_FSL_EDMA=y
CONFIG_IMX_SDMA=y
CONFIG_MXS_DMA=y
# CONFIG_VIRTIO_MENU is not set
CONFIG_STAGING=y
CONFIG_STAGING_MEDIA=y
CONFIG_VIDEO_IMX_MEDIA=y
CONFIG_COMMON_CLK_PWM=y
CONFIG_IMX_GPCV2_PM_DOMAINS=y
CONFIG_IIO=y
CONFIG_VF610_ADC=y
CONFIG_OPT3001=y
CONFIG_VCNL4000=y
CONFIG_VCNL4200=y
CONFIG_MPL3115=y
CONFIG_PWM=y
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_IMX27=y
CONFIG_RAS=y
CONFIG_NVMEM_IMX_OCOTP=y
CONFIG_NVMEM_SNVS_LPGPR=y
CONFIG_MUX_MMIO=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_WBUF_VERIFY=y
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_UBIFS_FS=y
CONFIG_SQUASHFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_ROOT_NFS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_UTF8=y
CONFIG_SECURITYFS=y
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DEV_FSL_CAAM=y
CONFIG_CRYPTO_DEV_SAHARA=y
CONFIG_CRC_CCITT=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CMA_SIZE_MBYTES=64
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_PRINTK_TIME=y
# CONFIG_DEBUG_BUGVERBOSE is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_FS=y
CONFIG_PANIC_TIMEOUT=1
# CONFIG_SCHED_DEBUG is not set
CONFIG_PROVE_LOCKING=y
# CONFIG_RCU_TRACE is not set
# CONFIG_FTRACE is not set




Am 17.05.2022 um 20:55 schrieb Marian Postevca:
> 12 May 2022 16:39:02 Maximilian Senftleben<kernel@mail.msdigital.de>:
>
>> [1.] One line summary of the problem:
>>
>> No static MAC address for usb gadget ethernet via kernel boot parameter any more.
>>
>> [2.] Full description of the problem/report:
>>
>> In 5.15. and before we were able to set a static MAC address for the usb gadget ethernet connection using kernel parameters "g_ether.dev_addr" and "g_ether.host_addr".
>> Since 5.16. and more concrete after commit 890d5b40908bfd1a79be018d2d297cf9df60f4ee, this is no longer possible, and a random MAC address is assigned.
>> (Possible Regression)
>>
>> [3.] Keywords (i.e., modules, networking, kernel):
>> usb, gadget, mac, g_ether
>>
>> [4.] Kernel information
>> [4.1.] Kernel version (from /proc/version):
>> Linux version 5.17.4-141174-ge11818a6ec02 (ms@local) (arm-v7a-linux-gnueabihf-gcc (OSELAS.Toolchain-2020.08.0 10-20200822) 10.2.1 20200822, GNU ld (GNU Binutils) 2.35) #14 SMP Thu May 12 13:51:50 CEST 2022
>> [4.2.] Kernel .config file:
>> -
> Could you please send the kernel .config file and kernel command line with which you reproduce this issue?
