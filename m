Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C594E4951CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376796AbiATPvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:51:52 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:37778 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiATPvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hTTIoKDQe0uKDwlKxKFNYq4zkC7rRGIvXgj05n1s++4=; b=gpiLWnMTEWdS8YrXW2tzskQvA3
        SU1Pzwgmm2jDi0zXhMdQwSl+JRJ1jzFLkevBI9g6arnlP4T6u8RwU6byZKWp5t4ldEnEXhsoCycOi
        4Nfsk2XaXp4+C8/uA9RKJcsTphKfdRVWRA/6AaaYbsDgZlAtJy3VbdCQ2hV0unzmmesz6pWzAvLeN
        r79BTxBA27NyUW9W5kxpxQ2rHJqFxVtP1zs2y9r08Q0G7IY3HDTERjvezi+zPQtOlghAFpc/vznjn
        xfwWdnyTEWbH2asbc4jdhkQ57W98XMtccNniGWc0DzDdSkHT8ajKDhZdR/z5xKBNrV0Gv3uNQIA8Y
        K8Gls8hQ==;
Received: from [179.98.77.138] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nAZiu-00014r-D0; Thu, 20 Jan 2022 16:51:40 +0100
Message-ID: <4de89aeb-c127-908c-b403-f9cea128a0b0@igalia.com>
Date:   Thu, 20 Jan 2022 12:51:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, kernel@gpiccoli.net,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
 <94bb12a2-a788-cee6-7d4f-dc0ac581fb39@igalia.com> <YektvNyN6mAHv9jJ@alley>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YektvNyN6mAHv9jJ@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2022 06:39, Petr Mladek wrote:
> [...]
> It makes perfect sense to disable the watchdogs during panic().
> For example, rcu_panic() just sets a variable:
> 
> static int rcu_panic(struct notifier_block *this, unsigned long ev, void *ptr)
> {
> 	rcu_cpu_stall_suppress = 1;
> 	return NOTIFY_DONE;
> }
> 
> It is quick and super-safe. It might make sense to implement similar
> thing for other watchdogs and do something like:
> 
> void panic_supress_watchdogs(void)
> {
> 	rcu_panic();
> 	softlockup_watchog_panic();
> 	wq_watchog_panic();
> }
> 
> It might be caller early in panic().
> 

For reference, I saw your great input about this subject in another
related thread, which I think we should mention here:

https://lore.kernel.org/lkml/Yel8WQiBn%2FHNQN83@alley/


> JFYI, there is an extension for the crash tool that might be able to read
> the trace log, see https://crash-utility.github.io/extensions.html
> 
> I haven't tested it myself yet.

Thanks, nice to know =)
