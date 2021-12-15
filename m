Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F217475BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244015AbhLOPkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244007AbhLOPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:40:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63835C061574;
        Wed, 15 Dec 2021 07:40:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7FDB618C5;
        Wed, 15 Dec 2021 15:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412B3C350A0;
        Wed, 15 Dec 2021 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639582810;
        bh=lnaJeZrmcfRPUXrS5zYz/AbX8ZL7Dk9Dej0q5x35Vas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7YfzR+RqR3AOZBSUB7Po5wUzm3IqFw9tPYlCgZDkoaVzkQ1OzKXQY7qKrJcP7Iit
         waFiYflUVOl9s9vBmW0LVzqys8a0xSfzMamrXwv8DxGSoTIDMAwJNNaWn9D1f+dPG0
         d5PuzPiv97CT0gb0JC8GgkjNWPsv51CfTv+gWMx0=
Date:   Wed, 15 Dec 2021 16:19:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>,
        Andrew Scull <ascull@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] misc: open-dice: Add driver to expose DICE data
 to userspace
Message-ID: <YboHh6TJJ0VNHpV2@kroah.com>
References: <20211215150410.1707849-1-dbrazdil@google.com>
 <20211215150410.1707849-3-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215150410.1707849-3-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 03:04:10PM +0000, David Brazdil wrote:
> +	drvdata = devm_kmalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	*drvdata = (struct open_dice_drvdata){
> +		.lock = __SPIN_LOCK_UNLOCKED(drvdata->lock),
> +		.rmem = rmem,
> +		.misc = (struct miscdevice){
> +			.parent	= dev,
> +			.name	= drvdata->name,
> +			.minor	= MISC_DYNAMIC_MINOR,
> +			.fops	= &open_dice_fops,
> +			.mode	= 0600,
> +		},
> +	};

That is a lovely abuse of an implicit memcpy(), took me a while to
realize what it was doing here...

Anyway, this all looks great to me, I'll wait for the DT maintainers to
review the dt change before being able to take this through my tree.
Thanks for the cleanups based on the review, the driver is now almost
1/3 smaller than your first version with more functionality!

thanks,

greg k-h
