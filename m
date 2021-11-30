Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC62463E05
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245600AbhK3SxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245598AbhK3Sw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:52:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBED9C061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:49:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so30726873ybe.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KC1KslsAWcLKbueuly8tNpIr1XMybfLtjcHTyhp9kPA=;
        b=eoiEVlkLUz8iLCc3q+yUTxvA+3ZF7VsDhtl4WNZsBLzc6K46xzxSsjbsJD2C/tUHQu
         hn1szDmsYDQEtq4mVVsib7hSyrVVtFUHOJSMktoUe0M9QwqANtBjEzFHCYFOlQohZlb2
         5V1qSXN0RYsQe+2wNIcWm1OBS+pLNVRZUErpC1A+gDCf/ym+cIRx7gmDsg8Gt9X00Cmw
         S9tsr0LIM5s5DUGziknCita87jgmV0kvP4+Zuoe0ZB0PfsGX4cinsHwwz+9yuxPi8wB5
         Dm/KpffAoPLZyqeBhsP02HHxIQDeavUkd0f3aiCzPLLVcb4ifSEkagflgH4726bZx6v8
         9SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KC1KslsAWcLKbueuly8tNpIr1XMybfLtjcHTyhp9kPA=;
        b=bkFsax0oELjTucC711vFRWFBpYuBp/iIiTZSHBEc9d5mm368/3VVPSXE7FL9ndmrt5
         oBxxmJfJDe5TVTLV++kz7zpWmHpLPVjrkjVJ8n2tO9q6VfTm25nE2ZsYWf36ttbf7uNB
         FBjlYwpKfAmfEn+9v7NIdhFfPZ8Bek3nruZFMXOi7DxERaUIqN54orTylx03sLObg9Sh
         2EVU/njDMsNRQc9XoFUaU2GSXpeZWTgNYflmENeGPreJmc9mG+2ttGxfMwUUqRnjbsYc
         3ZkVqYlrV6WnAOHoV1u6OoV01Mjkex5vbZX9iqbHPfwmtWHMo2PP6AGc3ToMBExoIYwO
         piKg==
X-Gm-Message-State: AOAM531+MF1b/Ql4WPXsDI2MHG7zM153RajDl4XSMdgf72Jg58vlctMs
        Y0zbmLtlSNIj4rRvvOce77pt+Wk=
X-Google-Smtp-Source: ABdhPJywuox5pRKXk/NzXZXHKmmoDVKC5pZnFGHOmy8w2yLDI/QOrQVy8Knol8P4jpbS+i0jDk7kXL4=
X-Received: from osk.cam.corp.google.com ([2620:15c:93:a:bd6e:e7b3:bbdb:f3df])
 (user=osk job=sendgmr) by 2002:a25:9781:: with SMTP id i1mr1064086ybo.638.1638298148193;
 Tue, 30 Nov 2021 10:49:08 -0800 (PST)
Date:   Tue, 30 Nov 2021 13:48:55 -0500
Message-Id: <20211130184855.1779353-1-osk@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] ARM: dts: aspeed: tyan-s7106: Add uart_routing and fix vuart config
From:   Oskar Senft <osk@google.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     aaelhaj@google.com, Oskar Senft <osk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the vuart in such a way that it does not inhibit the SuperIO's
UART from functioning correctly. This allows the same DTS to be used for
both configurations with SuperIO and VUART (depending on the BIOS
build). The decision on whether to actually enable VUART can then be
made at runtime.

This change also enables the new uart_routing driver for the SuperIO
case.

Signed-off-by: Oskar Senft <osk@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
index 60ac6d3f03b5..aff27c1d4b06 100644
--- a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
@@ -3,6 +3,7 @@
 
 #include "aspeed-g5.dtsi"
 #include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Tyan S7106 BMC";
@@ -127,8 +128,23 @@ &uart5 {
 	status = "okay";
 };
 
+&uart_routing {
+	status = "okay";
+};
+
 &vuart {
 	status = "okay";
+
+	/* We enable the VUART here, but leave it in a state that does
+	 * not interfere with the SuperIO. The goal is to have both the
+	 * VUART and the SuperIO available and decide at runtime whether
+	 * the VUART should actually be used. For that reason, configure
+	 * an "invalid" IO address and an IRQ that is not used by the
+	 * BMC.
+	 */
+
+	aspeed,lpc-io-reg = <0xffff>;
+	aspeed,lpc-interrupts = <15 IRQ_TYPE_LEVEL_HIGH>;
 };
 
 &lpc_ctrl {
-- 
2.34.0.rc2.393.gf8c9666880-goog

