Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9055A59FC37
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbiHXNv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbiHXNty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3776F9A9DA;
        Wed, 24 Aug 2022 06:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A931B61786;
        Wed, 24 Aug 2022 13:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79A4C433D6;
        Wed, 24 Aug 2022 13:45:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iGKKsQGw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1661348703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZLtAsF2uZ9ocOb5E6/KIG4KyzKa728jhYH5YX05G5Ac=;
        b=iGKKsQGwwzxqfQugSyH9e8+0wsfHfn7IASIQBlcjRKKwha/bjUVL0mcdoCXN6zZh51j72s
        Ci1MTsR0ad1DtVx5X0D1UnePA5xn2WGTWOE53t0kJkLDs0nfVmEyerJtOWplVsej7D809S
        I4luJft4eIGfz54Wxl4PMBRgQN1m6Hc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d95281f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 24 Aug 2022 13:45:03 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3375488624aso431904707b3.3;
        Wed, 24 Aug 2022 06:45:02 -0700 (PDT)
X-Gm-Message-State: ACgBeo3BGl+Ru6yEq67sjmpUY3YFP8hVwuP/HKWWrO4hWKrnHtr4ws1j
        2zKZvL4FUC6EQg+CHAH+QfYEJcMGytRfvW0R0Vs=
X-Google-Smtp-Source: AA6agR72fmrESu0IuSCwVNckXUvR1jJheO3GJct5r4F5XpU2Zpb00FWb1tpIjnDDNhvAKv6ek8rQRFeF6upoFJlPA8Q=
X-Received: by 2002:a81:6141:0:b0:328:30e0:a6ca with SMTP id
 v62-20020a816141000000b0032830e0a6camr32712430ywb.454.1661348699719; Wed, 24
 Aug 2022 06:44:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:2589:b0:191:2a95:8ff9 with HTTP; Wed, 24 Aug 2022
 06:44:59 -0700 (PDT)
In-Reply-To: <YwQzyMlY6fa2WrM5@piliu.users.ipa.redhat.com>
References: <20220822021520.6996-1-kernelfans@gmail.com> <20220822021520.6996-7-kernelfans@gmail.com>
 <CAEXW_YRH11xFg-0nQfvv59SMFCW=SNTEEL0oHJKTs1X45wGr7w@mail.gmail.com> <YwQzyMlY6fa2WrM5@piliu.users.ipa.redhat.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 24 Aug 2022 09:44:59 -0400
X-Gmail-Original-Message-ID: <CAHmME9oLpTus_yVEcocWLB35RGi32xR8pJtTEL_dK180knW=Og@mail.gmail.com>
Message-ID: <CAHmME9oLpTus_yVEcocWLB35RGi32xR8pJtTEL_dK180knW=Og@mail.gmail.com>
Subject: Re: [RFC 06/10] rcu/hotplug: Make rcutree_dead_cpu() parallel
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22, Pingfan Liu <kernelfans@gmail.com> wrote:
> On Mon, Aug 22, 2022 at 02:08:38PM -0400, Joel Fernandes wrote:
>> On Sun, Aug 21, 2022 at 10:16 PM Pingfan Liu <kernelfans@gmail.com>
>> wrote:
>> >
>> > In order to support parallel, rcu_state.n_online_cpus should be
>> > atomic_dec()
>>
>> What does Parallel mean? Is that some kexec terminology?
>>
>
> 'Parallel' means concurrent. It is not a kexec terminology, instead,
> should be SMP.

Only sort of. See section A.6 of Paul 's book:
http://kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook.html

Jason
