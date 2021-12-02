Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4B466B5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349094AbhLBVJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhLBVJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:09:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D4BC06174A;
        Thu,  2 Dec 2021 13:05:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 131A062823;
        Thu,  2 Dec 2021 21:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C48C00446;
        Thu,  2 Dec 2021 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638479141;
        bh=jsmwirm9+n4y1de5SlVlUsgGkQ+0+JkYKJK4UcdA6yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PC+uosLGtHEq010bYO0YoOq6FmJxT8jEUyFo0eCtLTjsh0OU+ObBFTs4jIVWJMWGS
         hBkH1zIfMWwOIwwG7NDyx0dF98fJj2EU8rxGCTS/T5CyZufDykMchquS+kxxEJ60cv
         /3PrySqzHKwg52IbqybreF8PfYreylby6gXQIp057aKsiieJgyIsUggSmtYqHLlER0
         tkjAdDVOiwCyCfnM0WKZZ3JWitjt2vJnejeRap/0Y5VeC064zNTefpEjhmsNOGe1rq
         dflPdXGf78XZ3AUr62BRwG64F0kiZZ25PRHyOx3GUP3Hy3al9sR2BUFrA6F9wYTO6y
         iU62IXrnxZLcQ==
Date:   Thu, 2 Dec 2021 13:05:39 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] docs: consolidate sysfs-block into Documentation/ABI/
Message-ID: <Yak1I/xolvLIOtkf@sol.localdomain>
References: <20211201084524.25660-1-ebiggers@kernel.org>
 <0bf11301-4085-f4a1-eeed-c65d0e5563b4@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf11301-4085-f4a1-eeed-c65d0e5563b4@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 11:32:45AM -0800, Bart Van Assche wrote:
> On 12/1/21 12:45 AM, Eric Biggers wrote:
> > This series consolidates the documentation for /sys/block/<disk>/queue/
> > into Documentation/ABI/, where it is supposed to go (as per Greg KH:
> > https://lore.kernel.org/r/YaXXpEAwVGTLjp1e@kroah.com).
> > 
> > This series also updates MAINTAINERS to associate the block
> > documentation with the block layer.
> > 
> > This series applies to linux-block/for-next.
> > 
> > Eric Biggers (7):
> >    docs: sysfs-block: sort alphabetically
> >    docs: sysfs-block: add contact for nomerges
> >    docs: sysfs-block: fill in missing documentation from queue-sysfs.rst
> >    docs: sysfs-block: document stable_writes
> >    docs: sysfs-block: document virt_boundary_mask
> >    docs: block: remove queue-sysfs.rst
> >    MAINTAINERS: add entries for block layer documentation
> > 
> >   Documentation/ABI/testing/sysfs-block | 766 ++++++++++++++++++--------
> >   Documentation/block/index.rst         |   1 -
> >   Documentation/block/queue-sysfs.rst   | 321 -----------
> >   MAINTAINERS                           |   2 +
> >   4 files changed, 545 insertions(+), 545 deletions(-)
> >   delete mode 100644 Documentation/block/queue-sysfs.rst
> 
> How about adding a patch that moves Documentation/ABI/testing/sysfs-block
> to Documentation/ABI/stable/sysfs-block? The block layer sysfs ABI is used
> widely by user space software and is considered stable.
> 

That would make sense.  I decided not to include it in this patch series since
some of the sysfs-block files were added recently, so may not be as "stable" as
ones that have been around for 18 years, and because about 90% of the sysfs
documentation is in the "testing" directory anyway so it is not unusual.  So I
felt it should be a separate change.

I think these patches should go in first, and then I can send a separate patch
that moves the file to the stable directory, if there is no objection to it.

- Eric
