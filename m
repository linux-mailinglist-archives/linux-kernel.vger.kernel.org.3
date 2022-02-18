Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E594BB499
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiBRIul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:50:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiBRIui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:50:38 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96ACB2B354D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:50:20 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m7so8035604pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 00:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b7z6iiw22lnHjci/Ii1/zt223km1527nVd9KogEQtMU=;
        b=seeuPptDfkero5sztHjnfTdR7kAX0RDQ+GXKIYPmD9/YMJP1s/q1+WUrOEvfXGR7S0
         2KDZBfbuc6AyrLHQr5yV8jEBMmXJXCcdZ5N6HivQXxMR5W6FVV5diWMQMLAIxpEhlG2M
         iY/M6jiEV7sn40uD+OfH0H7ZQiTGEqUek1GmoMXA9kc/fF7hsXGbhWqjVNgPvZJjifQA
         DlR8sjSQC5xn6p3QCtM9E8bfCsH6azPSSjjpUQD6UxKusGPR9G+UzqQ+OyI26qUJS5KO
         LaHkIN1dwzN66kfSzZnRnOUFkEa1mF6Raq1psC4+zvSNWD5cGF1C7c5lVCX4nCHaf22N
         dKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b7z6iiw22lnHjci/Ii1/zt223km1527nVd9KogEQtMU=;
        b=bscZS2pXfApQf8KVg0Ib2r2aggQODpoKJmxZ7l/sQuNlgqoupEQ0nCE8UHLVU+uUuX
         lpZm3EmwUTAAWLPhwE9w4M/U2C++l2RZFDY0pzIJ9Ki1Eyn8e5yaegJtIdmXHPYp0zcj
         9E6Ghtk3EYu+m76KR+0rAwig4cdXTWG+458gj9PHEKtg1wVbT8o3Ll9ORkymtlErQKk2
         DmJO9jU1C/02vgtm0Er9CuTYbxHAsaT47CpahwLNthRNh+EEhWRjfUK3w9cuzTQ8/uUG
         lT3ma9UJerPmx6ztJNme53CFLprK0RZf6eoRzBTmlvoSnDlrJNMcvx+MCPMXiULugeTx
         nOIQ==
X-Gm-Message-State: AOAM532Y8s3MbeeP9J5VTSXQO2QFf1upwdLYIq0ddPJcDpJ75wrN2z6b
        kwxvL+pO3t/p/LCqn7ZFU+nMMA==
X-Google-Smtp-Source: ABdhPJwpYaB42zV9cx7WtkoPcQKhcNvCEW0vB7/C4F6IE0jCZlGR4uQYV9WGq9VayBg64TbURiE0aQ==
X-Received: by 2002:a17:903:31cd:b0:14d:bb40:2a17 with SMTP id v13-20020a17090331cd00b0014dbb402a17mr6448398ple.1.1645174219918;
        Fri, 18 Feb 2022 00:50:19 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:bdb7:3728:9760:87c])
        by smtp.gmail.com with ESMTPSA id d16sm2192602pfj.1.2022.02.18.00.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 00:50:19 -0800 (PST)
Date:   Fri, 18 Feb 2022 00:50:16 -0800
From:   Fangrui Song <maskray@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] arm64 module: remove (NOLOAD)
Message-ID: <20220218085016.jv4qcfaxav5fxhrs@google.com>
References: <20220218081209.354383-1-maskray@google.com>
 <CAMj1kXGZuOWOPEHv0YSM4GseG2PnTgS8mSLXQ+imo-TN7MmvaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXGZuOWOPEHv0YSM4GseG2PnTgS8mSLXQ+imo-TN7MmvaQ@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-18, Ard Biesheuvel wrote:
>On Fri, 18 Feb 2022 at 09:12, Fangrui Song <maskray@google.com> wrote:
>>
>> On ELF, (NOLOAD) sets the section type to SHT_NOBITS[1]. It is conceptually
>> inappropriate for .plt and .text.* sections which are always
>> SHT_PROGBITS.
>>
>> In GNU ld, if PLT entries are needed, .plt will be SHT_PROGBITS anyway
>> and (NOLOAD) will be essentially ignored. In ld.lld, since
>> https://reviews.llvm.org/D118840 ("[ELF] Support (TYPE=<value>) to
>> customize the output section type"), ld.lld will report a `section type
>> mismatch` error. Just remove (NOLOAD) to fix the error.
>>
>> [1] https://lld.llvm.org/ELF/linker_script.html As of today, "The
>> section should be marked as not loadable" on
>> https://sourceware.org/binutils/docs/ld/Output-Section-Type.html is
>> outdated for ELF.
>
>This patch lacks a SOB line.
>
>With one added,
>
>Acked-by: Ard Biesheuvel <ardb@kernel.org>

Ah, yes. Sorry, I haven't sent a kernel patch for a while...

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Fangrui Song <maskray@google.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>

>> ---
>>  arch/arm64/include/asm/module.lds.h | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/module.lds.h b/arch/arm64/include/asm/module.lds.h
>> index a11ccadd47d2..094701ec5500 100644
>> --- a/arch/arm64/include/asm/module.lds.h
>> +++ b/arch/arm64/include/asm/module.lds.h
>> @@ -1,8 +1,8 @@
>>  SECTIONS {
>>  #ifdef CONFIG_ARM64_MODULE_PLTS
>> -       .plt 0 (NOLOAD) : { BYTE(0) }
>> -       .init.plt 0 (NOLOAD) : { BYTE(0) }
>> -       .text.ftrace_trampoline 0 (NOLOAD) : { BYTE(0) }
>> +       .plt 0 : { BYTE(0) }
>> +       .init.plt 0 : { BYTE(0) }
>> +       .text.ftrace_trampoline 0 : { BYTE(0) }
>>  #endif
>>
>>  #ifdef CONFIG_KASAN_SW_TAGS
>> --
>> 2.35.1.265.g69c8d7142f-goog
>>
