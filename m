Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B539046685E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359573AbhLBQeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348060AbhLBQe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:34:27 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C0FC061758
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 08:31:04 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 13so710227ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 08:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGi7LIeuTdgZBFGen8AUJZNWTMwudrol6LbQe/Ktdd4=;
        b=kx1WWPNOnTyu2Su02F81AoeoOYfuXh7LGJ97vrlfiXWYVAACw5Sf0CY23J47o6lDP3
         EJpIk2t5t4/CXvC0UBUUa9sHppwc8pum5zDupnF2RJbwfR0wdkvg44koDf/TcHB9sMbh
         B0NpBbDIE896MiT2sev9n1Wwm85WCsoZBMjX4tLBZXuFCHoQrpONMPh7WPU1Vs9Dh686
         VBksvf1VEilgKBupFH7Nvx4l/NNfPVS5+yoHqKZ+IYBYMoON4xKYgxJ443leQwbyf9WP
         RmzV3gPk/toknMAUaV0JCjyan1Fz1btLii2S8vSXk4fkucpMQGYfrfMiWCE7n0vW1z/9
         WMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGi7LIeuTdgZBFGen8AUJZNWTMwudrol6LbQe/Ktdd4=;
        b=COLv69pf/ifFDRX5tmKJZkrjus9iINt+1BVvTyQCdrOfSEAdlBf297MR7IkhEz7HD5
         TgEdKxYaQW9sSpIyUNoZyG5utNiUz300iTHWRA009KsfowhNYaPIKePP2Vkaj5O3rXrl
         FCFwDh9mz4BkrCSojpE/XlzEa8f1cvT3j4ZDg++kTDPnkchK+8staovKq8UgA9vgXS5l
         KWZYRXTrBwupjqs7MDi4kBzAC6LQoSnLtyy5dHGhNL6ShZ3TPBVDiwIF1Rqi+9ljGZEu
         D3yr/PoX+kT06dAfNyzEfykN/mpdn+3Ns0TrBy8uE0+OUXwX8RI9ove8isVEDwGdtnUD
         QxZQ==
X-Gm-Message-State: AOAM530CFCgbkSt8Or7WPllIBfymtZsRfV5NyvAMxcmz+szPGNC2Feqe
        fky8oN6rhajrTFPiLu9PBBjQUP75Gp2qc/WoYEuh5gpTlJg/TA==
X-Google-Smtp-Source: ABdhPJydE37/YC3YcGsTbHv6XoqsBV4zF8xWP0hW8aluolTigJtBPrZTQ54xcXdEgBBd2cEWf/4xlCJqVwEekjJ0BDo=
X-Received: by 2002:a2e:bc1b:: with SMTP id b27mr12957864ljf.91.1638462662631;
 Thu, 02 Dec 2021 08:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20211202150614.22440-1-mgorman@techsingularity.net>
In-Reply-To: <20211202150614.22440-1-mgorman@techsingularity.net>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 2 Dec 2021 08:30:51 -0800
Message-ID: <CALvZod6am_QrZCSf_de6eyzbOtKnWuL1CQZVn+srQVt20cnpFg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

On Thu, Dec 2, 2021 at 7:07 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
> problems due to reclaim throttling for excessive lengths of time.
> In Alexey's case, a memory hog that should go OOM quickly stalls for
> several minutes before stalling. In Mike and Darrick's cases, a small
> memcg environment stalled excessively even though the system had enough
> memory overall.
>
> Commit 69392a403f49 ("mm/vmscan: throttle reclaim when no progress is being
> made") introduced the problem although commit a19594ca4a8b ("mm/vmscan:
> increase the timeout if page reclaim is not making progress") made it
> worse. Systems at or near an OOM state that cannot be recovered must
> reach OOM quickly and memcg should kill tasks if a memcg is near OOM.
>

Is there a reason we can't simply revert 69392a403f49 instead of adding
more code/heuristics? Looking more into 69392a403f49, I don't think the
code and commit message are in sync.

For the memcg reclaim, instead of just removing congestion_wait or
replacing it with schedule_timeout in mem_cgroup_force_empty(), why
change the behavior of all memcg reclaim. Also this patch effectively
reverts that behavior of 69392a403f49.

For direct reclaimers under global pressure, why is page allocator a bad
place for stalling on no progress reclaim? IMHO the callers of the
reclaim should decide what to do if reclaim is not making progress.

thanks,
Shakeel
