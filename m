Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C078158A2AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiHDVIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiHDVIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:08:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF85B6FA2C;
        Thu,  4 Aug 2022 14:08:20 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a89so1187071edf.5;
        Thu, 04 Aug 2022 14:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=9Fx/r6gG45RdaUEXtZvdtTR0qBKogKkCa14b5WLRWyY=;
        b=cOmHl2UAO+D+20hRsGYqUKoONVJrXAsH+F4x4KCnqpcDDUd/DdI3w4TDsD0jdv/1fa
         +UNpmslIrY+Ef1FRa8vd3/DHj8nmTdAiGVYBlzbpuQnxAQOEETXDJFaiwAazQ3GVs/Jw
         LfUIoIj6vkqNOkE/NgjhKt17YQGLatbS2JyoWKtpHK3rbFzHXVoP7IVRenhsDE9uAm7Z
         t2CJ8bXdsbCx2a9WKUtxST5wFagJ3BiXUdqoS9NP85nKsROZRrYSKAQrKMqLxu4G3ZET
         YUr5vqJ4Gqy165XCOEO+cVeu8tqY+pT181EVVWiDnN58rVjXCJFOOEEzlLLQ3HOLdXj+
         cRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9Fx/r6gG45RdaUEXtZvdtTR0qBKogKkCa14b5WLRWyY=;
        b=RylkkcJx41taOieT74hbRKj4riKHctaZ6IY85xa6rWBaHzQGQxprC/8+P+Yeyt7gm/
         BOgTdBZTTu6E1PEHRMZ7RT5USi0jLBDRzDDxkvoCqnNS+Vsju/wum4ejlLB1guMKsGNP
         iv3+bXKbbzo/M4LJcFB7YisNIbgeqNkeoPIcDH++tnb8qm+V3+zIOCuTTZvwcP/GgI9c
         043eahIVAIi2wkoYI4fxV5kjK2UAVXiKBVgSiKqU6NmEZCVZNhVwHG1+6RU7DLveKxGY
         RdyX11kHshfniVkCOGC0tJfFzRSdUrLbQoeyh2WpwLTTkuK+kAMhjRi1F22dZ3Ja6hW+
         DzqQ==
X-Gm-Message-State: ACgBeo0kKhlCMCqKxw/3Z+gfxmzqYHsPlo5Z4DONDthANtbWQODRbqEI
        BJQMUX3KN3cwqKpUXet7fNKzfEBORHHnag==
X-Google-Smtp-Source: AA6agR7a/bbQGu2hbyROFfNcIvPGJhZEl+WD2hdxoXGYw1XI0gQnAiyofgcxrEhBmR9g+xfcMaf+hg==
X-Received: by 2002:a05:6402:1389:b0:43a:ceea:93fd with SMTP id b9-20020a056402138900b0043aceea93fdmr3805027edv.64.1659647299265;
        Thu, 04 Aug 2022 14:08:19 -0700 (PDT)
Received: from ubuntu.fritz.box ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709061baa00b007308fab3eb7sm699407ejg.195.2022.08.04.14.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 14:08:18 -0700 (PDT)
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
To:     kestrelseventyfour@gmail.com
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Add support for WASP SoC on AVM router boards
Date:   Thu,  4 Aug 2022 23:08:03 +0200
Message-Id: <20220804210806.4053-1-kestrelseventyfour@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a popular set of Lantiq xrx200 router boards by AVM in
Germany (AVM Fritzbox 3390, 3490, 5490, 5491 and 7490) which
have the strange implementation of having the wifi cards
connected to a separate memory only ATH79 based SoC. It has no
persistent storage and no access to any resource on the Lantiq
host, but is connect to the Lantiq GSWIP switch on an additional
fixed internal network port.
This kernel module is to support booting the secondary SoC called
Wireless Assistant Support Processor (WASP).
After turning it on, a small network boot firmware is sent to
the SoC by using mdio and when it is started, an initramfs
linux image is sent to the SoC using raw ethernet frames.

The whole procedure takes about 6 seconds, if there is no error.
So far tested on 3490, 5490 and 7490 devices based on OpenWrt, 3390
takes about 20 seconds.

Patch 1/3 adds the vendor name
Patch 2/3 adds the dt-bindings
Patch 3/3 adds the remoteproc driver

To build and run, there is OpenWrt PR 5075.

Please review.

