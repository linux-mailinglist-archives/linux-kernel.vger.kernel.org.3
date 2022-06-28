Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAE655CAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345497AbiF1L2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345460AbiF1L2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:28:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5073CE5C;
        Tue, 28 Jun 2022 04:28:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u12so25057171eja.8;
        Tue, 28 Jun 2022 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=inDOpdCUQzR/8S+9fAaTVfT632HEMGCp6YCOVifU2kw=;
        b=jc4hFd9jdYGeJvFHrv+UO/R44jwrsXG/F4bCuk6p2pdqGMD6t0HviouLBwPhg4MqLz
         tkTnQeX0ybNvr8ftVO/yDIlPi320Lz2+Oy/2JewLRneLeI5ww/p7Iu2lIPmEsPFCya7S
         qKT0JQ1Y3XOXW4iel31odz9r8fkulW0fz0kHPKHgXCpESS8nVOjs9YdYgGyJMeXVj0Qf
         fDL4/JNAaDLk5KKQ1ia3lF27yjQqAhR/wBxFZOChWksQ2L16R4SZ5j9033XVExEPt0ni
         HATqEwo6Z/Mc5JsxDJnNOFOUDoHhhWIX3OWG/k3bw9K2fA3H8lb22Jw3ST3iESjyjPZN
         onvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=inDOpdCUQzR/8S+9fAaTVfT632HEMGCp6YCOVifU2kw=;
        b=bziMTi96VCxl6aSu+zq5rXnnEYwfp3fAxFCtaVJ6v4tLzfPYEZp58HPNN8+RuEBbvz
         EDUQs1BisQoBd33lWYlVHoDvbjJlVLgyS6y8ScXwZM1WNyLold2C5U8q6DPS6nh5FiYA
         cKkbXaPki5auxGkjrgwRLoR0X9zvlTfA1WrE4AMGsgv7b8BVy4BWCbZoSIYxEnUIuqfM
         qTmnR6oNJQ+XLZoePWPoNW87eTjs1X9OCPbbyEp/KaI+b8PZSYy42taKEc6SpAQcPPfI
         G4VepGBE5MUVW4H4C5uClRWbeykcKPiClD203vB55/HqI8DRQ1vpmVJZPXE8Jqb0LlI0
         2RNA==
X-Gm-Message-State: AJIora9HI7qJEdFJ8LlGfprdCRnaTfjbdwfSdniOgprOybbmcTrPFFLW
        bJpNw12zpjnEF0C2bCAtKZ7dZTUOkIE=
X-Google-Smtp-Source: AGRyM1ur91VeMBh2tzN91CwCPguBdLKKSYQdo3d8X5J02oGrVOU4qUlP2KJPKAAD/IaJT61hEvc3kA==
X-Received: by 2002:a17:907:94ce:b0:726:449e:73cc with SMTP id dn14-20020a17090794ce00b00726449e73ccmr16313870ejc.270.1656415686765;
        Tue, 28 Jun 2022 04:28:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id h6-20020aa7cdc6000000b00435720b7a1csm9456318edw.20.2022.06.28.04.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:28:06 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 0/8] intel-nand-controller: Fixes, cleanups and questions
Date:   Tue, 28 Jun 2022 13:27:23 +0200
Message-Id: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
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
   reg property. In the dt-bindings example this is 0xe0f00000. I don't
   understand how this can even work on Intel SoCs. My understanding is
   that it must be read from the NAND chip (child node).
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

Before this series is applied it would be great to have these questions
answered:
- My understanding is that the chip select line (reg property of the
  NAND controller's child node) refers to the chip select line of the
  controller. Let's say we have a controller with two CS lines. A NAND
  flash chip (which a single chip select line) is connected to the
  second CS line of the controller. Is my understanding correct that
  the NAND chip device-tree node should get reg = <1> in this case?
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


Best regards,
Martin


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

 .../bindings/mtd/intel,lgm-nand.yaml          |  8 +++---
 drivers/mtd/nand/raw/intel-nand-controller.c  | 28 +++++++++----------
 2 files changed, 17 insertions(+), 19 deletions(-)

-- 
2.36.1

