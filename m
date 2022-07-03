Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA34564706
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiGCLUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiGCLUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:20:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE5795B5;
        Sun,  3 Jul 2022 04:20:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k7so9432561wrc.12;
        Sun, 03 Jul 2022 04:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ys1F62IdNpV/Qm6Fov0SLvZOWmQV/XxMuC4Osb9VP3g=;
        b=A/obEgi43Y/XrOWjxPTSMnaX4nxWIZFGBOMxUc3giM7Hs+5qA0v5UMzcnbXI19Ihb+
         j0a9MaKKITuZLU3A+3f3HVcxVKoj7xd1e+1AXGt4CbLBpkpeqb3U2FlWzeRUS0+uG8WJ
         vqY2Uvt6xWL2chS9oA627wQ+HuGiyrc8IRYZACGEl+Ae7ciy4MigXlbFeZcuAFQuFbmv
         udpPjzEDV1+iEzfQGtjo3B91ienIReVZM/TXWkka/sD91bD9tmAuttzWH8XHkrHKDQwx
         9JX+xvgXmluZujH/nba0iiQUTeq/L8KJtYnxPUi1qwY6AbfKXIK1ntC5spepjn7qfLNT
         TzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ys1F62IdNpV/Qm6Fov0SLvZOWmQV/XxMuC4Osb9VP3g=;
        b=x291UNWPMCY0ALkHWEKinJNxelbNqjIFh4HMP2EBv55jZHPnQTCQJAY29OsGIa9aXl
         +VvN9k65zpTLYuuddkvcZEkMpTnp+QMlLl/XrkruAPKjIcWJfxwjXkftDDwMJvzviQCv
         FIKVDNCVh3d6oMIxEHLns45RuL9f9pjTH8P1N1YIK25gMDkruFm3nMURXvTtVA1eX9QO
         Bj5NYPUwmf0PJcBeRKY3ILMi610gpYej82+YttZljpZeVK0DD8EMV/+fn0yTwIUixUrB
         1yOhacnp7eOi9fKZrUkWeSfUO/uvaus3dBFjx74wUynW2Z9w4b5R4ukedwWfMBamEEcm
         YwsQ==
X-Gm-Message-State: AJIora/JDNHo/aMz8cG7+Hp2YZCp312+71Om01KfMthz3GC9J0oVLu3s
        Vyj2NQTaKhH3D+STiY1qa6E=
X-Google-Smtp-Source: AGRyM1tbN4Irq6G2WX6betUzmP+c77CpTufU2zhh+r8IyjnxF0xmnGTIfnu6oQjAzsRv8K/Tkm8Tug==
X-Received: by 2002:a05:6000:1f08:b0:21b:ae8f:4f0a with SMTP id bv8-20020a0560001f0800b0021bae8f4f0amr22800322wrb.456.1656847210550;
        Sun, 03 Jul 2022 04:20:10 -0700 (PDT)
Received: from localhost (92.40.202.9.threembb.co.uk. [92.40.202.9])
        by smtp.gmail.com with ESMTPSA id n5-20020a1ca405000000b0039c587342d8sm12301710wme.3.2022.07.03.04.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 04:20:09 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andy.shevchenko@gmail.com, krzk@kernel.org,
        m.szyprowski@samsung.com, mazziesaccount@gmail.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 00/12] regmap-irq cleanups and refactoring
Date:   Sun,  3 Jul 2022 12:20:49 +0100
Message-Id: <20220703112101.24493-1-aidanmacdonald.0x0@gmail.com>
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

This series is an attempt at cleaning up the regmap-irq API in order
to simplify things and consolidate existing features, while at the
same time generalizing it to support a wider range of hardware.

There is a new system for IRQ type configuration, some tweaks to
unmask registers so they're more intuitive and useful, and a new
callback for calculating register addresses. There's also a few
minor code cleanups in here.

Several existing features have been marked deprecated. Warnings will
be issued for any drivers that use deprecated features, but they'll
otherwise continue to function normally.

One important caveat: not all of these changes are tested beyond
compile testing, since I don't have hardware to exercise all of
the features.

v3 changelog

* Fix bug in patch 11/12 reported by Marek Szyprowski
  https://lore.kernel.org/lkml/acaaf77f-3282-8544-dd3c-7915fc1a6a4f@samsung.com/

v2 changelog

* Drop driver patches, these will be sent as separate series to the
  appropriate subsystem maintainers.
* Drop patches that remove deprecated features, that should be done
  in a separate series.
* Various fixups to address Andy Shevchenko's v1 review comments.
* Drop patches that changed the behavior of mask_writeonly; instead
  just remove the flag.

Aidan MacDonald (12):
  regmap-irq: Convert bool bitfields to unsigned int
  regmap-irq: Remove unused type_reg_stride field
  regmap-irq: Cleanup sizeof(...) use in memory allocation
  regmap-irq: Remove an unnecessary restriction on type_in_mask
  regmap-irq: Remove inappropriate uses of regmap_irq_update_bits()
  regmap-irq: Remove mask_writeonly and regmap_irq_update_bits()
  regmap-irq: Refactor checks for status bulk read support
  regmap-irq: Introduce config registers for irq types
  regmap-irq: Deprecate type registers and virtual registers
  regmap-irq: Fix inverted handling of unmask registers
  regmap-irq: Add get_irq_reg() callback
  regmap-irq: Deprecate the not_fixed_stride flag

 drivers/base/regmap/regmap-irq.c | 432 +++++++++++++++++++++----------
 include/linux/regmap.h           | 104 +++++---
 2 files changed, 367 insertions(+), 169 deletions(-)

-- 
2.35.1

