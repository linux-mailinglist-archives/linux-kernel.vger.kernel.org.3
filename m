Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B84523C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbiEKR7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345952AbiEKR72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:59:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE156FA29
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:59:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k27so3490553edk.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpvF/G4xuVb2lXY63PSPtbidovxryyw3Az5XWwC60vo=;
        b=RbK3zt9fAFVilHkcwWN9jceetynxrMvtlrXzPTlVar2ZD6mqSxmFHhHsJvVdGdj8oI
         BdUObZOYI75NcJ2SSDoRa5dgZGU0KHn4S4ony/g70hsqCPjT2fqxPmixaO08qir+9s1k
         sMGXhofMo+yhDn2YS7Eyv334cFNRehtrMjd18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpvF/G4xuVb2lXY63PSPtbidovxryyw3Az5XWwC60vo=;
        b=4kRnqRY7/D3hYL98N8feQJ+Xvbf8t/rsetILEVy2K/pZfuWEZEl/FtgsrBQPbYxxEA
         xPia7BVphGlb+1K7QHFb9WtLWKYdEKm2I/c7rzMrk08BuHQJKlyX294RUrf6I8YCfJUM
         NMsI6UjFvQ8RrQsATMW5f3Vpi8YpvnL9KlzVXk480ZU5Yi2jyXXFm4+mvI1MYv1GO2G1
         ipsULJcBwdBOJDsU2z73WUJFfPVS7+4FR71TWmhmuLxLPjiG3Gf9FEn8FEwBtIbZqZsh
         B0rftZnNVoCJRRWXHbupvkkQQddSuBUeMyhThv/NKcyNylP3swBfqVJzCVUZjhlIuovt
         ptGw==
X-Gm-Message-State: AOAM532cpMOJEsPg+foMQo3U6CqdmB6OkyGXJ/zPdNcOHoqk2/neJgfX
        6zT3C/qmGwSGNp+1KJvi2R+PXt0XnzsnH9632EE=
X-Google-Smtp-Source: ABdhPJxZFOVdeyeCTnq0I7hZUgkq3Cotg/sz93oOxDq151WE8TIyOxTWLOY8aKddFtcMaf6/co4cBw==
X-Received: by 2002:aa7:c418:0:b0:428:44a0:9967 with SMTP id j24-20020aa7c418000000b0042844a09967mr30668232edq.342.1652291965505;
        Wed, 11 May 2022 10:59:25 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b0042617ba63a9sm1436908edi.51.2022.05.11.10.59.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 10:59:24 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id q20so1680850wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:59:24 -0700 (PDT)
X-Received: by 2002:a7b:c8d6:0:b0:394:25ff:2de with SMTP id
 f22-20020a7bc8d6000000b0039425ff02demr5994279wml.154.1652291964221; Wed, 11
 May 2022 10:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <CANpfEhOnNZa5d_G3e0dzzbbEtSuqxWY-fUCqzSiFpiQ2k0hJyw@mail.gmail.com>
 <CAHk-=wjfecvcUk2vNQM1GiUz_G=WQEJ8i8JS7yjnxjq_f-OgKw@mail.gmail.com>
 <87a6czifo7.fsf@email.froward.int.ebiederm.org> <CAHk-=wj=EHvH-DEUHbkoB3vDZJ1xRzrk44JibtNOepNkachxPw@mail.gmail.com>
 <87ilrn1drx.ffs@tglx> <877d7zk1cf.ffs@tglx> <CAHk-=wiJPeANKYU4imYaeEuV6sNP+EDR=rWURSKv=y4Mhcn1hA@mail.gmail.com>
 <87y20fid4d.ffs@tglx> <87bkx5q3pk.fsf_-_@email.froward.int.ebiederm.org>
 <87mtfu4up3.fsf@email.froward.int.ebiederm.org> <87r150ug1l.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=whUy_cuJsVeob4zDnK5sWpE3U2EjVbnR2xobqgx7DOp4g@mail.gmail.com> <87zgjot0qr.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87zgjot0qr.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 11 May 2022 10:59:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgT7XdnjJhJmsc342ouHiDu2oxcguziHSL21UH3jsnrCw@mail.gmail.com>
Message-ID: <CAHk-=wgT7XdnjJhJmsc342ouHiDu2oxcguziHSL21UH3jsnrCw@mail.gmail.com>
Subject: Re: [PATCH 8/7] sched: Update task_tick_numa to ignore tasks without
 an mm
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:53 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> I do have it in a public git branch.  The testing in linux-next
> is what revealed this.
>
> However it is a topic branch that as far as I know no one depends
> on so I should be able to rebase it.

Not a big deal, since it needs to not just bisect into that small
series, you also need a certain amount of bad luck to then hit the
issue.

So I don't think you should rebase unless you have other reasons to do
so, but if you do, just put this commit either first, or fold it into
the commit that removes PF_KTHREAD for threads that will become user
threads.

                  Linus
