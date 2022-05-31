Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA74538D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbiEaJHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbiEaJFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:05:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E00369C9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:05:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so4429395lfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXvtrwihxvcxSs1Fpbv4pO6ci42Kw2r2BvzhnZ4/XRo=;
        b=Kbi70PlsR5+i802aBEmHE5kSCiTflqXipOGStTJBs7NP5am4ttQBpDKSC/hOGNlPMy
         tPACEWG22DC0KB6dkW2WlKLfsmHkNVRPHWbE/zLJJWx5el74LNPkTotrhwwn+jf/+w/Y
         nI9YCvELVEYgAiGlLYRs9ySgxD2TmI+gHcAUgTPLzQeFscQYoNM7/VjJWdkwzo3NIOcX
         mzsG42+ToUxlCjQbQuf16n5Bu+kGWDNYuKQh/WS0dmuQ3Jh3mWuU72I03QvymNoF0SyD
         qAatat4lTj2CUpcFoeDWenrT2jU39J+m2GS7CDjezZpEtxdh2AOXtZj2p6bztXsThp0y
         swZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXvtrwihxvcxSs1Fpbv4pO6ci42Kw2r2BvzhnZ4/XRo=;
        b=IcH8G/fwM2iXKIk7DJvu97Sx2VR7R1lCfc5o0MYX6SsH8TxiQE4vKiCP+qizkkmeZc
         lPoDo2zjJKdTeqgrLucJSxSSQHDJkwjFrJPsrC8H0O+OzXUHjPlellewD0Aee9NMPQCP
         b7s+O+bs4GP/qYlAX0H11P1iSJVfWyWBYu32tZTJOqafIvtVnSZLaMnr/5sUvXDRy/y1
         eC70xolzrEAbh6C6CltI79z5VquesZrlXHKRZa4qpX1vpoXZtH3DbND/arYrTV7bILaW
         +JVzPrWx7ViqcLpg7TPWbp0q3nrnWvDmt0gYH84VFedr3rv0wedUdaB6HaWVdA2o3FYW
         cv4w==
X-Gm-Message-State: AOAM5328B5f3jPz1ZS7Uspuv2rrGkwifZyNQWeV36m3DpMOKeZDZaTxb
        kXGVxfEff00DAC9BQZ473+B6kC37V5q3hODOpxUuMQ==
X-Google-Smtp-Source: ABdhPJyz4e5cRckDm7lj2o7+M7mpbQaJQjZ1zy5BPi7XX0n8/aXbBoNj0soqbvW3QipRoCJ+q/B25+ibJO1Blaun0Ys=
X-Received: by 2002:a05:6512:1156:b0:478:79b1:583c with SMTP id
 m22-20020a056512115600b0047879b1583cmr29681645lfg.206.1653987929308; Tue, 31
 May 2022 02:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f0b26205e04a183b@google.com> <3d3c6b5f-84cd-cb25-812e-dac77e02ddbf@kernel.dk>
 <e0867860-12c6-e958-07de-cfbcf644b9fe@icloud.com> <bcac089a-36e5-0d85-1ec3-b683dac68b4f@kernel.dk>
In-Reply-To: <bcac089a-36e5-0d85-1ec3-b683dac68b4f@kernel.dk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 31 May 2022 11:05:18 +0200
Message-ID: <CACT4Y+aqriNp1F5CJofqaxNMM+-3cxNR2nY0tHEtb4YDqDuHtg@mail.gmail.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in io_submit_sqes
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hao Xu <haoxu.linux@icloud.com>,
        syzbot <syzbot+b6c9b65b6753d333d833@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 at 11:01, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/31/22 3:00 AM, Hao Xu wrote:
> > On 5/31/22 16:45, Jens Axboe wrote:
> >> On 5/31/22 1:55 AM, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    3b46e4e44180 Add linux-next specific files for 20220531
> >>> git tree:       linux-next
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=16e151f5f00000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ccb8d66fc9489ef
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=b6c9b65b6753d333d833
> >>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >>>
> >>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>> Reported-by: syzbot+b6c9b65b6753d333d833@syzkaller.appspotmail.com
> >>>
> >>> ================================================================================
> >>> ================================================================================
> >>> UBSAN: array-index-out-of-bounds in fs/io_uring.c:8860:19
> >>> index 75 is out of range for type 'io_op_def [47]'
> >>
> >> 'def' is just set here, it's not actually used after 'opcode' has been
> >> verified.
> >>
> >
> > Maybe we can move it to be below the opcode check to comfort UBSAN.
>
> Yeah that's what I did, just rebased it to get rid of it:
>
> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.19&id=fcde59feb1affb6d56aecadc3868df4631480da5

If you are rebasing it, please add the following tag so that the bug
is closed later:

Tested-by: syzbot+b6c9b65b6753d333d833@syzkaller.appspotmail.com
