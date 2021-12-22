Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3635B47CF29
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243887AbhLVJZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239722AbhLVJYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:24:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94408C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:24:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43BC5B81B4D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0861FC36AEA;
        Wed, 22 Dec 2021 09:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640165082;
        bh=ADjjKeMGQq4tz8v/9fPbwYPnoD4URSab2L8MYx05/SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BSWmSZm/CFIW6ox00fGxqrFDUjFOjl9VrexKjZ6siulnw3RpDaKGjehqtbr1gZ0gy
         z5KYDUs4hDBcNQTcjJKPJEmU8wZ+F0ve5GU0qO2PAy+yBsDoBwfR/kzlymgyQ4mGCZ
         RS550JOKlZzNDkERZb8axZWzYLxLUtpmDVi3xi58xmm7KZPrpj1HvR3A4IW09hEfEZ
         f7QLBkHokWcVMTB5ilZxmuNezuvPh2YCNykfvTjcRcWsoKs7F1760VLivSijhX5vgB
         mjWLhk/+Dd8D3C+ZknNcz2J2khdqTCRltB5F7cLhy08P5fjAllMuC/eCGW0dYo3lfU
         R7jyt+by553KQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzxrN-0003BN-4Y; Wed, 22 Dec 2021 10:24:33 +0100
Date:   Wed, 22 Dec 2021 10:24:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register()
 error path
Message-ID: <YcLu0VAMXpiw6l+T@hovoldconsulting.com>
References: <20211221154550.11455-1-zajec5@gmail.com>
 <YcH7fw5S6aSXswvb@kroah.com>
 <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
 <YcLXbPzyhtMnP0YQ@kroah.com>
 <YcLkA0e48+xuGsHk@hovoldconsulting.com>
 <YcLoPV6A9XJImBXa@kroah.com>
 <YcLp1PtcX0QCp2BZ@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YcLp1PtcX0QCp2BZ@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:03:17AM +0100, Johan Hovold wrote:
> On Wed, Dec 22, 2021 at 09:56:29AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Dec 22, 2021 at 09:38:27AM +0100, Johan Hovold wrote:
> > > On Wed, Dec 22, 2021 at 08:44:44AM +0100, Greg Kroah-Hartman wrote:
> > > > On Tue, Dec 21, 2021 at 06:46:01PM +0100, Rafał Miłecki wrote:
> > > > > On 21.12.2021 17:06, Greg Kroah-Hartman wrote:
> > > > > > On Tue, Dec 21, 2021 at 04:45:50PM +0100, Rafał Miłecki wrote:
> > > > > > > From: Rafał Miłecki <rafal@milecki.pl>
> > > > > > > 
> > > > > > > 1. Drop incorrect put_device() calls
> > > > > > > 
> > > > > > > If device_register() fails then underlaying device_add() takes care of
> > > > > > > calling put_device() if needed. There is no need to do that in a driver.
> > > > > > 
> > > > > > Did you read the documentation for device_register() that says:
> > > > > > 
> > > > > >   * NOTE: _Never_ directly free @dev after calling this function, even
> > > > > >   * if it returned an error! Always use put_device() to give up the
> > > > > >   * reference initialized in this function instead.
> > > > > 
> > > > > I clearly tried to be too smart and ignored documentation.
> > > > > 
> > > > > I'd say device_add() behaviour is rather uncommon and a bit unintuitive.
> > > > > Most kernel functions are safe to assume to do nothing that requires
> > > > > cleanup if they fail.
> > > > > 
> > > > > E.g. if I call platform_device_register() and it fails I don't need to
> > > > > call anything like platform_device_put(). I just free previously
> > > > > allocated memory.
> > > > 
> > > > And that is wrong.
> > > 
> > > It seems Rafał is mistaken here too; you certainly need to call
> > > platform_device_put() if platform_device_register() fail, even if many
> > > current users do appear to get this wrong.
> > 
> > A short search found almost everyone getting this wrong.  Arguably
> > platform_device_register() can clean up properly on its own if we want
> > it to do so.  Will take a lot of auditing of the current codebase first
> > to see if it's safe...
> 
> Right, but I found at least a couple of callers getting it it right, so
> changing the behaviour now risks introducing a double free (which is
> worse than a memleak on registration failure). But yeah, a careful
> review might suffice.

Actually, I'm not sure we can (should) change
platform_device_register(). The platform device has been allocated by
the caller and it would be quite counterintuitive to have the
registration function deallocate that memory if registration fails.

Heh, we even have statically allocated structures being registered with
this function and we certainly don't want the helper to try to free
those.

Johan
