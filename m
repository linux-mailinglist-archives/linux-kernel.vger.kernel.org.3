Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4329153E0E3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiFFF2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiFFF2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:28:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96781C9EEC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:12:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gd1so11927805pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 22:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=op8id7H7tQz7uDFI1943qxMJT3tGZ4qLWFIbW7eordo=;
        b=syxVqCWjBDcNEHo+Mj3sAZ7hY+20pUZiEZVwuDyTzlZjp3RlFmxGJmrI3l00aQZSH3
         PuxwmJ/LuI/zvB0wuprJ9ckI0LK8bt6Pe/HU45vgqe7L6+7GQRoCItXup/TGuqjoAwZm
         dY6n/p9ncxGx+21giddtFYQbVmPrMUd0K5mJvhfvD0FEcBn/fDfLlNrdB5z/aQeHy8ON
         FgR1ltyAXnWjnc83QD/I8HHpWQ4SAHhiEi7mmpt1LGfWSig1fvNaMl4Q3+fJZ6cBHK9e
         0CR5akA0MPxl8mSsjl2c9g4IWbJuR7eVoBn3GRCPJnZjZ+zrUHKZ76T42t5TUvQzOQvi
         Z/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=op8id7H7tQz7uDFI1943qxMJT3tGZ4qLWFIbW7eordo=;
        b=wo+aX2POgExxej4ZQqjrbACrWh2Y1OAWzbFzp/vODyhXbfJ4P5v6CmqRdr4o36MzGr
         9p5wX5PDpvATyS2GTdggkjmq6YFoLRaeOkkij5ghNemXWKXdOscf3i1HG9w/tBynP9xk
         /WPptXZdzCj2s8GWT60Fy8amqtYbbQHTXHyguv6G/OsEnBHjOYhNjkUYZO8crSJACCpJ
         jslzW/6YWwVGJmKJsuBwNBS3C60aIzxS3rLAaFA7LK8O5R2915HZ5jzpxmoIT3w5tDfb
         CF7Y06VluBJQG5tPKbQ2unn3sAMDLRG3AjS3WR1g3ckd5+pQ/DbKFwUyUbd9C5y8IZz0
         9RIw==
X-Gm-Message-State: AOAM531nINfizJo3GJnd6xP6o7p/rjNbToPCPo8O+X+OslmjeH0n37Eh
        hAXDoRUuv5vHr7iE7RwxfBi4Ag==
X-Google-Smtp-Source: ABdhPJwNxGaE7R67xBOKYQzm5B3m4jsUAVAnDH4JDWCTQnytZtT+xonF88NcjVRHsxJTzYIIn/T/Hw==
X-Received: by 2002:a17:90b:350b:b0:1e8:46b9:5bc5 with SMTP id ls11-20020a17090b350b00b001e846b95bc5mr14126691pjb.100.1654492363072;
        Sun, 05 Jun 2022 22:12:43 -0700 (PDT)
Received: from [10.61.2.177] (110-175-254-242.static.tpgi.com.au. [110.175.254.242])
        by smtp.gmail.com with ESMTPSA id b4-20020a1709027e0400b00164097a779fsm1873324plm.147.2022.06.05.22.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 22:12:42 -0700 (PDT)
Message-ID: <7d30583e-7e58-5184-be2d-773882dd9092@ozlabs.ru>
Date:   Mon, 6 Jun 2022 15:12:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:101.0) Gecko/20100101
 Thunderbird/101.0
Subject: Re: [PATCH kernel v2] zstd: Fixing mixed module-builtin objects
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20220429053329.2278740-1-aik@ozlabs.ru>
 <YoLjpivvU7dRVTuL@dev-arch.thelio-3990X>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <YoLjpivvU7dRVTuL@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?


