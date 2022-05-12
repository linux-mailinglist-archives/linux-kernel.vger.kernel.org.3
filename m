Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4C524DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbiELNNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiELNNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:13:40 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257E4190D2E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:13:36 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso6579534fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9b8EZDyUoN0uQXXzMQaW4MgPF/CGPA5fxKw0eOOwKUw=;
        b=mPLsWmlqvgUCrE1gCj5V0tNTrtCPetOI3UpfETcDi3mzjSJBQ+JQgo0IBpMmgBdX+n
         nfMl26BZWWwZPwR4bjFGMvgeUz+sW4Vc5ZvM0VErE3mjMHfPiBFa+wrffTzioZaBCEXb
         +Jt4ip5oXZLmwFpoD8Xk1ErJy/YCAaM62qhjOZjCvLNYKzgdnAaupX0ozgoA5USwnyhi
         SE30KPvt3ura78f2niux1w9viHQkCbokfb/oYlmdy+Zm8PUg/bBINW4XyLMujxo7A6X8
         2kVsVoY9ND8JMA/+8XkMrBnCS1Esq9ni9/2731XU5B0Bw3tSrIRuH3QcjIaQXoS9+vpx
         iN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9b8EZDyUoN0uQXXzMQaW4MgPF/CGPA5fxKw0eOOwKUw=;
        b=qmgpNxkjRLYgfpBccvYYet7Qh5wd55mk/ZRJkxnUl0ujZ2zHWwJOZgM0zGs1cPku6W
         JOruBiN+d6kMNRANUAXCAHOZaPnnlBJL989xE77kx2XQ5cr64eyq+552z/76Whrh09mp
         n/lycmqag4sm3/1kyU/nOl0/ZPbwMWQpDbX2asJTdZiUx3vD9FQLCqELPCcfzW0UPEwS
         Mi+9YFluhCOrsMn6k31APy2UhVfNt2wYjBHHqZCf0njuhSHVL1jp5fW6R8RRv7lRsKiH
         NlozZnAcn/oPraJDGCxLEIm/ZrselpKLHLEViK+CdvX6DvO9AZ6IAVqcFVci5he1UCsf
         2JNQ==
X-Gm-Message-State: AOAM533AiTqjnlQf0ElEdwmW+PN6urC6IT32Y546/kUQZQXCw1jTPFHO
        ++IPJIV5YeAr0hRQx+9ubcF6+Pho4vSA/++Myn+7jw==
X-Google-Smtp-Source: ABdhPJxMxc7kko3AkZVfgGt5vvVL+nGl5Ndl+W4H9Y2j7zppHzfU9XW1TOayfygDx3RctO43yDSEZeUc5wS7rGVcfFQ=
X-Received: by 2002:a05:6870:b61e:b0:ec:a426:bab5 with SMTP id
 cm30-20020a056870b61e00b000eca426bab5mr5463201oab.163.1652361215217; Thu, 12
 May 2022 06:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c560bd05ad3c5187@google.com> <000000000000c7d07705d7c9b7a4@google.com>
In-Reply-To: <000000000000c7d07705d7c9b7a4@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 May 2022 15:13:24 +0200
Message-ID: <CACT4Y+aS6TpBVcFxW9h760J_PZN6nG+e_5oYMPtH7Sour4PJ3A@mail.gmail.com>
Subject: Re: [syzbot] WARNING in rtnl_dellink
To:     syzbot <syzbot+b3b5c64f4880403edd36@syzkaller.appspotmail.com>
Cc:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        fw@strlen.de, harshit.m.mogalapalli@oracle.com, hawk@kernel.org,
        jiri@mellanox.com, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        roopa@cumulusnetworks.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yajun.deng@linux.dev, yhs@fb.com
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

On Sat, 12 Feb 2022 at 04:24, syzbot
<syzbot+b3b5c64f4880403edd36@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit f123cffdd8fe8ea6c7fded4b88516a42798797d0
> Author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Date:   Mon Nov 29 17:53:27 2021 +0000
>
>     net: netlink: af_netlink: Prevent empty skb by adding a check on len.
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=107b5472700000
> start commit:   cd02217a5d81 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
> dashboard link: https://syzkaller.appspot.com/bug?extid=b3b5c64f4880403edd36
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116f8172900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1145d1b1900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net: netlink: af_netlink: Prevent empty skb by adding a check on len.

#syz fix: net: netlink: af_netlink: Prevent empty skb by adding a check on len.
