Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD274BFA72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiBVOJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiBVOJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:09:20 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE4215F377
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Gft2vksxvg2p7hlkEZC2wTxmWAXTizdIoqfd+83pKUA=; b=CkILlN47FdZ0e1Eg5VfGrMMbyY
        M9kCxxlSC5GNSBy/hdl1vhI6vtZGxpwaC5eCSiu2rIZ0DEesCAZlsZ4QKbQPU93q3s466Ak0JVyO3
        icK1Vjbr8gHCpE6SVWJkymogGsQnoAY76tdHQ4XeIJ8c9lShy/3ZQLdV3brtYbOKUOD4RjT39NzYL
        qB0vK8Hds/5cgA10EXUmSdJQXGWBlJipPTqMcK10VXWgJmezbxUFSD9ox6Uj9VM7MNllTXFJQRTRm
        iSXL65nDF+s6QNkhfNQD602+pTMK10nyZnquU5y69c4721yAvwujRLT+x5DlI0igPtbPX9HM3lYK9
        z0LLNdHg==;
Received: from [189.79.213.38] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nMVqJ-000A22-5x; Tue, 22 Feb 2022 15:08:40 +0100
Message-ID: <7702bdc2-78ce-00f5-d5a4-c06527c3ae72@igalia.com>
Date:   Tue, 22 Feb 2022 11:08:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>, bhe@redhat.com,
        pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        anton@enomsg.org, ccross@android.com, dyoung@redhat.com,
        feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        tony.luck@intel.com, vgoyal@redhat.com
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRAOQbH15E7y9s8@google.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YhRAOQbH15E7y9s8@google.com>
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

On 21/02/2022 22:45, Sergey Senozhatsky wrote:
> [...]
> Yeah, if Petr is fine with that then I'm OK. But at the same time,
> we have `panic_print' which is a bit mask of what panic_print_sys_info()
> should do. And now we also have a boolean `console_flush` flag that tells
> panic_print_sys_info() to ignore some (one as of now) bits of `panic_print'.
> 
> So _maybe_ panic_print_sys_info() can just accept panic_print as
> its parameter and then we can do something like this (as an example)
> 
> 	panic_print_sys_info(panic_print & ~PANIC_PRINT_ALL_PRINTK_MSG);
> 
> 
>>  	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
>>  		trigger_all_cpu_backtrace();
>> @@ -286,6 +289,8 @@ void panic(const char *fmt, ...)
>>  	 */
>>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> 
> [..]
> 
>> +	panic_print_sys_info(false);
> 
> Merely because `panic_print_sys_info(false);` doesn't tell much to a reader.
> Like what is print sys info false?
> 
> Or did you already discuss this?

Hi Sergey, thanks for your feedback. So, personally I prefer having the
flag - for me it's clear, it's just a matter of reading the prototype -
either we print the info _or_ we console_flush.

But let's see if others have a preference - if the preference is to use
the bitmask as you suggest, we can do it in a next version.

Cheers,


Guilherme
