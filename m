Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED05C500A12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbiDNJnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiDNJnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:43:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79818349;
        Thu, 14 Apr 2022 02:41:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bv19so8955503ejb.6;
        Thu, 14 Apr 2022 02:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UuOwDORBiD0z41Seqm9aBtjGmDsw1F+gRxiqyKbH2nI=;
        b=OBGE3V9bp47DU5rd4Eq2DJhu1lFQdRlhlsn6/6VyI8H1yJagdbsz50SMeJgiQ5JRJG
         ALM+dxzQPso8u855jkyqw6A2/J+3wx//ATplFkqxy6yypYhf8TkONTW7qlm+zYZDLgUt
         vRNzPFR07vpJ1pEO4pfX8GnlDP4JKSAL7v/d0a25CwB5t4dNotFQ2qdyHyAsEFO+Df3r
         P2yvJtXBY7YWSyymSzyTQ3TeIT5XGVCpp6Na/2IAB5zoycjLc66dVyFqIcReRq6e2uaf
         +YMK2pBJ/LJ2dcUOVEV96b/o9xB8A0Tyob6oe3VpofJHqKNBREHSqXZ59X1Xti+rerkn
         D3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UuOwDORBiD0z41Seqm9aBtjGmDsw1F+gRxiqyKbH2nI=;
        b=TP3ZyZ1WFA2xJptLkUyke7gkHS1LmCNeXphLCa7FCMUiwCmmPPVpSMueEU5MfyHRJ3
         SKnkaBngduN5XWf2PLjFQJKUow1JzgU0ZL7W31iXuFpa4UEh8r4mWM2FIqnD+RAJAmxW
         fRpofCGebb6cVUp6FscEk1qRELzuZ0i6hrkuDxjkiSlXuEAaE88OWf4vSniQenuJIcgU
         W/gwFAQSRkXKXOmqCQQJykWPRbAyQ6XgJ3u3UkQVMcwd9lSKx8lk4MUVuC91pg+Yj0RW
         rL6dh/RHbmY/mBUVwaoztM3Ab70IRlYu8+wDhkelI/8GTfyxCFFZZ0nsBbCOtWV/Bk2p
         iGLg==
X-Gm-Message-State: AOAM532/ljQPIUoOpI6LLWvGBVqIAHGMEmoQZTWag91NhvnTDkqa9EJQ
        tV68entK+y87eWB/up+rOzA=
X-Google-Smtp-Source: ABdhPJx+1Tz4/yVuXTwUZGZ/Dok/CFO13SwpvvKqswiflJbKV1nw9ZFx1wBOSOxAQ8h8KTehIkuOTg==
X-Received: by 2002:a17:907:2d91:b0:6e8:abf6:c368 with SMTP id gt17-20020a1709072d9100b006e8abf6c368mr1703256ejc.124.1649929284659;
        Thu, 14 Apr 2022 02:41:24 -0700 (PDT)
