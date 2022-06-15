Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD02954D0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358377AbiFOSIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358174AbiFOSIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:08:32 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC722CDDF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:08:30 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id i186so12503347vsc.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bifXozJGbo2KT995FRrx29MncDAj30k/nMYRikNI7Us=;
        b=k67Cqug/KGcfDfJvUGzGpDoRMkM0wQGv3NOMJFcL85FnMSa/n+LmSaJrbs8kgHdf/+
         0AhX+ZANP6ffNUhunuMIwTOc0dHv9naqexOTZFgK7Gmbgjvo1Oe7KoaiPAqPoZdfwAIM
         SdKZNTFvMfU9hqOlDyKaCAUaawN2yJjBYfQowfwnsZ30l6I6IzRyUB5QJGx1qCb/w7yx
         kUaSet8RG8bneb51mfOK8eEUq7HDBM5l4TwNBU2IWwkPs80mgMwQZPx26uKoHWQVUfqV
         ka9aYYCNP5aqGB1zHAdqhuetl5szBdwsuiwefa/98RZ/uoq43Mm1VzzXpfi3zSc4Mut5
         /+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bifXozJGbo2KT995FRrx29MncDAj30k/nMYRikNI7Us=;
        b=xou/4PduOhbZtY1FyuXNf+vc9xVYoJU3lclb/4tL0Pf//uaStWWRXnLxWwC+H0T5+X
         dRZ2nAIcZVfv495u4yqJUkuIUH1J5TSpjM2aES1cOcdQyIepfEWsekrbqZfZti1ZI2Zu
         M2PEiueiW6BHRnJekziyQLAW2G3kGAsYd9Qd2j3pnhT9g0T2g0n8S48f1FFjc2t9wRaZ
         ovGqilCCWk6r+VO53iGJcPlL5vvR77TVqiorusvVCbL/CdXU+F67D8OvmKyqb4TgU1K1
         xcBAasN50g1T5iSJSHXh2lpCfGp51bkSrZATjD87hB2Iwg0GvvD67CQABcE3ucIE7qWB
         1qzQ==
X-Gm-Message-State: AJIora/dVhHJlGIbm+XNzpAfeTvr3d/CqFNhHmQxwOhBfXlYXhEuwVXo
        2Qu6S1Aze5fbLHgskUQeETpfL2HRbzXI1HTjjBTabg==
X-Google-Smtp-Source: AGRyM1vm4MUmXMdIsm7m17iINrr4Dp60T17s5/so7x4+sgCh08nPSiYN7VN7nJSpqFOJcZkWGdPRZwQ/W1Hg5KzJEWA=
X-Received: by 2002:a67:f3d0:0:b0:34b:b52d:d676 with SMTP id
 j16-20020a67f3d0000000b0034bb52dd676mr520254vsn.6.1655316509460; Wed, 15 Jun
 2022 11:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com> <20220504011345.662299-13-Liam.Howlett@oracle.com>
 <Yp3udPy0vuDK8khc@qian> <20220606161940.fh5edq5nyz4jru2u@revolver>
 <Yp4uD8uWB3rit/Ee@qian> <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
 <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com> <20220615142508.mtp65w6tdiurtvcn@revolver>
In-Reply-To: <20220615142508.mtp65w6tdiurtvcn@revolver>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 15 Jun 2022 12:07:53 -0600
Message-ID: <CAOUHufaoZ99qkBfsRWwCAx6fspL5KJYgCGe=nOVR07_2dF6URQ@mail.gmail.com>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Wed, Jun 15, 2022 at 8:25 AM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Yu Zhao <yuzhao@google.com> [220611 17:50]:
> > On Sat, Jun 11, 2022 at 2:11 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Mon, Jun 6, 2022 at 10:40 AM Qian Cai <quic_qiancai@quicinc.com> wrote:
> > > >
> > > > On Mon, Jun 06, 2022 at 04:19:52PM +0000, Liam Howlett wrote:
> > > > > Does your syscall fuzzer create a reproducer?  This looks like arm64
> > > > > and says 5.18.0-next-20220603 again.  Was this bisected to the patch
> > > > > above?
> > > >
> > > > This was triggered by running the fuzzer over the weekend.
> > > >
> > > > $ trinity -C 160
> > > >
> > > > No bisection was done. It was only brought up here because the trace
> > > > pointed to do_mas_munmap() which was introduced here.
> > >
> > > Liam,
> > >
> > > I'm getting a similar crash on arm64 -- the allocator is madvise(),
> > > not mprotect(). Please take a look.
> >
> > Another crash on x86_64, which seems different:
>
> Thanks for this.  I was able to reproduce the other crashes that you and
> Qian reported.  I've sent out a patch set to Andrew to apply to the
> branch which includes the fix for them and an unrelated issue discovered
> when I wrote the testcases to cover what was going on here.

Thanks. I'm restarting the test and will report the results in a few hours.

> > BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> > Write of size 136 at addr ffff88c5a2319c80 by task stress-ng/18461
                                                       ^^^^^^^^^

> As for this crash, I was unable to reproduce and the code I just sent
> out changes this code a lot.  Was this running with "trinity -c madvise"
> or another use case/fuzzer?

This is also stress-ng (same as the one on arm64). The test stopped
before it could try syzkaller (fuzzer).
