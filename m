Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA61B538D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245112AbiEaJOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiEaJOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:14:18 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4238A328
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:14:17 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id m26so3247029ljb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OVCYgnsO9VXl16r4mJF3rP7SyoUZlqXKC/WkfdR69g=;
        b=IxMvO2t21VERLlSdrkYYqyhbafynN+JdXxRfPRaHs6HlX74d9/yOVOADN5kTCiot21
         0IMp6fqZVuZMS0IEunaEfFezW/0I+sNne8Mrko8HpoQRlYPolzW1q8eShNKCmsDIyJN/
         GQIvYIRJiiaunondXzFA8/WVkbiu4GYCG7/ewtlBZLs4wakX719AbAtsOQCyUoDFCW1a
         eeG3gfAnSx5rSelHxnEPKg+9X2u/jJhbYfTm08NsFDhhmM5kH//WSdNTrJ3A6zvwzHTX
         h5Tv35LSNgGm8wd/Qpnywp3VHpX6i1LesCW1Fl+AuUwLY84vScRuasvZDmzEka69CBbM
         Srcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OVCYgnsO9VXl16r4mJF3rP7SyoUZlqXKC/WkfdR69g=;
        b=Xw2be++NOPxSBpwD3zAcB4DfvY78dIRQJjZnuk0J/dQvxd44kFhk6/3KGsTAbRsBxM
         mEAtjrySLUU85bumQQob1xYpqyhqTF0IfRfe5yjZZJuUt8PbqgGMw/q8mqdyLDJ+t8zZ
         87/SjlpYeRq687RVFW5zXkFmGpjf7kunzkXgay+Lj4oSc+LNjoiD5SSNwj+hNt+lJus/
         X2niQTcG9UC5kbGCIsXvG4OcLEmEqo04V4+fts6IwKRakJsatsvuMuxDFXKYXe+N/xD3
         0BFdVFJuUh0qgcwVSl4AKL8PDL8uO3k/Or8Zb15xKptmBO37Q45cutIVMnWlICjXSxOg
         wrHA==
X-Gm-Message-State: AOAM5314ic3wwOjCaSMXnahYWaIcjGXEx1zKw8tQ0YBKQpROPS6se+b1
        ZdItRNHNJkTdG7y1vrgp9cnKQGNzloMERrSUeSlp+g==
X-Google-Smtp-Source: ABdhPJyuV+gxkk4LkVlziu4ujj3riLftL53ZxueuE2wl3swI6nn1fiyJkXzEaqwLINDRRBA/HoxZ3LJA6Yom9ycDV4Y=
X-Received: by 2002:a2e:90da:0:b0:255:4d38:f21e with SMTP id
 o26-20020a2e90da000000b002554d38f21emr6842287ljg.92.1653988455515; Tue, 31
 May 2022 02:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f0b26205e04a183b@google.com> <3d3c6b5f-84cd-cb25-812e-dac77e02ddbf@kernel.dk>
 <e0867860-12c6-e958-07de-cfbcf644b9fe@icloud.com> <bcac089a-36e5-0d85-1ec3-b683dac68b4f@kernel.dk>
 <CACT4Y+aqriNp1F5CJofqaxNMM+-3cxNR2nY0tHEtb4YDqDuHtg@mail.gmail.com> <7c582099-0eef-6689-203a-606cb2f69391@kernel.dk>
In-Reply-To: <7c582099-0eef-6689-203a-606cb2f69391@kernel.dk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 31 May 2022 11:14:04 +0200
Message-ID: <CACT4Y+bEKD7fREyiTst2oA7rjTz3u3LWLe23QmSBAQ=Piir3Ww@mail.gmail.com>
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

On Tue, 31 May 2022 at 11:07, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/31/22 3:05 AM, Dmitry Vyukov wrote:
> > On Tue, 31 May 2022 at 11:01, Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 5/31/22 3:00 AM, Hao Xu wrote:
> >>> On 5/31/22 16:45, Jens Axboe wrote:
> >>>> On 5/31/22 1:55 AM, syzbot wrote:
> >>>>> Hello,
> >>>>>
> >>>>> syzbot found the following issue on:
> >>>>>
> >>>>> HEAD commit:    3b46e4e44180 Add linux-next specific files for 20220531
> >>>>> git tree:       linux-next
> >>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=16e151f5f00000
> >>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ccb8d66fc9489ef
> >>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=b6c9b65b6753d333d833
> >>>>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >>>>>
> >>>>> Unfortunately, I don't have any reproducer for this issue yet.
> >>>>>
> >>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>>> Reported-by: syzbot+b6c9b65b6753d333d833@syzkaller.appspotmail.com
> >>>>>
> >>>>> ================================================================================
> >>>>> ================================================================================
> >>>>> UBSAN: array-index-out-of-bounds in fs/io_uring.c:8860:19
> >>>>> index 75 is out of range for type 'io_op_def [47]'
> >>>>
> >>>> 'def' is just set here, it's not actually used after 'opcode' has been
> >>>> verified.
> >>>>
> >>>
> >>> Maybe we can move it to be below the opcode check to comfort UBSAN.
> >>
> >> Yeah that's what I did, just rebased it to get rid of it:
> >>
> >> https://git.kernel.dk/cgit/linux-block/commit/?h=io_uring-5.19&id=fcde59feb1affb6d56aecadc3868df4631480da5
> >
> > If you are rebasing it, please add the following tag so that the bug
> > is closed later:
> >
> > Tested-by: syzbot+b6c9b65b6753d333d833@syzkaller.appspotmail.com
>
> Sorry, missed that, would be a bit confusing?

Why confusing? It tested it, no?

> 5.20 branch is rebased
> on top of that too. Can we just do:
>
> #syz fix: io_uring: add io_op_defs 'def' pointer in req init and issue
>
> ?

In most cases it will work. However, there is no way to distinguish
unfixed and fixed versions of the patch based on the title.
So if the unfixed version manages to reach all syzbot builds, it will
close the bug at that point. And then can start reporting duplicates
since the bug is still present. But practically unlikely to happen.
The tag allows to distinguish unfixed and fixed versions of the patch,
so it will work reliably w/o possible duplicates.
