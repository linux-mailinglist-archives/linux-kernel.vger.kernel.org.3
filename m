Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5085523BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345759AbiEKRmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345744AbiEKRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:42:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A27237276
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:42:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j6so5480271ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPRBvvBW0lETz5m8YN39fLl5gQS2Sga9Keu000AT3pU=;
        b=UgsIpw2ht5hPvVl099BLiCTT08ScStzT8c+FWysbU/Oy86z0w/uXgvQmDAbrMrlZGp
         32M+oWHwDOkmTg6SHbcv/oXEJ0MJdTVAVh/ePYx9g5bOD6ZGeqIGFzfzNDU5F1MuRwV2
         /mtUwL9J1sDC06DI+Q5uj5uScoyb2AKsRly0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPRBvvBW0lETz5m8YN39fLl5gQS2Sga9Keu000AT3pU=;
        b=T0nWj24l2j+/iGzY28erp6tQfdgbow3wDKBi+NNySLnkEktxUZ0nDDitWPZxVAu9bq
         ncnAKE5R2GUTvm+pDdmkvqfacZQCGEewHQzziTjfqUHICU1h5uYz6fEOZgg+fha9+pHI
         7wN6vZEBqcfOtIyqs7D8eb0XnqQVyf8WyafevCe7btcZfErMaf0lEUPn96FFVUz/vlbV
         RSf6y+Mlt+G8aoURSKdQPX15McnoDGAVdiFCQqzrzLbByTNSgSR2E6EkLxtMfW78PCP2
         uTJGY++uOJr50luS/PFUPxcmTvOAQGJKrCY0h3UCMeyoWAwHQrJnM4lrXevU6WRRPnTD
         gPOA==
X-Gm-Message-State: AOAM5306xgW93Q9haS33WOW9GlprmeDC+/musWobVunNKFXK4boCkQlB
        9ahLUAGZMsvNDZDzMWw0F45vCEk8yDTsL6xKw+s=
X-Google-Smtp-Source: ABdhPJzvOTwl4CWtDrQboMytm+mtwDiRIZvtBzMYKd+adsfK5k5hdulkwdR2QG9bqMhG+x+lo2oYlQ==
X-Received: by 2002:a17:906:7d5:b0:6f3:a6a5:28c6 with SMTP id m21-20020a17090607d500b006f3a6a528c6mr26238977ejc.11.1652290958982;
        Wed, 11 May 2022 10:42:38 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id v3-20020a170906564300b006f3ef214e3esm1204803ejr.164.2022.05.11.10.42.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:42:38 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id a5so208543wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:42:37 -0700 (PDT)
X-Received: by 2002:adf:dfc8:0:b0:20a:d256:5b5c with SMTP id
 q8-20020adfdfc8000000b0020ad2565b5cmr23591245wrn.97.1652290957387; Wed, 11
 May 2022 10:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <CANpfEhOnNZa5d_G3e0dzzbbEtSuqxWY-fUCqzSiFpiQ2k0hJyw@mail.gmail.com>
 <CAHk-=wjfecvcUk2vNQM1GiUz_G=WQEJ8i8JS7yjnxjq_f-OgKw@mail.gmail.com>
 <87a6czifo7.fsf@email.froward.int.ebiederm.org> <CAHk-=wj=EHvH-DEUHbkoB3vDZJ1xRzrk44JibtNOepNkachxPw@mail.gmail.com>
 <87ilrn1drx.ffs@tglx> <877d7zk1cf.ffs@tglx> <CAHk-=wiJPeANKYU4imYaeEuV6sNP+EDR=rWURSKv=y4Mhcn1hA@mail.gmail.com>
 <87y20fid4d.ffs@tglx> <87bkx5q3pk.fsf_-_@email.froward.int.ebiederm.org>
 <87mtfu4up3.fsf@email.froward.int.ebiederm.org> <87r150ug1l.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87r150ug1l.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 11 May 2022 10:42:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUy_cuJsVeob4zDnK5sWpE3U2EjVbnR2xobqgx7DOp4g@mail.gmail.com>
Message-ID: <CAHk-=whUy_cuJsVeob4zDnK5sWpE3U2EjVbnR2xobqgx7DOp4g@mail.gmail.com>
Subject: Re: [PATCH 8/7] sched: Update task_tick_numa to ignore tasks without
 an mm
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:37 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> With the change to init and the user mode helper processes to not have
> PF_KTHREAD set before they call kernel_execve the PF_KTHREAD test in
> task_tick_numa became insufficient to detect all tasks that have
> "->mm == NULL".  Correct that by testing for "->mm == NULL" directly.

If you end up rebasing at any time for other reasons (I didn't even
check if you keep this series in a public git branch), please just
fold this fix into the original commit, so that we don't have
unnecessary bisection issues.

               Linus
