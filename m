Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FCA4CDE0C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiCDUDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiCDUDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:03:16 -0500
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697E82A7534
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 11:59:56 -0800 (PST)
Received: by mail-oi1-x249.google.com with SMTP id u13-20020a056808150d00b002d73c61e0d7so6237221oiw.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 11:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J64es7HM/NEnjdZCnfIshrO3wOmcq5xIZ4GZ3l0aZZI=;
        b=GItdpzKUBGucNm4WOe+HN7O/1STAH96AycQndTvxw/AJHcG/IZXBQqhHpuZ05xhR4h
         s4/tKY3tQeE7DrutZ5Ai6jwAl8HZtsKW56JRi+K1/bpZ5fj9ArMcTSHKmuftwci5pnc5
         8185Z7VFl8q58WBsa5DKcW7AqVcRHiRJlzc8uTybp2GtjLt3aimA8WJqpE9dZYDCaKpg
         nSDfUCu2diH4MZ2AkU0UqvXwMpOpJHeKUdcg+CDWj/hZdns7uGct3IOKaTBZkWLRZBTm
         LT0ppGdP7Ddd/W2mtx4Yd4qmSgUu1hBcDWvQ1o0GawHtl57BA07e3RkLP77VwgB12XvH
         SzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J64es7HM/NEnjdZCnfIshrO3wOmcq5xIZ4GZ3l0aZZI=;
        b=YN3lUN68o6VzuTaTSrpFcumbnZo8jVUMdFJwOSXW6ug+yDv3QFdkPWgyjFf8FSoix0
         N8JUAQW2w9cOyiY19q6F2UqawOt2M0dqSpf+rJQeB2N0hi7zoFOivewWpfPARyNOmPV3
         m1GAAJwLPhj1sbvERMFvMAqbrRAnXhPxz2B+yHJY3kFK3Nz5SsnHyL5kZNt6G4842rLV
         FcribcbSujJv1OxAyzP8Vf4BkICU69Z3MFJayHnllWDNCl1+ZwOA8/5Ch5+sACeBLQm+
         ONoRWaqGdZNuTwiQzoByV5lZfRpJy+Fiude32YEHyb8lQIwN0odngshpnPI2swVXSIke
         Br1g==
X-Gm-Message-State: AOAM533PYg0PRJ3PmrncxqrBl/eAPXrHW18rc5QnAmIbmM5tJr4K+UWI
        O/I4vGwEzM0lgTALW66OdmWtCoZPNMG3QQ==
X-Google-Smtp-Source: ABdhPJx1JBku7Y5F4eCh0ATGfGMRZ6wb/cJ1gQZwri0EnQCSBm4x3jk1yCC9794gkFLFxVD0xxm+uUa1OAahIg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a05:6902:3cc:b0:628:73aa:9c7f with SMTP
 id g12-20020a05690203cc00b0062873aa9c7fmr20910540ybs.632.1646421963101; Fri,
 04 Mar 2022 11:26:03 -0800 (PST)
Date:   Fri, 4 Mar 2022 19:26:00 +0000
In-Reply-To: <20220304171912.305060-1-hannes@cmpxchg.org>
Message-Id: <20220304192600.rvmgbg72aq6idooc@google.com>
Mime-Version: 1.0
References: <20220304171912.305060-1-hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: madvise: MADV_DONTNEED_LOCKED
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>, dgilbert@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 12:19:12PM -0500, Johannes Weiner wrote:
> MADV_DONTNEED historically rejects mlocked ranges, but with
> MLOCK_ONFAULT and MCL_ONFAULT allowing to mlock without populating,
> there are valid use cases for depopulating locked ranges as well.

> Users mlock memory to protect secrets. There are allocators for secure
> buffers that want in-use memory generally mlocked, but cleared and
> invalidated memory to give up the physical pages. This could be done
> with explicit munlock -> mlock calls on free -> alloc of course, but
> that adds two unnecessary syscalls, heavy mmap_sem write locks, vma
> splits and re-merges - only to get rid of the backing pages.

> Users also mlockall(MCL_ONFAULT) to suppress sustained paging, but are
> okay with on-demand initial population. It seems valid to selectively
> free some memory during the lifetime of such a process, without having
> to mess with its overall policy.

> Why add a separate flag? Isn't this a pretty niche usecase?

> - MADV_DONTNEED has been bailing on locked vmas forever. It's at least
>    conceivable that someone, somewhere is relying on mlock to protect
>    data from perhaps broader invalidation calls. Changing this behavior
>    now could lead to quiet data corruption.

> - It also clarifies expectations around MADV_FREE and maybe
>    MADV_REMOVE. It avoids the situation where one quietly behaves
>    different than the others. MADV_FREE_LOCKED can be added later.

> - The combination of mlock() and madvise() in the first place is
>    probably niche. But where it happens, I'd say that dropping pages
>    from a locked region once they don't contain secrets or won't page
>    anymore is much saner than relying on mlock to protect memory from
>    speculative or errant invalidation calls. It's just that we can't
>    change the default behavior because of the two previous points.

> Given that, an explicit new flag seems to make the most sense.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
