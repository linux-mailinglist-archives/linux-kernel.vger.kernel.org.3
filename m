Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A081F5389EF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243600AbiEaCaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243573AbiEaC3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:29:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14A99347D;
        Mon, 30 May 2022 19:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=NJejcipX43D92rCsFofp6ci3+C5iED75p3tPH8Jiq24=; b=L3f1w/682QSIuD6mOi7ydQwiI2
        6sExxLDpWf+ZHtI4sBWIaOagsxZwIYX/RbKBfgzGC4B91qcqFg4s1cenRnCPZuUcNPIJgUJn5b38I
        Slw56bPPcas3FLjhi8muwwLbc2KHnuPyCvUSbPFcITNV51t3xxuFDxw3OFgYEwT7wqYxhcVGTYSNa
        EFGD1evFF/XC+jbICJCMX6G1pfgthPYgj0P+tA74EByacCKzN2ugDUuJghS0yPTx5ev0hI11/Oq7J
        4wnrKN4PAWm/kl9kb+tDsKD0iRviw07ChKJIETV61bDV7oeVObviROjrpGs09O2peQ6A7og5RZSwy
        bSkYk4mA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvrdk-004yrX-F8; Tue, 31 May 2022 02:29:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Charles Mirabile <cmirabil@redhat.com>,
        Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH -next] Input: joystick: Raspberry Pi Sense HAT depends on HAS_IOMEM
Date:   Mon, 30 May 2022 19:29:42 -0700
Message-Id: <20220531022942.16340-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since JOYSTICK_SENSEHAT selects MFD_SIMPLE_MFD_I2C and the latter
depends on HAS_IOMEM, and since 'select' does not follow any
dependency chains, JOYSTICK_SENSEHAT should also depend on HAS_IOMEM
to prevent a kconfig warning and a build error:

WARNING: unmet direct dependencies detected for MFD_SIMPLE_MFD_I2C
  Depends on [n]: HAS_IOMEM [=n] && I2C [=y]
  Selected by [y]:
  - JOYSTICK_SENSEHAT [=y] && INPUT_JOYSTICK [=y] && INPUT [=y] && I2C [=y]

s390-linux-ld: drivers/mfd/simple-mfd-i2c.o: in function `simple_mfd_i2c_probe':
simple-mfd-i2c.c:(.text+0xc8): undefined reference to `devm_mfd_add_devices'

Fixes: 41657514c796 ("Input: add Raspberry Pi Sense HAT joystick driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Charles Mirabile <cmirabil@redhat.com>
Cc: Daniel Bauman <dbauman@redhat.com>
Cc: Mwesigwa Guma <mguma@redhat.com>
Cc: Joel Savitz <jsavitz@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/joystick/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -402,6 +402,7 @@ config JOYSTICK_N64
 config JOYSTICK_SENSEHAT
 	tristate "Raspberry Pi Sense HAT joystick"
 	depends on INPUT && I2C
+	depends on HAS_IOMEM
 	select MFD_SIMPLE_MFD_I2C
 	help
 	  Say Y here if you want to enable the driver for the
