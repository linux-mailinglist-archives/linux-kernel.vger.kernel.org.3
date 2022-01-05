Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A17485A39
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244220AbiAEUra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244200AbiAEUrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:47:17 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15C6C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 12:47:16 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id m19so1364808ybf.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 12:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02ZgXw9c8JzN01gaCGL5VWnFGMxpZF7MLVMkLIy8DNw=;
        b=sjXRrMchZskclkiP4hn18BKjFfN22i1Hpi02tLuMaEcmL+dWrh9T+MqmeGFJxewbZV
         Cp+C6NSEtfwlsmG/dbAVAx2yMl95m9sPeGJo376C4aQwylNlpfk9WYyYngF7mfHPfK0P
         vWRtySS9ZEO8x59S9+n7IjpmuDag2dH5FdW/LJcD4K1mGXyexhbsZb7/xU+Jj0duScdc
         F5HoCoPEx+iujoc10LOC/qqH/GlX0eD3wSzxN++Wrt44IjfjhmKhV4QPQDjzDjDwS5G9
         csjMqbdUOHfwezAvb5E/WobQBG8k9Bnflx9X/Kq4XHYivHSAqTxp+INWEEfST5ZVQgP4
         ZkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02ZgXw9c8JzN01gaCGL5VWnFGMxpZF7MLVMkLIy8DNw=;
        b=F3IfyNbFjJZicxHtuTxtJjKYJEPcDUsQ7hEFoBxlOlATKqDc72wU2pCUesD6X8aD5Y
         gH6n2Z6HdmXqUQ59Kod0WAavs3Mi/UuQSvWHB5EhlKGQ+s/IokhBKFOpYOD0J3oZbgAo
         MrwwgpPg4Sv/o/iTgupgXVpKz8LPdWz58y4EDJyJEi6hX0dE+yu220P5KTr0sU4wdgdo
         5QRC/7kva9xSonq0AUrSYlG41e4XuXo9GEf4ItiUmuQbhQwo9O6yTLVFIim1/tE0d2Tb
         AiZ++O2xxrM6BMvmnsuT9aNQMWUVbNYfd9iA48UKLejL0ymED64GoPmHMCbAf0hjHCCB
         0v7g==
X-Gm-Message-State: AOAM531RWXj3xbcTn9AmtM7kQ+ZpxUOEKEaLVIJpwyRePDeM/lK4JsGG
        Tblp/TL11vp/OSbwi03ME/mlbtllQyo7U8BOXzn9/A==
X-Google-Smtp-Source: ABdhPJyu2QAwdw8PEqEXDvKhFBnziLwhifsBxZiV/LYEOBnlKms2rVNNYSjY4xNGH1LDNHhy1TqlR1iK1DIv7oTr3hI=
X-Received: by 2002:a25:2e0a:: with SMTP id u10mr47560940ybu.246.1641415635828;
 Wed, 05 Jan 2022 12:47:15 -0800 (PST)
MIME-Version: 1.0
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1640262603-19339-2-git-send-email-CruzZhao@linux.alibaba.com>
 <CABk29NvPJ3S1xq5xm+52OoUGDyuMSxGOLJbopPa3+-QmLnVYeQ@mail.gmail.com> <b02204ea-0683-2879-5843-4cfb31d44d27@linux.alibaba.com>
In-Reply-To: <b02204ea-0683-2879-5843-4cfb31d44d27@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 5 Jan 2022 12:47:05 -0800
Message-ID: <CABk29Nts4sysjmRcnZ_DWmMzhUrianp55Zgf-Nod8m+aUKiWeA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/core: Cookied forceidle accounting per cpu
To:     cruzzhao <cruzzhao@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 3:33 AM cruzzhao <cruzzhao@linux.alibaba.com> wrote:
>
> Firstly, attributing forced idle time to the specific cpus it happens on
> can help us measure the effect of steal_cookie_task(). We found out that
> steal_cookie_task() conflicts with load balance sometimes, for example,
> a cookie'd task is stolen by steal_cookie_task(), but it'll be migrated
> to another core by load balance soon.

I don't see how this is very helpful for steal_cookie_task(), since it
isn't a targeted metric for that specific case. If you were interested
in that specifically, I'd think you'd want to look at more direct
metrics, such as task migration counts, or adding some
accounting/histogram for the time between steal and load balance away.

> Secondly, a more convenient way of
> summing forced idle instead of iterating cookie'd task is indeed what we
> need. In the multi-rent scenario, it'll be complex to maintain the list
> of cookie'd task and it'll cost a lot to iterate it.

That motivation makes more sense to me. Have you considered
accumulating this at the cgroup level (ie. attributing it as another
type of usage)?
