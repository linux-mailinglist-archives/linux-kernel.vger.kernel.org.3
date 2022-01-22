Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2662496B2C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiAVJRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiAVJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:17:45 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FCEC061401
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:17:45 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so11269184pja.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lR7Iu10SezhvGD8GEDZxPbVDEUW/bqCD91/b4jLeEnE=;
        b=GJUTWJgF9XEe4NI5urctJROaTT105G8Sl9IA0VbjvHHhh39CFJLwyft8QZxZOZPzMl
         hk+KzgJ7aCbmuQDioX73079qB3j1EXImy7Iaietuk/9RJHfujgSgO9qA17W6Se0EGyVJ
         KSsB6DeNq5/1Hr5KWLy1IzwAGAZZcewMabMl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lR7Iu10SezhvGD8GEDZxPbVDEUW/bqCD91/b4jLeEnE=;
        b=Z+uBOalKVEjg1tyg5DjQq3JKH1x06oMftmBuPVU7iAQUoGUg8RRV8Wfpa3rC3K+dNi
         fVP6olA+b5Dhvl2Y87fLiIBRcySXpeNHa3+Cey6IWHWZMO+0e47uX49R8F1lGaA8D9PS
         Ee8qhYKyWWnwX+JR5Jrfmh+W1TAW9pK+uzYQ0Kkr/gDyi1eVeREdLmbrsEFo4r/6CoPu
         S8Hg7DE1aHLf+N5kOW1YTAGIROWztitbWxHNQOnqs65VFHDI42PsZ8UieA2/pmNfMksa
         GL1+TAuLz4zv0sdf0NL2Om5Iab+GZcxvnIIqeaoOYh8iO3C9w0nB9NjnB3Q+pxFTpt6a
         OBug==
X-Gm-Message-State: AOAM532S1IVzKkQ+GtiMp5NsAuS75phjVypRv+5tSxV1WNwY5I0ijy8Y
        ozesqhYISovRkYMVCl+W5Xjlag==
X-Google-Smtp-Source: ABdhPJwgamtUukp/wX2Vv8Kja9mO15pM9OvUR5D7VwBD2XhLvZ7MedSAzL6y/LrUOP+di2FB4c0zNQ==
X-Received: by 2002:a17:902:da88:b0:14b:337f:1918 with SMTP id j8-20020a170902da8800b0014b337f1918mr1835553plx.129.1642843064665;
        Sat, 22 Jan 2022 01:17:44 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:17:44 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/31] clk: mediatek: Cleanups and Improvements - Part 1
Date:   Sat, 22 Jan 2022 17:17:00 +0800
Message-Id: <20220122091731.283592-1-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is part 1 of planned work to cleanup, improve, and modernize the
MediaTek clk drivers. The full proposal for the work is included below.

Part 1 involves cleaning up various parts of the MediaTek common clk
driver library:

- Code style cleanups in places touched by other changes
- Code for a given clk type that happened to be split between different
  files is consolidated
- Parts of the implementation, such as the internal data structures and
  registration/unregistration of a single clk, are internalized and no
  longer exported to other parts of the library
- Unregister APIs for all clk types in the library are added
- Remove function added for the simple driver case
- Error handling is added for all clk types
- MT8195 clk drivers cleaned up with error handling and removal support
  added

Adding error handling to the clk driver library results is a change in
its behavior, and might cause some breakage where the affected system
was originally somewhat working, but not completely. The failure would
result from a duplicated clk, either in name or ID. Old behavior was to
skip over these and ignore the error, whereas the new behavior is to
restore changes and error out.

To detect duplicate IDs, an additional warning will now be printed when
such occurrences happen. In a correct driver such things should not
happen though, so maybe we could consider wrapping that in some debug
Kconfig option. That's why I put it as the last patch in this series.

This series was tested on MT8195 with the series applied on the downstream
ChromeOS v5.10 kernel. Some other patches were applied to make this
series apply cleanly, but nothing The cpumux clk type changes were
not tested due to lack of related hardware. However the changes are
very similar to the other types, and I am confident there are no issues.


Full proposal follows:

MediaTek Kernel Clk Driver Improvement

Objective

Modernize the MediaTek clk drivers to support "struct clk_hw" based
registration and local parenting. Also address any deficiencies, such
as lack of proper cleanup and removal of clocks.

Requirements

