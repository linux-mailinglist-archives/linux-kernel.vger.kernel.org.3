Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3514A93DA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 07:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiBDGJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 01:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiBDGJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:09:27 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8325BC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 22:09:27 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id o12so16036737eju.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 22:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=irPohvkYW/vu/tINGbfcT0yMRUasDFKKmSa2izf+JcI=;
        b=aMddKGsuPh3qd0rOIqO9k1JKKZm+feThOV211oA6JRocAiR2gvwuNmWPG7WMMn8H+0
         /tck16Ek/Gn7YK7VKTIjp9hYhtj/Lnw1heeEC87jEPNa9j+/TRegIRzlQxqUTQ8D3HL7
         o+NDyAr1GMBStMksD8DY+k/KjdR7fLYAay2Xt74ZK2LbwpN04L/en7FuqeX1P1mytxLu
         RD1hWrY91feOm+kKcQebg6/y2nE5NK8vjJ1/fQ8M7iHG0tcsJojj2BzXy7/cxXLcpbxq
         mye80raZc81lFJrxl2OXYoeXYPvjr8VUbTgx4tVRRINo24HYDs4MdraqVbWjGjd11dJ2
         jooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=irPohvkYW/vu/tINGbfcT0yMRUasDFKKmSa2izf+JcI=;
        b=AgqjP6zltlRqaPM3c4Di50MGGrA5OAEJzucnEqopSvQ23RNlfgxbLl8vPuP1Sf8MVn
         ZMuW5pgSM/HYkVTeCq14Mh2wBixXdAH+rvu9tOAuNlInQDW0g22CSGLpeGsGN0HOwVVs
         /UMgtAFJchodp0IA8WmcAvKiqYeLfvjCr9vyAa4JLQAFh8etSSPH4r+BCbwestq03CMd
         erfoyLWV/FQFu0GR1uGmf8Kuj/5sQIBst7jNV16tMt0AWhzJTYW+XT6m4zETsiyZttvO
         rT6MTb0UKbfPxFcGW/lrDSfIszT5KlUnabtQq7HDux0fWhokp7XpHi9Y6ckmFF6IUKUk
         5MnA==
X-Gm-Message-State: AOAM530McGw9fYimC+ghXiGBjkHPvbzgYqNUXV0VK6oKapLcX5wiUcES
        4ws1dCybCOD7ylG/LYNelso2zqXNoaBe+ricbW7JHGAhclo=
X-Google-Smtp-Source: ABdhPJwP1bbXEMt9wd6t0qLBiZSaPI0z98GUTDdpDr/7g/UE+k5Y0mloWJXKjqLzgwgpFLmRr9nv8jOPBrQy3TOG5PI=
X-Received: by 2002:a17:907:948c:: with SMTP id dm12mr1205388ejc.770.1643954965956;
 Thu, 03 Feb 2022 22:09:25 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 4 Feb 2022 16:09:15 +1000
Message-ID: <CAPM=9tx9Ag9zPenB48F0qCZ1B8gxF0vtRG5-h3We_2QW_z+pxg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.17-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Regular fixes for the week. Daniel has agreed to bring back the fbcon
hw acceleration under a CONFIG option for the non-drm fbdev users, we
don't advise turning this on unless you are in the niche that is old
fbdev drivers, Since it's essentially a revert and shouldn't be high
impact seemed like a good time to do it now.

Otherwise, i915 and amdgpu fixes are most of it, along with some minor
fixes elsewhere.

Dave.

drm-fixes-2022-02-04:
drm fixes for 5.17-rc3

fbdev:
- readd fbcon acceleration

i915:
- fix DP monitor via type-c dock
- fix for engine busyness and read timeout with GuC
- use ALLOW_FAIL for error capture buffer allocs
- don't use interruptible lock on error paths
- smatch fix to reject zero sized overlays.

amdgpu:
- mGPU fan boost fix for beige goby
- S0ix fixes
- Cyan skillfish hang fix
- DCN fixes for DCN 3.1
- DCN fixes for DCN 3.01
- Apple retina panel fix
- ttm logic inversion fix

dma-buf:
- heaps: fix potential spectre v1 gadget

kmb:
- fix potential oob access

mxsfb:
- fix NULL ptr deref

nouveau:
- fix potential oob access during BIOS decode
The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c=
:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-02-04

for you to fetch changes up to 9ca3d3cd0857523c95ab8cdbb6cfe47b8f90e309:

  Merge tag 'drm-intel-fixes-2022-02-03' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2022-02-04
15:48:27 +1000)

----------------------------------------------------------------
drm fixes for 5.17-rc3

fbdev:
- readd fbcon acceleration

i915:
- fix DP monitor via type-c dock
- fix for engine busyness and read timeout with GuC
- use ALLOW_FAIL for error capture buffer allocs
- don't use interruptible lock on error paths
- smatch fix to reject zero sized overlays.

