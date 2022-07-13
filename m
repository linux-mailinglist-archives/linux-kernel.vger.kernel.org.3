Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9695735C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiGMLsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbiGMLsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 991DF1034C4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 04:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657712883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Mww04r+3ec6OV9BE9n56mJoBDx1peSx+B2QTleOL7s=;
        b=Fa13forx9hWeZtr9KxNrfqt+ACh87X9bFMF8CTmJ7D6Yo/8SrNRMGDShClYQt6g0bizvbG
        oKHxXQ4cOnfuHKL41WnJGF0/BvDtklazQJalxTtpAUwDUzPV9L0fOme0fFp0EtCRSdIrv+
        GmqAHeirrBxPZdc9ipuYVBqgcijj67s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-cxwzfLWZOEC8mISIsEiD4g-1; Wed, 13 Jul 2022 07:48:00 -0400
X-MC-Unique: cxwzfLWZOEC8mISIsEiD4g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C7798032F6;
        Wed, 13 Jul 2022 11:48:00 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.32.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D81D4492C3B;
        Wed, 13 Jul 2022 11:47:59 +0000 (UTC)
Date:   Wed, 13 Jul 2022 07:47:58 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <Ys6w7pqQdlaHoiIG@lorien.usersys.redhat.com>
References: <20220712214301.809967-1-pauld@redhat.com>
 <Ys5gyqMqB/TW6ftv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys5gyqMqB/TW6ftv@kroah.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Jul 13, 2022 at 08:06:02AM +0200 Greg Kroah-Hartman wrote:
> On Tue, Jul 12, 2022 at 05:43:01PM -0400, Phil Auld wrote:
> > Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> > This breaks userspace code that retrieves the size before reading the file. Rather
> > than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> > limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> > comparison and a worst-case maximum to ensure compile time constants. For cpulist the 
> > max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960. 
> > In order to get near that you'd need a system with every other CPU on one node or 
> > something similar. e.g. (0,2,4,... 1024,1026...). We set it to a min of PAGE_SIZE 
> > to retain the older behavior. For cpumap, PAGE_SIZE is plenty big.
> 
> Does userspace care about that size, or can we just put any value in
> there and it will be ok?  How about just returning to the original
> PAGE_SIZE value to keep things looking identical, will userspace not
> read more than that size from the file then?
>

I'll go look. But I think the point of pre-reading the size with fstat is to allocate
a buffer to read into. So that may be a problem. 

That said, I believe in this case it's the cpulist file which given the use of ranges
is very unlikely to actually get that big. 

> > On an 80 cpu 4-node sytem (NR_CPUS == 8192)
> 
> We have systems running Linux with many more cpus than that, and your
> company knows this :)

The 80 cpus here don't matter and we only build with NR_CPUS = 8192 :)

But yes, I realize now that the cpumap part I posted is broken for larger
NR_CPUS.  I originally had it as NR_CPUS, but as I said in my reply to Barry,
it wants to be ~= NR_CPUS/4 + NR_CPUS/32. I'll change that.  

I think we should decide on a max for each and use that. 

Cheers,
Phil

> 
> thanks,
> 
> greg k-h
> 

-- 

