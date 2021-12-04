Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7235C468204
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 03:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384099AbhLDCll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 21:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbhLDClk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 21:41:40 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE96BC061354
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 18:38:15 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v138so14657495ybb.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 18:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/mTyk8aIwXaGnyhnIJNEDEMKPBdBItVHe13k9FZkPg=;
        b=kYMahCiLWicebBL5mpWnkZhDF6XeuuB9zqO4/U5pi1B81EWU9r7jTUpJRDRMgjntWS
         cMiV11vX89R/MpHtT2jLjHs90c2nkDQhWtFTzmIcoPbkA5zTlnE3ZHzTivaKltlOEIFc
         J5cu5jjb0pXuuFK/1/jVe8m/hWDwoZiZcSh1scy+VbZD3M0E6svgi6HwJNH+fcpxNNdy
         O7TAu3QWRZb6NdYEmcsuThTRlimoGQdy3ILtV48g8ZMzGN3q63nHDjbBZd/XSEJm72UV
         7G0VeIvNYNlUzv5DcXpPk0DHB2mi/nK4eilMJ2cEgO/7U0Zzl+1WakF10htEFF3XJhAv
         g5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/mTyk8aIwXaGnyhnIJNEDEMKPBdBItVHe13k9FZkPg=;
        b=U1una580/Akpqs/peRLN6XGw+vHTsJiB0Gr914NYInbB8fGJZrLEhH1aUhT5mEpLTR
         MGKm2WoewD6KRcoMIouGDAd7w7x0/wQN8AP2E6i0Hq1xtBagUY9IIjOYd+2axfhWnz5A
         YsmBrsHGKZcX9lYuifkDIV8lq0EBIRgK3T/xDaUfunBMto3q8OK/Xg0GGKErrptle6Fn
         KJSoyTDKtijkRWjZDrNcP9b0xU8fyZf/cv6F0gzzvTUGuA8CD96K470HOupUQ2u+OhjU
         UXAGBGl2Rc3fohDP+TPWoOB35GRf1DHtMpBLpvMkIsp+xIXxqy0UpSVB8CYW8m0PTImN
         ux7g==
X-Gm-Message-State: AOAM531sXxE2vG/FDSPsd86+5He9eGgsyKRI6CduZytA7FGf9iPcPw+f
        l+/A0Z4qS6WYbhwkpVym3C24ytGbcyP59CQXwBSz9Q==
X-Google-Smtp-Source: ABdhPJz4Q7i8gRI29F+bX6HPgquBXNSajDtNgM4FV0xGjBlDJ0AVdjZe4YDyUFlVYcsvtNAexWmTrtfke0KRjJqBdBo=
X-Received: by 2002:a25:ba0e:: with SMTP id t14mr27840068ybg.49.1638585494982;
 Fri, 03 Dec 2021 18:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20211201150440.1088-1-sj@kernel.org> <20211201150440.1088-5-sj@kernel.org>
 <CAMZfGtUPSmquyMd70HtqFVvxU68kbTdYN1fJU8g35zeXHMJHVA@mail.gmail.com> <20211203124430.bd1879d382010270f4112324@linux-foundation.org>
In-Reply-To: <20211203124430.bd1879d382010270f4112324@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 4 Dec 2021 10:37:37 +0800
Message-ID: <CAMZfGtVO42xt5hwjGXHru3ghEi_EezrEzS22AW_x4uUYiAD9Zg@mail.gmail.com>
Subject: Re: [PATCH 04/11] mm/damon/vaddr: Remove an unnecessary warning message
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
        brendanhiggins@google.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 4:44 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 3 Dec 2021 11:01:36 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > On Wed, Dec 1, 2021 at 11:05 PM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > The DAMON virtual address space monitoring primitive prints a warning
> > > message for wrong DAMOS action.  However, it is not essential as the
> > > code returns appropriate failure in the case.  This commit removes the
> > > message to make the log clean.
> > >
> > > Fixes: 6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schemes")
> >
> > I don't think there should be a Fixes tag since it's not a serious bug.
>
> "Fixes:" doesn't mean "backport to stable".  At least, not for MM
> patches.  Other subsystems do get their Fixes:-tagged patches
> automatically backported.
>

Got it. Thanks.
