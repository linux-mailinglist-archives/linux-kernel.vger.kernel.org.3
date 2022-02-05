Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4B14AAC29
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 20:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiBETCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 14:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381610AbiBES6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:58:21 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC40C043188;
        Sat,  5 Feb 2022 10:56:32 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 28411240018;
        Sat,  5 Feb 2022 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSPt7u1+30zfQR7rOTKR21cnm8xgbGtvIXTidlwItMo=;
        b=Be/2jLdRiGZRoUQ4CBH+WEvtTYMh6fSdQH9+wkanouzfRkK0qP89cEde98YfM87C8G30kq
        BkkL0WDWJEPi5lIG3w/bXAm2U4OXfyEn1yGjL4Rn2d75ioys2XhZwJ2V9bSva+BhHLP9hE
        Oy9nqiZqA0aDaElFIEBe7k59XVXfw0Ja1Hv6VYoqeRuS7m6dJQ9HeVwxl7fuklVHQiTWT3
        LMI9L2S3TO8S1X5ibfpUXfxybZa9H2vpW+o2KJpUeYmNrn0cIvp8B2iNr35KkYZHMTCOrZ
        XrNBpDwwNc8WjMzAswGqQcCmYN/FML8/+8ndeaKw36y7NGm3WQ/vXuQK6xtlTQ==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH NOT FOR MERGE v2 66/66] of: Mark interconnects property supplier as optional
Date:   Sat,  5 Feb 2022 19:54:29 +0100
Message-Id: <20220205185429.2278860-67-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This illegitimate change makes it possible for the sun6i csi and isp
drivers to probe without a proper interconnect driver available.

Without this change, the core will wait for an interconnect driver to
probe and return EPROBE_DEFER in our drivers. This ends up in these
drivers never being probed since no driver exists.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index a3483484a5a2..6f1b74a2f568 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1352,7 +1352,7 @@ static struct device_node *parse_interrupts(struct device_node *np,
 
 static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
-	{ .parse_prop = parse_interconnects, },
+	{ .parse_prop = parse_interconnects, .optional = true,},
 	{ .parse_prop = parse_iommus, .optional = true, },
 	{ .parse_prop = parse_iommu_maps, .optional = true, },
 	{ .parse_prop = parse_mboxes, },
-- 
2.34.1

