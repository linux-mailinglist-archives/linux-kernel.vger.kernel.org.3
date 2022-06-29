Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF044560BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiF2Vf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF2VfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:35:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1600F31361;
        Wed, 29 Jun 2022 14:35:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n8so10036687eda.0;
        Wed, 29 Jun 2022 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LiKkW3yHrZaOOcbsnGJ7HkRfakbETu6k5duCEkXFxQA=;
        b=CUuuBdlRNPLWLJMR1JLJq4smnvGh0RJx2mmdis0JaP8rYXin3oTnaKbbUmYPwOorkh
         KwovYJAhc9vh6+GSEc0XLl5wwxhDV86OjhbOfVXkQPhwWLbk3BQ2y1z444ozVPuIO5Bo
         ogZSK/GoxYxCLOL74AO/dHaXWp0u80R4TzE7R57rq8R/a2y8T990ZQ9mFUp1QCH6Jthq
         7qM/Im8WsK4S/kWeJQmVtgyhOnXd6bbfLYzqQ0dQFN9d9e+k55ZVBNEK1+6TVHnArCCd
         +jFydRDsbiejk2rqysJ0o1z17SVIpMVAh2JwJsD2NHvT1yc6eFmXhE6aSAr7sWNScM0O
         hDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LiKkW3yHrZaOOcbsnGJ7HkRfakbETu6k5duCEkXFxQA=;
        b=TkgYp1rtutTsM0LrZh8SCtql7HYCbgP+zDKCkgOwpaEoTDMTr+DGQqhoeFMRzmJKPT
         2qWIsjF2u6igcljhx3luStUnz+ElMo9gdIEz7sR7X3mISV42ZFaw1TLe2RIk/cGibm83
         dLz2xUjha7voUAjzfQqDoZKmiYoYTGI6wWpS7uJeHPWg3QGJRQqFC7MtzDKyncaMT3W3
         I8RW+NgmEWL9sIjczMjZzxTSQFsVOjnuGNmODrjcIPU4u352ODt0JqA5HnQbdpO3UpRS
         LqG3B5o/ipLr0mlzhMt8nX4ugHRVK5ILynadjPCHY99rS85TUOksflz5dfUmyTPfEKvu
         3mgQ==
X-Gm-Message-State: AJIora8VCUGKCP9tRO+KFDpb5hwFFdeRbrxLd1lLC0XCZYZ6sYPuFm/0
        hQoC/iFfKjM80HAqMtgRYoc=
X-Google-Smtp-Source: AGRyM1tAIMpGgefHqFCQRWYzZ9NqwtuvUALqqzBrXrxab6zN2iTDYh/IcdKg27jf4rqdsxg3qkPAWw==
X-Received: by 2002:a05:6402:2684:b0:435:afac:3670 with SMTP id w4-20020a056402268400b00435afac3670mr7434140edd.262.1656538519427;
        Wed, 29 Jun 2022 14:35:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-003-132.77.7.pool.telefonica.de. [77.7.3.132])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1709066c8700b0070c4abe4706sm8237889ejr.158.2022.06.29.14.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:35:18 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/8] intel-nand-controller: Fixes, cleanups and questions
Date:   Wed, 29 Jun 2022 23:35:00 +0200
Message-Id: <20220629213508.1989600-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.0
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

Hello,

I am trying to replace the xway_nand driver (which is still using the
legacy NAND API) with the intel-nand-controller driver. The Intel LGM
IP (for which intel-nand-controller was implemented) uses a newer
version of the EBU NAND and HSNAND IP found in Lantiq XWAY SoCs. The
most notable change is the addition of HSNAND Intel LGM SoCs (it's not
clear to me if/which Lantiq SoCs also have this DMA engine).

While testing my changes on a Lantiq xRX200 SoC I came across some
issues with the intel-nand-controller driver. The problems I found are:
1) Mismatch between dt-bindings and driver implementation (compatible
   string, patch #1 and patch #4) and hardware capabilities (number of
   CS lines, patch #1).
2) The driver reads the CS (chip select) line from the NAND controller's
   reg property. In the dt-bindings example this is 0xe0f00000. Instead
   it must be read from the NAND chip (child node).
3) A few smaller code cleanups to make the driver easier to understand
   (patches #5 to #8)
4) I tried to understand the timing parameter calculation code but found
   that it probably doesn't work on the Intel LGM SoCs either. The
   dt-bindings example use clock ID 125 which is LGM_GCLK_EBU. So far
   this is fine because EBU is the actual IP block for the NAND
   interface. However, drivers/clk/x86/clk-lgm.c defines this clock as
   a gate without a parent, so it's rate (as read by Linux) is always 0.
   The intel-nand-controller driver then tries to calculate:
     rate = clk_get_rate(ctrl->clk) / HZ_PER_MHZ
   (rate will be 0 because clk_get_rate() returns 0) and then:
     DIV_ROUND_UP(USEC_PER_SEC, rate)
   (this then tries to divide by zero)

For me to move forward with the transition from xway_nand to the
intel-nand-controller driver I to understand a few more details:
- Who from Maxlinear (who took over Intel's AnyWAN division, which
  previously worked on the drivers for the Intel LGM SoCs) can send a
  patch to correct the LGM_GCLK_EBU clock rate in
  drivers/clk/x86/clk-lgm.c? Or is LGM dead and the various drivers
  should be removed instead?
- Who from Maxlinear can provide insights into which clock is connected
  to the EBU NAND controller on Lantiq XWAY (Danube, xRX100, xRX200,
  xRX300) SoCs as well as newer GRX350/GRX550 SoCs so that I can make
  the intel-nand-controller work without hardcoded timing settings on
  the XWAY SoCs?

Due to the severity of issues 2) and 4) above I am targeting linux-next
with this series. In my opinion there's no point in backporting these
fixes to a driver which has been broken since it was upstreamed.

Changes since v1 from [0]:
- Thanks to Miguel for confirming that the reg property of the NAND chip
  is the chip select number of the NAND controller. I removed a question
  about this from the cover-letter.
- Fixed accidental $id change in patch #1 which fixes a binding error
  reported by Rob's bot
- Dropped RFC status


Best regards,
Martin


[0] https://lore.kernel.org/linux-mtd/20220628163850.17c56935@xps-13/T/#m4b2b6e1c970adf074a17ab9568637aff90e6ca36


Martin Blumenstingl (8):
  dt-bindings: mtd: intel: lgm-nand: Fix compatible string
  dt-bindings: mtd: intel: lgm-nand: Fix maximum chip select value
  mtd: rawnand: intel: Read the chip-select line from the correct OF
    node
  mtd: rawnand: intel: Remove undocumented compatible string
  mtd: rawnand: intel: Don't re-define NAND_DATA_IFACE_CHECK_ONLY
  mtd: rawnand: intel: Remove unused nand_pa member from ebu_nand_cs
  mtd: rawnand: intel: Remove unused clk_rate member from struct
    ebu_nand
  mtd: rawnand: intel: Use devm_platform_ioremap_resource_byname()

 .../bindings/mtd/intel,lgm-nand.yaml          |  6 ++--
 drivers/mtd/nand/raw/intel-nand-controller.c  | 28 +++++++++----------
 2 files changed, 16 insertions(+), 18 deletions(-)

-- 
2.37.0

