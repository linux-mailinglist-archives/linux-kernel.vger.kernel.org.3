Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D538E57BD4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiGTR5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGTR5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:57:03 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0CB24951;
        Wed, 20 Jul 2022 10:57:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so1857780wmi.1;
        Wed, 20 Jul 2022 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHRPEwie+kv37rjFQaOMTG39vvbswHQIAL5qJKmAXZY=;
        b=jHHP9ovMBvjF1Tz2XGF2O9uZIGYUh8uL3ccc1JcN0v8LL9vnt/CinMBSagcmUsB0Ha
         xOMPdfqLVfRR8KBTjUW3q4gJAiq9/Bj+xwq8vM5i2NJGbuUau3prMQFvEfK187IPw3sP
         ldn0KN2bm3rURRez4YtZRMTE9BhOk8rkB5kG+pW/VAI5cr1aqPSKS04ccEoqIYJR6tVy
         Zuw3v3nP+Hb8a3vYv7VyQIgdXWHzjqNVBfIr4tnV16bQGFafAwIaR6YmH3qdWmpIj3MM
         3fM2UpyV4zp2x+GfoPfTe10AJahSclTCRwIrWIwAQ6N64nxC0rG4BGVOnfxlHcdrCw9m
         qR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHRPEwie+kv37rjFQaOMTG39vvbswHQIAL5qJKmAXZY=;
        b=EMrO5uBrQB3xChamH6PnF9txpk3mUXEH8WZqoIZT19muEMEGx1ZoZq3QQaW5wr1h30
         e+mZGNU5v6QuJ8cMwSZ05k5+Ou4rqNu+NRzLQ9T25y7u8kTglp9UTQKOFCmtlQ9Tx+1T
         npDMPOAhdjscfk1PqrcLyirSsa+CvyqjtbbDWLlI4lLT6pYVOr9aYqUogHToaBOL+1gM
         d7jldZ+/C+GFfr34gIYaCF2kyls1VJCcK7H7NSL122VPbvwSKfTEMdm3HceGE/Q1PjVb
         42raYm4IgY8aSMMo0dloWih4L5kK9n4gxI5+z+y9olNh7ZO0nwWlclx2WvRPRP/n+/0u
         FiFw==
X-Gm-Message-State: AJIora+0P0BdKZHTew0ijJ2G3uDOvM1BWXp1933KOxHqVg5+GRyWSI+z
        p7tjgelnPI8DLbN0pFmkFdiKXbqsemLI01GLLdw=
X-Google-Smtp-Source: AGRyM1um84Qx2d3VuA14HmTjZeEjFriFAeIWZ5gQkmqsDi89xqJ0we4+Qh4P4848RYr0tzuTinlTksVyONKTxWesIwg=
X-Received: by 2002:a05:600c:3ac3:b0:3a0:45b6:7efb with SMTP id
 d3-20020a05600c3ac300b003a045b67efbmr4906657wms.183.1658339820479; Wed, 20
 Jul 2022 10:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220719171900.289265-1-robdclark@gmail.com> <20220719171900.289265-10-robdclark@gmail.com>
 <c5beb186-96d3-59d7-fad8-987bb8125de1@collabora.com>
In-Reply-To: <c5beb186-96d3-59d7-fad8-987bb8125de1@collabora.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 20 Jul 2022 10:57:21 -0700
Message-ID: <CAF6AEGusbnsY8fyFetkov5bRPd0vidTyBm8QL7a56TwYZ+NdRQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] drm/gem: Add LRU/shrinker helper
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
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

On Tue, Jul 19, 2022 at 11:56 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 7/19/22 20:18, Rob Clark wrote:
> > +void
> > +drm_gem_lru_move_tail_locked(struct drm_gem_lru *lru, struct drm_gem_object *obj)
> > +{
> > +     WARN_ON(!mutex_is_locked(lru->lock));
>
> Nit: What about lockdep_assert_held_once(&lru->lock->base)) ?

ahh, good point.. I've switched it locally

BR,
-R

> Otherwise, looks good! I'll use it for the DRM-SHMEM shrinker after
> completing the work on the dma-buf locks.
>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>
> --
> Best regards,
> Dmitry
