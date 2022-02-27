Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7974C5AC8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiB0L7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiB0L7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:59:39 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFAC3CFEF;
        Sun, 27 Feb 2022 03:59:02 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x5so13662787edd.11;
        Sun, 27 Feb 2022 03:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=hD3VFGB83X+vH7ZF+K9wjycTN2eHYXgx7yYeU3ztz+k=;
        b=OGpuVbDy8w0iSayXASZ82L5zMNlc8v4rzF+1qPlATQhg02R7Mfj5d+qV4gBu7tOfCP
         /1ZkuFDIxy5ovL7YNy0R3rqTXj1aEIwnAQgYTMa3X5HD43IgfXIno/2e844Is8xgup46
         fJ3jaWnq7WOaZLsqM0+P64EenPiPibuPohiyHa65ZEiolIcWyfE0paKS4MjYndG613L8
         xLjatv0sXby5mVZ6hxVKk3QT0+04qM8Kg8KTgnvkXdQbSt8whk9pA8Mol8rulk+HWzyY
         obi/fgOa7wsMIiTkmB4E6ILnE7EBSOjyAsP8EDH84bFVDlwof65ozdQZTl2rMSaZ5Moe
         0R0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hD3VFGB83X+vH7ZF+K9wjycTN2eHYXgx7yYeU3ztz+k=;
        b=1wNaPy9rvNBpfV6Z/hPFkbzyUthIGitE8xbGDvyQCPhECNTDPKgkf8XxG7FKt+AIEa
         IouYtzlDTUIrtAR74qwwWwhHPadVJZbpVCO+mcueISuyqM2YtMQOeiduUbhCOxHTVjYf
         d1Fho7EwLdgTGddquvgcl/G2ZEZuRPU4dfZX6AV1dEOUoGJ7RzlX9Vgw0Hz05/Wf2Db7
         Umdvqw9rk+8kyRcysjs28EPAAji8G6u32rfliOnkbxKGcx4x/v0KfJuUV3NvHvr10IsR
         dgkIMf3pWOYLuogyDkaUehWEXAiMrbKWMGhhiNOU4X9FTiJhun6feXft1lw4eCwcANgm
         iymQ==
X-Gm-Message-State: AOAM531ACm0oqqfkjiAWvgh5v/CZ6JZRch2xVn5v1dGHrooRA9DTPUE3
        k72YmHwpYCQEk4CSuB9Aa60rBTWK1EtEvQ==
X-Google-Smtp-Source: ABdhPJxcgj25YScKfb6Amya4ea0kT0WM7LdRTNXfmnQbaq55LGB3JFJ6gN6G1ShtWKli88e5qGwuTw==
X-Received: by 2002:aa7:daca:0:b0:410:d02a:1bf3 with SMTP id x10-20020aa7daca000000b00410d02a1bf3mr15257855eds.455.1645963140863;
        Sun, 27 Feb 2022 03:59:00 -0800 (PST)
Received: from localhost.localdomain ([155.133.219.250])
        by smtp.gmail.com with ESMTPSA id dn14-20020a05640222ee00b00410b88abd6fsm4474577edb.45.2022.02.27.03.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 03:59:00 -0800 (PST)
From:   Daniel Kestrel <kestrelseventyfour@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kestrel <kestrelseventyfour@gmail.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add support for WASP SoC on AVM router boards 
Date:   Sun, 27 Feb 2022 12:58:29 +0100
Message-Id: <20220227115832.13490-1-kestrelseventyfour@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
So far tested on 3490, 5490 and 7490 devices based on OpenWrt.

Patch 1/3 adds the vendor name
Patch 2/3 adds the dt-bindings
Patch 3/3 adds the remoteproc driver

To build and run, there is OpenWrt PR 5075.

Please review.

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

 .../bindings/remoteproc/avm,wasp-rproc.yaml   |   56 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/remoteproc/Kconfig                    |   10 +
 drivers/remoteproc/Makefile                   |    1 +
 drivers/remoteproc/avm_wasp.c                 | 1051 +++++++++++++++++
 5 files changed, 1120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/avm,wasp-rproc.yaml
 create mode 100644 drivers/remoteproc/avm_wasp.c

-- 
2.17.1

