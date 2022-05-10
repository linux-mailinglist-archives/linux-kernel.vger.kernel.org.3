Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131FF521292
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbiEJKwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiEJKwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:52:09 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9571BDD82
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:12 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e5so14319317pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpDFlOZXpJjXLC7ktedthI7zQougAm9+755lwKBDRYQ=;
        b=L2p74zzSnxmX+oAWUzKHb5m9IZgc62QdY3HohYzBVPVhe0dhmg9ADu4Yqu6AqCF4B0
         v4jkWStbaOkwaXbT8yqdvBCGNLccvBfLYoTlQo87rzR3e3bhqPB22CbyCS5yh1wEp9Ew
         gzxoCQ/DWr/9rVFWN/LM/IS9Cq3uEDN8srenc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpDFlOZXpJjXLC7ktedthI7zQougAm9+755lwKBDRYQ=;
        b=IDvHe7II1fgI/W0ByxORuwBj0RY5ibgSw/aipw75bz4p/cDBdy176ZetBNCzzXNvgE
         1zCQ2yub2epcI70t9VF2eC/PqYRBB+/J6xiyd75VnbMmfCArj5B5ylcUaH+fDxRvIG/W
         yvq9Mzl8FEsm1P64vWLEwrB6etESqoLr/CdhMDpvKSNGjtWtAmqolIpejCscZAKkJZu4
         v9vmlCn7pJyef9Oe3t/+e7It0hLjsWMDHquXSdAHsQY0w/2K/ADKD4OV/PSIp4YztEtE
         kHamEvcQvE7A/W2257bBxaVJJU6Mk2S8fPGNJuq6HitURkoPDDmKXwxeyCI76dR//nr8
         UD8A==
X-Gm-Message-State: AOAM533DIFTiaGZCWO5+qSyXPdjJk3m03d3c2ekuii5ZifyBHyWb0+G0
        BsUd2tOl9cC338r043XcSt66Ng==
X-Google-Smtp-Source: ABdhPJyhlmUFh9/ps5D57B2uVw0NOeQ/MOs6dPy31mbKwB0SdcdcVA74igmhool6iWIHCQau2SEetQ==
X-Received: by 2002:a62:31c1:0:b0:50a:4909:2691 with SMTP id x184-20020a6231c1000000b0050a49092691mr20316266pfx.64.1652179692002;
        Tue, 10 May 2022 03:48:12 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6dcd:8578:55cf:2b12])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902e30900b0015e8d4eb21esm1659691plc.104.2022.05.10.03.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:48:11 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] clk: mediatek: Move to struct clk_hw provider APIs
Date:   Tue, 10 May 2022 18:47:53 +0800
Message-Id: <20220510104804.544597-1-wenst@chromium.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is v2 of part 2 of my proposed MediaTek clk driver cleanup work [1].

Changes since v1:
- Rebased and added coverage of new MT8186 clk drivers
- Split patch "clk: mediatek: Replace 'struct clk' with 'struct clk_hw'"
  into arbitrary pieces so that they don't bounce from the mailing lists

This was tested on MT8183 Juniper. Apppreciate any help testing on non-
ChromeOS devices.

I'm not sure how this is supposed to be merged. Patches 3~8 need to be
squashed together for bisectability, and the same goes for patches 9+10.
Maybe after review, I could squash them and send a pull request? Or the
patches could be put on a separate topic branch? That would be bad if
we needed to revert the branch and other stuff was based on it though.

Original cover letter from v1, with patch numbers fixed:

Part 2 involves moving the whole MediaTek clk driver library from the
old `struct clk` provider API to the new `struct clk_hw` provider API.

Parts of this series were done with coccinelle scripts, while others
were done by hand. To facilitate review, these parts are currently split
into different patches. As a result however, this series is not fully
bisectable. Later on, the related parts should be squashed together.

Patch 1 and 2 are minor cleanups around code that is touched by later
patches.

Patch 3 starts the switch of the underlying data structure used to hold
clocks from `struct clk_onecell_data` to `struct clk_hw_onecell_data`.
This part is done by hand. The helpers used to allocate the data
structures are changed, but none of the actual call sites, nor the
clk provider API usage.

Patch 4~8 finish the switch from `struct clk_onecell_data` to `struct
clk_hw_onecell_data`. All the holding variables and call sites that
involve `struct clk_onecell_data` are changed using coccinelle scripts.

Patch 9 moves most of the MediaTek clk driver library from clk_register*()
to clk_hw_register*, including all intermediate helpers, using
coccinelle scripts.

