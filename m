Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54C49BCD9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiAYUTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiAYUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:19:20 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7EFC06173B;
        Tue, 25 Jan 2022 12:19:20 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id me13so33357266ejb.12;
        Tue, 25 Jan 2022 12:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkD++w5wQuM0pFdWNSxU+9PLuYMVyvi7yffqi+Pe620=;
        b=VpsFLJzitgnUe5tDPxu+bIcWmi2+SD6nhORlPdFdESwnxx9ResacUmvOFpe7kPCUe9
         hvagcDjvrn/v5+2KpABhX0FIcjk7AtiDIH2wlSDN4fGPQjhe5TZt6Wdi2aouwuYiXU0K
         zHBnE6/GXgiTIEtG1c07mXwu7vPWh9IalkW0av3RlBapsnzeS46V+gWZwtUSvCxBdKkY
         //3KLt9InWmM2lhDAX/vz79SlIbjN0rDHdWE4pvRPCymaXi6dvBNcVM9k7olMFGWP1yT
         8B5tbVgjXMdnvonSkKXes6Yn7UxEp7SItRS0O/A+EcIZqQWenwZUCJz2VFMx4zZSrJIN
         1RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkD++w5wQuM0pFdWNSxU+9PLuYMVyvi7yffqi+Pe620=;
        b=Fn7CkWckl8Lct662dCotALz329CscC6hfq0ukpmOEmj/o2/WwR9qfDeBsNP7lK1Io9
         GsB7WgJq87/X2Q3NkNhAufH2Cafxi3EHd/l0dF43RUaSVjoW2Iaj1GiPpQU0Xs5xDsKM
         3WAkCMt7i8QTxxSBLY18Rjuq1FlCH7ZZTwSS7PyJ3KnXVwNigz4mYX4P0apGfu3yq25N
         7fxUj9/+n7NUxK2dUUJbwPyvBfhxFLONQQSnB8Ri9cn78HuK27GW15QqT0Z4Z8/0p9xq
         eicH9TfA0LRKex0zNFKtcdYn0YS4y1j4PDjftQG/SIOBa2edOa+R+bSAGAZjWw/c+iqS
         LLgw==
X-Gm-Message-State: AOAM532DXR0ZzpwUyKkMrYBJu18EVreI7WLBVS41OqAq7SEHfUeXW5iX
        EgHC47fkgsvDIm5hmY5duAdyjJSLWx0h9I/VlCY=
X-Google-Smtp-Source: ABdhPJxJHR8hzUe4FytmweJ8fcXjxc0YkzwId6iLbh4Lm4OiGTzxJLOOHEl4Lv3fq+NlaZrNs0P9ioUlDiAO0Vx2v5Y=
X-Received: by 2002:a17:907:608b:: with SMTP id ht11mr17025374ejc.644.1643141958928;
 Tue, 25 Jan 2022 12:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20200203053650.8923-1-xiyou.wangcong@gmail.com>
 <CAHbLzkoUmhPbnt=yMfBSFs2G6r2S5ggD6AkYQvg0zxBAqQK2fA@mail.gmail.com>
 <20220125093702.3ffdb721@gandalf.local.home> <20220125093846.59826cad@gandalf.local.home>
 <CAHbLzkq51-_Rxj0YyWR4qxQRzosvP2Tj6D52=OtCZUG_mydDBQ@mail.gmail.com> <20220125150352.147d3c58@gandalf.local.home>
In-Reply-To: <20220125150352.147d3c58@gandalf.local.home>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 25 Jan 2022 12:19:06 -0800
Message-ID: <CAHbLzkrkvcnfxQqrAJosLZK_jOxErwGvn5VkLASNfut6_N-+0Q@mail.gmail.com>
Subject: Re: [Patch v3] block: introduce block_rq_error tracepoint
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:03 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 25 Jan 2022 11:58:10 -0800
> Yang Shi <shy828301@gmail.com> wrote:
>
> > Never mind. Other than the code restructure, I also found some data
> > structure (struct request) and function (blk_fill_rwbs) change. I
> > think I'd better rebase the patch to 5.17-rc1 then resubmit it. Since
> > there is no fundamental change to the patch, can I keep your
> > reviewed-by tag?
>
> Sure, but please Cc me.

Yeah, definitely. Thanks.

>
> -- Steve
