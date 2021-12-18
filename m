Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91FF479D6C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 22:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhLRVh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 16:37:59 -0500
Received: from netrider.rowland.org ([192.131.102.5]:54953 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229480AbhLRVh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 16:37:58 -0500
Received: (qmail 881331 invoked by uid 1000); 18 Dec 2021 16:37:57 -0500
Date:   Sat, 18 Dec 2021 16:37:57 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: How to fix screen resolution detection?
Message-ID: <Yb5UtbfhmCHx+snO@rowland.harvard.edu>
References: <Yby4ooKl43NRm+5y@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yby4ooKl43NRm+5y@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The screen resolution on my laptop is not reported accurately.  Here's 
an extract from the output of xdpyinfo:

screen #0:
  dimensions:    3200x1800 pixels (847x476 millimeters)
  resolution:    96x96 dots per inch

The number of pixels is correct, but the size and resolution values 
smack of a bogus default.  The actual width of the screen (determined 
with a tape measure) is about 11.5 inches (291 mm), which yields a 
resolution of 280 dots per inch (11 dots per mm), approximately.  
Most definitely _not_ 96 dpi.

Presumably X gets the size/resolution information from Wayland, which 
gets it from the kernel, which gets it from the firmware.  So the kernel 
driver is the logical place to start in figuring where things are going 
wrong.  The laptop uses i915; here are the relevant lines from the 
kernel log:

[    0.000000] Linux version 5.14.9-200.fc34.x86_64 (mockbuild@bkernel02.iad2.fedoraproject.org) (gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1), GNU ld version 2.35.2-5.fc34) #1 SMP Thu Sep 30 11:55:35 UTC 2021

[    0.463895] efifb: probing for efifb
[    0.463913] efifb: framebuffer at 0xe0000000, using 22500k, total 22500k
[    0.463916] efifb: mode is 3200x1800x32, linelength=12800, pages=1
[    0.463919] efifb: scrolling: redraw
[    0.463920] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.464028] Console: switching to colour frame buffer device 400x112
[    0.474894] fb0: EFI VGA frame buffer device

[    2.888858] fb0: switching to inteldrmfb from EFI VGA
[    2.891260] Console: switching to colour dummy device 80x25
[    2.891318] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.902665] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.904833] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/skl_dmc_ver1_27.bin (v1.27)
[    2.947359] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
[    2.949468] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.949803] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input9
[    2.964371] fbcon: i915 (fb0) is primary device
[    2.979854] Console: switching to colour frame buffer device 400x112
[    3.012355] i915 0000:00:02.0: [drm] fb0: i915 frame buffer device

Now, I know nothing about the kernel's graphics subsystems.  How can I 
find out what size/resolution information i915 is getting and passing to 
Wayland?  If it's wrong, how can I fix it?

Thanks,

Alan Stern
