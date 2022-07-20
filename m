Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F207457B444
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiGTKF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGTKFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:05:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CD75C9E8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:05:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c6so14524082pla.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C6Z6JqwqSHD1Pxl7j+M9Xv/wk5TAAqbSiRlE2ihHvyk=;
        b=U93OjkVXci1r2RHwNOXChSOl29W1H4Aw9ze6/rLApkBNlMNjYWwh/uGvi0LxozP6D1
         buw7A48b80d75D7Zgy19O3zcN2oJHahtSiCUFvUwcvnYa4f1OmFdEKHPk+Tw++fHpHkO
         nJcwYvw5klU2ua/Fg/KSvx6R4oIGFl8JrMpq1QE1JU+tjnbuSqLcAXWEGlgkJbcJI2wa
         QT65DgTUFGOZ6iNbWIzr2cEEtZZ91eZzp7ZlqiItTguX0MP3qxrDuxX7bct5SPyavvoI
         WdBHfuJQUxq4TbLdmbklReu3rgMbjcfQpQygdILmoCpgUifHRsTbcVeroULUrVqksci+
         h/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C6Z6JqwqSHD1Pxl7j+M9Xv/wk5TAAqbSiRlE2ihHvyk=;
        b=NV2T4pepyF26eBTb4wBO5yCBiIGoPMs/OdFkWpNTaJXQy+HWer3STb4pagEXnqVCIQ
         WMyi7mwOLb/wSwPFebNorYCQkD3WER+pStVyetMEHk1f09v8+Lsm6OdXfDx7/Ie8TqHP
         T5LVzF8Gp4Sc2vMT7dongECqQseqVfYvdfeDJ9G12ygCbqOO7DU2/tLhGsM/YEPxwddd
         hsu3pdWvWYrAgD7kWkHEcG+4oMCAtNfl6V5UKQUfJHTWI17DWhw6TlNsgmYUpsrl2363
         h6dilnp2dx0ZxTnla+3e3pjx1k99gP7ETDcJU0fOh0dnjhY8eX3swd2YR601IOxi7J/m
         1A4Q==
X-Gm-Message-State: AJIora+y0UbJBkim3NSA0UJK6+OBokH2buWCq/OaWxEOhQxXmMLiFUXT
        7hyKjFOznscA9Cwb66i/s3E=
X-Google-Smtp-Source: AGRyM1s3ABuJ5Rs4YNmUtYSHTpyCuFYVnS+sK83V2uuFqCcwAy9zWvOS/H0Vol7ECwJ7WWBHG751kw==
X-Received: by 2002:a17:90b:1c09:b0:1ef:f82c:174b with SMTP id oc9-20020a17090b1c0900b001eff82c174bmr4411389pjb.88.1658311549965;
        Wed, 20 Jul 2022 03:05:49 -0700 (PDT)
Received: from ip-172-31-24-42.ap-northeast-1.compute.internal (ec2-35-78-228-6.ap-northeast-1.compute.amazonaws.com. [35.78.228.6])
        by smtp.gmail.com with ESMTPSA id r5-20020aa79885000000b00525442ac579sm13137201pfl.212.2022.07.20.03.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 03:05:49 -0700 (PDT)
Date:   Wed, 20 Jul 2022 10:05:44 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Christoph Lameter <cl@gentwo.de>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 16/16] mm/sl[au]b: check if large object is valid in
 __ksize()
Message-ID: <YtfTeJrnViCejwC4@ip-172-31-24-42.ap-northeast-1.compute.internal>
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-17-42.hyeyoo@gmail.com>
 <alpine.DEB.2.22.394.2207121701070.57893@gentwo.de>
 <Ys6Pp6ZPwJTdJvpk@ip-172-31-24-42.ap-northeast-1.compute.internal>
 <alpine.DEB.2.22.394.2207131205590.112646@gentwo.de>
 <CANpmjNPbbugrbCFADy1C7PgaU-4PMd9UK90QiHKS-Md0ocqa3w@mail.gmail.com>
 <alpine.DEB.2.22.394.2207141115050.184626@gentwo.de>
 <CANpmjNPGsqV4FYNq9Q-rUKCEZ3wOJbk3xfcfBks0O-bhFDmYcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPGsqV4FYNq9Q-rUKCEZ3wOJbk3xfcfBks0O-bhFDmYcw@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 12:30:09PM +0200, Marco Elver wrote:
> On Thu, 14 Jul 2022 at 11:16, Christoph Lameter <cl@gentwo.de> wrote:
> >
> > On Wed, 13 Jul 2022, Marco Elver wrote:
> >
> > > We shouldn't crash, so it should be WARN(), but also returning
> > > PAGE_SIZE is bad. The intuition behind returning 0 is to try and make
> > > the buggy code cause less harm to the rest of the kernel.
> > >
> > > >From [1]:
> > >
> > > > Similarly, if you are able to tell if the passed pointer is not a
> > > > valid object some other way, you can do something better - namely,
> > > > return 0. The intuition here is that the caller has a pointer to an
> > > > invalid object, and wants to use ksize() to determine its size, and
> > > > most likely access all those bytes. Arguably, at that point the kernel
> > > > is already in a degrading state. But we can try to not let things get
> > > > worse by having ksize() return 0, in the hopes that it will stop
> > > > corrupting more memory. It won't work in all cases, but should avoid
> > > > things like "s = ksize(obj); touch_all_bytes(obj, s)" where the size
> > > > bounds the memory accessed corrupting random memory.
> >
> > "in the hopes that it will stop corrupting memory"!!!???
> >
> > Do a BUG() then and definitely stop all chances of memory corruption.
> 
> Fair enough.
> 
> Well, I'd also prefer to just kill the kernel. But some people don't
> like that and want the option to continue running. So a WARN() gives
> that option, and just have to boot the kernel with panic_on_warn to
> kill it. There are other warnings in the kernel where we'd better kill
> the kernel as the chances of corrupting memory are pretty damn high if
> we hit them. And I still don't quite see why the case here is any more
> or less special.
> 
> If the situation here is exceedingly rare, let's try BUG() and see what breaks?

Let's try BUG() for both conditions and replace it with WARN() later
if kernel hit those often.

I'll update this patch in next version.

And I have no strong opinion on returning 0, but if kernel hits it a
lot, I think returning 0 would be more safe as you said.

Thanks,
Hyeonggon
