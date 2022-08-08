Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6211758CC6D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbiHHQ5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243717AbiHHQ5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:57:38 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8ADBCA6
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:57:37 -0700 (PDT)
Received: from [192.168.86.80] (unknown [180.246.144.41])
        by gnuweeb.org (Postfix) with ESMTPSA id EEB5580615;
        Mon,  8 Aug 2022 16:57:31 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1659977856;
        bh=/OGOJQIWPxdrSQ5ocjgVJh/1nFP46kbWJPlJHPapsoY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RN/+5u8/dW6DenwJNHcep7w1hiLq1mCuIj7lq/8P65rilL7lzfEhMOYyuWcP2Qwx0
         PesuvdqHmrqADncB60ifFn9wvq803kPhNzAWKuhnIbnXbsOtWLDdSCY7nu7dx+lS4W
         ccPw7Pvsv6K4dIMJTMvbipFwWOHzjMWiXe1rvCBWKW58LNRTYni4SNfMfNf10bJx2b
         stkFkfkTsdi44obPItTipd+0YedhswSL3NvBPkHLLfmMpn/2ViEm6xm0fZQITet1H8
         7v53erC0nwJTUG4tFkzsR4iLrTk5ZhDf23Z+Go5BzthAdS9u8Rj7aQzDdCi0qMUDVw
         nrTZmgf2V4DgQ==
Message-ID: <2fd07224-6c00-78d7-d9d3-625d99b6ecc1@gnuweeb.org>
Date:   Mon, 8 Aug 2022 23:57:19 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] x86: Change mov $0, %reg with xor %reg, %reg
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Bill Metzenthen <billm@melbpc.org.au>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Roth <michael.roth@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220804152656.8840-1-knscarlet@gnuweeb.org>
 <20220804152656.8840-2-knscarlet@gnuweeb.org> <Yuvrd2yWLnyxOVLU@zn.tnic>
 <20220804180805.9077-1-knscarlet@gnuweeb.org> <YuzowUBt4pTLcMRc@zn.tnic>
From:   Kanna Scarlet <knscarlet@gnuweeb.org>
In-Reply-To: <YuzowUBt4pTLcMRc@zn.tnic>
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

On 8/5/22 4:54 PM, Borislav Petkov wrote:
> On Thu, Aug 04, 2022 at 06:08:05PM +0000, Kanna Scarlet wrote:
>> Hello sir Borislav,
> 
> Please, no "sir" - just Boris or Borislav,

ok, sorry

> I don't think you need to do that - you can do this one patch in order
> to go through the whole process of creating and submitting a patch but
> you should not go on a "let's convert everything" spree just for the
> sake of it.

ok, i will try to finish the process for this one patch for learning the
submitting process. After that I will avoid touching similar small
improvement and focus on real kernel bugs/issues, i'll send v2 revision
with only commit message improvement

> Because maintainers barely have time to look at patches, you don't have
> to send them more when they're not really needed.
> 
> Rather, I'd suggest you go and try to fix real bugs. This has some ideas
> what to do:
> 
> https://www.linux.com/news/three-ways-beginners-contribute-linux-kernel/
> 
> Looking at the kernel bugzilla and trying to understand and reproduce a
> bug from there would get you a long way. And you'll learn a lot.
> 
> Also, you should peruse
> 
> https://www.kernel.org/doc/html/latest/process/index.html
> 
> which has a lot of information about how this whole community thing
> works.
> 
> I sincerely hope that helps.
> 
> Thx.

thank you for the guide, I'm following it

Regards,
-- 
Kanna Scarlet

