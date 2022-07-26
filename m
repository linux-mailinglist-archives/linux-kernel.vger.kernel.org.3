Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0767D580F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiGZJMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiGZJMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8522CDD2;
        Tue, 26 Jul 2022 02:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD07A6157C;
        Tue, 26 Jul 2022 09:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14844C341C0;
        Tue, 26 Jul 2022 09:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658826759;
        bh=I7oFMsDd+NqwunPLpzOEtgV7hXHXjObjS4RaSddRgOc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZOP9tWOq4LDCmmIBNWcloFwr55JWunqasmdmS3tq9iNoEAa4aMv1daGm0sJL/OMWw
         uzjF2A+irxJEAkjDX7tv2YMLcWkngcDzN7uGKlCr08PvHYMlKZYOSQgbdzJQXihIJH
         MuJ77X0UHUhFxpVf/5VZhDyjOK6w2QhON4V84kCIXCjNRaIh3z1hXsmbDtJhtkbhRW
         AoPvO5l4B5qAxKYN/nuLb3w5/SwmQ8HpMKjE1IzjpvcTREah0Y+D7zNwZ2gKlcpx3n
         ZiH7C725c39tGt5QeSoEfrk6JLwV4UM9VNQuOVjgT9Brhii8uKEp9yK3KQaadcmmyu
         eUjRRCcJiY3TA==
Received: by pali.im (Postfix)
        id 2AE4482D; Tue, 26 Jul 2022 11:12:36 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: mvebu-uart: uart2 error bits clearing
Date:   Tue, 26 Jul 2022 11:12:21 +0200
Message-Id: <20220726091221.12358-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Narendra Hadke <nhadke@marvell.com>

For mvebu uart2, error bits are not cleared on buffer read.
This causes interrupt loop and system hang.

Signed-off-by: Narendra Hadke <nhadke@marvell.com>
Reviewed-by: Yi Guo <yi.guo@cavium.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/mvebu-uart.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 0429c2a54290..ff61a8d00014 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -265,6 +265,7 @@ static void mvebu_uart_rx_chars(struct uart_port *port, unsigned int status)
 	struct tty_port *tport = &port->state->port;
 	unsigned char ch = 0;
 	char flag = 0;
+	int ret;
 
 	do {
 		if (status & STAT_RX_RDY(port)) {
@@ -277,6 +278,16 @@ static void mvebu_uart_rx_chars(struct uart_port *port, unsigned int status)
 				port->icount.parity++;
 		}
 
+		/*
+		 * For UART2, error bits are not cleared on buffer read.
+		 * This causes interrupt loop and system hang.
+		 */
+		if (IS_EXTENDED(port) && (status & STAT_BRK_ERR)) {
+			ret = readl(port->membase + UART_STAT);
+			ret |= STAT_BRK_ERR;
+			writel(ret, port->membase + UART_STAT);
+		}
+
 		if (status & STAT_BRK_DET) {
 			port->icount.brk++;
 			status &= ~(STAT_FRM_ERR | STAT_PAR_ERR);
-- 
2.20.1