- Clks should be registered with clk_hw_* APIs
- Clk parents within the same IP block / driver should be described with
  clk_hw pointers, not global clock names
- All clk registration APIs should have corresponding unregister APIs
  for proper cleanup
- All clk drivers should have proper error path cleanup
- Essential clk drivers should not be allowed to be unbound
- Non-essential modular clk drivers should have removal paths

Background

The clk API in the Linux kernel is split into per-user "struct clk"
consumer and per-provider "struct clk_hw" provider APIs. Upstream has
deprecated the use of clk_register() and co APIs that return "struct clk",
and encourages everyone to migrate to the provider APIs.

The MediaTek clk driver is still using the deprecated clk_register() API
to register clocks. As the driver family is based on a common library
shared by all MediaTek platforms, this presents a huge obstacle in the
deprecation and removal of the old API. This also precludes the MediaTek
driver from fully utilizing new features and improvements in the Common
Clock Framework.

One such feature is the ability to reference clock parents directly with
pointers to their respective "struct clk_hw", instead of looking up clock
names in the global clock table. Newer platforms have hundreds of
individual clocks, split amongst a handful of IP blocks. Most of them are
internal nodes of each IP block's clock tree. Reducing the amount of time
spent on global clock name lookups would make clk drivers probe faster
and boost overall boot time.

Indeed, there has already been an attempt by MediaTek to improve this by
hashing the clock names [1] to get around the slow string comparison.
However this doesn't address the primary deficiency of the current driver
implementation.

Design ideas

As the requirements section lists, many improvements can be made to the
driver library and platform drivers. Given the amount of existing
platforms supported by the driver library, and lack of hardware within
ChromeOS for some of them, the most likely approach is to target one
specific platform to do the improvements, and let MediaTek & the broader
kernel community handle the rest.

1. Add proper cleanup code
   - Add "unregister" APIs to each type of clock supported by the driver
     library
   - Add calls to these new APIs to the error paths of existing drivers
   - Add driver removal code for non-essential modular drivers
2. clk_hw_register() support
   - Add matching clk_hw_register_* API variants
     - This should be made as generic as possible (like the clk_hw_register()
       API) to make step 3 easier to implement.
   - Migrate existing platform driver to new APIs
3. Pointer based local parenting
   - Add macros to handle "struct clk_hw" and "struct clk_parent_data"
     ways of describing clock parents
   - Add clock parent descriptions based on "struct clk_hw" to existing
     platform drivers
     - For clocks on the input-side hardware boundary,
       "struct clk_parent_data" should be used to leave room for device
       tree based clock lookups

4. At this point, we should require MediaTek and other parties to use the
   new APIs to implement drivers for new platforms

5. Once all platform drivers have been converted, the old clk_register()
   based APIs can be removed

Alternatives considered

Hashing the clock names and comparing the hash first [1] has been proposed
by MediaTek. However while this does improve performance, the hashing
itself still incurs a cost that could be avoided entirely for most
instances. The only instances where local clock parenting is unusable
and global clock name matching is needed is for clock parents between
different clock provider IP blocks. The number of clocks wired between
blocks is quite large, and MediaTek has avoided describing them in the
device tree.

[1] https://lore.kernel.org/linux-mediatek/20211005065948.10092-1-mark-pk.tsai@mediatek.com/


