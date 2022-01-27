Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A089849DDD1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbiA0JW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiA0JW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:22:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A043BC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:22:58 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643275375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+L8VBqp4PAtxyX7hRuZa156QYGOG2O11t3OVdXRWmnA=;
        b=iD6/HX691zapFHyUcCF1FeJutThKMgmH9B07qdHrhkp1dPXftSsz4raGQNQVLIimA/WZ/G
        IJOWxcULQAiW1iHwjl78QqRETqbcGlVw4vBpKkKHpenjcnHRXuXeu3hFPzBlY+vVtyboE5
        bOEw29HPic+9dIEP1U8Td504bRnhMPHHzGvVZh586VkqtoMD7W71kgx2mPpPbNsb9eKpJL
        vaJyWLNvTprfs9vacZFGJHoeDlCeECyeViS2wBWqfkuPio48y7FRbpdclbPG2h8xN44A/N
        3jPBnqtjmNyBydcQlgaOzeEEA5qFN7AhwpA2UMNC+UDA6Jh1s4ORUUucMUs0GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643275375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+L8VBqp4PAtxyX7hRuZa156QYGOG2O11t3OVdXRWmnA=;
        b=/s2wg8YyHWHLZgjZ1NWO+P72Xr+Jo893y9z4aPhr9qd4hyj/A8Z81e8derfNzjXfzdUbvC
        FTAPOyuvF7AugcCg==
To:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] printk: Drop console_sem during panic
In-Reply-To: <20220126230236.750229-5-stephen.s.brennan@oracle.com>
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
 <20220126230236.750229-5-stephen.s.brennan@oracle.com>
Date:   Thu, 27 Jan 2022 10:28:53 +0106
Message-ID: <87fsp9pm6q.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-26, Stephen Brennan <stephen.s.brennan@oracle.com> wrote:
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2759,7 +2782,7 @@ void console_unlock(void)
>  	 * flush, no worries.
>  	 */
>  	retry = prb_read_valid(prb, next_seq, NULL);
> -	if (retry && console_trylock())
> +	if (retry && !abandon_console_lock_in_panic() && console_trylock())

As Sergey suggested [0], I would like to see the call to
abandon_console_lock_in_panic() move inside console_trylock(). This will
help to avoid the race between NMI CPU halt and the internal sema.lock
spinlock.

John Ogness

[0] https://lore.kernel.org/all/YfJFjHdg%2FkhNXiRd@google.com
