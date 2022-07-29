Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2558D5852F0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbiG2PlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbiG2Pkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:40:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F64287352;
        Fri, 29 Jul 2022 08:40:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y11so7873591lfs.6;
        Fri, 29 Jul 2022 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HWtZgfqryZS10gAM5+N9gAYNVLECjP2Z56KMURvmOKI=;
        b=euHZ1fQ1C+8MXJDNliazU66pJCoH1NCOGCtqLTKpdeASnGQkf+sY7yxLBk76yeVYay
         /EThO69XrLUTKSWN5LObbt4loU99UlWOf3oTDCNgKHDilPUDQoXejUL4JiJrJm6V6yJp
         QzjADGUrd2TOU0iyaCcbid3iRoNcNt+x4ZCX6hH1WxI2IbXnQQQnC4vpzjwftLaXzoCO
         Iy078jY1RFkL1j0OMVSzwbE1kjl89SWXdJ0MbXnRXay4hXDi/26q8fM/rUsXws4CXA8k
         HOjiZlnv1LArYZ+NpPcBvrU18gToZT/7AZJVw+dZikNiusCqqcNTqZPCl1johueID5eT
         VUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HWtZgfqryZS10gAM5+N9gAYNVLECjP2Z56KMURvmOKI=;
        b=fZcoxnRL9Ms8cl/XtegxISsT/XnpImTW97gcxJvi227/NevidnN2wucYjv1o7AtimK
         pIvKQW09qXHDmkclJPh1L7NEN99yVTc43S3YP5kdvnXXOJ+XF8dpoDzD0BXn+uElzUX3
         NBFvnUlh9EK88BvzNVKxDKqtjdELrQtrW9SsI2SGoHwXkHr5Mg9ZLWegnOxbcQsWX/Wk
         csKQx8Ezka8EkLEZL45frpZIFaGH6ZOGagvi9OqufopMVKpOq23gn5gxS6+vri/wNE7U
         S/OkYbi95y83wJnMNa/Qf2XrBWR7hKc4wGEefp1C7gENRsfy17HbHalMRrRBJbO/7S9L
         PHSA==
X-Gm-Message-State: AJIora+MU5kQyxGGvYJOOeeVqZOTvNoZP9E+iQED0Z79QEdAZif8w++p
        gLcWsHKMAvA+OSiGkj/x7htyX3qg9y/Ly3I75n8oXaWU
X-Google-Smtp-Source: AGRyM1sHvHUXlo1QU7/mh3/lb8kgSzVpxtss/27lKNBMvVfaHatlshZGnYxbG102EiWdDya/FmBDZL9xI/xdNeXM9Gk=
X-Received: by 2002:ac2:4f03:0:b0:481:50f7:ac07 with SMTP id
 k3-20020ac24f03000000b0048150f7ac07mr1348088lfr.422.1659109236965; Fri, 29
 Jul 2022 08:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220726175043.1027731-1-robdclark@gmail.com> <20220726175043.1027731-10-robdclark@gmail.com>
 <49fe9ecf-b1bd-a21b-8d8c-e4a33e3fa821@collabora.com>
In-Reply-To: <49fe9ecf-b1bd-a21b-8d8c-e4a33e3fa821@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 29 Jul 2022 08:40:24 -0700
Message-ID: <CAF6AEGuKU839m6TiARN3EwjPToo-qpdZR5cGD+BdJeiObjeY4A@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] drm/gem: Add LRU/shrinker helper
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 8:27 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 7/26/22 20:50, Rob Clark wrote:
> > +/**
> > + * drm_gem_lru_move_tail_locked - move the object to the tail of the LRU
> > + *
> > + * If the object is already in this LRU it will be moved to the
> > + * tail.  Otherwise it will be removed from whichever other LRU
> > + * it is in (if any) and moved into this LRU.
> > + *
> > + * Call with LRU lock held.
> > + *
> > + * @lru: The LRU to move the object into.
> > + * @obj: The GEM object to move into this LRU
> > + */
> > +void
> > +drm_gem_lru_move_tail_locked(struct drm_gem_lru *lru, struct drm_gem_object *obj)
> > +{
> > +     lockdep_assert_held_once(lru->lock);
> > +
> > +     if (obj->lru)
> > +             lru_remove(obj);
>
> The obj->lru also needs to be locked if lru != obj->lru, isn't it? And
> then we should add lockdep_assert_held_once(obj->lru->lock).
>

It is expected (mentioned in comment on drm_gem_lru::lock) that all
lru's are sharing the same lock.  Possibly that could be made more
obvious?  Having per-lru locks wouldn't really work for accessing the
single drm_gem_object::lru_node.

BR,
-R
