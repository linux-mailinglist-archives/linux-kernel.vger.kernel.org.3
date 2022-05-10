Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3337B52207F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346959AbiEJQDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346723AbiEJP6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:58:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0425113F1D7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:51:36 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso2399441pjw.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PqrBku7yWCns4CXdaKkexOpRPKx78T35A2SXeO5Nj2E=;
        b=H+qXQc4zr8F6UfoAgbi5D//b4XzaqZVmA+b7sInWlNzEN6NONMtGhp4uLT3EhXky0B
         F2ykJK18cz68RmJacrLVeTIKJsx2twiKIDeaoobGkT13lMMLzxjonor+gFOXjuv2eiFf
         alcejIWCmMvJy5lI8HJ2nUM36sWK7biyf10tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PqrBku7yWCns4CXdaKkexOpRPKx78T35A2SXeO5Nj2E=;
        b=2iYsZGiPm9ndk+mhRzzX8puv8dWGOw5N1+iJWL6l3vF1WPrSXJsi9TqKlk9yj6MoRQ
         MYVP2nIL1r37q3ggAZfWGT5l8AKeiQL3m4JdpeE8oZW2eQhrALbZ4eYjeWVjTntXCfal
         L4rAm0elUL/RebvcML2p4B/7mF/WALAKjMrPZld43siCeDb0yP1sZhRpv7iQKcNo3TM1
         djBwS1BfM8W5L8FIimgGLXiNEMupF2h6gbudeFHVmvwqdm4YGd2ygHShtI3EDhk2yLX6
         nGjuhg1JSu+7SCFLh70Q5mUNo1M8Fa/FmkYOLSskHDUyPMLaqYOqhhPmxDlCmFab4NAV
         rq6Q==
X-Gm-Message-State: AOAM531wNmMjE4qWgf0IB9O1GTfjlHDOkjBW6mGvb3j+nRQbfmFBo+1p
        PpsDAEMVgjqFjQ9j6UF202p78w==
X-Google-Smtp-Source: ABdhPJybt3dgYr6zy6CHWp80A2YhHDeIy7tSmCq53SNr13/QWthE/HGjzW3UCKvVi/6K+DIgnBx5KQ==
X-Received: by 2002:a17:902:b412:b0:15e:dc07:4c14 with SMTP id x18-20020a170902b41200b0015edc074c14mr21368892plr.99.1652197895085;
        Tue, 10 May 2022 08:51:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 67-20020a621946000000b0050dc7628190sm10963364pfz.106.2022.05.10.08.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:51:34 -0700 (PDT)
Date:   Tue, 10 May 2022 08:51:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bob Peterson <rpeterso@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Bill Wendling <morbo@google.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gfs2: Use container_of() for gfs2_glock(aspace)
Message-ID: <202205100851.663310B@keescook>
References: <20220508100630.2642320-1-keescook@chromium.org>
 <YnoQmuPgK9c5V8ZC@infradead.org>
 <CAHc6FU5VfS9yNe0yH_sfOt04rvii6T_NMq7kp+32HZa5XQDtEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5VfS9yNe0yH_sfOt04rvii6T_NMq7kp+32HZa5XQDtEA@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 01:13:31PM +0200, Andreas Gruenbacher wrote:
> Kees and Christoph,
> 
> thanks for the patch and review.
> 
> On Tue, May 10, 2022 at 9:29 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > +/* gfs2_glock_get(), "glock" must be first. */
> > > +struct glock_aspace {
> > > +     struct gfs2_glock       glock;
> > > +     struct address_space    mapping;
> > > +};
> >
> > Why does glock need to be first?  The whole point of using container_of
> > is that we don't have to make that assumption.
> 
> Just needs to be cleaned up in gfs2_glock_get() and
> gfs2_glock_dealloc() as well. I'll do that when applying the patch.
> 
> > >  static inline struct address_space *gfs2_glock2aspace(struct gfs2_glock *gl)
> > >  {
> > >       if (gl->gl_ops->go_flags & GLOF_ASPACE)
> > > -             return (struct address_space *)(gl + 1);
> > > +             return &(container_of(gl, struct glock_aspace, glock)->mapping);
> >
> > Do we even need the braces here?
> 
> Will use a local variable here, as suggested below.
> 
> > >       struct inode *inode = mapping->host;
> > >       if (mapping->a_ops == &gfs2_meta_aops)
> > > -             return (((struct gfs2_glock *)mapping) - 1)->gl_name.ln_sbd;
> > > +             return container_of(mapping, struct glock_aspace, mapping)->glock.gl_name.ln_sbd;
> >
> > A local variable would be really nice for the reader here to decompose
> > this a bit:
> >
> >                 struct glock_aspace *a =
> >                         container_of(mapping, struct glock_aspace, mapping);
> >
> >                 return a->glock.gl_name.ln_sbd;
> 
> Yes.

Thanks! So I should leave this with you to arrange, or should I send an
updated patch?

-- 
Kees Cook
