Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987F249E30C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbiA0NFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:05:54 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:46069 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiA0NFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:05:53 -0500
X-Greylist: delayed 1637 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jan 2022 08:05:53 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1643288748;
    s=strato-dkim-0002; d=ko-hh.de;
    h=Message-ID:Subject:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=b+caAxbUrHuhIpx7+ePsmJewnN68/Jfd7jaXxPBONu0=;
    b=pRTPd08iAF/6d9RISTuRtIS2RahhHjp7EEWcHmzC0jgAKcV89cWSxT6kDqkrXakD2D
    dQzgfoVTA2mKxjXs0NMCKAYbg8b2ZL5lU3K19m59CQenK29ev4NLtOV5hO9lUkc4N47/
    gn18wvNoVgKrd5zhik4n0dLDP7Eb9d3mojG54bWkmntqJKTYVS2mnOGYRGAqSIV7Fiip
    RZ5N9aqu3Nn+o+btt4ss6TN0Bwf6wSYGOw8nXOi1vrBjKkedIvs4JDkdVwm7plOR1vS7
    A/smf0I2e76phZW5aFMCBuHS6t7Le0PFfwojtzgFVh/cj9lNwew+kL1bNXgjlHW2uOZH
    wP7A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OGQBeUWjaN+znm36YqWmJEx4lU5vgP4am+jDJsl40KLIzDO7mhveTrcVbinBxa9usBQY4Ns="
X-RZG-CLASS-ID: mo00
Received: from odroid-VirtualBox
    by smtp.strato.de (RZmta 47.38.0 DYNA|AUTH)
    with ESMTPSA id L5f488y0RD5moIG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 27 Jan 2022 14:05:48 +0100 (CET)
Date:   Thu, 27 Jan 2022 14:05:37 +0100
From:   Lutz Koschorreck <theleks@ko-hh.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: meson-sm1-odroid: use correct enable-gpio pin
 for tf-io regulator
Message-ID: <20220127130537.GA187347@odroid-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt pin of the external ethernet phy is used, instead of the
enable-gpio pin of the tf-io regulator. The GPIOE_2 pin is located in
the gpio_ao bank.

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

only gpio bank
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index 0bd1e98a0eef..ed7cd5f53046 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -48,7 +48,7 @@ tf_io: gpio-regulator-tf_io {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc_5v>;
 
-		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
+		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-always-on;
 
-- 
2.25.1

