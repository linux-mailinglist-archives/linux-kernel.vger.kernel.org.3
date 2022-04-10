Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CC64FAFC1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbiDJTUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiDJTUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:20:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0218161A30
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:17:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649618276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KVVbvECq84k+jqXnHwi5XzSuH5e4qkbMSKft0RE4GAs=;
        b=sBHsp7dIrRJtHsbmhYq4KjM55ns5nvf059BGbLajh34xnvsIbn+JIGOpUKRT0ZT1fBBTZx
        AyrZbJTNRvnivBGlgVkyuxk2YSEtRj/I79fix9A8q8KHc+eAqm/nKzEQKGML7w5KFzG/yC
        nse8ulc5tpkl1lYfdf8REMqke5auh+SYgzD3Fnu+gXHZiEmMhhCs3vREdxhg4vhmbEUZcg
        CdL8GV6NTVgXbJ+Ko1K8fp43ZDaniUd9b2PVKVm3uivJnGjNArVSb71Ox4sm/1SB8biGxj
        z6dw8K96KtcKA21vcyjYeZCfuY4ojWwM98X3Zo1ZAxzKE08nV0U4KS4m7Vra5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649618276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KVVbvECq84k+jqXnHwi5XzSuH5e4qkbMSKft0RE4GAs=;
        b=NJoRGcweOM3xoSZkBlU2OS9/fr6pTF5ZS2W3Hk+Z148auMbm6lHeTIf9Fcxbk3P+uC47cZ
        IGvnmOQsQEp9gnBw==
To:     Paran Lee <p4ranlee@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Craig Gallek <kraig@google.com>,
        Austin Kim <austindh.kim@gmail.com>
Subject: Re: [PATCH] genirq: Refactor actions_show loop block using a common
 macro to go through the actions list
In-Reply-To: <20220408114153.GA1955@DESKTOP-S4LJL03.localdomain>
References: <20220408114153.GA1955@DESKTOP-S4LJL03.localdomain>
Date:   Sun, 10 Apr 2022 21:17:56 +0200
Message-ID: <87fsmkhhnf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paran,

On Fri, Apr 08 2022 at 20:41, Paran Lee wrote:

thanks for providing this patch.

> Hello, I am Paran Lee.
>
> Since we have a macro defined in our IRQ subsystem internal functions to
> traverse the list of actions, how about refactoring this loop?
>
> - genirq: Use a common macro to go through the actions list
> (f944b5a7aff05a244a6c8cac297819af09a199e4)
>
> have a good day!
> Paran Lee.

Neither 'Hello' nor 'have a good day' are part of the change log.

Also please write the changelog in a factual way and not in form of a
question. If you want to add a reference to a git commit, then please
use the canonical form as described in Documentation/process, where you
also find the general patch submission rules. There is also a tip tree
specific chapter:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html?highlight=x86#patch-submission-notes

Following these rules makes everyones life simpler.

> Signed-off-by: Paran Lee <p4ranlee@gmail.com>
> ---
>  kernel/irq/irqdesc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 939d21cd55c3..34a0cefff712 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -246,12 +246,12 @@ static ssize_t actions_show(struct kobject *kobj,
>  			    struct kobj_attribute *attr, char *buf)
>  {
>  	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
> -	struct irqaction *action;
> +	struct irqaction *action = NULL;

There is no NULL initialization required.

Thanks,

        tglx