Changes in v5:
  - Replace names for properties and descriptions as requested in the
    device tree documentation and change the driver to accept them
  - Change example in the device tree documentation
  - Restructure constants and defines in the beginning of the driver
    source for better readability
  - Combine m_start_addr and m_exec_addr into a single constant and
    change avm_wasp_netboot_write_header to use only this one constant
  - Change variable startup_gpio to power_gpio in driver

Changes in v4:
  - Fix compiler warnings with W=2 option

Changes in v3:
  - Replace generic avm,fritzboxx490-wasp with actual device names for
    device tree documentation and change the driver to accept them
  - Add maxItems to device tree documentation
  - Change example in the device tree documentation
  - Fix wait time to make the Wasp upload work for 3390 more reliable
  - Enable the SOC on driver load, use reset instead of disable/enable
    while driver is loaded and disable on unloading the driver
  - Change some messages printed to adhere to standards (e.g. remove !)

Changes in v2:
  - Remove firmware names from dt-binding and add as kmod parameters
  - Rename other bindings with vender prefix and fix gpios suffix
  - Change descriptions in dt-binding
  - Replace/Remove asynch load of firmware with request_firmware_direct
  - Fix comments to use the errno define instead of the number
  - Implement wait loops with read_poll_timeout() macro
  - Wrap read_poll_timeout() macro in function saving 6k module size
  - Return -ETIMEDOUT for all errors returned by read_poll_timeout
  - Replace mdio writes/reads with mdiobus_write and mdiobus_read and add
    return codes and their handling
  - Remove mutex for mdiobus_lock and add return code checking for mdio ops
  - Replaced the mdio register array with directly specifying registers
  - As a result of the previous 3 changes remove the functions for mdio
  - Consolidate error messages for mdio writes into a single one saved 1k
    for module size
  - Replaced mdelay with usleep_range saved 0,7k module size
  - Remove unneeded include <linux/interrupt.h> and <linux/error.h>
  - Wrap all blocks with {} and fix some indentation errors
  - Change const len in to size_t in avm_wasp_netboot_write_chunk
  - Make all methods static to fix kernel bot warning
  - Change read variable name in avm_wasp_load_initramfs_image
  - Change ssize_t variables to size_t in avm_wasp_load_initramfs_image
  - avm_wasp_netboot_write_chunk change for loop for 2 byte divisibility
  - Change uint32_t to u32
  - Change int count = -1 to u32 with U32_MAX initialisation
  - Add check for firmware len divisable by 4
  - Replace big endian bit shift operations with be32_to_cpu
  - Change loop to write 14 byte firmware chuncks like suggested
  - Change WASP_CHUNK_SIZE to ARRAY_SIZE(mac_data) for readability
  - Change int done to boolean
  - Change unsigned ints to u32
  - Change int to size_t for send_len
  - Use int for numbytes because kernel_recvmsg returns error or number
  - Two sockets are not needed, so reduce to one socket usage
  - Remove struct timeval definition, replace with __kernel_old_timeval
  - __kernel_old_timeval is depracated, but arch mips is 32bit platform
  - Replace &avmwasp->pdev->dev with local dev
  - Check if wasp network interface is up and fail if not in start method
  - Remove setsockopt for SO_REUSEADDR and SO_BINDTODEVICE
  - Remove packet_counter
  - Move firmware and firmware_end out of RESP_DISCOVER to make sure that
    they are initialized if RESP_DISCOVER is not happening first
  - indend break;
  - Move second half of the send/receive paket while loop to RESP_OK and
    let RESP_DISCOVER fall through
  - Remove bringing up the wasp network interface
  - Check if wasp network interface is up in probe and defer if not
  - Remove the check for the root device and replace it with match data
    for WASP device identification
  - Move of_read and find of mdio bus to rproc_start but delete reference
    after using it in the rproc_start method
  - Replace dev_set_drvdata with platform_set_drvdata
  - Remove avm_wasp_rproc_boot_addr because its not needed and move
    setting the fw struct pointer to avm_wasp_rproc_load
  - Move avm_wasp.h definitions to kernel module

Reported-by: kernel test robot <lkp@intel.com>

Daniel Kestrel (3):
  dt-bindings: vendor-prefixes: Add AVM
  dt-bindings: remoteproc: Add AVM WASP
  remoteproc: Add AVM WASP driver

 .../bindings/remoteproc/avm,wasp-rproc.yaml   |   61 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/remoteproc/Kconfig                    |   10 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/avm_wasp.c                 | 1051 +++++++++++++++++
 5 files changed, 1125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
 create mode 100644 drivers/remoteproc/avm_wasp.c

-- 
2.17.1

