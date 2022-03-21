Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F7F4E2553
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346803AbiCULjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbiCULjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:39:52 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDA83E0F9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:38:27 -0700 (PDT)
Received: from [192.168.12.80] (unknown [182.2.38.58])
        by gnuweeb.org (Postfix) with ESMTPSA id 9F95D7E2DA;
        Mon, 21 Mar 2022 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647862706;
        bh=sGCCsF1nBmMsD5TBZTyQUXibY7ZkHQnUkBbAPcG5uE0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ym5Ey51x4Qv5YDlnzEF9C4q8NT3VVA/FLm8bAzUY64Oxb1uIjBS5xjXWl+5x4FTEe
         6bA+8t7YiM+lBdumsVe4koo6BpegaEd6JaTyyCK4yOgrP/yeeHouslhKdEr8F4impT
         Ne7DaGmidZvldeXwUvQEqwIhn3r3iwTcJHkRNNI3gtH3KIKT63nPtRda6sESlRIQcw
         qD0yTUeRHJQvG9XyViZf7ge/xEhRvA8nJZwa/9idnGzj3PRghCPmCK0KiT3y9uGi7R
         4k7J3c2G/UuG+zcDqCkzMvzrhiXDuDN+57ZaBG0v81rUJk6lDKDUgrLsves2Wxry3Z
         ARKj7Vfu6U1Xg==
Message-ID: <9e69af8e-74c1-f35b-98dd-e2a77153ea09@gnuweeb.org>
Date:   Mon, 21 Mar 2022 18:38:18 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v1 2/6] tools/nolibc: Make the entry point not weak
 for clang
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        llvm@lists.linux.dev
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-3-ammarfaizi2@gnuweeb.org>
 <20220320191619.GA27312@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220320191619.GA27312@1wt.eu>
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

On 3/21/22 2:16 AM, Willy Tarreau wrote:
> Hi Ammar,
> 
> I've had a look at this one.
> 
> On Sun, Mar 20, 2022 at 04:37:46PM +0700, Ammar Faizi wrote:
>> Budilig with clang yields the following error:
>    ^^^^^^^
> BTW please fix the typo in the final commit message.
> 
>> @@ -183,7 +183,9 @@ struct sys_stat_struct {
>>   
>>   /* startup code */
>>   asm(".section .text\n"
>> +#if !defined(__clang__)
>>       ".weak _start\n"
>> +#endif
>>       ".global _start\n"
>>       "_start:\n"
> 
> So it seems that I was wrong and that .weak is an alternate for .global
> and not a complement. As such, instead of adding all these #if, please
> simply remove all .global.

Will fix this in the next version.

-- 
Ammar Faizi
