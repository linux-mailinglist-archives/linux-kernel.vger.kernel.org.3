Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD08150C9D1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiDWMQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiDWMQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:16:50 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DAE229ED5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:13:53 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id m11so1155442oib.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=814BnvISD/lQpTp8ydpSYIHXPoZ1ZdzgcZRghF12aQE=;
        b=BdhSrTXzc/rfFi9u+CfIQje2e5mED29PXqZL78GOrirT6WYfAEXb7F2sNKnHDwC89V
         1RCvgsJyV42pD1de4r5+2xRerdF2GIkL4Wh6B6tY9IEQ+cvU68KHn0OvrkE0wGA/Obv+
         GdwIOE3t6C9Q2dgKByUdd1CE9iKSRbYSDAxg9E5OUnhDf9tXHw/UBlISHPJPAP7uToYB
         9j9J8A7+lZHSfwOnJgjcd9Vo9oI3BwZgoDoeA6gJ7DQsePD5r8AVpNQ5p+3ARNxb8kbd
         uWnA7jxnVK+MDSSGxJD/Y5tTa9Wi7603S15i6HsIYMTij3QuqRDQpecoEkfrOi4Hc3EE
         aY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=814BnvISD/lQpTp8ydpSYIHXPoZ1ZdzgcZRghF12aQE=;
        b=giGXc57jvM5/rFa8CGa2R0wjjdZnp0q8/bgCI4d064f3Y6U4chU887u2AX2N7U7BFf
         JECYiq8nEqUZF5RTR9UIhwgngf9g9oB1DVcE+QW+NvQSb/yxbMKpNTSj1pcRmg3chzgR
         rGRYicdP87vsXFt/yUC8Oz50m3CG9pvbuAQh7adLVJyzwCveC231hykz/hpwO3W62cYy
         hF+n6CioRABgTWNezVhaZJdcLTvc/0yjWfbAN0ug0gHrejKIRn8jJTHQ9c0zkcXqqQoC
         LnlZthTxn+SHfizHH0zx3ImY0F2+myJnT1KJ/5F5JqdgIOXm2KHQajUFrONuyGOqF202
         gz/w==
X-Gm-Message-State: AOAM5322pr4zZmvkXj8jHC+iSRpgF+nAd+7trNaf7PZ4G75plhnFdmKD
        0sQ56DU1OD5OFKOOMkB7J7Nl+vov4uvkPpBUm4Zm9w==
X-Google-Smtp-Source: ABdhPJyxlJjQyztYwIaim7Uibo0wr+M45gxVbikLvfl8HcQWbrAUKGngYzgeZbVjMNevm75Mf/xd+7YKTgWNqLoCFVk=
X-Received: by 2002:a05:6808:16a4:b0:2f7:1fd1:f48 with SMTP id
 bb36-20020a05680816a400b002f71fd10f48mr4377426oib.163.1650716032697; Sat, 23
 Apr 2022 05:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000033acbf05d1a969aa@google.com> <000000000000ec946105dd42bcd6@google.com>
In-Reply-To: <000000000000ec946105dd42bcd6@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 23 Apr 2022 14:13:41 +0200
Message-ID: <CACT4Y+ZuuRUQXKOuAsrdx9oDqp1T1hBxeGg-imCcNkFPJdAonw@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in bpf
To:     syzbot <syzbot+cecf5b7071a0dfb76530@syzkaller.appspotmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        jiri@nvidia.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, leonro@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 20:53, syzbot
<syzbot+cecf5b7071a0dfb76530@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 0708a0afe291bdfe1386d74d5ec1f0c27e8b9168
> Author: Daniel Borkmann <daniel@iogearbox.net>
> Date:   Fri Mar 4 14:26:32 2022 +0000
>
>     mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1499c6fcf00000
> start commit:   1d5a47424040 sfc: The RX page_ring is optional
> git tree:       net
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
> dashboard link: https://syzkaller.appspot.com/bug?extid=cecf5b7071a0dfb76530
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176738e7b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b4508db00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls
