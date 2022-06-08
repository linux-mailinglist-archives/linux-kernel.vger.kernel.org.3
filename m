Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88E65428AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiFHHzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiFHHyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:54:44 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0421D6845
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1654671946; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WCTiZsVbZkiyPWNKvOWqgJDqqwyAZ2nrFRS/3PKCYlyJr603gecGh7m594lOs9XEyrw98uYBey3bzdT8SXT74t5bf49aVhHJoDnJ+cRrnZH8n82zIizKjenvjOlmdoGIVrZ1najueXgrQIThYmeXiWdj6x3hpfgzXfmN8xfBXLM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1654671946; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=eOSmYjeyodRtWW8Zwck9JJRoEsPSewYFv2Sg459aO/Q=; 
        b=G/eNIckA5Til4nC5uo16h7QvppeC7CSstxKDtcsI8Y7Te0MksFJr9V+Fkm+vDqAnPXZn0powOMjU8e03pVP5O4szMQ1CO3dPbxPZj0OHnjn44I6oMJgVIr+pMfIcgwXCNmzX2rpqLsvIJuiTcJz144sTAt3eqHZfvN1bHH4bHvE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1654671946;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=eOSmYjeyodRtWW8Zwck9JJRoEsPSewYFv2Sg459aO/Q=;
        b=cNVbmGV1//Q6JbD9i1XFILyKxUL34hHeFs7E7h935aziVne3c/0xojIuQ6KRMkat
        Mn/bZC38/aYu+a8CCF3OPvl6eFR7GpW2oXSU5GVRsEr45u8dO3qUY4bR23CalzuFW8P
        GXH8fidZ459UrbemGmCb3SEppLuZ+vafke/DfQTg=
Received: from edelgard.icenowy.me (59.41.163.66 [59.41.163.66]) by mx.zohomail.com
        with SMTPS id 1654671944661761.5571172953408; Wed, 8 Jun 2022 00:05:44 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-usb@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 5/7] musb: sunxi: add support for the F1C100s MUSB controller
Date:   Wed,  8 Jun 2022 15:04:50 +0800
Message-Id: <20220608070452.338006-6-uwu@icenowy.me>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220608070452.338006-1-uwu@icenowy.me>
References: <20220608070452.338006-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

The suniv SoC has a MUSB controller like the one in A33, but with a SRAM
region to be claimed.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/usb/musb/sunxi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 961c858fb349..2cb512e172f8 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -722,14 +722,17 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 	INIT_WORK(&glue->work, sunxi_musb_work);
 	glue->host_nb.notifier_call = sunxi_musb_host_notifier;
 
-	if (of_device_is_compatible(np, "allwinner,sun4i-a10-musb"))
+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-musb") ||
+	    of_device_is_compatible(np, "allwinner,suniv-f1c100s-musb")) {
 		set_bit(SUNXI_MUSB_FL_HAS_SRAM, &glue->flags);
+	}
 
 	if (of_device_is_compatible(np, "allwinner,sun6i-a31-musb"))
 		set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
 
 	if (of_device_is_compatible(np, "allwinner,sun8i-a33-musb") ||
-	    of_device_is_compatible(np, "allwinner,sun8i-h3-musb")) {
+	    of_device_is_compatible(np, "allwinner,sun8i-h3-musb") ||
+	    of_device_is_compatible(np, "allwinner,suniv-f1c100s-musb")) {
 		set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
 		set_bit(SUNXI_MUSB_FL_NO_CONFIGDATA, &glue->flags);
 	}
@@ -826,6 +829,7 @@ static const struct of_device_id sunxi_musb_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-musb", },
 	{ .compatible = "allwinner,sun8i-a33-musb", },
 	{ .compatible = "allwinner,sun8i-h3-musb", },
+	{ .compatible = "allwinner,suniv-f1c100s-musb", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sunxi_musb_match);
-- 
2.36.0

