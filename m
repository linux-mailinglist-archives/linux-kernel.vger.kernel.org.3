Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F804EB804
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 03:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbiC3B6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 21:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiC3B6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 21:58:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A41260E4;
        Tue, 29 Mar 2022 18:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ggJNGMpkihFhJWyUJhQRWh604kRYGl5zlZQIzdqWw8w=; b=l93siP1gZgio7hGsz9Q/dEhPq1
        x/zLngcp77PgAqflGyDLWSjWS9JqqC2s0dFXcA1mJqoOxA9qFQQPcmvJaGEiwOVffryN+jlUFLb00
        suHXUjD4+nva25aF+tg1jT3kXURWO9ZSy0X/1SoRSnuXjoK8hhUSYGV5WI4B0Rs561yCqXINnq84y
        pzBHqcUNowQZhx8V1+0gmQX+oINmR2gtV1juodFyMHhpY7q3NkqynPWs3eLyzh5X3bXJGIBBTgdxW
        hA++MHNve4hU3YbkaLIif5UKMnk4gm9DCGiaarHb9ldZmCqtSDWCLzWDnTvf+L3+6gPaqezwRkO+L
        rnInJ0Xw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZNZt-00Dw29-Sz; Wed, 30 Mar 2022 01:56:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Marek Vasut <marex@denx.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH -next] media: isl7998x: select V4L2_FWNODE to fix build error
Date:   Tue, 29 Mar 2022 18:56:52 -0700
Message-Id: <20220330015652.5420-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
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

Fix build error when VIDEO_ISL7998X=y and V4L2_FWNODE=m
by selecting V4L2_FWNODE.

microblaze-linux-ld: drivers/media/i2c/isl7998x.o: in function `isl7998x_probe':
(.text+0x8f4): undefined reference to `v4l2_fwnode_endpoint_parse'

Fixes: 51ef2be546e2 ("media: i2c: isl7998x: Add driver for Intersil ISL7998x")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Michael Tretter <m.tretter@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/i2c/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20220329.orig/drivers/media/i2c/Kconfig
+++ linux-next-20220329/drivers/media/i2c/Kconfig
@@ -1177,6 +1177,7 @@ config VIDEO_ISL7998X
 	depends on OF_GPIO
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
 	help
 	  Support for Intersil ISL7998x analog to MIPI-CSI2 or
 	  BT.656 decoder.
