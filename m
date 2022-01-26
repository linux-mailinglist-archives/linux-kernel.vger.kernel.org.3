Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8594449D65E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiAZXth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:49:37 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:40549 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiAZXtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1643240616;
    s=strato-dkim-0002; d=ko-hh.de;
    h=Message-ID:Subject:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rUwf4V6VfjCh/Tz0lFpBY98CSKOMaoI/ZlA6KjECeLc=;
    b=Gyt0I8d1vrwyVdd9BPP+goGYbnc0j8x6TKG1RRT1FSae8MCKMpCgt4ICPViamIWx/B
    7fZhlz4/uQNBD1Ie+9+lI2PukTlQi2N7DTJ4HnICI6qHOKYPBzRn5AcBMm1qG88JIR+p
    63bmhAVtc8Hzh6HO7MYnaOWsTYeG6VZzrvKtGnzOW05cpFQL6daAuuem8sw4SeFCNIXe
    J+SJBxChlaIWe+1fZVd6uoEcn+87gOIvBk5Bgd4RsxYhcThTRluy78O2obNSuwBbP6pu
    UjFRkT1GM061AqCOa05TpL+Kd9NFkLrFLE15C7/G9OYsEbWeqrzaP7WstXNFbWzJ7fNn
    1EWg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OGQBeUWjaN+znm36YqWmJEx4lU5vgP4am+jDJsl40KLIzDO7mhvQTIqpxZoDGXXc/Nut"
X-RZG-CLASS-ID: mo00
Received: from odroid-VirtualBox
    by smtp.strato.de (RZmta 47.38.0 DYNA|AUTH)
    with ESMTPSA id L5f488y0QNhZk0e
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 27 Jan 2022 00:43:35 +0100 (CET)
Date:   Thu, 27 Jan 2022 00:43:25 +0100
From:   Lutz Koschorreck <theleks@ko-hh.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-sm1-odroid: use correct enable-gpio pin
 for tf-io regulator
Message-ID: <20220126234325.GA7363@odroid-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt pin of the external ethernet phy is used, instead of the
enable-gpio pin of the tf-io regulator. The GPIOE_2 pin is located in
the gpio_ao bank.
Using open drain prevents reboot issues.

This causes phy interrupt problems at system startup.
[   76.645190] irq 36: nobody cared (try booting with the "irqpoll" option)
[   76.649617] CPU: 0 PID: 1416 Comm: irq/36-0.0:00 Not tainted 5.16.0 #2
[   76.649629] Hardware name: Hardkernel ODROID-HC4 (DT)
[   76.649635] Call trace:
[   76.649638]  dump_backtrace+0x0/0x1c8
[   76.649658]  show_stack+0x14/0x60
[   76.649667]  dump_stack_lvl+0x64/0x7c
[   76.649676]  dump_stack+0x14/0x2c
[   76.649683]  __report_bad_irq+0x38/0xe8
[   76.649695]  note_interrupt+0x220/0x3a0
[   76.649704]  handle_irq_event_percpu+0x58/0x88
[   76.649713]  handle_irq_event+0x44/0xd8
[   76.649721]  handle_fasteoi_irq+0xa8/0x130
[   76.649730]  generic_handle_domain_irq+0x38/0x58
[   76.649738]  gic_handle_irq+0x9c/0xb8
[   76.649747]  call_on_irq_stack+0x28/0x38
[   76.649755]  do_interrupt_handler+0x7c/0x80
[   76.649763]  el1_interrupt+0x34/0x80
[   76.649772]  el1h_64_irq_handler+0x14/0x20
[   76.649781]  el1h_64_irq+0x74/0x78
[   76.649788]  irq_finalize_oneshot.part.56+0x68/0xf8
[   76.649796]  irq_thread_fn+0x5c/0x98
[   76.649804]  irq_thread+0x13c/0x260
[   76.649812]  kthread+0x144/0x178
[   76.649822]  ret_from_fork+0x10/0x20
[   76.649830] handlers:
[   76.653170] [<0000000025a6cd31>] irq_default_primary_handler threaded [<0000000093580eb7>] phy_interrupt
[   76.661256] Disabling IRQ #36

Fixes: 1f80a5cf74a6 ("arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for tf_io regulator")

Signed-off-by: Lutz Koschorreck <theleks@ko-hh.de>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index 0bd1e98a0eef..ddb1b345397f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -48,7 +48,7 @@ tf_io: gpio-regulator-tf_io {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc_5v>;
 
-		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
+		enable-gpio = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;
 		enable-active-high;
 		regulator-always-on;
 
-- 
2.25.1

