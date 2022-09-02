Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C71E5AB131
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiIBNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238560AbiIBNGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:06:55 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8778EC4EF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:44:21 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j6so1283916qvu.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FkmxdR4Dcm/ujHCvCJBUmwMDqldmM2QaPxOVUhqd5sU=;
        b=nwgynCkLaT0WbqzOlHuhGd8cLVh200E8FMSzHg+pLoYA8EMt6a2OiBaQBIj8fF8cHt
         NQWMW9m/gU8mGEH4eveFvUfYLtGmt4GN7hYk5YOZwrxb4LxIrtWv/120thSossafRnvY
         6OkGGy6ons2+5+k5tSbJs823yu0dUz8poVuM7s7wF6zvDdK5GjSjPS/da5I4QDpqV91u
         h0L0zhXinzVbiLJX2gho0MzAE/yN0hsfShNHuCepx/dw2EqL5YFP+QmmTTSvYOQJzoUW
         Tn0B1Y7yiozzdnRKdFskSE6C03hTYjdt9I/mjSpjYZk3ThLnjz8vvNuWqKUF9XjiODDy
         /Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FkmxdR4Dcm/ujHCvCJBUmwMDqldmM2QaPxOVUhqd5sU=;
        b=4VbjGIsVq0fQPd2ZFnrGlJJ5gmroT9WAA+9Au4a+Ucu57SXdZ59tTVGJFEpnDoNJiT
         tCqSGqqVT0BJXah3gFjullsjh/nJvNwBsa/MvuAncRcriQbf5pDR7vie63kNcLMwAqf6
         mZoQZOOoV4nXER0m7g/1yGfZCEZhBBpZqRhmJjl97JVFtIoA9+/iu/6EinO2eSFWpeTN
         LKFw7/sJxIE0g2Z+xWe1x+vB1mxB6Ob2FkKmHAUOyXOIbU53oxOPi67shmMYDfbXdVve
         3KmnsDMAurt6F+X9LwAMrI07gq6EQaC1iN/RxZe7RivxqRQ5B6wqsIX++gUAlC/iT2Ze
         fD3A==
X-Gm-Message-State: ACgBeo369EALNQczydM/7Vj2VKbIGUcDdMzK4fOAm84cXZuVjtjm37qR
        b2wBd+L+lDI5xzRoYiS3MR3+oaSdrw5uNlSrHx8j/AIFj9uPrg==
X-Google-Smtp-Source: AA6agR4vUnoq3aiXV4dIHija42gBr47BtjEJpRqA6+YRDBu/g/jvJfB1iQ2moCzX3oWlauq5eW5f3lBXAH5brvsBnZs=
X-Received: by 2002:a1f:a289:0:b0:38c:5df3:40ea with SMTP id
 l131-20020a1fa289000000b0038c5df340eamr10092015vke.10.1662121950678; Fri, 02
 Sep 2022 05:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007d901905e6f23c23@google.com>
In-Reply-To: <0000000000007d901905e6f23c23@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 2 Sep 2022 14:32:19 +0200
Message-ID: <CANp29Y5f0YNsPSzeNao7_1a8WUJTNBZuLX1sDQGey_7qC2tKcw@mail.gmail.com>
Subject: Re: [syzbot] WARNING: CPU: NUM PID: NUM at mm/huge_memory.c:LINE split_huge_page_to_l
To:     syzbot <syzbot+2184d61af7d9d86337fc@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "'Aleksandr Nogikh' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>
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

#syz dup: WARNING in split_huge_page_to_list (2)

On Wed, Aug 24, 2022 at 3:02 AM syzbot
<syzbot+2184d61af7d9d86337fc@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    680fb5b009e8 Merge tag 'arm64-upstream' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=13d186a5080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4557ad2600fc45f4
> dashboard link: https://syzkaller.appspot.com/bug?extid=2184d61af7d9d86337fc
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c0bffd080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1217ce8d080000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2184d61af7d9d86337fc@syzkaller.appspotmail.com
>
> raw: 05ffc00000010801 0000000000000000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00000002ffffffff 0000000000000000
> page dumped because: VM_WARN_ON_ONCE_PAGE(is_hzp)
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 3026 at mm/huge_memory.c:2555 split_huge_page_to_l
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000007d901905e6f23c23%40google.com.
