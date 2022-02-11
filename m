Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7610E4B3173
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 00:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354276AbiBKXmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 18:42:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiBKXmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:42:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845BDA5;
        Fri, 11 Feb 2022 15:42:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FA65618C1;
        Fri, 11 Feb 2022 23:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFD2C340EB;
        Fri, 11 Feb 2022 23:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644622960;
        bh=dotqGisqT6xom3+yh8EyRGKAr3ZPuPfXjlwiUjg95Ts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L3v8QvPp3JMZbdQ4ppy6JgyNZgaXGe5VSW78Ipfb6YsDzpX80460JbXGPlSBe+LC2
         tZS1QlBPidxrH2gIImwt01t0tG99p/OMtHvgVqoSkvz6unRe8BJDa28tdqex3ga01+
         iAHlNczc8ZWEzbMRP86WaIU06zb5xRberL88oV5WerAA2K8ZUaCcfYa4q80OJmDSl0
         2LyhZ+C6ZpdiTjrm+LihYt6VVoHf257j1rWUsdGXn147bmqcNEFeCeO9Syz+ekHVLU
         rvn3qb0Nxaa8TPc4pB61rrECoXKaAjL1Qfd5SLFPKZ/fcc1EE4lu10NmnFGv4NJXfd
         vphpBbr28/uMQ==
Message-ID: <8340d413-4951-5e62-ef5f-f396523edac7@kernel.org>
Date:   Fri, 11 Feb 2022 15:42:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/8] kernel/fork: Duplicate task_struct before stack
 allocation.
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
 <20220125152652.1963111-3-bigeasy@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220125152652.1963111-3-bigeasy@linutronix.de>
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
> alloc_thread_stack_node() already populates the task_struct::stack
> member except on IA64. The stack pointer is saved and populated again
> because IA64 needs it and arch_dup_task_struct() overwrites it.

I understand the problem, I think.

> 
> Allocate thread's stack after task_struct has been duplicated as a
> preparation.
> 

But I don't understand this.  How does this patch relate to the problem?

Also, you appear to be missing a change to the free_stack and free_tsk 
code at the end of dup_task_struct().
