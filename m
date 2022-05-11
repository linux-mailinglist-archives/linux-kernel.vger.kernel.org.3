Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2A9523F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348285AbiEKVqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244741AbiEKVqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:46:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3901A80A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:46:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id c14so3103022pfn.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fmAQGXykxhi3NepF05zy14Lr44K9yKjrDKoSJAz3/FY=;
        b=JBqMvOVBN2rq0FFfHUFV1lH1c5cMiSL4usNhYXtUzFbudxKFr2HaFM5NBw15FMmZUh
         Ter7iPSqzb3NC1djJOjvaG7MuwkULz9LF6jXij8HFiTi861C/PXgJR9ewcrjdKwUEn6B
         GfIP+XhnBY3DfMFyMK9RlfwMomDKCjtLznNeqpElUkYWYTkcYZ8F2M+3eyQr8ACUC2MM
         +VE0n7soq5lesWTF9FQ86gGacuwnK0LMNHS8BpRLu1lQpc0B4RUUnV3WxsiRu3ENkFBo
         VBJBE5fu8hj9w2JxBu1OsvZbcaX44HrTnvrxlui7Lkaiw2s2GRAlzzf1L4aBlb7F76rX
         3Uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fmAQGXykxhi3NepF05zy14Lr44K9yKjrDKoSJAz3/FY=;
        b=0AJ6NJk0ClH0Pqy/7mFfH5X+V8iGAD1z5l8oaWnQzoO2HO/BXE39bjmcQgNZice0xH
         gfJr46e6Hk9qKwNWVijeJclh+PFF9XyeLydhtdSDanGJzYICDJT2wgoLqs6tQa38odPR
         D2OEPrXVEsekUY49tEUno8Gc5rqMa/XX9zD5UMBY/Fxli3KVo5dr67RIzYr+pgiKvY20
         sfCXA06MrksHH8/jG6v1/W4kvd88HAmCYFEjTS9zr3HgzewiFlu7pkmhTk9krfqnuVUV
         BDXm4Sm8RXLxC3idS7qm6YPMzeWg9bmHkttEuw6gq2u6xU+pixcgiITHhwRZRIDWHSsR
         3Gpw==
X-Gm-Message-State: AOAM533yf2QifF+BIFXVSbnsWIeNoTyV4STI60yxxy7ryQP19041t2Ps
        pnynqiDrBJJB9AFfatrYbL6GRVJLosc=
X-Google-Smtp-Source: ABdhPJzltmz0RDNNi+ko+midxpZBcyYw7TrYspnUZofQpPSidhOETlVnZ7Lgi9ltztlvJicJhn5sYQ==
X-Received: by 2002:a63:381e:0:b0:3c6:d5e4:fed9 with SMTP id f30-20020a63381e000000b003c6d5e4fed9mr11305562pga.553.1652305574817;
        Wed, 11 May 2022 14:46:14 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:69ef:9c87:7816:4f74])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902b41200b0015e8d4eb26asm2345293plr.180.2022.05.11.14.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:46:14 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 11 May 2022 14:46:12 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4] mm: fix is_pinnable_page against on cma page
Message-ID: <YnwupNzDNv7IbjRQ@google.com>
References: <20220510211743.95831-1-minchan@kernel.org>
 <857d21da-5de2-fa3e-b1ce-41cc1cfb0191@nvidia.com>
 <Ynr10y6pkH6WwbQo@google.com>
 <bb6e76f1-2cbc-893d-c8ab-3ecd3fcae2a5@nvidia.com>
 <Ynr+wTCQpyh8+vOD@google.com>
 <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ffa7670-04ea-bb28-28f8-93a9b9eea7e8@nvidia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 09:32:05PM -0700, John Hubbard wrote:
> On 5/10/22 17:09, Minchan Kim wrote:
> > On Tue, May 10, 2022 at 04:58:13PM -0700, John Hubbard wrote:
> > > On 5/10/22 4:31 PM, Minchan Kim wrote:
> > > > > > +	int __mt = get_pageblock_migratetype(page);
> > > > > > +	int mt = __READ_ONCE(__mt);
> > > > > 
> > > > > Although I saw the email discussion about this in v2, that discussion
> > > > > didn't go far enough. It started with "don't use volatile", and went
> > > > > on to "try __READ_ONCE() instead", but it should have continued on
> > > > > to "you don't need this at all".
> > > > 
> > > > That's really what I want to hear from experts so wanted to learn
> > > > "Why". How could we prevent refetching of the mt if we don't use
> > > > __READ_ONCE or volatile there?
> > > > 
> > > > > 
> > > > > Because you don't. There is nothing you are racing with, and adding
> > > > > __READ_ONCE() in order to avoid a completely not-going-to-happen
> > > > > compiler re-invocation of a significant code block is just very wrong.
> > > > > 
> > > > > So let's just let it go entirely. :)
> > > > 
> > > > Yeah, once it's clear for everyone, I am happy to remove the
> > > > unnecessary lines.
> > > > 
> > > > > 
> > > > > > +
> > > > > > +	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
> > > > > 
> > > 
> > > With or without __READ_ONCE() or volatile or anything else,
> > > this code will do what you want. Which is: loosely check
> > > for either of the above.
> > > 
> > > What functional problem do you think you are preventing
> > > with __READ_ONCE()? Because I don't see one.
> > 
> > I discussed the issue at v1 so please take a look.
> > 
> > https://lore.kernel.org/all/YnFvmc+eMoXvLCWf@google.com/
> 
> I read that, but there was never any real justification there for needing
> to prevent a re-read of mt, just a preference: "I'd like to keep use the local
> variable mt's value in folloing conditions checks instead of refetching
> the value from get_pageblock_migratetype."
> 
> But I don't believe that there is any combination of values of mt that
> will cause a problem here.
> 
> I also think that once we pull in experts, they will tell us that the
> compiler is not going to re-run a non-trivial function to re-fetch a
> value, but I'm not one of those experts, so that's still arguable. But
> imagine what the kernel code would look like if every time we call
> a large function, we have to consider if it actually gets called some
> arbitrary number of times, due to (anti-) optimizations by the compiler.
> This seems like something that is not really happening.

Maybe, I might be paranoid since I have heard too subtle things
about how compiler could changes high level language code so wanted
be careful especially when we do lockless-stuff.

Who cares when we change the large(?) function to small(?) function
later on? I'd like to hear from experts to decide it.

