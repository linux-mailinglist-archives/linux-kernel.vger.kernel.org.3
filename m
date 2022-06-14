Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7380254AC72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355486AbiFNIvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355983AbiFNIv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:51:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A641004
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:51:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i64so8005778pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GcDmyKbMVJDGWvzcHsGVQuP18Z833uzA4bptR4Fs4pQ=;
        b=beZRe95Lr0tH7S7mweuSbhUSSjlqnWEWSaa17bsi+kyifdMjiorYCWbcFoF0ud61mk
         e/BUObi1Qu7XSUMdtdMSYtFzZKOBmWgH2nADQOvCPOIIyy6GzISBRAg16v+c5Rj4RevP
         tA0sZ+nA+a7Xls+SOjXyrlBDyD8DaVScCxDUgZR7FCb3W3g2YBCpEgVGmfIuYxPYHbhC
         28qbrS2zu0GSlDYq4JD9RGnQeuIp7lEWVj+5Grh6MQCcCr+Rw2HjoKHHTBmsZy6onD09
         fn7UOZ3M9Gg8dsqzJTaylsYvorsCFe7NLbCDps5mVzSeBEtyA2ZhpPvzt0qziW6jo7qF
         OTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GcDmyKbMVJDGWvzcHsGVQuP18Z833uzA4bptR4Fs4pQ=;
        b=qRN8y3CCWXZnKKDHMHkkYVXmJZrZlf9T4H9gb7s5u8dzQrlgBmrK+LTHUHS2hP9q0o
         x5v61ELEmz+uo+L2zspT7i+GrBy1klRMbj/5mxtpZf+7g3zLUNWNvYsHMQTGDiUtYC9U
         Xpk2eA46xF44oTq5L8nf2FS65UpMRoX25pepP1BrBgIi3tfa2rl5sXhRJMX9vb2JDALq
         rAHUKAlIpUwJ5UYRmHtDYRCFxng9pz/B64Bfcf4DLjJQXA17ahUwiIvNqQclqIWDDR1T
         JknO3MFcKqhSbGUU3Pz/CPSRsh/hsjlQ+YcljfqNq2rLF1nT5iFpTFoD0DPkyfxt+9d3
         pw/A==
X-Gm-Message-State: AOAM530IHF+zPKXoLU4Ced1Dn94Lkhi3LZF9QS/N4Z0KMi32EjTHB/Y7
        ReMNU80cPtNeuYQierEQz4c=
X-Google-Smtp-Source: ABdhPJyZ5oMRTIE5HfG9tFVWHseAEmknEW4pKy164JcpJa0BfXwhIbMHYVfo8W5l18J79jSLtPJ7Gw==
X-Received: by 2002:a63:dd4c:0:b0:3fd:df6f:5bb1 with SMTP id g12-20020a63dd4c000000b003fddf6f5bb1mr3590057pgj.1.1655196684693;
        Tue, 14 Jun 2022 01:51:24 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id e129-20020a636987000000b00408a3724b38sm1333865pgc.76.2022.06.14.01.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 01:51:23 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:51:17 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Xiongwei Song <sxwjean@gmail.com>
Cc:     Xiongwei Song <sxwjean@me.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xiongwei Song <xiongwei.song@windriver.com>
Subject: Re: [PATCH v2] mm/slub: Simplify __kmem_cache_alias()
Message-ID: <YqhMBU9T0OY/NGf1@hyeyoo>
References: <20220603143555.41914-1-sxwjean@me.com>
 <YpspHqZM27DeEhNR@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <CAEVVKH_WM321zQPC-xjchqjySi4kngo6CFz-A6HY2tCjNCZ3SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEVVKH_WM321zQPC-xjchqjySi4kngo6CFz-A6HY2tCjNCZ3SA@mail.gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 03:04:44PM +0800, Xiongwei Song wrote:
> On Sat, Jun 4, 2022 at 5:43 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> >
> > On Fri, Jun 03, 2022 at 10:35:55PM +0800, sxwjean@me.com wrote:
> > > From: Xiongwei Song <xiongwei.song@windriver.com>
> > >
> > > There is no need to do anything if sysfs_slab_alias() return nonzero
> > > value after getting a mergeable cache.
> > >
> > > Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> > > Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > > v2: Collect Reviewed-by tag from Muchun.
> > > ---
> > >  mm/slub.c | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index d8d5abf49f5f..9444277d669a 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -4861,6 +4861,9 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
> > >
> > >       s = find_mergeable(size, align, flags, name, ctor);
> > >       if (s) {
> > > +             if (sysfs_slab_alias(s, name))
> > > +                     return NULL;
> > > +
> > >               s->refcount++;
> > >
> >
> > I think we should not expose sysfs attributes before initializing
> > what can be read via sysfs attribute (object_size).
> >
> > >               /*
> > > @@ -4869,11 +4872,6 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
> > >                */
> > >               s->object_size = max(s->object_size, size);
> >
> > this calculation should be done before sysfs_slab_alias().
> 

Sorry for the late reply.

> Yeah, understood. Should we restore s->object_size and s->inuse if
> sysfs_slab_alias() returns non zero value?

In my opinion, yes.

Thanks,
Hyeonggon

> Regards,
> Xiongwwei
> 
> >
> > Thanks,
> > Hyeonggon
> >
> > >               s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
> > > -
> > > -             if (sysfs_slab_alias(s, name)) {
> > > -                     s->refcount--;
> > > -                     s = NULL;
> > > -             }
> > >       }
> > >
> > >       return s;
> > > --
> > > 2.30.2
> > >
> >

-- 
Thanks,
Hyeonggon
