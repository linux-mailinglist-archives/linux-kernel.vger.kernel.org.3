Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB2573928
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiGMOs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiGMOsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F05A33A04
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657723703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PTlOYax8SWdwKuBY/itdH3EnXrgEI1qbVsXFNBDxiUk=;
        b=X+FA+4A0rUd54a0b7qDh9QOtHx/LuhoAS3CzdZSr57xZoQLd78leg6PfTqmT1k16KsUCER
        Z92SUkOlfiVYTBWo3NULpTFK4C8ncwLQhH+WDnAI7nL92/X6TBOjtpBSVToGLiD7nwQuhl
        2KM1Ai1vrYtKeypYyqq8J5h1glwO0qU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-JiAThkNvM_CvnyYck92Qew-1; Wed, 13 Jul 2022 10:48:17 -0400
X-MC-Unique: JiAThkNvM_CvnyYck92Qew-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 228B53C10143;
        Wed, 13 Jul 2022 14:48:17 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BD20401473;
        Wed, 13 Jul 2022 14:48:16 +0000 (UTC)
Date:   Wed, 13 Jul 2022 10:48:15 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Barry Song <21cnbao@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH v2] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <Ys7bL/OG6EJrZDdU@lorien.usersys.redhat.com>
References: <20220713134545.1382367-1-pauld@redhat.com>
 <Ys7Pkxqzrz75gCiN@kroah.com>
 <Ys7TCFoGIk3hlCpB@lorien.usersys.redhat.com>
 <Ys7V2oW82qW75x6X@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys7V2oW82qW75x6X@kroah.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 04:25:30PM +0200 Greg Kroah-Hartman wrote:
> On Wed, Jul 13, 2022 at 10:13:28AM -0400, Phil Auld wrote:
> > On Wed, Jul 13, 2022 at 03:58:43PM +0200 Greg Kroah-Hartman wrote:
> > > On Wed, Jul 13, 2022 at 09:45:45AM -0400, Phil Auld wrote:
> > > > Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> > > > This breaks userspace code that retrieves the size before reading the file. Rather
> > > > than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> > > > limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> > > > comparison and a worst-case maximum to ensure compile time constants. For cpulist the
> > > > max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960
> > > > (8192 * 5). In order to get near that you'd need a system with every other CPU on one
> > > > node or something similar. e.g. (0,2,4,... 1024,1026...). To simplify the math and
> > > > support larger NR_CPUS we are using NR_CPUS * 6. We also set it to a min of PAGE_SIZE
> > > > to retain the older behavior for smaller NR_CPUS. The cpumap file wants to be something
> > > > like NR_CPUS/4 + NR_CPUS/32, for the ","s so for simplicity we are using NR_CPUS/2.
> > > > 
> > > > On an 80 cpu 4-node sytem (NR_CPUS == 8192)
> > > > 
> > > > before:
> > > > 
> > > > -r--r--r--. 1 root root 0 Jul 12 14:08 /sys/devices/system/node/node0/cpulist
> > > > -r--r--r--. 1 root root 0 Jul 11 17:25 /sys/devices/system/node/node0/cpumap
> > > > 
> > > > after:
> > > > 
> > > > -r--r--r--. 1 root root 49152 Jul 13 09:26 /sys/devices/system/node/node0/cpulist
> > > > -r--r--r--. 1 root root  4096 Jul 13 09:24 /sys/devices/system/node/node0/cpumap
> > > > 
> > > > Fixes: 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size limitation of cpumap ABI")
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Signed-off-by: Phil Auld <pauld@redhat.com>
> > > > ---
> > > >  drivers/base/node.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > > index 0ac6376ef7a1..3577f4eb4ac6 100644
> > > > --- a/drivers/base/node.c
> > > > +++ b/drivers/base/node.c
> > > > @@ -45,7 +45,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
> > > >  	return n;
> > > >  }
> > > >  
> > > > -static BIN_ATTR_RO(cpumap, 0);
> > > > +static BIN_ATTR_RO(cpumap, (((NR_CPUS>>1) > PAGE_SIZE) ? NR_CPUS >> 1 : PAGE_SIZE));
> > > 
> > > Why not just PAGE_SIZE?
> > >
> > 
> > This one is likely to grow beyond page size if NR_CPUS is larger than 8192. It's about 2300 bytes
> > at 8192 if my math is right.
> > 
> > Let me ask again before I write the comments... what values of NR_CPUS are you seeing? Are people
> > using an order of magnitude above 8192? Two orders?  This patch (with the 6 below) handles about 1
> > order more.
> 
> One order for now that we know of, probably larger that we don't :)

Fair enough. I'll go with 7 then. Thanks!

> 
> > > >  static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> > > >  				   struct bin_attribute *attr, char *buf,
> > > > @@ -66,7 +66,7 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> > > >  	return n;
> > > >  }
> > > >  
> > > > -static BIN_ATTR_RO(cpulist, 0);
> > > > +static BIN_ATTR_RO(cpulist, (((NR_CPUS * 6) > PAGE_SIZE) ? NR_CPUS *6 : PAGE_SIZE));
> > > 
> > > "* 6" in both places here?
> > >
> > 
> > It's compile time so it's cheap. But yes, 6 in both places.  That's to support NR_CPUS=100000.
> 
> Sorry, I was trying to point out to use a " " before the "6" in both
> places.  Not questioning the math.
>

Right! Sorry, misunderstood, obviously :)

Cheers,
Phil

> thanks,
> 
> greg k-h
> 

-- 

