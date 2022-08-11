Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20238590724
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 21:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiHKTzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiHKTzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 15:55:17 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7135CB1E4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:55:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y141so17355925pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 12:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=H+iit096tbtYLAxfBBuXOSkmb5ZtfeBc5/8tyIt3JJ8=;
        b=mH1Hn0W7ql5H5xOYDNgWgZZBseez8btVDaYhzdh4EjCjUySkbs9XF40etf7wTSpvfi
         lKCNJLeh0Q3HwGk/cdsaDvEeQJmOOATztCWBbL/zJq5W5SpnBghSkSgHM6V5VulIsYbV
         L8jtLg/X6vFmDiNeSDe4ve5Sg+jrNeETHSSNC8LP+1bkGoBF1P7OsC6DMc8AVL0qhvum
         pSzKvQYI+DftSk9mE36MXmb4Cr5zwkjgdTPcoKPPhyAJICrDxEXD7cJjIcB67Ohwg5EG
         L3tlztrwUVGN6IhzIQn3sn3SxS8+TlOxj4FOf59sULT/xybWBtEVkFWOgITuwrVl68oB
         drPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=H+iit096tbtYLAxfBBuXOSkmb5ZtfeBc5/8tyIt3JJ8=;
        b=Fr0gSNjCW5u9rW9/geew4Q7nbftZ8csDgl8G2XU9EvWeqvEcG/mOkOUzjywHafzJ2p
         Wq+j/0a74EwyetsiynKTXJJWJhxOIZX54VsDTayZlsP4N6YHQhG+CKAlIkDV08XYHcxB
         obDzaoC5IJ+PcqVmxdSLrKa8qq+nMZ1gJOufBg6H6X/vht513vi5CzqK+YTU+4eoxjhN
         Zevh1cDAZ0o4dyleB46TKUmApwEUjpMQxA9ka2xDea0JOGw206wkuN5mFELP9es+LOWi
         RLtqQyAiI11tNAJd0CYI9f4hiBtWB+Taz6+vUlHvnA350XwnoqRjAxzJQ0NvKy5QcI2y
         /70A==
X-Gm-Message-State: ACgBeo3x3WB8Yi0QflJD2aRbTFLUliaHw+W8rGLsjOEHmejeOSbcUUgg
        kP8EeiKAqwc4PfR5zY9DDMk=
X-Google-Smtp-Source: AA6agR4WUh177NQMFRk012AkudTxHsZXgtMcJ3HJ0nNRrz5Y4dBUDCvGyiqz5U45pyEQFIIowP6ixg==
X-Received: by 2002:a63:d711:0:b0:415:c581:2aff with SMTP id d17-20020a63d711000000b00415c5812affmr479270pgg.278.1660247713822;
        Thu, 11 Aug 2022 12:55:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n34-20020a635c62000000b0041aa01c8bb0sm134474pgm.10.2022.08.11.12.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 12:55:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Aug 2022 12:55:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] amba: Remove deferred device addition
Message-ID: <20220811195234.GA4018948@roeck-us.net>
References: <CAGETcx_ATE6vy9YhygHnBA2P1GDVi54np-=E+50F+cwnj6Wg4A@mail.gmail.com>
 <0c6ef9a3-bbb1-9f1c-7f00-ceb05589594e@roeck-us.net>
 <CAGETcx8yKqEthtyd8Zb=mqMBNp1TPRXbQOoFp+OxeCoXnTs2kw@mail.gmail.com>
 <1196e002-c07d-44fd-b07a-aa5ae446ea0b@roeck-us.net>
 <YvQnbq2RhMOElQE3@google.com>
 <225747de-4348-58b3-19be-8b14356ab3a0@roeck-us.net>
 <CAGETcx895=9wPF+jnUfiycJ0k8d1S3BA0HLz42nCegtMBeo3LQ@mail.gmail.com>
 <971799be-8c15-fc81-ec71-bbca6483207d@roeck-us.net>
 <YvUzpSAQDktDPRbR@google.com>
 <YvVWEIn8veGL9Psa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvVWEIn8veGL9Psa@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_75_100 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 12:18:40PM -0700, Isaac Manjarres wrote:
