Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E2D462A96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbhK3CkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbhK3CkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:40:02 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E36C061748
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:36:44 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id y68so48118106ybe.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgI/AaQZFO092ur38zyTNNcK9cTmIjNH5zoKttaDw+s=;
        b=kYkEpq6LFfs3NoxTELSmxCDx47pYFaIovpRQGk2quPgVmdWUClF+vOD/rZsiomySAK
         X/zimWA0oKUSpvxdallx8oTsNjVTID4LekkUuE/tLkqT+GQ1HYUie6ZhKNFbOtfVyLrg
         Ol6Ov926pxHkMA3keHjhtZeyKd40GR/QHKJXOriNYWJvDwZi+y5GANYYSFLL7EwFqLls
         SWOM6of0sDfztlYzipJoSoyG0n7huKNlRqpRkgc+Flg82cBAIaqmbxv4poSaIfXHcBVP
         68vLxzZrlSTYmwhvu7R6HepJZm6xQ31Nn9db81qJeAbnEl09V7n0zPl1oE840Yz/jQlU
         SWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgI/AaQZFO092ur38zyTNNcK9cTmIjNH5zoKttaDw+s=;
        b=6LGsRQ9vLzQeY26mSdwBiK6JQKmXMSMqG8NUSCOo0N4WhDlLbpaJWFrKm+aSTSwKcu
         TXTBWCf9plUQH4eFc/k3eYINCztwUgZJ4zGaCgulJ9bfJ4Wzy3z52Aps7eujiTFUK674
         Yzh+K4iol3p8lbAlzamw+N7fK1ArlKillKq9QYItNnY6skpJwyIigU2PB79S+/aXx8Y4
         jfL++oUtO6j77XtlswctndBnYFSPK11/3djo6ry6zO9PuaIQ0tCuhY/B7HtC2uiRNPXu
         ZGa2qL2TkB7v3KVjdWbmBtozsYfbEQK6ibDnCj2MzhifHxvVhG+WZ6dt0S9uYXyxchbB
         LAwQ==
X-Gm-Message-State: AOAM532fTgzE9ZSA0fWDU2dhzH3SRn14EhqDAq6uUMFPQq4n3DTEDrMm
        li+DcDf/gdXEb/CMcKIA/rTZFNK4q8TUv27RIlovfA==
X-Google-Smtp-Source: ABdhPJyFf6WTkt1uX5KpYxUT5GJwtE8x2E0e3vEVMXMsXaGqkI+umr2ym/BiLOmJvqyb8y9kR3sw1Ymo4ANuwF0vanc=
X-Received: by 2002:a25:ba0e:: with SMTP id t14mr9675193ybg.49.1638239803470;
 Mon, 29 Nov 2021 18:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20211129161140.306488-1-longman@redhat.com>
In-Reply-To: <20211129161140.306488-1-longman@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 30 Nov 2021 10:36:07 +0800
Message-ID: <CAMZfGtXvHB-PRe11VmmFqsLg9EQ3LUPqYA2zNi-1A81p-pzH5Q@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: Relocate mod_objcg_mlstate(), get_obj_stock()
 and put_obj_stock()
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 12:14 AM Waiman Long <longman@redhat.com> wrote:
>
> All the calls to mod_objcg_mlstate(), get_obj_stock() and put_obj_stock()
> are done by functions defined within the same "#ifdef CONFIG_MEMCG_KMEM"
> compilation block. When CONFIG_MEMCG_KMEM isn't defined, the following
> compilation warnings will be issued [1] and [2].
>
>   mm/memcontrol.c:785:20: warning: unused function 'mod_objcg_mlstate'
>   mm/memcontrol.c:2113:33: warning: unused function 'get_obj_stock'
>
> Fix these warning by moving those functions to under the same
> CONFIG_MEMCG_KMEM compilation block. There is no functional change.
>
> [1] https://lore.kernel.org/lkml/202111272014.WOYNLUV6-lkp@intel.com/
> [2] https://lore.kernel.org/lkml/202111280551.LXsWYt1T-lkp@intel.com/
>
> Fixes: 559271146efc ("mm/memcg: optimize user context object stock access")
> Fixes: 68ac5b3c8db2 ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
