Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2FB5736D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiGMNGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGMNGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:06:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6328F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70C62B81F01
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8710DC34114;
        Wed, 13 Jul 2022 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657717556;
        bh=EAXJgBwI2keLSIZeMjBVYhrmB+hmvho7oKlJJvuBDX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZOes/DyH4JRiebZpMxx53KG38Dafheux35ejHA0o9MHMZpakEvwj43twiQyl3abP
         UfeF4rbCTbQs2ydHXAQlZ9+437+WVwPYu8oRqJ78uyNKiT/Awonlt/OKmF8nAExojw
         dfoAblEzeIZ1gcslNHonoE2yKR5aR306u0rjxKDg=
Date:   Wed, 13 Jul 2022 15:05:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <Ys7DMC66cUWUcvtu@kroah.com>
References: <20220712214301.809967-1-pauld@redhat.com>
 <Ys5gyqMqB/TW6ftv@kroah.com>
 <Ys6w7pqQdlaHoiIG@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys6w7pqQdlaHoiIG@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 07:47:58AM -0400, Phil Auld wrote:
> Hi Greg,
> 
> On Wed, Jul 13, 2022 at 08:06:02AM +0200 Greg Kroah-Hartman wrote:
> > On Tue, Jul 12, 2022 at 05:43:01PM -0400, Phil Auld wrote:
> > > Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> > > This breaks userspace code that retrieves the size before reading the file. Rather
> > > than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> > > limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> > > comparison and a worst-case maximum to ensure compile time constants. For cpulist the 
> > > max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960. 
> > > In order to get near that you'd need a system with every other CPU on one node or 
> > > something similar. e.g. (0,2,4,... 1024,1026...). We set it to a min of PAGE_SIZE 
> > > to retain the older behavior. For cpumap, PAGE_SIZE is plenty big.
> > 
> > Does userspace care about that size, or can we just put any value in
> > there and it will be ok?  How about just returning to the original
> > PAGE_SIZE value to keep things looking identical, will userspace not
> > read more than that size from the file then?
> >
> 
> I'll go look. But I think the point of pre-reading the size with fstat is to allocate
> a buffer to read into. So that may be a problem. 
> 
> That said, I believe in this case it's the cpulist file which given the use of ranges
> is very unlikely to actually get that big. 

That is why we had to change this to a binary file.  Think about
every-other CPU being there, that's a huge list.  This already was
broken on some systems which is why it had to be changed (i.e. we didn't
change it for no reason at all.)

> > > On an 80 cpu 4-node sytem (NR_CPUS == 8192)
> > 
> > We have systems running Linux with many more cpus than that, and your
> > company knows this :)
> 
> The 80 cpus here don't matter and we only build with NR_CPUS = 8192 :)
> 
> But yes, I realize now that the cpumap part I posted is broken for larger
> NR_CPUS.  I originally had it as NR_CPUS, but as I said in my reply to Barry,
> it wants to be ~= NR_CPUS/4 + NR_CPUS/32. I'll change that.  
> 
> I think we should decide on a max for each and use that. 

Sure, pick a max size please, that's fine with me.

greg k-h
