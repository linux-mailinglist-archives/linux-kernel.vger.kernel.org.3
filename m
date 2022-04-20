Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195EB509178
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379800AbiDTUi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiDTUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:38:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5A42ED68;
        Wed, 20 Apr 2022 13:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C054B82192;
        Wed, 20 Apr 2022 20:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3086FC385A1;
        Wed, 20 Apr 2022 20:36:02 +0000 (UTC)
Date:   Wed, 20 Apr 2022 16:36:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH RFC] rcu/nocb: Provide default all-CPUs mask for
 RCU_NOCB_CPU=y
Message-ID: <20220420163600.18b9cd15@gandalf.local.home>
In-Reply-To: <CAEXW_YT0CDp7kqKVeqGRT8YfXiCYuL0ZgRwz05MQrmns2Yp+2Q@mail.gmail.com>
References: <CAEXW_YQ+oE3xQ0tLnBMFxRXLqKZkT5UfjF+CULxnhf9F-dEA2g@mail.gmail.com>
        <CAEXW_YRK2t2JO4RyBTd8cR9sTVpgP7Z5Ywhb1g7CRz3HJ_kNQA@mail.gmail.com>
        <20220408205440.GL4285@paulmck-ThinkPad-P17-Gen-1>
        <CAEXW_YTunj5j7cxT3VYGGmJwcQowpDiyqmewiwHjyXP-zJd4FA@mail.gmail.com>
        <20220411154109.GX4285@paulmck-ThinkPad-P17-Gen-1>
        <Ylhz1LOIf+JyjH7n@google.com>
        <20220414194204.GU4285@paulmck-ThinkPad-P17-Gen-1>
        <CAEXW_YS5b_51tqmdf27QqQHqsgJKbTys1V3h+Bek3XN4FjBmbw@mail.gmail.com>
        <20220414210933.GW4285@paulmck-ThinkPad-P17-Gen-1>
        <YliOnZC6gva5WZrG@google.com>
        <20220414213156.GZ4285@paulmck-ThinkPad-P17-Gen-1>
        <CAEXW_YT0CDp7kqKVeqGRT8YfXiCYuL0ZgRwz05MQrmns2Yp+2Q@mail.gmail.com>
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

On Thu, 14 Apr 2022 17:38:08 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> Then it should be called: CONFIG_RCU_NOCB_CPU_DEFAULT_ALL , or
> something. Otherwise I can tell you that I will be the first one to be
> confused by menuconfig unless I also read the code :-D

Naw, I think calling it CONFIG_RCU_NOCB_CPU_ALL is fine, it's what you
write in the help message of the Kconfig file that really matters.

I would always say that what is on the command line should override the
configs (when feasible). To add something to the command line takes effort,
and is always visible (cat /proc/cmdline), whereas configs are hidden and
not as visible to those using the kernel. Not having the command line work
would be annoying, and even if it came up with a message of "The config
says *all* so I'm ignoring what you want to do" would be exceptionally more
annoying as now the user has to recompile the kernel (and only if they
could).

-- Steve
