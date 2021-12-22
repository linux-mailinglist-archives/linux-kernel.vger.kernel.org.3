Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71A747CF3B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbhLVJ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbhLVJ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:29:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE3AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:29:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44E5761959
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52785C36AE5;
        Wed, 22 Dec 2021 09:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640165367;
        bh=JoRSr6T8RTSX5VBLuEu0rKVX6/srNrSDAX3PPW4VgLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y58lMK+H+yBG9FncTwK7/+J1PeOvnZYd37CotV+yS8Gc2KV3aXSmZyQBxEfvCqDSE
         P0Gbw70sFuuT+wgvbb3Ns28+q/swV7Ru9ygD3UaV6h4suEcBVQ7l3k32KX7TdW2Z/d
         /xjHQmNjUwbkTdrhGRQBYB80Ij7JyJdSVq/pIfAg=
Date:   Wed, 22 Dec 2021 10:29:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register()
 error path
Message-ID: <YcLv9aMZOEHfBtAJ@kroah.com>
References: <20211221154550.11455-1-zajec5@gmail.com>
 <YcH7fw5S6aSXswvb@kroah.com>
 <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
 <YcLXbPzyhtMnP0YQ@kroah.com>
 <YcLkA0e48+xuGsHk@hovoldconsulting.com>
 <52a2a318-0efe-94af-b8b9-308c2fbb1fab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52a2a318-0efe-94af-b8b9-308c2fbb1fab@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:00:03AM +0100, Rafał Miłecki wrote:
> On 22.12.2021 09:38, Johan Hovold wrote:
> > On Wed, Dec 22, 2021 at 08:44:44AM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Dec 21, 2021 at 06:46:01PM +0100, Rafał Miłecki wrote:
> > > > On 21.12.2021 17:06, Greg Kroah-Hartman wrote:
> > > > > On Tue, Dec 21, 2021 at 04:45:50PM +0100, Rafał Miłecki wrote:
> > > > > > From: Rafał Miłecki <rafal@milecki.pl>
> > > > > > 
> > > > > > 1. Drop incorrect put_device() calls
> > > > > > 
> > > > > > If device_register() fails then underlaying device_add() takes care of
> > > > > > calling put_device() if needed. There is no need to do that in a driver.
> > > > > 
> > > > > Did you read the documentation for device_register() that says:
> > > > > 
> > > > >    * NOTE: _Never_ directly free @dev after calling this function, even
> > > > >    * if it returned an error! Always use put_device() to give up the
> > > > >    * reference initialized in this function instead.
> > > > 
> > > > I clearly tried to be too smart and ignored documentation.
> > > > 
> > > > I'd say device_add() behaviour is rather uncommon and a bit unintuitive.
> > > > Most kernel functions are safe to assume to do nothing that requires
> > > > cleanup if they fail.
> > > > 
> > > > E.g. if I call platform_device_register() and it fails I don't need to
> > > > call anything like platform_device_put(). I just free previously
> > > > allocated memory.
> > > 
> > > And that is wrong.
> > 
> > It seems Rafał is mistaken here too; you certainly need to call
> > platform_device_put() if platform_device_register() fail, even if many
> > current users do appear to get this wrong.
> 
> Yes I was! Gosh I made up that "platform_device_put()" name and only
> now I realized it actually exists!
> 
> I stand by saying this design is really misleading. Even though
> platform_device_put() was obviously a bad example.
> 
> Please remember I'm just a minor kernel developer however in my humble
> opinion behaviour of device_register() and platform_device_register()
> should be changed.
> 
> If any function fails I expect:
> 1. That function to clean up its mess if any
> 2. Me to be responsible to clean up my mess if any
> 
> This is how "most" code (whatever it means) works.
> 1. If POSIX snprintf() fails I'm not expected to call *printf_put() sth
> 2. If POSIX bind() fails I'm not expected to call bind_put() sth
> 3. (...)
> 
> I'm not sure if those are the best examples but you should get my point.

I do understand, and for platform_device_register() I agree with you.

But for device_register() we can not do this as the driver core is not
the "owner" of the structure being passed into it.  If you call
device_register() you are bus and you have to know how to handle an
error here as there is usually much more that needs to be done that a
device_put() can not do by the core.

Yes, it's well down on the "Rusty's API usability scale", but it is
documented well and in a number of places for device_register().

platform_device_register() is not documented, and that's not good, so we
should fix it up.  Although there's the larger issue of everyone using
static 'struct device' for this which is yet-another-reason I hate the
platform device code.

thanks,

greg k-h
