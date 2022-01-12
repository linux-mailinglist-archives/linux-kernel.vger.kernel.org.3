Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E144948CB6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356356AbiALTAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344097AbiALTAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:00:54 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FB4C061751
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:00:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u11so208334plh.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mQS/VpnaZwp8vvBS7bW5RHzkJL7wrZtEei5jO98xz0Q=;
        b=OAU0pdMxyZLnZaVRj4tCpd5R434J7CI/Lj/NOaC/jRmbpDS+B3al1wYTjRspajEWsE
         rTJvonQvUe3wivOOa1sbh4K5XL50Jsp7Qvdm5SOVVgwH9cxGyuoId4nY/1AnulhnE3ej
         inrb+2rKK2pDmkkym/+yX9RvH4VU3IoROZADc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mQS/VpnaZwp8vvBS7bW5RHzkJL7wrZtEei5jO98xz0Q=;
        b=pgjZ2FOQ3n3njGEz6qs9FwsKFwVAuBgRrY/VNmqx13xzzogDdzbwAgQbbER9ZCb15T
         vJ6Fekee4u3sQor/ftsbdMLQJ8Lmv7oWoMo7/k+orjFxSKkKYT5I8KI0PU/r0PIxSmz/
         lJW06AjTxKWG8AzO/aDAmL0Hz1tOvvEKvfuhE6+uQf/3efXGIYK6WVvO1rCTnPrHiOQp
         UfI86+cpCYDI8bt/cZfvup8Uxv4H2lKRg1frB2qPLz3p20nkFWkRWV0f7SZvb+U2vmdX
         ytJzOxFlBICM1hbtVRID9KXqOCgUE294/OZv1JGMhBBKVrYDofYIFtiODuFJ+KUDUKNN
         TRoQ==
X-Gm-Message-State: AOAM532apdl3Po1md0HYPphP7ochjURSpM/ExUP4Feeqx+pWUw+Mc5sf
        2+HrfKT4r+vEvJZ+ZEakV9jFpQ==
X-Google-Smtp-Source: ABdhPJziYkjp5Qh/pCL7g6DVoLUFpI0ITlTEoFjsrZOZJgIWm57pRipwsx88yOx+fcsRn1cq/jKDhA==
X-Received: by 2002:a63:3855:: with SMTP id h21mr877305pgn.157.1642014052994;
        Wed, 12 Jan 2022 11:00:52 -0800 (PST)
Received: from localhost ([2620:15c:202:201:f6eb:5b26:28c:1ca5])
        by smtp.gmail.com with UTF8SMTPSA id k2sm379855pgh.11.2022.01.12.11.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 11:00:52 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:00:50 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v17 1/7] usb: misc: Add onboard_usb_hub driver
Message-ID: <Yd8lYiWeVEy8Pq0x@google.com>
References: <20211116200739.924401-1-mka@chromium.org>
 <20211116120642.v17.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <07781322-3632-7d63-0da8-a651a438a3ff@gmail.com>
 <Yc4T1qSkcRF2iBVg@google.com>
 <1c37be43-4102-6afe-fb05-4cac21ac4d98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c37be43-4102-6afe-fb05-4cac21ac4d98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 01, 2022 at 03:23:22PM +0300, Dmitry Osipenko wrote:
> 30.12.2021 23:17, Matthias Kaehlcke пишет:
> > On Mon, Dec 20, 2021 at 11:05:28PM +0300, Dmitry Osipenko wrote:
> >> 16.11.2021 23:07, Matthias Kaehlcke пишет:
> >>> +static const struct usb_device_id onboard_hub_id_table[] = {
> >>> +	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS0411 USB 3.0 */
> >>> +	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.0 */
> >>> +	{},
> >>> +};
> >>
> >> RTS5411 two times in the comments?
> > 
> > One time, the other is RTS0511
> > 
> >> Internet suggests that RTS5411 is USB 3.0
> > 
> > Correct, however the chip internally has two hubs, one for USB2 and one for
> > USB3:
> > 
> >   Bus 002 Device 002: ID 0bda:0411 Realtek Semiconductor Corp. 4-Port USB 3.1 Hub
> >   Bus 001 Device 002: ID 0bda:5411 Realtek Semiconductor Corp. 4-Port USB 2.1 Hub
> 
> Alright, thanks.
> 
> >> Are these hubs expected to be powered-on only when upstream port is
> >> enabled? Shouldn't runtime PM be used for that somehow?
> > 
> > In the general case I would expect that a onboard hub is connected to a port
> > that is enabled. For now I think it's fine to power the hub always when the
> > system is running (which is also the current situation with using always-on
> > regulators). If someone has an actual use case where the upstream port can
> > be disabled they can add support for that later.
> > 
> 
> I see that you're handling the wakeup-capable devices during the
> driver's suspend, perhaps it should work okay then.
> 
> BTW, shouldn't the "companion-hub" need to be turned into a generic USB
> property? The onboard-usb-hub looks like a generic thing, but
> "companion-hub" is specific to the RTS5411 binding.

The series started with a generic binding, however Rob didn't like that. To my
knowledge there is currently no dedicated binding for USB hubs where such a
property could be added.
