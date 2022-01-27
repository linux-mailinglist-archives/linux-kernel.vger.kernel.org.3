Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A991749E8A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244400AbiA0RQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:16:45 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:59146 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiA0RQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cImWtFyHM1tAc1vEBjvw8nQrN3d7f56KDXmjT7Ki8Sg=; b=C1QtDdhFeqHe1qv2PGOhZzsKNJ
        ry62lcTCiunx8yiMAAofVVYNIImO9Q2eg0EnPsy20kkhfAsqpjQBwH9nPcvkatgrdsVxsLZtLsXWP
        DEsyiQi3rbh4tonByXER5ZnXpiDaahv2yaoLRMqC+cxV5YGepmBUo5xjOwf/RU1jdBlmZKcWxV2l8
        GmK/nelxMe1xzvoBSyjPYcDy/bksCY8cAoO6agI2ZZPBCAa3B9HzSJlv8wjueCcpZhl0UVStVK5xj
        KK0F7RCB5LoA9IVOORUag+JHzbKd5chJI6nGMS/LeRIQ2Xx9s2DPKbWfSULxkMGh0LWHDGstGstta
        g3GO2iZg==;
Received: from 200-207-58-141.dsl.telesp.net.br ([200.207.58.141] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nD8Ny-00090E-5G; Thu, 27 Jan 2022 18:16:38 +0100
Message-ID: <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com>
Date:   Thu, 27 Jan 2022 14:16:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
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
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2022 10:06, d.hatayama@fujitsu.com wrote:
> 
> But the pre_dump cannot avoid calling multiple unnecessary handlers, right?
> It's more risky than the previous idea...
> 

I think we could have 2 kernel parameters then:

crash_kernel_disable_pre_notitifers (of course we can think in some
better name here heh)

crash_kernel_enable_post_notifiers (which is the same as the current
"crash_kernel_post_notifiers", we can keep it)

The point being (if I understand correctly): some callbacks are really
simple and don't introduce risks for kdump, like the RCU; a bunch of
them just set one variable. Those could be enable by default, before the
kdump.

The majority would fit in the 2nd group, meaning they are not enabled by
default, requiring some parameter for that.

Petr, let me know if that makes sense and is aligned with your suggestion.


> For example, how about simply maintaining function symbol names in the list
> as string, not address.
> 

I considered that before, it was my first idea but it's not great due to
memory allocation. We'd need to use memblock to allocate a struct to
hold function names, and the comparison on register time is slower, I
guess... so it's much easier to pre-allocate some handlers and only
track the addresses of the function. I personally do not see much use in
this filter for module callbacks, but if that's a use case, we can think
on how to do that. But notice that the current implementation of the
filter wont hold if we end-up following the suggestions in this thread,
not sure even if we're gonna have a filter...

Cheers,


Guilherme
