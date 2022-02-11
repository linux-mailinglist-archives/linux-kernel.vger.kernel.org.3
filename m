Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B04B2EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353636AbiBKU5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:57:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353564AbiBKU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:50 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85C7B5;
        Fri, 11 Feb 2022 12:56:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id fj5so22388126ejc.4;
        Fri, 11 Feb 2022 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2jouqTSQ+t42GvGLV2muns7tD5a7TR40ov5yhzbkkU=;
        b=iGAWyvskKctE+9MuuqsiRfw67CfrNYyJiiHTtz3/Y6J6QnSQrQHMNZKSL3e2ecfor/
         HwVVi8EmiBjzsAl2ehwpmU207Ek8+1dSxzht2gGkGwx2JQZhgcprXi9za1PQxvEORrVy
         urNQcG7FKFxY9Aa88X+RX1+5o4IfD6fU0o92wZaJAgFdDQbcNQP9xKXfEEZJ7dk3IL3W
         u+ooglzQBDgdB3X9+82wbtkweslPkkr1Yx0Io2pFyim/QpofkHTztE7yN3YE5eEcqA7z
         xLzMXRrl4B+DqblJXWZOMJZOJvUHaF/92R+YdU5dsUCTYBKpS1FdpHWLrwf6dLnnGDzY
         zBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2jouqTSQ+t42GvGLV2muns7tD5a7TR40ov5yhzbkkU=;
        b=cJTrPTO/nxcjIfNSsBCmHeQt2urg9VkFTpIUlkoM14qs+MENg+jjPPFwTbgIsw8GtB
         1Ba8+6ANe8e2XYKaBOIykY6KoYEyDbeDss4lTrY84VknBH94Klm9K8xF9LRu5Krv6y69
         UNG/OTULIIxItXYhrEkmSIdHpeiBRdMjHtkGYK9qkkLT4KHKfmdPY71x041NcwtOs5gV
         nEEND2Pf/Ti1OT6l1sfWxX+bAbeEImPjooQ5tn47kY7vfN/g9FpOQI6imUsNxQtr7/Lp
         oVLUpmDsPYR8AHgEtcctdrAE29PDzWsTnwtNoIM2LEJPqGQ8CV+zkAywTvBQOX5wpwXa
         HvSA==
X-Gm-Message-State: AOAM530mDPI3aM4qxe3G7VzFTF+B9ZtxJDdQgaYDG5IOJi5/LuK18RQj
        lzZm3DjqiXjcsus///OKKmY46rynBlSPsFbJtqc=
X-Google-Smtp-Source: ABdhPJwEiTIL6PwDGZfsJZjuQPYcYtmYJS3djKYd+yZjH3sRDA41cQz4ql52LK5vrINOIUEkRJLHZB+d1ed7j+X6ioY=
X-Received: by 2002:a17:906:9259:: with SMTP id c25mr2971010ejx.239.1644612994355;
 Fri, 11 Feb 2022 12:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20220210225222.260069-1-shy828301@gmail.com> <164459883724.122482.1096803254957441815.b4-ty@kernel.dk>
In-Reply-To: <164459883724.122482.1096803254957441815.b4-ty@kernel.dk>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 11 Feb 2022 12:56:21 -0800
Message-ID: <CAHbLzkrNhPUjs+NE=e8-t9qOnDLkKeR5J_r2eQQdOarZhhGTFg@mail.gmail.com>
Subject: Re: [v8 PATCH] block: introduce block_rq_error tracepoint
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 9:00 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On Thu, 10 Feb 2022 14:52:22 -0800, Yang Shi wrote:
> > Currently, rasdaemon uses the existing tracepoint block_rq_complete
> > and filters out non-error cases in order to capture block disk errors.
> >
> > But there are a few problems with this approach:
> >
> > 1. Even kernel trace filter could do the filtering work, there is
> >    still some overhead after we enable this tracepoint.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] block: introduce block_rq_error tracepoint
>       commit: d5869fdc189f0f12a954a48d58a48104a2f5d044

Thank you!

>
> Best regards,
> --
> Jens Axboe
>
>
