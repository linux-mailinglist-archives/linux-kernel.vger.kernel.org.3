Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A22C4784A1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 06:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhLQFqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 00:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhLQFqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 00:46:07 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9336C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 21:46:06 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r11so3580035edd.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 21:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kzK9nTcSN0oQPdWUovRg++U6GA8sCzQEl6XCB6N6fiQ=;
        b=ZEqtvpTkodXGb+EG11jrCjJRqPVcBGBuW3Xa9QOAdz4Q2GcoOJjQUDiQmWMn6mDO8I
         OMAaH8qOL+GGIK3yNq0EvMQ1uMorpjqG5+fKWVtREHnTO0aEYcbp6NMNGGfekJszxUVr
         HJ362/HyEA9/oRR5dAYE0ed7FWr4//WIL9YtC+SA2j6ZsDLboCjhbosRlVYMdnU/akbv
         ofEstrt7N4QKXKQd/qLersLQh9XoKu06sn1cpZRe7xx+swSmk7/xNEMF5v/uXMIOzAci
         gAmgquUY3xJidfU3zXgGFW3QVLzUOJSNZzz9NdKhivxlqaXQA56WDNvPqcFlr86pAKQ8
         6j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kzK9nTcSN0oQPdWUovRg++U6GA8sCzQEl6XCB6N6fiQ=;
        b=JB/UCIdqke8wWiurryXiCPcvprEj7oVyZek2b4Y3OceRFqU2CFVc5CPMUXvd4qKk8n
         8aj7wQMXhkOEVgKtzGzdph7O4BLqeIseOq2ZYKTiYeHKSvqSHdNVvJnTUTJjaANnqNk4
         j/gmwYX75pCN06UNVRXnltMu+c8hjsskp5EdO4IslXY3+9V46dWhnWw9xi07K6tIpu95
         32ZUZ4P8ISQisXrsxcmVBLTuzGW/qQSSsdABjF/wPQmuCailvOrhXJZzyocnztqK5W7v
         O3QmjHUt8MsD2G3XB9D1f2vCsJbbZRBgUkLC36TEAY3j1kBPn+FMPhfWU4/eO0hoZdJA
         b35g==
X-Gm-Message-State: AOAM531g0waC0vK5kplpGTL+y9Uu+DutFjJmyS4LcMqTxnWMzwETXW59
        i8GSU4ozaHpnUW5CSCL6PaSpJib2FlNlZWuZogEnnyCdQCY=
X-Google-Smtp-Source: ABdhPJyHAgj2yM+urv06zWX78aoRt/hr9IJDa4NrYE6oKMDU9HW1EhlqUQOQZjr08ADthJVmbIZmfecg2SRg2XBDM10=
X-Received: by 2002:a17:906:3ac9:: with SMTP id z9mr1260098ejd.750.1639719965192;
 Thu, 16 Dec 2021 21:46:05 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 17 Dec 2021 15:45:54 +1000
Message-ID: <CAPM=9twMFXcWtEGnpOFx5KCZDcNKoteYXeLurMiwaAX9XqESuQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.16-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Mostly amdgpu fixes this week scattered around the driver, otherwise
one i915, one ast, one simpledrm. There is a revert in the fb-helper
for places userspace was using a string that we tried to change.

Regards,
Dave.

drm-fixes-2021-12-17-1:
drm fixes for 5.16-rc6

i915:
- Fix a bound check in the DMC fw load.

ast:
- NULL ptr deref fix

simpledrm:
- pixel clock units fix

fb-helper:
- userspace regression revert

amdgpu:
- Fix RLC register offset
- GMC fix
- Properly cache SMU FW version on Yellow Carp
- Fix missing callback on DCN3.1
- Reset DMCUB before HW init
- Fix for GMC powergating on PCO
- Fix a possible memory leak in GPU metrics table handling on RN
The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-12-17-1

for you to fetch changes up to a2fbfd517117157e99160ff1b39b171872dcba07:

  Merge tag 'amd-drm-fixes-5.16-2021-12-15' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-12-17
15:01:01 +1000)

----------------------------------------------------------------
drm fixes for 5.16-rc6

i915:
- Fix a bound check in the DMC fw load.

ast:
- NULL ptr deref fix

simpledrm:
- pixel clock units fix

fb-helper:
- userspace regression revert

amdgpu:
- Fix RLC register offset
- GMC fix
- Properly cache SMU FW version on Yellow Carp
- Fix missing callback on DCN3.1
- Reset DMCUB before HW init
- Fix for GMC powergating on PCO
- Fix a possible memory leak in GPU metrics table handling on RN

----------------------------------------------------------------
Alejandro Concepcion-Rodriguez (1):
      drm: simpledrm: fix wrong unit with pixel clock

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2021-12-15' of
ssh://git.freedesktop.org/git/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2021-12-16-1' of
ssh://git.freedesktop.org/git/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.16-2021-12-15' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Evan Quan (1):
      drm/amdgpu: correct the wrong cached state for GMC on PICASSO

Harshit Mogalapalli (1):
      drm/i915/display: Fix an unsigned subtraction which can never be negative.

Hawking Zhang (1):
      drm/amdgpu: don't override default ECO_BITs setting

Javier Martinez Canillas (1):
      Revert "drm/fb-helper: improve DRM fbdev emulation device names"

Jiasheng Jiang (1):
      drm/ast: potential dereference of null pointer

Lang Yu (1):
      drm/amd/pm: fix a potential gpu_metrics_table memory leak

Le Ma (1):
      drm/amdgpu: correct register access for RLC_JUMP_TABLE_RESTORE

Mario Limonciello (1):
      drm/amd/pm: fix reading SMU FW version from amdgpu_firmware_info on YC

Nicholas Kazlauskas (2):
      drm/amd/display: Set exit_optimized_pwr_state for DCN31
      drm/amd/display: Reset DMCUB before HW init

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c          | 1 -
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c          | 1 -
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c          | 1 -
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c           | 9 ++++-----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c           | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c           | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c           | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c           | 2 --
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c | 1 +
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 7 ++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 3 +++
 drivers/gpu/drm/ast/ast_mode.c                    | 5 ++++-
 drivers/gpu/drm/drm_fb_helper.c                   | 8 +++++++-
 drivers/gpu/drm/i915/display/intel_dmc.c          | 2 +-
 drivers/gpu/drm/tiny/simpledrm.c                  | 2 +-
 19 files changed, 45 insertions(+), 20 deletions(-)
