Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2E846D8A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhLHQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhLHQmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:42:11 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2453C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:38:39 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o17so2728095qtk.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 08:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nF6V5tMWiKH75knkiRMFt+EtHKzskngGPrZf17wdLBM=;
        b=hjbuZAqmUSEBdngCqKX0ob0KoeEJIVsY12CjCZs5hnQVfPPJjnKfWn69T9sOk/v+QQ
         lgjeYPRFl+yLZMqoxOffYVRuWEvhYl7Em8haJJtWQESZTyFkclXtoFcQUcelBGhbarem
         aQUEgvY7u4zEGp5rB4/DcfNJOEhwOcuRb/rybV47vxPPDuJunqGJDPU3xr6cK59mWjgt
         HHtb6Z+Q5IWxPiBJ8daUWLYT2tG4opt64WD1ms8BkLS5LjUh9dcN75sglDg2ZakWsnfR
         4Kc0hFhrCg4Zvrnl9eklv8FJuHrOdFFAOapg6mfWKH179mHlFyprs/+f/N/kyt9ANdgS
         CwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nF6V5tMWiKH75knkiRMFt+EtHKzskngGPrZf17wdLBM=;
        b=ycQiD1xsLCLkezKqg9BUpGe2/Tv+kr0wUMPHGHP+t4S8CjCHnU3oxCI/oljgLi/Hqk
         4YEO1tN0l2THPmGljr2otI8s/Es5+yhSlctapX9JPUBpc1SDEmJms+QMX5ZJ2tyFuWCw
         8iGn24ubScZU+24m/5C/6JA1P9ZfMNOfSnxvWvu3jaDBy83A9P37QuDSTM38oTxeKfpr
         Uw97j4XdegFX8umxzSY5MmbtolLCDfr3Hi+qo2k0dMl4J1rDrAXHhCHbCq2dtZrCmerT
         ZADGgWIj0pIcNHAjeBBvPov8OJKq1uMD89BZ5zl7Oryu6Kw1GciGwvYvXqK7PDlX3clt
         6CFQ==
X-Gm-Message-State: AOAM530vkKaPTVdBPQUMNa1xxYSVnMpzCC1B5piWguTQ35XQECfGxSdI
        Jz4JDfDQMfCkpU6VC6YO9/Sl5A==
X-Google-Smtp-Source: ABdhPJzvNgCijlTEnKMhDzTiI01sP7Yrg8WXhJZIrQGUnZkhUv1h8JBG473bDhFVIJs45vSgx/ttbA==
X-Received: by 2002:ac8:7d87:: with SMTP id c7mr9148381qtd.501.1638981518853;
        Wed, 08 Dec 2021 08:38:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:6bda])
        by smtp.gmail.com with ESMTPSA id d13sm1671930qkn.100.2021.12.08.08.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 08:38:38 -0800 (PST)
Date:   Wed, 8 Dec 2021 11:38:37 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: count zram read/write into PSI_IO_WAIT
Message-ID: <YbDfjdMljr9/TMwl@cmpxchg.org>
References: <1638356341-17014-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznHq15QN5Dn6_QfbAm7jS9OPCV4TVqn2_9RxUBx0V9v78w@mail.gmail.com>
 <Yaj0KTp17AaHMQyC@cmpxchg.org>
 <CAGWkznEHTVJzrCqfZRSHN=HtFjKHBGy0yyxpK8paP+9W1DsX_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEHTVJzrCqfZRSHN=HtFjKHBGy0yyxpK8paP+9W1DsX_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 05:16:47PM +0800, Zhaoyang Huang wrote:
> On Fri, Dec 3, 2021 at 12:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Dec 01, 2021 at 07:12:30PM +0800, Zhaoyang Huang wrote:
> > > There is no chance for zram reading/writing to be counted in
> > > PSI_IO_WAIT so far as zram will deal with the request just in current
> > > context without invoking submit_bio and io_schedule.
> >
> > Hm, but you're also not waiting for a real io device - during which
> > the CPU could be doing something else e.g. You're waiting for
> > decompression. The thread also isn't in D-state during that time. What
> > scenario would benefit from this accounting? How is IO pressure from
> > comp/decomp paths actionable to you?
> No. Block device related D-state will be counted in via
> psi_dequeue(io_wait). What I am proposing here is do NOT ignore the
> influence on non-productive time by huge numbers of in-context swap
> in/out (zram like). This can help to make IO pressure more accurate
> and coordinate with the number of PSWPIN/OUT. It is like counting the
> IO time within filemap_fault->wait_on_page_bit_common into
> psi_mem_stall, which introduces memory pressure high by IO.

It's not ignored, it shows up as memory pressure. Because those delays
occur due to a lack of memory.

On the other hand, having a faster IO device would make no difference
to the time spent on compression and decompression. Counting this time
as IO pressure makes no sense to me.

I'm against merging this patch.
