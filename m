Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E21247AA54
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 14:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhLTNZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 08:25:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43260 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhLTNZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 08:25:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08726B80E7A;
        Mon, 20 Dec 2021 13:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22C0C36AE7;
        Mon, 20 Dec 2021 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640006740;
        bh=0T59YL2OCFcODnHmhNy9+75kRZWCcmXfi5sDEdf+KN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E60I34AveczV273rQoLyFjfKWCHv2UnnQiWQ97Zwlfm5ggIWj5s+XPKIS+ehDHnnj
         Di65tsPzVCLnfnOU4xEMUlvSWrz18GhHiibZFOR4GYQC3p08idBR5yKlqeWw5n4gcg
         PtlE+W0XUFWVFD0meUg1s6navLR4wveH/zJ9+pdqXDvJPHZNQq1AoTwwxXOdm11kR7
         aFaUW1XuTqCwo3uZbWu1MpFRXlFBXENmvMoaiJUkx5e4h3rxBd0dXtg2G3PyXm/fQV
         Yucncu9DWaeYJoBzT/HQI2Ak7feVgES+xBsZY0C91TxNDuvCuXCszsWkPGgUEDJWnW
         WsOuk354AOhSg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzIfV-0006Ni-Aa; Mon, 20 Dec 2021 14:25:34 +0100
Date:   Mon, 20 Dec 2021 14:25:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Marc Ferland <ferlandm@amotus.ca>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gnss: add USB support
Message-ID: <YcCETSO17GpP+3Hh@hovoldconsulting.com>
References: <20211220111901.23206-1-johan@kernel.org>
 <20211220111901.23206-2-johan@kernel.org>
 <091d25b4-cfa5-c702-144a-8cfdb70b7f42@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <091d25b4-cfa5-c702-144a-8cfdb70b7f42@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 01:49:23PM +0100, Oliver Neukum wrote:
> 
> On 20.12.21 12:19, Johan Hovold wrote:
> > +static int gnss_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)

> > +	urb = usb_alloc_urb(0, GFP_KERNEL);
> > +	if (!urb)
> > +			goto err_put_gdev;
> 
> The value of 'ret' here is the result of
> usb_find_common_endpoints(), hence 0 due to the prior test.

> > +err_free_buf:
> > +	kfree(buf);
> > +err_free_urb:
> > +	usb_free_urb(urb);
> > +err_put_gdev:
> > +	gnss_put_device(gdev);
> > +err_free_gusb:
> > +	kfree(gusb);
> > +
> > +	return ret;
> Yet you return it in the error case and subsequent error cases..

Thanks for spotting that! I'll fix it up before applying.

Johan
