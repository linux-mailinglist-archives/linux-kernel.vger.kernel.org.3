Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9711B462266
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhK2UqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhK2UoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:44:02 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C91C0C0857
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:19:17 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id l7so35833166lja.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULamTUST6L2A21kAICas7AlHR1YPJikHumKTUMz0JF4=;
        b=KpLlvkXPiqlh90dRrkMiw6RVVebFtOcim8stxS8GSc3BRe262oEefo4fCtn/n5dSyF
         AzCk9A3mr0ghtqEYFUnZ6LpyGMxRrIR56LcUAjfj6Y5coGW4WKof/0nURa9/WhzOna//
         6KMeiBS7y93+57LjMtRLJWLV9Z8QG1Ulf86Zv/Qv5hr9iwB53s+NI9orCNCEtzv43Ma9
         rMZ8vvSZclmxXvo24LkFGlyI+FP5aK1DmEBGo7Wad3dzcYpWOO2QItBnMc2TtZvu7Xl3
         0dTtueijGHDAZWxLMaiuH5yXWBUn8CtZA3XEXtehRJPKfRP416Cf3jJVwV0guRHObDNu
         9D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULamTUST6L2A21kAICas7AlHR1YPJikHumKTUMz0JF4=;
        b=4dlFZ5KywFj7y1ktK3EbmEsU+t2CfSnhdBY+8jk31VMVsj6cem47CiCkAld5ulW7qC
         TYLo5SLJ72kKAJ3K1DBYd6VIfAShSjTTHKquUetTE+1XNqoKude6/CMwzNAWFS0RTfhm
         cKIm+hEo2Cmwrq9LAHPVF2/njW+yrvh0VMnj7ZFPNwFV53qUBZf0GS7CS+l6wsZWITHq
         RD31fMS4pYBgRcg1wHeWdeg/UixIM/kYh3369S2Ep1dzr8+dt7yESNjRJe+3V1pSU8Vq
         WNJfJQ7z0K4SMWrZfJdVTJHOuMsN7axuCfozYZA3T3IuokfDlt/zthL8iDCnMDlvLQkg
         EPwQ==
X-Gm-Message-State: AOAM530v/w/n29NaDamNDbESlpZzrh1ITT7fEFu0hm1Wu9PGdT640UoF
        4ubNauc7YA7+GoBE8I6IyKl13S4PTYj13MZ4Xghn5A==
X-Google-Smtp-Source: ABdhPJxqmbkfmnB5Qpdh6ObutiDkIv82YSiBCEC1//M8iI+OVzSf9Hz/3dHh9Q8OCShqO1Tq1mj/iIiNtEawrdh1T2M=
X-Received: by 2002:a2e:bc1b:: with SMTP id b27mr50913795ljf.91.1638206355462;
 Mon, 29 Nov 2021 09:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20211129161140.306488-1-longman@redhat.com>
In-Reply-To: <20211129161140.306488-1-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 29 Nov 2021 09:19:04 -0800
Message-ID: <CALvZod5mELR1OLEO+i6=wkDyckzGx8pXNFAYgLLxD8h+Q9K6Pw@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: Relocate mod_objcg_mlstate(), get_obj_stock()
 and put_obj_stock()
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 8:12 AM Waiman Long <longman@redhat.com> wrote:
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

Reviewed-by: Shakeel Butt <shakeelb@google.com>
