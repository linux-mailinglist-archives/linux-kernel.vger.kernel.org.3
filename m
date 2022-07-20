Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D208957B649
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiGTMZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGTMZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:25:52 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F5145F7A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:25:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id z23so32765226eju.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sjXwnWKyhBxBzBGiYMwLKosOzhlOCzMsptfg4c6EAuA=;
        b=m3O3x/f/H+KcpJUYzGbLJBTX8HPfSoBlCJFZlh+08wzt5PkIJzmlPjpbk6TKK81DRM
         5y2T+ReL7FEz4LrPHiY80haWkU3/rjzY+UGwt657KR6S2GtaeN1D6AsxCDh3n6GNNL5j
         YH3qfNBQeB+9KH7QiNntocpXkgXuWoRJ+MQFgUCxtux3JSxj0kzlw/VE8JBGWFQ/Fkhh
         XIDecStHjuG3YUXMLkZ2bGfhEy2qdHvA9d3MG+NFgmZgEt/Zc1IXctK7brKlZIlI450F
         5yiSmoTUkMDh1oNVjZQ+8OqlhYZu2eWHypLzv+sYHltiAoGTpDZT5BWSrH9tz2vTs6uo
         r3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sjXwnWKyhBxBzBGiYMwLKosOzhlOCzMsptfg4c6EAuA=;
        b=HHQAQR0nywXZ7CLhMOsRHqBt+VH98dT9nBOYtoZWmzWuJr4/K4Awei0sN6kEJPDlbm
         ET1KGcLfHgdDRK3pgQ3abTSC8S+mjs7fPA2wdhydq9xkGhqJ7a/uL3TZ+hguRAOI2bcH
         SkRcuoVHuls8MfzJ76jI5vL/sQHErGrrVp49W/Pr7mR0TDcn+ZndbpUN0RAwoYm0BgXq
         40Gs9tBsGYvKFlU+o/ywKSQBcWYF4CHLSbSBXJ8ZytfXmNoqZeWdHvLsH3YDcZgYFIRz
         WYyWkXTxwMxJkOsEL8BxPg3BfQ1Zu1tR1teBWlWIQyw6YCynHO14NCotpQrbGgpRxZp5
         IhZA==
X-Gm-Message-State: AJIora+qEHkO8X2Kb7pQrM9OM1NEbz+8rCNC6DJ/XhjdwLTvFUc5HPnJ
        Xv4SWMf+6EbOS6AoS2sWEzDmPgNNCz5sGhL+aA4=
X-Google-Smtp-Source: AGRyM1vetmGCR7OkrI87xR6NlL26wzvxaLkOG5ZO9vAw2Ik+OGKcGLw4M42uHy98+ggt822o7Q7SDGy2kzBPRyAo3mw=
X-Received: by 2002:a17:906:99c5:b0:6fe:b069:4ab6 with SMTP id
 s5-20020a17090699c500b006feb0694ab6mr34890132ejn.436.1658319948163; Wed, 20
 Jul 2022 05:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220720102956.1141634-1-zengjx95@gmail.com> <YtfoCAKfV8PXQz5h@worktop.programming.kicks-ass.net>
In-Reply-To: <YtfoCAKfV8PXQz5h@worktop.programming.kicks-ass.net>
From:   jingxiang zeng <zengjx95@gmail.com>
Date:   Wed, 20 Jul 2022 20:25:37 +0800
Message-ID: <CAPp=jc8wdLd7rZGuun3FH6k2nDMsfMLHF94M=ZOjbaEFvS6WRQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/sched/cputime: Fix unused value in cputime_adjust()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2022=E5=B9=B47=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=89 19:33=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jul 20, 2022 at 06:29:56PM +0800, zengjx95@gmail.com wrote:
> > From: Zeng Jingxiang <linuszeng@tencent.com>
> >
> > Coverity warns uf an unused value:
> >
> > assigned_value: Assign the value of the variable rtime to utime here,
> > but that stored value is overwritten before it can be used.
> > 568   if (stime =3D=3D 0) {
> > 569           utime =3D rtime;
> > 570           goto update;
> > 571   }
> >
> > value_overwrite: Overwriting previous write to utime with
> > the value of expression rtime - stime.
> > 592   utime =3D rtime - stime;
>
> Coverity is being daft, the compiler has a dead-store-elimination pass.
>
> This way the code is more consistent / easier to ready.


Thank you for your suggestion, I will try it.
