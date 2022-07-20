Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F8757BF00
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiGTUKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGTUKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:10:50 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBE522519
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:10:49 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id v185so15174768ioe.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 13:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZbB9VnKGJLInuj72DJYZA8o4PYITUT0S6KGJae4KPqw=;
        b=D3g2EvZhuWnUXeQaneJXywswhO2BPfAAtNguy0zp2A5RQItolJnZk+5TXzZbLv22J1
         mgwTY9bypAkjnMaz34meIe4XYXvZEnmOoomJmHTnzEgxrk6NXJG1vrRNb9e847rKDeV8
         qxxOp4Gc5r/Gs0OLVXncyreX8GBO7cxWV65zKQ4bGnac+El3rxT+tWLiEf0ZHBsJHYlR
         6SkBlISbeozFHbHXgBEnh4FCjPST5VEvVPQ7B9cg9z6F+dcDc0MFObTNzM/boZagIwGf
         pDxWTHY+8z+Zw/nICI4UG50b1mcX2d/9YMN8DrFDX7ZuNLaGsOnKrL/fptVQs6Xbi7xg
         +Ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZbB9VnKGJLInuj72DJYZA8o4PYITUT0S6KGJae4KPqw=;
        b=suweBlkDLYqUEw1J35yQCPYBx5zWvaadCJyt0mJti6WkGDK+lx11fDfbPRevj7D5Mr
         +7wGRqp0YCmjgnNA0Sf7Hg5Y3oBW2HtYkPgqIf7/1l2aUFtAdRym3eOvpSL36aJy90Jo
         t30fGQ7h3FsybkOcalV9Srl/Ffs0rKLPkWyC5XA5+8hk2ANrgk1RZPLu+UCCVyrk9YY4
         cOzjeqXINHINAPAM6IGRSjux+Gk+Gge3jkRl/A9UDS+P5i+sTY4BVjk+P88PLpeWiz/G
         RuXcYCvGfSk6e3sBUbe6EdA6jCszF/ooEkRLEusZw86A/YS6U2u96b2+f9dO7RnyfAO3
         iNxA==
X-Gm-Message-State: AJIora/9qH2mkObnGmD1+3XJOSoaSDjyEll52RyFi/QMxyTuA88955KD
        hQTL/YzOvA+GA+KWXv/cwii68Ekuqda58G15OEAzPQ==
X-Google-Smtp-Source: AGRyM1vzHpiGlGt2/iCzYwHXXGPDjI8Pd2dtU3rTuyBSy1cuI2Exos8o8s6qqTFWtm7HAQDTBB7j+C6oDcLY75bACzY=
X-Received: by 2002:a02:c812:0:b0:33f:4812:4699 with SMTP id
 p18-20020a02c812000000b0033f48124699mr19570572jao.314.1658347849186; Wed, 20
 Jul 2022 13:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220719195628.3415852-1-axelrasmussen@google.com>
 <20220719195628.3415852-3-axelrasmussen@google.com> <D43534E1-7982-45EE-8B16-2C4687F49E77@vmware.com>
 <CAJHvVcigVqAibm0JODkiR=Pcd3E14xp0NB6acw2q2enwnrnLSA@mail.gmail.com>
 <D8D7C973-1480-4166-86AF-AD179873B2A4@vmware.com> <YtdpQBrAGJwMnssj@xz-m1.local>
 <3C93275E-B3B8-45CA-808E-0C163DBBB32F@vmware.com>
In-Reply-To: <3C93275E-B3B8-45CA-808E-0C163DBBB32F@vmware.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 20 Jul 2022 13:10:13 -0700
Message-ID: <CAJHvVcjs_=vbUbXcm1_vAxatEu9inqkVo_geX7pcW1XqWF=gJw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 10:42 AM Nadav Amit <namit@vmware.com> wrote:
>
> On Jul 19, 2022, at 7:32 PM, Peter Xu <peterx@redhat.com> wrote:
>
> > =E2=9A=A0 External Email
> >
> > On Tue, Jul 19, 2022 at 11:55:21PM +0000, Nadav Amit wrote:
> >> Anyhow, I do want to clarify a bit about the =E2=80=9Ccross-process su=
pport=E2=80=9D
> >> userfaultfd situation. Basically, you can already get cross-process su=
pport
> >> today, by using calling userfaultfd() on the controlled process and ca=
lling
> >> pidfd_open() from another process. It does work and I do not remember =
any
> >> issues that it introduced (in contrast, for instance, to io-uring, tha=
t
> >> would break if you use userfaultfd+iouring+fork today).
> >
> > Do you mean to base it on pidof_getfd()?
>
> autocorrect? :)
>
> I did refer to pidfd_getfd() as a syscall that can be used today by one
> process to control the address space of another process. I did not intend=
 to
> use it for the actual implementation.
>
> > Just want to mention that this will still need collaboration of the tar=
get
> > process as userfaultfd needs to be created explicitly there.  From that=
 POV
> > it's still more similar to general SCM_RIGHTS trick to pass over the fd=
 but
> > just to pass it in a different way.
>
> There are also some tricks you can do with ptrace in order not to need th=
e
> collaboration, but they are admittedly fragile.
>
> > IMHO the core change about having /proc/pid/userfaultfd is skipping tha=
t
> > only last step to create the handle.
>
> Yes. The point that I was trying to make is that there are no open issues
> with adding support for remote process control through
> /proc/pid/userfaultfd. This is in contrast, for example, for using io-uri=
ng
> with userfaultfd. For instance, if you try to use io-uring TODAY with
> userfaultfd (without the async support that I need to add), and you try t=
o
> monitor the fork event, things would break (the new userfaultfd file
> descriptor after fork would be installed on the io-worker thread).
>
> This is all to say that it is really simple to add support for one proces=
s
> monitoring userfaultfd of another process, since I understood that Axel h=
ad
> concerned that this might be utterly broken=E2=80=A6

Mostly I was worried it would be nontrivial to implement, and it isn't
a use case I plan to use so I was hoping to ignore it and defer it to
some future patches. ;)

But, if it "just works" I'm happy to include it in v5.
