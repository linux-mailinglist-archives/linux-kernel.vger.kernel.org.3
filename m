Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5BD493DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356037AbiASQDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:03:43 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:59748 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbiASQDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lJftPEJHRwVtXT5VmrtZuYaqnJ5uAXD+32MKyePnyww=; b=mLZX70R1FqWT9zRoFcLbGhFWnm
        hSwlj4W88Od7ySlHXhrWLsBFzPikB/WOeEazMutsXJkIntsRXmT4fi5W7B7INkTQUNER/zo52kirO
        wQgWw4CkgpAEw2QVdgyOyM/RIYFHLtK1KNnurUgZ2YsQuMXSftSA/doGdApM16efOY6x/n4xhC/R/
        2svNgIknAg8fFstIlhc5AUm69TRrHUeYzR0i9gUhClPpB2FAzzE9hwh+DoTsrR11p6odK1sRWFiOm
        uKVMcDA97wBm60FLYTB39H2lfAoYlDjyG2iflEFDISKL67oNrsTDQrEtWxUpPL683kV1WRf75BYnG
        297ydupg==;
Received: from [179.98.77.138] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nADQp-000AGF-6S; Wed, 19 Jan 2022 17:03:31 +0100
Message-ID: <94bb12a2-a788-cee6-7d4f-dc0ac581fb39@igalia.com>
Date:   Wed, 19 Jan 2022 13:03:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>, Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <20220114183046.428796-1-gpiccoli@igalia.com>
 <20220119071318.GA4977@MiWiFi-R3L-srv> <YegytkfED+QI56Y8@alley>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YegytkfED+QI56Y8@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again Petr, for the deep analysis! Much appreciated.
Some comments inline below:


On 19/01/2022 12:48, Petr Mladek wrote:
>[...]
> From my POV, the function of panic notifiers is not well defined. They
> do various things, for example:
> [...] 
> 
> The do more that just providing information. Some are risky. It is not
> easy to disable a particular one.

We are trying to change that here:
https://lore.kernel.org/lkml/20220108153451.195121-1-gpiccoli@igalia.com/

Your review/comments are very welcome =)


> [...] 
> It might make sense to allow to call kmsg_dump before panic notifiers
> to reduce the risk of a breakage. But I do not have enough experience
> with them to judge this.
> 
> I can't remember any bug report in this code. I guess that only
> few people use kmsg_dump.

One of the problems doing that is that RCU and hung task detector, for
example, have panic notifiers to disable themselves in the panic
scenario - if we kmsg_dump() _before_ the panic notifiers, we may have
intermixed messages, all messy...so for me it makes sense to keep the
kmsg_dump() after panic notifiers.


> [...]
> Yes, panic_print_sys_info() increases the risk that the crash dump
> will not succeed. But the change makes sense because:
> 
>   + panic_print_sys_info() does nothing by default. Most users will
>     not enable it together with crash dump.
> 
>   + Guilherme uses crash dump only to dump the kernel log. It might
>     be more reliable than kmsg_dump. In this case, panic_print_sys_info()
>     is the only way to get the extra information.
> 
>   + panic_print_sys_info() might be useful even with full crash dump.
>     For example, ftrace messages are not easy to read from the memory
>     dump.

The last point is really good, I didn't consider that before but makes a
lot of sense - we can now dump (a hopefully small!) ftrace/event trace
buffer to dmesg before a kdump, making it pretty easy to read that later.
Cheers,


Guilherme
