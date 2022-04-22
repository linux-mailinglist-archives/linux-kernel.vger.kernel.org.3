Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561FF50BC25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449578AbiDVPze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355262AbiDVPzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:55:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D8D18388;
        Fri, 22 Apr 2022 08:52:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03CE8B8311D;
        Fri, 22 Apr 2022 15:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07EBC385A0;
        Fri, 22 Apr 2022 15:52:35 +0000 (UTC)
Date:   Fri, 22 Apr 2022 11:52:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     patrick wang <patrick.wang.shcn@gmail.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: ftrace: avoid tracing a few functions executed in
 multi_cpu_stop()
Message-ID: <20220422115234.613436e4@gandalf.local.home>
In-Reply-To: <CAGcnep9Ez-S962vukR_a=otzcSxDRo5HUW2vG_YCBanCfURGXw@mail.gmail.com>
References: <20220418043735.11441-1-patrick.wang.shcn@gmail.com>
        <20220418143404.55c8fcab@gandalf.local.home>
        <CAGcnep8bH4Nncbt3t+VRLff35ZyD8JyzHcEgkq-u6TEq47jqzQ@mail.gmail.com>
        <CAGcnep_Gx+3KiUvDVronYKn_divU3OM-RQEOPZakv7MRYh4EJw@mail.gmail.com>
        <20220420114454.69ab108c@gandalf.local.home>
        <20220420122633.55d4ff6b@gandalf.local.home>
        <CAGcnep86pd2trfTovU8_z1msOstx7gKCdndm=pHLDGTy+_K7=g@mail.gmail.com>
        <20220421085047.2cb8edf9@gandalf.local.home>
        <CAGcnep9Ez-S962vukR_a=otzcSxDRo5HUW2vG_YCBanCfURGXw@mail.gmail.com>
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

On Fri, 22 Apr 2022 18:45:46 +0800
patrick wang <patrick.wang.shcn@gmail.com> wrote:

> Yes, and not just RISC-V. It's arch-independent. It's the internal change of
> stop machine implementation.
> 
> ----------------------------------------------------------------
> Former stop machine wait loop:
> do {
>     cpu_relax(); => macro
>     ...
> } while (curstate != STOPMACHINE_EXIT);
> -----------------------------------------------------------------
> Current stop machine wait loop:
> do {
>     stop_machine_yield(cpumask); => function (notraced)
>     ...
>     touch_nmi_watchdog(); => function (notraced, inside calls also notraced)
>     ...
>     rcu_momentary_dyntick_idle(); => function (notraced, inside calls traced)
> } while (curstate != MULTI_STOP_EXIT);
> ------------------------------------------------------------------

That makes much more sense. Can you add that to the change log.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
