Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665C059F17E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 04:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiHXCsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 22:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiHXCsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:48:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8D36A4BD
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:48:09 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MC9RV1KKCz1N7Td;
        Wed, 24 Aug 2022 10:44:38 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 10:48:01 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 10:48:01 +0800
Message-ID: <48ca5e9e-eb03-3fb1-96d0-4755e1d39c3f@huawei.com>
Date:   Wed, 24 Aug 2022 10:48:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] objtool: replace _ASM_PTR with quad in macros
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     <jpoimboe@kernel.org>, <bp@suse.de>, <mhiramat@kernel.org>,
        <sv@linux.ibm.com>, <christophe.leroy@csgroup.eu>,
        <naveen.n.rao@linux.vnet.ibm.com>
References: <20220823133124.55914-1-chenzhongjin@huawei.com>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <20220823133124.55914-1-chenzhongjin@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/23 21:31, Chen Zhongjin wrote:
> Macros STACK_FRAME_NON_STANDARD and ANNOTATE_NOENDBR uses
> _ASM_PTR. It switch between .long and .quad based on 32bit
> or 64bit. However objtool doesn't work for 32bit, so _ASM_PTR
> makes no sense.
>
> Considering that _ASM_PTR comes from asm.h, which is x86
> specific head file, while objtool.h is generic. Replace
> _ASM_PTR with quad and remove asm.h reference.
>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>   include/linux/objtool.h       | 6 ++----
>   tools/include/linux/objtool.h | 6 ++----
>   2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/objtool.h b/include/linux/objtool.h
> index 62c54ffbeeaa..d2413cb78037 100644
> --- a/include/linux/objtool.h
> +++ b/include/linux/objtool.h
> @@ -45,8 +45,6 @@ struct unwind_hint {
>   
>   #ifdef CONFIG_OBJTOOL
>   
> -#include <asm/asm.h>
> -
>   #ifndef __ASSEMBLY__
>   
>   #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
> @@ -87,7 +85,7 @@ struct unwind_hint {
>   #define ANNOTATE_NOENDBR					\
>   	"986: \n\t"						\
>   	".pushsection .discard.noendbr\n\t"			\
> -	_ASM_PTR " 986b\n\t"					\
> +	".quad 986b\n\t"					\
>   	".popsection\n\t"
>   
>   #define ASM_REACHABLE							\
> @@ -144,7 +142,7 @@ struct unwind_hint {
>   
>   .macro STACK_FRAME_NON_STANDARD func:req
>   	.pushsection .discard.func_stack_frame_non_standard, "aw"
> -	_ASM_PTR \func
> +	.quad \func
>   	.popsection
>   .endm
>   
> diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
> index 62c54ffbeeaa..d2413cb78037 100644
> --- a/tools/include/linux/objtool.h
> +++ b/tools/include/linux/objtool.h
> @@ -45,8 +45,6 @@ struct unwind_hint {
>   
>   #ifdef CONFIG_OBJTOOL
>   
> -#include <asm/asm.h>
> -
>   #ifndef __ASSEMBLY__
>   
>   #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
> @@ -87,7 +85,7 @@ struct unwind_hint {
>   #define ANNOTATE_NOENDBR					\
>   	"986: \n\t"						\
>   	".pushsection .discard.noendbr\n\t"			\
> -	_ASM_PTR " 986b\n\t"					\
> +	".quad 986b\n\t"					\
>   	".popsection\n\t"
>   
>   #define ASM_REACHABLE							\
> @@ -144,7 +142,7 @@ struct unwind_hint {
>   
>   .macro STACK_FRAME_NON_STANDARD func:req
>   	.pushsection .discard.func_stack_frame_non_standard, "aw"
> -	_ASM_PTR \func
> +	.quad \func
>   	.popsection
>   .endm
>   

As ppc said they will use objtool for both 32 and 64bit, maybe we still 
need a switchable symbol type for this.

How about this one?


diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 62c54ffbeeaa..14af2bcc460b 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -45,10 +45,14 @@ struct unwind_hint {

  #ifdef CONFIG_OBJTOOL

-#include <asm/asm.h>
-
  #ifndef __ASSEMBLY__

+#ifdef CONFIG_64BIT
+#define _RELOC_PTR __stringify(.quad)
+#else
+#define _RELOC_PTR __stringify(.long)
+#endif
+
  #define UNWIND_HINT(sp_reg, sp_offset, type, end)              \
         "987: \n\t"                                             \
         ".pushsection .discard.unwind_hints\n\t"                \
@@ -87,7 +91,7 @@ struct unwind_hint {
  #define ANNOTATE_NOENDBR                                       \
         "986: \n\t"                                             \
         ".pushsection .discard.noendbr\n\t"                     \
-       _ASM_PTR " 986b\n\t"                                    \
+       _RELOC_PTR " 986b\n\t"                                  \
         ".popsection\n\t"

  #define ASM_REACHABLE                                                  \
@@ -98,6 +102,12 @@ struct unwind_hint {

  #else /* __ASSEMBLY__ */

+#ifdef CONFIG_64BIT
+#define _RELOC_PTR .quad
+#else
+#define _RELOC_PTR .long
+#endif
+
  /*
   * This macro indicates that the following intra-function call is valid.
   * Any non-annotated intra-function call will cause objtool to issue a 
warning.
@@ -144,7 +154,7 @@ struct unwind_hint {

  .macro STACK_FRAME_NON_STANDARD func:req
         .pushsection .discard.func_stack_frame_non_standard, "aw"
-       _ASM_PTR \func
+       _RELOC_PTR \func
         .popsection
  .endm



