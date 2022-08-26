Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3335A2F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbiHZS5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345123AbiHZS5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:57:09 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9AC3DB41
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:54:35 -0700 (PDT)
Received: (qmail 47487 invoked by uid 1000); 26 Aug 2022 14:54:34 -0400
Date:   Fri, 26 Aug 2022 14:54:34 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Maxim Devaev <mdevaev@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com
Subject: Re: [PATCH] usb: gadget: mass_storage: Fix cdrom data transfers on
 MAC-OS
Message-ID: <YwkW6pZoZcua9eoN@rowland.harvard.edu>
References: <1661535142-5204-1-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661535142-5204-1-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 11:02:22PM +0530, Krishna Kurapati wrote:
> During cdrom emulation, the response to read_toc command must contain
> the cdrom address as the number of sectors (2048 byte sized blocks)
> represented either as an absolute value (when MSF bit is '0') or in
> terms of PMin/PSec/PFrame (when MSF bit is set to '1'). Incase of
> cdrom, the fsg_lun_open call sets the number of sectors to 2048 byte

Sets the sector size to 2048 bytes, not the number of sectors.

> sized blocks.
> 
> When MAC OS sends a read_toc request with MSF set to '1', the
> store_cdrom_address assumes that the address being provided is the
> LUN size represented in 512 byte sized blocks instead of 2048. It
> tries to modify the address further to convert it to 2048 byte sized
> blocks and store it in MSF format. This results in data transfer
> failures as the cdrom address being provided in the read_toc response
> is incorrect.
> 
> Fixes: 3f565a363cee ("usb: gadget: storage: adapt logic block size to bound block devices")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>

Should include "Cc: stable@vger.kernel.org".

> ---
>  drivers/usb/gadget/function/storage_common.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/storage_common.c b/drivers/usb/gadget/function/storage_common.c
> index 03035db..db40392 100644
> --- a/drivers/usb/gadget/function/storage_common.c
> +++ b/drivers/usb/gadget/function/storage_common.c
> @@ -295,7 +295,6 @@ void store_cdrom_address(u8 *dest, int msf, u32 addr)
>  {
>  	if (msf) {
>  		/* Convert to Minutes-Seconds-Frames */
> -		addr >>= 2;		/* Convert to 2048-byte frames */

Please leave a comment here saying that we already know the sector size 
is 2048 bytes.

>  		addr += 2*75;		/* Lead-in occupies 2 seconds */
>  		dest[3] = addr % 75;	/* Frames */
>  		addr /= 75;

Otherwise this is okay.  In your next submission you can add:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