> > 
> Hi Guenter,
> 
> I tried to reproduce the crash you reported in __clk_put() above with
> the information you mentioned, unfortunately I'm unable to reproduce this.
> I'm able to boot up with the command using the same baseline commit you had,
> along with my patch.
> 

Ah, it must be triggered by one of the configuration options I have enabled
on top of versatile_defconfig. Sorry, I should have checked. Please try
with the configuration below.

Guenter

---
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_SYSVIPC=y
CONFIG_NO_HZ_IDLE=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_NAMESPACES=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_EXPERT=y
# CONFIG_ARCH_MULTI_V7 is not set
CONFIG_ARCH_VERSATILE=y
CONFIG_AEABI=y
CONFIG_OABI_COMPAT=y
CONFIG_CMDLINE="root=1f03 mem=32M"
CONFIG_FPE_NWFPE=y
CONFIG_VFP=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_SLAB=y
CONFIG_CMA=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_INET_DIAG is not set
# CONFIG_IPV6 is not set
# CONFIG_WIRELESS is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_PM_QOS_KUNIT_TEST=y
CONFIG_MTD=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_CFI=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_BLK_DEV_RAM=y
CONFIG_VIRTIO_BLK=y
CONFIG_EEPROM_LEGACY=m
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_BLK_DEV_SR=y
CONFIG_SCSI_VIRTIO=y
CONFIG_NETDEVICES=y
CONFIG_VIRTIO_NET=y
CONFIG_SMC91X=y
CONFIG_USB_USBNET=y
# CONFIG_WLAN is not set
# CONFIG_SERIO_SERPORT is not set
CONFIG_SERIO_AMBAKMI=y
CONFIG_LEGACY_PTY_COUNT=16
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_AMBA_PL011=y
CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_VERSATILE=y
CONFIG_SPI=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_PL061=y
# CONFIG_HWMON is not set
CONFIG_DRM=y
CONFIG_DRM_PANEL_ARM_VERSATILE=y
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_PANEL_EDP=y
CONFIG_DRM_DISPLAY_CONNECTOR=y
CONFIG_DRM_SIMPLE_BRIDGE=y
CONFIG_DRM_PL111=y
CONFIG_FB=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_LOGO=y
CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_ARMAACI=m
CONFIG_HID_A4TECH=y
CONFIG_HID_APPLE=y
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CYPRESS=y
CONFIG_HID_EZKEY=y
CONFIG_HID_ITE=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_USB=y
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_STORAGE=y
CONFIG_USB_UAS=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_MMC=y
CONFIG_MMC_ARMMMCI=y
CONFIG_MMC_SDHCI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MMIO=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT4_KUNIT_TESTS=y
CONFIG_BTRFS_FS=y
CONFIG_ISO9660_FS=y
CONFIG_VFAT_FS=m
CONFIG_JFFS2_FS=y
CONFIG_CRAMFS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
CONFIG_MINIX_FS=y
CONFIG_ROMFS_FS=y
CONFIG_NFS_FS=y
CONFIG_ROOT_NFS=y
CONFIG_NFSD=y
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
CONFIG_CRC32_SELFTEST=y
CONFIG_GLOB_SELFTEST=y
CONFIG_DEBUG_INFO_DWARF5=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_KFENCE=y
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_WW_MUTEX_SELFTEST=y
CONFIG_DEBUG_LIST=y
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_USER=y
CONFIG_DEBUG_LL=y
CONFIG_KUNIT=y
CONFIG_KUNIT_TEST=y
CONFIG_TEST_SORT=y
CONFIG_RBTREE_TEST=y
CONFIG_INTERVAL_TREE_TEST=y
CONFIG_STRING_SELFTEST=y
CONFIG_TEST_BITMAP=y
CONFIG_TEST_UUID=y
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
CONFIG_RESOURCE_KUNIT_TEST=y
CONFIG_SYSCTL_KUNIT_TEST=y
CONFIG_LIST_KUNIT_TEST=y
CONFIG_CMDLINE_KUNIT_TEST=y
CONFIG_MEMCPY_KUNIT_TEST=y
