Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A9C5756D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbiGNVYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGNVX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1778326AC2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657833836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aX0UCpzxHCp9LLdQUb/GLcuIR0vbBL4YD9MyslaxhRM=;
        b=DMv786IrE8akVExpx2k9wWQnbLEcnUEvaTokglEZTZrB8LyqbDJ0Rohiw6Fn3GG52g4fuv
        Yy6aWIXFItnjZk7KOED4r2lbhoBHvPlP1yFff/bVZsNgFHac5HMGo1Yxb9dsUYGS7KMEqC
        8qBQObyI9Bp3Ago8NBcJyhWgGdqJknI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-smZVnk9tOu2DM03VdiZmfw-1; Thu, 14 Jul 2022 17:23:51 -0400
X-MC-Unique: smZVnk9tOu2DM03VdiZmfw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D4C63806653;
        Thu, 14 Jul 2022 21:23:51 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA993C28100;
        Thu, 14 Jul 2022 21:23:50 +0000 (UTC)
Date:   Thu, 14 Jul 2022 17:23:49 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Barry Song <21cnbao@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v4 RESEND] drivers/base: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <YtCJZT08lHrsLul7@lorien.usersys.redhat.com>
References: <20220714183021.2924119-1-pauld@redhat.com>
 <YtBkA3QvP8JDGbhX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtBkA3QvP8JDGbhX@kroah.com>
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

Hi Greg,

On Thu, Jul 14, 2022 at 08:44:19PM +0200 Greg Kroah-Hartman wrote:
> On Thu, Jul 14, 2022 at 02:30:21PM -0400, Phil Auld wrote:
> > Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> > This breaks userspace code that retrieves the size before reading the file. Rather
> > than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> > limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> > comparison and a worst-case maximum to ensure compile time constants. For cpulist the
> > max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960
> > (8192 * 5). In order to get near that you'd need a system with every other CPU on one
> > node or something similar. e.g. (0,2,4,8, ... ). To simplify the math and support
> > larger NR_CPUS in the future we are using NR_CPUS * 7. We also set it to a min of
> > PAGE_SIZE to retain the older behavior for smaller NR_CPUS. The cpumap file wants to
> > be something like NR_CPUS/4 + NR_CPUS/32, for the ","s so for simplicity we are using
> > NR_CPUS/2.
> > 
> > Add a set of macros for these values to cpumask.h so they can be used in multiple places.
> > Apply these to the handful of such files in drivers/base/topology.c as well as node.c.
> 
> Git should have asked you to round at 72 columns, right?
>

My git doesn't do that. Maybe I'm missing a useful config.

> And that's one huge wall of text for the first paragraph, can you make
> that more readable?

Fixed.

> 
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
> > -r--r--r--. 1 root root 57344 Jul 13 11:32 /sys/devices/system/node/node0/cpulist
> > -r--r--r--. 1 root root  4096 Jul 13 11:31 /sys/devices/system/node/node0/cpumap
> > 
> > CONFIG_NR_CPUS = 16384
> > -r--r--r--. 1 root root 114688 Jul 13 14:03 /sys/devices/system/node/node0/cpulist
> > -r--r--r--. 1 root root   8192 Jul 13 14:02 /sys/devices/system/node/node0/cpumap
> > 
> > Fixes: 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size limitation of cpumap ABI")
> > Fixes: bb9ec13d156 ("topology: use bin_attribute to break the size limitation of cpumap ABI")
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> 
> You want to cc: stable too, right?
>

Will do.


> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -1071,4 +1071,20 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
> >  	[0] =  1UL							\
> >  } }
> >  
> > +/* 
> > + * Provide a valid theoretical max size for cpumap ands cpulist sysfs files to 
> > + * avoid breaking userspace which may allocate a buffer based on the size 
> > + * reported by e.g. fstat.
> > + *
> > + * For cpumap NR_CPUS/2 is a simplification of NR_CPUS/4 + NR_CPUS/32. 
> > + *
> > + * For cpulist 7 is (ceil(log10(NR_CPUS)) + 1) allowing for NR_CPUS to be up to 
> > + * 2 orders of magnitude larger than 8192. This covers a worst-case of every 
> > + * other cpu being on one of two nodes for a very large NR_CPUS.
> > + *
> > + *  Use PAGE_SIZE as a minimum for smaller configurations. 
> > + */
> 
> Please run checkpatch on your patches before sending them out and
> getting grumpy emails from maintainers asking you to run checkpatch on
> your patches...
>

Aargh, yes, sorry. I used to use the RH internal version all the time but the workflow
has changed and it's not needed anymore. Totally forget about the uptream version.
You'd think this was my first upstream patch...

I'll fix up the numbers and clean it up for the next version.


Cheers,
Phil


> greg k-h
> 

-- 

