Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED352135B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbiEJLR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbiEJLRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC8782A83F1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652181226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D5QpDLvjaL/3sbIJjxhXvjRruga3nx8tizHPxU55AHk=;
        b=ixQltLsdZZmVu/paZGHocU3fq8Is5QE3+LMx8kuG5136bWfyOfK09jU4MGbs8LbXYOxBWB
        w9Zseyogv6OoAUvsfmC+0UUQu0xFit0fuykPaPwTe/RpErsacj6OGbSiElUJwf/LiqPI25
        J5r7pFe4SqbdDNBqQ8mmH78oiE/zw0I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-cMhZcyPwMlS2jAsJZrmERA-1; Tue, 10 May 2022 07:13:44 -0400
X-MC-Unique: cMhZcyPwMlS2jAsJZrmERA-1
Received: by mail-wm1-f69.google.com with SMTP id z23-20020a05600c221700b003942fd37764so1117847wml.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5QpDLvjaL/3sbIJjxhXvjRruga3nx8tizHPxU55AHk=;
        b=3utz9gl86pzZg5/vLUqcJjp74gpdyyou4VcvjiTWMqXWwFvccI/kb0Iy4tzxcIFyVX
         8Jx5RsuXr35aFb2nYS1wWiPsHsQ67A+zD8I5RWimMflZI3QGU0fnFo1aoSwFYLp0bxQ7
         Ef/ItheZy80dG/MFhS7zFQQxz24rbM1CY9j3UC/3tqXNoTDj6YZoloNSIM1eHCkcuS17
         Wsd8xQC3y5W+WZtmZiRh5UoSovkuaJUU/PR1OLiUM5vXkpUm5UX2KNeqBuALKnUJiv9n
         KwNntmKeWOpFvlgO61TIi2nyxYfTrL5AVakuZkO4e+BnmtK8XqwQX2N0HFc0n9lAWYWa
         nAQQ==
X-Gm-Message-State: AOAM530bd2PW0aiTsWlb7/V9gswpWCYoqgJdHrHGM4wYyTUiVirJTtxw
        VncecFgM02++RRx/9+0sYnQwUYgQ+wQWuZMVbu9GMcMqXIy+/CxGjq5M63+9aDXjoby4mfVJoIV
        BsJ9jQ2CMeBPq/Z0twxdXTHLdUVPEvVT1xdQAEMuZ
X-Received: by 2002:a05:600c:501e:b0:394:8b0a:3ec9 with SMTP id n30-20020a05600c501e00b003948b0a3ec9mr11945149wmr.0.1652181223538;
        Tue, 10 May 2022 04:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0gjbA7+3TrCagIYxdCI9NkRd7LcHVggdp1NZufK6Cnw8DV0cCzDb63Ne9hqLyNNa1u57MLcInZtEPF2ZahDw=
X-Received: by 2002:a05:600c:501e:b0:394:8b0a:3ec9 with SMTP id
 n30-20020a05600c501e00b003948b0a3ec9mr11945136wmr.0.1652181223377; Tue, 10
 May 2022 04:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220508100630.2642320-1-keescook@chromium.org> <YnoQmuPgK9c5V8ZC@infradead.org>
In-Reply-To: <YnoQmuPgK9c5V8ZC@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 10 May 2022 13:13:31 +0200
Message-ID: <CAHc6FU5VfS9yNe0yH_sfOt04rvii6T_NMq7kp+32HZa5XQDtEA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Use container_of() for gfs2_glock(aspace)
To:     Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Bill Wendling <morbo@google.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees and Christoph,

thanks for the patch and review.

On Tue, May 10, 2022 at 9:29 AM Christoph Hellwig <hch@infradead.org> wrote:
> > +/* gfs2_glock_get(), "glock" must be first. */
> > +struct glock_aspace {
> > +     struct gfs2_glock       glock;
> > +     struct address_space    mapping;
> > +};
>
> Why does glock need to be first?  The whole point of using container_of
> is that we don't have to make that assumption.

Just needs to be cleaned up in gfs2_glock_get() and
gfs2_glock_dealloc() as well. I'll do that when applying the patch.

> >  static inline struct address_space *gfs2_glock2aspace(struct gfs2_glock *gl)
> >  {
> >       if (gl->gl_ops->go_flags & GLOF_ASPACE)
> > -             return (struct address_space *)(gl + 1);
> > +             return &(container_of(gl, struct glock_aspace, glock)->mapping);
>
> Do we even need the braces here?

Will use a local variable here, as suggested below.

> >       struct inode *inode = mapping->host;
> >       if (mapping->a_ops == &gfs2_meta_aops)
> > -             return (((struct gfs2_glock *)mapping) - 1)->gl_name.ln_sbd;
> > +             return container_of(mapping, struct glock_aspace, mapping)->glock.gl_name.ln_sbd;
>
> A local variable would be really nice for the reader here to decompose
> this a bit:
>
>                 struct glock_aspace *a =
>                         container_of(mapping, struct glock_aspace, mapping);
>
>                 return a->glock.gl_name.ln_sbd;

Yes.

Thanks,
Andreas

