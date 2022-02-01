Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07724A58A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiBAInB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:43:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57618 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiBAInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:43:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE279614E5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 08:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFA7C340EB;
        Tue,  1 Feb 2022 08:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643704973;
        bh=tuTz/4vnnYgcufzTAZfha7A80BzViBwYZlGg6z5D0gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dwBuy8Y8eSxQ0fFRIa2HthV6Wp4eIxVaObH7hIS3OOWLNJQ2CnsTYnNbL5pn2OLbk
         p+T9Ob1r/ZYG/SlB5E/HwTfh/aOvkLeGcNRS0XK7qheSTBEjHPh/kFEFa3V1Bh7+sg
         tTizMeZmKJyK3NjuIeLTGxUbc3Ez7sw3vzCmSCzo=
Date:   Tue, 1 Feb 2022 09:42:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 0/2] firmware: Add boot information to sysfs
Message-ID: <YfjyiuWBeJeHCg7q@kroah.com>
References: <20220201050501.182961-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201050501.182961-1-joel@jms.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 03:34:59PM +1030, Joel Stanley wrote:
> This is the second iteration of this idea. The first used socinfo
> custom attribute groups, but Arnd suggested we make this something
> standardised under /sys/firmware instead:
> 
>  http://lore.kernel.org/all/CAK8P3a3MRf0aGt1drkgsuZyBbeoy+S7Ha18SBM01q+3f33oL+Q@mail.gmail.com
> 
> Some ARM systems have a firmware that provides a hardware root of
> trust. It's useful for the system to know how this root of trust has
> been configured, so provide a standardised interface that expose this
> information to userspace.
> 
> This is implemented as a sysfs attribute group registration to be called
> at boot, with the properties described in the ABI document.
> 
> Alternatively we could put the properties in the driver core, and have
> platforms register callbacks for each supported property. This would
> make it harder to insert non-standard properties, with the trade off of
> more code to selectively show supported properties.

It is trivial to selectively show properties in sysfs, the is_visible()
callback is there for this very reason.

So yes, this should be in the driver core so that we do not have random
platform values and fields that have no relation to each other at all.

For example, you could provide these fields for UEFI today, right?  That
would be a good proof if this really can work for multiple systems or
not.

thanks,

greg k-h
