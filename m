Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3114758F3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiHJVBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJVBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:01:10 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F697A525
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:01:07 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id c185so19148268oia.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BxpuIx4IgOUgHFmWtE+X6gZrBs6TxjXfhAzvNT/RIIU=;
        b=NIaFzgx4ewzLBbulDstovwS6BAvP95YoYx3iE7SSCEZKwMkFc7DGsFLVFKNUzgPFcN
         D9CLl8TY2inI8fmQQLpsLwriCPM7F/mUMiP8lt7KAP+lzkW3JAQz0g9CEpGagfiRfJWQ
         oWa/X66WCad3uuR1gOBCZssIxHliM66SB/mleOTxmWfIxnBT63tOugX8RHtdsPsp/xkO
         x2KhIasS7AHjNj2/kEyUycNfsmVY9Ep4AO5XZhssn1ZOyZFBRxXQC5hG91J90oeQ4oHb
         FRmfhtZe5qYHQ6Z9a2SWts8vTpEDzzcspCxGM2qXVIgMpg4j6BYJmpKQl+XQPnY1JWyq
         253Q==
X-Gm-Message-State: ACgBeo3VviJXTSifBFe1AmdjxrtbhceTJQoEQgvm7YqeVsW5yuqGVU/G
        AE18s0mmyQVIKhVFcSqk9iudGedNIdP5AxjQhcZLeVgTcCk7mw==
X-Google-Smtp-Source: AA6agR6fzNeEMNbxbN1S7uuYiJo1HpCLn1F+Wm2zLIs5zNYlMSvyBjuliEfRUF5A42r//HhU8qxq7IB6PRYE9eb9Xyc=
X-Received: by 2002:aca:ba86:0:b0:33a:c6f7:3001 with SMTP id
 k128-20020acaba86000000b0033ac6f73001mr2174005oif.5.1660165266978; Wed, 10
 Aug 2022 14:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220808175956.592707-1-namhyung@kernel.org> <7b1c463c-c912-ba08-bac4-99d45e45f7e1@redhat.com>
 <CAM9d7ciPHi27JwcCbCWAkHnFBn-6PRbpRjBJ1U=cfDN-UcthjA@mail.gmail.com>
 <eb01385f-4860-6394-ade5-518e12f70287@redhat.com> <CAM9d7ch19LdYceFFmKEd3=tPU53xEMHtUiarv9CTXxaCLKHTtQ@mail.gmail.com>
In-Reply-To: <CAM9d7ch19LdYceFFmKEd3=tPU53xEMHtUiarv9CTXxaCLKHTtQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 10 Aug 2022 14:00:56 -0700
Message-ID: <CAM9d7ciyy1kU9rApr3vNKeMGQQOcDMfZaU6nAZpLWJ1=YHDwDQ@mail.gmail.com>
Subject: Re: [PATCH] locking: Add __lockfunc to slow path functions
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 4:37 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Aug 9, 2022 at 4:09 PM Waiman Long <longman@redhat.com> wrote:
> >
> > On 8/9/22 17:13, Namhyung Kim wrote:
> > > --- a/arch/x86/include/asm/qspinlock_paravirt.h
> > > +++ b/arch/x86/include/asm/qspinlock_paravirt.h
> > > @@ -36,7 +36,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
> > >    *   rsi = lockval           (second argument)
> > >    *   rdx = internal variable (set to 0)
> > >    */
> > > -asm    (".pushsection .text;"
> > > +asm    (".pushsection .spinlock.text;"
> > >          ".globl " PV_UNLOCK ";"
> > >          ".type " PV_UNLOCK ", @function;"
> > >          ".align 4,0x90;"
> > >
> > That is what I meant. However, you should also a comment saying that the
> > use of .spinlock.text section is equivalent to the use of __lockfunc on
> > an equivalent C function to make it clear. Also add the __lockfunc to
> > the pseudo code in the comment section.

FYI I had to use __PV_CALLEE_SAVE_REGS_THUNK to pass the section name
(".spinlock.text") to prevent a build error.

  CC      kernel/locking/qspinlock.o
/tmp/ccdn2Gyk.s: Assembler messages:
/tmp/ccdn2Gyk.s:725: Error: changed section attributes for .spinlock.text

Thanks,
Namhyung
