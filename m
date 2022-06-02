Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC6353B24B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiFBDwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiFBDwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:52:45 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE87911C16
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 20:52:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id i185so3684422pge.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 20:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=wUCm0YHDvCYDpmRLDnHBVbbCEPwJyFjXA8+1aHpeL+o=;
        b=zaQZpztukhJ1+lyofqGSIosNGZoFy6UaoiAmMwlnG7TUbBZYMI6JDC5A0D2Fjy65FO
         3wjpd7Kw7u4d3jdJYyCEszI1pWkmUKH8v0Q1Ov9X0P18sGtQp+hzLkkdaoPHXI0JoV1a
         cLJYvsDknMNt0aghuHjOJ7xw9KH3/4z+/IOArThv8R7eoqB42ZVKdfgVCvOonegYUTC2
         l3T1YsQPVkHqYXuh3E+qQ7gqBVzIt1XyRe5Nc7hiqQ4u6JczpRjD0WbOvCJOghQVRtI7
         VF+0E6/oYPX71Le2c/GPYKy1MpAiFtqKQsP0YGqZoJ+92onCoBMm/dIrq+uskO6PsVIL
         v1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=wUCm0YHDvCYDpmRLDnHBVbbCEPwJyFjXA8+1aHpeL+o=;
        b=a6YBQlW9fWGRlW2HwlKGVhk/jPuCDcYz2cfonhL124r9tNzRdg1IVORqcADYqnh5DZ
         DPjpGDXpOVbPbvbChkVGkcvHQ+bAtIBFbFl+/pj166XwKyI63FDxhyTmz/duBqoSjoBp
         H+RzmEl2Dj23r2O4aaiPHzjPT/q+002aZxm1Id3dgWE6MGTYmGnp3pWue/BxKf7Mjako
         TWrxDIvJT9x22bgOyTcWHyGmbNUq9aOeOhbNLhdpEu8scxi2rAG0ZbduGbyEsWNOLquF
         jSif/vF7usQO2avjnMY9qIP/q3i+6EsR20xH26xKeeFTmH0x361jP861c9h9gGz5exU/
         BtVw==
X-Gm-Message-State: AOAM532k8kYuA4KJB437ncTYFFYIKq+7h3E06GTx25CAD1OBSxx/gFfg
        WLnH4pslVwKcSMA6sOjq7ffOaQ==
X-Google-Smtp-Source: ABdhPJzZ4RLRiI6C1EZH9ZYpBtQQeVUud0yToyB/5r+3PaPsNavxv+x8yaDmDLNZjYowgWVR6pw3bg==
X-Received: by 2002:a05:6a00:2287:b0:518:85ee:9992 with SMTP id f7-20020a056a00228700b0051885ee9992mr2854759pfe.62.1654141963093;
        Wed, 01 Jun 2022 20:52:43 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902c38600b0015e9d4a5d27sm2309986plg.23.2022.06.01.20.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 20:52:42 -0700 (PDT)
Date:   Wed, 01 Jun 2022 20:52:42 -0700 (PDT)
X-Google-Original-Date: Wed, 01 Jun 2022 20:52:35 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: cpu.c: remove nonexistent ext from cpuinfo
In-Reply-To: <YoSw8lNHJqRDy6lg@Sun>
CC:     Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     i@zenithal.me, i@zenithal.me, Kito Cheng <kito.cheng@gmail.com>,
        Nelson Chu <nelson.chu@sifive.com>
Message-ID: <mhng-7b349805-02ff-47b3-b9b5-31dcbd2bb256@palmer-ri-x1c9>
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

On Wed, 18 May 2022 01:40:18 PDT (-0700), i@zenithal.me wrote:
> On Tue, Apr 26, 2022 at 06:08:01AM +0800, Hongren (Zenithal) Zheng wrote:
>> There are no single-letter B/K/J extentions,
>> as they are never ratified. For P, it is still in
>> progress and not ratified.
>>
>> The ordering constraint of these placerholders is now removed
>> from the spec. By commit ("Delete more nonexistent
>> extensions from the naming constraints") of riscv/riscv-isa-manual
>
> Hi, is there any further update on this patch?

IIRC there was some debate as to whether that change constituted an 
incompatible change to the spec, but I guess it's stuck around for long 
enough that maybe we should count on it being canon now?  I added Kito 
and Nelson, there's a GNU toolchain call tomorrow morning so hopefully 
we can remember to talk about it...

>
>>
>> Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
>> ---
>>  arch/riscv/kernel/cpu.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>> index ccb617791e56..53a061ab0743 100644
>> --- a/arch/riscv/kernel/cpu.c
>> +++ b/arch/riscv/kernel/cpu.c
>> @@ -113,10 +113,8 @@ static void print_isa_ext(struct seq_file *f)
>>  /*
>>   * These are the only valid base (single letter) ISA extensions as per the spec.
>>   * It also specifies the canonical order in which it appears in the spec.
>> - * Some of the extension may just be a place holder for now (B, K, P, J).
>> - * This should be updated once corresponding extensions are ratified.
>>   */
>> -static const char base_riscv_exts[13] = "imafdqcbkjpvh";
>> +static const char base_riscv_exts[9] = "imafdqcvh";
>
> The base_riscv_exts "imafdqcvh" is exactly the spec now, as
> https://github.com/riscv/riscv-isa-manual/commit/db7a4a0dad0e99d1ec1fc67b582624fc0aeae98e
> (Add single-letter "H" extension to the table)
> has shown

Oddly enough I stumbled upon that one this morning, it's another one of 
these like the HPM stuff: we used to say "there's no letter describing 
the hypervisor behavior, so it's part of the base" (see the commentary 
on the binutils patch), but now that there's a letter I'm assuming we 
should split that out?

Not clear if the RISC-V folks want H to be ignored by software like 
those other recent changes, and if so it's also not clear that's a good 
idea.

Anyway, sorry this is taking a while but I think it's going to be too 
late for this merge window -- kind of silly for such a small patch, but 
it's got interface implications and it's all a bit of a hot topic right 
now.

>
>>
>>  static void print_isa(struct seq_file *f, const char *isa)
>>  {
>> --
>> 2.35.1
>>
