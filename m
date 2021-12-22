Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0EC47CE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243547AbhLVI4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:56:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60402 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243502AbhLVI4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:56:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EF9C61940
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 08:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71860C36AE5;
        Wed, 22 Dec 2021 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640163393;
        bh=TmCoqWH4x3ydeTsuaY7t9E9/Y8W4IomlRr92OXsU9r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/I9aRfOhps+fvWOVm9ulmA3HZZJ98clsZuN05o2Yct/34GZGq+G/1B0Wt+enJo27
         qFxenyGuHYac5TKjyBwcoolpmxJ4ocJb8JRN+UG7CBwoFXGpXNJX+QSgFvLhhxHwpg
         Ey+mIB6sWG/v/4s3TT2PDyfP/9271UVO5QGdgDEE=
Date:   Wed, 22 Dec 2021 09:56:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register()
 error path
Message-ID: <YcLoPV6A9XJImBXa@kroah.com>
References: <20211221154550.11455-1-zajec5@gmail.com>
 <YcH7fw5S6aSXswvb@kroah.com>
 <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
 <YcLXbPzyhtMnP0YQ@kroah.com>
 <YcLkA0e48+xuGsHk@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YcLkA0e48+xuGsHk@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:38:27AM +0100, Johan Hovold wrote:
> On Wed, Dec 22, 2021 at 08:44:44AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Dec 21, 2021 at 06:46:01PM +0100, Rafał Miłecki wrote:
> > > On 21.12.2021 17:06, Greg Kroah-Hartman wrote:
> > > > On Tue, Dec 21, 2021 at 04:45:50PM +0100, Rafał Miłecki wrote:
> > > > > From: Rafał Miłecki <rafal@milecki.pl>
> > > > > 
> > > > > 1. Drop incorrect put_device() calls
> > > > > 
> > > > > If device_register() fails then underlaying device_add() takes care of
> > > > > calling put_device() if needed. There is no need to do that in a driver.
> > > > 
> > > > Did you read the documentation for device_register() that says:
> > > > 
> > > >   * NOTE: _Never_ directly free @dev after calling this function, even
> > > >   * if it returned an error! Always use put_device() to give up the
> > > >   * reference initialized in this function instead.
> > > 
> > > I clearly tried to be too smart and ignored documentation.
> > > 
> > > I'd say device_add() behaviour is rather uncommon and a bit unintuitive.
> > > Most kernel functions are safe to assume to do nothing that requires
> > > cleanup if they fail.
> > > 
> > > E.g. if I call platform_device_register() and it fails I don't need to
> > > call anything like platform_device_put(). I just free previously
> > > allocated memory.
> > 
> > And that is wrong.
> 
> It seems Rafał is mistaken here too; you certainly need to call
> platform_device_put() if platform_device_register() fail, even if many
> current users do appear to get this wrong.

A short search found almost everyone getting this wrong.  Arguably
platform_device_register() can clean up properly on its own if we want
it to do so.  Will take a lot of auditing of the current codebase first
to see if it's safe...

thanks,

greg k-h
