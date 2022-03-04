Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8F4CD95F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbiCDQqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiCDQqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:46:30 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9541C4B12
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:45:42 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id 189so3206564vsi.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 08:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GA0SoMn+kIK7VXpyWPIIcjTCHNEkwSgfzR0APlNlrJg=;
        b=pSeR3hef1XnxR4/nQFW+MFhfBtxvVFp57i9Us/VREs4VLuFusv1k4tzGc2MaHU2Mfl
         Bllgnmtnqu8UpbbnFCnunqddYu2K73j1s0TZAAxfmGirAE2DZnpmVl2q4V4zfdJv7Th5
         57eG/TvYKIQwBaAUYHriLKGxCEgM9kgeFhl4P08BcDWh/Qe7SjYVpaS+X73Y7kfowo3x
         m98tRTA9aRRBj9wnENGhz72MRBsZ5rZQwVDCoh3l3ZidlnJ+xBw5p+KjOvNWWsQnpzmD
         iNBt82ep8JZcXXhqfte7CY640ZR7O2LHWbFN/PFNSJ60cGov6bhIJ1UNpqz4HH02xLBZ
         A/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GA0SoMn+kIK7VXpyWPIIcjTCHNEkwSgfzR0APlNlrJg=;
        b=n1hvs9OCATtttw+Ffjc/MwBP4x/alPiVesx1gwmIqJdndNTgEXzZIafnBdexKketB+
         EBmUPiESPqN4JdqZeESeFIX0M+qMxqtj8RXbQc9RxW60Azg6Dbb1ioZGrrL8Gv4Fsmqq
         TMW3Tu3ZvK7yqSwCMPCAETdIGJxlQzrZZ+nz+5zR6KBaaQCzAX/ijQRFtQ6psq/6zxAy
         xLyhuBazeqN+4AKjLKmueL8f9Oyj6qRW4jBqRvyaS7ivMHIeyWZYrDA2XsSebpRzo8Df
         bhBc6NdhXGJOnbpeVfpycdhDIIHrUGoSSaZboq1hfU7iSXnU1ZoPOLzVy+RgWeLh7oUd
         N+XA==
X-Gm-Message-State: AOAM533kPe0R3ZiB8hNHJk7SKHnpDlg5Uuc5L/KewSk7dHrxASfTAY6y
        lNlXLyrhGVQ21hJtpPZUKN16cP/4yX2/GSParF5UeQ==
X-Google-Smtp-Source: ABdhPJyYpNlo2UIy0FwUyKX/4wcjFBLUOGvJrApitzy2ngjrFoIOsaKqWnVb6EliqTa8tklvYFF99QmZXD7MOGAgIBU=
X-Received: by 2002:a05:6102:303a:b0:31b:f6a6:237f with SMTP id
 v26-20020a056102303a00b0031bf6a6237fmr16448932vsa.4.1646412341333; Fri, 04
 Mar 2022 08:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20220304063427.372145-1-42.hyeyoo@gmail.com> <CANpmjNNv8+frHPdvT=0ZNuz5phUy1WRanJ6DkiiNvDTBtFraAQ@mail.gmail.com>
 <YiH/6MeYNaEehXmj@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <CANpmjNNYt9AG8RrGF0pq2dPbFc=vw2kaOnL2k5+8kfJeEMGuwg@mail.gmail.com> <b9adf3a8-a260-c3ae-58a3-feefab40a651@suse.cz>
In-Reply-To: <b9adf3a8-a260-c3ae-58a3-feefab40a651@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Mar 2022 17:45:05 +0100
Message-ID: <CANpmjNP3EJWpt3qHEMGmi3uVBMYthp66j9jvYggdbr1kTfpKBA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] slab cleanups
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 at 17:42, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 3/4/22 14:11, Marco Elver wrote:
> > On Fri, 4 Mar 2022 at 13:02, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >>
> >> On Fri, Mar 04, 2022 at 12:50:21PM +0100, Marco Elver wrote:
> >> > On Fri, 4 Mar 2022 at 07:34, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >> > >
> >> > > Changes from v1:
> >> > >         Now SLAB passes requests larger than order-1 page
> >> > >         to page allocator.
> >> > >
> >> > >         Adjusted comments from Matthew, Vlastimil, Rientjes.
> >> > >         Thank you for feedback!
> >> > >
> >> > >         BTW, I have no idea what __ksize() should return when an object that
> >> > >         is not allocated from slab is passed. both 0 and folio_size()
> >> > >         seems wrong to me.
> >> >
> >> > Didn't we say 0 would be the safer of the two options?
> >> > https://lkml.kernel.org/r/0e02416f-ef43-dc8a-9e8e-50ff63dd3c61@suse.cz
> >> >
> >>
> >> Oh sorry, I didn't understand why 0 was safer when I was reading it.
> >>
> >> Reading again, 0 is safer because kasan does not unpoison for
> >> wrongly passed object, right?
> >
> > Not quite. KASAN can tell if something is wrong, i.e. invalid object.
> > Similarly, if you are able to tell if the passed pointer is not a
> > valid object some other way, you can do something better - namely,
> > return 0.
>
> Hmm, but how paranoid do we have to be? Patch 1 converts SLAB to use
> kmalloc_large(). So it's now legitimate to have objects allocated by SLAB's
> kmalloc() that don't have a slab folio flag set, and their size is
> folio_size(). It would be more common than getting a bogus pointer, so
> should we return 0 just because a bogus pointer is possible?

No of course not, which is why I asked in the earlier email if it's a
"definitive failure case".

> If we do that,
> then KASAN will fail to unpoison legitimate kmalloc_large() objects, no?
> What I suggested earlier is we could make the checks more precise - if
> folio_size() is smaller or equal order-1 page, then it's bogus because we
> only do kmalloc_large() for >order-1. If the object pointer is not to the
> beginning of the folio, then it's bogus, because kmalloc_large() returns the
> beginning of the folio. Then in these case we return 0, but otherwise we
> should return folio_size()?
>
> > The intuition here is that the caller has a pointer to an
> > invalid object, and wants to use ksize() to determine its size, and
> > most likely access all those bytes. Arguably, at that point the kernel
> > is already in a degrading state. But we can try to not let things get
> > worse by having ksize() return 0, in the hopes that it will stop
> > corrupting more memory. It won't work in all cases, but should avoid
> > things like "s = ksize(obj); touch_all_bytes(obj, s)" where the size
> > bounds the memory accessed corrupting random memory.
> >
> > The other reason is that a caller could actually check the size, and
> > if 0, do something else. Few callers will do so, because nobody
> > expects that their code has a bug. :-)
>
