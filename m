Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421B74A9EAA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377379AbiBDSJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiBDSJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:09:11 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F1CC061714;
        Fri,  4 Feb 2022 10:09:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id o12so21653764eju.13;
        Fri, 04 Feb 2022 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOk1AjwIVX9pqDuRbELOCa6z4G8rYwIr5B63rOLPi6w=;
        b=WzlYqpQ9SFXr3PX0uYzI1THJe1HOJjHnQYjFosTkecnxX56r1yjc/1jr7dEL2onX98
         ojbxDzjeA15k37t+POMIoGbnCdw0F0/Q945oDIATQCU3YuHJMrym9OBMUy7ED58xFS2f
         OvDj3LeIFKuByu9wtCVJj9zR/KCHwgCzcufanpT3Rj+fiCD8TpGIYoPiv8uZEfXPGKVL
         ivQUAqE+Wt1bWyxBLkf41RjEpx0xgnyW8E3SrjnhEJsr0lkM46GugLbkvvtIrsm+GP7o
         N8n6JUrCA37Izve+pGlgY9XFG28XEHH0TdJHSPy9bF4Zz2O0Q+PYpnYPHoW5yB/8LVVC
         dVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOk1AjwIVX9pqDuRbELOCa6z4G8rYwIr5B63rOLPi6w=;
        b=QA04E4k73ZJtj92axiBOk+KYqgXqWgFZ6IzjlP6IeDHmvZ/P/osYFnjJr8jkEbTfDI
         Th6D3+SB4ll19e6lvbvVz1Fr9znIzK7F4h6EZoitB+1iD18ZNu7d41L4JGWT4TpCKqui
         yTm6v0C2SkQ/QxKoV5GlJ1dYVU8cd6JislHxxxgj1A0AHc1amiPQTkoGhg1VyKyiEc0l
         SWG8pDYMRHmyyjQcncD4femhweIa+Tsh9bmzHxAhnbdJsZGD0UtjsB2SKbmZBw5VUE7p
         qhSz2ynhWNWNd7wDBQh2Q7Vykzsd7904Fcs7A4kCiQqgL9NGNyu50Ij15P4+H4ltoOPz
         1tUQ==
X-Gm-Message-State: AOAM532lr89lYjqIIZICbYIxEIlbAkcO1TkRimM+OMn5tAROetg2uNUx
        AYpT5+1M3mNpplIyO7YSj9pI1CBw9GOIJa0xn2APOf2p
X-Google-Smtp-Source: ABdhPJwafFKJN7/nW/YfpdDz6GBq+Lu04Yh1LmAOb61IjhGfURB/qgcTa/AMBwlAWsDw2vk5++ZSGS4R2gxsK5B101s=
X-Received: by 2002:a17:906:30c9:: with SMTP id b9mr61442ejb.377.1643998149504;
 Fri, 04 Feb 2022 10:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20220203201207.1075933-1-shy828301@gmail.com> <302fa562-612b-0853-31de-a11399e5aa08@nvidia.com>
In-Reply-To: <302fa562-612b-0853-31de-a11399e5aa08@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 4 Feb 2022 10:08:57 -0800
Message-ID: <CAHbLzko1izwBERS6auEna+eAGzQVA7zkDihMjT=tt_EBdhfmaA@mail.gmail.com>
Subject: Re: [v6 PATCH] block: introduce block_rq_error tracepoint
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 6:46 PM Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:
>
> Yang,
>
> On 2/3/22 12:12, Yang Shi wrote:
> > Currently, rasdaemon uses the existing tracepoint block_rq_complete
> > and filters out non-error cases in order to capture block disk errors.
> >
> > But there are a few problems with this approach:
> >
> > 1. Even kernel trace filter could do the filtering work, there is
> >     still some overhead after we enable this tracepoint.
> >
> > 2. The filter is merely based on errno, which does not align with kernel
> >     logic to check the errors for print_req_error().
> >
> > 3. block_rq_complete only provides dev major and minor to identify
> >     the block device, it is not convenient to use in user-space.
> >
> > So introduce a new tracepoint block_rq_error just for the error case.
> > With this patch, rasdaemon could switch to block_rq_error.
> >
>
> This patch looks good, but I've a question for you.
>
> We already have a tracepoint for the request completion
> block_rq_complete(). We are adding a new tracepoint blk_rq_error()
> that is also similar to what blk_rq_complete() reports.
> Similar call sites  :-
> trace_block_rq_complete(req, error, nr_bytes);
> trace_block_rq_error(req, error, nr_bytes);
>
> The only delta between blk_rq_complete() and blk_rq_error() is
> cmd field for blk_rq_complete() in the TP_STRUCT_ENTRY() and
> __get_str(cmd) field in TP_printk() which I don't think will
> have any issue if we use that for blk_rq_error().

Yes, I agree. Just no user needs it for our usecase.

>
> Question 1 :- What prevents us from using the same format for
> both blk_rq_complete() and blk_rq_error() ?

Actually nothing if we ignore cmd.

>
> Question 2 :- assuming that blk_rq_complete() and blk_rq_error()
> are using same format why can't we :-
>
> declare DECLARE_EVENT_CLASS(blk_rq_completion....)
> and use that class for blk_rq_complete() and blk_rq_error() ?
>
> since if I remember correctly we need to define a event class
> instead of duplicating a tracepoint with similar reporting.

Very good point. I did overlook it. The original post did have disk
name and didn't have cmd, now the two tracepoints look much more
similar than the original post, so I agree the duplicate could be
combined into an event class.

>
> -ck
>
>
