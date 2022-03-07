Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C94D0038
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbiCGNjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbiCGNjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:39:04 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F30D2E6B5;
        Mon,  7 Mar 2022 05:38:10 -0800 (PST)
Received: from [192.168.43.69] (unknown [182.2.38.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 77DCC7E6C3;
        Mon,  7 Mar 2022 13:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1646660289;
        bh=SPrR395Fio1xIoiYPHowYe9I1TFzu6lXoGUk7nXE7MI=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=Jq9W84JzC1kZQIJ+c+L2MvNXQuwzshExfw17fqYYar6573HmdZQIwmp6RV0AhVfwX
         54XFyno3gpee1rt1KZ9eY1TaRM55VeOQ5s265kdMq0tdydfIOBiZa7VRLRU/NAsZc2
         MbSJYBzAXJDCi2jQet8EN51Lxp+/MQbXdvzG7uWXeBf6MT37rdyp3sJ3/Db/N/t5TA
         OQ94E5BY6ZjynVT5KnIu2713KsfsSwMSXJblJVNUnrAzfp/vOGS/RERxa49/n0+xZv
         56B6k3oFheJ4RdjoXs4axKmvEDN8oLjO5jQhxsZEVLpFyy1C/FrXP0XVBh0znkSsLS
         LVCiHEYgs+UQg==
Message-ID: <11dec988-0b4f-00f2-6fa6-8d08be95d106@gnuweeb.org>
Date:   Mon, 7 Mar 2022 20:37:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gwml@vger.gnuweeb.org, x86@kernel.org
References: <20220307114558.1234494-1-ammarfaizi2@gnuweeb.org>
 <YiX81kD/668UdFBr@nazgul.tnic>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH v1 0/2] x86: Avoid using INC and DEC instructions on hot
 paths
In-Reply-To: <YiX81kD/668UdFBr@nazgul.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/22 7:38 PM, Borislav Petkov wrote:
> On Mon, Mar 07, 2022 at 06:45:56PM +0700, Ammar Faizi wrote:
>> In order to take maximum advantage of out-of-order execution,
>> avoid using INC/DEC instructions when appropriate. INC/DEC only
>> writes to part of the flags register, which can cause a partial
>> flag register stall. This series replaces INC/DEC with ADD/SUB.
> 
> "Improvements" like that need to show in benchmark runs - not
> microbenchmark - that they bring anything. Just by looking at them, I'd
> say they won't show any difference. But I'm always open to surprises.

OK, thanks for taking a look. I will play a bit more with this. Not sure
how much the visible improvement. If I can win some numbers (probably can't),
I will be back to this thread.

> Btw, you don't have to send all your patches directly to me - there are
> other x86 maintainers. IOW, you can use scripts/get_maintainer.pl to
> figure out who to send them to.

I did anyway, all CC list here I took from that script. I will try to give
other maintainers a turn next time.

> Also, I'd advise going over Documentation/process/ if you're new to this.
> Especially Documentation/process/submitting-patches.rst.
I might've missed the benchmark backup part. Will review those documents again.

-- 
Ammar Faizi

