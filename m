Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6F55835E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiG1AGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiG1AGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:06:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F09A455
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=56XHhnZ45uD7kuhdi5C7kKwazdECR0dfnBBECKqYRcs=; b=PcSdeyu64JbC+rRhu6t9oo4pmt
        1nGvMV0L9WCeQRCEUrcF77aowjEiJgOf/JrhDrOXizT+T9W6twzTbMjm79bcHNAfZ2IqPMeM0d3TQ
        HvxXTX8NTaevdbGjXCVwAi8EeQPxI/7NJstpeqdC4uXCyl8u41ZboXDSzzIgeK49vYFWKbCP0kdFv
        Q/dHKCHot6Abuw4/7wDVwzkJmu8FWPK6IWfpHoRxvVJ6KUpsSrwDut8X1e0svIAaotRYRtLxh/F33
        8YY+StwBhnEi5+s41DzqxPOBYgjgartLwHP3L18vFALCvAL6gRmlBYCfLx3na5n+3UffWrbc3c9RV
        c3/rlY6A==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGr2I-003N22-Ph; Thu, 28 Jul 2022 00:05:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH] mux: mmio: depends on REGMAP
Date:   Wed, 27 Jul 2022 17:05:50 -0700
Message-Id: <20220728000550.10495-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when CONFIG_REGMAP is not set/enabled:

../drivers/mux/mmio.c: In function ‘mux_mmio_probe’:
../drivers/mux/mmio.c:76:34: error: storage size of ‘field’ isn’t known
   76 |                 struct reg_field field;
../drivers/mux/mmio.c:102:29: error: implicit declaration of function ‘devm_regmap_field_alloc’ [-Werror=implicit-function-declaration]
  102 |                 fields[i] = devm_regmap_field_alloc(dev, regmap, field);
../drivers/mux/mmio.c:76:34: warning: unused variable ‘field’ [-Wunused-variable]
   76 |                 struct reg_field field;

Most drivers that use REGMAP select it, but trying to use 'select'
here causes a ton of recursive/circular dependency chains, so just
use "depends on" to prevent the build errors.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 73726380a26f ("mux: mmio-based syscon mux controller")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Rosin <peda@axentia.se>
---
 drivers/mux/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -48,6 +48,7 @@ config MUX_GPIO
 config MUX_MMIO
 	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
 	depends on OF || COMPILE_TEST
+	depends on REGMAP
 	help
 	  MMIO/Regmap register bitfield-controlled Multiplexer controller.
 
