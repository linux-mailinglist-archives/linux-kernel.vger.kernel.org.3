Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFFC52D519
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbiESNuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239203AbiESNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:50:27 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E422F3A9;
        Thu, 19 May 2022 06:50:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id a22so4753482qkl.5;
        Thu, 19 May 2022 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vBqh7Tk2z2K1YwGYzAH4brkfEyxgFWvHmBvnWHs1Zp4=;
        b=flFbqmZxx9iM5vRGY/4eQBnTHrzZe9ShyTGtUfoI5IhkuVrEkViYFtkY0ApjDpQSma
         NKGWwmHhnQwHti46okHFeiW/Vtm17DAPZJx4zvDOTHmG7cBoWd2e0yPyDTGquH+Qw0d6
         PIZzIC09nejA7WeWV0LroOLgNA0Hl2CcBLAa6vurXGShpfQxd3EoHmP9jF3cK9bC7Gnb
         //ytY6uTxONFx3cQLZKrymmAgwdIYRK9wXCtm+RqcY2rS1IXl+TQa9gpzDfLsvfIOamZ
         RM+kXX+Eb/JQ8cqxn9PD7HkJ80bnOMwV5J44IX4C0C/z80B65gpi5bxua3DxtdUtrUV5
         484g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vBqh7Tk2z2K1YwGYzAH4brkfEyxgFWvHmBvnWHs1Zp4=;
        b=TOzCxCuho+E8krO26p0HqpA5XzO2eNDD+ROZMrYAxm4z5vw/70kYX+5bpAOp9YZFaz
         FdAjEjC+TwEvxo9w0GPIxReTwDGVhPHbxQS2dqxA+I7juifrKRTDoFZUZhRXVU9y/cwA
         p4TatSOx5uZyFvLN/OFLnEJ+VKwFGHE8DE5BfPdgI5l5XHwG2PraqW8QzEtOOn9ElET5
         ADSEpDCjS/KsplcnrwO/pkk9Quv2vFNhycuh/6HL20WEdB3lZMOBNNqKbwPaiMdxsMky
         3xcfh8Q6VLafcTCWkGYLgzH7XRaLUEOGKjHrTSQVL2deaeAsO4QkI4lkmrf7fo5TdP7b
         MiJA==
X-Gm-Message-State: AOAM530xGYV/FGVX/Wn5S284M8bYL9W+y4cR9lyf+XwauGu6p1p1agMG
        qaDhX3RzlNFsQWBYRQbj9TY=
X-Google-Smtp-Source: ABdhPJy0wt0R0C+qdbicIKHg86HWjUDyYZscDjDdlgPI+3OgR1c1hrYBu5g+wbK5WOVdKMQ9Sqfrpw==
X-Received: by 2002:a37:8641:0:b0:67e:85d1:f5e9 with SMTP id i62-20020a378641000000b0067e85d1f5e9mr3195651qkd.128.1652968155429;
        Thu, 19 May 2022 06:49:15 -0700 (PDT)
Received: from localhost.localdomain ([217.138.206.82])
        by smtp.gmail.com with ESMTPSA id i186-20020a3754c3000000b0069fc13ce23dsm1315024qkb.110.2022.05.19.06.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:49:15 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 0/6] clk: mediatek: Improvements to simple probe/remove and reset controller unregistration
Date:   Thu, 19 May 2022 17:47:22 +0400
Message-Id: <20220519134728.456643-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series started as part of an earlier series adding support for the main
clock controllers on MediaTek MT6735[1]. It has since been split off and
expanded. It adds a new function to unregister a reset controller and expands
the mtk_clk_simple_probe/remove functions to support the main 5 types of clocks:
- PLLs		(new)
- Fixed clocks	(new)
- Fixed factors	(new)
- Muxes		(new)
- Gates		(supported previously)
This should allow it to be used in most clock drivers, resulting in reduced
code duplication. It will be used in MT6735 clock drivers in the upcoming v2
of the MT6735 main clock controller series.

Dependencies:
- clk: mediatek: Move to struct clk_hw provider APIs (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220510104804.544597-1-wenst@chromium.org/ 
- Cleanup MediaTek clk reset drivers and support MT8192/MT8195 (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220503093856.22250-1-rex-bc.chen@mediatek.com/
- Export required symbols to compile clk drivers as module (single patch)
  https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/

Yassine Oudjana (6):
  clk: mediatek: gate: Export mtk_clk_register_gates_with_dev
  clk: mediatek: Use mtk_clk_register_gates_with_dev in simple probe
  clk: mediatek: reset: Return reset data pointer on register
  clk: mediatek: reset: Implement mtk_unregister_reset_controller() API
  clk: mediatek: Unregister reset controller on simple remove
  clk: mediatek: Add support for other clock types in simple
    probe/remove

 drivers/clk/mediatek/clk-gate.c   |   1 +
 drivers/clk/mediatek/clk-mt8192.c |   7 +-
 drivers/clk/mediatek/clk-mtk.c    | 123 +++++++++++++++++++++++++-----
 drivers/clk/mediatek/clk-mtk.h    |  22 +++++-
 drivers/clk/mediatek/reset.c      |  41 ++++++----
 drivers/clk/mediatek/reset.h      |  20 +++--
 6 files changed, 167 insertions(+), 47 deletions(-)

-- 
2.36.1