amdgpu:
- mGPU fan boost fix for beige goby
- S0ix fixes
- Cyan skillfish hang fix
- DCN fixes for DCN 3.1
- DCN fixes for DCN 3.01
- Apple retina panel fix
- ttm logic inversion fix

dma-buf:
- heaps: fix potential spectre v1 gadget

kmb:
- fix potential oob access

mxsfb:
- fix NULL ptr deref

nouveau:
- fix potential oob access during BIOS decode

----------------------------------------------------------------
Agustin Gutierrez (1):
      drm/amd/display: Update watermark values for DCN301

Alexander Stein (1):
      drm: mxsfb: Fix NULL pointer dereference

Anitha Chrisanthus (1):
      drm/kmb: Fix for build errors with Warray-bounds

Aun-Ali Zaidi (1):
      drm/amd/display: Force link_rate as LINK_RATE_RBR2 for 2018 15"
Apple Retina panels

Christian K=C3=B6nig (1):
      drm/amdgpu: fix logic inversion in check

Dan Carpenter (1):
      drm/i915/overlay: Prevent divide by zero bugs in scaling

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.17-2022-02-02' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2022-02-03' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2022-02-03' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Evan Quan (1):
      drm/amd/pm: correct the MGpuFanBoost support for Beige Goby

Helge Deller (3):
      Revert "fbdev: Garbage collect fbdev scrolling acceleration,
part 1 (from TODO list)"
      Revert "fbcon: Disable accelerated scrolling"
      fbcon: Add option to enable legacy hardware acceleration

Imre Deak (1):
      drm/i915/adlp: Fix TypeC PHY-ready status readout

Jordy Zomer (1):
      dma-buf: heaps: Fix potential spectre v1 gadget

Lang Yu (1):
      drm/amdgpu: fix a potential GPU hang on cyan skillfish

Mario Limonciello (4):
      drm/amd: Warn users about potential s0ix problems
      drm/amd: add support to check whether the system is set to s3
      drm/amd: Only run s3 or s0ix if system is configured properly
      drm/amd: avoid suspend on dGPUs w/ s2idle support when runtime PM ena=
bled

Matthew Brost (2):
      drm/i915: Allocate intel_engine_coredump_alloc with ALLOW_FAIL
      drm/i915: Lock timeline mutex directly in error path of eb_pin_timeli=
ne

Nick Lopez (1):
      drm/nouveau: fix off by one in BIOS boundary checking

Paul Hsieh (1):
      drm/amd/display: watermark latencies is not enough on DCN31

Umesh Nerlige Ramappa (2):
      drm/i915/pmu: Use PM timestamp instead of RING TIMESTAMP for referenc=
e
      drm/i915/pmu: Fix KMD and GuC race on accessing busyness

Zhan Liu (1):
      drm/amd/display: revert "Reset fifo after enable otg"

 Documentation/gpu/todo.rst                         |  24 -
 drivers/dma-buf/dma-heap.c                         |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  37 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   3 +
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |  16 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c   |  20 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  20 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   5 -
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |  15 -
 .../amd/display/dc/dcn10/dcn10_stream_encoder.h    |   3 -
 .../amd/display/dc/dcn20/dcn20_stream_encoder.c    |   2 -
 .../display/dc/dcn30/dcn30_dio_stream_encoder.c    |   2 -
 .../gpu/drm/amd/display/dc/inc/hw/stream_encoder.h |   4 -
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   6 +-
 drivers/gpu/drm/i915/display/intel_overlay.c       |   3 +
 drivers/gpu/drm/i915/display/intel_tc.c            |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |   9 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h             |   5 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  | 114 ++++-
 drivers/gpu/drm/i915/i915_gpu_error.c              |   2 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   3 +-
 drivers/gpu/drm/kmb/kmb_plane.c                    |   6 -
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |   6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c    |   2 +-
 drivers/video/console/Kconfig                      |  20 +
 drivers/video/fbdev/core/bitblit.c                 |  16 +
 drivers/video/fbdev/core/fbcon.c                   | 557 +++++++++++++++++=
+++-
 drivers/video/fbdev/core/fbcon.h                   |  72 +++
 drivers/video/fbdev/core/fbcon_ccw.c               |  28 +-
 drivers/video/fbdev/core/fbcon_cw.c                |  28 +-
 drivers/video/fbdev/core/fbcon_rotate.h            |   9 +
 drivers/video/fbdev/core/fbcon_ud.c                |  37 +-
 drivers/video/fbdev/core/tileblit.c                |  16 +
 drivers/video/fbdev/skeletonfb.c                   |  12 +-
 include/linux/fb.h                                 |   2 +-
 38 files changed, 972 insertions(+), 160 deletions(-)
