Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DF04C13D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbiBWNQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbiBWNQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:16:25 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE26AA007
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fJkrYZreFrZbT4XmSOKefb8T6OZuObvM4MLsBp/+ydk=; b=btZLNNKQJthSB3fw2T+zImqCpn
        meS5pTMkT2JiUCGBD1HwkCyUjBvStmcBuBatMhnHtwhK72lplZHX7P+rBzuLdBBys0W5590kVxWwf
        zcsBWJEDzX3TRt/4UMeEXGLPnw/i8pYQKpXUBof3gVoFmdHjtwjzNyW9v0gLHDs9M8XddgQHi1Uqq
        jodL3ltU5pz/aoXLQOIwSkl2Spev+suTlCtP17/b94CNE2CXcMve7c9fCRccqQ7Q0mnaluzJKRyUc
        pTSfufsugxXf33TXglcR0BcvjwBfrs9Msfr0KjNC2HowPUpv0nN81/VZyDHJTiLFK1C3sQ19pR4tv
        XciTHApw==;
Received: from [189.79.213.38] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nMrUK-0000VM-AI; Wed, 23 Feb 2022 14:15:24 +0100
Message-ID: <5eeba935-d73a-5539-4eb1-298fb6ee0578@igalia.com>
Date:   Wed, 23 Feb 2022 10:15:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, pmladek@suse.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        tony.luck@intel.com, vgoyal@redhat.com
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YhWNhzacAVDuFtwB@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 22:27, Sergey Senozhatsky wrote:
> [...]
> Hmm. Yeah, well, that's a bit of a tricky interface now
> 
> 	panic()
> 		// everything (if corresponding bits set), no console flush
> 		panic_print_sys_info(false)
> 		...
> 		// console flush only if corresponding bit set
> 		panic_print_sys_info(true)
> 
> 
> 
> If everyone is fine then OK.
> 
> But I _personally_ would look into changing this to something like this:
> 
> 	#define EARLY_PANIC_MASK (PANIC_PRINT_FOO | PANIC_PRINT_BAR | ...)
> 	#define LATE_PANIC_MASK (PANIC_PRINT_ALL_PRINTK_MSG)
> 	panic()
> 		panic_print_sys_info(panic_print & EARLY_PANIC_MASK)
> 		...
> 		panic_print_sys_info(panic_print & LATE_PANIC_MASK)

Hi Sergey, notice that panic_print_sys_info() currently doesn't have a
parameter! The prototype (without this patch) is:

static void panic_print_sys_info(void);

So, it consumes the "panic_print" global variable (which matches the
command-line parameter / sysctl), hence to implement your suggestion
either we need a refactor in panic_print_sys_info(), adding a parameter
(more or less what the patch is already doing, but with a bit more
changes) or we override the global variable twice in panic(), before the
function calls.

As you said, it's possible and a matter of personal coding style. I'd be
fine if more people ask that, but if everyone is fine with the current
implementation, I'd rather get this patch merged as is, since we need it
and couldn't even make it for 5.17 heh

Cheers,


Guilherme
