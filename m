Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F4658CC51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiHHQqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHHQp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:45:58 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8E4FC6
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:45:58 -0700 (PDT)
Received: from [192.168.86.80] (unknown [180.246.144.41])
        by gnuweeb.org (Postfix) with ESMTPSA id 5C51D80615;
        Mon,  8 Aug 2022 16:45:52 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1659977157;
        bh=ANKv5xRVE6/hvX3Ng1nOfjwYpAyNN7bQS4f6fGJ97Qg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fStCmJxuw+YLVF1Ma74PrMmnZ+Snyv2sjAiSVVspI7eSoicYwZ3qAril5tkoiQXNn
         kYYomIRY2qGeM1g1Yhv0rGwZz2I398liD7tmhEl//Ku7kf++kqSY585ZaFDTa1WAyR
         7iyIp1XX4RVblQoqTqwksXKqZib9EK6mzq31TLarzqUReWR3vmAtW5Ld4SO5E8uRQe
         tZZRXlnXegY6tqmvf2jYQawjmkYv3NPdA4NmwQItKBSza8M+R2riYssn/4GgpVOXAv
         wR76UozrxCQ2VbYhKB0+IcOsHe4mUCz/24bCP/QAxttg/iUJF6CCYv845eTJjcrKm2
         XHNkOA9SkwkIg==
Message-ID: <4764d363-b5a4-0cf5-6ed0-0911c4182b5b@gnuweeb.org>
Date:   Mon, 8 Aug 2022 23:45:45 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] x86: Change mov $0, %reg with xor %reg, %reg
Content-Language: en-US
To:     Joerg Roedel <jroedel@suse.de>
Cc:     David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bill Metzenthen <billm@melbpc.org.au>,
        Brijesh Singh <brijesh.singh@amd.com>,
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
 <20220804180805.9077-1-knscarlet@gnuweeb.org>
 <126271e264204581a42b079b51481740@AcuMS.aculab.com>
 <Yuzl7+qPtK1i2aSj@suse.de>
From:   Kanna Scarlet <knscarlet@gnuweeb.org>
In-Reply-To: <Yuzl7+qPtK1i2aSj@suse.de>
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

On 8/5/22 4:42 PM, Joerg Roedel wrote:
> On Fri, Aug 05, 2022 at 09:26:02AM +0000, David Laight wrote:
>> Use "xor %rax,%rax" instead of "xor %eax,%eax" to save
>> the 'reg' prefix.
> 
> Also, some places explicitly use the mov variant to zero a register
> without touching rflags. Please be careful to not change those.

thank you for reminder, i will check again to make myself more sure
the patch doesn't break this %rflags dependency situation

Regards,
-- 
Kanna Scarlet
