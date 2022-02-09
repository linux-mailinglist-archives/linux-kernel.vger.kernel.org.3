Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7073A4AF66C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiBIQVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiBIQV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:21:28 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B47CC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:21:31 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id p190-20020a4a2fc7000000b0031820de484aso2988197oop.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=eWTUS3VqmsjwF4c8OTdfF5F0odt3UsQcGtmj9YbWaEk=;
        b=EIBIj1i0RF6eGofIPoMkdMlxqqoTb5r4muwHZujQjmjolPsYNoxgUKu/jT8Fu3jKkB
         /qytsaekGzVAdDUOk9HLhTVb5vW1puLgQSvn/tRDl2t1ebbB7Vue9+rxQEeIiYcc8KAO
         oSp8/xPz4a5wHhxGGDkWnXqrbZX0WI29dV4cSPUjoKv486QCfHtYEiBjzC5Em3E7KIVd
         c9o0+uldteFR96I3dhMGpuEfgcGB4LTR4wSzfkl0tqz3xWkFUlkEsL9Bws0D19G6SHsj
         qi02gEjgAm5UvcWjIkqPqFpGRuP/+8TMwuUvKw6hSsxPmc4VxhJS4XjMtIc9hQq8+lMZ
         7eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=eWTUS3VqmsjwF4c8OTdfF5F0odt3UsQcGtmj9YbWaEk=;
        b=J5Pv+KvFbo0Upz3uNPCmW/oXBgZwHQ139+AhhfJnyh9x+0VjU+5lRtypZR4rNrV5Er
         IhEvw2FKN+gbwonZLhHu5WsA/Ui41ZWhqBAWU8jz+ORpGat75H+vHR7wjAHZckG2LFaR
         1MkpJ8FjkJkhMNSyH7ZAvuBo8C8l3lYuG+J4D+si1kamO3rnz8TrW0t+vP3KW15PjskH
         9UDjJEl4Qptv7NR6ApbkMcqif3Z0U4pAQvAXV/6s4t3FAsXbuvXsG2nXg0BRxOVwYHLZ
         0HMH3Ywsd8kUDYUfXHPWm2FuZnQqC4oZVFwXrldh+E9cstB3kGuztL5ZXnkIlMVHCVVA
         zLmw==
X-Gm-Message-State: AOAM531/Y4m2+NCJODRlpfm3Zk9rzCeQgtPnYkeTM7d15EHI4mpzu6xJ
        B7/JXdE0388Xh3ibyh0ix+Ai+A==
X-Google-Smtp-Source: ABdhPJy0j7eWBmlJVk4eLI22dh3gUmeOg6uBbExzigwzZo5sR81MUFVc0DE25/D1z6UEH3jHHDWPPw==
X-Received: by 2002:a4a:1d42:: with SMTP id 63mr326326oog.80.1644423690443;
        Wed, 09 Feb 2022 08:21:30 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id el40sm7504405oab.22.2022.02.09.08.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:21:29 -0800 (PST)
Date:   Wed, 9 Feb 2022 08:21:17 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Michal Hocko <mhocko@suse.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/13] mm/munlock: rework of mlock+munlock page
 handling
In-Reply-To: <YgPfX+/f0ksBpx6G@dhcp22.suse.cz>
Message-ID: <147388c6-eb7-5c58-79a-7a8279c27fd@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <YgPfX+/f0ksBpx6G@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 9 Feb 2022, Michal Hocko wrote:
> 
> So far I have only managed to read through the series and trying to put
> all the pieces together (so far I have given up on the THP part) and my
> undestanding is far from complete. But I have to say I like the general
> approach and overall simplification.

Many thanks for looking, Michal, and for all the positivity!

> 
> The only thing that is not entirely clear to me at the moment is why you
> have chosen to ignore already mapped LOCKONFAULT pages. They will
> eventually get sorted out during the reclaim/migration but this can
> backfire if too many pages have been pre-faulted before LOCKONFAULT
> call. Maybe not an interesting case in the first place but I am still
> wondering why you have chosen that way.

I'm puzzled: what makes you think I'm ignoring already mapped LOCKONFAULT
pages?  I'd consider that a bug.

It is the case, isn't it, that a VM_LOCKONFAULT area always has VM_LOCKED
set too?  If I've got that wrong, yes, I'll need to revisit conditions.

> 
> I will be off next couple of days and plan to revisit this afterwards
> (should time allow). Anyway thanks a lot Hugh!
> -- 
> Michal Hocko
> SUSE Labs
