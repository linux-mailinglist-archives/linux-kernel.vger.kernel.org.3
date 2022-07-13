Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F94F57363B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbiGMMUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGMMUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:20:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 852B2D444E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657714835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Enkh/4YAjGp9GLbWlxmLW0H7mH9uTroh847WCOp+OTw=;
        b=UAI7M1BcUOTIyq8U7jFdfSBkGzBUWn9zVSHCxDw1xfU5wli3AMEW8kb9XOgCa3tnCu4MkA
        8YXZbqtoxTR/tv5AZqITXzSfEvX/SJw5ARgy84doiM231b7qMz02AeoHZidATnj9Ug8+zQ
        SRKvm/Uc0dQRxpqeBR3omQ4T7t9OGjw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-_aQJeTEBPN-URzrX-SsqRQ-1; Wed, 13 Jul 2022 08:20:32 -0400
X-MC-Unique: _aQJeTEBPN-URzrX-SsqRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5247101A586;
        Wed, 13 Jul 2022 12:20:31 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 719541121314;
        Wed, 13 Jul 2022 12:20:31 +0000 (UTC)
Date:   Wed, 13 Jul 2022 08:20:30 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki : --cc=" <rafael@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <Ys64jlfb+0qWKg+d@lorien.usersys.redhat.com>
References: <20220712214301.809967-1-pauld@redhat.com>
 <CAGsJ_4xG0az1-g8DWL-mEv_cF3ZBMe6j87m_cxeL9abvxGNW=g@mail.gmail.com>
 <Ys6ud4JmMGjktAlL@lorien.usersys.redhat.com>
 <CAGsJ_4ypcobo73M9brBD8c_Jc1KLfeY6SSiP=0kFKvHUcUaM=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4ypcobo73M9brBD8c_Jc1KLfeY6SSiP=0kFKvHUcUaM=Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 12:00:34AM +1200 Barry Song wrote:
> Got it.
> 
> On Wed, Jul 13, 2022 at 11:37 PM Phil Auld <pauld@redhat.com> wrote:
> >
> > On Wed, Jul 13, 2022 at 11:18:59AM +1200 Barry Song wrote:
> > > On Wed, Jul 13, 2022 at 9:58 AM Phil Auld <pauld@redhat.com> wrote:
> > > >
> > > > Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> > > > This breaks userspace code that retrieves the size before reading the file. Rather
> > > > than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> > > > limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> > > > comparison and a worst-case maximum to ensure compile time constants. For cpulist the
> > > > max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960.
> > > > In order to get near that you'd need a system with every other CPU on one node or
> > > > something similar. e.g. (0,2,4,... 1024,1026...). We set it to a min of PAGE_SIZE
> > > > to retain the older behavior. For cpumap, PAGE_SIZE is plenty big.
> > > >
> > > > On an 80 cpu 4-node system (NR_CPUS == 8192)
> > > >
> > > > before:
> > > >
> > > > -r--r--r--. 1 root root 0 Jul 12 14:08 /sys/devices/system/node/node0/cpulist
> > > > -r--r--r--. 1 root root 0 Jul 11 17:25 /sys/devices/system/node/node0/cpumap
> > >
> > > it is a fundamental problem of bin_attr, isn't it? when we don't know the
> > > exact size of an attribute, and this size might become more than one
> > > PAGE_SIZE, we use bin_attr to break the limitation. but the fact is that
> > > we really don't know or it is really hard to know the actual size of the
> > > attribute.
> > >
> >
> > But it broke userspace applications. I figured rather than revert it maybe
> > we can find a max size to put in there and make it continue to work.
> >
> > > >
> > > > after:
> > > >
> > > > -r--r--r--. 1 root root 40960 Jul 12 16:48 /sys/devices/system/node/node0/cpulist
> > > > -r--r--r--. 1 root root  4096 Jul 12 15:50 /sys/devices/system/node/node0/cpumap
> > >
> > > if we finally set a size which might be improper, it seems we defeat the
> > > purpose we start to move to bin_attr?
> > >
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
> > > > index 0ac6376ef7a1..291c69671f23 100644
> > > > --- a/drivers/base/node.c
> > > > +++ b/drivers/base/node.c
> > > > @@ -45,7 +45,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
> > > >         return n;
> > > >  }
> > > >
> > > > -static BIN_ATTR_RO(cpumap, 0);
> > > > +static BIN_ATTR_RO(cpumap, PAGE_SIZE);
> > >
> > > PAGE_SIZE is probably big enough, will we still calculate to get it rather than
> > > hard coding?
> >
> > This one is actually wrong. I did not realize how big a NR_CPUS people were actually using.
> > It should be something like (NR_CPUS/4 + NR_CPUS/32).
> >
> > >
> > > >
> > > >  static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> > > >                                    struct bin_attribute *attr, char *buf,
> > > > @@ -66,7 +66,7 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> > > >         return n;
> > > >  }
> > > >
> > > > -static BIN_ATTR_RO(cpulist, 0);
> > > > +static BIN_ATTR_RO(cpulist, (((NR_CPUS * 5) > PAGE_SIZE) ? NR_CPUS *5 : PAGE_SIZE));
> > >
> > > I am still not sure why it is NR_CPUS * 5. Is 5 bytes big enough to
> > > describe the number
> > > of cpu id? technically it seems not,  for example,  for cpuid=100000,
> > > we need at least 6
> > > bytes.
> >
> > Sure. As I said in the comment I wanted to do NR_CPUS * (ceil(log10(NR_CPUS)) + 1) but doing
> > that math in the kernel was messy. So I used 5. Even that is probably way bigger than needed.
> > Are there really 100000 cpus on one node with discontiguous cpuids? "0-99999" is only, what,
> > 9 characters?
> >
> > We can put whatever number you want that is >= the size the read will return.
> 
> Thanks,
> does it mean we can use something like -1UL?
>

I suppose we could be that seems like it would be overkill, no?  My understanding is the app
in question uses the reported size to allocate a buffer to read the file into. It needs to
be at least equal to the amount we'll actually read but 4GB seems like it might be a bit much.


Cheers,
Phil

> >
> > Thanks,
> > Phil
> >
> > >
> > > BTW, my silly question is that what if we set the size to MAXIMUM int?
> > > Will it fix
> > > the userspace fsstat?
> > >
> > > >
> > > >  /**
> > > >   * struct node_access_nodes - Access class device to hold user visible
> > > > --
> > > > 2.31.1
> > > >
> > >
> > > Thanks
> > > Barry
> > >
> >
> > --
> >
> 

-- 

