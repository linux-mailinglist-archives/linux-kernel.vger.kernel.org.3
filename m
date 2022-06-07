Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5411F540174
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245546AbiFGOcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiFGOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:32:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319615B3CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:32:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u18so14984022plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VPOLce4T8uKTl8bDuvP4aIArWmHTCA4t119LiXZasqg=;
        b=BdkETQXDehKm3RcVOVc9IQ+5+eLDKcr/JN6J0vfmovydms+JFO5qQflU50SLT2xkjL
         CGp03OfGGatm2GSbk90GTyq4BHJi3G9gZJFLU+L2misnEd2asnYJ+67b7RUAAhXziIqR
         FHN09RKAdBe/DQ/fup4DHjPtQTdxgrbRDNf065bei0nE414/z1Oh4ThLAKz0hMUHhMuy
         x9cn0jeuE18MYnd4KogDFU3Q+zDpnoCSn0C308ksuyAOyhxrinC0f+7bDJKqCtCMqjaZ
         QmQZQOsMz6ky+yVMTgILZSpT9lOiptwPU4tj5plX7Rh4C5+Qbi/bxLvPM8mdmgAYHEJC
         yVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VPOLce4T8uKTl8bDuvP4aIArWmHTCA4t119LiXZasqg=;
        b=TfR8fmDYMnmqkFdF9w0FyLmMb6obPv9k2LLkoah7wHm5USDC6amtC1YplJA8q1O8Bf
         pkuRhWATPLoLx7bUioexF2Zs/rYphNbhSgWBJsRNcteIgEFbrc97/jcOnJAxb9SAOIYL
         NwaSoa5GhNsF5LyEJ2CqlVv9toRo6b6TemLN8xlFQknDm8fuNB6yrqZV5NoUiEBKpKAa
         PiGc24gYLeOQgCp8hm3ac2b9uCMnJNfkiGV3fxCDnQdnzUSm+75jXqW+mgOLCVKJLT10
         b4Xz5jZYS3RRNvn2AvMJCXxmKZDV+hjr8qj7UEwSugkWvHfHJM6TGYQ/T5XyJu+0q5/X
         R/bA==
X-Gm-Message-State: AOAM530tB8ylvt0uFCvUfA1bkfUNRaSTjw1IVkgFN2f4/Id/vdzGS019
        Z8ixLEEcDR+zz7w8i0exkks=
X-Google-Smtp-Source: ABdhPJyv9HnBgv55K19xenISwxECGP7eD7YX/uyVGu+CijT7ncOI+nSmLo2B8LGbyhrDTSeymhVBCQ==
X-Received: by 2002:a17:903:1c5:b0:167:71bd:462f with SMTP id e5-20020a17090301c500b0016771bd462fmr13880919plh.65.1654612350883;
        Tue, 07 Jun 2022 07:32:30 -0700 (PDT)
Received: from [192.168.1.104] ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id jb15-20020a170903258f00b001688f2ff292sm243875plb.222.2022.06.07.07.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 07:32:30 -0700 (PDT)
Message-ID: <8fc24ba3-1467-b845-a70e-7ed77750e6cd@gmail.com>
Date:   Tue, 7 Jun 2022 22:32:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/4] mm: kmemleak: add OBJECT_PHYS flag for objects
 allocated with physical address
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
 <20220603035415.1243913-2-patrick.wang.shcn@gmail.com>
 <Yp3rO4WpLzxLA6+7@arm.com>
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
In-Reply-To: <Yp3rO4WpLzxLA6+7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/6 19:55, Catalin Marinas wrote:
> On Fri, Jun 03, 2022 at 11:54:12AM +0800, Patrick Wang wrote:
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index a182f5ddaf68..1e9e0aa93ae5 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -172,6 +172,8 @@ struct kmemleak_object {
>>   #define OBJECT_NO_SCAN		(1 << 2)
>>   /* flag set to fully scan the object when scan_area allocation failed */
>>   #define OBJECT_FULL_SCAN	(1 << 3)
>> +/* flag set for object allocated with physical address */
>> +#define OBJECT_PHYS		(1 << 4)
>>   
>>   #define HEX_PREFIX		"    "
>>   /* number of bytes to print per line; must be 16 or 32 */
>> @@ -575,7 +577,8 @@ static int __save_stack_trace(unsigned long *trace)
>>    * memory block and add it to the object_list and object_tree_root.
>>    */
>>   static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
>> -					     int min_count, gfp_t gfp)
>> +					     int min_count, gfp_t gfp,
>> +					     bool is_phys)
> 
> The patch looks fine but I wonder whether we should have different
> functions for is_phys true/false, we may end up fewer changes overall
> since most places simply pass is_phys == false:

This should be better. Will do.

> 
> static struct kmemleak_object *__create_object(unsigned long ptr, size_t size,
> 					       int min_count, gfp_t gfp,
> 					       bool is_phys);
> 
> static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
> 					     int min_count, gfp_t gfp)
> {
> 	return __create_object(ptr, size, min_count, gfp, false);
> }
> 
> static struct kmemleak_object *create_object_phys(unsigned long ptr, size_t size,
> 						  int min_count, gfp_t gfp)
> {
> 	return __create_object(ptr, size, min_count, gfp, true);
> }
> 
> Same for the other patches that change a few more functions.

Since the physical objects are only used as gray objects.
Changes on irrelevant places will be removed.

The leak check could be taken on physical objects. Conversion
of block address from virtual to physical before lookup should
make this work (this is useless currently). I think we'd better
know about this.

Thanks,
Patrick

