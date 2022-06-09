Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5B7544D75
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbiFINXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343774AbiFINXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:23:40 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D84726ACD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:23:38 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id u8so16521270qvj.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ac0XSm6qLT5ejHpXkWVAkUQcaAKF9sF1khNJzx5SMGc=;
        b=IBWxD9g+sOOqJuU9+jsbN9tnjWE8Rx1lsWEFswdhXxOjH8KJP11tnU4skwTHAJoEB0
         Uq5x5aHSnHP+YK2ENYnbUtixhxo8GuHvrL3YshFeokIfn/HFuzsQeIAQi7pxhcssa3QR
         LnAs2/NnpoS/96sFloYm1NK9XRjJygrt6v5UHJCzGcPScpVV82ZRpizWgAdboQRWWzPK
         epC8F4+clohxoO9fzisXGinlp2qkuO9KGNBd8M7823ShukpkBZWZ8TKnQfJdwBM9f1db
         +a7V5EFCZbB+srx+xy6XCRQm0AKcKTvY8ZQC9ocXRGPoC4oxGk2MDWAohKaPC96DczKh
         nPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ac0XSm6qLT5ejHpXkWVAkUQcaAKF9sF1khNJzx5SMGc=;
        b=CjlmueIi9YhkP6yWOh5w3KXpS1Rs5WWgwQXbJmSF/K7At/GX/r+k881Z5awxKlT8al
         dqAXOQNfNhFixORFztGAA/O1j6dYFVP5vbQN1NR3tX28KVMRRpt1etZzbN5LgzfnfVpH
         3W8Tpeh/tn9PDsc7DUkSyY7FR+mk2cNvGDNTmbfnbnnN2fDRHIEdAcaXhFqMrKAb752M
         yhDvHKlz2WcLpf5ZseJUJeHhBL+gM5QAWERswna650lWJWJ5WUWTEDWqi5Veb0rJNMby
         d01xrjgWFNAPuaYBH2I7S5YA9iwMlbrwIYd8+oIo3+r5zP++XZxqWFN2a1nshs0YUaTC
         6XRw==
X-Gm-Message-State: AOAM530lT0qZEe1okdEQrhlDZ+NEH38ePFgzudut8MVq5xsXEYq/Yfig
        U5fD5jBze+x/ir1rwx9dzymtPucnl49uB1R6dAc=
X-Google-Smtp-Source: ABdhPJxxJtzyI6zz1/XREsLwTQubMJsVJXisR+qMeXs7VfVdZY3h9I0a1VHAvQ+tlhTSORWX5mwkjD0I9tFPmKhXGt8=
X-Received: by 2002:ad4:5ba8:0:b0:46b:a8d7:bd61 with SMTP id
 8-20020ad45ba8000000b0046ba8d7bd61mr13976579qvq.70.1654781017674; Thu, 09 Jun
 2022 06:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220606122612.2580930-1-foxhoundsk.tw@gmail.com> <YqHnr8SA2gbf45ok@worktop.programming.kicks-ass.net>
In-Reply-To: <YqHnr8SA2gbf45ok@worktop.programming.kicks-ass.net>
From:   Huichun Feng <foxhoundsk.tw@gmail.com>
Date:   Thu, 9 Jun 2022 21:23:26 +0800
Message-ID: <CAFbkdV2TCZ38ngMViCHgS_v2vMKVMpJwQBR7nZ0a=z6Vwam2Fw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: avoid redundant hrtimer check
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
        Chin-En Lin <shiyn.lin@gmail.com>
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

Peter Zijlstra <peterz@infradead.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=889=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=888:29=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Jun 06, 2022 at 08:26:12PM +0800, Huichun Feng wrote:
> > The check is required iff HRTICK is enabled and DOUBLE_TICK is disabled=
,
> > avoid the redundant check by adding corresponding sched_feat() .
>
> How about: 'don't do that then'?

Looks good!

Should I send a v2 for this? Or could you help amend it directly?

Thank you!
Huichun
