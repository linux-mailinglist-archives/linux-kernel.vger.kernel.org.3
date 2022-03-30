Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE5E4EC702
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347176AbiC3OuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243105AbiC3OuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:50:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3EA27AD67
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:48:25 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y10so24691462edv.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skpWGuoRsn4zMngiALQtMeLWmhDG0oiVtHfiE27Pg1w=;
        b=p2lUG7YqGZv9FiSN4GaUHzyUJPq7MJAmitalRVTI8MoRD3rAWmvZZK0XyO1W7ndvXC
         EDN5nSMouDCTBFAsRR24B7f0RiVxAXea2PmG/6AbTE3AtnzvMu7TRx022Iw75OxsEgmh
         Qp1yFZ+uU4GWr82we4J0tu6LUoWAHNep1BJCjbP/v8Ch3nVx0CqYzq2KV++0rG86TE1o
         Pr/QcQcaUFhXs0SEsXTlFsWlxCpoIi8fz9vniK9wuAhy0zoREwevoWLKoqY93P+zqRmY
         YeDe71W10a9ed2HivKy+Gg7dJAbhMzpD0FJq6+d/7rPNGuvUMU7VRS8EOYFTWMZyDt+S
         Jdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skpWGuoRsn4zMngiALQtMeLWmhDG0oiVtHfiE27Pg1w=;
        b=cRJCSf6Yl8OZ1QZYQ9L5zLbfwkcBmPlYoV4ddoUCJtocZQ+2fWNB1PvectaWjet5Vx
         mGSbm4H8a4yk1byx8d9LclQVqzwYyRl3+JfjLtad5sADA1T0eZqaEBBT6Y/EhqSIDENG
         yGv1/O6ux6OViu23IvXgRTQW8n5wSq0ssZyvjutpC1CSDftp1ErVBf7tYNXEjRTflfWd
         iN8AXvQyWBu3j+kM5L+ZFFW2xaPFLH++i5uMLCYSD8nysqfiD5H2uuwQYYxWb8wyl/7m
         ZiNXsO5pNZI2wAYoL1+R9s3tQgVBD5k3BzxV9qhVNgT7xBNYLWxHp6VV/sQu7H2EvZP1
         6lfw==
X-Gm-Message-State: AOAM530lmFtbohoEEcvxHaqM4zPbK/44Jzzi14Cp+63hr/koHOR+s0cg
        Qli0fa0marS4NFlL9hcf1Co9n889Re3agDegsLF8S1V9YA==
X-Google-Smtp-Source: ABdhPJwykt5VjJKxTRmsrS2i2h+Iha+y6OyT1gjlYhXzWfLUBu1liGouA3aDoW1NcYW8z29RQzmqGDxmRlsCG3hJD3g=
X-Received: by 2002:a05:6402:350d:b0:419:547f:134a with SMTP id
 b13-20020a056402350d00b00419547f134amr11254035edd.405.1648651703736; Wed, 30
 Mar 2022 07:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <202203270449.WBYQF9X3-lkp@intel.com> <62426553.1c69fb81.bb808.345c@mx.google.com>
 <CAHC9VhRNuoPH6AySUbe6h2D6kghhezyVQtTAvm-t-fTpXH6XwQ@mail.gmail.com>
 <62427b5c.1c69fb81.fc2a7.d1af@mx.google.com> <CAHC9VhTLTQmHaka9tTyuu=rQOzpsn_K2NxfJ==7-6FSY3KnuFg@mail.gmail.com>
 <6243f1d7.1c69fb81.b19c7.7ec1@mx.google.com>
In-Reply-To: <6243f1d7.1c69fb81.b19c7.7ec1@mx.google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Mar 2022 10:48:12 -0400
Message-ID: <CAHC9VhTxACMG=V_J1OYy_7VjM3LjuNJcwJSf6om1eO8esCDAbg@mail.gmail.com>
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
To:     CGEL <cgel.zte@gmail.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        eparis@redhat.com, linux-audit@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 1:59 AM CGEL <cgel.zte@gmail.com> wrote:
> On Tue, Mar 29, 2022 at 09:11:19AM -0400, Paul Moore wrote:
> > On Mon, Mar 28, 2022 at 11:22 PM CGEL <cgel.zte@gmail.com> wrote:
> > > On Mon, Mar 28, 2022 at 11:06:12PM -0400, Paul Moore wrote:
> > > > On Mon, Mar 28, 2022 at 9:48 PM CGEL <cgel.zte@gmail.com> wrote:
> > > > > Sorry could anybody give a hand to solve this? It works well on x86_64 and arm64.
> > > > > I have no alpha environment and not familiar to this arch, much thanks!
> > > >
> > > > Regardless of if this is fixed, I'm not convinced this is something we
> > > > want to merge.  After all, a process executed a syscall and we should
> > > > process it like any other; just because it happens to be an
> > > > unrecognized syscall on a particular kernel build doesn't mean it
> > > > isn't security relevant (probing for specific syscall numbers may be a
> > > > useful attack fingerprint).
> > >
> > > Thanks for your reply.
> > >
> > > But syscall number less than 0 is even invalid for auditctl. So we
> > > will never hit this kind of audit rule. And invalid syscall number
> > > will always cause failure early in syscall handle.
> > >
> > > sh-4.2# auditctl -a always,exit -F arch=b64 -S -1
> > > Syscall name unknown: -1
> >
> > You can add an audit filter without explicitly specifying a syscall:
> >
> > % auditctl -a exit,always -F auid=1000
> > % auditctl -l
> > -a always,exit -S all -F auid=1000
> >
> I have tried this, and execute program which call syscall number is -1,
> audit still didn't record it. It supports that there's no need for audit
> to handle syscall number less than 0.
>
> sh-4.2# auditctl -a exit,always
> sh-4.2# auditctl -l
> -a always,exit -S all

If audit is not generating SYSCALL records, even for invalid/ENOSYS
syscalls, I would consider that a bug which should be fixed.

-- 
paul-moore.com
