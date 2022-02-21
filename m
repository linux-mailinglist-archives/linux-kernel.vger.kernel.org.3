Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2617E4BEAC4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiBUShi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:37:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbiBUSgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:36:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29E9CC0;
        Mon, 21 Feb 2022 10:36:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 683C3614E6;
        Mon, 21 Feb 2022 18:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53425C340E9;
        Mon, 21 Feb 2022 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645468562;
        bh=LvyAU0uC90qJLSAUEoQzZgP182YjQz/6HjvAx3mw0hM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=girqwU9uRq/0C1W6d0fbWt/68D3PbWeDGmjpYZ+ZkmeXDo8ekmyl4u4D9SFOsG6dQ
         3DLx7VB/AdcR5H3DxpLeS9Sa9e23ACYXuXGwpTZ+VM+2O0rmnklZmHKTWufoHbOTCp
         Y4PXK/W9496tcu6eFA4EUUFx0ooZepYoZGn9BaQq9juZKjUE97C5o2YxWsEevmRFoY
         2DG4E9+nXd9R+W96X0PCvu6VvoiDMe6MeX+MiBp5kwe8cykLDyPCpFy5V3kU1edRdR
         RHkh0zENPg2j0Zj2Ycl4yYacIHa8NTT59FtGMEjmYXGBP4YOPkUr+w8+czUeg4oXna
         kY97sdrShS16w==
Message-ID: <215dc5af-5e81-fb64-9f00-b1e9e8d08297@kernel.org>
Date:   Mon, 21 Feb 2022 10:36:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/8] kernel/fork: Move thread stack free otu of the
 scheduler path.
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
References: <20220217102406.3697941-1-bigeasy@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220217102406.3697941-1-bigeasy@linutronix.de>
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

On 2/17/22 02:23, Sebastian Andrzej Siewior wrote:
> This is a follup-up on the patch
>      sched: Delay task stack freeing on RT
>      https://lkml.kernel.org/r/20210928122411.593486363@linutronix.de
> 
> It addresses the review feedback:
> - Decouple stack accounting from its free invocation. The accounting
>    happens in do_exit(), the final free call happens later.
> 
> - Add put_task_stack_sched() to finish_task_switch(). Here the VMAP
>    stack is cached only. If it fails, or in the !VMAP case then the final
>    free happens in delayed_put_task_struct(). This is also an oportunity
>    to cache the stack.

My first two tries to apply this series to something failed.  What's it 
based on?

The rest of my review will be based on diffs, not real code, since I 
failed to apply it.
