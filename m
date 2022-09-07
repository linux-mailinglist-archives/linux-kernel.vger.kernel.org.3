Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB205B0766
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiIGOql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIGOqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:46:36 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CE87B1EF;
        Wed,  7 Sep 2022 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662561995; x=1694097995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jq/LXarroQvKCnR+TWFdrbIO6mQxGew6wfFoa385Hgw=;
  b=auzo1w2frdM0uF1pYiFd+zHuP9dn5o5ukHUi++5Aw3W2hpRQsjQNLiF1
   U5HKfD1evJRnUbUcv594V+bdbhNaeRwpawcTWkn7vPinHuisOLotlGYIb
   q9KVsUDigB+z1Gnd3UOziIUcxPYfnslyhvPCdWLHxs8DLJwPtfxkDDwVU
   fe+ZKCWtlJeed/M/JUm7ianPD87x0XTOEXuq+jpwf2HfWZGsb2WXhecHj
   gdcHC0tssbPSV8X3vkh/MJv6XR/ZjR7DmwGafhrf0C7Zy2+SUyGLE86eu
   tSfFC6zaEK1MnguUSnob+Wz4TsG17iKNvjm59TYziIQPf4bgYrcOB0mkx
   w==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654552800"; 
   d="scan'208";a="26047484"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Sep 2022 16:46:30 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 07 Sep 2022 16:46:30 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 07 Sep 2022 16:46:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662561990; x=1694097990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jq/LXarroQvKCnR+TWFdrbIO6mQxGew6wfFoa385Hgw=;
  b=CsWNCph7KnP/34n0XH6KtYavjH9jxeMVN2LrVqnf5NCG0RtLoN/npTjM
   /smURe8A0gZK95mPruYP0A8sZhx69flLnLQyj/dLgnAk5iLQYiiEDEQTC
   LO4Gs9OGjJwmKIpuXgy2JBJYo2wLkP3hxw7qfKUWvA3pU1JLjfr8NaHNg
   qeP9UESyBKDomSeuHbhczSiewI7wnSKa3tW/0hphxdEnyQRxXdskMZK+i
   yzI+vO+fAHx+4yCyw1GpdCvV6B/PYpyIVx1Hx4tsUQfL6Xpgn2iVaCpJx
   Be12KGYIfdJLkDed3JPPoeU8ZNXfOxOwzOBCkMa/pS2AKDtuHSamyUvhK
   w==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654552800"; 
   d="scan'208";a="26047483"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Sep 2022 16:46:30 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 69C35280072;
        Wed,  7 Sep 2022 16:46:30 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Li Jun <jun.li@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: usb: dwc3: Add gfladj-refclk-lpm-sel-quirk
Date:   Wed,  7 Sep 2022 16:46:21 +0200
Message-Id: <20220907144624.2810117-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This selects SOF/ITP to be running on ref_clk.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1779d08ba1c0..2a54d0bb0b15 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -234,6 +234,11 @@ properties:
       avoid -EPROTO errors with usbhid on some devices (Hikey 970).
     type: boolean
 
+  snps,gfladj-refclk-lpm-sel-quirk:
+    description:
+      When set, run the SOF/ITP counter based on ref_clk.
+    type: boolean
+
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when
-- 
2.25.1

