Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C144FB92F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345199AbiDKKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345177AbiDKKQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:16:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8674B140A6;
        Mon, 11 Apr 2022 03:14:20 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e21so5751975wrc.8;
        Mon, 11 Apr 2022 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eqcGjjm4t9oja+wPiB6DWrW8xnu61nXeB06A5pikcg=;
        b=UA7ENPCXOxx/YrFjB425AB1sIrOppxca9ehmwGxQEysxoHrSF4c09veGHwTzbuPSoG
         lQRKftye/P10K3xLbfsFKxZUVDrggIEqqu8uf16Jg4dRDWTHvkdw6w81APN3QD2ko03S
         xL3CXZhbiO3AuEzydbNJg1H4OF2UTIQLkMWgWDvxQO9dxmdjsbEUFLMP5JXjhojScnIb
         3yHaVV/DqiwpVfeHBvNG7hWiufMdcpdMyWAO5rljP8LiG64P6sD50LOAnyQ8AZb02+G9
         HfCbIEkN8BC0YSH9jil1xIBoKD8AV4+dKUxjTi/4DpmfxMmjameAwN9Z7fIJy/fmMvgm
         QTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0eqcGjjm4t9oja+wPiB6DWrW8xnu61nXeB06A5pikcg=;
        b=2AVkWadwp5XePpVdZz6JQ7fOpoGEHwFlfbS9k0CQ692HE8Bu5fyG90mG0Etugt9h3D
         CjfaW3+LERZLRJWf+++UH33ilt3zYzehFJuxLFqzhSD1ayQW+t1f54+hDuyODqHQ1SMF
         Kbv7DNBUIFMOOHdQZYMN53Zf4vWRHNFtwoY+3n10ayIUST/vBBmwbfYh6kW7Bi4l4ybH
         y9Iid5KCEnVFsQkXzQp+YdE1MEdWXezo6TC8gXnUEPyaVn9/TXLBbFA2LocsZm9+Y+E5
         d4QArADShk3gMjsc1UG/AmaGHwvOmYW1p/vIqyjhBz3w+UT4pVTVP7LtAlQgERMWjTkE
         17Rg==
X-Gm-Message-State: AOAM533HjJ6F8jAuyQOeCwLDC9K5Bg+0ggLenctskppPs+zOfryX0SeN
        plq2Ppq8qi6kRlAPEq94a/Mah+PnPWpuCQ==
X-Google-Smtp-Source: ABdhPJzZ6poXDmBpCLIfKa0Mi4rY711qe1bn5+Ah7QyWxhxzSgDuNDMHiJte1o9u98OH6Tm2iWixew==
X-Received: by 2002:a5d:5986:0:b0:205:87ae:9e18 with SMTP id n6-20020a5d5986000000b0020587ae9e18mr24751709wri.537.1649672059138;
        Mon, 11 Apr 2022 03:14:19 -0700 (PDT)
Received: from localhost (92.40.202.18.threembb.co.uk. [92.40.202.18])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0038ceb0b21b4sm20526369wmq.24.2022.04.11.03.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:14:18 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, paulburton@kernel.org,
        tsbogend@alpha.franken.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [RESEND PATCH 0/3] Clock fixes for Ingenic SoCs
Date:   Mon, 11 Apr 2022 11:14:38 +0100
Message-Id: <20220411101441.17020-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending this series since it appears none of the patches were picked up
the first time around.

I ran across a problem trying to get Linux running on an Ingenic X1000 SoC:
since the memory clock isn't referenced by any driver, it appears unused and
gets disabled automatically. After that, the system hangs on any RAM access.

There is a hack in board-ingenic.c to forcibly enable the CPU clock, but this
is insufficient for the X1000 since the memory clock has its own gate and mux
that isn't tied to the CPU.

This patch series fixes the bug by adding CLK_IS_CRITICAL flags to important
clocks, which seems to be the approach used in many other SoC clock drivers.

Original submission:
https://lore.kernel.org/linux-mips/20220208010048.211691-1-aidanmacdonald.0x0@gmail.com/

Aidan MacDonald (3):
  clk: ingenic: Allow specifying common clock flags
  clk: ingenic: Mark critical clocks in Ingenic SoCs
  mips: ingenic: Do not manually reference the CPU clock

 arch/mips/generic/board-ingenic.c | 26 --------------------------
 drivers/clk/ingenic/cgu.c         |  2 +-
 drivers/clk/ingenic/cgu.h         |  3 +++
 drivers/clk/ingenic/jz4725b-cgu.c |  2 ++
 drivers/clk/ingenic/jz4740-cgu.c  |  2 ++
 drivers/clk/ingenic/jz4760-cgu.c  |  2 ++
 drivers/clk/ingenic/jz4770-cgu.c  |  1 +
 drivers/clk/ingenic/jz4780-cgu.c  |  3 +++
 drivers/clk/ingenic/x1000-cgu.c   |  3 +++
 drivers/clk/ingenic/x1830-cgu.c   |  3 +++
 10 files changed, 20 insertions(+), 27 deletions(-)
-- 
2.35.1

