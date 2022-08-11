Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2980D5901B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 18:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiHKPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbiHKPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:53:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F6545068
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:45:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id 17so17230439plj.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=IqdpAm+3ZI27zm3WrWt4kogz8HX3uySUVAkMSid/X6U=;
        b=1G0z6VKeHyOv+DmFlwNaDXpbESavfOAPdJ0y7qxpkZ8KGb1ELkE4Oi3sNw5j1vlVrv
         YsT/Jvnr4Qx4zxafupJ6e465wLqyqB94XpJdUo1RMy0UAaoWJ2m9rEns8gIXEddP+y/G
         1Lcw6OCuCuxqK9qvhxVrW914AGArcswAUhTHLJZ7gA/zEismEh7/w4AKVuAwf0eAzk5j
         bAbiWFDAIE7pU3pwRWZqCGEl9PkgLvUfdi/HBFADY5zuJ8T8djjykzn2LsYLXKNoJKjt
         ZKfPAOFCPCMSlKygsEwhK8NAgqV+i6VGFHBBNq3eAyEi2+/p6PBbELjvq6J9dh4q4dxY
         IJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=IqdpAm+3ZI27zm3WrWt4kogz8HX3uySUVAkMSid/X6U=;
        b=ViJ7AuNpv79WD9JBOOXYEF60VKW0w/WO3gG7LINDb+3esgB/FGuFFU5Pdj/73sDkBZ
         7ns6d+m+L8qGin2oanJvDvI62PBLRl8YDkrZjy3WHkCKAhNpv7HZ0V3Ugjipwl+h2ylC
         7G1xpenpxcnQIQCngsXnN4fXZZj0ruJAAj61Pq6kZEG9qwGOkZodA8xLtyaFs3u1zSMD
         1VYJwdlLeeeS2ZhTx+qBq08ZAL7dkDTwHVwsgMoutLgiTzez8E/VG9a1XBpxd/1wjppm
         5d9UlM3PuqzQhGZ6EnDTvcNtWrX18y/NRKkMFDAwuAf0uhZvPXafFpZ+tVCjy2BHqFqM
         9etw==
X-Gm-Message-State: ACgBeo34JIxDPxRzMLiR2g4hQ4jWmsuZG8/Cf9VwxleeAybtu5JjJUnD
        BmXy8BRYqaGV+P0BsLHYi/U8cQ==
X-Google-Smtp-Source: AA6agR4aa6Jphe0Y0Hlh91VQt7xwxcn4/ibQAux03E/k/HY8C9mVj0pgJLt4eegG06tTQiRHNA5sfg==
X-Received: by 2002:a17:903:31cb:b0:16f:3d1:f5b with SMTP id v11-20020a17090331cb00b0016f03d10f5bmr33577264ple.148.1660232719614;
        Thu, 11 Aug 2022 08:45:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n129-20020a622787000000b0052dcbd87ae8sm4216988pfn.25.2022.08.11.08.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:45:19 -0700 (PDT)
Date:   Thu, 11 Aug 2022 08:45:19 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Aug 2022 08:39:47 PDT (-0700)
Subject:     Re: [PATCH] riscv: traps_misaligned: do not duplicate stringify
In-Reply-To: <20220623112905.253157-1-krzysztof.kozlowski@linaro.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     krzysztof.kozlowski@linaro.org
Message-ID: <mhng-1a6d1fe9-4b73-4088-bd89-015486990666@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2022 04:29:05 PDT (-0700), krzysztof.kozlowski@linaro.org wrote:
> Use existing stringify macro from the kernel headers.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/riscv/kernel/traps_misaligned.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
> index 46c4dafe3ba0..378f5b151443 100644
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -7,6 +7,7 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/irq.h>
> +#include <linux/stringify.h>
>
>  #include <asm/processor.h>
>  #include <asm/ptrace.h>
> @@ -150,9 +151,6 @@
>  #define PRECISION_S 0
>  #define PRECISION_D 1
>
> -#define STR(x) XSTR(x)
> -#define XSTR(x) #x
> -
>  #define DECLARE_UNPRIVILEGED_LOAD_FUNCTION(type, insn)			\
>  static inline type load_##type(const type *addr)			\
>  {									\
> @@ -207,9 +205,9 @@ static inline ulong get_insn(ulong mepc)
>  	asm ("and %[tmp], %[addr], 2\n"
>  		"bnez %[tmp], 1f\n"
>  #if defined(CONFIG_64BIT)
> -		STR(LWU) " %[insn], (%[addr])\n"
> +		__stringify(LWU) " %[insn], (%[addr])\n"
>  #else
> -		STR(LW) " %[insn], (%[addr])\n"
> +		__stringify(LW) " %[insn], (%[addr])\n"
>  #endif
>  		"and %[tmp], %[insn], %[rvc_mask]\n"
>  		"beq %[tmp], %[rvc_mask], 2f\n"

Thanks, this is on for-next.
