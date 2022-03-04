Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8029E4CD3F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239649AbiCDMDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiCDMDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:03:41 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83596A052
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:02:53 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id w37so7345897pga.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 04:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NzcZgwZFLCCuIJnOuJ1HaowII5peo8NL2C53TxI2HVA=;
        b=em2FB0rNmaY2N4GJSP4mosWesASMnGcHZrZeumdPkHJrGww65bTu38YdATItGiHQc/
         PmLrKaceCTBksdgDmkOFm7PKKx5O6d7uMYrSw3XyxpJTk34EEAQftMuUucjT42Vrz2YA
         odIfUPn6kZDsTUX/q6A4cnpgkaQb+wKJzscwX5IZ0tLNLMVk4hkI3MH1vVUh3uCW1/jD
         qkqvmWZE81utQR7lKTw/MqJjCq7EiOoA+Kpz78jADqyt0Uvm0hGjzw+0tNaVgO2XU5Sz
         +bj6XFrCZRPwHk0/MUdDH/iMKEHeEvnqn/8+x+2TOunE0zudy7QfNNSw6NvCRSJCcFUH
         FNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NzcZgwZFLCCuIJnOuJ1HaowII5peo8NL2C53TxI2HVA=;
        b=ggsZKRbQwmTw2KV2FGoGuk6KKpZsnZ2K314QbpEzahmNzQrpHSLh02ASsfPssfKdaX
         KU+CZ04yJlWJbYB/OBpDIZs+c08K8xaMc59T5xsHVfh937zk3k8HXR1UcbDIsKC/Qobt
         P0PZXaqyT28whyO8Tn6S2gKNpHatmC7THfVRJQqoyPaKbVBA9IeSq365XgEGSs7rps5D
         sBNVAQl6lgt2e6r5RaL7//oA8AERl0QUb3jcK3xgqRut1zUHe0EbuTwN9tH6tIXdPzVc
         eDV+qg8c3Xgv/wF0o3gi98uINWdiZnNbmqSPPYA6tenmPqHX3m3q1M44GNxa67pZ15Xn
         rkDQ==
X-Gm-Message-State: AOAM5329hDG973xMRoYyMUguAMHfKZuZTtL+5uXP3GOeWz0WhPJp9arV
        WTW6p8oMok8+Vy4Xl8TVbO8=
X-Google-Smtp-Source: ABdhPJxwAUhaRxtOUSm1s6kiBI6LWfM+gF10OYm3swp4ny5IAETwFgi5xIKr8YEoO2/wZQhZoa1iyg==
X-Received: by 2002:a05:6a00:885:b0:4f4:17d8:be31 with SMTP id q5-20020a056a00088500b004f417d8be31mr24014481pfj.57.1646395373261;
        Fri, 04 Mar 2022 04:02:53 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id b21-20020a056a000cd500b004e1e0d3ed18sm5788181pfv.2.2022.03.04.04.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 04:02:52 -0800 (PST)
Date:   Fri, 4 Mar 2022 12:02:48 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] slab cleanups
Message-ID: <YiH/6MeYNaEehXmj@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
 <CANpmjNNv8+frHPdvT=0ZNuz5phUy1WRanJ6DkiiNvDTBtFraAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNv8+frHPdvT=0ZNuz5phUy1WRanJ6DkiiNvDTBtFraAQ@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 12:50:21PM +0100, Marco Elver wrote:
> On Fri, 4 Mar 2022 at 07:34, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > Changes from v1:
> >         Now SLAB passes requests larger than order-1 page
> >         to page allocator.
> >
> >         Adjusted comments from Matthew, Vlastimil, Rientjes.
> >         Thank you for feedback!
> >
> >         BTW, I have no idea what __ksize() should return when an object that
> >         is not allocated from slab is passed. both 0 and folio_size()
> >         seems wrong to me.
> 
> Didn't we say 0 would be the safer of the two options?
> https://lkml.kernel.org/r/0e02416f-ef43-dc8a-9e8e-50ff63dd3c61@suse.cz
>

Oh sorry, I didn't understand why 0 was safer when I was reading it.

Reading again, 0 is safer because kasan does not unpoison for
wrongly passed object, right?

> > Hello, these are cleanup patches for slab.
> > Please consider them for slab-next :)
> >
> > Any comments will be appreciated.
> > Thanks.
> >
> > Hyeonggon Yoo (5):
> >   mm/slab: kmalloc: pass requests larger than order-1 page to page
> >     allocator
> >   mm/sl[au]b: unify __ksize()
> >   mm/sl[auo]b: move definition of __ksize() to mm/slab.h
> >   mm/slub: limit number of node partial slabs only in cache creation
> >   mm/slub: refactor deactivate_slab()
> >
> >  include/linux/slab.h |  36 ++++++------
> >  mm/slab.c            |  51 ++++++++---------
> >  mm/slab.h            |  21 +++++++
> >  mm/slab_common.c     |  20 +++++++
> >  mm/slob.c            |   1 -
> >  mm/slub.c            | 130 ++++++++++++-------------------------------
> >  6 files changed, 114 insertions(+), 145 deletions(-)
> >
> > --
> > 2.33.1
> >

-- 
Thank you, You are awesome!
Hyeonggon :-)
