Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F249546471A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346902AbhLAGVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346855AbhLAGVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:21:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCCAC061574;
        Tue, 30 Nov 2021 22:18:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03312B81DCF;
        Wed,  1 Dec 2021 06:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E73C53FAD;
        Wed,  1 Dec 2021 06:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638339496;
        bh=VPRDQ89SUILlUjx+vs2IsxZqXAW8pekN6ey9IeNPVhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSnSqYGTJBmMTILji3ZZ9WCzHTPvzncE0mHBd0oXUTBKJJEoBaSP7585NBjF2+18N
         jFahLiglhNv4/FLygY44ADbwGRfAo8mT0ogwIkNnXXB4V8+q/a5ep18PUXn2RFpMHp
         oaq1IijLXR4DdCzWUgP6e+cEbNtuLkwcGc+oFoQM=
Date:   Wed, 1 Dec 2021 07:18:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
Message-ID: <YacTpI7k5gTDQ4Ki@kroah.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-2-neal_liu@aspeedtech.com>
 <YaYOvgCaO4FJ8r+z@kroah.com>
 <HK0PR06MB3202436CA49363FD3F60212380689@HK0PR06MB3202.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR06MB3202436CA49363FD3F60212380689@HK0PR06MB3202.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 05:43:16AM +0000, Neal Liu wrote:
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Tuesday, November 30, 2021 7:45 PM
> > To: Neal Liu <neal_liu@aspeedtech.com>
> > Cc: Felipe Balbi <balbi@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew
> > Jeffery <andrew@aj.id.au>; Cai Huoqing <caihuoqing@baidu.com>; Tao Ren
> > <rentao.bupt@gmail.com>; Julia Lawall <julia.lawall@inria.fr>; kernel test
> > robot <lkp@intel.com>; Sasha Levin <sashal@kernel.org>;
> > linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org; BMC-SW
> > <BMC-SW@aspeedtech.com>
> > Subject: Re: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
> > 
> > On Tue, Nov 30, 2021 at 06:42:53PM +0800, Neal Liu wrote:
> > > Support qualifier descriptor to pass USB30CV compliance test.
> > 
> > Please provide more information here in this description.  This does not
> > explain what is happening here very well.
> > 
> > Also, what is "USB30CV"?
> > 
> 
> USB 3 Command Verifier (USB3CV) is the official tool for USB 3 Hub and Device Framework testing.
> The USB3CV tool includes the xHCI Compliance Drivers for use with the USB3CV.

Please put that information in the changelog text.

> We would like to pass USB3CV - Chapter 9 Test [USB 2 devices] - Device Qualifier Tests.
> A high-speed capable device that has different device information for full-speed and high-speed
> must have a Device Qualifier Descriptor.
> This patch is to support device qualifier, and the host will retrieve it through Get Descriptor request.

Again, this type of information needs to go into the changelog text.

thanks,

greg k-h
