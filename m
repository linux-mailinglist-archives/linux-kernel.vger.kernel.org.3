Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232E047CE62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbhLVIik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239721AbhLVIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:38:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662CCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:38:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CC2DB81A52
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 08:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF121C36AE8;
        Wed, 22 Dec 2021 08:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640162316;
        bh=UR4EKc0/bCNdoXjQZxr7F+L+PvTK1DfNqQdTTxtLOKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WhqmxEpue7hGYMOPQ5sJ2GIKryc6nEK9DVICWbV3VnZadwINFulhNU0rfhYHTVQm4
         iYMCi/d8vHS9Gb21u9i2m5DmrKYg2EvweCc/lDjJBoztkln+Yngv6oYAZvVOC8sWww
         0bToS6Rm/ybj6NTUqzHc42wyc81dfoAlVae8V6pWJ/LLFbWbz1t3HC8vmEF46Xzq6F
         kUHaBvzTXLmi+6YqUCPpAqN9xSyKm4G81mUEAXvioTEXAs9C8HXTpO9kYiSVN7VKqE
         1P9cQTqmuwmX6Y3naQwhsfKWNANWLovDhsMu3VKkvGTmc+ULXR1BGSHXNY70zD0XBp
         +sR3VOnxSx6ZA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzx8l-0002vV-TV; Wed, 22 Dec 2021 09:38:28 +0100
Date:   Wed, 22 Dec 2021 09:38:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register()
 error path
Message-ID: <YcLkA0e48+xuGsHk@hovoldconsulting.com>
References: <20211221154550.11455-1-zajec5@gmail.com>
 <YcH7fw5S6aSXswvb@kroah.com>
 <9e94f0fd-e2d5-4d9e-5759-a5f591191785@gmail.com>
 <YcLXbPzyhtMnP0YQ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YcLXbPzyhtMnP0YQ@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 08:44:44AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 21, 2021 at 06:46:01PM +0100, Rafał Miłecki wrote:
> > On 21.12.2021 17:06, Greg Kroah-Hartman wrote:
> > > On Tue, Dec 21, 2021 at 04:45:50PM +0100, Rafał Miłecki wrote:
> > > > From: Rafał Miłecki <rafal@milecki.pl>
> > > > 
> > > > 1. Drop incorrect put_device() calls
> > > > 
> > > > If device_register() fails then underlaying device_add() takes care of
> > > > calling put_device() if needed. There is no need to do that in a driver.
> > > 
> > > Did you read the documentation for device_register() that says:
> > > 
> > >   * NOTE: _Never_ directly free @dev after calling this function, even
> > >   * if it returned an error! Always use put_device() to give up the
> > >   * reference initialized in this function instead.
> > 
> > I clearly tried to be too smart and ignored documentation.
> > 
> > I'd say device_add() behaviour is rather uncommon and a bit unintuitive.
> > Most kernel functions are safe to assume to do nothing that requires
> > cleanup if they fail.
> > 
> > E.g. if I call platform_device_register() and it fails I don't need to
> > call anything like platform_device_put(). I just free previously
> > allocated memory.
> 
> And that is wrong.

It seems Rafał is mistaken here too; you certainly need to call
platform_device_put() if platform_device_register() fail, even if many
current users do appear to get this wrong.

Johan