Patch 10 fixes, by hand, a build error from a call site that was not covered
by the previous patch.

Patch 11 converts the last usage of clk_register*() in the MediaTek clk
drivers.

As mentioned above, this series includes parts that don't build, but are
split out for clarity. These are patches 3~8 and 9+10. Once the patches
are reviewed, they can be squashed together.

This series will likely conflict with Rex's "Cleanup MediaTek clk reset
drivers" that was posted earlier today. We'll see how these work out.

The next phase of the cleanup/improvement shall be to introduce some
variant of `struct clk_parent_data` to describe clk relationships
efficiently.

Please have a look.


Thanks
ChenYu

[1] https://lore.kernel.org/linux-clk/20220122091731.283592-1-wenst@chromium.org/

Chen-Yu Tsai (11):
  clk: mediatek: Make mtk_clk_register_composite() static
  clk: mediatek: apmixed: Drop error message from clk_register() failure
  clk: mediatek: Convert mtk_{alloc,free}_clk_data to struct clk_hw
  clk: mediatek: Replace 'struct clk' with 'struct clk_hw'
  clk: mediatek: mt27xx: Replace 'struct clk' with 'struct clk_hw'
  clk: mediatek: mt67xx: Replace 'struct clk' with 'struct clk_hw'
  clk: mediatek: mt7xxx: Replace 'struct clk' with 'struct clk_hw'
  clk: mediatek: mt8xxx: Replace 'struct clk' with 'struct clk_hw'
  clk: mediatek: Switch to clk_hw provider APIs
  clk: mediatek: mt8173: Fix usage of mtk_clk_register_ref2usb_tx()
  clk: mediatek: mt8173: Switch to clk_hw provider APIs

 drivers/clk/mediatek/clk-apmixed.c           |  12 +-
 drivers/clk/mediatek/clk-cpumux.c            |  50 +++---
 drivers/clk/mediatek/clk-cpumux.h            |   6 +-
 drivers/clk/mediatek/clk-gate.c              |  52 +++---
 drivers/clk/mediatek/clk-gate.h              |   8 +-
 drivers/clk/mediatek/clk-mt2701-aud.c        |   4 +-
 drivers/clk/mediatek/clk-mt2701-bdp.c        |   4 +-
 drivers/clk/mediatek/clk-mt2701-eth.c        |   4 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c        |   4 +-
 drivers/clk/mediatek/clk-mt2701-hif.c        |   4 +-
 drivers/clk/mediatek/clk-mt2701-img.c        |   4 +-
 drivers/clk/mediatek/clk-mt2701-mm.c         |   4 +-
 drivers/clk/mediatek/clk-mt2701-vdec.c       |   4 +-
 drivers/clk/mediatek/clk-mt2701.c            |  26 +--
 drivers/clk/mediatek/clk-mt2712-bdp.c        |   4 +-
 drivers/clk/mediatek/clk-mt2712-img.c        |   4 +-
 drivers/clk/mediatek/clk-mt2712-jpgdec.c     |   4 +-
 drivers/clk/mediatek/clk-mt2712-mfg.c        |   4 +-
 drivers/clk/mediatek/clk-mt2712-mm.c         |   4 +-
 drivers/clk/mediatek/clk-mt2712-vdec.c       |   4 +-
 drivers/clk/mediatek/clk-mt2712-venc.c       |   4 +-
 drivers/clk/mediatek/clk-mt2712.c            |  28 +--
 drivers/clk/mediatek/clk-mt6765-audio.c      |   4 +-
 drivers/clk/mediatek/clk-mt6765-cam.c        |   4 +-
 drivers/clk/mediatek/clk-mt6765-img.c        |   4 +-
 drivers/clk/mediatek/clk-mt6765-mipi0a.c     |   4 +-
 drivers/clk/mediatek/clk-mt6765-mm.c         |   4 +-
 drivers/clk/mediatek/clk-mt6765-vcodec.c     |   4 +-
 drivers/clk/mediatek/clk-mt6765.c            |  12 +-
 drivers/clk/mediatek/clk-mt6779-aud.c        |   4 +-
 drivers/clk/mediatek/clk-mt6779-cam.c        |   4 +-
 drivers/clk/mediatek/clk-mt6779-img.c        |   4 +-
 drivers/clk/mediatek/clk-mt6779-ipe.c        |   4 +-
 drivers/clk/mediatek/clk-mt6779-mfg.c        |   4 +-
 drivers/clk/mediatek/clk-mt6779-mm.c         |   4 +-
 drivers/clk/mediatek/clk-mt6779-vdec.c       |   4 +-
 drivers/clk/mediatek/clk-mt6779-venc.c       |   4 +-
 drivers/clk/mediatek/clk-mt6779.c            |  12 +-
 drivers/clk/mediatek/clk-mt6797-img.c        |   4 +-
 drivers/clk/mediatek/clk-mt6797-mm.c         |   4 +-
 drivers/clk/mediatek/clk-mt6797-vdec.c       |   4 +-
 drivers/clk/mediatek/clk-mt6797-venc.c       |   4 +-
 drivers/clk/mediatek/clk-mt6797.c            |  22 +--
 drivers/clk/mediatek/clk-mt7622-aud.c        |   4 +-
 drivers/clk/mediatek/clk-mt7622-eth.c        |   8 +-
 drivers/clk/mediatek/clk-mt7622-hif.c        |   8 +-
 drivers/clk/mediatek/clk-mt7622.c            |  30 ++--
 drivers/clk/mediatek/clk-mt7629-eth.c        |   8 +-
 drivers/clk/mediatek/clk-mt7629-hif.c        |   8 +-
 drivers/clk/mediatek/clk-mt7629.c            |  30 ++--
 drivers/clk/mediatek/clk-mt7986-apmixed.c    |   6 +-
 drivers/clk/mediatek/clk-mt7986-eth.c        |  12 +-
 drivers/clk/mediatek/clk-mt7986-infracfg.c   |   4 +-
 drivers/clk/mediatek/clk-mt7986-topckgen.c   |  16 +-
 drivers/clk/mediatek/clk-mt8135.c            |  18 +-
 drivers/clk/mediatek/clk-mt8167-aud.c        |   4 +-
 drivers/clk/mediatek/clk-mt8167-img.c        |   4 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c     |   4 +-
 drivers/clk/mediatek/clk-mt8167-mm.c         |   4 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c       |   4 +-
 drivers/clk/mediatek/clk-mt8167.c            |  12 +-
 drivers/clk/mediatek/clk-mt8173-mm.c         |   4 +-
 drivers/clk/mediatek/clk-mt8173.c            |  69 ++++----
 drivers/clk/mediatek/clk-mt8183-audio.c      |   4 +-
 drivers/clk/mediatek/clk-mt8183-cam.c        |   4 +-
 drivers/clk/mediatek/clk-mt8183-img.c        |   4 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c       |   4 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c       |   4 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c    |   4 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c   |   4 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c     |   4 +-
 drivers/clk/mediatek/clk-mt8183-mm.c         |   4 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c       |   4 +-
 drivers/clk/mediatek/clk-mt8183-venc.c       |   4 +-
 drivers/clk/mediatek/clk-mt8183.c            |  25 +--
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c |   6 +-
 drivers/clk/mediatek/clk-mt8186-mcu.c        |   6 +-
 drivers/clk/mediatek/clk-mt8186-mm.c         |   6 +-
 drivers/clk/mediatek/clk-mt8186-topckgen.c   |   6 +-
 drivers/clk/mediatek/clk-mt8192-aud.c        |   4 +-
 drivers/clk/mediatek/clk-mt8192-mm.c         |   4 +-
 drivers/clk/mediatek/clk-mt8192.c            |  21 +--
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c |   6 +-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c |   6 +-
 drivers/clk/mediatek/clk-mt8195-topckgen.c   |   6 +-
 drivers/clk/mediatek/clk-mt8195-vdo0.c       |   6 +-
 drivers/clk/mediatek/clk-mt8195-vdo1.c       |   6 +-
 drivers/clk/mediatek/clk-mt8516-aud.c        |   4 +-
 drivers/clk/mediatek/clk-mt8516.c            |  12 +-
 drivers/clk/mediatek/clk-mtk.c               | 173 +++++++++----------
 drivers/clk/mediatek/clk-mtk.h               |  25 ++-
 drivers/clk/mediatek/clk-mux.c               |  50 +++---
 drivers/clk/mediatek/clk-mux.h               |   6 +-
 drivers/clk/mediatek/clk-pll.c               |  52 +++---
 drivers/clk/mediatek/clk-pll.h               |   6 +-
 95 files changed, 543 insertions(+), 554 deletions(-)

-- 
2.36.0.512.ge40c2bad7a-goog

