Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27D449DD15
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiA0I5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiA0I53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:57:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A18DC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:57:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u15so3414170wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GY57P1sggKQ62F4MEfPuJxIuvLtyxZj9XProYJhJxXM=;
        b=BFIDGD8+9JuJaij5kjA57/Ww0Pz80Ocaf+mPmpMVDFv2ANWrz/twd25od88fymMu2A
         7jF8V9WRibRV6s+TvF87EfnRU5aEtFNuuo7xVlIcNCAJwiBoULAZH0azGNmKS/D8qE1i
         p/4cxUf3Px0hOtXdXk+PYoh7+pes5xdG9tVrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=GY57P1sggKQ62F4MEfPuJxIuvLtyxZj9XProYJhJxXM=;
        b=zJEsUPpGNNQCDGtCcn4FEUQhphKrBoUzDJBnyTNk335Liy0FIZfmNPFMphUoNpLy+S
         EYq3Ff0/ilXav6nWElJ7wjNbBOvm3K4b16GKKyiSckNWzTLXiSmK6sN1IjoM5qpPhusb
         B/uWEiCNPc6JR/q7ejOqBT4GpoFWiuWq78i9MVC/4OoO31jHuoRW0+ICxDJOEw1ZTf4T
         9ScBVHf3jSIfJfOMQHn55Mf5FICc3kzqeRcv+/IbABoTYjJ4gO/mzLe2k9J3U6cskHJG
         sq2o2l4pbimGz3900hHsaCZkz5dyv4Tm2ZHhnHBswm1pGKMiO6rtPD9PQzsu+qvrY8at
         LvEQ==
X-Gm-Message-State: AOAM531t9hPdCoAgmvxZ69md2dQ62FsFO9W+wGI+0oYfz0ON8O8Wh+59
        nlpEfPp+fbC6pSB5NqsP8AxE9A==
X-Google-Smtp-Source: ABdhPJyRQitMhUS+Ju/DLA/Kq0oR28qWU34o39eLzwkQsZqjzWAXY9sqLltQKK1y9VACzumfZZYb4w==
X-Received: by 2002:adf:f252:: with SMTP id b18mr2135447wrp.50.1643273847900;
        Thu, 27 Jan 2022 00:57:27 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l10sm1806803wry.67.2022.01.27.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 00:57:27 -0800 (PST)
Date:   Thu, 27 Jan 2022 09:57:25 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        linaro-mm-sig@lists.linaro.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 02/19] dma-buf-map: Add helper to initialize second map
Message-ID: <YfJedaoeJjE3grum@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linaro-mm-sig@lists.linaro.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
References: <20220126203702.1784589-1-lucas.demarchi@intel.com>
 <20220126203702.1784589-3-lucas.demarchi@intel.com>
 <f0dbdcc0-13b5-c484-0bf3-a1f8c3e48954@amd.com>
 <20220127075728.ygwgorhnrwaocdqv@ldmartin-desk2>
 <3066c6a7-fc73-d34d-d209-a3ff6818dfb6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3066c6a7-fc73-d34d-d209-a3ff6818dfb6@amd.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:02:54AM +0100, Christian König wrote:
> Am 27.01.22 um 08:57 schrieb Lucas De Marchi:
> > On Thu, Jan 27, 2022 at 08:27:11AM +0100, Christian König wrote:
> > > Am 26.01.22 um 21:36 schrieb Lucas De Marchi:
> > > > When dma_buf_map struct is passed around, it's useful to be able to
> > > > initialize a second map that takes care of reading/writing to an offset
> > > > of the original map.
> > > > 
> > > > Add a helper that copies the struct and add the offset to the proper
> > > > address.
> > > 
> > > Well what you propose here can lead to all kind of problems and is
> > > rather bad design as far as I can see.
> > > 
> > > The struct dma_buf_map is only to be filled in by the exporter and
> > > should not be modified in this way by the importer.
> > 
> > humn... not sure if I was  clear. There is no importer and exporter here.
> 
> Yeah, and exactly that's what I'm pointing out as problem here.
> 
> You are using the inter driver framework for something internal to the
> driver. That is an absolutely clear NAK!
> 
> We could discuss that, but you guys are just sending around patches to do
> this without any consensus that this is a good idea.

Uh I suggested this, also we're already using dma_buf_map all over the
place as a convenient abstraction. So imo that's all fine, it should allow
drivers to simplify some code where on igpu it's in normal kernel memory
and on dgpu it's behind some pci bar.

Maybe we should have a better name for that struct (and maybe also a
better place), but way back when we discussed that bikeshed I didn't come
up with anything better really.

> > There is a role delegation on filling out and reading a buffer when
> > that buffer represents a struct layout.
> > 
> > struct bla {
> >     int a;
> >     int b;
> >     int c;
> >     struct foo foo;
> >     struct bar bar;
> >     int d;
> > }
> > 
> > 
> > This implementation allows you to have:
> > 
> >     fill_foo(struct dma_buf_map *bla_map) { ... }
> >     fill_bar(struct dma_buf_map *bla_map) { ... }
> > 
> > and the first thing these do is to make sure the map it's pointing to
> > is relative to the struct it's supposed to write/read. Otherwise you're
> > suggesting everything to be relative to struct bla, or to do the same
> > I'm doing it, but IMO more prone to error:
> > 
> >     struct dma_buf_map map = *bla_map;
> >     dma_buf_map_incr(map, offsetof(...));

Wrt the issue at hand I think the above is perfectly fine code. The idea
with dma_buf_map is really that it's just a special pointer, so writing
the code exactly as pointer code feels best. Unfortunately you cannot make
them typesafe (because of C), so the code sometimes looks a bit ugly.
Otherwise we could do stuff like container_of and all that with
typechecking in the macros.
-Daniel

> > IMO this construct is worse because at a point in time in the function
> > the map was pointing to the wrong thing the function was supposed to
> > read/write.
> > 
> > It's also useful when the function has double duty, updating a global
> > part of the struct and a table inside it (see example in patch 6)
> > 
> > thanks
> > Lucas De Marchi
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
