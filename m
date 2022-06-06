Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2492953E726
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239998AbiFFOmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbiFFOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:42:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8482D89A3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DC53B81A6B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B385C385A9;
        Mon,  6 Jun 2022 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654526515;
        bh=+PqOvDVBMAo5Z0wuMAGeqDON3g9v2EJjw+ews+oIwQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u8bBqivZ51RJxDpkBkRgbts5/QcuEKDS6tOOamCUGQuaJrIJmSB/q/H2/WfJwRZVH
         CAtyEqUH+m8Y1dhBW8xPaHeh/PcxmZOHCBhv61coiUN8OqEqeVruXlhtM6B76FBaW5
         32HTLpaYCSKmGC3lWcEjoJU/6+ps8CkTRJ+EKXEjGJO8OgdC719atFy8XgcjFzCOkM
         Sx044R5yTYD1aG4a3CgTCU8FbDe0295+ZyQZb3pbLpcl8o8Y8OYIP+Tf0yOe2N3ukv
         VFQ+kEdCBa2734zqGT4gHckpkBna3w2sraSVwZPxW7gL1xF0EAPbw1sgoHGNtnguW8
         cHEFBnR0uMgSw==
Date:   Mon, 6 Jun 2022 23:41:50 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] tracing/probes: allow no event name input when
 create group
Message-Id: <20220606234150.43ddad8dd5b459c18a46994d@kernel.org>
In-Reply-To: <1654171861-24014-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1654171861-24014-1-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linyu,

On Thu, 2 Jun 2022 20:10:58 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> take kprobe event as example, when create a group of events,
> p[:[GRP/]EVENT] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS],
> according to this format, we must input EVENT name,
> 
> this change allow only GRP/ input, EVENT name auto generate from KSYM,
> p[:[GRP/][EVENT]] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]
> 
> siliar change apply to eprobe and uprobe.

Thanks for updating the series. This looks godd to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

for this series.

Thank you!

> 
> V1: https://lore.kernel.org/lkml/1651397651-30454-1-git-send-email-quic_linyyuan@quicinc.com/
> 
> V2: fix remove comment in V1 patch1,
>     remove v1 patch2 as it is NACK.
> 
> v3: (v2 link: https://lore.kernel.org/lkml/1653795294-19764-1-git-send-email-quic_linyyuan@quicinc.com/)
>     add selftest cases for kprobe and eprobe event,
>     remove macro used in v1,v2,
>     change location to generate eprobe event name.
> 
> v4: (v3 link: https://lore.kernel.org/lkml/1653978552-18637-1-git-send-email-quic_linyyuan@quicinc.com/)
>     fix comment of kprobe/eprobe test case.
> 
> Linyu Yuan (3):
>   tracing: eprobe: remove duplicate is_good_name() operation
>   tracing: auto generate event name when create a group of events
>   selftests/ftrace: add test case for GRP/ only input
> 
>  Documentation/trace/kprobetrace.rst                |  8 +++----
>  Documentation/trace/uprobetracer.rst               |  8 +++----
>  kernel/trace/trace.c                               |  8 +++----
>  kernel/trace/trace_dynevent.c                      |  2 +-
>  kernel/trace/trace_eprobe.c                        | 25 +++++++++++-----------
>  kernel/trace/trace_kprobe.c                        | 16 ++++++++------
>  kernel/trace/trace_probe.c                         |  6 ++++++
>  kernel/trace/trace_uprobe.c                        | 12 +++++++----
>  .../ftrace/test.d/dynevent/add_remove_eprobe.tc    |  9 +++++++-
>  .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |  7 ++++++
>  10 files changed, 64 insertions(+), 37 deletions(-)
> 
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
