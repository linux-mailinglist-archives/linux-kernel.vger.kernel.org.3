Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF62506698
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbiDSIPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239279AbiDSIPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:15:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E19A2981F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:13:00 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b7so5031919plh.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJS2hJenJldyL6QnmX1ihHYBKXvEoZf1gwDmlsvsiH0=;
        b=Mr4oR8QDQY1eJMvYaK3mFzBcZsdZ2spX8b15ThU1VejxeKtT79otFJBVC9nj2qDzZX
         hyuigr73nga9epHNJeZcqbwi4n8FB4X+EadSjNLM7FdSPpVRCBw47cRR0tV76gdfTJmM
         aUAau/ooxvj56ME07V+rqlvhfcfpNOH1syqzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJS2hJenJldyL6QnmX1ihHYBKXvEoZf1gwDmlsvsiH0=;
        b=z8xXuk8nCQJanmAAq//WfwNzDf7eSE71tT88YEx+UyNl0caBP+Y3ZvEYDZcqepsmT7
         z+1aAIjSnj8S3wrj+0CgMD9wyjBZX4yO6swb48+T6QlzywYc1WRaMPp0rTJKwvuBE4uC
         zeAUnit7QeDa36TqhgzupADproFcwdee+Y3El6SgIl491P8vcj0c2EErEb9z2a466jrg
         fObhN/7+WlrvDIkulifNMn8ZNYtk47AtDlmKIxUtUf7ZpEOmPbaPvNEQJ/SASi5qeAb0
         LmILpXZo1b0heoNpnf85QABLEUZS/z23496zBAhIRGmtinPQsUq7Qp8WRvbg56CBdWUs
         Y/KA==
X-Gm-Message-State: AOAM533YjLMOyOsCgUk4gQQQRxkIMdmnt8cjWNvnt6p4Yjs5mAGVkO/g
        9MxIW/94KA0qxEoNT/QX70rAdw==
X-Google-Smtp-Source: ABdhPJxXfBzegevdRA3wHfXndcdUtZ91I5IAndHrDASqCN9KGF95zjolQiA9hcRRUItZ6pCeQdxS0g==
X-Received: by 2002:a17:90b:3810:b0:1d1:b184:1ead with SMTP id mq16-20020a17090b381000b001d1b1841eadmr17449829pjb.89.1650355979845;
        Tue, 19 Apr 2022 01:12:59 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:33f6:f1e6:3e21:a253])
        by smtp.gmail.com with ESMTPSA id n13-20020a654ccd000000b0039db6f73e9dsm15767448pgt.28.2022.04.19.01.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 01:12:59 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/7] clk: mediatek: Move to struct clk_hw provider APIs
Date:   Tue, 19 Apr 2022 16:12:39 +0800
Message-Id: <20220419081246.2546159-1-wenst@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is part 2 of my proposed MediaTek clk driver cleanup work [1].

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

Patch 4 finishes the switch from `struct clk_onecell_data` to `struct
clk_hw_onecell_data`. All the holding variables and call sites that
involve `struct clk_onecell_data` are changed using coccinelle scripts.

Patch 5 moves most of the MediaTek clk driver library from clk_register*()
to clk_hw_register*, including all intermediate helpers, using
coccinelle scripts.

Patch 6 fixes, by hand, a build error from a call site that was not covered
by the previous patch.

Patch 7 converts the last usage of clk_register*() in the MediaTek clk
drivers.

As mentioned above, this series includes parts that don't build, but are
split out for clarity. These are patches 3 and 5. Once the patches are
reviewed, they shall be squashed together.

This series doesn't cover the new MT8186 clk driver, which is fully
reviewed on the mailing lists, but not yet queued up. I think it would
be better to have that series merged, and I can rerun the coccinelle
scripts to add coverage.

This series will likely conflict with Rex's "Cleanup MediaTek clk reset
drivers" that was posted earlier today. We'll see how these work out.

The next phase of the cleanup/improvement shall be to introduce some
variant of `struct clk_parent_data` to describe clk relationships
efficiently.

Please have a look.


Thanks
ChenYu

[1] https://lore.kernel.org/linux-clk/20220122091731.283592-1-wenst@chromium.org/


Chen-Yu Tsai (7):
  clk: mediatek: Make mtk_clk_register_composite() static
  clk: mediatek: apmixed: Drop error message from clk_register() failure
  clk: mediatek: Convert mtk_{alloc,free}_clk_data to struct clk_hw
  clk: mediatek: Replace 'struct clk' with 'struct clk_hw'
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
 91 files changed, 531 insertions(+), 542 deletions(-)

-- 
2.36.0.rc0.470.gd361397f0d-goog

