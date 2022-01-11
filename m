Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D1648B8A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiAKU2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:28:13 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:44065 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230469AbiAKU2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:28:11 -0500
Received: from [192.168.0.5] (ip5f5aeb85.dynamic.kabel-deutschland.de [95.90.235.133])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C20C761E5FE02;
        Tue, 11 Jan 2022 21:28:09 +0100 (CET)
Message-ID: <b72ad376-7a42-1ff2-701d-7fb2f3333c64@molgen.mpg.de>
Date:   Tue, 11 Jan 2022 21:28:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Unable to unselect VGA_ARB (VGA Arbitration)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


I am using Linux 5.16, and I am unable to unset `VGA_ARB` in Kconfig 
(`make menuconfig`). I have an Asus F2A85-M PRO with an AMD A6-6400K APU 
(integrated Radeon graphics device), so no legacy stuff.

 From `drivers/gpu/vga/Kconfig`:

```
config VGA_ARB
         bool "VGA Arbitration" if EXPERT
         default y
         depends on (PCI && !S390)
         help
           […]

config VGA_ARB_MAX_GPUS
         int "Maximum number of GPUs"
         default 16
         depends on VGA_ARB
         help
           […]

config VGA_SWITCHEROO
         bool "Laptop Hybrid Graphics - GPU switching support"
         depends on X86
         depends on ACPI
         depends on PCI
         depends on (FRAMEBUFFER_CONSOLE=n || FB=y)
         select VGA_ARB
         help
           […]
```

But in `make menuconfig` I am unable to unselect it.

     -*- VGA Arbitration

and the help says:

     Symbol: VGA_ARB [=y]
     Type  : bool
       Depends on: HAS_IOMEM [=y] && PCI [=y] && !S390
       Visible if: HAS_IOMEM [=y] && PCI [=y] && !S390 && EXPERT [=n]
       Location:
         Main menu
          -> Device Drivers
            -> Graphics support
     Selected by [n]:
       - VGA_SWITCHEROO [=n] && HAS_IOMEM [=y] && X86 [=y] && ACPI [=y] 
&& PCI [=y] && (!FRAMEBUFFER_CONSOLE [=y] || FB [=y]=y)

So, VGA_SWITCHEROO is not set, and, therefore, as `Selected by [n]:` 
suggests, I thought I’d be able to deselect it.

It’d be great if you could help me out.


Kind regards,

Paul
