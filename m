Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDFD4813A8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhL2NyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:54:24 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:37701 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhL2NyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:54:23 -0500
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Wed, 29 Dec 2021
 21:54:15 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V2 0/6] the UART driver compatible with the Amlogic Meson S4
Date:   Wed, 29 Dec 2021 21:53:44 +0800
Message-ID: <20211229135350.9659-1-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Using the common Clock code to describe the UART baud rate clock makes it
easier for the UART driver to be compatible with the baud rate requirements of
the UART IP on different meson chips. Add Meson S4 SoC compatible.

2.Fix some omissions

3.An interrupt error occurs when the user opens (/dev/ttyAML0) twice in a row

Yu Tu (6):
  tty: serial: meson: Drop the legacy compatible strings and clock code
  tty: serial: meson: Request the register region in meson_uart_probe()
  dt-bindings: serial: meson: Support S4 SoC uart. Also Drop compatible
    = amlogic,meson-gx-uart.
  tty: serial: meson: The UART baud rate calculation is described using
    the common clock code. Also added S4 chip uart Compatible.
  tty: serial: meson: meson_uart_shutdown omit clear AML_UART_TX_EN bit
  tty: serial: meson: Change request_irq to devm_request_irq and move
    devm_request_irq to meson_uart_probe()

V1 -> V2: Use CCF to describe the UART baud rate clock.Make some changes as
discussed in the email

Link:https://lore.kernel.org/linux-amlogic/20211221071634.25980-2-yu.tu@amlogic.com/

 .../bindings/serial/amlogic,meson-uart.yaml   |  10 +-
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/meson_uart.c               | 359 +++++++++++++-----
 3 files changed, 265 insertions(+), 105 deletions(-)

-- 
2.33.1

