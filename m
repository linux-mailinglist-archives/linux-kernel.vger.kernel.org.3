Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C81858CC3C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiHHQjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244083AbiHHQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:38:54 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C2B167CD
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:38:53 -0700 (PDT)
Received: from [192.168.86.80] (unknown [180.246.144.41])
        by gnuweeb.org (Postfix) with ESMTPSA id 3976E80615;
        Mon,  8 Aug 2022 16:38:46 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1659976732;
        bh=D9li3UZHC7gHF0JnLSNNjigsZnnKC880jXkuikq7ErI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mPN/mvvSNwj2RIjPRetwc9wK2r0n9+e//wXGVKdtJ8L89A4M5BwlJ0xtfUK7v03v/
         +2UGQXjkZRQEpsgLwp1FZSJahJp2EluMs/+SCk8QF19RYtrROgOEShSCfuzr9MpI9j
         LhCbl61evDdPrqKiNrUxtTBl78J/NgBjAp3t5uch+gENsIVRY/GBHpR2zkQs3O+DJz
         2viYLIu+DZhW5iarc5I5lGZte3jYMF8pI4VbECv8yDWkXArTFnFDkuLZuOnndpWPJr
         BQ5/CfmsfxpXA8dNPLvz0JW0+AKGaSvHDyi9aNVYW3U8Ky4MRuB8x7u5ih8H9l5J4b
         tFuVLcJOda58w==
Message-ID: <97c052a1-44e4-3c59-d4c8-34176d1d601a@gnuweeb.org>
Date:   Mon, 8 Aug 2022 23:38:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] x86: Change mov $0, %reg with xor %reg, %reg
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
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
 <20220804180805.9077-1-knscarlet@gnuweeb.org>
 <126271e264204581a42b079b51481740@AcuMS.aculab.com>
From:   Kanna Scarlet <knscarlet@gnuweeb.org>
In-Reply-To: <126271e264204581a42b079b51481740@AcuMS.aculab.com>
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

On 8/5/22 4:26 PM, David Laight wrote:
> Use "xor %rax,%rax" instead of "xor %eax,%eax" to save
> the 'reg' prefix.

hello David Laight

"xor %rax,%rax" is bigger because of rex prefix, "xor %eax,%eax" is smaller
because it doesn't need rex prefix.

asm:
    0:   48 31 c0  xor    %rax,%rax
    3:   31 c0     xor    %eax,%eax

so i think to save from rex prefix, use xor %eax,%eax instead of xor %rax,%rax.

Best regards,
-- 
Kanna Scarlet

