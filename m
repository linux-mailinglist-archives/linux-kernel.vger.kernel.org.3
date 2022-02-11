Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCD94B316F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 00:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354300AbiBKXm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 18:42:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354281AbiBKXmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:42:51 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67105D6C;
        Fri, 11 Feb 2022 15:42:48 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id k18so1570222ils.11;
        Fri, 11 Feb 2022 15:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EJieVrYw7bGsS/GbDwdyCqkJlHD+DNLeYNU+G9HF0Kw=;
        b=aJyCdrt6mtHVARW18KLBIZip5IXDQg3a50Kp8xN8UESpGu5Hg8vkgiS7JCTti43+MI
         YHzD/b+jZuTBWbpTbtgFWzZzikCdZT94HGe2M2cnWMzri3xBEX7c7vaxgRBFerE0rxuM
         bvcMe9NGtEpqZac2QheDaLEp3CjfrPoYKXTwSLVZ0IWpwd40PEHkzn2/ogEh5iAOw4TL
         S2Pq8mZCCyop5a3yYxrSOkPKb3vF/s/PW0xtrEEOEqI1qdyA3WmmIZrlfgd4c1rwuzMK
         kxWYhiAKGA5y8ueqQ8VWfZcTi5r/Z4k3SuxubyaLXnOcnXpxWWN0aL9Wywn91URR+8L1
         4Oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EJieVrYw7bGsS/GbDwdyCqkJlHD+DNLeYNU+G9HF0Kw=;
        b=eTgeOrulndOIdVAyKHHsZBrIv0odvSeXs3hnU9O1iqLB3KvU6B0x4+W3OSxHxiksMn
         fgyX434kziLJ43eio06YCT4sfLlWzoJzLX/PZ9QqsVIgfbFX8D15/lfbq1peouVKvEId
         bSZygV2bsRud0W/SPJreuhsIUs1moMKp0fxMB0FHPEhCQr3GH3MT0OZkFi3w9W4uMSbJ
         6YNGqgg8zd1tlJGjI2b+rV/dRWA+LYraUDZWi9fnPaEJWgHZ5nc9X4OxA7wXkgV/5Fht
         aIhtXWbTmkHQl47Lz7kjWVXIX3YL/ncRDO3JZrbpldC1T275zNsBMKsY9jA9lx3p/nnd
         afGw==
X-Gm-Message-State: AOAM533UgaxCDJN5hr8jXn/ioDB+wuTKRTbKWrxHftQwF9zCBICeAMN3
        dAyYdvoEPJcSMOcH2N2pQrw=
X-Google-Smtp-Source: ABdhPJx2/HGyOBckGTxMpiRreSEAJEsNJebRTbV0IbocBugJaSb4aBKID1N0GneyP9liEw2Hu3L3lw==
X-Received: by 2002:a92:d648:: with SMTP id x8mr2031228ilp.142.1644622967680;
        Fri, 11 Feb 2022 15:42:47 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id h19sm12766856ila.4.2022.02.11.15.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 15:42:47 -0800 (PST)
Date:   Fri, 11 Feb 2022 15:40:36 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 39/49] arch/s390: replace cpumask_weight with
 cpumask_weight_eq where appropriate
Message-ID: <Ygbz9G3DlPZYQ7Y7@yury-laptop>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-40-yury.norov@gmail.com>
 <yt9dwni17v19.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dwni17v19.fsf@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 07:54:26AM +0100, Sven Schnelle wrote:
> Hi Yury,
> 
> Yury Norov <yury.norov@gmail.com> writes:
> 
> > cfset_all_start() calls cpumask_weight() to compare the weight of cpumask
> > with a given number. We can do it more efficiently with
> > cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
> > traversing the cpumask earlier, as soon as condition is (or can't be) met.
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  arch/s390/kernel/perf_cpum_cf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
> > index ee8707abdb6a..4d217f7f5ccf 100644
> > --- a/arch/s390/kernel/perf_cpum_cf.c
> > +++ b/arch/s390/kernel/perf_cpum_cf.c
> > @@ -975,7 +975,7 @@ static int cfset_all_start(struct cfset_request *req)
> >  		return -ENOMEM;
> >  	cpumask_and(mask, &req->mask, cpu_online_mask);
> >  	on_each_cpu_mask(mask, cfset_ioctl_on, &p, 1);
> > -	if (atomic_read(&p.cpus_ack) != cpumask_weight(mask)) {
> > +	if (!cpumask_weight_eq(mask, atomic_read(&p.cpus_ack))) {
> >  		on_each_cpu_mask(mask, cfset_ioctl_off, &p, 1);
> >  		rc = -EIO;
> >  		debug_sprintf_event(cf_dbg, 4, "%s CPUs missing", __func__);
> 
> given that you're adding a bunch of these functions - gt,lt,eq and
> others, i wonder whether it makes sense to also add cpumask_weight_ne(),
> so one could just write:
> 
> if (cpumask_weight_ne(mask, atomic_read(&p.cpus_ack))) {
> 	...
> }
> 
> ?

It will have 3 users in cpumask + 1 in nodemask. I have no strong opinion
whether we need it or not. Let's see what people say.

Thanks,
Yury