On 5/17/22 09:52, Nathan Chancellor wrote:
> Hi Nick,
> 
> Did you have any thoughts on this patch? It is necessary for enabling
> LTO with PowerPC:
> 
> https://lore.kernel.org/20220429064547.2334280-1-aik@ozlabs.ru/
> 
> If you don't have anything to send to Linus for the next cycle, perhaps
> this patch could be carried by the PowerPC folks with your ack?
> 
> Cheers,
> Nathan
> 
> On Fri, Apr 29, 2022 at 03:33:29PM +1000, Alexey Kardashevskiy wrote:
>> With CONFIG_ZSTD_COMPRESS=m and CONFIG_ZSTD_DECOMPRESS=y we end up in
>> a situation when files from lib/zstd/common/ are compiled once to be
>> linked later for ZSTD_DECOMPRESS (build-in) and ZSTD_COMPRESS (module)
>> even though CFLAGS are different for builtins and modules.
>> So far somehow this was not a problem but enabling LLVM LTO exposes
>> the problem as:
>>
>> ld.lld: error: linking module flags 'Code Model': IDs have conflicting values in 'lib/built-in.a(zstd_common.o at 5868)' and 'ld-temp.o'
>>
>> This particular conflict is caused by KBUILD_CFLAGS=-mcmodel=medium vs.
>> KBUILD_CFLAGS_MODULE=-mcmodel=large , modules use the large model on
>> POWERPC as explained at
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?h=v5.18-rc4#n127
>> but the current use of common files is wrong anyway.
>>
>> This works around the issue by introducing a zstd_common module with
>> shared code.
>>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v2:
>> * add a new module instead of inlining common bits
>>
>> ---
>>   lib/zstd/Makefile                | 18 ++++++++----------
>>   lib/zstd/common/entropy_common.c |  4 +++-
>>   lib/zstd/common/zstd_common.c    |  7 +++++++
>>   lib/Kconfig                      |  8 ++++++--
>>   4 files changed, 24 insertions(+), 13 deletions(-)
>>
>> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
>> index fc45339fc3a3..440bd0007ae2 100644
>> --- a/lib/zstd/Makefile
>> +++ b/lib/zstd/Makefile
>> @@ -10,14 +10,10 @@
>>   # ################################################################
>>   obj-$(CONFIG_ZSTD_COMPRESS) += zstd_compress.o
>>   obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
>> +obj-$(CONFIG_ZSTD_COMMON) += zstd_common.o
>>   
>>   zstd_compress-y := \
>>   		zstd_compress_module.o \
>> -		common/debug.o \
>> -		common/entropy_common.o \
>> -		common/error_private.o \
>> -		common/fse_decompress.o \
>> -		common/zstd_common.o \
>>   		compress/fse_compress.o \
>>   		compress/hist.o \
>>   		compress/huf_compress.o \
>> @@ -33,12 +29,14 @@ zstd_compress-y := \
>>   
>>   zstd_decompress-y := \
>>   		zstd_decompress_module.o \
>> -		common/debug.o \
>> -		common/entropy_common.o \
>> -		common/error_private.o \
>> -		common/fse_decompress.o \
>> -		common/zstd_common.o \
>>   		decompress/huf_decompress.o \
>>   		decompress/zstd_ddict.o \
>>   		decompress/zstd_decompress.o \
>>   		decompress/zstd_decompress_block.o \
>> +
>> +zstd_common-y := \
>> +		common/debug.o \
>> +		common/entropy_common.o \
>> +		common/error_private.o \
>> +		common/fse_decompress.o \
>> +		common/zstd_common.o \
>> diff --git a/lib/zstd/common/entropy_common.c b/lib/zstd/common/entropy_common.c
>> index 53b47a2b52ff..f84612627471 100644
>> --- a/lib/zstd/common/entropy_common.c
>> +++ b/lib/zstd/common/entropy_common.c
>> @@ -15,6 +15,7 @@
>>   /* *************************************
>>   *  Dependencies
>>   ***************************************/
>> +#include <linux/module.h>
>>   #include "mem.h"
>>   #include "error_private.h"       /* ERR_*, ERROR */
>>   #define FSE_STATIC_LINKING_ONLY  /* FSE_MIN_TABLELOG */
>> @@ -239,7 +240,7 @@ size_t FSE_readNCount(
>>   {
>>       return FSE_readNCount_bmi2(normalizedCounter, maxSVPtr, tableLogPtr, headerBuffer, hbSize, /* bmi2 */ 0);
>>   }
>> -
>> +EXPORT_SYMBOL_GPL(FSE_readNCount);
>>   
>>   /*! HUF_readStats() :
>>       Read compact Huffman tree, saved by HUF_writeCTable().
>> @@ -255,6 +256,7 @@ size_t HUF_readStats(BYTE* huffWeight, size_t hwSize, U32* rankStats,
>>       U32 wksp[HUF_READ_STATS_WORKSPACE_SIZE_U32];
>>       return HUF_readStats_wksp(huffWeight, hwSize, rankStats, nbSymbolsPtr, tableLogPtr, src, srcSize, wksp, sizeof(wksp), /* bmi2 */ 0);
>>   }
>> +EXPORT_SYMBOL_GPL(HUF_readStats);
>>   
>>   FORCE_INLINE_TEMPLATE size_t
>>   HUF_readStats_body(BYTE* huffWeight, size_t hwSize, U32* rankStats,
>> diff --git a/lib/zstd/common/zstd_common.c b/lib/zstd/common/zstd_common.c
>> index 3d7e35b309b5..06f62b2026d5 100644
>> --- a/lib/zstd/common/zstd_common.c
>> +++ b/lib/zstd/common/zstd_common.c
>> @@ -13,6 +13,7 @@
>>   /*-*************************************
>>   *  Dependencies
>>   ***************************************/
>> +#include <linux/module.h>
>>   #define ZSTD_DEPS_NEED_MALLOC
>>   #include "zstd_deps.h"   /* ZSTD_malloc, ZSTD_calloc, ZSTD_free, ZSTD_memset */
>>   #include "error_private.h"
>> @@ -59,6 +60,7 @@ void* ZSTD_customMalloc(size_t size, ZSTD_customMem customMem)
>>           return customMem.customAlloc(customMem.opaque, size);
>>       return ZSTD_malloc(size);
>>   }
>> +EXPORT_SYMBOL_GPL(ZSTD_customMalloc);
>>   
>>   void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
>>   {
>> @@ -71,6 +73,7 @@ void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem)
>>       }
>>       return ZSTD_calloc(1, size);
>>   }
>> +EXPORT_SYMBOL_GPL(ZSTD_customCalloc);
>>   
>>   void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
>>   {
>> @@ -81,3 +84,7 @@ void ZSTD_customFree(void* ptr, ZSTD_customMem customMem)
>>               ZSTD_free(ptr);
>>       }
>>   }
>> +EXPORT_SYMBOL_GPL(ZSTD_customFree);
>> +
>> +MODULE_LICENSE("Dual BSD/GPL");
>> +MODULE_DESCRIPTION("Zstd Common");
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 087e06b4cdfd..33f3a7054cdd 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -333,12 +333,16 @@ config LZ4HC_COMPRESS
>>   config LZ4_DECOMPRESS
>>   	tristate
>>   
>> +config ZSTD_COMMON
>> +	select XXHASH
>> +	tristate
>> +
>>   config ZSTD_COMPRESS
>> -	select XXHASH
>> +	select ZSTD_COMMON
>>   	tristate
>>   
>>   config ZSTD_DECOMPRESS
>> -	select XXHASH
>> +	select ZSTD_COMMON
>>   	tristate
>>   
>>   source "lib/xz/Kconfig"
>> -- 
>> 2.30.2
>>
>>

-- 
Alexey
