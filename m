Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16FB4F03D3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354287AbiDBOLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346612AbiDBOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:11:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ADB13D45
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zWvGZKI9SeXG33QH0VHAxJwyqLjTHGSTR8wnBkMrRiA=;
        t=1648908576; x=1650118176; b=lvTXhxeYBpyqUGZ33w4DsAOnnl+bzRrCjQoOolk9Aw5caSb
        Yuk7xhqEV9ZWh0Uuh168F5xENm/2wk+yQ7NCsQcEkcumieqFdI6Xz5FZFNrNjfgWDnRlGIeIEiivx
        tDn5A/ddOQ6edT6x/CmxuiOUBZPvDNYpUQ8hnfM4rU9PFIkouZxfKk5zWAra9LgrOfGm2PCjCHA1V
        AM/LL1+rDd3jE92GRJ7sBfkmSzKqH4J4VIXKtSZ2Nd6zJijXWXYOpY9C+iLjTampT7WKPG9YuNceH
        /XCcAVDv8oPXCiuQIRe+mt+AnG+d3G71w6v9YbsXRxQIn/7biw4Xw1H2XNs5FUGQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1naeRW-003sRf-PW;
        Sat, 02 Apr 2022 16:09:30 +0200
Message-ID: <84f9d627092660c38400b607198c3b83f795be7f.camel@sipsolutions.net>
Subject: Re: UML time-travel warning from __run_timers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Date:   Sat, 02 Apr 2022 16:09:29 +0200
In-Reply-To: <20220330110156.GA9250@axis.com>
References: <20220330110156.GA9250@axis.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,


> [10737482.720000][    C0] ------------[ cut here ]------------
> [10737482.720000][    C0] WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1729 __run_timers+0x36d/0x380
> 

[for those new on the thread, full message and config here:
https://lore.kernel.org/r/20220330110156.GA9250@axis.com]


I think maybe you found a bug in the timers code?

Your config has CONFIG_NO_HZ_COMMON, so we have both BASE_STD and
BASE_DEF.

Evidently, in your config, we *never* have any timer with
TIMER_DEFERRABLE, which would put it into BASE_DEF.

(I put a WARN_ON into get_timer_cpu_base() and get_timer_this_cpu_base()
in the if, and it never triggered; I guess my config has something that
creates a deferrable timer, so it didn't trigger, but I didn't check
that now.)

Therefore, base->next_expiry never changes or something?

At init, we get

init_timer_cpu(0) base 0 clk=0xffff8ad0, next_expiry=0x13fff8acf
init_timer_cpu(0) base 1 clk=0xffff8ad0, next_expiry=0x13fff8acf

which makes sense, jiffies is set up to wrap very quickly after boot.

The warning triggers when we have jiffies=0x13fff9600, so it's just
after the "next_expiry", so in this code:

static inline void __run_timers(struct timer_base *base)
{
   struct hlist_head heads[LVL_DEPTH];
   int levels;

   if (time_before(jiffies, base->next_expiry))
           return;


we no longer return. Previously, we've *never* executed past that if for
BASE_DEF.

But we never touched this timer base nor did we ever want to recalc it I
guess, so

    WARN_ON_ONCE(!levels && !base->next_expiry_recalc);

triggers.


I thought about changing that condition to

  if (time_before(...) || !base->timers_pending)
          return;

and that *does* make the splat go away, but I fear that might make it
not recalculate when needed, so perhaps in the condition we should have

  if (time_before(...) ||
      (!base->timers_pending && !base->next_expiry_recalc))
          return;

or something? (which also avoids hitting the warning)

But I really don't know anything about this code, so adding a few CCs.
Can you help?

Thanks,
johannes
