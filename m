Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B391B4BB692
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbiBRKNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:13:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiBRKNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:13:51 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CBB6007B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:13:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y9so8163478pjf.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1PKhL/9YxVh44Q8mJ2k9mFL0NfcXYRcMNcar+n3ctso=;
        b=B+V1TX06hO7yCTDcwWv1oOU8qPNwVKVSZAOtzncFeznx+dbcYcNw7EgUbZhCqOncHE
         v07rLC4MeWFX2F7hwBkI1VJCKIPIy5Ef6fty6j0rsRyg1QnFHJIQihmylTkAKmuBTEFN
         FQ8JC410OGtNTk8gZr+umUw0FnV78fqcuDl7rgniPqygdLBM2Nk4jSZnQxuMQVgRp0kq
         UfD7BUOs6si5i6YmhVdSxxHtcYuRefsaXUHRTLT53TYe2s2XXzbDQ30YqB+g5bEzFNIm
         3tLColl7XhgKpDgFrUvPTHSUgq0uEmOSBXHlmyGciCppxMSY8OcOQyBmX7bv1ASyc+jF
         5cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1PKhL/9YxVh44Q8mJ2k9mFL0NfcXYRcMNcar+n3ctso=;
        b=oh5ccjuMOwX/bczFiRQauF/HG9eVSdRZdWDBUWy39jV1mT9ydfL81Jf80Lak8giZpq
         ylP+5Rv0g/N5QvlzynSzsm7n+nCD8FQMVvHA2CcCNzUX+Q23RQ2/uB3+66BVs7R/OoQx
         fRR90g/a6g5OAGLUdyrz/dL0PmsuBqIuAlw+gTsE6wt5A4J6IwvksUSbnZXeraIIBV56
         Yv8S1d1n2bOmEswB1okNddRofsLhlxFYNkvbVnvnLji961MxLb5C12TmCiMQ0Sb5TZle
         FLi4evv3rhtswdqPIpjPxLGvZH3HykPM5ybUHXmKY+Sp2c7Wb1yTW1ku12xmDJTDYUJg
         5EaA==
X-Gm-Message-State: AOAM5300IPQGWeQVuT/DOiGq3Y+E3eE86IGa3I9eOCB4vmHwBQ+hzkaj
        0si0t4c8zqceXJvgefpt+Do8YDVOUTySKA==
X-Google-Smtp-Source: ABdhPJxcY9wJZv/QU9AS+Ztdz6u/swmfTAQm+kxu19oxkxM5a7MSxqJP7i7VJvqnFX3D6YmfBE2olA==
X-Received: by 2002:a17:90a:ec10:b0:1b8:9da7:3d13 with SMTP id l16-20020a17090aec1000b001b89da73d13mr7641603pjy.194.1645179214682;
        Fri, 18 Feb 2022 02:13:34 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id x4sm4398484pjq.2.2022.02.18.02.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 02:13:34 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:13:29 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@gentwo.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@gentwo.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Do we really need SLOB nowdays?
Message-ID: <Yg9xSWEaTZLA+hYt@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <YWw1n6y/AGED14HD@casper.infradead.org>
 <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
 <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YXqSoo+b9RTclW/2@casper.infradead.org>
 <20211210110835.GA632811@odroid>
 <alpine.DEB.2.22.394.2112101305500.290446@gentwo.de>
 <cbfaeb40-13c7-15b6-177d-07b3f3c4a0a9@suse.cz>
 <20211215062904.GA1150813@odroid>
 <54c6fff8-8c79-463b-a359-96e37bd13674@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54c6fff8-8c79-463b-a359-96e37bd13674@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:10:06AM +0100, Vlastimil Babka wrote:
> On 12/15/21 07:29, Hyeonggon Yoo wrote:
> > On Tue, Dec 14, 2021 at 06:24:58PM +0100, Vlastimil Babka wrote:
> >> On 12/10/21 13:06, Christoph Lameter wrote:
> >> > On Fri, 10 Dec 2021, Hyeonggon Yoo wrote:
> >> > 
> >> >> > > (But I still have doubt if we can run linux on machines like that.)
> >> >> >
> >> >> > I sent you a series of articles about making Linux run in 1MB.
> >> >>
> >> >> After some time playing with the size of kernel,
> >> >> I was able to run linux in 6.6MiB of RAM. and the SLOB used
> >> >> around 300KiB of memory.
> >> > 
> >> > What is the minimal size you need for SLUB?
> >>  
> > 
> > I don't know why Christoph's mail is not in my mailbox. maybe I deleted it
> > by mistake or I'm not cc-ed.
> > 
> > Anyway, I tried to measure this again with SLUB and SLOB.
> > 
> > SLUB uses few hundreds of bytes than SLOB.
> > 
> > There isn't much difference in 'Memory required to boot'.
> > (interestingly SLUB requires less)
> > 
> > 'Memory required to boot' is measured by reducing memory
> > until it says 'System is deadlocked on memory'. I don't know
> > exact reason why they differ.
> > 
> > Note that the configuration is based on tinyconfig and
> > I added initramfs support + tty layer (+ uart driver) + procfs support,
> > + ELF binary support + etc.
> > 
> > there isn't even block layer, but it's good starting point to see
> > what happens in small system.
> > 
> > SLOB:
> > 
> > 	Memory required to boot: 6950K
> > 
> > 		Slab:                368 kB
> > 
> > SLUB:
> > 	Memory required to boot: 6800K
> > 
> > 		Slab:                552 kB
> > 
> > SLUB with slab merging:
> > 
> > 		Slab:                536 kB
> 
> 168kB different on a system with less than 8MB memory looks rather
> significant to me to simply delete SLOB, I'm afraid.

Just FYI...
Some experiment based on v5.17-rc3:

SLOB:
	Slab:                388 kB

SLUB:
	Slab:                540 kB (+152kb)

SLUB with s->min_partial = 0:
	Slab:                452 kB (+64kb)

SLUB with s->min_partial = 0 && slub_max_order = 0:
	Slab:                436 kB (+48kb)

SLUB with s->min_partial = 0 && slub_max_order = 0
+ merging slabs crazily (just ignore SLAB_NEVER_MERGE/SLAB_MERGE_SAME):
	Slab:                408 kB (+20kb)

Decreasing further seem to be hard and
I guess +20kb are due to partial slabs.

I think SLUB can be memory-efficient as SLOB.
Is SLOB (Address-Ordered next fit) stronger to fragmentation than SLUB?
