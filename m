Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEF258CE3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbiHHTDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbiHHTDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:03:04 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5681151
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:03:03 -0700 (PDT)
Received: from [IPV6:2601:646:8600:40c0:425:cd56:6750:e1bf] ([IPv6:2601:646:8600:40c0:425:cd56:6750:e1bf])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 278IxMUU011390
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 8 Aug 2022 11:59:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 278IxMUU011390
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022080501; t=1659985169;
        bh=cZ9tmgrRSOq3dE+ZK3XrojSatKCt0m5O2C6/7unhmJI=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=bTucGkuaotdPLle7G5OOIOAwTCv00pcw4XAJ8ns5/HwJVsBPIAkP0U1dwOoSZCvbe
         2NlLS/LsJu3VOoqpQqLnQjW4Vv6dyNxMxBXq1BKeL16T82q1cI5PN51meBBZdJFh3D
         a/oR2PgckLO3WJo5TwrMgAyqWrjYAZ5IO+MrrPSS+i0vlNuI/GcIKRHHYAL+1+NeaY
         XOyExmOBkio+FrjVebnFC/S6xqw/eHYZlrl4uC+STEvitCu+TzNr0imWHFmaTMw7N4
         zBWDkbrcaFIKAO5oGTfprUVdlrVZ6N5NIiVeoW+NE+dUcQIkvK2XOyF5vVaCH7+co7
         rw7FeiuqVtYAQ==
Message-ID: <ad5f732f-778f-a337-38e5-0129d2f49793@zytor.com>
Date:   Mon, 8 Aug 2022 11:59:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/1] x86: Change mov $0, %reg with xor %reg, %reg
To:     Kanna Scarlet <knscarlet@gnuweeb.org>,
        Joerg Roedel <jroedel@suse.de>
Cc:     David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
 <Yuzl7+qPtK1i2aSj@suse.de> <4764d363-b5a4-0cf5-6ed0-0911c4182b5b@gnuweeb.org>
Content-Language: en-US
In-Reply-To: <4764d363-b5a4-0cf5-6ed0-0911c4182b5b@gnuweeb.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 8, 2022 9:45:45 AM PDT, Kanna Scarlet <knscarlet@gnuweeb.org> 
wrote:
>On 8/5/22 4:42 PM, Joerg Roedel wrote:
>> On Fri, Aug 05, 2022 at 09:26:02AM +0000, David Laight wrote:
>>> Use "xor %rax,%rax" instead of "xor %eax,%eax" to save
>>> the 'reg' prefix.
>> 
>> Also, some places explicitly use the mov variant to zero a register
>> without touching rflags. Please be careful to not change those.
>
>thank you for reminder, i will check again to make myself more sure
>the patch doesn't break this %rflags dependency situation
>
>Regards,

In some cases you can hoist the zeroing to avoid that (and sometimes 
improve performance in the process), but be very careful in general when 
messing with hand-optimized assembly code like crypto; for those pieces 
of code benchmarking the change is mandatory.
