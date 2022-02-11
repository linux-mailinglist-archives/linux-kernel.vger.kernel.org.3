Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2054B3177
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 00:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354304AbiBKXn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 18:43:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiBKXny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:43:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26FA5;
        Fri, 11 Feb 2022 15:43:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09EEB619D7;
        Fri, 11 Feb 2022 23:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EDBC340E9;
        Fri, 11 Feb 2022 23:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644623031;
        bh=V3+Yg4w3h8Gc6QUNzphw26pGQ5B8l7gPWtmWyyPF7Jg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ps9z+Xq8Y0npS0gKt2TQhJhfYsfkx4O3JUynEEFWH3fARJvLFqC2IP7MY+dIdjTd0
         qhLRlYoJ8o1yLRd7TAnpnKMIYdQj/K5BhPnRJz2XZ6Agz4UWVuXaEBce96OT9v80Ur
         bOe3aRgIEY+/OU83T+QFIkn0ozSicN0L7cEPSPXGNYuwfymGrJ8b387q8nfbRg2a7x
         6HWQ5ZRZm7RxHqXmPJ6gNe5V8O2MfhB4SFeDTmELejuB1kr3aT6DGPwL8XmWTkNjrV
         KhbgeEZMFBjFaIQE4lDhxnfaXh8Nnhi19Kl8Cn4IVQIWHLuq9nkIx9Ypbv2aR4MmSx
         iX9C+E4vi8U7A==
Message-ID: <55812c89-484d-6981-32f4-aaf20908f631@kernel.org>
Date:   Fri, 11 Feb 2022 15:43:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/8] kernel/fork: Move task stack account to do_exit().
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
 <20220125152652.1963111-7-bigeasy@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220125152652.1963111-7-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 07:26, Sebastian Andrzej Siewior wrote:
> There is no need to perform the stack accounting of the outgoing task in
> its final schedule() invocation which happens with disabled preemption.
> The task is leaving, the resources will be freed and the accounting can
> happen in do_exit() before the actual schedule invocation which
> frees the stack memory.
> 
> Move the accounting of the stack memory from release_task_stack() to
> exit_task_stack_account() which then can be invoked from do_exit().

Seems reasonable.
