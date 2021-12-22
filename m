Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690D247CDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243058AbhLVHos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:44:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34090 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhLVHor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:44:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F2D16189F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 07:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1057FC36AE8;
        Wed, 22 Dec 2021 07:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640159086;
        bh=vkHajpWN3p1MMrZ4HvcJzEwOALIp1X3ZS3EL2D5vfwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCkOqH8OwRODpePjYLrOqWT5JzBQHo8D6u882x33xkAs5wMui2qxHu7+4Jw3i3jdn
         6y1tvddRPfb8ksWI9nmIzPQ1LiUZByrtVXzDPp/IEzQF848MgSiIOj2zNBdWRH7Un6
         6kg8OwdzCW6mi3p4ZIZgPTn1l6ee75S1iHmexO5k=
Date:   Wed, 22 Dec 2021 08:44:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register()
 error path
Message-ID: <YcLXbPzyhtMnP0YQ@kroah.com>
References: <20211221154550.11455-1-zajec5@gmail.com>
 <YcH7fw5S6aSXswvb@kroah.com>
 <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 06:46:01PM +0100, Rafał Miłecki wrote:
> On 21.12.2021 17:06, Greg Kroah-Hartman wrote:
> > On Tue, Dec 21, 2021 at 04:45:50PM +0100, Rafał Miłecki wrote:
> > > From: Rafał Miłecki <rafal@milecki.pl>
> > > 
> > > 1. Drop incorrect put_device() calls
> > > 
> > > If device_register() fails then underlaying device_add() takes care of
> > > calling put_device() if needed. There is no need to do that in a driver.
> > 
> > Did you read the documentation for device_register() that says:
> > 
> >   * NOTE: _Never_ directly free @dev after calling this function, even
> >   * if it returned an error! Always use put_device() to give up the
> >   * reference initialized in this function instead.
> 
> I clearly tried to be too smart and ignored documentation.
> 
> I'd say device_add() behaviour is rather uncommon and a bit unintuitive.
> Most kernel functions are safe to assume to do nothing that requires
> cleanup if they fail.
> 
> E.g. if I call platform_device_register() and it fails I don't need to
> call anything like platform_device_put(). I just free previously
> allocated memory.

And that is wrong.

{sigh}

Seems the author of that function did not read the documentation.  I'll
add "fix platform_device_register()" to my long TODO list.  Arguably, it
should handle this type of failure internally to it, to prevent all
individual drivers from having to handle it.

You also need to handle this type of functionality in your bus call, and
you do, which is good as you do not want everyone who calls
nvmem_register() to also have to do much the same thing.

> When calling device_register() / device_add() it seems device always
> gets partially registered (even if it fails!). Enough to make it safe to
> depend on core subsystem calling .release() after device_put().
> 
> So what initially looks like unbalanced device_put() call is actually
> some device_add() specific magic behaviour ;)

It's documented magic behavior :)

thanks,

greg k-h
