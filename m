Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38D3557817
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiFWKq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiFWKqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:46:55 -0400
Received: from galois.linutronix.de (unknown [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BAB4B1DA;
        Thu, 23 Jun 2022 03:46:53 -0700 (PDT)
Date:   Thu, 23 Jun 2022 12:46:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655981197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8nHj+HFfIWxK8CNsjVFreUnM9gLsfriiyE/MKybp4BA=;
        b=xpuNcA8tDMnQeG7QwGyi2Alc/WV3d54CpW81WbwYlxqk0eEOwA4pyfwSn1UI/wH+vY9nGn
        1WLH3NSJsp8PMB1YKHQPragAa43iONvWnrlOFQwykw4eGnfnyAIMmdwUC2V9SAyD7sx/0g
        +xNwgnvZodMcnRBKVjSJoyVBPskXtmxZnyQXaxGD8iqfACI7kup1QWmUB5G1kZ31+kTBjT
        TH784R4terqdTO6UZROadTW/PUwg2Hy3CD7i9/aJAEG757Y5+KZ+7wQDh5CnuLbjgQVhNt
        3SW1tmGKfDGOKt221/nHEqsSgJKxNzhsG0y+zmxlZzXm4HnybK6QWbo8eIJy3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655981197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8nHj+HFfIWxK8CNsjVFreUnM9gLsfriiyE/MKybp4BA=;
        b=Adb+klKZJpUQmOFLzpUFllVBI2OaxJj5Jome+QdSEQVdjtkav48fEBeBrMOgrpFHGARzSR
        mX+aHp92QBuEk9Bw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] WARNING at hrtimer_start_range_ns
Message-ID: <YrREi3qSDfNek9S1@linutronix.de>
References: <YqnygxNWOztakt8+@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqnygxNWOztakt8+@localhost.localdomain>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-15 16:53:55 [+0200], Juri Lelli wrote:
> Hi,
Hi,

> My understanding is that we have
> 
> fs/aio.c::read_events
>   wait_event_interruptible_hrtimeout
>     __wait_event_hrtimeout
>       hrtimer_init_sleeper_on_stack <- this might mode |=HRTIMER_MODE_HARD on RT

will set HRTIMER_MODE_HARD  of might set HRTIMER_MODE_HARD if the task has elevated priority
(RT/DL).

>         hrtimer_start_range_ns
> 	  WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard)
> 	  fires since the latter doesn't see the change of mode done by
> 	  init_sleeper

correct.

> The attached patch seems to cure the problem, although I'm not entirely
> sure it's the cleanest fix (if I'm right at all about it :).

The problem seems to be that __wait_event_hrtimeout() does
hrtimer_start_range_ns() instead of hrtimer_sleeper_start_expires(). So
if you switch that, then it should go away.

> Thanks,
> Juri

Sebastian
