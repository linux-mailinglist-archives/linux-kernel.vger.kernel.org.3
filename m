Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF00A50B0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444520AbiDVGvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386779AbiDVGvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE1250E00
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16224B82A8A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077D5C385A4;
        Fri, 22 Apr 2022 06:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650610098;
        bh=gISDvz+D8qTMQ5Gp5PJQM46yJh6C9L4liYxsGrNBnKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgcKhRLnA244Wn4UbJjktxAmaZtk7y5n4z/WkITGoHr888a7zSvTs8WVDspEYoSOL
         lkrlZfuEeFN6V9GTnoYBf8goHmYMx7UzmOWUdpCozkSrgwxY3tCNi3Af1cdVAzEK+F
         j8Lj3f0q5CdC8OZjm6dI9M52+JUVzCRJJDS06jWA=
Date:   Fri, 22 Apr 2022 08:48:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v3 0/3] firmware: Add boot information to sysfs
Message-ID: <YmJPrxB8x/zE4Vy7@kroah.com>
References: <20220204072234.304543-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204072234.304543-1-joel@jms.id.au>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 05:52:31PM +1030, Joel Stanley wrote:
> v3 resolves Greg's review for the bootinfo header and macros, and drops
> uart_boot as it's unlikely to be common across platforms.
> 
> v2 reworks the series to put the sysfs properties in the core, and
> optionally show them with the is_visible() callback.
> 
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
> This is implemented as a sysfs attribute group registration in the
> driver core, with platforms populating values obtained from firmware at
> kernel boot time.
> 
> Patch 2 provides a user of the properties on an ARM system.
> 
> Patch 3 is new in v2 and is an example of populating bootinfo with the
> EFI secure boot status.

I would like arch maintainers to review this before it going any
further.

thanks,

greg k-h
