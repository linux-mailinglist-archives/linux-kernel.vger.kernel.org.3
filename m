Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAAD58B013
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbiHESxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236448AbiHESxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:53:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1831C1570F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 11:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A812A619D9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 18:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551F0C433D7;
        Fri,  5 Aug 2022 18:53:35 +0000 (UTC)
Date:   Fri, 5 Aug 2022 14:53:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Daniel Dao <dqminh@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: 5.15 ftrace bug when enabling function_graph
Message-ID: <20220805145333.1360dbbb@gandalf.local.home>
In-Reply-To: <CABWYdi1aKXWDjT+-aAQvn7eLcySbmeEucVS+8RAbUPE+bprK6A@mail.gmail.com>
References: <CA+wXwBQ-VhK+hpBtYtyZP-NiX4g8fqRRWithFOHQW-0coQ3vLg@mail.gmail.com>
        <20220223115457.7bb575c1@gandalf.local.home>
        <CABWYdi1aKXWDjT+-aAQvn7eLcySbmeEucVS+8RAbUPE+bprK6A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2022 11:37:56 -0700
Ivan Babrou <ivan@cloudflare.com> wrote:

> root@foo:~# echo 'bpf_dispatcher_*_func' >
> /sys/kernel/tracing/set_ftrace_notrace
> 
> root@foo:~# trace-cmd record -p function_graph -l handle_mm_fault -P 3367417
> plugin 'function_graph'
> Hit Ctrl^C to stop recording


> [1459709.204253] ------------[ ftrace bug ]------------
> [1459709.204257] ftrace failed to modify
> [1459709.204262] [<ffffffffac3ea960>] bpf_dispatcher_xdp_func+0x0/0x10
> [1459709.204275]  actual:   ffffffe9:ffffff9b:76:ffffffb0:14
> [1459709.204302] Setting ftrace call site to call ftrace function
> [1459709.204305] ftrace record flags: 10000001
> [1459709.204309]  (1)
>                   expected tramp: ffffffffabc4bcb0
> [1459709.204325] ------------[ cut here ]------------

Did you reboot since the error happened? Because the command you showed
should not have touched bpf_dispatcher_xdp_func.

-- Steve
