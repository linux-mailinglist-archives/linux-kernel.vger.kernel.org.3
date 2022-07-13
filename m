Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC1573886
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbiGMONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGMONh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CDAA2AC3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657721615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=16fe0zG+Df80Kw/yiUxFcqE0wkKzreKjMLbVHAylSVs=;
        b=XEIAvEbqe2WmnngYIdejpMstSw2gdIPnN6YBImU/w/+n2aIFILogFSLBSSTcBsHx/Zl7wO
        Vyw58IonxRGrkbW4ZrbX7p9cTC1BxcyOtEHNHjCRed/hQerUiZaMv40GrMbCDvL+ZO/kxy
        kHlXze8WNY6mbt/W/847gO81YN2HF8E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-2JqrfoevOESecsRjA0hvJQ-1; Wed, 13 Jul 2022 10:13:31 -0400
X-MC-Unique: 2JqrfoevOESecsRjA0hvJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF853811E76;
        Wed, 13 Jul 2022 14:13:30 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 146842026D64;
        Wed, 13 Jul 2022 14:13:30 +0000 (UTC)
Date:   Wed, 13 Jul 2022 10:13:28 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Barry Song <21cnbao@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH v2] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <Ys7TCFoGIk3hlCpB@lorien.usersys.redhat.com>
References: <20220713134545.1382367-1-pauld@redhat.com>
 <Ys7Pkxqzrz75gCiN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys7Pkxqzrz75gCiN@kroah.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 03:58:43PM +0200 Greg Kroah-Hartman wrote:
> On Wed, Jul 13, 2022 at 09:45:45AM -0400, Phil Auld wrote:
> > Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> > This breaks userspace code that retrieves the size before reading the file. Rather
> > than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> > limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> > comparison and a worst-case maximum to ensure compile time constants. For cpulist the
> > max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960
> > (8192 * 5). In order to get near that you'd need a system with every other CPU on one
> > node or something similar. e.g. (0,2,4,... 1024,1026...). To simplify the math and
> > support larger NR_CPUS we are using NR_CPUS * 6. We also set it to a min of PAGE_SIZE
> > to retain the older behavior for smaller NR_CPUS. The cpumap file wants to be something
> > like NR_CPUS/4 + NR_CPUS/32, for the ","s so for simplicity we are using NR_CPUS/2.
> > 
> > On an 80 cpu 4-node sytem (NR_CPUS == 8192)
> > 
> > before:
> > 
> > -r--r--r--. 1 root root 0 Jul 12 14:08 /sys/devices/system/node/node0/cpulist
> > -r--r--r--. 1 root root 0 Jul 11 17:25 /sys/devices/system/node/node0/cpumap
> > 
> > after:
> > 
> > -r--r--r--. 1 root root 49152 Jul 13 09:26 /sys/devices/system/node/node0/cpulist
> > -r--r--r--. 1 root root  4096 Jul 13 09:24 /sys/devices/system/node/node0/cpumap
> > 
> > Fixes: 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size limitation of cpumap ABI")
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > ---
> >  drivers/base/node.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index 0ac6376ef7a1..3577f4eb4ac6 100644
> > --- a/drivers/base/node.c
> > +++ b/drivers/base/node.c
> > @@ -45,7 +45,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
> >  	return n;
> >  }
> >  
> > -static BIN_ATTR_RO(cpumap, 0);
> > +static BIN_ATTR_RO(cpumap, (((NR_CPUS>>1) > PAGE_SIZE) ? NR_CPUS >> 1 : PAGE_SIZE));
> 
> Why not just PAGE_SIZE?
>

This one is likely to grow beyond page size if NR_CPUS is larger than 8192. It's about 2300 bytes
at 8192 if my math is right.

Let me ask again before I write the comments... what values of NR_CPUS are you seeing? Are people
using an order of magnitude above 8192? Two orders?  This patch (with the 6 below) handles about 1
order more.

> If not, a HUGE comment explaining what you are doing here is going to be
> required.

Sure, will do. See above :)

> 
> >  
> >  static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> >  				   struct bin_attribute *attr, char *buf,
> > @@ -66,7 +66,7 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> >  	return n;
> >  }
> >  
> > -static BIN_ATTR_RO(cpulist, 0);
> > +static BIN_ATTR_RO(cpulist, (((NR_CPUS * 6) > PAGE_SIZE) ? NR_CPUS *6 : PAGE_SIZE));
> 
> "* 6" in both places here?
>

It's compile time so it's cheap. But yes, 6 in both places.  That's to support NR_CPUS=100000.

> And again, we need a huge comment explaining this so that we can
> understand it in a few weeks, and in 10 years...

Will do.


Thanks,
Phil

> 
> thanks,
> 
> greg k-h
> 

-- 

