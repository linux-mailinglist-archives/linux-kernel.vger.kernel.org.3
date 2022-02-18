Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF02B4BB6FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 11:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiBRKiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 05:38:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiBRKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:38:20 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E21C3204B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:38:04 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w20so6813738plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 02:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LcqL4i71QUH+JJw7+SI/98dBrZjn5nAbXLi47gmA/IU=;
        b=AyMFXlcqFLqMLg2SWqB03zPZB6jTePzw2pSd7X2uRF7sw5xk8+TuG07WZPhgNoNnUo
         uCIJpLTbgiv9j0mmtlNEFHuOpERFaXFgx85hxLhaOkXFQdYIAFVB+73/8XX0HJG2ilOp
         B0Kvg1B6LV90iwy5/nGlTA/KYoBBnUpAcvQQUJi8cHK4msDfmlTlMauwZs48S35ZZB0G
         XeEOOpLI10ola/FSZlVlx76z5ucPVPej9RzSEdOG5TlHxC1NvfSzmOfuUQECM569MxGT
         3teK2uWqviyIuoId/WIJR+ZrarzGOUBQItPHCQ1kRabT7bMz5o5IM/fllV2LM8BmULC2
         7BHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LcqL4i71QUH+JJw7+SI/98dBrZjn5nAbXLi47gmA/IU=;
        b=XXhciKsKdR+r7XsOTxb54VHz5wlLT7xfOB/UcGzoPkxZH2cLqagT6AepALReCAJeue
         w+Lo1r9PEDMIuZVZgPgPEIROc25kUZByLvIAVBw8jnwoJ9WkPZ9Q5jzRJjOdB3QS8ys1
         6gyMicUMa0V/xQAjPzRrvAC9T+a9+Q2QfDEuBcFcHKnyX89cunF6zS5JnPG9sqhdvbFy
         0+m5w7lUsx0nxnz4RrLl5XeBT9yyAG8k8nVSHPrfNHG7aK/Q4aFm68VQxJa6PwmVzrPy
         ZgNwJdfhptwm3dQw76lmHMzEBBDTonA2z8a8LixyTH4MCufp6LLWv8cE966KYCCfqAWm
         jjPg==
X-Gm-Message-State: AOAM532vDa47xuEnZ5l8XomJZcIVuQqMQkU+hg0K84sGUY/IFV6gswxq
        5OiYEjeXBlPDB072wIG2HpQ=
X-Google-Smtp-Source: ABdhPJz32SXdkji8Ovdm/FdDKNJcFDEj43pwkAm4DR2lGp8YsS+2qClXj5s6bqJuP9zGhMPrTbUX9A==
X-Received: by 2002:a17:902:860a:b0:14b:341e:5ffb with SMTP id f10-20020a170902860a00b0014b341e5ffbmr6908039plo.6.1645180683864;
        Fri, 18 Feb 2022 02:38:03 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id l11sm4451064pjm.23.2022.02.18.02.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 02:38:03 -0800 (PST)
Date:   Fri, 18 Feb 2022 10:37:59 +0000
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
Message-ID: <Yg93B/DcI8+zqOjn@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <CAB=+i9Tor-tmZuB8YjATT_rv68nnF2W_TvMvyGp55AGaSyKynw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110251016260.3145@gentwo.de>
 <20211028100414.GA2928@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YXqSoo+b9RTclW/2@casper.infradead.org>
 <20211210110835.GA632811@odroid>
 <alpine.DEB.2.22.394.2112101305500.290446@gentwo.de>
 <cbfaeb40-13c7-15b6-177d-07b3f3c4a0a9@suse.cz>
 <20211215062904.GA1150813@odroid>
 <54c6fff8-8c79-463b-a359-96e37bd13674@suse.cz>
 <Yg9xSWEaTZLA+hYt@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg9xSWEaTZLA+hYt@ip-172-31-19-208.ap-northeast-1.compute.internal>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 10:13:29AM +0000, Hyeonggon Yoo wrote:
> On Wed, Dec 15, 2021 at 11:10:06AM +0100, Vlastimil Babka wrote:
> > On 12/15/21 07:29, Hyeonggon Yoo wrote:
> > > On Tue, Dec 14, 2021 at 06:24:58PM +0100, Vlastimil Babka wrote:
> > >> On 12/10/21 13:06, Christoph Lameter wrote:
> > >> > On Fri, 10 Dec 2021, Hyeonggon Yoo wrote:
> > >> > 
> > >> >> > > (But I still have doubt if we can run linux on machines like that.)
> > >> >> >
> > >> >> > I sent you a series of articles about making Linux run in 1MB.
> > >> >>
> > >> >> After some time playing with the size of kernel,
> > >> >> I was able to run linux in 6.6MiB of RAM. and the SLOB used
> > >> >> around 300KiB of memory.
> > >> > 
> > >> > What is the minimal size you need for SLUB?
> > >>  
> > > 
> > > I don't know why Christoph's mail is not in my mailbox. maybe I deleted it
> > > by mistake or I'm not cc-ed.
> > > 
> > > Anyway, I tried to measure this again with SLUB and SLOB.
> > > 
> > > SLUB uses few hundreds of bytes than SLOB.
> > > 
> > > There isn't much difference in 'Memory required to boot'.
> > > (interestingly SLUB requires less)
> > > 
> > > 'Memory required to boot' is measured by reducing memory
> > > until it says 'System is deadlocked on memory'. I don't know
> > > exact reason why they differ.
> > > 
> > > Note that the configuration is based on tinyconfig and
> > > I added initramfs support + tty layer (+ uart driver) + procfs support,
> > > + ELF binary support + etc.
> > > 
> > > there isn't even block layer, but it's good starting point to see
> > > what happens in small system.
> > > 
> > > SLOB:
> > > 
> > > 	Memory required to boot: 6950K
> > > 
> > > 		Slab:                368 kB
> > > 
> > > SLUB:
> > > 	Memory required to boot: 6800K
> > > 
> > > 		Slab:                552 kB
> > > 
> > > SLUB with slab merging:
> > > 
> > > 		Slab:                536 kB
> > 
> > 168kB different on a system with less than 8MB memory looks rather
> > significant to me to simply delete SLOB, I'm afraid.
> 
> Just FYI...
> Some experiment based on v5.17-rc3:
> 
> SLOB:
> 	Slab:                388 kB
> 
> SLUB:
> 	Slab:                540 kB (+152kb)
> 
> SLUB with s->min_partial = 0:
> 	Slab:                452 kB (+64kb)
> 
> SLUB with s->min_partial = 0 && slub_max_order = 0:
> 	Slab:                436 kB (+48kb)
> 
> SLUB with s->min_partial = 0 && slub_max_order = 0
> + merging slabs crazily (just ignore SLAB_NEVER_MERGE/SLAB_MERGE_SAME):
> 	Slab:                408 kB (+20kb)
> 
> Decreasing further seem to be hard and
> I guess +20kb are due to partial slabs.
> 
> I think SLUB can be memory-efficient as SLOB.
> Is SLOB (Address-Ordered next fit) stronger to fragmentation than SLUB?
	  (Address-Ordered *first* fit)
