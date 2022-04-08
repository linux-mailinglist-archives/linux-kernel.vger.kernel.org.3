Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F584F9F48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbiDHVo4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Apr 2022 17:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiDHVox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:44:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7957E27E;
        Fri,  8 Apr 2022 14:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1665E62085;
        Fri,  8 Apr 2022 21:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91469C385A1;
        Fri,  8 Apr 2022 21:42:46 +0000 (UTC)
Date:   Fri, 8 Apr 2022 17:42:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team <kernel-team@android.com>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT
 kthread_worker
Message-ID: <20220408174245.65e1ec98@gandalf.local.home>
In-Reply-To: <CAC_TJvf_ubOPUVpNYK9UUWXn5J5hpiTkOt2++kYTGbF9bM_pYw@mail.gmail.com>
References: <20220408045734.1158817-1-kaleshsingh@google.com>
        <CAEXW_YQ6_VpneJnBfhTOMr6DwJhNmvMAKDRMnpr8LxB9Gtt=Xg@mail.gmail.com>
        <20220408143444.GC4285@paulmck-ThinkPad-P17-Gen-1>
        <CAEXW_YSrGKXh5DiJyrNvmbssSXbWBkA-XUjGRdS8HtGvW1r6hw@mail.gmail.com>
        <20220408153447.GE4285@paulmck-ThinkPad-P17-Gen-1>
        <CAEXW_YT-vJmXgWPQ_1J34iTb+ZhrAgN7c-HPz7kW17HmvKzJ3A@mail.gmail.com>
        <20220408173908.GJ4285@paulmck-ThinkPad-P17-Gen-1>
        <CAC_TJvf_ubOPUVpNYK9UUWXn5J5hpiTkOt2++kYTGbF9bM_pYw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 10:53:53 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> If PREEMT_RT systems don’t disable expedited grace periods, we can
> remove default off for those. Steve?

Yep, commit 36221e109eb20 ("rcu: Enable rcu_normal_after_boot
unconditionally for RT") is still there.

OK, that explains it. I missed that change, so I didn't see the relation to
PREEMPT_RT. It wasn't described in the change log nor was there any
comment in the kconfig to say why it was special. Perhaps that should be
added for those that don't know all this tribal knowledge ;-)

-- Steve
