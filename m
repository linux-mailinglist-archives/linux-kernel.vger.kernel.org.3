Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE13A5760C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiGOLo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiGOLoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:44:23 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DEA2AE2E;
        Fri, 15 Jul 2022 04:44:23 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-31dfe25bd49so7014837b3.2;
        Fri, 15 Jul 2022 04:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBZsa9lyP4gCzC2HEvoO/iYsp14LWEjyfimLTk/xvRM=;
        b=nOSocrJr+Tt6gckDbeiGX7CdnEssOFqFOyWrPG7vAwoLRpNBz9H/3Jaxd/WUnekuZK
         hB89Bg5u32GeCrSsaqjcMpTdG6X+pCDmkKRREsy4u94zhWKggKvwbwJ0q5Si3Xwk3L6t
         erUABZxBdfsVnd3L03nABv/ENs2HkKOmK6B9fsEVomK1FKGiJfoKlsd/E+12gDkne2Yn
         rrKFDCaRkYn/azjX/QroDZuM+PMzKU/w83+pi4rigCf/MFarXm524BTssmcyBOY6fz2g
         b80TFjK0ttX7u8rYKfvvhnMV9XKfALQQed1qClFQJeeLY+CUgPNMAscOyPQuJIBL8t6D
         8uGw==
X-Gm-Message-State: AJIora8UgMYzG+Wz4FCICrt/KejLj94+/rHfLtfuxNSJSIcY6RhJ8F3R
        rujVW3EOiutQ6mz/TaolexKqX2WmEGh4FZAzzYI=
X-Google-Smtp-Source: AGRyM1udLMPYidhY0CV44YvufRiTgBwDakgpMtwYtBpzMpIHi7lYWu0Co04vg9d8lRhpl6gjfDIAtPMYBE69nmZsux0=
X-Received: by 2002:a81:58c1:0:b0:31d:6b54:3fd5 with SMTP id
 m184-20020a8158c1000000b0031d6b543fd5mr15386267ywb.7.1657885462231; Fri, 15
 Jul 2022 04:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220711124229.16516-1-lukasz.luba@arm.com> <1198724e-d94f-0b7c-9c4a-90595f8426d2@arm.com>
In-Reply-To: <1198724e-d94f-0b7c-9c4a-90595f8426d2@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 13:44:09 +0200
Message-ID: <CAJZ5v0gh78z3tw6simaZ5S6dmGvDc-OE6t02N8vQYk-2eoFQgA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Move max CPU capacity to sugov_policy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:47 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
> gentle ping.
>
> On 7/11/22 13:42, Lukasz Luba wrote:
> > There is no need to keep the max CPU capacity in the per_cpu instance.
> > Furthermore, there is no need to check and update that variable
> > (sg_cpu->max) everytime in the frequency change request, which is part
> > of hot path. Instead use struct sugov_policy to store that information.
> > Initialize the max CPU capacity during the setup and start callback.
> > We can do that since all CPUs in the same frequency domain have the same
> > max capacity (capacity setup and thermal pressure are based on that).
> >
> > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > ---
> >   kernel/sched/cpufreq_schedutil.c | 30 +++++++++++++++---------------
> >   1 file changed, 15 insertions(+), 15 deletions(-)
>
> The patch got Ack from Viresh.
> Could you take it?

Yes, it's there in my queue.  Same for the EM changes.
