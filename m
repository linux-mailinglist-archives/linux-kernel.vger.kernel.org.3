Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91216512B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243518AbiD1GRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiD1GRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:17:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6E621257
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A13AB82B2B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 06:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD9CC385A0;
        Thu, 28 Apr 2022 06:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651126427;
        bh=oipGbngq1gZo295e2cSvyLZBfjBxWVkQIRHYavIJvKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MM4aou7b6uTZ8Z7TnesdkB8nOuHoPrBWBuvAazpJnPQCr9vbr9CInsUpBX/wfnyQ1
         S7ya2jmiUULQvXRL2R4Hf+VFZbAysoanFKFuDUuJ9aT/z6/8HJOb2CEudCSkOVqf1z
         xpMiqzJaTkBTCLVcw9CrZ4qEgYiSb/08NHL3ggWc=
Date:   Thu, 28 Apr 2022 08:13:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] platform: finally disallow IRQ0 in platform_get_irq()
 and its ilk
Message-ID: <YmowldgtcBvwkS1M@kroah.com>
References: <025679e1-1f0a-ae4b-4369-01164f691511@omp.ru>
 <YmfNi3j/sL9PdByv@kroah.com>
 <d0a51ca4-e535-01cc-fb08-2a59ad2e50dd@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a51ca4-e535-01cc-fb08-2a59ad2e50dd@omp.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:59:41PM +0300, Sergey Shtylyov wrote:
> Hello!
> 
> On 4/26/22 1:46 PM, Greg Kroah-Hartman wrote:
> 
> >> The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
> >> invalid") only calls WARN() when IRQ0 is about to be returned, however
> >> using IRQ0 is considered invalid (according to Linus) outside the arch/
> >> code where it's used by the i8253 drivers. Many driver subsystems treat
> >> 0 specially (e.g. as an indication of the polling mode by libata), so
> >> the users of platform_get_irq[_byname]() in them would have to filter
> >> out IRQ0 explicitly and this (quite obviously) doesn't scale...
> >> Let's finally get this straight and return -EINVAL instead of IRQ0!
> >>
> >> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> >> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> >> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> [...]
> 
> > Ok, let's try this now.
> 
>    Well, better late than never! :-)
> 
> > Worst case, we revert it later :)
> 
>    Please just don't revert it outright on the 1st issue report -- give me time
> to look at the issue(s) reported...
>    BTW, I've CC'ed you on the SH patch that avoids using IRQ0. Please help to
> merge it (v1/v2 were posted on February 11th and there was no motion since then)!

I can't merge that until a sh maintainer acks it.  Is that arch even
still alive?

thanks,

greg k-h
