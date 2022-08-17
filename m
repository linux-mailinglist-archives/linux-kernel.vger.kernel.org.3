Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547E2597008
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbiHQNed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbiHQNeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:34:17 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C186D8E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:34:16 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11c5505dba2so1620255fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=/P1jCJo94ZKBVPz+Z0zL9bzR+A2pTXoDyJceXkylseU=;
        b=Q/hB4E6kBet7KQ1qdLFLDkdhnAvJeTm5+ZvJtec0G2MnH15FwmdmqwYepaC6PKT0mq
         pyz0vJmEtI5IP8LQs5r1gVF8bQGXP6pdK5uLoQh1uQiJIKytDY/3LStvvNSh4/6AUNG4
         to+vqNRwfAui/AU/CGxH6MOZSUy2iGEorPFnECYp42J7kdaJ2mAFIp0QvM3qWIjVgi/t
         QwgRBaQfv0nR8hwOwdNk3WBApyaPhBZn0ksa0ro5yA0SuOrpK46Pj94WFBLXx40+coeC
         quGYkznYK0Aixddrx8KqL1CL5y3tHWj7+3OOdYvHXd9wXGyusn2kc4RjY0KjFmqEX/fa
         xE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=/P1jCJo94ZKBVPz+Z0zL9bzR+A2pTXoDyJceXkylseU=;
        b=F/2wZ3vpPsXLAtYVEqeoCWvT51+MUfzUlsg5CjDzvl+9i+bHjixsqxXjJqUyuzLftC
         6LCB8m77AuHzs0P/lY2eaBX2gr0JnELwHVFRfMWglJ7de88mlPhmggcbp9GiiKfJlGuF
         U2LXkHz6MmfEx42esmUkr9GAdJn5LbCHF4S98hFlgmjuGtHRO8gtrC8Qa1HpPQYladVR
         dox5zxC5lZBlkYwyGGXYa9uONhqxnNcO7EUcV9eGIXecm2QIMHZiu2RckCy4JQaIA/hp
         EJY3cGJuMWPkD1+zus2hemX5r2GTZWhr+x+WNiL+STivqL6QGTKVjXnP0s6ATMqfRJf2
         hjNw==
X-Gm-Message-State: ACgBeo0h/9L8OPeeXWdXqeD6xCiALIfjlNE2FMWKheJP9xk6vDY93yBP
        9QVvUddD0LdxDXREfgtVVvs17ZnTcXCx/mjC9P8=
X-Google-Smtp-Source: AA6agR6HwMrhUynqU2UKkjDThxgaR+8v95bTs4N+qkNwjZQm6QfWowxtrHgFutP+H/lfuRCFDxCxhzCn2rPPxJLLYYQ=
X-Received: by 2002:a05:6870:c386:b0:102:fcb:86cd with SMTP id
 g6-20020a056870c38600b001020fcb86cdmr1737363oao.296.1660743255993; Wed, 17
 Aug 2022 06:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220815142137.29982-1-91tuocao@gmail.com> <YvtgyxoZ/RmtfOs/@worktop.programming.kicks-ass.net>
In-Reply-To: <YvtgyxoZ/RmtfOs/@worktop.programming.kicks-ass.net>
From:   tuo cao <91tuocao@gmail.com>
Date:   Wed, 17 Aug 2022 21:34:03 +0800
Message-ID: <CAEVeK2CY4t4UwvDYxW-vGV-VZUFHzMWEk4wtw60jZaXPKS25aQ@mail.gmail.com>
Subject: Re: [PATCH] sched: core: remove access_ok() before copy_to_user()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just think usize has limited in caller of sched_attr_copy_to_user()
: SCHED_ATTR_SIZE_VER0 < usize < PAGE_SIZE. Maybe user provided
garbage input and cause (usize + uattr) > TASK_SIZE,  but if (ksize +
uattr) < TASK_SIZE, user can also get the struct sched_attr correctly
by copy_to_user() only and there are no side effects.
So, should we really limit user get the struct sched_attr in this
situation? Thanks.

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2022=E5=B9=B48=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=BA=8C 17:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 15, 2022 at 10:21:37PM +0800, Tuo Cao wrote:
> > If usize > ksize, usize may be not valid and if(!access_ok()) will retu=
rn
> > -EFAULT. But ksize may be valid, copy_to_user() should be executed.And
> > also, copy_to_user() will calls access_ok() to test whether a block of
> > memory is a valid user space address.
>
> I don't follow, why do you want this to continue if the user provided
> garbage input?
