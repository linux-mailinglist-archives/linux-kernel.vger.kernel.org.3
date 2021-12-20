Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B9A47B0A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbhLTPvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhLTPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:51:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E32EC06173E;
        Mon, 20 Dec 2021 07:51:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27777B80ED8;
        Mon, 20 Dec 2021 15:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C320C36AE5;
        Mon, 20 Dec 2021 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640015466;
        bh=pLgGyDKK1/5N+m3LhSIJ3nO1D7WaH6YeiBnPxQs+i4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n0FdS++29ApJD3dEbBUpEFZxgpoQwuizmrDRznJCnx4esGDCjnOJDH84T2tnRXV37
         RJXTDlvuzuPAuCr59fkq5NGLebkwp8/dabi9BR1pjhZTyUoLFd8WxTzc6B//Uxtas+
         RwpXdg0ZnHOOhfEsND7SBkPNLeR8w2+CKZVSPpZk=
Date:   Mon, 20 Dec 2021 16:51:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hammer Hsieh <hammerh0314@gmail.com>
Cc:     robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH v5 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Message-ID: <YcCmaJkeKy+R0mhF@kroah.com>
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 03:10:07PM +0800, Hammer Hsieh wrote:
> +/* Register offsets */
> +#define SUP_UART_DATA			0x00
> +#define SUP_UART_LSR			0x04
> +#define SUP_UART_MSR			0x08
> +#define SUP_UART_LCR			0x0C
> +#define SUP_UART_MCR			0x10
> +#define SUP_UART_DIV_L			0x14
> +#define SUP_UART_DIV_H			0x18
> +#define SUP_UART_ISC			0x1C
> +#define SUP_UART_TX_RESIDUE		0x20
> +#define SUP_UART_RX_RESIDUE		0x24
> +
> +/* Line Status Register bits */
> +#define SUP_UART_LSR_TXE		BIT(6) /* tx empty */
> +#define SUP_UART_LSR_BC			BIT(5) /* break condition status */
> +#define SUP_UART_LSR_FE			BIT(4) /* frame error status */
> +#define SUP_UART_LSR_OE			BIT(3) /* overrun error status */
> +#define SUP_UART_LSR_PE			BIT(2) /* parity error status */
> +#define SUP_UART_LSR_RX			BIT(1) /* 1: receive fifo not empty */
> +#define SUP_UART_LSR_TX			BIT(0) /* 1: transmit fifo is not full */
> +#define SUP_UART_LSR_TX_NOT_FULL	1
> +#define SUP_UART_LSR_BRK_ERROR_BITS	GENMASK(5, 2)
> +
> +/* Line Control Register bits */
> +#define SUP_UART_LCR_BC			BIT(5) /* break condition select */
> +#define SUP_UART_LCR_PR			BIT(4) /* parity bit polarity select */
> +#define SUP_UART_LCR_PE			BIT(3) /* parity bit enable */
> +#define SUP_UART_LCR_ST			BIT(2) /* stop bits select */
> +#define SUP_UART_LCR_WL5		0x00 /*  word length 5 */
> +#define SUP_UART_LCR_WL6		0x01 /*  word length 6 */
> +#define SUP_UART_LCR_WL7		0x02 /*  word length 7 */
> +#define SUP_UART_LCR_WL8		0x03 /*  word length 8 (default) */
> +
> +/* Modem Control Register bits */
> +#define SUP_UART_MCR_LB			BIT(4) /* Loopback mode */
> +#define SUP_UART_MCR_RI			BIT(3) /* ring indicator */
> +#define SUP_UART_MCR_DCD		BIT(2) /* data carrier detect */
> +#define SUP_UART_MCR_RTS		BIT(1) /* request to send */
> +#define SUP_UART_MCR_DTS		BIT(0) /* data terminal ready */
> +
> +/* Interrupt Status/Control Register bits */
> +#define SUP_UART_ISC_RXM		BIT(5) /* RX interrupt enable */
> +#define SUP_UART_ISC_TXM		BIT(4) /* TX interrupt enable */
> +#define SUP_UART_ISC_RX			BIT(1) /* RX interrupt status */
> +#define SUP_UART_ISC_TX			BIT(0) /* TX interrupt status */
> +
> +#define SUP_DUMMY_READ			BIT(16) /* drop bytes received on a !CREAD port */
> +#define SUP_UART_NR			5

Aren't most of these defines already in the kernel header files?  Why
create them again?

