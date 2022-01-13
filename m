Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8066F48D80B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiAMMe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:34:29 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:48688 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiAMMe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wQtWtM09iBZmv9xk/tKCHMTRNvqGx3TjjRoBe9wm/LU=; b=T/nlGduKLAmP914ehy5z6eigbO
        HE+Udp55VhMN/ysDgyvboww/3sO6Guh6kuase0068mrKcRuJcMuZOOOYaqkv6teyNLF5IDJzyGRZC
        SbG1g04uyz0CekByOMKONs4DGkSMVvjntDjmKDaBzpgpyNwi6YSKasSgV7IMAFreDQR8CuVq/dhuS
        7iVOE3TC824sBA3sX9PMpL1XI8gsX4e5tCk12Ou9Q7QXDsHSSdHhO89NxAXiwGo5jd8mGDnYh66sY
        PkjyW/la5XPjIbJ+/GV9hAIK1YFxP54O1hZjGQkmlFOYTtWns21tM9g2UMIiJCFGhCwnQCW5oH+G2
        fVpRJWDQ==;
Received: from [179.113.53.20] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n7zJ7-0006eF-Fv; Thu, 13 Jan 2022 13:34:21 +0100
Message-ID: <ba0e29ba-0e08-df6e-ade5-eb58ae2495e3@igalia.com>
Date:   Thu, 13 Jan 2022 09:34:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V2] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <20220106212835.119409-1-gpiccoli@igalia.com>
 <Yd/0K1x7ILw3Qa46@alley>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Yd/0K1x7ILw3Qa46@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 08:50, Petr Mladek wrote:
>> @@ -249,7 +252,7 @@ void panic(const char *fmt, ...)
>>  	 * show some extra information on kernel log if it was set...
>>  	 */
>>  	if (kexec_crash_loaded())
>> -		panic_print_sys_info();
>> +		panic_print_sys_info(false);
> 
> panic_print_sys_info(false) will be called twice when both
> kexec_crash_loaded() and _crash_kexec_post_notifiers are true.
> 
> Do we really need to call panic_print_sys_info() here? All information
> provided by panic_print_sys_info(false) can be found also in
> the crash dump.
> 
>>  	/*
>>  	 * If we have crashed and we have a crash kernel loaded let it handle
>> @@ -283,6 +286,8 @@ void panic(const char *fmt, ...)
>>  	 */
>>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>>  
>> +	panic_print_sys_info(false);
> 
> This is where the info might be printed 2nd time.
> 
>> +
>>  	kmsg_dump(KMSG_DUMP_PANIC);
>>  
>>  	/*
> 
> Otherwise, the change makes sense to me.
> 
> Best Regards,
> Petr

Hi Petr, thanks for your great review!
I see you also commented in the thread of the patch introducing the
panic_print_sys_info() before kdump.

Thanks for catching this issue - indeed, if
"_crash_kexec_post_notifiers" is true, with this patch we print stuff
twice. I will submit a V3 that guards against that, using a bool, makes
sense to you?

The interesting question here is:
> Do we really need to call panic_print_sys_info() here? All information
> provided by panic_print_sys_info(false) can be found also in
> the crash dump.

So, we indeed need that in our use case. Crash is meant to be used
post-mortem, i.e., you made a full vmcore collection and then, of
course, you have basically all the data you need accessible though the
crash tool.

Problem is: in our use case, we want more data than a regular dmesg in a
panic event (hence we use panic_print), but we don't collect a full
crash dump, due to its big size. Also, as you can imagine, we do favor
pstore over kdump, but it might fail due to a variety of reasons (like
not having a free RAM buffer for ramoops), so kdump is our fallback.
Hence, we'd like to be able to use panic_print with both kdump and
pstore, and for that, both patches are needed.

Cheers,


Guilherme
