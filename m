Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEED4BC859
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 13:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbiBSMAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 07:00:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiBSMAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 07:00:05 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16F95DE5F
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 03:59:46 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d187so4530876pfa.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 03:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q3S/BU0h5z1TWDtM7/trwzzdXaxUs1NRowNdwGsTgok=;
        b=YuK+xUE3N2UL4vhozvRT2RTu3henp67FsQdQcK59s4ZCoRpw/EAhgehnyf0YsqzR4W
         BT1m3M2DQzlt8rP7rULMnrJZxz2ivFGTXOZ6gTQCisFOde+YRONXi5n7Jac+Oeqc9Hx0
         vfLnTOosOgoL5hMLh+LGaOHxWIcAnV6kwxLe7Q4U9kQ/z+hPNYOvi8YO8cp/SUpuQAk0
         L3odT2JVMpt6ZQd1ZspgGSjwUAjPHoDpXxFqQLy5JgCFRV+aicxqVORXKqOxEwIoq3IA
         /e9eD2Z4ZfX0bhzZE/koRo8quqzM52m7YDNHAtLMVBVU6uoPItrQPyXEaApF+Kz5DbEx
         MG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q3S/BU0h5z1TWDtM7/trwzzdXaxUs1NRowNdwGsTgok=;
        b=RQTG+96cloz5NSJPWFM0sRysHdAjQcctkID51HU0keCh+dEYCZksyyyOBTB+mEMIYg
         zvGIQZOrOTcYvOV788i7H8MyFZjOk5QcZAJTUuhsWO3EXEtcpQxXFiuZ/hPzwWPahgLq
         FlFI66OMocIIR5onq8AaIpFgIQpmCzd1KUXddShG/CimM3SHHejbg11PnjkeGbOB7qKx
         lMlkAH7KRTxGvLhql0L130I6hgwg7V4NqHqqDzD78gRlkVIuzfOicJWBErzbnYdntk6S
         m//Xp/AFhwNyYDueIhY2d+NcEs7wd694SlB3zT29L/vBhZ98Hjnv2eYjha04X0C9Soa7
         oweQ==
X-Gm-Message-State: AOAM531HY2mVlQ1AgXJetAYb36TvoCBforZTwwFmE+0zCa5pqRUjOzLC
        mDzTvzbxDyyg66lDCPN5vwE=
X-Google-Smtp-Source: ABdhPJydTEJwQNWaSddpo4lHXPhWP5QjSCtR4+XvQy6/uJEiNdd4sa1yXcoDRDgWMI3nVuAk+c4zJA==
X-Received: by 2002:a05:6a00:24ca:b0:4e1:cb76:32da with SMTP id d10-20020a056a0024ca00b004e1cb7632damr10876785pfv.81.1645271986371;
        Sat, 19 Feb 2022 03:59:46 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id k16sm13009844pgh.45.2022.02.19.03.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 03:59:45 -0800 (PST)
Date:   Sat, 19 Feb 2022 11:59:41 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@gentwo.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Do we really need SLOB nowdays?
Message-ID: <YhDbrTSdSWQWFF91@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
 <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YXqSoo+b9RTclW/2@casper.infradead.org>
 <20211210110835.GA632811@odroid>
 <alpine.DEB.2.22.394.2112101305500.290446@gentwo.de>
 <cbfaeb40-13c7-15b6-177d-07b3f3c4a0a9@suse.cz>
 <20211215062904.GA1150813@odroid>
 <54c6fff8-8c79-463b-a359-96e37bd13674@suse.cz>
 <Yg9xSWEaTZLA+hYt@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <7829ee15074448d5a7cec1a0e3c352d4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7829ee15074448d5a7cec1a0e3c352d4@AcuMS.aculab.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 04:10:28PM +0000, David Laight wrote:
> From: Hyeonggon Yoo
> > Sent: 18 February 2022 10:13
> ...
> > I think SLUB can be memory-efficient as SLOB.
> > Is SLOB (Address-Ordered next^Wfirst fit) stronger to fragmentation than SLUB?
> 
> Dunno, but I had to patch the vxworks malloc to use 'best fit'
> because 'first fit' based on a fifo free list was really horrid.
> 
> I can't imagine an address ordered 'first fit' really being that much better.
> 
> There are probably a lot more allocs and frees than the kernel used to have.
> 
> Also isn't the performance of a 'first fit' going to get horrid
> when there are a lot of small items on the free list.

SLOB is focused on low memory usage, at the cost of poor performance.
Its speed is not a concern.

I think Address-Ordered sequential fit method pretty well in terms of
low memory usage.

And I think SLUB may replace SLOB, but we need to sure SLUB is
absolute winner.. I wonder How slab maintainers think?

> 
> Does SLUB split pages into 3s and 5s (on cache lime boundaries)
> as well as powers of 2?
>

SLUB/SLAB use different strategy than SLOB, for better allocation
performance. It's variant of segregated storage method.

SLUB/SLAB both creates dedicated "caches" for each type of object. for
example, on my system, there are slab cache for dentry(192), filp(256),
fs_cache(64) ... etc.

Objects that has different types are by default managed by different cache,
which holds manages of pages. slab caches can be merged for better cacheline
utilization.

SLUB/SLAB also creates global kmalloc caches at boot time for power of 2
objects and (128, 256, 512, 1K, 2K, 4K, 8K on my system).

Thanks,
Hyeonggon.

> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
