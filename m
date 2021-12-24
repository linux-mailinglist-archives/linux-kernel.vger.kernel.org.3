Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2D347ED93
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 09:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352120AbhLXI7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 03:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbhLXI72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 03:59:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EDAC061401;
        Fri, 24 Dec 2021 00:59:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C774B82238;
        Fri, 24 Dec 2021 08:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB59C36AE5;
        Fri, 24 Dec 2021 08:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640336365;
        bh=Gh11WWbnMCjkjNIzAwdSQnj6/O8C60z4b4LA5IW1Y7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcAGa3+QDIjrTS1rhABUzg1XuiCjNCAjVhxDR26xUu28WAfcRs9RUdwcUrcrPXM6k
         IEp/BzFn+PR1RJ7EzSPDht1+N2vXGgEVD/GGub4cSlJnu5fx4WaSeNOzbjL6tczNK1
         k2i1/k7DRKA6Rq3S8YvKZ6paVnt5ZveDV20lOtzQ=
Date:   Fri, 24 Dec 2021 09:59:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     hammer hsieh <hammerh0314@gmail.com>
Cc:     robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jirislaby@kernel.org, p.zabel@pengutronix.de, wells.lu@sunplus.com,
        Hammer Hsieh <hammer.hsieh@sunplus.com>
Subject: Re: [PATCH v5 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Message-ID: <YcWL4c0e02mzETMp@kroah.com>
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
 <YcCmaJkeKy+R0mhF@kroah.com>
 <CAOX-t54j9=7eLMAx4n-ngiNdM=Ab=YcK-zdxRW88e41cPS=46Q@mail.gmail.com>
 <YcGOmzKSHOoycZNC@kroah.com>
 <CAOX-t55fBM7u3qZm7ubLANDnWNFhCiBXB29v00racWd-gy3OgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX-t55fBM7u3qZm7ubLANDnWNFhCiBXB29v00racWd-gy3OgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 03:16:55PM +0800, hammer hsieh wrote:
> Hi, Greg KH :
> 
> In patch v1 coding quite mess, it is almost 2000 LOCs.
> For down size code under 1000 LOCs, I decide to drop DMA function code
> after patch v3.
> I think that's the biggest difference compared with 8250.
> Without DMA function, like you said it looks like 8250 variant.
> I think I should put DMA function back in next submit.

The 8250 driver handles DMA just fine today, why is your chip doing it
differently?  Are you sure it is a different chip?  Who created a new
uart chip these days?

> Another question for why I need PORT_SLUNPLUS ?
> I just check many other uart driver, almost all driver define their
> own PORT number.
> Actually, I didn't know about it.
> Maybe some device like bluetooth(use uart port) need autoconfig.
> Then it will call ioctl with TIOCSERCONFIG.
> I don't have tool for calling type/config/request/release/verify.

If you do not need it, and you can not test for it, please do not add
it.

thanks,

greg k-h
