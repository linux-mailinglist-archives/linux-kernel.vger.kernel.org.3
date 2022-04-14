Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CAA50093C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241465AbiDNJGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241545AbiDNJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:06:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD26EB23;
        Thu, 14 Apr 2022 02:03:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lc2so8725619ejb.12;
        Thu, 14 Apr 2022 02:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9u7qw4yp00eYY5QfUw6RMbFSecwCVYTFJ19bEl/qjdM=;
        b=AeKpdJKEodMNW2v4OrFzSphwYbliqKh3Sb491uSvXD6kjTpGBShcuurHxzXApjAm/7
         9gsi/w8Quy6dIfB/9Xrn0xDLMFWRJ334ZhY+EZ0d65IRGoRmrvB/g3J4RaS/7gR/xzTC
         Mu27Wi/qyqXdahzyu5oH3cZZckQ/sle14p3A+7JGeR6ANrPKidpJJ8ssZFfMg+1pwu/e
         Ypiob70EBAgmGfJfpTlNyMtltBCr2EEm+isaiR6ds38HQ0L2OqdRjcjyjinOmQk8zp26
         xfjsQlvZAL0AlS7M2KV+jVFII5qIigTJ4Fa1NBhr0umX/LlD5nQkSw8ACrUlNLDjNVca
         JT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9u7qw4yp00eYY5QfUw6RMbFSecwCVYTFJ19bEl/qjdM=;
        b=f0oYODcTSzlg2lmybKedg5Ll56y5O639P1L+fqoeRy8rmk1W4XLby6UDGc+nP4FFcM
         jDuaRIDPJyXjrE5q5O8Nbx+TJQGaiNPVqc5jm6R5tcx6QnCT3yGi/cOx3A8F5OvitFFu
         z2d1ztlTqNnnXx1ACvn8WlMybr+Ao2p9iejC+1Vyu6T/rs0CDjl1LJBjnTjSTFl7oxRf
         RJGX/tPvWyr+enPR6Z4RIeL2eJi2NpiIGEQVSOijoUKf8dkOCIR9dq5iv5fsIDT3rFYt
         JVorj2+Nf7RHr4UP5LHs1MV+eHw/9jC1rnIfigV6HAKIrmKi8PVlso1wH7XbLTyQpkgu
         ShhQ==
X-Gm-Message-State: AOAM532JTvYaRhDkeYly+SOj53DnvyH8RJPdR0xf4rTC3Lra6katncbP
        1XFoDIGfLC+reB3a0gxrcRM=
X-Google-Smtp-Source: ABdhPJxClkNKCFq2g+KTlgIrqxgJ2pli/Y86+JHuXOupIt/wTAfEaxcHxqIwG0S0s6bhMpHN9LCfkQ==
X-Received: by 2002:a17:907:6095:b0:6e7:cc3f:c33d with SMTP id ht21-20020a170907609500b006e7cc3fc33dmr1505722ejc.570.1649927018678;
        Thu, 14 Apr 2022 02:03:38 -0700 (PDT)
Received: from leap.localnet (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id s4-20020a170906a18400b006db0a78bde8sm436003ejy.87.2022.04.14.02.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 02:03:37 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Alison Schofield <alison.schofield@intel.com>,
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
Date:   Thu, 14 Apr 2022 11:03:35 +0200
Message-ID: <4180675.ejJDZkT8p0@leap>
In-Reply-To: <alpine.DEB.2.22.394.2204140902030.3023@hadrien>
References: <20220413225531.9425-1-fmdefrancesco@gmail.com> <Yld+wpMe1C51bKU3@iweiny-desk3> <alpine.DEB.2.22.394.2204140902030.3023@hadrien>
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

On gioved? 14 aprile 2022 09:03:40 CEST Julia Lawall wrote:
> 
> On Wed, 13 Apr 2022, Ira Weiny wrote:
> 
> > On Wed, Apr 13, 2022 at 05:44:54PM -0700, Alison Schofield wrote:
> > > On Thu, Apr 14, 2022 at 12:55:31AM +0200, Fabio M. De Francesco 
wrote:
> > > > The use of kmap() is being deprecated in favor of kmap_local_page()
> > > > where it is feasible. The same is true for kmap_atomic().
> > > >
> > > > In file pci/hmm/hmm.c, function hmm_store() test if we are in 
atomic
> > > > context and, if so, it calls kmap_atomic(), if not, it calls 
kmap().
> > > >
> > > > First of all, in_atomic() shouldn't be used in drivers. This macro
> > > > cannot always detect atomic context; in particular, it cannot know
> > > > about held spinlocks in non-preemptible kernels.
> > > >
> > > > Notwithstanding what it is said above, this code doesn't need to 
care
> > > > whether or not it is executing in atomic context. It can simply use
> > > > kmap_local_page() / kunmap_local() that can instead do the mapping 
/
> > > > unmapping regardless of the context.
> > > >
> > > > With kmap_local_page(), the mapping is per thread, CPU local and 
not
> > > > globally visible. Therefore, hmm_store()() is a function where the 
use
> > > > of kmap_local_page() in place of both kmap() and kmap_atomic() is
> > > > correctly suited.
> > > >
> > > > Convert the calls of kmap() / kunmap() and kmap_atomic() /
> > > > kunmap_atomic() to kmap_local_page() / kunmap_local() and drop the
> > > > unnecessary tests which test if the code is in atomic context.
> > > >
> > >
> > > Not specifically about this patch, but more generally about all
> > > such conversions - is there a 'proof' that shows this just works
> >
> > Just code inspection.  Most of them that I have done have been compile 
tested
> > only.  Part of the key is that des is a local variable and is not 
aliased by
> > anything outside this function.
> 
> Typically, the concern about being in atomic context has to do with
> whether GFP_KERNEL or GFP_ATOMIC should be used, ie whether allocation 
> can sleep.  

I'd add that the concern about being in atomic context has mainly to do 
with calling whatever function that may sleep. 

Some time ago I analyzed a calls chain which, under spinlocks and with 
IRQ's disabled, led to console_lock() which is annotated with 
might_sleep(). It took about 8000 ms to recover when executing in a 4 CPU / 
8 SMT System. Linus T. suggested to make this work asynchronous (commit 
1ee33b1ca2b8 ("tty: n_hdlc: make n_hdlc_tty_wakeup() asynchronous")).

> It doesn't have to do with whether some data can be shared.  

Yes, FWIW I agree with you.

> Is that the concern here?

The concern here is about the locality of the pointer variable to which the 
struct page has been mapped to. In atomic context we are not allowed to 
kmap() (this is why in the code we had that in_atomic() test), instead we 
can kmap_local_page() or kmap_atomic(). The latter is strongly discouraged 
in favor of the former.

Furthermore, Alison was asking if we can prove that these kinds of 
conversions can actually work when we have not the hardware for testing. As 
Ira wrote, code inspection is sufficient to prove it.

Thanks,

Fabio M. De Francesco



