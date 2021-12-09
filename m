Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468D446F4F2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhLIUe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhLIUe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:34:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2E3C061746;
        Thu,  9 Dec 2021 12:31:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B6730CE286A;
        Thu,  9 Dec 2021 20:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1A5C341C7;
        Thu,  9 Dec 2021 20:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639081878;
        bh=6r/eB8lxbXJXe5tk1w6eUyewlp1rCQ3ywwINxscRZP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TlVp4htbLaKOiksL0+1MDrhNtwbuvHq9L+yKgkg67hRZrgfc7y8SSCm7b1fhY6eke
         bPYmtvvvYIVtjFphKbYsHIBuXUJAtUPb9AsmTgho/h7XvHqyzndnjRCQ0jiCWpUu+o
         iPdd5jIiRsND4SZIWWhUEZxn/sRykzQA7b17DmIo=
Date:   Thu, 9 Dec 2021 21:31:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     David Brazdil <dbrazdil@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/2] misc: dice: Add driver to forward secrets to
 userspace
Message-ID: <YbJnk7elmP4kUZEH@kroah.com>
References: <20211209151123.3759999-1-dbrazdil@google.com>
 <20211209151123.3759999-3-dbrazdil@google.com>
 <YbIhaWC8b2DV5C7Y@kroah.com>
 <20211209193857.GA28088@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209193857.GA28088@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 08:38:57PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > +	memzero_explicit(kaddr, dice_rmem->size);
> > > +	devm_memunmap(dice_misc.this_device, kaddr);
> > 
> > Do you really need to call memzero_explicit()?  This isn't "local"
> > memory, if the compiler "optimizes away" a normal call, it would be
> > _VERY_ broken.
> 
> For clearing secrets, I believe memzero_explicit is nice
> documentation.

Only if it's really needed please.
