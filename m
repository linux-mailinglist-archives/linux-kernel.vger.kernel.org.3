Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E8453D421
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 02:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349839AbiFDAr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 20:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiFDAr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 20:47:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0917D1FCCF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 17:47:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b135so8293022pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 17:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdDGlC0lns52Uw6ScJUD6BF1PLqziLviHb7d6w1wTpY=;
        b=a1Zr2vgNvc3YZOeZA/WXKlisS5gVf19VLX5J0A4ciKLN+8Pm1fQhX+nIecPcWwXdWp
         hAL9Odinf0A8wu0W9tTPISn9n0/y4NlhTgE1wKRLDFQSyxusv54Aq5Q8BB3vYydv4np6
         fKbJgW9ijRf6W3+v2BDRE/KaP9xPKSNRb50bjwbLNUc1KmWevMv2H1orcSIGQ39I1mgc
         ntJK7CxT+W66XgRSN/HtGl5p+PaJrdL15mZJITgd5S2g6B4x3S315kxB6XzTV5cX+ozI
         LN2ZBtwrGzfwjvjk5l6d7jZawaIObnefzF147DnanowtkHUp3LkSWDM78JziRD0HvMKh
         yRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdDGlC0lns52Uw6ScJUD6BF1PLqziLviHb7d6w1wTpY=;
        b=V8aAhYiBmjpoc++KwhrjLHRO05CvMMdEGEu5+9tUpWTl+QPzC4vcTMrIij6OaTa0/G
         XjQgfPzF6eO4ocCMpkm2r2WATQqkT+k+LPTjCdSdCa8GxvUz4gvdBA88ScG01vFOw6so
         HZ5dw+rbgoNkPpLToyv9XYmtrR/x3sQYEyWofx0nUnePvpAzFSMnCo1ggzSlUlDt/Twn
         BBzAqL+Ab2+fAs4dYxsi5e5+qo9lV8mTJSX6nKuidA58h9ZMahFWA/IrmbwB5VRBNgnH
         sZxF7PWXrDiEN0SYRkosKye1/wpMgjIfVhxxBs7LSIjhBxc4CXs+U6L55dmtOCIKzkbX
         Redw==
X-Gm-Message-State: AOAM533c3+qZgNiJQFY7XGLamfktfUMAIz6TLeS3YZP/BZNoEIvGgIFk
        UI063yby962pKwY35DBEy6o/yu82yvflYAo7LLN1LQ==
X-Google-Smtp-Source: ABdhPJxDRGhEU8WNQRV9k+Q2YB3N3a9jW6NdWqcj3PP7qytCALiKQ4FiP7Hhr752nEOx7LkZYmS7a6QJywBNM3tYDvo=
X-Received: by 2002:a65:61a8:0:b0:3fa:95b8:66c4 with SMTP id
 i8-20020a6561a8000000b003fa95b866c4mr10961843pgv.166.1654303645308; Fri, 03
 Jun 2022 17:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220603070423.10025-1-zhengqi.arch@bytedance.com>
In-Reply-To: <20220603070423.10025-1-zhengqi.arch@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 3 Jun 2022 17:47:14 -0700
Message-ID: <CALvZod6s8ss0Doe9y+X=3ZHvw0Ove9Lw3MdfKekXr0gVnJwA4w@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: separate {pgscan,pgsteal}_{kswapd,direct}
 items in memory.stat of cgroup v2
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 12:06 AM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>
[...]
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 176298f2f4de..0b9ca7e7df34 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1442,11 +1442,17 @@ PAGE_SIZE multiple when read back.
>           pgrefill (npn)
>                 Amount of scanned pages (in an active LRU list)
>
> -         pgscan (npn)
> -               Amount of scanned pages (in an inactive LRU list)
> +         pgscan_kswapd (npn)
> +               Amount of scanned pages by kswapd (in an inactive LRU list)
>
> -         pgsteal (npn)
> -               Amount of reclaimed pages
> +         pgscan_direct (npn)
> +               Amount of scanned pages directly  (in an inactive LRU list)
> +
> +         pgsteal_kswapd (npn)
> +               Amount of reclaimed pages by kswapd
> +
> +         pgsteal_direct (npn)
> +               Amount of reclaimed pages directly

No objection to adding new fields but removing 'pgsteal' and 'pgscan'
from the user visible API might break some applications.
