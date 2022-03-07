Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9C4CFFB1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiCGNNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242837AbiCGNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:13:06 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B6F7C161;
        Mon,  7 Mar 2022 05:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zdVOZSv8Dl1mXAQ3jsdVs/VHAcNFaHrMfeEDreIacvk=; b=AgoOurRk63K06dWCs+e44Y8/jF
        eM9yU2YU08p7svHM8ZN8XgB7VLuYYVdQVo/NoVQXbilOJ/vd1K5HIj2BN5yrXIhM8tGDdy+9nmjl6
        eIaM8XID73hFthDCP4PitHZ76yy0LAbr/st0TiMPnmFSEph/4i4WSYgy8p9gGKs8GLmED2oXWOnk2
        rbTvNiZvjbhSjeFwKR+MJbJB4mWCi2Dl1tTq7oYtVZbCqJqSmoUUAdd8BVaWidg3czLC16cnuc79d
        aC5TrhcJVC3KKNyxA79zZzkklPIsG0ZtcEbAWmNmM3E1a96IPONUXm0b2exw/3Vy+boowfZSlfaNA
        WQe5VZiQ==;
Received: from [187.56.66.217] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nRD9Z-0008j1-DB; Mon, 07 Mar 2022 14:11:57 +0100
Message-ID: <e1033adc-46ff-5dbc-e739-1bf725b6fed0@igalia.com>
Date:   Mon, 7 Mar 2022 10:11:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     "bhe@redhat.com" <bhe@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com> <YfPxvzSzDLjO5ldp@alley>
 <73011b6f-084b-43f5-cc01-1818a8a57e56@igalia.com>
 <YiV/HbXftVF2iAvU@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YiV/HbXftVF2iAvU@MiWiFi-R3L-srv>
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

On 07/03/2022 00:42, bhe@redhat.com wrote:
> [...]
>> Let me know your thoughts Petr / Baoquan - it would add slightly more
>> code / complexity, but in my opinion the payback is very good.
>> Cheers,
> 
> The ideal situation is each panic notifier has an order or index to
> indicate its priority. Wondering how to make it. What I think of is
> copying initcall. We have several priorities, at the same priority,
> execution sequence is not important. Not sure if I get your point.
> 
> ~~~~~~~
> #define core_initcall(fn)               __define_initcall(fn, 1)
> #define core_initcall_sync(fn)          __define_initcall(fn, 1s)
> ......
> #define late_initcall(fn)               __define_initcall(fn, 7)
> #define late_initcall_sync(fn)          __define_initcall(fn, 7s)
> 

Hi Baoquan, thanks for you consideration! In fact, the notifiers
infrastructure already have a mechanism of ordering, my idea is to make
use of that. It's not that different from the initcall system...

For instance, the code in the notifier register function checks for the
priority field in the notifier block:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/notifier.c#n31
.

For example, the Xen panic notifier is one of the few blocks that make
use of that, currently:

static struct notifier_block xen_panic_block = {
	.notifier_call = xen_panic_event,
	.priority = INT_MIN
};

(see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/xen/enlighten.c#n286)

In this case, xen_panic_event() will be the latest one to run. My idea
is to make use of that in *all* panic notifiers, having a table/list on
panic_notifier.h (defines or enum, I'll think about that when writing
this part) so all notifiers are documented and the ordering is clear and
enforced.

Makes sense to you?
Cheers,


Guilherme
