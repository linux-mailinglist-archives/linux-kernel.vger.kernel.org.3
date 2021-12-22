Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1729C47CF40
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbhLVJaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:30:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45066 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbhLVJaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:30:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE42761940
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7539C36AE8;
        Wed, 22 Dec 2021 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640165409;
        bh=KaadygKFqB7daGLi8fihDH+uRSoXsMcZn5V+R8Hl+Eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2CGM/fhPZIQwNkMdJ6ZBYHUD/TE0adXSu/RUnujxkPMgkUNpjve5BPi72GKtdzen
         FssLN3jq1EBed+ILxJUn19g1aNOzngzbuNoEeICP8dmLu3xb6CY8QYjIoayQcqfA9t
         olrI7kojezPeoOzacYOIJzuSSpDTICqS2fZcw8iY=
Date:   Wed, 22 Dec 2021 10:30:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Johan Hovold <johan@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register()
 error path
Message-ID: <YcLwHqvyJMQNsxdY@kroah.com>
References: <20211221154550.11455-1-zajec5@gmail.com>
 <YcH7fw5S6aSXswvb@kroah.com>
 <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
 <YcLXbPzyhtMnP0YQ@kroah.com>
 <YcLkA0e48+xuGsHk@hovoldconsulting.com>
 <52a2a318-0efe-94af-b8b9-308c2fbb1fab@gmail.com>
 <YcLrHEoOy3iRSkFp@hovoldconsulting.com>
 <c5b76d10-c270-21e5-e528-9aa20b1384ef@milecki.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5b76d10-c270-21e5-e528-9aa20b1384ef@milecki.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:16:20AM +0100, Rafał Miłecki wrote:
> On 22.12.2021 10:08, Johan Hovold wrote:
> > On Wed, Dec 22, 2021 at 10:00:03AM +0100, Rafał Miłecki wrote:
> > > On 22.12.2021 09:38, Johan Hovold wrote:
> > 
> > > > It seems Rafał is mistaken here too; you certainly need to call
> > > > platform_device_put() if platform_device_register() fail, even if many
> > > > current users do appear to get this wrong.
> > > 
> > > Yes I was! Gosh I made up that "platform_device_put()" name and only
> > > now I realized it actually exists!
> > > 
> > > I stand by saying this design is really misleading. Even though
> > > platform_device_put() was obviously a bad example.
> > > 
> > > Please remember I'm just a minor kernel developer however in my humble
> > > opinion behaviour of device_register() and platform_device_register()
> > > should be changed.
> > > 
> > > If any function fails I expect:
> > > 1. That function to clean up its mess if any
> > > 2. Me to be responsible to clean up my mess if any
> > > 
> > > This is how "most" code (whatever it means) works.
> > > 1. If POSIX snprintf() fails I'm not expected to call *printf_put() sth
> > > 2. If POSIX bind() fails I'm not expected to call bind_put() sth
> > > 3. (...)
> > > 
> > > I'm not sure if those are the best examples but you should get my point.
> > 
> > Yes, and we all agree that it's not the best interface. But it exists,
> > and changing it now risks introducing worse problem than a minor, mostly
> > theoretical, memleak.
> 
> Thanks for confirming that, I was wondering if it's just my mind that
> doesn't find this design clear enough.
> 
> Now, assuming this design isn't perfect and some purists would like it
> cleaned up:
> 
> Would that make sense to introduce something like
> 1. device_register2() / device_add2()
> and
> 2. platform_device_register2() / platform_device_add2()
> 
> that would *not* require calling *_put() on failure? Then start
> converting existing drivers to those new (clearner?) helpers?

See my other response, but no, this is not a good idea.
device_register() is correct as-is, but platform_device_register()
isn't.

thanks,

greg k-h
