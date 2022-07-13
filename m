Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49635736EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiGMNKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiGMNKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DBE5D59
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657717808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NtlaKy/Pi7fFkMlw5/xShDsKILPGpTf38KvCH4G4WHI=;
        b=DvDozQ8o5yskTULH2U4SfAcpd0QEtJhPTSRtpS5VqLjXWY4hgD9ljlekwYP5IGrmTBQAM+
        x4BbSyCMv4i3zaP0SDm0vwfgwlEwdWMLWv7fg62iJ5HNqZMjOB4Xvhos6jtbxJWV+VBftO
        nn/KCifcKj6T/dqEcigSTNoyZRnWMP4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-65NjDsgYNpWr6p8by5j2Dg-1; Wed, 13 Jul 2022 09:10:04 -0400
X-MC-Unique: 65NjDsgYNpWr6p8by5j2Dg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5707E803301;
        Wed, 13 Jul 2022 13:10:04 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D7382026D64;
        Wed, 13 Jul 2022 13:10:03 +0000 (UTC)
Date:   Wed, 13 Jul 2022 09:10:02 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <Ys7EKngGeFP0eiXt@lorien.usersys.redhat.com>
References: <20220712214301.809967-1-pauld@redhat.com>
 <Ys5gyqMqB/TW6ftv@kroah.com>
 <Ys6w7pqQdlaHoiIG@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys6w7pqQdlaHoiIG@lorien.usersys.redhat.com>
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

On Wed, Jul 13, 2022 at 07:48:00AM -0400 Phil Auld wrote:
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

From what I understand the app does use the size from fstat to allocate a buffer.

It also does a lseek to the end and back. This is actaully where it breaks when it gets a 0.

This is before:
8747  10:20:32.584460 fstat(6</sys/devices/system/node/node0/cpulist>, {..., st_size=4096, ...}) = 0 <0.000006>
8747  10:20:32.584502 fstat(6</sys/devices/system/node/node0/cpulist>, {..., st_size=4096, ...}) = 0 <0.000005>
8747  10:20:32.584537 lseek(6</sys/devices/system/node/node0/cpulist>, 4096, SEEK_SET) = 4096 <0.000005>
8747  10:20:32.584560 lseek(6</sys/devices/system/node/node0/cpulist>, 0, SEEK_SET) = 0 <0.000005>
8747  10:20:32.584585 read(6</sys/devices/system/node/node0/cpulist>, "0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46\n", 4096) = 67 <0.000008>
8747  10:20:32.584617 read(6</sys/devices/system/node/node0/cpulist>, "", 4096) = 0 <0.000005>

(I'll note here their system does seem to have a worst case cpu to node list too)

And with the bin_attr change:
8871  09:27:41.034279 fstat(6</sys/devices/system/node/node0/cpulist>, {..., st_size=0, ...}) = 0 <0.000009>
8871  09:27:41.034330 fstat(6</sys/devices/system/node/node0/cpulist>, {..., st_size=0, ...}) = 0 <0.000010>
8871  09:27:41.034377 lseek(6</sys/devices/system/node/node0/cpulist>, 0, SEEK_SET) = 0 <0.000008>
8871  09:27:41.034410 lseek(6</sys/devices/system/node/node0/cpulist>, 0, SEEK_SET) = 0 <0.000008>
And here it spins in a loop. 


> That said, I believe in this case it's the cpulist file which given the use of ranges
> is very unlikely to actually get that big. 
> 
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
>

What values of NR_CPUS are people actually using when they build kernels? Barry mentioned cpuid 100000 for
example. I'm not sure if that was real or just illustrating the need for more characters.

I've modified my patch to use NR_CPUS/2 for the cpumap which should be plenty. And to use NR_CPUS*6 for
the cpulist, which covers up to 99999 cpus safely.


Cheers,
Phil


> Cheers,
> Phil
> 
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> -- 

-- 

