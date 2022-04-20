Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF5E508C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380076AbiDTPr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380366AbiDTPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478662ACF;
        Wed, 20 Apr 2022 08:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC3316194F;
        Wed, 20 Apr 2022 15:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1888CC385A1;
        Wed, 20 Apr 2022 15:44:55 +0000 (UTC)
Date:   Wed, 20 Apr 2022 11:44:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     patrick wang <patrick.wang.shcn@gmail.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: ftrace: avoid tracing a few functions executed in
 multi_cpu_stop()
Message-ID: <20220420114454.69ab108c@gandalf.local.home>
In-Reply-To: <CAGcnep_Gx+3KiUvDVronYKn_divU3OM-RQEOPZakv7MRYh4EJw@mail.gmail.com>
References: <20220418043735.11441-1-patrick.wang.shcn@gmail.com>
        <20220418143404.55c8fcab@gandalf.local.home>
        <CAGcnep8bH4Nncbt3t+VRLff35ZyD8JyzHcEgkq-u6TEq47jqzQ@mail.gmail.com>
        <CAGcnep_Gx+3KiUvDVronYKn_divU3OM-RQEOPZakv7MRYh4EJw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 18:34:34 +0800
patrick wang <patrick.wang.shcn@gmail.com> wrote:

[ I had a power outage yesterday, just catching up now ]

> Sorry for the format. Need get used to gmail.
> 
> These functions are running within stop machine and ftrace modify
> code by using stop machine to ensure the safety on some
> architectures(e.g. RISC-V). These functions' instructions will be
> modified during ftrace modifying code. When instructions are being
> modified, they shouldn't be executed typically. Or the executor
> may behave unpredictably.

Interesting. On x86 when we used stop machine[*] it was not an issue to
modify the code that is being executed in stop machine. I'm curious to
exactly what the issue is if something does get traced in the stop machine
processing. Why does it crash?

-- Steve


[*] You really should come up with a better way than stop machine, because
the stop machine method is really disruptive, can you not use the break
point method for updates?
