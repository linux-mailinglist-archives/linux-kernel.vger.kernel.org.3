Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C7256706D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiGEOKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiGEOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:09:33 -0400
X-Greylist: delayed 596 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Jul 2022 07:00:05 PDT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E21F62B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:00:05 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4LckZP3srQz9sQW;
        Tue,  5 Jul 2022 15:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1657029005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UyCk5SUo23lRExuOxQfNLPjP4O8HrmVgBeUWKaFi8J4=;
        b=svXW6Kz/MpTYyrxbLCjLSxllI2k8TPMOgZbUAFou6gtUiNxcjTstPYCFAy1+aLttptBawZ
        mqZXlx86iFXcD0RpW/Ngn5lbCgXaU8ueabO1Cf8w3nEzRaA4fobuQxuVcu2UEhR/r9pNVG
        38lTJY5Nkevqjkq+M2/tMaN2jlDT948hTxIOIWK/EGRZAXAm6zEhUVj+BoARHw3lxYKtdx
        Z1Ap5GjXHzKvRy656zCqmHEM1kNmvCs/+yR1b50zglP7lNXSRGPhQEhpuM2Zw4OozYnDpf
        /Vhh9FthxoUwK6v8rATqmJLEwzSkpRowsMcJJNX3CHuvSoRsAeJCqdy2vFjunA==
Date:   Tue, 5 Jul 2022 15:50:05 +0200 (CEST)
From:   torvic9@mailbox.org
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Message-ID: <272584304.305738.1657029005216@office.mailbox.org>
Subject: [Regression?] Linux 5.19-rc5 gets stuck on boot, not rc4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: 029f27e751297196207
X-MBO-RS-META: u51njqbnd8em9sh1o465sto5i6zxe1er
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linux 5.19-rc5 does not boot on my Kaby Lake Thinkpad.
rc3 and rc4 were still fine, so I guess something between rc4 and rc5
introduced a regression.

Unfortunately, there are no errors or warning messages.
It gets stuck quite early on boot, about the time USB is initialized,
so less than 1 second into post-bootloader boot.
It then just sits there doing nothing - SysRq still works though.

I don't have time for a bisect, but I thought I'll let you know about
this issue, and maybe someone already has an idea.

Some system information below. Root filesystem is f2fs.

Machine:
  Type: Laptop System: LENOVO product: 20HN0016GE v: ThinkPad X270
CPU:
  Info: dual core Intel Core i5-7200U [MT MCP] speed (MHz): avg: 1563
    min/max: 400/3100
Graphics:
  Device-1: Intel HD Graphics 620 driver: i915 v: kernel
  Device-2: Acer Integrated Camera type: USB driver: uvcvideo
  Display: x11 server: X.Org v: 21.1.3 with: Xwayland v: 22.1.2 driver: X:
    loaded: intel unloaded: modesetting,vesa gpu: i915
    resolution: 1920x1080~60Hz
  OpenGL: renderer: Mesa Intel HD Graphics 620 (KBL GT2) v: 4.6 Mesa 22.1.3
Network:
  Device-1: Intel Ethernet I219-V driver: e1000e
  Device-2: Intel Wireless 8265 / 8275 driver: iwlwifi
  Device-3: Intel Bluetooth wireless interface type: USB driver: btusb
Drives:
  Local Storage: total: 238.47 GiB used: 76.38 GiB (32.0%)
Info:
  Processes: 178 Uptime: 9m Memory: 7.54 GiB used: 1.74 GiB (23.1%)
  Shell: Zsh inxi: 3.3.19

% lspci
  00:00.0 Host bridge: Intel Corporation Xeon E3-1200 v6/7th Gen Core Processor Host Bridge/DRAM Registers (rev 02)
  00:02.0 VGA compatible controller: Intel Corporation HD Graphics 620 (rev 02)
  00:14.0 USB controller: Intel Corporation Sunrise Point-LP USB 3.0 xHCI Controller (rev 21)
  00:14.2 Signal processing controller: Intel Corporation Sunrise Point-LP Thermal subsystem (rev 21)
  00:15.0 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #0 (rev 21)
  00:15.1 Signal processing controller: Intel Corporation Sunrise Point-LP Serial IO I2C Controller #1 (rev 21)
  00:16.0 Communication controller: Intel Corporation Sunrise Point-LP CSME HECI #1 (rev 21)
  00:1c.0 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #1 (rev f1)
  00:1c.2 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #3 (rev f1)
  00:1c.4 PCI bridge: Intel Corporation Sunrise Point-LP PCI Express Root Port #5 (rev f1)
  00:1f.0 ISA bridge: Intel Corporation Sunrise Point-LP LPC Controller (rev 21)
  00:1f.2 Memory controller: Intel Corporation Sunrise Point-LP PMC (rev 21)
  00:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
  00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
  00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (4) I219-V (rev 21)
  02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A PCI Express Card Reader (rev 01)
  03:00.0 Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
  04:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961/SM963

Thank you,
Tor Vic
