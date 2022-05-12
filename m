Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE66524DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354236AbiELNMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354223AbiELNMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:12:36 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A579920F9F8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:12:29 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r1so6344876oie.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rz2PiOGCEL7PsJWor5rXsw1MmLIXNz9Ejq4MPyc3HFQ=;
        b=FxDvRqha4P2uGeagQFfAYHPWIi9SSbRFQqL60OTV4e0N05SXAS5ixk7BlsASCsT5Wa
         9jJX2vHxD1spL2NZiXZZVYsUiCzR/EQReGcybhe4G4Q7do1T9DVcCs0RXS3Klc9xgn+C
         Si6Rn4VLiTmiZn/nYBglaZn2gL+jXlBDeWNyLUffr3oO/APP/+Pg+juVR23iENB/DulQ
         Z43mZutHonjrRm2jipRw2J3VsaGA+Bb4AaibT9y3ZuaJU+cCBgvuSK9ywJs55ASpNSqL
         +z2KoiaoizgGhV1o4BOgErsQ0j/djG/YlOfGod73Z64GF7C/YHPVgZwNQE4Y27V95Cyp
         BHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rz2PiOGCEL7PsJWor5rXsw1MmLIXNz9Ejq4MPyc3HFQ=;
        b=MwptFh9ZCKicHRq1S7tg9+HvZgvjg87GO8QqzxHM+FGc6Nx1c55McZ4JGETh22yf03
         OFSORMK9teSLaZNqjVRx1aky3c2LaK+RDZ0W+KsqqqkhlrCAUQtpZ31wZrmTJ+icwBxb
         0M4oUrUBq3R6Tn0TEUuOKLQ/YOAXbY1PCTSMdixg6F0t0fpVCk+cynPvKfydt/2elh+U
         y0YbpGvsI0x/GbCEjKImWCoxILSxQuF9FL6Uv1yeRdSlYUxZFkZ0vWCxHUzFtUvPeqfa
         GXATzitUjJGWaGg5jO1TSsUj3j/JyB05A4qVIzBjlhz43p2RlJi8NMkT1fr90A0EWB0a
         Mp9A==
X-Gm-Message-State: AOAM532dZykhj5HclXi9NLPEQB5MrHKsJUJ3UdIvhqDOK9U2foe3pxJl
        Do3sHjDUTgHzZ1XED9CaEl14M4lNXhMIPC96bpSB2g==
X-Google-Smtp-Source: ABdhPJzEfwk4FlZsxuf8ufTZraPd57haaereC/38xN7Yn8dS20DhWKGc6/iTLeG1Wt9z/reNCWlWxoeQKkFbP0EmGRw=
X-Received: by 2002:a05:6808:16a4:b0:2f7:1fd1:f48 with SMTP id
 bb36-20020a05680816a400b002f71fd10f48mr5095017oib.163.1652361148815; Thu, 12
 May 2022 06:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000056c3e005b82689d1@google.com> <000000000000ed630705cb58a93b@google.com>
In-Reply-To: <000000000000ed630705cb58a93b@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 May 2022 15:12:17 +0200
Message-ID: <CACT4Y+a25frDABFk1Ra364UqgXLh=iUq8QbNmDr+ZsMEGpWZpQ@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in xfrm_user_rcv_msg_compat
To:     syzbot <syzbot+5078fc2d7cf37d71de1c@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, dima@arista.com, herbert@gondor.apana.org.au,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com,
        xiyou.wangcong@gmail.com, zoe.byrne@bpchargemaster.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sept 2021 at 21:29, syzbot
<syzbot+5078fc2d7cf37d71de1c@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 4e9505064f58d1252805952f8547a5b7dbc5c111
> Author: Dmitry Safonov <dima@arista.com>
> Date:   Sat Jul 17 15:02:21 2021 +0000
>
>     net/xfrm/compat: Copy xfrm_spdattr_type_t atributes
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b8aa69300000
> start commit:   a99163e9e708 Merge tag 'devicetree-for-5.12' of git://git...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7a875029a795d230
> dashboard link: https://syzkaller.appspot.com/bug?extid=5078fc2d7cf37d71de1c
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167c1832d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10214f12d00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net/xfrm/compat: Copy xfrm_spdattr_type_t atributes

#syz fix: net/xfrm/compat: Copy xfrm_spdattr_type_t atributes
