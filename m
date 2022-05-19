Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5BC52CCB0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiESHQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiESHQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:16:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A6B3584A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:16:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y41so4354466pfw.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oyJfxiPIz8g8A3U05r86isMDJTb4tby+2gyocMXQ0s0=;
        b=P8TJy0mWCyHIFuEVpcIwt+YXcwED7Y8P5hREbHFHwcEUK7qW67KgOICo3B9h2Zdhu/
         Nd/YRCcS/7Nn677WsvLvjvU6iC65Lnh6Kzqg0no+LMb/QjT8OpEUPtEuNp6ViU2TbhIr
         nIJw9ZbMMn849lWy2dTHbMtZPiWk2+4Rbk1Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oyJfxiPIz8g8A3U05r86isMDJTb4tby+2gyocMXQ0s0=;
        b=mEZ+NbF6Sk8kW+G6Rc8oE2a78CXrqQ8uZ8yX92wmNn1CdyDD6BF/cODywmpqA0hi7t
         Sv3TW+hKQGA0VdBiQJaTbGDHJ+5qo/Shnq7IlNmJ7dJAwi3XV07rn19OwJ4bKs2IRWRl
         2lsIz+zJ+rjneHvNCNxrKmeS++VG4xfpNiN68YpsML9gQ2M7JzRuPEfjFoozORwpdNSU
         uxMW921IS0T+8V4L61BiBxNpThh+1XAmdJLlv6jUPp6XerwLkDIQ1w1utSyeFiz8uVfP
         nBNSSsIpBKtw5Xfn71quHRxqlSFHQ/jfrkY38egnxjKwSj/wL8tjW70dEWdYWfH4eTZF
         C9ew==
X-Gm-Message-State: AOAM530LKV+UR7kR49CrnUZchK4pUYGAHAL4MV+c1zasSDh/wYeii2Yb
        1HrdxReST1y/GhdSkGIZZfsWAg==
X-Google-Smtp-Source: ABdhPJyJQpD7kleyvNScef5SwunEcTily4VJr1/gxKpX7bJKMyn2Kvf4NYxv5cje6E66J3T38zAvfg==
X-Received: by 2002:a05:6a00:e8e:b0:518:287c:ce82 with SMTP id bo14-20020a056a000e8e00b00518287cce82mr3516187pfb.4.1652944597421;
        Thu, 19 May 2022 00:16:37 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2338:2871:9320:bed0])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902dac200b00160c970eeb7sm2972945plx.234.2022.05.19.00.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:16:36 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] clk: mediatek: Move to struct clk_hw provider APIs
Date:   Thu, 19 May 2022 15:16:05 +0800
Message-Id: <20220519071610.423372-1-wenst@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is v3 of part 2 of my proposed MediaTek clk driver cleanup work [1].
This is the final squashed version that is ready to be merged. If you
don't see all the patches on the mailing list, it's because the third
patch is over 100K and gets blocked by LAKML and linux-clk. Please
check LKML on lore.

The version is based on next-20220518. A couple non-clk patches that
fix usage for MT8183 Juniper were included in my branch, hence the
different base hash.

Changes since v2:
- Squahed patches 3~8 as one, and 9~10 as one

Changes since v1:
- Rebased and added coverage of new MT8186 clk drivers
- Split patch "clk: mediatek: Replace 'struct clk' with 'struct clk_hw'"
  into arbitrary pieces so that they don't bounce from the mailing lists

This was tested on MT8183 Juniper by me. Angelo tested on MT8173/92/95
and MT6795 devices, while Miles tested on MT6779.

Original cover letter from v1, with patch numbers fixed:

Part 2 involves moving the whole MediaTek clk driver library from the
old `struct clk` provider API to the new `struct clk_hw` provider API.

Parts of this series were done with coccinelle scripts, while others
were done by hand. To facilitate review, these parts are currently split
into different patches. As a result however, this series is not fully
bisectable. Later on, the related parts should be squashed together.

Patch 1 and 2 are minor cleanups around code that is touched by later
patches.

Patch 3 switches of the underlying data structure used to hold clocks
from `struct clk_onecell_data` to `struct clk_hw_onecell_data`.
This part is done partly by hand, and partly with coccinelle scripts.
The helpers used to allocate the data structures are changed, but none
of the actual call sites, nor the clk provider API usage.

Patch 4 moves most of the MediaTek clk driver library from clk_register*()
to clk_hw_register*, including all intermediate helpers, using
coccinelle scripts. A call site not covered is fixed by hand.

Patch 5 converts the last usage of clk_register*() in the MediaTek clk
drivers.

This series will likely conflict with Rex's "Cleanup MediaTek clk reset
drivers" that was posted earlier today. We'll see how these work out.

The next phase of the cleanup/improvement shall be to introduce some
variant of `struct clk_parent_data` to describe clk relationships
efficiently.

Please have a look and merge.


Thanks
ChenYu

[1] https://lore.kernel.org/linux-clk/20220122091731.283592-1-wenst@chromium.org/

Chen-Yu Tsai (5):
  clk: mediatek: Make mtk_clk_register_composite() static
  clk: mediatek: apmixed: Drop error message from clk_register() failure
  clk: mediatek: Replace 'struct clk' with 'struct clk_hw'
  clk: mediatek: Switch to clk_hw provider APIs
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
2.36.1.124.g0e6072fb45-goog

