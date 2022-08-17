Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E76597320
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbiHQPcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240417AbiHQPcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:32:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A59D8CF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:31:54 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y13so25114103ejp.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=a/PIyfsanhuZllpPivL8Bh2mQBuFyAwgudcPaKdSSHQ=;
        b=Y3aPmPl8Gl6Ticd5n+ONhVYew/dhHhrWtA9QzSdIK2WfxGUQcV+aTEE5sBioizif58
         OMIiUU2yFGe+LN9MNuo6NvHBMzw6a1w1uAUbDruLKacHo5ZwTMXNuD5lIKa0EX0HsCjm
         nY/m5XdLBg0kQmNnRLGHYHl4hEV3XqzIMyb6y1aSac9kD1+uMVmyUXmTExjLMqfpt1WZ
         TdtVqqeYVi0rxxTde2WbCPYcQVAOLu/KA3ft8im+QLVC2HK8rz5uj/KkRRC3oPvIGVJY
         UbzT8TBpVh9yfFxFH/wE81VFXr+d0wzfOSZXH4sQVceJdWaPnM4U1Msj1qWMfcLSuyAd
         S2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=a/PIyfsanhuZllpPivL8Bh2mQBuFyAwgudcPaKdSSHQ=;
        b=LVrQ30grjjBWYMzYo5RKh6yFRYjZucXW1Gwi4MFv/7YSNTTmXzDzAVUjg4uvrUk3kv
         ghArmm/5HkUMBKp/zwH94hkQUd0pIs8ZtSaQhbQu+A1dazufXmBdl/BEeIL1p3f8UaMe
         dT7L/8Jh2TgYab4IxEUMLV4/Ry1/A6ud169+U7eKs4UvyzmXmuX0NhkJR/mh2C35BL0K
         Nv+eITeqCEk2u/xe6yCUHSeL3+FT6MMTQnASoKMNsVNtCPssE3EzTKGwWVKFkiKg+GTB
         jcwjgh7iORQUOQw3hBX57F3CFaAUy7B0asL5m3U21m1qspcGg0/AXeDAXgp5/JCeMx2B
         dWhA==
X-Gm-Message-State: ACgBeo16dcNyIwJyxVaBD3HK1hDUxpEqhYlc1JOhHVNYjcivSx6cFypw
        Z7deUgW5D/nugNoR9p6lmY+HqA==
X-Google-Smtp-Source: AA6agR5EXt7m0iYui0lTtqSryBN00lK2V0UI74nd+7U7PhHJGidvWTUIyrw9wqSAXWbqjfZ9oT/8aQ==
X-Received: by 2002:a17:907:7e9f:b0:730:d954:c2b5 with SMTP id qb31-20020a1709077e9f00b00730d954c2b5mr16466931ejc.311.1660750312930;
        Wed, 17 Aug 2022 08:31:52 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id fn3-20020a1709069d0300b0072fb3704e49sm6892820ejc.46.2022.08.17.08.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 08:31:52 -0700 (PDT)
Date:   Wed, 17 Aug 2022 17:31:50 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, atishp@atishpatra.org,
        linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, daolu@rivosinc.com,
        Conor.Dooley@microchip.com, re@w6rz.net, apatel@ventanamicro.com
Subject: Re: [PATCH] riscv: Ensure isa-ext static keys are writable
Message-ID: <20220817153150.fvht2isdiqjpk3my@kamzik>
References: <CAOnJCU+Gx44ESHWyku7Kb6u5QnzjXiZcat5XmVWjksdFpcQ6nA@mail.gmail.com>
 <mhng-dd00cb27-4162-48aa-834d-30fb90e194cf@palmer-mbp2014>
 <Yvz7byY9F0ow1bgf@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvz7byY9F0ow1bgf@xhacker>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:30:07PM +0800, Jisheng Zhang wrote:
> On Tue, Aug 16, 2022 at 09:29:36PM -0700, Palmer Dabbelt wrote:
> > On Tue, 16 Aug 2022 16:41:46 PDT (-0700), atishp@atishpatra.org wrote:
> > > On Tue, Aug 16, 2022 at 9:31 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> > > > 
> > > > riscv_isa_ext_keys[] is an array of static keys used in the unified
> > > > ISA extension framework. The keys added to this array may be used
> > > > anywhere, including in modules. Ensure the keys remain writable by
> > > > placing them in the data section.
> > > > 
> > > > The need to change riscv_isa_ext_keys[]'s section was found when the
> > > > kvm module started failing to load. Commit 8eb060e10185 ("arch/riscv:
> > > > add Zihintpause support") adds a static branch check for a newly
> > > > added isa-ext key to cpu_relax(), which kvm uses.
> > >> > > 
> > > > Fixes: c360cbec3511 ("riscv: introduce unified static key mechanism for ISA extensions")
> > > > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > > > > > ---
> > > >  arch/riscv/kernel/cpufeature.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > > index 553d755483ed..3b5583db9d80 100644
> > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > @@ -28,7 +28,7 @@ unsigned long elf_hwcap __read_mostly;
> > > >  /* Host ISA bitmap */
> > > >  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> > > > 
> > > > -__ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
> > > > +DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
> > > >  EXPORT_SYMBOL(riscv_isa_ext_keys);
> > > > 
> > > >  /**
> > > > --
> > > > 2.37.1
> > > > 
> > > > 
> > > > --
> > > > kvm-riscv mailing list
> > > > kvm-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/kvm-riscv
> > > 
> > > Thanks for the quick fix. Tested with kvm guests booting in Qemu.
> > > 
> > > Tested-by: Atish Patra <atishp@rivosinc.com>
> 
> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> 
> Thanks for catching the bug in my code.
> 
> > 
> > Thanks, I hadn't realized how static keys work but looks like having them as
> > __ro_after_init was always bogus.  Sorry to break stuff, looks like I should be
> 
> Sorry for breaking the static isa extension key usage in modules.
> It's a good idea to make them readonly, but need to cope with the usage
> in module properly. This may be a good improvement item.

While some static keys do use __ro_after_init, they're almost all locally
defined (static __ro_after_init). I see a few instances of __read_mostly
global static key definitions, though. That may make sense for
riscv_isa_ext_keys[] as well.

Thanks,
drew
