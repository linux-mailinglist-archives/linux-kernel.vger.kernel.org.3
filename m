Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164834D9B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348442AbiCOMst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiCOMsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:48:47 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5480245784
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:47:35 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id n11so10027574qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B7pEXwFzgo4rOox6nVDFmgxOXeOCcTVTTlTiwKE1qAQ=;
        b=AxLlzrZFFinx3v3qxcSJwG8kMMDCTJfPy3a238z9DU+++nlTT8+pv9T22v9CjOFgk/
         nRzcbWMhrqTTrxDXGG364svExwF4vANPV/0VH4H0bh8g2/lDL1iJo7fm2ZUEbzLICyh3
         Us6w9epVMrwVwDxq22P94dmbZtRRhL4Kz0dwGa2ChzZ2skWq4YyOFJzEimcpWT2mpB42
         /eLjmoDlK/7nRK6COKRe/x7eAZH5CHk9Uk6MVZZumeyZafQjFa6oNWzJDiG4JPQhre8q
         uWqEfO0TLPI5RMdyfaRxz3rCbG+gq/dcfiZZSVAmMLznCkZFUcOxmvn2KwgQvIU+2P1m
         LRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B7pEXwFzgo4rOox6nVDFmgxOXeOCcTVTTlTiwKE1qAQ=;
        b=5ZlKxvSeeIGq/mQTO/LeoJqA6FNzCYmLyiVaNVI8tMvBPB2K/xrhx4N4NlHlDhsIIM
         I78GfkDI5TouaLrHXyiQ4AtQoPq2M4wr8lkXXN/YQDStJjGMXq5/T4oVjIdckuLil3UN
         Gaix3yah/R7MEm5SNrfx2gUr+6AOm82sWy9uEUzGU2K7FlLnySxKGLKjQeSYMWs3kYh3
         HKGcchgjb6VBGw5qTfVlbIQlSYtfZ6GU19Kq6grgEHELfmnxJt7IuHcVrMs+QNb4i+FB
         KYRATmTBbhVHWQVZljj0Ay6rMK8jnpXo10vwYD0w8lYdc4D7r9hFrq3eWIRuJ5yAtacv
         3qDg==
X-Gm-Message-State: AOAM531gLyT+MY3IBLiuIp8jRKq5ZQlL7PCpKWV0RxYUj3cT5r3mvNlY
        K3UZEHGOoiB6QilbF9gEiZe4GSS4LlmPJglFcck=
X-Google-Smtp-Source: ABdhPJxoKSVtwYVfQbcSJEII0PVgKvOgzB/w3kHMi5aRoRnGhYo75quRtlNpytcbBPbJJCtdyRKPqLjju3VOFwaNqok=
X-Received: by 2002:a05:622a:134d:b0:2e1:ce33:5d2d with SMTP id
 w13-20020a05622a134d00b002e1ce335d2dmr8848701qtk.407.1647348454540; Tue, 15
 Mar 2022 05:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 15 Mar 2022 12:47:23 +0000
Message-ID: <CACvgo50Fxn6D1d2_20etnL1TWfNkzJFydyDgr6DwGKFoxzg0_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Add memory shrinker to VirtIO-GPU DRM driver
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 at 22:44, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:

> Dmitry Osipenko (8):
>   drm/virtio: Correct drm_gem_shmem_get_sg_table() error handling
>   drm/virtio: Check whether transferred 2D BO is shmem
>   drm/virtio: Unlock GEM reservations in error code path

These three are legitimate fixes that we want regardless of the shrinker.

Please add the respective "Fixes" tag, so they find their way in the
stable trees. With that, them 3 are:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

HTH
Emil
