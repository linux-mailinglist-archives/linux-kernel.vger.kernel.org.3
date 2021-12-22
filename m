Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7947CEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243793AbhLVJEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:04:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34408 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243590AbhLVJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:03:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4E0FB81B5B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F29C36AE5;
        Wed, 22 Dec 2021 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640163805;
        bh=3nOxUlZwL9mYpqSUkIbOttUvZn2PzPka1mHEIeuhZFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+VmTKyphUE1knByAymwJJMl0nzsa2kAHkDyC6D17OdAHUiae5tGCtlWE6zshtuJO
         3bUKJqfrLJf2h+zhTJ58IfYSVuyeiyV0c0Q7njxvrz5KcsExGlxrOSVQVx6bBf484l
         vKwEj2Br/mVEFm8lr8MDos+N/6z1LDWTNKe/i4BhN70Jrv/3xH2jHzaTg/O7bCyRx/
         S1jzSX4iI43wKogZtY2JOTVak4eaGaRiIi/eAWY7yaKIXOfVETjhM3xMU1Bmx7YSmy
         igDgebPln1V5bgneNWVy3RNCpEJ369Q6f+LAaH0Ifr8oIK8/y6W3YerfAtFoTV43Se
         DP6WcMWl5omSg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzxWm-00035P-Uo; Wed, 22 Dec 2021 10:03:17 +0100
Date:   Wed, 22 Dec 2021 10:03:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register()
 error path
Message-ID: <YcLp1PtcX0QCp2BZ@hovoldconsulting.com>
References: <20211221154550.11455-1-zajec5@gmail.com>
 <YcH7fw5S6aSXswvb@kroah.com>
 <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
 <YcLXbPzyhtMnP0YQ@kroah.com>
 <YcLkA0e48+xuGsHk@hovoldconsulting.com>
 <YcLoPV6A9XJImBXa@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YcLoPV6A9XJImBXa@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:56:29AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 22, 2021 at 09:38:27AM +0100, Johan Hovold wrote:
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
> > > > >   * NOTE: _Never_ directly free @dev after calling this function, even
> > > > >   * if it returned an error! Always use put_device() to give up the
> > > > >   * reference initialized in this function instead.
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
> A short search found almost everyone getting this wrong.  Arguably
> platform_device_register() can clean up properly on its own if we want
> it to do so.  Will take a lot of auditing of the current codebase first
> to see if it's safe...

Right, but I found at least a couple of callers getting it it right, so
changing the behaviour now risks introducing a double free (which is
worse than a memleak on registration failure). But yeah, a careful
review might suffice.

Johan
