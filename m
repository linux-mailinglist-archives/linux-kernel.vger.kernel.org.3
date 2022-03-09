Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7637D4D309E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiCIN4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiCIN4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:56:10 -0500
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DB0F17129B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+LiqS
        C7WgziMlv/nNb/0VCH3ABcsSrI+VV/R7iTCCdA=; b=Rn20ap+DHV0iFXWuDDCCy
        QWqDoohGfRHB6T0iUj+8RT9S74OUtAnkiCXARpHwNTUD091QcyTvlU7MGHo36OWd
        wW7eU3X/BMynd2VGQN9ft5vAxfi0otFlco+f/wgiuyGNP87HiZ/S064fPJ7wWpuP
        gSgxbvQ9hRMLcTBGRiMqkU=
Received: from localhost.localdomain (unknown [120.204.77.140])
        by smtp13 (Coremail) with SMTP id EcCowABnf8ePsShisPxEGw--.28457S4;
        Wed, 09 Mar 2022 21:54:53 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, lizhe <sensor1010@163.com>
Subject: [PATCH] drivers/dd.c :  Remove the initial value of the global variable
Date:   Wed,  9 Mar 2022 05:54:18 -0800
Message-Id: <20220309135418.31101-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowABnf8ePsShisPxEGw--.28457S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWUZF45ur47Kw4UCFyrtFb_yoWxKwb_Ca
        n7WFZrXryYgr4kCF15Aw13Zr9Fga1fZr4vyw4ftrya9ay7J3WrK3WDuFy5Aw4rWr90qFZF
        yr4Yqr1Uur1DCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRN1v3DUUUUU==
X-Originating-IP: [120.204.77.140]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBog6+q1aEC6xU9AAAss
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global variable driver_deferred_probe_enable has
a default value of false and does not need to be
initialized to false.

Signed-off-by: lizhe <sensor1010@163.com>
---
 drivers/base/dd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f47cab21430f..7fcd895d49be 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -152,7 +152,7 @@ void driver_deferred_probe_del(struct device *dev)
 	mutex_unlock(&deferred_probe_mutex);
 }
 
-static bool driver_deferred_probe_enable = false;
+static bool driver_deferred_probe_enable;
 /**
  * driver_deferred_probe_trigger() - Kick off re-probing deferred devices
  *
-- 
2.25.1

