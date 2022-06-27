Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A055B5C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 05:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiF0Deh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 23:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF0Deg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 23:34:36 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6D738AF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 20:34:35 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2ef5380669cso72985517b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 20:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udYx9yVhBp19zfd4dxd6NWb/kHxWi5c9y7nXzGrjJEY=;
        b=Ntxnvqwm+4atSA7oH8HbS0qWbiyLl9hwKQPjhaoe5CikG0EkSFeR0jzF9Fwgs89O4j
         ozapg21g9OejXt5DBNn8WHlCY7d3wYaGk6oVysdhLX5uDoB0lr4Yj2j5BFkI8663a8CI
         vEn9f5StKVKnsH4GCtCWGuUIEclxpY7VETIg4LAbikp2xJIoxYRU/G60aZC+L5uz0YMX
         gAFxNaaPYcAbhKgIJuuMQXi6TMfdYpZvDjd1AL92PLhymq6SZ1HHzQqn1/sc6ctNL/67
         0YEX5l2JvW2MC4YiaTeERP3HtTy2l0iDOGc3MhIAtFpGeaEHSo0XcpN+idqgqzAYWKXG
         v33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udYx9yVhBp19zfd4dxd6NWb/kHxWi5c9y7nXzGrjJEY=;
        b=rzpdiU6lvetMV2SELoDRP2JTjgYOqRUv4wYjUedVMwLrBKxaU6auxG+2WWc99qWpu4
         fXL2mS9kH1kaU0d7bvfEoXT7rYKz+opDh3InFm1sVHYPdly8tFl0xWQd1qVqvBG05Qcq
         RP3czylXHPtD6FtTQvc79K9vL/dEjH80fMNp8rgONkNVHWy1PBJQxBT9i0LZ/A2pVKMM
         PQqaTxORajCiBgkgsJ5zV/fmD4gVKKHNsVVq/klXIOG4AGUQNFxWT731kxdOYioZJI7D
         4H1434hS0SrQ2C9gqjXin76iyqwe5Pp+tbvsuj33nM1j1DjDLIHC4vFbKWCng5L6kHli
         RffQ==
X-Gm-Message-State: AJIora8WihDgH/ANYfCGWKOWU3b7ibCEt6brNgX0XqCnw5RUCwMb3LLb
        48m9P0XpcB6UvI1r10/uloUlMq8hF23fevJZC4aFf34dR1olXzIo
X-Google-Smtp-Source: AGRyM1u1N/MM546IwEfu4pxLiWE2+9UtIyWwwrr/JEDz3XtCt5/tu6Z+IVxr9dZDJZdt/Z3XI5k3yf+zQdPyps+kfFc=
X-Received: by 2002:a81:5e42:0:b0:31b:6254:1c2b with SMTP id
 s63-20020a815e42000000b0031b62541c2bmr13394314ywb.35.1656300874622; Sun, 26
 Jun 2022 20:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <186d5b5b-a082-3814-9963-bf57dfe08511@openvz.org> <d8a9e9c6-856e-1502-95ac-abf9700ff568@openvz.org>
In-Reply-To: <d8a9e9c6-856e-1502-95ac-abf9700ff568@openvz.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 27 Jun 2022 11:33:58 +0800
Message-ID: <CAMZfGtWrqFiXUtGkhQwuR3wk1a8xH4Z1+B8zCwRTzny7EJGG-Q@mail.gmail.com>
Subject: Re: [PATCH cgroup] cgroup: set the correct return code if hierarchy
 limits are reached
To:     Vasily Averin <vvs@openvz.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 10:12 AM Vasily Averin <vvs@openvz.org> wrote:
>
> When cgroup_mkdir reaches the limits of the cgroup hierarchy, it should
> not return -EAGAIN, but instead react similarly to reaching the global
> limit.
>
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
