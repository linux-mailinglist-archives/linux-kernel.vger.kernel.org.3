Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A2D596830
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 06:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiHQE3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 00:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHQE3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 00:29:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA954661
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:29:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so811600pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 21:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc;
        bh=l7bruH7M7kCtSBuzafzBrFu70kZSFm/jLPtQDrjL9yk=;
        b=q2td9uCN9OVfImZm2lfHuKG1sOYdDqpR/UnqrhhxftIYNW3puoZ3q/OzG3MJA0rEfG
         BEZg95xCoMnq2qf4B64PNJIuvkgrWqnsIcwpg9yAC45pzTF4JyXdGkCKHO+5AZXaniAX
         fMkl7or4DHSAANfQzrczFW0TpmpaJUv/bKXDpRfTir+sQlM8b8VbAOo2g0MhJXlqDwgj
         /0vq1sM6CAB8XffSDReLsdfpPGJ3oW1RDcdLQ0g0Z15I0gmpr0psNHHnfOLMSsBR6ktq
         To0lIflsaJYuUqoRXsxe4K5hsV3NXG4pjxmPHop6JigZyNo1r4ysYDxYr5f0+cO3xexa
         Nu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc;
        bh=l7bruH7M7kCtSBuzafzBrFu70kZSFm/jLPtQDrjL9yk=;
        b=s//0IAXLevy8o8/ZaEd7AMYPXzFIEftXKWgeOJJjtJMMDIAJGcuNgG5dOaIzwSkQlF
         +AjO+EJoAH3Xf0u+GocIZWD+fvOomjDVhaCcRI+jZUZWqtsKaz/EJUcN6l03XxaxHWYE
         qeLe3sCi0jUDuv2t19zJnZtUMCnTslh5SjA5+rJhFWNsONoEdx3mdeNmikpvh3IvO+2+
         RgaD3Oj+y4Qe8WURF29EmLDaw2eg881IYc1B7TZWHkQnkYM4PPQocPJD8IhM4ZDbxpzd
         75fB9lAt03XwsbtQpHclX4Wc+BkQBFvKAlskjomyWE5z0xG4RBbstg3RVo1931jEz7wW
         44TA==
X-Gm-Message-State: ACgBeo23K73MFx0vpe6+6PvDK3zcB9zns4EAwGc0yQFg6k2mpSY/5QSR
        9ihTZ2Tf7nS33+mbEZeoGd/7+g==
X-Google-Smtp-Source: AA6agR7sr8hoPYZmOS6WDCPjtmFGhduiunUSfLYE/vb680nCFrOjRAhqzCy2Bxhj9tIvSeTGZs/cuQ==
X-Received: by 2002:a17:90b:1d44:b0:1f7:6f05:639e with SMTP id ok4-20020a17090b1d4400b001f76f05639emr1879028pjb.99.1660710577189;
        Tue, 16 Aug 2022 21:29:37 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r15-20020a17090a0acf00b001f559e00473sm399449pje.43.2022.08.16.21.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 21:29:36 -0700 (PDT)
Date:   Tue, 16 Aug 2022 21:29:36 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Aug 2022 21:07:01 PDT (-0700)
Subject:     Re: [PATCH] riscv: Ensure isa-ext static keys are writable
In-Reply-To: <CAOnJCU+Gx44ESHWyku7Kb6u5QnzjXiZcat5XmVWjksdFpcQ6nA@mail.gmail.com>
CC:     ajones@ventanamicro.com, linux-riscv@lists.infradead.org,
        kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        daolu@rivosinc.com, jszhang@kernel.org, Conor.Dooley@microchip.com,
        re@w6rz.net, apatel@ventanamicro.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-dd00cb27-4162-48aa-834d-30fb90e194cf@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 16:41:46 PDT (-0700), atishp@atishpatra.org wrote:
> On Tue, Aug 16, 2022 at 9:31 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>>
>> riscv_isa_ext_keys[] is an array of static keys used in the unified
>> ISA extension framework. The keys added to this array may be used
>> anywhere, including in modules. Ensure the keys remain writable by
>> placing them in the data section.
>>
>> The need to change riscv_isa_ext_keys[]'s section was found when the
>> kvm module started failing to load. Commit 8eb060e10185 ("arch/riscv:
>> add Zihintpause support") adds a static branch check for a newly
>> added isa-ext key to cpu_relax(), which kvm uses.
>>
>> Fixes: c360cbec3511 ("riscv: introduce unified static key mechanism for ISA extensions")
>> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
>> ---
>>  arch/riscv/kernel/cpufeature.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 553d755483ed..3b5583db9d80 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -28,7 +28,7 @@ unsigned long elf_hwcap __read_mostly;
>>  /* Host ISA bitmap */
>>  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>>
>> -__ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
>> +DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
>>  EXPORT_SYMBOL(riscv_isa_ext_keys);
>>
>>  /**
>> --
>> 2.37.1
>>
>>
>> --
>> kvm-riscv mailing list
>> kvm-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kvm-riscv
>
> Thanks for the quick fix. Tested with kvm guests booting in Qemu.
>
> Tested-by: Atish Patra <atishp@rivosinc.com>

Thanks, I hadn't realized how static keys work but looks like having them as
__ro_after_init was always bogus.  Sorry to break stuff, looks like I should be
loading some module (probably KVM, as it's in the defconfig) during testing.

This is on fixes, I'm planning on sending it up later this week.
