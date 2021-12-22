Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710A147CED8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243672AbhLVJI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243641AbhLVJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:08:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0DCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:08:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D6ABB81B4D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC91EC36AE8;
        Wed, 22 Dec 2021 09:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640164133;
        bh=2uhZVMLfYhRIBj/oj2LEo5kQRDnygLeV2amJiHrb5rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUdKJPOlOAgaPaJOM/JdQGml86s99/i47mG2QUCAjwR3ArAazeDlPDeixMtMOLedb
         pISgzfz8vttHpq4MNFAs3Z4UTbvuIhWIZVB4ZdBxsbf6cSk83Jpt+3hRR/20incwoX
         5xDmDof+kxtdIffJ95IMnt+jQ0dATe2Got5NvgwouVLR36ZBk/WuVEUg9FrpknuKsH
         r7g3kGabL79zbdJFb6u4atQ7doZ3gmYFtBJcrzFFVuPE0IIJnWb1mbDt6ZPostwcVn
         C5BBLO/jEjxjj6wx2lQA5D6UHquxFVEV/ZnwQEWapAPsu3zEoPFQtX9/b1EhQYGYhj
         O9IdoUgObn61g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mzxc4-00036f-4X; Wed, 22 Dec 2021 10:08:44 +0100
Date:   Wed, 22 Dec 2021 10:08:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] nvmem: fix unregistering device in nvmem_register()
 error path
Message-ID: <YcLrHEoOy3iRSkFp@hovoldconsulting.com>
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

Yes, and we all agree that it's not the best interface. But it exists,
and changing it now risks introducing worse problem than a minor, mostly
theoretical, memleak.

Johan
