Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ABB57ED14
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiGWJbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiGWJbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:31:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7C012632;
        Sat, 23 Jul 2022 02:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26B39B827CC;
        Sat, 23 Jul 2022 09:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCE5C341C0;
        Sat, 23 Jul 2022 09:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658568709;
        bh=nOYpDiEuiMsa/dvvzuJwWwhhNMgzATPrg+9e85VUeiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSM2Fvxp5zpJU3r95P2oTb3eBcNbZAzQK9K5SspVyMFqktjSBC2F2cemyDKXiB+Eb
         EkMP1qaZf2o7hFR8X1i5Jnru7Oscr52T7thwEguc/FnPNki7O+Rsr7QHdPoMRUm0Ag
         TNDaW3tH0+LJPJ3Z8dChKatg+IKdHmnMAmuzlj9Q=
Date:   Sat, 23 Jul 2022 11:31:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xy521521 <xy521521@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, EdisonZhang@zhaoxin.com,
        PeterWu@zhaoxin.com, cobechen@zhaoxin.com, wugaoquan@kylinos.cn,
        Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: Re: [PATCH -next] usb: ehci: Read CMD_RUN instead of STS_HALT in
 ehci_halt with ZX-200
Message-ID: <Ytu//IorhlAiunLa@kroah.com>
References: <20220723073805.23491-1-xy521521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723073805.23491-1-xy521521@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 03:38:05PM +0800, xy521521 wrote:
> From: Hongyu Xie <xiehongyu1@kylinos.cn>
> 
> Forcing HC to halt state is ensured by reading STS_HALT field in USBSTS
> register every microsecond(2ms in total) after clearing CMD_RUN filed in
> USBCMD register during initialization.
> 
> But sometimes the STS_HALT field in USBSTS is not set during that 2ms, i.e
> ehci_handshake returns -ETIMEDOUT. And host controller won't work after
> that, so does the device attached on it. This was first found on a system
> with ZX-200 HC on it.
> 
> The interesting part is that if you ignore -ETIMEOUT returned from
> ehci_handshak or read CMD_RUN instead and continue the initialization, the
> HC works just fine.
> 
> So read CMD_RUN instead.

You do not define what a "ZX-200" is, please do so.

This feels like a bug in the hardware, right?  If so, why not make a new
quirk flag for it and handle it that way as odds are it probably is in
other devices based on this silicon.

> 
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>

Is thie relevant for stable kernels?  If so, how far back?

> ---
>  drivers/usb/host/ehci-hcd.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 684164fa9716..a935cfb79bcc 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -181,6 +181,7 @@ static int tdi_in_host_mode (struct ehci_hcd *ehci)
>  static int ehci_halt (struct ehci_hcd *ehci)
>  {
>  	u32	temp;
> +	struct pci_dev  *pci_dev = to_pci_dev(ehci_to_hcd(ehci)->self.controller);

Wait, how do you know this is a PCI device?  What happens when you run
this on a ehci controller that is not a PCI device?  How well did you
test this change?

>  
>  	spin_lock_irq(&ehci->lock);
>  
> @@ -204,8 +205,14 @@ static int ehci_halt (struct ehci_hcd *ehci)
>  	spin_unlock_irq(&ehci->lock);
>  	synchronize_irq(ehci_to_hcd(ehci)->irq);
>  
> -	return ehci_handshake(ehci, &ehci->regs->status,
> -			  STS_HALT, STS_HALT, 16 * 125);
> +	if (((pci_dev->vendor == PCI_VENDOR_ID_ZHAOXIN) &&
> +		(pci_dev->device == 0x3104) &&
> +		((pci_dev->revision & 0xf0) == 0x90)))
> +		return ehci_handshake(ehci, &ehci->regs->command, CMD_RUN,
> +				0, 16 * 125);

What is the "0" here for?

> +	else

No need for the else statement, checkpatch should have caught that,
right?

thanks,

greg k-h
