Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC4859F140
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 04:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiHXCHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 22:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiHXCHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:07:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9C26EF34
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:07:20 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MC8W55gFrzXf3N;
        Wed, 24 Aug 2022 10:02:41 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 10:06:56 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 10:06:56 +0800
Message-ID: <3d479f53-9028-1640-985f-0fdd084c5037@huawei.com>
Date:   Wed, 24 Aug 2022 10:06:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] objtool: replace _ASM_PTR with quad in macros
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC:     "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@suse.de" <bp@suse.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "sv@linux.ibm.com" <sv@linux.ibm.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>
References: <20220823133124.55914-1-chenzhongjin@huawei.com>
 <27c6906c-baf3-6802-9843-50b27df74a71@csgroup.eu>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <27c6906c-baf3-6802-9843-50b27df74a71@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/24 0:47, Christophe Leroy wrote:
>
> Le 23/08/2022 à 15:31, Chen Zhongjin a écrit :
>> Macros STACK_FRAME_NON_STANDARD and ANNOTATE_NOENDBR uses
>> _ASM_PTR. It switch between .long and .quad based on 32bit
>> or 64bit. However objtool doesn't work for 32bit, so _ASM_PTR
>> makes no sense.
>>
>> Considering that _ASM_PTR comes from asm.h, which is x86
>> specific head file, while objtool.h is generic. Replace
>> _ASM_PTR with quad and remove asm.h reference.
> objtool is about to be used on powerpc on both PPC32 and PPC64, see
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=312955&state=*
>
> So if this part is meant to be used by all architectures, we need
> nothing that also works on 32 bits, don't we ?
>
> Christophe
>
ANNOTATE_NOENDBR affects nothing because it's for x86 IBT. Leaving this 
macro here is harmless now, but I think maybe it's better to move this 
to arch-specific.

The problem is STACK_FRAME_NON_STANDARD. The C version macro uses 
function pointer so the reloc symbol type can change between 32 and 64 bit.

Although I think quad is workable for both 32 and 64 bit, and this macro 
is .discard so it won't affect something else, but it may not keep reloc 
symbol type consistency.


Anyway, NO _ASM_PTR and asm.h, they are arch-specific and will break 
compiling on other arches.


Maybe we should create a macro similar to _ASM_PTR for other arches. 
Till now I didn't find one.

I'll send v2 patch to make this and Peter can judge.


Best,

Chen

>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> ---
>>    include/linux/objtool.h       | 6 ++----
>>    tools/include/linux/objtool.h | 6 ++----
>>    2 files changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/objtool.h b/include/linux/objtool.h
>> index 62c54ffbeeaa..d2413cb78037 100644
>> --- a/include/linux/objtool.h
>> +++ b/include/linux/objtool.h
>> @@ -45,8 +45,6 @@ struct unwind_hint {
>>    
>>    #ifdef CONFIG_OBJTOOL
>>    
>> -#include <asm/asm.h>
>> -
>>    #ifndef __ASSEMBLY__
>>    
>>    #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
>> @@ -87,7 +85,7 @@ struct unwind_hint {
>>    #define ANNOTATE_NOENDBR					\
>>    	"986: \n\t"						\
>>    	".pushsection .discard.noendbr\n\t"			\
>> -	_ASM_PTR " 986b\n\t"					\
>> +	".quad 986b\n\t"					\
>>    	".popsection\n\t"
>>    
>>    #define ASM_REACHABLE							\
>> @@ -144,7 +142,7 @@ struct unwind_hint {
>>    
>>    .macro STACK_FRAME_NON_STANDARD func:req
>>    	.pushsection .discard.func_stack_frame_non_standard, "aw"
>> -	_ASM_PTR \func
>> +	.quad \func
>>    	.popsection
>>    .endm
>>    
>> diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
>> index 62c54ffbeeaa..d2413cb78037 100644
>> --- a/tools/include/linux/objtool.h
>> +++ b/tools/include/linux/objtool.h
>> @@ -45,8 +45,6 @@ struct unwind_hint {
>>    
>>    #ifdef CONFIG_OBJTOOL
>>    
>> -#include <asm/asm.h>
>> -
>>    #ifndef __ASSEMBLY__
>>    
>>    #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
>> @@ -87,7 +85,7 @@ struct unwind_hint {
>>    #define ANNOTATE_NOENDBR					\
>>    	"986: \n\t"						\
>>    	".pushsection .discard.noendbr\n\t"			\
>> -	_ASM_PTR " 986b\n\t"					\
>> +	".quad 986b\n\t"					\
>>    	".popsection\n\t"
>>    
>>    #define ASM_REACHABLE							\
>> @@ -144,7 +142,7 @@ struct unwind_hint {
>>    
>>    .macro STACK_FRAME_NON_STANDARD func:req
>>    	.pushsection .discard.func_stack_frame_non_standard, "aw"
>> -	_ASM_PTR \func
>> +	.quad \func
>>    	.popsection
>>    .endm
>>    

