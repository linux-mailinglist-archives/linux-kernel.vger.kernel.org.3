Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9502D4E4483
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbiCVQto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239270AbiCVQtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:49:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF01DF66
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:48:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c62so2892964edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AGjZE0nexYYIrgZGc1/sQ9ebvM2IDXrU/8dxpFIfC6Q=;
        b=no3QyBMN97jJJhzD7cqUG00A6e2MB7KJHQvzy4ZBrorfKhZnY4KLpmH2ijl3hqJAEq
         w38SA1GGvBFZG7tP/8djpuj0BUbYdHZD9uy+WcRz+GY1qJugW+aRKiIkcr9+/i+/yCpl
         oDvJjvDBQlBi/23CI8I3sggW1bURzFDHhLeDItamtogT9SNEeMCBJHoKiJqhx70tbNX1
         Ju5tti5nJ1ezrJNTsClfOUV4Il9mdQ1cxiJnaMVkNSqyhptqkuN9M3Rj6KebwW+655E+
         EwOjKo25LrOTYBbCto5RaMfNuEZ99/RUyctw5hM2x3wHWiu5Zwfr1NE2y290i/E2Ow60
         0gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AGjZE0nexYYIrgZGc1/sQ9ebvM2IDXrU/8dxpFIfC6Q=;
        b=6luiIU0gGN3QR7IA3fLoAVnDZtQ+30956oiUlQZetIFYzn3fIaIpsQj9YtxJzOVjYx
         thVh7r7Sz2GdLO08VI+njiz9nGXfksP8JXYMUdFHG7WXyK4p9eR2oHEBj6lbnsPR64KK
         f6v6NHKbMC0LOzf3ptdsl13n7cjCKt9pXSctbOigkLY6hnyW3POYfAuG5wa1/PVU0t32
         YNZVob7r/BE82CC0V1yQDWqVlaxKwvosfO32EM7rM+9t2AVEU3b/YtJMa4lPzaaSfu2e
         LpMtNiqbV74LnEULQLARdveTjgL2DenefMMKm3V0yYsaAhergcYvJ4EAbhwf8QBPlR4G
         Sk2A==
X-Gm-Message-State: AOAM532LljXrGEodD0CvO8R+aKTjLd0YmuB4fEbEbu3bwpu8fzNVeWGM
        3JjKU7XJ3AE34ZqGIcHxpzuxndOa6ef98vVLhRlUQQ==
X-Google-Smtp-Source: ABdhPJwZRYX6C1CGVh68tu7TSeAiEpJ8wx/fcfVLk5Q+CMQBUqipxTaYyzGYpgmBcf1ERpmMdJvRS+InEGnYxa4P70w=
X-Received: by 2002:a50:fe81:0:b0:419:16a5:d265 with SMTP id
 d1-20020a50fe81000000b0041916a5d265mr21254515edt.4.1647967691267; Tue, 22 Mar
 2022 09:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220322095223.GG8477@blackbody.suse.cz>
In-Reply-To: <20220322095223.GG8477@blackbody.suse.cz>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 22 Mar 2022 09:47:59 -0700
Message-ID: <CABdmKX2hZChBO09xfhqB7EbH6RY9JdmDp7zh23DaGuwidn=v4w@mail.gmail.com>
Subject: Re: [RFC v3 5/8] dmabuf: Add gpu cgroup charge transfer function
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>, Kenny.Ho@amd.com,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        "Subject: Re: [RFC v3 5/8] dmabuf: Add gpu cgroup charge transfer
        function Reply-To: In-Reply-To:" 
        <CABdmKX3+mTjxWzgrv44SKWT7mdGnQKMrv6c26d=iWdNPG7f1VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 2:52 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> On Mon, Mar 21, 2022 at 04:54:26PM -0700, "T.J. Mercier"
> <tjmercier@google.com> wrote:
> > Since the charge is duplicated in two cgroups for a short period
> > before it is uncharged from the source cgroup I guess the situation
> > you're thinking about is a global (or common ancestor) limit?
>
> The common ancestor was on my mind (after the self-shortcut).
>
> > I can see how that would be a problem for transfers done this way and
> > an alternative would be to swap the order of the charge operations:
> > first uncharge, then try_charge. To be certain the uncharge is
> > reversible if the try_charge fails, I think I'd need either a mutex
> > used at all gpucg_*charge call sites or access to the gpucg_mutex,
>
> Yes, that'd provide safe conditions for such operations, although I'm
> not sure these special types of memory can afford global lock on their
> fast paths.

I have a benchmark I think is suitable, so let me try this change to
the transfer implementation and see how it compares.

>
> > which implies adding transfer support to gpu.c as part of the gpucg_*
> > API itself and calling it here. Am I following correctly here?
>
> My idea was to provide a special API (apart from
> gpucp_{try_charge,uncharge}) to facilitate transfers...
>
> > This series doesn't actually add limit support just accounting, but
> > I'd like to get it right here.
>
> ...which could be implemented (or changed) depending on how the charging
> is realized internally.
>
>
> Michal
