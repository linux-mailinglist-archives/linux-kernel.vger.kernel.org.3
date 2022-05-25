Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75A453365E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbiEYFZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiEYFZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:25:33 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF350B21
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:25:32 -0700 (PDT)
Received: from mail.ispras.ru (unknown [83.149.199.84])
        by mail.ispras.ru (Postfix) with ESMTPSA id 0670140D403D;
        Wed, 25 May 2022 05:25:31 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 25 May 2022 08:25:30 +0300
From:   baskov@ispras.ru
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86: Parse CONFIG_CMDLINE in compressed kernel
In-Reply-To: <YnztqAtNEvnF5YcX@zn.tnic>
References: <20220505103224.21667-1-baskov@ispras.ru>
 <20220505103224.21667-3-baskov@ispras.ru> <YnztqAtNEvnF5YcX@zn.tnic>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <d783442602a1c546d3727b939f5cd199@ispras.ru>
X-Sender: baskov@ispras.ru
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-12 14:21, Borislav Petkov wrote:
> On Thu, May 05, 2022 at 01:32:24PM +0300, Baskov Evgeniy wrote:
> 
> Same note on the subject format as for your previous patch.
> 

Thanks.

>> CONFIG_CMDLINE, CONFIG_CMDLINE_BOOL, and CONFIG_CMDLINE_OVERRIDE were
>> ignored during options lookup in compressed kernel.
>> 
>> Parse CONFIG_CMDLINE-related options correctly in compressed kernel
>> code.
>> 
>> cmd_line_ptr_init is explicitly placed in .data section since it is
>> used and expected to be equal to zero before .bss section is cleared.
> 
> What I'm missing in this commit message is the use case which you have
> in your 0/2 mail.
> 
> Also, to the tone of your commit messages, from
> Documentation/process/submitting-patches.rst:
> 
>  "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>   instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>   to do frotz", as if you are giving orders to the codebase to change
>   its behaviour."
> 
> Also, do not talk about what your patch does - that should hopefully be
> visible in the diff itself. Rather, talk about *why* you're doing what
> you're doing.
> 

Will fix.

> 
> I had asked this already but let me try again: instead of copying this
> from kernel proper, why don't you add a common helper which you call
> from both locations?
> 
> And it is not like this is going to be a huge function so you can stick
> it into a shared header in arch/x86/include/asm/shared/ and it'll get
> inlined into both locations...

Oh, now I got what you meant, I'll factor that out in the next version.
There are currently no arch/x86/include/asm/shared/ directory,
so, I guess, it will be OK to put the header just in
arch/x86/include/asm/?

--
Baskov Evgeniy
