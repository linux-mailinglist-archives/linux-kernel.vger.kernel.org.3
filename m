Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F5C54B6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351635AbiFNQrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344352AbiFNQrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:47:19 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF21E29341
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:47:02 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id l204so16085550ybf.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XDk/gviZ4PTB0F4aeM/SYkP/gckoTZKcQotKkjmgkbU=;
        b=UVo7z7mq83OdvUMfv2zalYzpjivYTuojc8nrC14VtzHQxfO8kkrbOasAwYDGrmh0Kr
         TPWc0pt/+WTr1mK679VBnfsxfJSlmVDdvJ3irqhAxmkoAx4FZyftOa92c55uGWg46fGk
         TdeH+DwIPD6MdYHH/1Jk2bwZMF8Li/tN3dYF48d71K87UHk4aSTUsKGoVJ/WFX7QGdRI
         WUP6m+iWKKgwgI4iEZMZPYuix0X3vA0PE9jMY5DudkbQGiz+Y33Dbzk6rPJIk+Wro6vk
         D8eKjKUczvkIQmPIhuCy3K231YVzvYQ5+wSL6oRpyTUF/8ZI14KP36My6ida7g7SkjWH
         t5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XDk/gviZ4PTB0F4aeM/SYkP/gckoTZKcQotKkjmgkbU=;
        b=7BdfRMisppXJb2/AL2KplEzV+cKzToeHC+Z6a/eYlyDJd0TvEfwQtpgPrVFctCCght
         yTXb0lrmC/8jDBPAsnaUJyCEaVGFohl7xSrSNNGaEiWHPxR0DAwlljJxCHqEdYtSESx5
         QM30HCOnbwAwNyXXjwmz/WYOpdovLM3+LfsviY2cR5LUR5hcFbkAPwUgaJd/4bWp3ZRS
         1k+pbNOpG1yfBJWhmkNmA++nP0IBm41DYckD6389H1iqMp/EfvDy4J5tz5Zn/SKuh3hB
         PbjE7M0P+FvdJSqwlEURuU7wIvl7XD27B/rcXq/x1JgYGNLk8RIv1TofHbFsrC6HMeVC
         UvoA==
X-Gm-Message-State: AJIora9jArbTmpu9hkB66cv7qVjFspw5G3ghFlKmXHVrPs0FxB4o+rwT
        PmZLj2yjNwiXCRmYloTCDsp9NRS+pL9YkZHCx0s=
X-Google-Smtp-Source: AGRyM1v5cuCGYw9RPYwQDmZWRztbN8i22S3AMOZQ1Zdps8kxiWn7B6Dux4ERGYj+6pPK+GABe7xiCvTpqdRn6UHJIaE=
X-Received: by 2002:a25:4688:0:b0:664:68b5:e283 with SMTP id
 t130-20020a254688000000b0066468b5e283mr6098349yba.546.1655225221744; Tue, 14
 Jun 2022 09:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220613155612.402297-1-daeho43@gmail.com> <Yqge0XS7jbSnNWvq@sol.localdomain>
 <YqhRBZMYPp/kyxoe@B-P7TQMD6M-0146.local>
In-Reply-To: <YqhRBZMYPp/kyxoe@B-P7TQMD6M-0146.local>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 14 Jun 2022 09:46:50 -0700
Message-ID: <CACOAw_wjCyTmwusY6S4+NgMuLOZm9fwGfrvCT272GJ01-RP6PQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: handle decompress only post processing
 in softirq
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Daeho Jeong <daehojeong@google.com>,
        Nathan Huckleberry <nhuck@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
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

>
> Some my own previous thoughts about this strategy:
>
>  - If we allocate all memory and map these before I/Os, all inflight I/Os
>    will keep such temporary pages all the time until decompression is
>    finished. In contrast, if we allocate or reuse such pages just before
>    decompression, it would minimize the memory footprints.
>
>    I think it will impact the memory numbers at least on the very
>    low-ended devices with bslow storage. (I've seen f2fs has some big
>    mempool already)
>
>  - Many compression algorithms are not suitable in the softirq contexts,
>    also I vaguely remembered if softirq context lasts for > 2ms, it will
>    push into ksoftirqd instead so it's actually another process context.
>    And it may delay other important interrupt handling.
>
>  - Go back to the non-deterministic scheduling of workqueues. I guess it
>    may be just due to scheduling punishment due to a lot of CPU consuming
>    due to decompression before so the priority becomes low, but that is
>    just a pure guess. May be we need to use RT scheduling policy instead.
>
>    At least with WQ_HIGHPRI for dm-verity at least, but I don't find
>    WQ_HIGHPRI mark for dm-verity.
>
> Thanks,
> Gao Xiang

I totally understand what you are worried about. However, in the real
world, non-determinism from workqueues is more harsh than we expected.
As you know, reading I/Os in the system are critical paths most of the
time and now I/O variations with workqueue are too bad.

I also think it's better that we have RT scheduling like things here.
We could think about it more.

Thanks,