Chen-Yu Tsai (31):
  clk: mediatek: Use %pe to print errors
  clk: mediatek: gate: Consolidate gate type clk related code
  clk: mediatek: gate: Internalize clk implementation
  clk: mediatek: gate: Implement unregister API
  clk: mediatek: gate: Clean up included headers
  clk: mediatek: cpumux: Implement unregister API
  clk: mediatek: cpumux: Internalize struct mtk_clk_cpumux
  clk: mediatek: cpumux: Clean up included headers
  clk: mediatek: mux: Implement unregister API
  clk: mediatek: mux: Internalize struct mtk_clk_mux
  clk: mediatek: mux: Clean up included headers
  clk: mediatek: pll: Split definitions into separate header file
  clk: mediatek: pll: Implement unregister API
  clk: mediatek: pll: Clean up included headers
  clk: mediatek: Implement mtk_clk_unregister_fixed_clks() API
  clk: mediatek: Implement mtk_clk_unregister_factors() API
  clk: mediatek: Implement mtk_clk_unregister_divider_clks() API
  clk: mediatek: Implement mtk_clk_unregister_composites() API
  clk: mediatek: Add mtk_clk_simple_remove()
  clk: mediatek: mtk: Clean up included headers
  clk: mediatek: cpumux: Implement error handling in register API
  clk: mediatek: gate: Implement error handling in register API
  clk: mediatek: mux: Reverse check for existing clk to reduce nesting
    level
  clk: mediatek: mux: Implement error handling in register API
  clk: mediatek: pll: Implement error handling in register API
  clk: mediatek: mtk: Implement error handling in register APIs
  clk: mediatek: Unregister clks in mtk_clk_simple_probe() error path
  clk: mediatek: mt8195: Hook up mtk_clk_simple_remove()
  clk: mediatek: mt8195: Implement error handling in probe functions
  clk: mediatek: mt8195: Implement remove functions
  clk: mediatek: Warn if clk IDs are duplicated

 drivers/clk/mediatek/clk-apmixed.c            |   2 +-
 drivers/clk/mediatek/clk-cpumux.c             |  69 +++-
 drivers/clk/mediatek/clk-cpumux.h             |  13 +-
 drivers/clk/mediatek/clk-gate.c               | 148 +++++++--
 drivers/clk/mediatek/clk-gate.h               |  59 ++--
 drivers/clk/mediatek/clk-mt2701.c             |   5 +-
 drivers/clk/mediatek/clk-mt2712.c             |   3 +-
 drivers/clk/mediatek/clk-mt6765.c             |   3 +-
 drivers/clk/mediatek/clk-mt6779.c             |   3 +-
 drivers/clk/mediatek/clk-mt6797.c             |   3 +-
 drivers/clk/mediatek/clk-mt7622.c             |   5 +-
 drivers/clk/mediatek/clk-mt7629.c             |   5 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c     |   4 +-
 drivers/clk/mediatek/clk-mt8135.c             |   3 +-
 drivers/clk/mediatek/clk-mt8167.c             |   3 +-
 drivers/clk/mediatek/clk-mt8173.c             |   5 +-
 drivers/clk/mediatek/clk-mt8183.c             |   3 +-
 drivers/clk/mediatek/clk-mt8192.c             |   3 +-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c  |  30 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c  |  25 +-
 drivers/clk/mediatek/clk-mt8195-cam.c         |   1 +
 drivers/clk/mediatek/clk-mt8195-ccu.c         |   1 +
 drivers/clk/mediatek/clk-mt8195-img.c         |   1 +
 .../clk/mediatek/clk-mt8195-imp_iic_wrap.c    |   1 +
 drivers/clk/mediatek/clk-mt8195-infra_ao.c    |   1 +
 drivers/clk/mediatek/clk-mt8195-ipe.c         |   1 +
 drivers/clk/mediatek/clk-mt8195-mfg.c         |   1 +
 drivers/clk/mediatek/clk-mt8195-peri_ao.c     |   1 +
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c    |   1 +
 drivers/clk/mediatek/clk-mt8195-topckgen.c    |  69 +++-
 drivers/clk/mediatek/clk-mt8195-vdec.c        |   1 +
 drivers/clk/mediatek/clk-mt8195-vdo0.c        |  20 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c        |  20 +-
 drivers/clk/mediatek/clk-mt8195-venc.c        |   1 +
 drivers/clk/mediatek/clk-mt8195-vpp0.c        |   1 +
 drivers/clk/mediatek/clk-mt8195-vpp1.c        |   1 +
 drivers/clk/mediatek/clk-mt8195-wpe.c         |   1 +
 drivers/clk/mediatek/clk-mt8516.c             |   3 +-
 drivers/clk/mediatek/clk-mtk.c                | 299 +++++++++++++-----
 drivers/clk/mediatek/clk-mtk.h                | 105 ++----
 drivers/clk/mediatek/clk-mux.c                |  89 +++++-
 drivers/clk/mediatek/clk-mux.h                |  17 +-
 drivers/clk/mediatek/clk-pll.c                |  94 +++++-
 drivers/clk/mediatek/clk-pll.h                |  57 ++++
 drivers/clk/mediatek/reset.c                  |   3 +-
 45 files changed, 891 insertions(+), 293 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-pll.h

-- 
2.35.0.rc0.227.g00780c9af4-goog

