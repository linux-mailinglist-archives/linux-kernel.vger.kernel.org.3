Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825E04A4833
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378957AbiAaNdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:33:12 -0500
Received: from relay040.a.hostedemail.com ([64.99.140.40]:41791 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1379207AbiAaNdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:33:06 -0500
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 759F320CE6;
        Mon, 31 Jan 2022 13:33:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 971C233;
        Mon, 31 Jan 2022 13:32:47 +0000 (UTC)
Message-ID: <8faabe9985a330afc41d774db3ac899e1453c88d.camel@perches.com>
Subject: Re: [PATCH v2] staging: media: atomisp: Use BIT macro instead of
 left shifting
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        kitakar@gmail.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, tomi.valkeinen@ideasonboard.com
Date:   Mon, 31 Jan 2022 05:33:00 -0800
In-Reply-To: <20220131073624.GH1951@kadam>
References: <YfVstOJ38OTtd43n@smile.fi.intel.com>
         <20220130180655.22970-1-mosescb.dev@gmail.com>
         <20220131073624.GH1951@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 971C233
X-Spam-Status: No, score=-2.99
X-Stat-Signature: yyiar3d9dom5ro6b3omwwrzjn55z5zrd
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+wLKO2r8bL7xWLkEInCdDfMKblV0U7hAY=
X-HE-Tag: 1643635967-396179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-31 at 10:36 +0300, Dan Carpenter wrote:
> On Sun, Jan 30, 2022 at 07:06:55PM +0100, Moses Christopher Bollavarapu wrote:
> > There is a BIT(nr) macro available in Linux Kernel,
> > which does the same thing.
> > Example: BIT(7) = (1UL << 7)
> > 
> > Also use GENMASK for masking
> > Example: GENMASK(3, 0) = 0b00001111 (same as (1 << 4) - 1)
> > 
> > Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
> 
> This patch does a couple unrelated things.  Break out the GENMASK()
> change into its own patch.
> 
> > @@ -65,7 +66,7 @@ enum ia_css_fw_type {
> >  	ia_css_sp_firmware,		/** Firmware for the SP */
> >  	ia_css_isp_firmware,		/** Firmware for the ISP */
> >  	ia_css_bootloader_firmware,	/** Firmware for the BootLoader */
> > -	ia_css_acc_firmware		/** Firmware for accelrations */
> > +	ia_css_acc_firmware,		/** Firmware for accelrations */
> >  };
> 
> This change needs to be in its own patch.

Because it's unrelated.  As is the repetitive use of 'Firmware for'
and the typo/misspelling of accelerations.

Another possibility would be to change the /** to /* or maybe
change to // and remove the ' */' trailing comment termination
also in a separate patch.

> > diff --git a/drivers/staging/media/atomisp/pci/ia_css_env.h b/drivers/staging/media/atomisp/pci/ia_css_env.h
[]
> >  enum ia_css_rx_irq_info {
> > -	IA_CSS_RX_IRQ_INFO_BUFFER_OVERRUN   = 1U << 0, /** buffer overrun */
> > -	IA_CSS_RX_IRQ_INFO_ENTER_SLEEP_MODE = 1U << 1, /** entering sleep mode */
> > -	IA_CSS_RX_IRQ_INFO_EXIT_SLEEP_MODE  = 1U << 2, /** exited sleep mode */
> > -	IA_CSS_RX_IRQ_INFO_ECC_CORRECTED    = 1U << 3, /** ECC corrected */
> > -	IA_CSS_RX_IRQ_INFO_ERR_SOT          = 1U << 4,
> > +	IA_CSS_RX_IRQ_INFO_BUFFER_OVERRUN   = BIT(0), /** buffer overrun */
> > +	IA_CSS_RX_IRQ_INFO_ENTER_SLEEP_MODE = BIT(1), /** entering sleep mode */
> > +	IA_CSS_RX_IRQ_INFO_EXIT_SLEEP_MODE  = BIT(2), /** exited sleep mode */
> > +	IA_CSS_RX_IRQ_INFO_ECC_CORRECTED    = BIT(3), /** ECC corrected */
> > +	IA_CSS_RX_IRQ_INFO_ERR_SOT          = BIT(4),
> >  	/** Start of transmission */
> > -	IA_CSS_RX_IRQ_INFO_ERR_SOT_SYNC     = 1U << 5, /** SOT sync (??) */
> > -	IA_CSS_RX_IRQ_INFO_ERR_CONTROL      = 1U << 6, /** Control (??) */
> > -	IA_CSS_RX_IRQ_INFO_ERR_ECC_DOUBLE   = 1U << 7, /** Double ECC */
> > -	IA_CSS_RX_IRQ_INFO_ERR_CRC          = 1U << 8, /** CRC error */
> > -	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ID   = 1U << 9, /** Unknown ID */
> > -	IA_CSS_RX_IRQ_INFO_ERR_FRAME_SYNC   = 1U << 10,/** Frame sync error */
> > -	IA_CSS_RX_IRQ_INFO_ERR_FRAME_DATA   = 1U << 11,/** Frame data error */
> > -	IA_CSS_RX_IRQ_INFO_ERR_DATA_TIMEOUT = 1U << 12,/** Timeout occurred */
> > -	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ESC  = 1U << 13,/** Unknown escape seq. */
> > -	IA_CSS_RX_IRQ_INFO_ERR_LINE_SYNC    = 1U << 14,/** Line Sync error */
> > -	IA_CSS_RX_IRQ_INFO_INIT_TIMEOUT     = 1U << 15,
> > +	IA_CSS_RX_IRQ_INFO_ERR_SOT_SYNC     = BIT(5), /** SOT sync (??) */
> > +	IA_CSS_RX_IRQ_INFO_ERR_CONTROL      = BIT(6), /** Control (??) */
> > +	IA_CSS_RX_IRQ_INFO_ERR_ECC_DOUBLE   = BIT(7), /** Double ECC */
> > +	IA_CSS_RX_IRQ_INFO_ERR_CRC          = BIT(8), /** CRC error */
> > +	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ID   = BIT(9), /** Unknown ID */
> > +	IA_CSS_RX_IRQ_INFO_ERR_FRAME_SYNC   = BIT(10),/** Frame sync error */
> > +	IA_CSS_RX_IRQ_INFO_ERR_FRAME_DATA   = BIT(11),/** Frame data error */
> > +	IA_CSS_RX_IRQ_INFO_ERR_DATA_TIMEOUT = BIT(12),/** Timeout occurred */
> > +	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ESC  = BIT(13),/** Unknown escape seq. */
> > +	IA_CSS_RX_IRQ_INFO_ERR_LINE_SYNC    = BIT(14),/** Line Sync error */
> 
> The comment is kind of messed up.  There should be a space after the
> comma and just /* Line Sync error */

or just a tab before all of the comments


