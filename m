Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2AF496CAA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 14:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiAVNuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 08:50:09 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:42842 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiAVNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 08:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M85Dp1PCDT5EATRSGMkaq8YE1CWlkb1P8zz5WRSMb1M=; b=V+tpx26mZ9hfX8uVUPwzbJl+iZ
        Lbmf1b3dHlkOFC2YHPA09pXixS4y/tnfaEGlm8F+I2ffqyULD8E/HbBrAuKvi81d7F2kIXFGArYqp
        YNpd3H2KlprHPPv/hDsa3ikbkT17egjsMbZ3SqtRmVV8NMixvJMGLaP2OPg3R23E14PLpRBEuH+bT
        xs0AfkM4E2Li4MNacMWWAwQkcyTi1O8CGVceiMW5/no24obwr59TQEbeb4z8DDWJlbjBYlDGc8VlR
        SNuFLxe2LT6E3zwS5qmwTvKSOUypKIotMMU/LYuoRawPwprj+xXZOO2tjqTTi+dcsOVQU3y9EwbLU
        UZ63sR1g==;
Received: from [179.98.77.138] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nBGmD-0002nY-S2; Sat, 22 Jan 2022 14:49:58 +0100
Message-ID: <ed18ba1e-4792-22c5-3ece-4d518a8a4a2d@igalia.com>
Date:   Sat, 22 Jan 2022 10:49:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, kernel@gpiccoli.net,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
 <20220120085115.GB18398@MiWiFi-R3L-srv>
 <63621138-2a41-26c2-524e-d889068f157a@igalia.com>
 <20220121023119.GB4579@MiWiFi-R3L-srv>
 <c7796467-ee32-942f-6011-860a3600f4ef@igalia.com>
 <20220122103121.GB2596@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220122103121.GB2596@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2022 07:31, Baoquan He wrote:
> [...]
> From my old POV, I took pstore as a necessity on handheld devices or
> embeded system, e.g on Andriod. In that case, reserving crashkernel
> memory to enable kdump to save kernel log, it sounds not so
> cost-effective, since memory on those systems is usually not big.
> I am also interested in any new use case where people deploy these
> and why it's needed, to widen my view.

Hi Baoquan, that's great to hear. Indeed, I feel pstore is unfortunately
not very used in non-embedded devices - if you see kdump/error-report
userspace tooling, like on Red Hat/Fedora, Debian/Ubuntu and so on, they
never rely on pstore. And the configuration is not straightforward for
the users...I think that's a good thing to change, since pstore is much
less resource consuming than kdump.
But of course, not a discussion related to this patch specifically, just
me thinking out loud heh


> [...] 
> It's my bad. My thought is panic_print and kmsg_dump can be coupled, but
> they should decouple with panic_notifier. When panic_print is enabled,
> we do not expect to execute panic_notifier? My personal opinion.
> 
> I missed the change at line 8, sorry for the caused misunderstanding. 
> Now the chance of holding C-programmer-prize of the year comes back
> again.
> 
>   void panic()
>   {
> 1         if (!_crash_kexec_post_notifiers && !panic_print) {
> 2                 __crash_kexec(NULL);
> 3                 smp_send_stop();
> 4         } else {
> 5                 crash_smp_send_stop();
> 6         }
>   
>   	if (_crash_kexec_post_notifiers)
> 8  		atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> 9  	panic_print_sys_info(false);
> 10  	kmsg_dump(KMSG_DUMP_PANIC);
> 11  	if (_crash_kexec_post_notifiers || panic_print)
> 12                 __crash_kexec(NULL);
>   	...
>   	debug_locks_off();
>           console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>           panic_print_sys_info(true);

Hmm, yeah, I still don't think I'm a brilliant C programmer heh
Again, in the code above, I can't see how we would reach
"__crash_kexec(NULL)" after printing the extra info of panic_print, if
we don't have panic notifiers enabled.

So, indeed the code currently don't really tightly couple "panic_print"
with the panic notifiers. We could change that in another patch series,
based on what Petr suggested in the filter thread (I know you're
following there as well, thanks bu the way!), but for now, they are
completely independent. My plan, following Petr suggestions here and if
you agree, is to re-submit this patch with some changes, but in the end
the code will allow users that have kdump enabled + panic_print
-"crash_kexec_post_notifiers" to have "panic_print_sys_info(false)"
executing before the "__crash_kexec(NULL)".

But also, we can add "crash_kexec_post_notifiers" and it will still
work; finally, pstore is gonna be able to collect the logs from
"panic_print" as well (the main purpose of this patch).

Once that's all resolved, my goal is to jump into the panic notifiers
refactor suggested in the other thread. Let me know if you agree with
these steps/plans, and I'll work them.
Cheers,


Guilherme
