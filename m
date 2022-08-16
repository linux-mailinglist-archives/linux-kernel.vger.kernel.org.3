Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1A595E75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiHPOlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHPOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:41:37 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36323B81FB;
        Tue, 16 Aug 2022 07:41:33 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oNxkr-0006js-Lz; Tue, 16 Aug 2022 16:41:17 +0200
Message-ID: <6b40ecc3-a2d3-3efd-4a19-2faf737f098b@leemhuis.info>
Date:   Tue, 16 Aug 2022 16:41:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 0/3] x86: make pat and mtrr independent from each other
To:     Chuck Zmudzinski <brchuckz@netscape.net>
Cc:     jbeulich@suse.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        regressions@lists.linux.dev, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Juergen Gross <jgross@suse.com>
References: <20220715142549.25223-1-jgross@suse.com>
 <efbde93b-e280-0e40-798d-dc7bf8ca83cf@leemhuis.info>
 <a0ce2f59-b653-fa8b-a016-1335f05c86ae@netscape.net>
 <32ed59c9-c894-c426-dd27-3602625cf3b1@netscape.net>
 <c88ea08c-a9d5-ef6a-333a-db9e00c6da6f@suse.com>
 <bd66b5bc-4d07-d968-f46c-40cf624499a7@netscape.net>
 <a29a66e0-2075-8084-84ad-8bd3e8a9fd4a@netscape.net>
 <a7d10605-87e3-c4bd-4a76-f07a04f5751c@leemhuis.info>
 <8d148826-62a5-95f9-8662-be14f56a6336@netscape.net>
Content-Language: en-US
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <8d148826-62a5-95f9-8662-be14f56a6336@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1660660893;25543714;
X-HE-SMSGID: 1oNxkr-0006js-Lz
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.08.22 20:17, Chuck Zmudzinski wrote:
> On 8/15/2022 2:00 PM, Thorsten Leemhuis wrote:
>
>> the right people have the issue on their radar again; give them time to
>> breath and work out a solution: it's not something that can be fixed
>> easily within a few minutes by one person alone, as previous discussions
>> have shown (also keep in mind that the merge window was open until
>> yesterday, which keeps many maintainers quite busy).
>>
>> And FWIW: I've seen indicators that a solution to resolve this is
>> hopefully pretty close now.
> 
> That's good to know. But I must ask, can you provide a link to a public
> discussion that indicates a fix is close?

I just searched for the commit id of the culprit yesterday like this:
https://lore.kernel.org/all/?q=bdd8b6c982*

Which brought me to this message, which looks like Boris applied a
slightly(?) modified version of Jan's patch to a branch that afaik is
regularly pushed to Linus:
https://lore.kernel.org/all/166055884287.401.612271624942869534.tip-bot2@tip-bot2/

So unless problems show up in linux-next I expect this will land in
master soon (and a bit later be backported to stable due to the CC
stable tag).

> Or do you know a fix is close
> because of private discussions? That distinction is important to me
> because open source software is much less useful to me if the solutions
> to problems are not discussed openly (except, of course, for solutions
> to security vulnerabilities that are not yet public).

You IMHO are expecting a bit too much here IMHO. Solutions to problems
in open source software get discussed on various, sometimes private
channels all the time. Just take conferences for example, where people
discuss them during talks, meetings, or in one-to-ones over coffee;
sometimes they are the only way to solve complex problems. But as you
can see from above link it's not like anybody is trying to sneak things
into the kernel.

Ciao, Thorsten
