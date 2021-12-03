Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26AF4673CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379481AbhLCJUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351294AbhLCJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:20:32 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B43C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 01:17:08 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id q64so2743026qkd.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 01:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgvMwOkDcRoUF6R7PGhUdw3mIh9JYIpn/aXxn0rHolQ=;
        b=nWccPpijhFPpxe62l6g043xtvIKpN4xKMVs4CaZGS92+m9gNBa5P1/seNwuuKz157r
         avZG6v5LcPlAzEJiEEA7NvXEvb8qQCsX2PW/YApleUrHn4/t5BfILeIa10oQquZQaGhI
         VEVXb0YgWQc+VF36v6V5CpTczgIXpdBrJVYBDqLQWly8Z9foXAfUsQ5NF3A8QbhFjoLd
         GHNWpXwBq5pKeZrC1DmEnDziTeUzcS58/62urVJOSdciDK8w0Jj9D3YQOtdLWaZjb2KS
         JQl1ONfgjwIW1E8YCufzPstnfeNSv6XJfOwQ2zLSHdjq6A+HEDVY5yI5q6sWmk2W2ZAe
         gHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgvMwOkDcRoUF6R7PGhUdw3mIh9JYIpn/aXxn0rHolQ=;
        b=QfY/e0TCn5Ich7V8lHTP5Ei7VrvjAv/UJxqWNIohsuRrRZWzVQbvnMRBpYPW9DmUh9
         aBmjZIaZHgmjFG2S4v7JtKCza+ztH3N657+otRTmAhLyT5AmBHus7J3hHl6B0fjREfy8
         PUGh0kfk96DfGUSkv4m7DG5fhNlM1DFsJoWvhiklXXs3IYnSt4RJ/1u9558J1ksaee6f
         JcRmFZ40svtTcwK4GvNCyLsk5dwdNAVBxhotRA3dN3aoLi1YfMH35c4sjzEBguBUWjvr
         IoXiKfqhAL9oUZfxkdejL4pMIPm1Nv6I9v//+q7oxXR13dk4NXlJtWTnCikQJR8/jnuc
         kozw==
X-Gm-Message-State: AOAM530qY89xn0j7Qb4Q0S/b6ZGPp8ujmZMwxxHBbnj3kX9lbSlQsO4F
        pFrK4uzEGc6m8LjNkPnu7XJRvsyQ7HslixIHqVcd43T0BFuIKA==
X-Google-Smtp-Source: ABdhPJxAFBqQY6PWlnykAzmKxVmXsxvG6coacu8lAxuXBr0Kgrlh2Jfe1aY7MuMC1/QFtZH//XO0uIVKWVWUuYCDcaI=
X-Received: by 2002:a05:620a:2989:: with SMTP id r9mr16108300qkp.630.1638523027682;
 Fri, 03 Dec 2021 01:17:07 -0800 (PST)
MIME-Version: 1.0
References: <1638356341-17014-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznHq15QN5Dn6_QfbAm7jS9OPCV4TVqn2_9RxUBx0V9v78w@mail.gmail.com> <Yaj0KTp17AaHMQyC@cmpxchg.org>
In-Reply-To: <Yaj0KTp17AaHMQyC@cmpxchg.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 3 Dec 2021 17:16:47 +0800
Message-ID: <CAGWkznEHTVJzrCqfZRSHN=HtFjKHBGy0yyxpK8paP+9W1DsX_w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: count zram read/write into PSI_IO_WAIT
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 12:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Dec 01, 2021 at 07:12:30PM +0800, Zhaoyang Huang wrote:
> > There is no chance for zram reading/writing to be counted in
> > PSI_IO_WAIT so far as zram will deal with the request just in current
> > context without invoking submit_bio and io_schedule.
>
> Hm, but you're also not waiting for a real io device - during which
> the CPU could be doing something else e.g. You're waiting for
> decompression. The thread also isn't in D-state during that time. What
> scenario would benefit from this accounting? How is IO pressure from
> comp/decomp paths actionable to you?
No. Block device related D-state will be counted in via
psi_dequeue(io_wait). What I am proposing here is do NOT ignore the
influence on non-productive time by huge numbers of in-context swap
in/out (zram like). This can help to make IO pressure more accurate
and coordinate with the number of PSWPIN/OUT. It is like counting the
IO time within filemap_fault->wait_on_page_bit_common into
psi_mem_stall, which introduces memory pressure high by IO.
>
> What about when you use zram with disk writeback enabled, and you see
> a mix of decompression and actual disk IO. Wouldn't you want to be
> able to tell the two apart, to see if you're short on CPU or short on
> IO bandwidth in this setup? Your patch would make that impossible.
OK. Is it better to start the IO counting from pageout? Both of the
bdev and ram backed swap would benefit from it.
>
> This needs a much more comprehensive changelog.
>
> > > @@ -1246,7 +1247,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
> > >                                 zram_get_element(zram, index),
> > >                                 bio, partial_io);
> > >         }
> > > -
> > > +#ifdef CONFIG_PSI
> > > +       psi_task_change(current, 0, TSK_IOWAIT);
> > > +#endif
>
> Add psi_iostall_enter() and leave helpers that encapsulate the ifdefs.
OK.
