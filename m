Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D4F59608E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiHPQt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiHPQty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:49:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBBA62A90
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:49:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t5so14238876edc.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=eESoYwKpImCoaxIugOjniEJkQT2OCNtFIufUhKGJ9QQ=;
        b=gUPJqfORSBSI+qNKrEFjTwwbcDdC4IvT0TiimScMDlCuGBELGb2WKQnE7VXXlxYnum
         fjg3hqC8L34ZuKo3RGWwrad1QRRxM6zC3pQoQO9+d/qaPPICi6TCRzICYvC3jtNRTMwn
         XyxjhMV9LQETN8rEgfYsOoStpjz/NMuXl3xN7MwPEmoKC8G9G3/Lw/IyFnIgq77YTTvK
         AtoUg8gxLkDQnIv4cwoIRo+C0/GRDFkAzhx4zzFzwHwVQwB1LQkU/aaBgpWVIolECy5F
         +Kc3dpYQdHWsvS67JXG7DhN/zcFYBZbNWe1DQ7wjxjzFuKBouJubEHtMd0iKgVvCgd/7
         l4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=eESoYwKpImCoaxIugOjniEJkQT2OCNtFIufUhKGJ9QQ=;
        b=FYtuUR2qeWakVjUFB8wQkXe4aukkPlmycnmr8wWkVGptKY6IyKVvPJvYnY5Ke4zfQv
         LRDzpNAae0RRZpbQoNShyYz/Fbtjjm5NYTbuTgLL3uao/IhVTXTET4x9KZ8CPXOdJzmv
         JPtuZG2OEyGUpgoh3633g8eMzR5/XbRtMXlYb88FK2Tsetq3AmSxrP6IrTbrXpXBXTeV
         YKdXlj9QMHJ6CwDiexXdm4y1N9bYgojYbhfOhR68oXG1AeSo8azvqXAt1+7tsQZaROvX
         eaGYVY+a4nLah+1fsnZNaY5G9DeNGq0gFcCGF3n1BvTlI3F+tXximH+Ko6vMLqHReOtN
         L2Sg==
X-Gm-Message-State: ACgBeo1g3oEwUO5FJAGP1XnQFkz/1xQFOE6C9JN42VwEks2NNa9nDmbv
        BUfutkqChocw7OvcXuCS3huj/qUTK9pYVw==
X-Google-Smtp-Source: AA6agR4Do7hhL5rTRE7cw5+BvG48GNXRfi2jdoZtUB8jli9rEhhAjmH1ksPUKgXX75yJYa5OcRoVsg==
X-Received: by 2002:a05:6402:3697:b0:443:1c6:acc3 with SMTP id ej23-20020a056402369700b0044301c6acc3mr19927913edb.421.1660668591977;
        Tue, 16 Aug 2022 09:49:51 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906538300b007307c4c8a5dsm5500149ejo.58.2022.08.16.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 09:49:51 -0700 (PDT)
Date:   Tue, 16 Aug 2022 18:49:50 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor.Dooley@microchip.com
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, daolu@rivosinc.com,
        jszhang@kernel.org, palmer@dabbelt.com, re@w6rz.net,
        apatel@ventanamicro.com
Subject: Re: [PATCH] riscv: Ensure isa-ext static keys are writable
Message-ID: <20220816164950.vyo7iiiehhhasxpr@kamzik>
References: <20220816163058.3004536-1-ajones@ventanamicro.com>
 <bef1a711-506a-d07b-dbd6-3a0c5f90aef2@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef1a711-506a-d07b-dbd6-3a0c5f90aef2@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:36:55PM +0000, Conor.Dooley@microchip.com wrote:
> On 16/08/2022 17:30, Andrew Jones wrote:
> > riscv_isa_ext_keys[] is an array of static keys used in the unified
> > ISA extension framework. The keys added to this array may be used
> > anywhere, including in modules. Ensure the keys remain writable by
> > placing them in the data section.
> > 
> > The need to change riscv_isa_ext_keys[]'s section was found when the
> > kvm module started failing to load. Commit 8eb060e10185 ("arch/riscv:
> > add Zihintpause support") adds a static branch check for a newly
> > added isa-ext key to cpu_relax(), which kvm uses.
> > 
> > Fixes: c360cbec3511 ("riscv: introduce unified static key mechanism for ISA extensions")
> 
> Hey Drew,
> How about adding:
> 
> Reported-by: Ron Economos <re@w6rz.net>
> Reported-by: Anup Patel <apatel@ventanamicro.com>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>

Sure, should I repost or can those be picked up when/if the patch is
picked up?

Thanks,
drew

> 
> Thanks,
> Conor.
> 
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/kernel/cpufeature.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 553d755483ed..3b5583db9d80 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -28,7 +28,7 @@ unsigned long elf_hwcap __read_mostly;
> >  /* Host ISA bitmap */
> >  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
> >  
> > -__ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
> > +DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
> >  EXPORT_SYMBOL(riscv_isa_ext_keys);
> >  
> >  /**
