Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2433B5A0A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiHYHWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbiHYHWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:22:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48C998D14;
        Thu, 25 Aug 2022 00:22:00 -0700 (PDT)
Received: from [192.168.10.7] (unknown [39.53.61.43])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C54196601E99;
        Thu, 25 Aug 2022 08:21:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661412119;
        bh=1FJOnrm6c8hesYXgPMcGpfrEmMkWbLuf31u0r6LEn7M=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=KK82O9BRLherxYbIleAZI3kE+Iy99/KI05X6sPWP43obywSQ1feSwoJfe1LVjJr15
         j+YZs6idJH9bPD+qiNgHootvFWxLC2uUfWebh80rXxpHp85IBxuzHYSW8Dw/dnzIPg
         Q6JiYdEV0Io9ktDNiDZIRjlh3aSzpw5sK3cOf0VIVvsklnjBjjQXwSHzz0OOBniA5B
         HSnMmyzQL3lJ0wyULyBRNJzJBQBI6gY0JqCX7v0fH+PQg8tqegJlwB77TpCoSMQ3lz
         cKbrpVX7NeOayudVA47fH7PguEbK9um6eaAC98pJp932XDw68ABMYTNEuMxhUSe+rR
         eKf5NThHo5rcg==
Message-ID: <971109b3-3f80-c00a-1df6-12a8a3218700@collabora.com>
Date:   Thu, 25 Aug 2022 12:21:52 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Cc:     usama.anjum@collabora.com, Steven Noonan <steven@uplinklabs.net>,
        kernel@collabora.com
Subject: Re: [PATCH 1/3] x86/tsc: implement tsc=directsync for systems without
 IA32_TSC_ADJUST
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220808113954.345579-1-usama.anjum@collabora.com>
 <87v8qhybk8.ffs@tglx>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <87v8qhybk8.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 7:13 PM, Thomas Gleixner wrote:
> On Mon, Aug 08 2022 at 16:39, Muhammad Usama Anjum wrote:
>> From: Steven Noonan <steven@uplinklabs.net>
>>
>> AMD processors don't implement any mechanism like Intel's
>> IA32_TSC_ADJUST MSR to sync the TSC. Instead of just relying on the
>> BIOS, TSC can be synced by calculating the difference and directly
>> writing it to the TSC MSR.
> 
> Why? This has been tried before and is known to be flaky and
> unrealiable.
I'm sorry. I was trying to find the historic attempts about this. But I
didn't find it. Can someone point me to the history?

Do we have some information on how AMD synchronizes the TSC in BIOS? If
the ADJUST MSR like Intel's isn't present in AMD, they must be syncing
it by directly writing to the TSC MSR like this patch is doing.

> 
>> Add directsync flag to turn on the TSC sync when IA32_TSC_MSR isn't
>> available. Attempt 1000 times or for 30 seconds before giving up.
> 
> Looping 30 seconds with interrupts disabled? Seriously?
Yeah, that's too much. Some BSD variant uses 1000 attempts. We can
change the 1000 attempts to 5 or 10 attempts as in my experience, 5
attempts at max were always successful every time.

> 
> Thanks,
> 
>         tglx

-- 
Muhammad Usama Anjum
