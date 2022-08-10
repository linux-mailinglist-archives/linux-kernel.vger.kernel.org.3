Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EC58E969
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiHJJQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiHJJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D73FA642E0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660122998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xTa10TwIZEmHS7/5XLZDQ5ZkmHqEHAF0pe3wgGd2/h0=;
        b=WsjJDLJsvdQITgKDHK4Mt9SLSL1UKAN2nv/nARYNjckuQD5hR8V3GuiZwrpG02JzV9Glha
        zLee6NWL1dJsUAit9qmWrFaFvoWAvsybhR4DNV8dKNNNwn+lpT8hTvRgGZWPExL+FY/2b0
        wJRDCfFQpLthcNGrqxp4AIdYRxhHxHE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-oYYHZvMPO-uFDORC06ek-w-1; Wed, 10 Aug 2022 05:16:36 -0400
X-MC-Unique: oYYHZvMPO-uFDORC06ek-w-1
Received: by mail-ed1-f71.google.com with SMTP id x20-20020a05640226d400b0043d50aadf3fso8970768edd.23
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 02:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xTa10TwIZEmHS7/5XLZDQ5ZkmHqEHAF0pe3wgGd2/h0=;
        b=Y/ZOqvIh6/HJHxSzrxqTCe9l8fAqU52Pxw0Xiy+mj10m2PtFK13DyDcjytfrk30ys/
         4eC8Py2UJBQ/z8Ys9TwZsDz1Na+Ro19on7FbP9ORjw4eHqT1PL6/4SfoyWDm/Xn1a/Fi
         hPR9jyfyx+LDaHPuFEDA0CiXKsjYsRw0jkpXe4q3gLt/g0jCTCCrw4JMPvewv7HlH0EI
         ExOgvvZjJvNhQb0u6qaFTlUP74TH0gdhjxF7EAnzZEM0d+tEvGpyKGXpONMLQT8CjWiV
         hxo1UgVRIwTZq+BrK5pJcGrb8hx9Kvij28JUARtIJqiyUrwE318tSD8Jjg0Xn49OFbyV
         QmrA==
X-Gm-Message-State: ACgBeo0eKhc35/gz+oGrTdccjVFnUd1gMv6wpAJgsgrzsKqVx0k1MrE4
        kD/Gb/K4oEY9rmkce3pbdZWSCGuHcIzUnahU/+qoT6JrFUPE/YPT6O0T/HtSMLNgnPxG+KXngro
        qdcwsOZwI/nnQMhc6DtEBb/Jv
X-Received: by 2002:a05:6402:42d3:b0:435:2c49:313d with SMTP id i19-20020a05640242d300b004352c49313dmr25266923edc.86.1660122995599;
        Wed, 10 Aug 2022 02:16:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5vQGMHSsCkDGtHBBUi7fKCKaqUt5o7vKoLsIjDaQYR/uv62iz+u3eUqMgIzFpOCvMUj3ryeA==
X-Received: by 2002:a05:6402:42d3:b0:435:2c49:313d with SMTP id i19-20020a05640242d300b004352c49313dmr25266900edc.86.1660122995397;
        Wed, 10 Aug 2022 02:16:35 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id by5-20020a0564021b0500b0044235219c07sm1600048edb.73.2022.08.10.02.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 02:16:34 -0700 (PDT)
Date:   Wed, 10 Aug 2022 05:16:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        David Hildenbrand <david@redhat.com>,
        Wei Liu <wei.liu@kernel.org>, Nadav Amit <namit@vmware.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/2] Enable balloon drivers to report inflated memory
Message-ID: <20220810051331-mutt-send-email-mst@kernel.org>
References: <7bfac48d-2e50-641b-6523-662ea4df0240@virtuozzo.com>
 <20220809094933.2203087-1-alexander.atanasov@virtuozzo.com>
 <20220809063111-mutt-send-email-mst@kernel.org>
 <d8fd3251-898d-89fe-226e-e166606c6983@virtuozzo.com>
 <20220810020330-mutt-send-email-mst@kernel.org>
 <b43de131-24dc-192c-f5f6-09bacee52a00@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43de131-24dc-192c-f5f6-09bacee52a00@virtuozzo.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 10:50:10AM +0300, Alexander Atanasov wrote:
> Hello,
> 
> On 10.08.22 9:05, Michael S. Tsirkin wrote:
> > On Wed, Aug 10, 2022 at 08:54:52AM +0300, Alexander Atanasov wrote:
> > > On 9.08.22 13:32, Michael S. Tsirkin wrote:
> > > > On Tue, Aug 09, 2022 at 12:49:32PM +0300, Alexander Atanasov wrote:
> > > > > @@ -153,6 +156,14 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > > > >    		    global_zone_page_state(NR_FREE_CMA_PAGES));
> > > > >    #endif
> > > > > +#ifdef CONFIG_MEMORY_BALLOON
> > > > > +	inflated_kb = atomic_long_read(&mem_balloon_inflated_kb);
> > > > > +	if (inflated_kb >= 0)
> > > > > +		seq_printf(m,  "Inflated(total): %8ld kB\n", inflated_kb);
> > > > > +	else
> > > > > +		seq_printf(m,  "Inflated(free): %8ld kB\n", -inflated_kb);
> > > > > +#endif
> > > > > +
> > > > >    	hugetlb_report_meminfo(m);
> > > > >    	arch_report_meminfo(m);
> > > > 
> > > > 
> > > > This seems too baroque for my taste.
> > > > Why not just have two counters for the two pruposes?
> > > 
> > > I agree it is not good but it reflects the current situation.
> > > Dirvers account in only one way - either used or total - which i don't like.
> > > So to save space and to avoid the possibility that some driver starts to use
> > > both at the same time. I suggest to be only one value.
> > 
> > I don't see what would be wrong if some driver used both
> > at some point.
> 
> If you don't see what's wrong with using both, i might as well add
> Cached and Buffers - next hypervisor might want to use them or any other by
> its discretion leaving the fun to figure it out to the userspace?

Assuming you document what these mean, sure.

> Single definitive value is much better and clear from user prespective and
> meminfo is exactly for the users.

Not really, the negative value trick is anything but clear.

> If a driver for some wierd reason needs to do both it is a whole new topic
> that i don't like to go into. Good news is that currently no such driver
> exists.
>
>
> > 
> > > 
> > > > And is there any value in having this atomic?
> > > > We want a consistent value but just READ_ONCE seems sufficient ...
> > > 
> > > I do not see this as only a value that is going to be displayed.
> > > I tried to be defensive here and to avoid premature optimization.
> > > One possible scenario is OOM killer(using the value) vs balloon deflate on
> > > oom will need it. But any other user of that value will likely need it
> > > atomic too. Drivers use spin_locks for calculations they might find a way to
> > > reduce the spin lock usage and use the atomic.
> > > While making it a long could only bring bugs without benefits.
> > > It is not on a fast path too so i prefer to be safe.
> > 
> > Well we do not normally spread atomics around just because we
> > can, it does not magically make the code safe.
> > If this needs atomics we need to document why.
> 
> Of course it does not. In one of your comments to my other patches you said
> you do not like patches that add one line then remove it in the next patch.
> To avoid that i put an atomic - if at one point it is clear it is not
> required i would be happy to change it but it is more likely to be need than
> not. So i will probably have to document it instead.
> 
> At this point the decision if it should be or should not be in the meminfo
> is more important - if general opinion is positive i will address the
> technical details.

Not up to me, you need ack from linux-mm guys for that.

> -- 
> Regards,
> Alexander Atanasov

