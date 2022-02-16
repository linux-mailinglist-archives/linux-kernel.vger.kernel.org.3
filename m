Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11F44B8E90
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiBPQwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:52:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiBPQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:52:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0081694975
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ZWwWqMNmYOaZCk1I7vCXiuWZi1pbjRDbYtZ05aCiVow=; b=fMVkJKXJDQlmJuz4yB5DqcxMz0
        1HAFqRuxuiUbKqonZdxPie6816LTC5CdbV7N9nVZ7QeZkPuWnrIEy/bKGlwbU2+ULolcMS0Eq3FOl
        /+vKcpveKMNX6Q4RF0CC4K/bkRI0K4klkg9l9zh4ljndIcSlEbPjNIbgEaMThq1AuNHylldwz4swL
        +1xhuPkswwNKcBukcFZn7VdDyDbzZofTx/ysdy1157XrvfBTSJJwxkHGrWDN/LsSTAvCsyXVAdpLu
        IvZdelMeeK6wcFL71/ir5Um2B+dAKcwAODDVYelLylBd+Weov7ftLTS4gGx/1+jkzGD0igh3MU7dd
        GOvgQzyw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKNXO-00EsZZ-Jt; Wed, 16 Feb 2022 16:52:19 +0000
Message-ID: <0ddaa732-4112-0e3e-e395-bc92af2a194f@infradead.org>
Date:   Wed, 16 Feb 2022 08:52:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: Build regressions/improvements in v5.17-rc4
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220214093704.1773948-1-geert@linux-m68k.org>
 <6f4af4c2-3ac0-a4d0-96c7-7164417cb8d7@infradead.org>
 <CAMuHMdW9Po1V5yH+gHzUJGx8NLcoCUyBa4FF41eH9vDbQWBW8w@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdW9Po1V5yH+gHzUJGx8NLcoCUyBa4FF41eH9vDbQWBW8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/22 00:05, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Tue, Feb 15, 2022 at 10:14 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 2/14/22 01:37, Geert Uytterhoeven wrote:
>>> Below is the list of build error/warning regressions/improvements in
>>> v5.17-rc4[1] compared to v5.16[2].
>>>
>>> Summarized:
>>>   - build errors: +14/-2
>>>   - build warnings: +23/-25
> 
>>> 23 warning regressions:
>>>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14410): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>>
>> This is a little confusing. Was there a problem with qed and qede network drivers?
>> Is it still a problem?
> 
> Yes there is.
> 
>> Many of the lines above and below are very similar.
> 
> Sorry, my script to filter out errors/warnings that just moved does
> not handle modpost output yet.

I see. No problem.

>> If there is still a problem, what $ARCH and config(s) cause it?
>> I can't reproduce it on 11 $ARCH tries.
>> Or maybe it is compiler-specific also.
> 
> xtensa-gcc11/xtensa-allmodconfig
> http://kisskb.ellerman.id.au/kisskb/buildresult/14697521/
> I don't know why it doesn't show up in the other gcc11 builds.
> 
> I had a look at the problem before, but fixing it is non-trivial:
> the driver uses a non-init table of structures that contains pointers
> to init data (only used early) and non-init data (used later, too).
> Sprinkling __ref over the code may help, but won't protect against
> introducing new bugs.

Got it. Thanks again.

-- 
~Randy
