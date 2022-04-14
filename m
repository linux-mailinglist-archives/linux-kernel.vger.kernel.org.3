Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D28750096A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbiDNJPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiDNJPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:15:07 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A116E543;
        Thu, 14 Apr 2022 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wABewbZJt0mhh8IOk7ztCzKFnpM0lq0f8UJxdgJwrqg=;
  b=qXdcSY7Smws8LvBXxXr86/upbr7Gej5IBpqpPxjsH2+WInpl15o/qcem
   2esXvn8E5dynhns9xwodiGfUdjKacQRCnu+KgmHhvcgTgyN03Uog0OW2a
   pGPU2b9TVD1oLi9V39zfDHa6EYa0XgFq2Qd4Av22MO+ghLOVL0RsvzZsc
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,259,1643670000"; 
   d="scan'208";a="31661822"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 11:12:40 +0200
Date:   Thu, 14 Apr 2022 11:12:39 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Ira Weiny <ira.weiny@intel.com>,
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
Subject: Re: [PATCH] staging: media: atomisp: Use kmap_local_page() in
 hmm_store()
In-Reply-To: <4180675.ejJDZkT8p0@leap>
Message-ID: <alpine.DEB.2.22.394.2204141111250.3023@hadrien>
References: <20220413225531.9425-1-fmdefrancesco@gmail.com> <Yld+wpMe1C51bKU3@iweiny-desk3> <alpine.DEB.2.22.394.2204140902030.3023@hadrien> <4180675.ejJDZkT8p0@leap>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Apr 2022, Fabio M. De Francesco wrote:

> On gioved? 14 aprile 2022 09:03:40 CEST Julia Lawall wrote:
> >
> > On Wed, 13 Apr 2022, Ira Weiny wrote:
> >
> > > On Wed, Apr 13, 2022 at 05:44:54PM -0700, Alison Schofield wrote:
> > > > On Thu, Apr 14, 2022 at 12:55:31AM +0200, Fabio M. De Francesco
> wrote:
> > > > > The use of kmap() is being deprecated in favor of kmap_local_page()
> > > > > where it is feasible. The same is true for kmap_atomic().
> > > > >
> > > > > In file pci/hmm/hmm.c, function hmm_store() test if we are in
> atomic
> > > > > context and, if so, it calls kmap_atomic(), if not, it calls
> kmap().
> > > > >
> > > > > First of all, in_atomic() shouldn't be used in drivers. This macro
> > > > > cannot always detect atomic context; in particular, it cannot know
> > > > > about held spinlocks in non-preemptible kernels.
> > > > >
> > > > > Notwithstanding what it is said above, this code doesn't need to
> care
> > > > > whether or not it is executing in atomic context. It can simply use
> > > > > kmap_local_page() / kunmap_local() that can instead do the mapping
> /
> > > > > unmapping regardless of the context.
> > > > >
> > > > > With kmap_local_page(), the mapping is per thread, CPU local and
> not
> > > > > globally visible. Therefore, hmm_store()() is a function where the
> use
> > > > > of kmap_local_page() in place of both kmap() and kmap_atomic() is
> > > > > correctly suited.
> > > > >
> > > > > Convert the calls of kmap() / kunmap() and kmap_atomic() /
> > > > > kunmap_atomic() to kmap_local_page() / kunmap_local() and drop the
> > > > > unnecessary tests which test if the code is in atomic context.
> > > > >
> > > >
> > > > Not specifically about this patch, but more generally about all
> > > > such conversions - is there a 'proof' that shows this just works
> > >
> > > Just code inspection.  Most of them that I have done have been compile
> tested
> > > only.  Part of the key is that des is a local variable and is not
> aliased by
> > > anything outside this function.
> >
> > Typically, the concern about being in atomic context has to do with
> > whether GFP_KERNEL or GFP_ATOMIC should be used, ie whether allocation
> > can sleep.
>
> I'd add that the concern about being in atomic context has mainly to do
> with calling whatever function that may sleep.
>
> Some time ago I analyzed a calls chain which, under spinlocks and with
> IRQ's disabled, led to console_lock() which is annotated with
> might_sleep(). It took about 8000 ms to recover when executing in a 4 CPU /
> 8 SMT System. Linus T. suggested to make this work asynchronous (commit
> 1ee33b1ca2b8 ("tty: n_hdlc: make n_hdlc_tty_wakeup() asynchronous")).
>
> > It doesn't have to do with whether some data can be shared.
>
> Yes, FWIW I agree with you.
>
> > Is that the concern here?
>
> The concern here is about the locality of the pointer variable to which the
> struct page has been mapped to. In atomic context we are not allowed to
> kmap() (this is why in the code we had that in_atomic() test), instead we
> can kmap_local_page() or kmap_atomic(). The latter is strongly discouraged
> in favor of the former.

I have the impression that you are first agreeing with me and then
contradicting me :).  Is your point that in general a concern about atomic
context has to do with whether sleeping is allowed, but that the concern
is something else here?  I'm not familiar with these kmap functions.

thanks,
julia


>
> Furthermore, Alison was asking if we can prove that these kinds of
> conversions can actually work when we have not the hardware for testing. As
> Ira wrote, code inspection is sufficient to prove it.
>
> Thanks,
>
> Fabio M. De Francesco
>
>
>
>
