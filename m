Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7A248259E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 20:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhLaTWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 14:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhLaTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 14:22:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA36C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 11:22:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l5so76889116edj.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 11:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FaWMSBfmWtZkzvxZZ3tF40QOE4zBte4EqNi/u5y60I=;
        b=E/SjcKhF4JFcwzv2/X9miVwVq5ZuHd7raajITq4JeZsOaYHUlIMLL8fT89QVFi8I1y
         NoKWuNsw75AcoAl8eAjbCJ/7mDzs0ypgFYfoJln+z3TQ1dBYG7x/EO1e5qlupTlfnHKT
         R47HkHrOG4EccFnAkS/BskjKUHRPD8bcHdm5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FaWMSBfmWtZkzvxZZ3tF40QOE4zBte4EqNi/u5y60I=;
        b=i6MG3GLmRdrbi8mnhQGoWi6z9KyntaU9eOgGbmnByRSCLca6uqdmbPXGqTxsBatGvN
         8jILRgBSKCue0dNmP6TdRCanp+qONqmTIV6YEr4ADn5n9mmFZPjHigxW0lz82E0U5u3q
         +zrSjlq5vihmtz4DuEhKJ1Hr2QkzKaSN+8+p6DIKnaj2rafCMv4aXBEKPslkdrvZcitH
         XcR2U8MnHiiXj4/VJIhGr0/tQ9kDo9rpXh1GTCUs+Zm6rsF/i6/g0tnScHnrDAI81vO4
         uYuFSAmf5KZRh3A90IRdQBVPOEDbeBmrckiKALncFxP+q6drgGQ2VMEdsVPTW21u8aAh
         i8fg==
X-Gm-Message-State: AOAM532ja9BBpLrfacfo1OvGl8LtEn3FCuZmMdb6ShraGeKPxLv3bXrc
        oVVCWc6Spj50agi2/RPZ3WnBREKi/LbXfzr7wzg=
X-Google-Smtp-Source: ABdhPJxTt+hlKsgX4KHHbOZ1u3Rjntf4ojP/uJ0cPJZ0x0gMk+15LYRCngwXVT0mbRHNMiaz05Dhyw==
X-Received: by 2002:a17:906:cd05:: with SMTP id oz5mr29755022ejb.519.1640978572251;
        Fri, 31 Dec 2021 11:22:52 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id go10sm8624738ejc.100.2021.12.31.11.22.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Dec 2021 11:22:51 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id s1so57351672wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 11:22:51 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr29689443wrp.442.1640978571474;
 Fri, 31 Dec 2021 11:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <caf247ab-f6fe-a3b9-c4b5-7ce17d1d5e43@leemhuis.info> <20211229154553.09dd5bb657bc19d45c3de8dd@linux-foundation.org>
 <5c9d7c6b-05cd-4d17-b941-a93d90197cd3@leemhuis.info> <CAHk-=wi3z_aFJ7kkJb+GDLzUMAzxYMRpVzuMRh5QFaFJnhGydA@mail.gmail.com>
 <CAHk-=whj9ZWJ2Fmv2vY-NAB_nR-KgpzpRx6Oxs=ayyTEN7E8zw@mail.gmail.com>
In-Reply-To: <CAHk-=whj9ZWJ2Fmv2vY-NAB_nR-KgpzpRx6Oxs=ayyTEN7E8zw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Dec 2021 11:22:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKNjx1EApBoaqB0kZ8BB5r+YReOELA5uwRhwMi17S=qg@mail.gmail.com>
Message-ID: <CAHk-=wjKNjx1EApBoaqB0kZ8BB5r+YReOELA5uwRhwMi17S=qg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mark Brown <broonie@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 11:21 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Pushed out as 1b4e3f26f9f7 ("mm: vmscan: Reduce throttling due to a
> failure to make progress")

.. and I _think_ this empties the regzbot queue for this release, Thorsten. No?

                   Linus
