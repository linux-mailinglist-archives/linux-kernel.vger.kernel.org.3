Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A1573714
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiGMNPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbiGMNO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D95BE12629
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657718097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Awwz27tJpceArcxUQo9spBIymSTuEIsUyVVbtXUALs=;
        b=ez7HS2BFE3vTkAi6OseJvhZt1Ikpm5v/D/80ck7sU1x53pThrWDuAxxSaly8fWvJ+EWMIH
        rvjtzB0UPAlcdI+si2zqjNq6ulb7UaAxrUZvZvZEWYHM/JG0HKHdxjVgC/PRqGwEqCEoZ7
        KB5qF9NjzFBOhsiKo/vfVvHwor9amho=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-ohhid9sgPHKcx4Tpzm6sHg-1; Wed, 13 Jul 2022 09:14:50 -0400
X-MC-Unique: ohhid9sgPHKcx4Tpzm6sHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEAFF3C11052;
        Wed, 13 Jul 2022 13:14:49 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95D21C28100;
        Wed, 13 Jul 2022 13:14:49 +0000 (UTC)
Date:   Wed, 13 Jul 2022 09:14:48 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <Ys7FSCAYOQH+YLbS@lorien.usersys.redhat.com>
References: <20220712214301.809967-1-pauld@redhat.com>
 <Ys5gyqMqB/TW6ftv@kroah.com>
 <Ys6w7pqQdlaHoiIG@lorien.usersys.redhat.com>
 <Ys7DMC66cUWUcvtu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys7DMC66cUWUcvtu@kroah.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 03:05:52PM +0200 Greg Kroah-Hartman wrote:
> On Wed, Jul 13, 2022 at 07:47:58AM -0400, Phil Auld wrote:
> > Hi Greg,
> > 
> > On Wed, Jul 13, 2022 at 08:06:02AM +0200 Greg Kroah-Hartman wrote:
> > > On Tue, Jul 12, 2022 at 05:43:01PM -0400, Phil Auld wrote:
> > > > Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> > > > This breaks userspace code that retrieves the size before reading the file. Rather
> > > > than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> > > > limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> > > > comparison and a worst-case maximum to ensure compile time constants. For cpulist the 
> > > > max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960. 
> > > > In order to get near that you'd need a system with every other CPU on one node or 
> > > > something similar. e.g. (0,2,4,... 1024,1026...). We set it to a min of PAGE_SIZE 
> > > > to retain the older behavior. For cpumap, PAGE_SIZE is plenty big.
> > > 
> > > Does userspace care about that size, or can we just put any value in
> > > there and it will be ok?  How about just returning to the original
> > > PAGE_SIZE value to keep things looking identical, will userspace not
> > > read more than that size from the file then?
> > >
> > 
> > I'll go look. But I think the point of pre-reading the size with fstat is to allocate
> > a buffer to read into. So that may be a problem. 
> > 
> > That said, I believe in this case it's the cpulist file which given the use of ranges
> > is very unlikely to actually get that big. 
> 
> That is why we had to change this to a binary file.  Think about
> every-other CPU being there, that's a huge list.  This already was
> broken on some systems which is why it had to be changed (i.e. we didn't
> change it for no reason at all.)
>

I didn't think you did and the change made sense. I did not expect this to
cause problems either when I backported it... :)

> > > > On an 80 cpu 4-node sytem (NR_CPUS == 8192)
> > > 
> > > We have systems running Linux with many more cpus than that, and your
> > > company knows this :)
> > 
> > The 80 cpus here don't matter and we only build with NR_CPUS = 8192 :)
> > 
> > But yes, I realize now that the cpumap part I posted is broken for larger
> > NR_CPUS.  I originally had it as NR_CPUS, but as I said in my reply to Barry,
> > it wants to be ~= NR_CPUS/4 + NR_CPUS/32. I'll change that.  
> > 
> > I think we should decide on a max for each and use that. 
> 
> Sure, pick a max size please, that's fine with me.

Right. I had another reply that crossed in the ether.

I can repost with the new version shortly.

It's using cpumap at NR_CPUS/2 and cpulist at NR_CPUS*6. 


Cheers,
Phil

> 
> greg k-h
> 

-- 

