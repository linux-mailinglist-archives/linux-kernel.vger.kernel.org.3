Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA69470513
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbhLJQFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:05:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33230 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhLJQFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:05:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C933B827BE;
        Fri, 10 Dec 2021 16:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B51CC00446;
        Fri, 10 Dec 2021 16:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639152101;
        bh=mSGFDf1CkIFsGekXfmMO0AqQmx5MaFE6V3Bsm58SZG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWXzI+IucunN+dQi05Qnbj5uNQFd3uU/DUc4a/2YoHqqrOl/slpnyrJgKBsLQQ7nr
         yci3st/7U4uyfkBo8+dtD/hd62iaeORwXk8G6dosrfHJai7pY4PGCbxKF0d4a8w5jU
         FdZhdQa+N9w08pC44ijbOWmNG8S5rYyp6yXDwaDc=
Date:   Fri, 10 Dec 2021 17:01:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 2/2] misc: dice: Add driver to forward secrets to
 userspace
Message-ID: <YbN54u4fEKx54Gvc@kroah.com>
References: <20211209151123.3759999-1-dbrazdil@google.com>
 <20211209151123.3759999-3-dbrazdil@google.com>
 <YbIhaWC8b2DV5C7Y@kroah.com>
 <YbM29thQ7U4oUmhi@google.com>
 <YbNmsFAYDVUYopFO@kroah.com>
 <YbN2tbYZyLBdyEfS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbN2tbYZyLBdyEfS@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:48:05PM +0000, David Brazdil wrote:
> In your first email you also mentioned removing the check in dice_probe()
> that only allows a single instance. On a second thought, I think it's
> simpler to keep it there for now, even if the memory is dynamically
> allocated, which I agree makes the code cleaner.

I don't remember what check you are talking about at all, sorry.

Remember some of us review hundreds of patches each week :(

> The reason being that if we allowed multiple instances, we'd also need
> some static unique identifier that ties the cdev filename to the DT entry,
> same as /dev/disk/by-uuid/. Just adding an index number to the misc
> device nodename based on DT probe order sounds very fragile, and
> anything more sophisticated sounds like too much trouble for something
> we don't have a clear use case for right now.

Just add a number to the device node name like every other device in the
system has.  Nothing new or special here, right?

thanks,

greg k-h
