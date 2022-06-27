Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F3455C8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiF0Hmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiF0Hmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:42:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85A060D7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:42:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j21so15152378lfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5aCEp0ikpHdasUm3ZOwjExx0rx7L4GFT03C4LhIeUo=;
        b=g4k9FP05mCAeGlUQ0znUQnEHeKdOhlileDmpMNoNHjwTQG6z17dva3vLD2GDHUrl7R
         DQx+QoNLEUgIfj0voDfvym0DoLlvvpWHscJ96SdNe4AzFoWogdbCQ15zcTgjqgWMZ22b
         foyg4jhu1EtqNLSpMDPgz/MC1gOC5fsn6MkPllhel8AfWE6anqxlIHxBdjn/hEip5XOe
         XlpNp4IlsHzW8IU9afihMM7mjBnRP2tUvq41q0zZUrJqGUT0+ncVMYw6E+yEVQyjR00I
         nslInUjfsuZ/avh/xiSew70ioVSbetsYT5zOatzPBQTwfAgTKRpISC2v2kG+5cIVgf4D
         /mmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5aCEp0ikpHdasUm3ZOwjExx0rx7L4GFT03C4LhIeUo=;
        b=KjHBCCSZo6ZKqbkogwRvQLGgooDQ3NlHEvJ/iJLz6buD7jXk0zQk2h2eTE0g5rlMHp
         JznqUc2ry+8imIgoU6gEMD6N9pLjSRrUb5HQf5+ZsGg7sKlz+8H47bsmIAmbBHSwspKE
         47fQqMf+zCnC1dRc3noAZ3i/qxSZbExaVcCIkZmJe+aeuA8jiuK8BIwcmVLtONb8thNr
         /cCYKCZcv+8KztSDIUzppdXgQgLzXmPu+8OlnQMW+nTbLOVx7mobMpj/G33/NwcHN9kP
         Oh9CaVKytcKO1bfHOhjwXiUCpKYu+lfnOmcHhdfHy998jqNyu8h2XSecyBd7R+gUgmNs
         Bn9w==
X-Gm-Message-State: AJIora+nhqklj41fhatediDL+pp2y36GONeSo0hL72Zld2Lap8WUgc18
        ZpjSDWAGzQ+PnrRcn7UJ7IcXVHgouXF72a/DFhczFQ==
X-Google-Smtp-Source: AGRyM1uOBNKtt+ZduX7vM0bhh209MPU7VZsCZRicPbUVUzQMj9TBCgPs4E28F98J48K1Qbz0wCNrRPntGkZz6P0t110=
X-Received: by 2002:a05:6512:1056:b0:47f:6f00:66c2 with SMTP id
 c22-20020a056512105600b0047f6f0066c2mr7335308lfb.410.1656315752909; Mon, 27
 Jun 2022 00:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000dab76c05d0bc284c@google.com> <00000000000095e3d105e2553f0a@google.com>
 <CACT4Y+Yf4ckOJjGkkFh_HYEKDjQo34wN=q18ADbP3=vhd5eQJQ@mail.gmail.com> <YrlelmgGpTtBva/0@google.com>
In-Reply-To: <YrlelmgGpTtBva/0@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 27 Jun 2022 09:42:21 +0200
Message-ID: <CACT4Y+Zt1tc_wGak6T=ydnQp2-Bn+a+zqRhaoHV1Or79-OA=FQ@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in console_unlock (2)
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     syzbot <syzbot+0b7c8bfd17c00d016fb4@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, elver@google.com, glider@google.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        npiggin@gmail.com, pmladek@suse.com, rdunlap@infradead.org,
        rostedt@goodmis.org, swboyd@chromium.org,
        syzkaller-bugs@googlegroups.com
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

On Mon, 27 Jun 2022 at 09:39, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (22/06/27 09:11), Dmitry Vyukov wrote:
> > > syzbot suspects this issue was fixed by commit:
> > >
> > > commit faebd693c59387b7b765fab64b543855e15a91b4
> > > Author: John Ogness <john.ogness@linutronix.de>
> > > Date:   Thu Apr 21 21:22:36 2022 +0000
> > >
> > >     printk: rename cpulock functions
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ed359bf00000
> > > start commit:   aa051d36ce4a Merge tag 'for-linus-2022052401' of git://git..
> > > git tree:       upstream
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=6c31e1555a4c59f3
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0b7c8bfd17c00d016fb4
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a5aad6f00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d697c3f00000
> > >
> > > If the result looks correct, please mark the issue as fixed by replying with:
> > >
> > > #syz fix: printk: rename cpulock functions
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> >
> > I guess this is also:
> >
> > #syz fix: printk: add kthread console printers
>
> Dmirty, we have reverted console kthreads for the time being.

Will keep in mind that if these reports re-appear, it's fine.
