Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CBE4B8EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbiBPQ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:56:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbiBPQ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:56:46 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2007215A2C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:56:31 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2d0ede7dd9eso5589907b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEjX8mqvhweVPssQ3aADUg4sgNUOBaiUpJdvZM1UYNE=;
        b=MmdBO/3AvmjD6OfQEWzFtZWbpNSA/34GdDNHW1q668elbaJZYc+SFo57AjnPwoZPre
         eQAp39N5LlQ9DGD75Qqle3I3jkUYAhrQ6MmByH/dm7Ev6nFwIbvs+wOeCnncyIiTENb2
         l3k0FjBPw9rgXCIaVN369t4lehqENpt7ss3HFj3nIU1dCIcG/e+d8ZzhSOIdG3y9iloy
         fkH2oAg2E3MoPxr39nJx13ZTzdXg/p1hG/Vw65BGOHn81v9ItiMEAYeUN2l9LIKBR/Hi
         1NcS+mMX0bJKe/JCP6daWS8JzAfQEuX17ZyqKk50cFri0ID3xU/DL/Cuecz6xMSJ2mTK
         Hn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEjX8mqvhweVPssQ3aADUg4sgNUOBaiUpJdvZM1UYNE=;
        b=PWq8XRIT7fBRJv8YdD04R7VyK4KjbDkVgEglwpUFaxpWjcTlMGr2OdzFOOCLdq8mWm
         v4x2zxfyT7y2RWR4ddT339fBLCpKkBj/lKfVqqNIEOtM1aP0EqIWJbdHZwQFLrijtEYu
         zXtORRvfcE/UvAN37/FiMnhXfuf94a+uf+MtGY+F/g03aKZqbwOlZVsTObpyoyg/1oaE
         GWCTRF1QyRWc22P33tYUnqEo+8lJzFHO/VM3ByZuNo5P7O/I6dvy/s0nXtdVpMoZ55tK
         NYqj5T0QakhOZdM0uQ8YnsqgAt6myrzmc/aWaSMwcnaXRRE0YgFiiIkp43LT9XZLN4lP
         u52g==
X-Gm-Message-State: AOAM533f0HCBTXE1FeImMMZNptjCPhL1rNRaktWTph57taZAeeg2V9Wb
        QICC7KR/cBOewr3x/bFLB+aWGC94XEdBNB3xo0z/VA==
X-Google-Smtp-Source: ABdhPJxaNNCJQXu++II+pEhb4hfv3aCcqH6TivF5eQUKW/mkJhVxJAn7xmzhf5aL1uO66wrImJ9m1NqNdRfvCjozGDY=
X-Received: by 2002:a81:75c6:0:b0:2d0:cbf8:e7b3 with SMTP id
 q189-20020a8175c6000000b002d0cbf8e7b3mr3167890ywc.255.1645030589922; Wed, 16
 Feb 2022 08:56:29 -0800 (PST)
MIME-Version: 1.0
References: <20220216050320.3222-1-kerneljasonxing@gmail.com>
 <CANn89i+6Hc7q-a=zh_jcTn9_GM5xP6fzv2RcHY+tneqzE3UnHw@mail.gmail.com> <CAL+tcoBnSDjHk_Xhd_ohQjpMu-Ns2Du4mWhUybrK6+VPXHoETQ@mail.gmail.com>
In-Reply-To: <CAL+tcoBnSDjHk_Xhd_ohQjpMu-Ns2Du4mWhUybrK6+VPXHoETQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 16 Feb 2022 08:56:18 -0800
Message-ID: <CANn89iJTrH1sgstrEw17OUwC8jLBS9_uk_oUd5Hj0-FypTvvPw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: introduce SO_RCVBUFAUTO to let the
 rcv_buf tune automatically
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Wei Wang <weiwan@google.com>,
        Alexander Aring <aahringo@redhat.com>,
        Yangbo Lu <yangbo.lu@nxp.com>, Florian Westphal <fw@strlen.de>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Jason Xing <xingwanli@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 10:58 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> Just now, I found out that the latest kernel has merged a similar
> patch (commit 04190bf89) about three months ago.

There you go :)

>
> Is it still necessary to add another separate option to clear the
> SOCK_RCVBUF_LOCK explicitly?

What do you mean, SO_BUF_LOCK is all that is needed.
