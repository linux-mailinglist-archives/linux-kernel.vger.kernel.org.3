Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C20D471E3F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 23:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhLLWel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 17:34:41 -0500
Received: from mail.wizzup.org ([95.217.97.174]:43942 "EHLO wizzup.org"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229838AbhLLWek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 17:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
        s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Q7is5ZmNW1K+nlqrkajhVi61MsMA53xm5KVxC+pmfag=; b=XfFVwiam04kfDkhTnCUGP4BPtH
        Y5tM+h1X6odY4mI+CxDKh9+EDpOt2B8arXIA/AG3//zfpsshSSyoE7DXzjRUfQG2FUyKVWgruQCON
        NAuvDhYFRTmtSg9jVKBb+fy2bjoaFW2DRPboFEtBaupgI5RviffczevoNTtSjQ2WJq6F02EJZJw5V
        +B/2N4Pi/anXuRGYpP/q+fry/X2ku1aQw/aYUfRSM/4lH2dgL/77ZPfsWMs/3KiGstpvM50KIgmBF
        KSnToPheNlQuOyaBhBCo+U3BW42z3yW3TY4aNzYsxESqSj5jzezs/vvvs5KyhnQSbdTf4tnfbUnaB
        HZFglimQ==;
Received: from [45.83.235.159] (helo=gentoo-x13.fritz.box)
        by wizzup.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <merlijn@wizzup.org>)
        id 1mwXQK-0001do-PY; Sun, 12 Dec 2021 22:34:29 +0000
From:   Merlijn Wajer <merlijn@wizzup.org>
To:     merlijn@wizzup.org
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-omap@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        devicetree@vger.kernel.org, Doug Zobel <dougdev334@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Subject: [PATCH 0/2] Fix RGB status LED and keyboard backlight LEDs on Nokia N900
Date:   Sun, 12 Dec 2021 23:40:05 +0100
Message-Id: <20211212224007.10293-1-merlijn@wizzup.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RGB status LED and keyboard backlight LEDs were broken on the Nokia N900
since the conversion to gpiod descriptors and additionally later on with the
addition of multi color support. There was at least one attempt merged to fix
the lp5523 driver since the gpiod conversion, but it doesn't honour the device
tree, which in the case of the Nokia N900 means that the fix doesn't work.

In this series are two patches fix the problems:

* One addresses the gpiod change in the device tree as well as the multi
  color support in the device tree;
* The other patch fixes the previous attempt at fixing the driver to honour
  the device tree;

Please let me know if anything seems off, and I'll be glad to make any
recommended changes, thanks!

Merlijn Wajer (1):
  leds: lp55xx: initialise output direction from dts

Sicelo A. Mhlongo (1):
  ARM: dts: omap3-n900: Fix lp5523 for multi color

 arch/arm/boot/dts/omap3-n900.dts  | 50 ++++++++++++++++++++++++-------
 drivers/leds/leds-lp55xx-common.c |  4 ++-
 2 files changed, 43 insertions(+), 11 deletions(-)

-- 
2.32.0

