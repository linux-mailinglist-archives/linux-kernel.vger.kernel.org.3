Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851BC574E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbiGNM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbiGNM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 877F75A446
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657803569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MeWRLQ8CiNEbcWHlXbLWbOEmb2EbjgYQonQVo4vSyBQ=;
        b=AXdILsXaHESXeYHM2L2ATtAr3G0ilQRzenjMkbfQ5GvlO2qB3CVHo9qMmPwKjWrRaAPeoq
        iCl27371UNSBjHdoq22kVo6ReqVhz9YpGWtAEG2ZjpBNqg41uXwUWjta11RJuS6ZvTw499
        YvKMFgHbnAsXEDmbGICIG+TOsTf/VCs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-RGBPgKdeO_Kz-yF0UATWCw-1; Thu, 14 Jul 2022 08:59:26 -0400
X-MC-Unique: RGBPgKdeO_Kz-yF0UATWCw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F14FF8032EE;
        Thu, 14 Jul 2022 12:59:25 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.33.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E6D8492C3B;
        Thu, 14 Jul 2022 12:59:25 +0000 (UTC)
Date:   Thu, 14 Jul 2022 08:59:24 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH v3] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <YtATLNvojuvOOmys@lorien.usersys.redhat.com>
References: <20220713183855.2188201-1-pauld@redhat.com>
 <CAGsJ_4yb5Z3msMgXRZpSXLFiysQdJq-n_p9B6d-p2t_-_UHhVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yb5Z3msMgXRZpSXLFiysQdJq-n_p9B6d-p2t_-_UHhVQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 12:23:01PM +1200 Barry Song wrote:
> On Thu, Jul 14, 2022 at 6:38 AM Phil Auld <pauld@redhat.com> wrote:
> >
> > Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> > This breaks userspace code that retrieves the size before reading the file. Rather
> > than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> > limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> > comparison and a worst-case maximum to ensure compile time constants. For cpulist the
> > max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960
> > (8192 * 5). In order to get near that you'd need a system with every other CPU on one
> > node or something similar. e.g. (0,2,4,... 1024,1026...). To simplify the math and
> > support larger NR_CPUS we are using NR_CPUS * 7 to support a future with much larger NR_CPUS.
> > We also set it to a min of PAGE_SIZE to retain the older behavior for smaller NR_CPUS.
> > The cpumap file wants to be something like NR_CPUS/4 + NR_CPUS/32, for the ","s so for
> > simplicity we are using NR_CPUS/2.
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
> > NR_CPUS = 16384
> > -r--r--r--. 1 root root 114688 Jul 13 14:03 /sys/devices/system/node/node0/cpulist
> > -r--r--r--. 1 root root   8192 Jul 13 14:02 /sys/devices/system/node/node0/cpumap
> >
> > Fixes: 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size limitation of cpumap ABI")
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > ---
> >  drivers/base/node.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > index 0ac6376ef7a1..89c932a1d8ca 100644
> > --- a/drivers/base/node.c
> > +++ b/drivers/base/node.c
> > @@ -45,7 +45,11 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
> >         return n;
> >  }
> >
> > -static BIN_ATTR_RO(cpumap, 0);
> > +/* Report a valid max size for this file to avoid breaking userspace. We use NR_CPUS/2 as
> > + * a simplification of NR_CPUS/8 + NR_CPUS/32.  Use PAGE_SIZE as a minimum for smaller
> > + * configurations.
> > + */
> > +static BIN_ATTR_RO(cpumap, (((NR_CPUS >> 1) > PAGE_SIZE) ? NR_CPUS >> 1 : PAGE_SIZE));
> 
> the code should be fine. but the comment seems to be wrong?
> 
> /$ cat /sys/devices/system/node/node0/cpumap
> 00000000,00000000,00000000,000000ff
> 
> 4 cpus need one byte in hex, 32 cpus need a comma.
> for 32cpus, we totally need 9 bytes.
> 
> Based on your comment, you get 32/8+32/32=5.
> should be NR_CPUS/4 ?
>

Yes, sorry. Meant /4 as in the commit message.  I'll fix that.


> >
> >  static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> >                                    struct bin_attribute *attr, char *buf,
> > @@ -66,7 +70,15 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> >         return n;
> >  }
> >
> > -static BIN_ATTR_RO(cpulist, 0);
> > +/* Report a valid maximum size for this file since 0 breaks userspace, which
> > + * may use the size from fstat to allocate a read buffer.
> > + * The value 7 is a hardcoded version of ceil(log10(NR_CPUS)) + 1 for future values
> > + * of NR_CPUS that may be upto 2 orders of magnitude larger than 8192.
> > + * In a worst case system every other cpu is on one of two nodes. This leads to
> > + * a file like "0,2,4,6,8...1024,...8190,...". Use PAGE_SIZE as a minimum for smaller
> > + * NR_CPUS.
> > +*/
> > +static BIN_ATTR_RO(cpulist, (((NR_CPUS * 7) > PAGE_SIZE) ? NR_CPUS * 7 : PAGE_SIZE));
> >
> 
> It seems to be very sufficient. At least, my poor math tells me 7
> bytes can describe cpu id like
> "100000," and up to "999999,"
> but it is still hard for me to understand the comments :-)
>

I picked 7 based on Greg saying there might be systems with 2 orders of magnitude more
than 8192 cpus. Personally I think lock contention and percpu data will start to be
a problem before that. I couldn't get x86 to build with more than NR_CPUS=16k. But it
allows for future expansion.

What would you like the comment to say that makes more sense to you? Should I put
some of those really large cpuids in the worst case example? Take that out completely?


> btw, we have a lot of other places which might need this, such as
> drivers/base/topology.c
> 
> so perhaps we can move them to some common place,
> 
> #define cpu_bitmap_bytes  (((NR_CPUS >> 1) > PAGE_SIZE) ? NR_CPUS >> 1
> : PAGE_SIZE)
> #define cpu_list_bytes  (((NR_CPUS * 7) > PAGE_SIZE) ? NR_CPUS * 7 : PAGE_SIZE)
> 
> is include/linux/cpumask.h a good place for it?

My concern is the ones that are breaking actual userspace code. But yes, those
otherwise have the same 0 size. 

It seems somewhat specific to drivers/base. Maybe there's a less global place to
put those closer. I can look and do it this way if that will help get it fixed.


Cheers,
Phil

> 
> >  /**
> >   * struct node_access_nodes - Access class device to hold user visible
> > --
> > 2.31.1
> >
> 
> Thanks
> Barry
> 

-- 