Received: from leap.localnet (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id ay17-20020a170906d29100b006e88f246fdbsm454878ejb.152.2022.04.14.02.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 02:41:23 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alison Schofield <alison.schofield@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_store()
Date:   Thu, 14 Apr 2022 11:41:21 +0200
Message-ID: <2066056.OBFZWjSADL@leap>
In-Reply-To: <alpine.DEB.2.22.394.2204141111250.3023@hadrien>
References: <20220413225531.9425-1-fmdefrancesco@gmail.com> <4180675.ejJDZkT8p0@leap> <alpine.DEB.2.22.394.2204141111250.3023@hadrien>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved? 14 aprile 2022 11:12:39 CEST Julia Lawall wrote:
> 
> On Thu, 14 Apr 2022, Fabio M. De Francesco wrote:
> 
> > On gioved? 14 aprile 2022 09:03:40 CEST Julia Lawall wrote:
> > >
> > > On Wed, 13 Apr 2022, Ira Weiny wrote:
> > >
> > > > On Wed, Apr 13, 2022 at 05:44:54PM -0700, Alison Schofield wrote:
> > > > > On Thu, Apr 14, 2022 at 12:55:31AM +0200, Fabio M. De Francesco
> > wrote:
> > > > > > The use of kmap() is being deprecated in favor of 
kmap_local_page()
> > > > > > where it is feasible. The same is true for kmap_atomic().
> > > > > >
> > > > > > In file pci/hmm/hmm.c, function hmm_store() test if we are in
> > atomic
> > > > > > context and, if so, it calls kmap_atomic(), if not, it calls
> > kmap().
> > > > > >
> > > > > > First of all, in_atomic() shouldn't be used in drivers. This 
macro
> > > > > > cannot always detect atomic context; in particular, it cannot 
know
> > > > > > about held spinlocks in non-preemptible kernels.
> > > > > >
> > > > > > Notwithstanding what it is said above, this code doesn't need 
to
> > care
> > > > > > whether or not it is executing in atomic context. It can simply 
use
> > > > > > kmap_local_page() / kunmap_local() that can instead do the 
mapping
> > /
> > > > > > unmapping regardless of the context.
> > > > > >
> > > > > > With kmap_local_page(), the mapping is per thread, CPU local 
and
> > not
> > > > > > globally visible. Therefore, hmm_store()() is a function where 
the
> > use
> > > > > > of kmap_local_page() in place of both kmap() and kmap_atomic() 
is
> > > > > > correctly suited.
> > > > > >
> > > > > > Convert the calls of kmap() / kunmap() and kmap_atomic() /
> > > > > > kunmap_atomic() to kmap_local_page() / kunmap_local() and drop 
the
> > > > > > unnecessary tests which test if the code is in atomic context.
> > > > > >
> > > > >
> > > > > Not specifically about this patch, but more generally about all
> > > > > such conversions - is there a 'proof' that shows this just works
> > > >
> > > > Just code inspection.  Most of them that I have done have been 
compile
> > tested
> > > > only.  Part of the key is that des is a local variable and is not
> > aliased by
> > > > anything outside this function.
> > >
> > > Typically, the concern about being in atomic context has to do with
> > > whether GFP_KERNEL or GFP_ATOMIC should be used, ie whether 
allocation
> > > can sleep.
> >
> > I'd add that the concern about being in atomic context has mainly to do
> > with calling whatever function that may sleep.
> >
> > Some time ago I analyzed a calls chain which, under spinlocks and with
> > IRQ's disabled, led to console_lock() which is annotated with
> > might_sleep(). It took about 8000 ms to recover when executing in a 4 
CPU /
> > 8 SMT System. Linus T. suggested to make this work asynchronous (commit
> > 1ee33b1ca2b8 ("tty: n_hdlc: make n_hdlc_tty_wakeup() asynchronous")).
> >
> > > It doesn't have to do with whether some data can be shared.
> >
> > Yes, FWIW I agree with you.
> >
> > > Is that the concern here?
> >
> > The concern here is about the locality of the pointer variable to which 
the
> > struct page has been mapped to. In atomic context we are not allowed to
> > kmap() (this is why in the code we had that in_atomic() test), instead 
we
> > can kmap_local_page() or kmap_atomic(). The latter is strongly 
discouraged
> > in favor of the former.
> 
> I have the impression that you are first agreeing with me and then
> contradicting me :).  Is your point that in general a concern about 
atomic
> context has to do with whether sleeping is allowed, but that the concern
> is something else here?  I'm not familiar with these kmap functions.

Yes the concern is something else here (sorry for my poor English). It was 
not my intention to contradict you :) 

The concern for "locality" here is that if the variable is shared between 
different functions there are cases where we cannot use kmap_local_page().
For example, those mappings with kmap_local_page() are per thread and CPU 
local.

I think that the best means to convey what I want to express is pointing to 
my patch to Documentation/vm/highmem.rst:

https://lore.kernel.org/lkml/20220412124003.10736-1-fmdefrancesco@gmail.com/

I hope that this can help to understand why we care of "locality" in this 
specific case where we use kmap_local_page().

Again, sorry for not being clear.

Thanks,

Fabio M. De Francesco

> thanks,
> julia
> 
> 
> >
> > Furthermore, Alison was asking if we can prove that these kinds of
> > conversions can actually work when we have not the hardware for 
testing. As
> > Ira wrote, code inspection is sufficient to prove it.
> >
> > Thanks,
> >
> > Fabio M. De Francesco



