Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555D9591C2D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 19:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbiHMRox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 13:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiHMRov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 13:44:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3662314001;
        Sat, 13 Aug 2022 10:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ALNhYRCb/lVV57dBftkzVmCk3HiImur59ihXdRxOY2g=; b=PhdlriN0WmqMgOUx7q+gXAEOI7
        9ZYd8s3X1DgeueEP8dgY/R0t4A/BvFDz5Lt6jyC/Ht/wDa7tlpiy/NAaZqLQKwrRwE81/4UfaPLX/
        oTCTJHpg+p1raUGQjz1EXmx3/VGPsSJaXNL+/cotXn9tymdMH+pVsMweAi2DEu9+VgNAl/G7Tl+a7
        DshZxc88gvMtRhAB2ot1aHQsEGN1VXlSrdtbmbrq6y/e8MVyjkzsC9WNghG7XlkdewXzsDjpLFpHG
        1zHA1T85/6vRHteocqMO7NOMuM7f2Xb9MngbUPkInR0Xs25+t0sXUoUAbTdYPkcwGjPCqOXlqUmap
        YlHVRCWw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oMvBl-00GJfu-F9; Sat, 13 Aug 2022 17:44:45 +0000
Message-ID: <7b97d66d-610a-6750-f17f-4de41a97b528@infradead.org>
Date:   Sat, 13 Aug 2022 10:44:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] kernel/sys_ni: add compat entry for fadvise64_64
Content-Language: en-US
To:     Conor.Dooley@microchip.com, linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, josh@joshtriplett.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-api@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org
References: <20220807220934.5689-1-rdunlap@infradead.org>
 <03c5f897-d4e2-8408-6116-ad7619ca385d@microchip.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <03c5f897-d4e2-8408-6116-ad7619ca385d@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/13/22 10:03, Conor.Dooley@microchip.com wrote:
> On 07/08/2022 23:09, Randy Dunlap wrote:
>> When CONFIG_ADVISE_SYSCALLS is not set/enabled and CONFIG_COMPAT is
>> set/enabled, the riscv compat_syscall_table references
>> 'compat_sys_fadvise64_64', which is not defined:
>>
>> riscv64-linux-ld: arch/riscv/kernel/compat_syscall_table.o:(.rodata+0x6f8):
>> undefined reference to `compat_sys_fadvise64_64'
>>
>> Add 'fadvise64_64' to kernel/sys_ni.c as a conditional COMPAT function
>> so that when CONFIG_ADVISE_SYSCALLS is not set, there is a fallback
>> function available.
> 
> Is this in a 6.0 destined tree somewhere that I've missed?
> Bumped into it while looking at an unrelated LKP randconfig error.
> FWIW:
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> Thanks,
> Conor.

It's in Andrew's mm-hotfixes-unstable branch AFAIK.

Thanks.

>>
>> Fixes: d3ac21cacc24 ("mm: Support compiling out madvise and fadvise")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Albert Ou <aou@eecs.berkeley.edu>
>> Cc: linux-riscv@lists.infradead.org
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-api@vger.kernel.org
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> ---
>> v2: patch kernel/sys_ni.c (for any arch) instead of arch/riscv's
>>     unistd.h (Arnd)
>>
>>  kernel/sys_ni.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- a/kernel/sys_ni.c
>> +++ b/kernel/sys_ni.c
>> @@ -277,6 +277,7 @@ COND_SYSCALL(landlock_restrict_self);
>>  
>>  /* mm/fadvise.c */
>>  COND_SYSCALL(fadvise64_64);
>> +COND_SYSCALL_COMPAT(fadvise64_64);
>>  
>>  /* mm/, CONFIG_MMU only */
>>  COND_SYSCALL(swapon);
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
~Randy
