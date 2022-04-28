Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AE1513A31
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350251AbiD1Qri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350260AbiD1Qrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:47:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52589B2467;
        Thu, 28 Apr 2022 09:44:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 129so3301049wmz.0;
        Thu, 28 Apr 2022 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WN0HGdKpWoSZ0LiSed55nop2VOLSomnBY77ipXlmIVo=;
        b=V9CGZZDheuRNpjCUW+jbajRmXNYBF/ds4+4HUjCxNLHTKSBzKfrj7/BghHgsAnhymE
         4LKopQUSwp/ERCUkww8wnsO45a+VcViAE1nOvFDrGjiFg7VoALTSBP2Gp+XLYBESp5bO
         8NkbJ8Mi3g7OZ8H+Rs5E5vJtfub3foxvnKHZm/9931jtKdBQIk2eQ7x/taGu/FitZGr6
         gKalr4MfcVnO7CbDhooYPyBru5sv4PJdeItPjAQHKEaGuzc8AW0VIAVU34cTsoCJVO9B
         5aZZiC6Zwow9cnFrx3+CfXZXLXdResBjlERUr7S0Gq1YXsleW+ITO9mdsqjBCA8eRUEm
         kyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WN0HGdKpWoSZ0LiSed55nop2VOLSomnBY77ipXlmIVo=;
        b=12aLZ9aZeoejMTmyCxB2OBkBl8bQdBYzGyLGGK8eHxmh8vc2nQduYdta47AqkFErkU
         duyp8uF+UcKsnC8rAhGA2zzzRyKSYhL2YHFhMSawJVE5h1bWFYC3789gOvdv2DuE+8RM
         LS2BuyybiF2zFMr+3uEWC99GOo5jjfdx3xmPifSgZ1XiPOATgyXWeQVDfSarExsUDxwF
         XHFq3PsACVL6af7PQF9d67yAgyCElXrLIi+ziQDYUjZfgIRqoPZG3vJUGXc3gboCRaan
         4kWKdrdVZEmQtGRsey9k9GpOYDTFV51u3aQKU7MMF0KEjxknZm/UiKkcrmVO+HnY1ykW
         LncQ==
X-Gm-Message-State: AOAM531tS/JYFc55t+5te9/NPPAlipo0TZwUYbM0kKjNq2OGiTrHZTNl
        DQh0WJBuiBmL24dFAr42sE8=
X-Google-Smtp-Source: ABdhPJxobhyOyDJaoF16yg7Aob/pFOO3tu1f7qRSIxDY0GG+TE/ClXR9kY5ixY0FZ3F1zhZWvABC8Q==
X-Received: by 2002:a05:600c:1e1d:b0:394:1b19:e347 with SMTP id ay29-20020a05600c1e1d00b003941b19e347mr712517wmb.202.1651164259847;
        Thu, 28 Apr 2022 09:44:19 -0700 (PDT)
Received: from localhost (92.40.203.206.threembb.co.uk. [92.40.203.206])
        by smtp.gmail.com with ESMTPSA id f189-20020a1c38c6000000b0038ff83b9792sm4453035wma.43.2022.04.28.09.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:44:19 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     sboyd@kernel.org, mturquette@baylibre.com,
        tsbogend@alpha.franken.de
Cc:     paulburton@kernel.org, paul@crapouillou.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 0/3] Clock fixes for Ingenic SoCs
Date:   Thu, 28 Apr 2022 17:44:51 +0100
Message-Id: <20220428164454.17908-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran across a problem trying to get Linux running on an Ingenic X1000 SoC:
since the memory clock isn't referenced by any driver, it appears unused and
gets disabled automatically. After that, the system hangs on any RAM access.

There is a hack in board-ingenic.c to forcibly enable the CPU clock, but this
is insufficient for the X1000 since the memory clock has its own gate and mux
that isn't tied to the CPU.

This patch series fixes the bug by adding CLK_IS_CRITICAL flags to important
clocks, which seems to be the approach used in many other SoC clock drivers.

v2: Add comments to patch 02 to explain why we need CLK_IS_CRITICAL.

Aidan MacDonald (3):
  clk: ingenic: Allow specifying common clock flags
  clk: ingenic: Mark critical clocks in Ingenic SoCs
  mips: ingenic: Do not manually reference the CPU clock

 arch/mips/generic/board-ingenic.c | 26 --------------------------
 drivers/clk/ingenic/cgu.c         |  2 +-
 drivers/clk/ingenic/cgu.h         |  3 +++
 drivers/clk/ingenic/jz4725b-cgu.c | 10 ++++++++++
 drivers/clk/ingenic/jz4740-cgu.c  | 10 ++++++++++
 drivers/clk/ingenic/jz4760-cgu.c  | 10 ++++++++++
 drivers/clk/ingenic/jz4770-cgu.c  |  5 +++++
 drivers/clk/ingenic/jz4780-cgu.c  | 15 +++++++++++++++
 drivers/clk/ingenic/x1000-cgu.c   | 15 +++++++++++++++
 drivers/clk/ingenic/x1830-cgu.c   | 11 +++++++++++
 10 files changed, 80 insertions(+), 27 deletions(-)

-- 
2.35.1

