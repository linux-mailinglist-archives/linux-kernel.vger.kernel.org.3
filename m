Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A8574C47
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbiGNLgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbiGNLgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD4695A2DF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657798588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzJge1CDFiz3CXcKr0tL6QkQC9brq6bIgDLKquTU284=;
        b=F5StHoUZ1TUy2aITHg8gx5sYpjTIUp7wdDJHf+Xrk/ObVy2N0CHJKwn4o+yPYD59JurvKK
        UBlH7IWyyEpqs0D2j4pxbJrfhLZhzRUOuLyMcnUHkg1BbwCv0BfRF8iHCmTLtRsLcbwQ5G
        ac3f+M1QRCp33lLiTFrpxeHoQjc5hV4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-bTtOYGAqP8qEt7VmrwNjdg-1; Thu, 14 Jul 2022 07:36:27 -0400
X-MC-Unique: bTtOYGAqP8qEt7VmrwNjdg-1
Received: by mail-ej1-f72.google.com with SMTP id nc23-20020a1709071c1700b0072b94109144so666647ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yzJge1CDFiz3CXcKr0tL6QkQC9brq6bIgDLKquTU284=;
        b=AVsaxTDHsh/Mlv5Csm1R/RXcVU89QbXsNcfPlLGlWNojSNe0iV1bqUI0Bd0D0TGg0j
         izW8eI1gf41UniFkv+fULpT14wK5bMCFP9qY7chqq3eM9m4k+r0ao5MrxfnET9Py8YoP
         Z3TPFpEidvyezPto7j4YxEOgr6QoE8L6nwvXKmwI8/XvsN2zRNu48Nfi38B4j0Qe2hVE
         z4otTzocqKOMUUXC/MC3SFBaQ/kY0glag/Yuhz22GcpuF7tggTfVr9F7irFO4dlA2X3y
         S/5Wcir5ep5a/aW+XZ++zzcjJTLCGyycOjCvRJp6C00X56AbAolQcMUdq+Iy8ThWjcBJ
         1sYw==
X-Gm-Message-State: AJIora/FB3F5d9vnEZr/hcUoXQO7raN9ioD3ZmxxlE6FD7V7782twGRo
        sY/pGYxybGLNgqKZNTDVrTKt1aYSrOXWrPoIkwQHyd+SS67CuuGG0XlhiuVFO5Ax9oHDFCczUPw
        Frql+dFQDBiyB7n5TYUhMaUZ/
X-Received: by 2002:a17:906:c152:b0:726:35bd:b3bd with SMTP id dp18-20020a170906c15200b0072635bdb3bdmr8547620ejc.201.1657798586266;
        Thu, 14 Jul 2022 04:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1soMs6ib0bGsSIDUbevpTdLCHlVeXmj1/9cy57IT8JvY+ym0ohu3hRr8eg8qnRzm5l28Qe84Q==
X-Received: by 2002:a17:906:c152:b0:726:35bd:b3bd with SMTP id dp18-20020a170906c15200b0072635bdb3bdmr8547605ejc.201.1657798586018;
        Thu, 14 Jul 2022 04:36:26 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id by28-20020a0564021b1c00b0043acddee068sm881292edb.83.2022.07.14.04.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 04:36:25 -0700 (PDT)
Message-ID: <976510d2-c7ad-2108-27e0-4c3b82c210f1@redhat.com>
Date:   Thu, 14 Jul 2022 13:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] x86/kvm: fix FASTOP_SIZE when return thunks are enabled
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
References: <20220713171241.184026-1-cascardo@canonical.com>
 <Ys/ncSnSFEST4fgL@worktop.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ys/ncSnSFEST4fgL@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 11:52, Peter Zijlstra wrote:
> On Wed, Jul 13, 2022 at 02:12:41PM -0300, Thadeu Lima de Souza Cascardo wrote:
>> The return thunk call makes the fastop functions larger, just like IBT
>> does. Consider a 16-byte FASTOP_SIZE when CONFIG_RETHUNK is enabled.
>>
>> Otherwise, functions will be incorrectly aligned and when computing their
>> position for differently sized operators, they will executed in the middle
>> or end of a function, which may as well be an int3, leading to a crash
>> like:
> 
> Bah.. I did the SETcc stuff, but then forgot about the FASTOP :/
> 
>    af2e140f3420 ("x86/kvm: Fix SETcc emulation for return thunks")
> 
>> Fixes: aa3d480315ba ("x86: Use return-thunk in asm code")
>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> ---
>>   arch/x86/kvm/emulate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
>> index db96bf7d1122..d779eea1052e 100644
>> --- a/arch/x86/kvm/emulate.c
>> +++ b/arch/x86/kvm/emulate.c
>> @@ -190,7 +190,7 @@
>>   #define X16(x...) X8(x), X8(x)
>>   
>>   #define NR_FASTOP (ilog2(sizeof(ulong)) + 1)
>> -#define FASTOP_SIZE (8 * (1 + HAS_KERNEL_IBT))
>> +#define FASTOP_SIZE (8 * (1 + (HAS_KERNEL_IBT | IS_ENABLED(CONFIG_RETHUNK))))
> 
> Would it make sense to do something like this instead?

Yes, definitely.  Applied with a small tweak to make FASTOP_LENGTH
more similar to SETCC_LENGTH:
  
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index db96bf7d1122..0a15b0fec6d9 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -189,8 +189,12 @@
  #define X8(x...) X4(x), X4(x)
  #define X16(x...) X8(x), X8(x)
  
-#define NR_FASTOP (ilog2(sizeof(ulong)) + 1)
-#define FASTOP_SIZE (8 * (1 + HAS_KERNEL_IBT))
+#define NR_FASTOP	(ilog2(sizeof(ulong)) + 1)
+#define RET_LENGTH	(1 + (4 * IS_ENABLED(CONFIG_RETHUNK)) + \
+			 IS_ENABLED(CONFIG_SLS))
+#define FASTOP_LENGTH	(ENDBR_INSN_SIZE + 7 + RET_LENGTH)
+#define FASTOP_SIZE	(8 << ((FASTOP_LENGTH > 8) & 1) << ((FASTOP_LENGTH > 16) & 1))
+static_assert(FASTOP_LENGTH <= FASTOP_SIZE);
  
  struct opcode {
  	u64 flags;
@@ -442,8 +446,6 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
   * RET | JMP __x86_return_thunk	[1,5 bytes; CONFIG_RETHUNK]
   * INT3				[1 byte; CONFIG_SLS]
   */
-#define RET_LENGTH	(1 + (4 * IS_ENABLED(CONFIG_RETHUNK)) + \
-			 IS_ENABLED(CONFIG_SLS))
  #define SETCC_LENGTH	(ENDBR_INSN_SIZE + 3 + RET_LENGTH)
  #define SETCC_ALIGN	(4 << ((SETCC_LENGTH > 4) & 1) << ((SETCC_LENGTH > 8) & 1))
  static_assert(SETCC_LENGTH <= SETCC_ALIGN);


Paolo

