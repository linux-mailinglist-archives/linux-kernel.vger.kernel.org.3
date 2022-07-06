Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B8A5684CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiGFKKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiGFKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:09:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D365F65A1;
        Wed,  6 Jul 2022 03:09:34 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE35C66019AA;
        Wed,  6 Jul 2022 11:09:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657102173;
        bh=BAxlR3/lkspMvovn7KbmzMLiXm5omRN205BI9gc6tfg=;
        h=From:To:Cc:Subject:Date:From;
        b=kGVpgnuUA/4JhkoGIJAnlmqe8l/+JjzD+3DnA/lwseolhlVGk0tVWP9IEmq/OF7bn
         2tG4H1R2epzcQPgEpEw6MZKHjvJCXMdaVj0gLfWppmjpIgDyMan5HpcHgqap/1nvtz
         RtzlQOFCR6RRflc/Pf/NIBDRcJI9X6KRGqYb44YkSSU44hmzdvuotW9PGiMYqqn6RN
         Z7gNSUFkOHarmP4nIeaBF0iJM4PoLdCPHA+d9MVCK35+X4HexQn1Of3kTfx7o9717g
         6UJswu4Scnx0Qxqq5lBWVd7TY6GtYnKUtVoOyWrDKdj6WbElcVUdW7cUDApASAiK09
         af9yY9CmRviKg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 RESEND 0/4] MediaTek Helio X10 MT6795 - MT6331/6332 Regulators
Date:   Wed,  6 Jul 2022 12:09:08 +0200
Message-Id: <20220706100912.200698-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series adds support for the regulators found in MT6331 and MT6332
main/companion PMICs.

Adding support to each driver in each subsystem is done in different
patch series as to avoid spamming uninteresting patches to maintainers.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

Changes in v3:
 - Sorry, one of the commits picked both the pre-rename file and
   the new one... the v3 fixes the mt6332 bindings commit.
 - Changed comment style on top for mt633[12]-regulator.c as
   suggested (missed that in v2)

Changes in v2:
 - Refactored description in dt-bindings
 - Simplified get_status() function and removed callback
   where not needed
 - Simplified set_mode()/get_mode() functions and removed
   callback where not needed
 - Added new regulator_ops for no_qi (no .get_status) and
   for no_ms (no .{get, set}_mode)
 - Fixed vsel mask on some regulators and removed pattern of
   repeated voltage entries present in some voltage tables,
   avoiding to set higher bits for safety
 - Reordered regulators (and some formatting fixes) in
   mt6331-regulator.c in per-type alphabetic order

AngeloGioacchino Del Regno (4):
  dt-bindings: regulator: Add bindings for MT6331 regulator
  regulator: Add driver for MT6331 PMIC regulators
  dt-bindings: regulator: Add bindings for MT6332 regulator
  regulator: Add driver for MT6332 PMIC regulators

 .../regulator/mediatek,mt6331-regulator.yaml  | 273 ++++++++++
 .../regulator/mediatek,mt6332-regulator.yaml  | 112 ++++
 drivers/regulator/Kconfig                     |  18 +
 drivers/regulator/Makefile                    |   2 +
 drivers/regulator/mt6331-regulator.c          | 507 ++++++++++++++++++
 drivers/regulator/mt6332-regulator.c          | 422 +++++++++++++++
 include/linux/regulator/mt6331-regulator.h    |  46 ++
 include/linux/regulator/mt6332-regulator.h    |  27 +
 8 files changed, 1407 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6331-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6332-regulator.yaml
 create mode 100644 drivers/regulator/mt6331-regulator.c
 create mode 100644 drivers/regulator/mt6332-regulator.c
 create mode 100644 include/linux/regulator/mt6331-regulator.h
 create mode 100644 include/linux/regulator/mt6332-regulator.h

-- 
2.35.1

