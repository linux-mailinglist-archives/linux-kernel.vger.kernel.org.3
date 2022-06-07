Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2532B534D27
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbiEZKQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiEZKP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:15:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B78722F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:15:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m1so1081244plx.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Y3eU/w+btAOyZHyBXYt+hk25vT05aSPhsIXUT8uHW4=;
        b=Udx8BVbAkgZSSSzXzgFgYJbCewYfcdOpz6T7ErV8QIvhsSQ1EYf2KvPy+lFegyPAd6
         FNfgWZhnOnlMHk2m9HFCEFzXJki/V52WDF3S5Ej5XqwJW8C9zIrPtcnYRbKyb88ktsc/
         VInB3efk12Vodx/9EWhqliUp3tlsWYWH1w42wcQDNp/8sG94vsl36u37aCByBYr0KRxW
         VOiHpIMGgA3dkn9vk4WXcH2j6s/oWaZkmrAShqRvTidBenAQm7KWdnKZsq6LhmvnoUIu
         F+UROkgF/b9j5swVr91EFcCRyN5zd3IHryE+QselPPfxwj7u9K1hoNJsK8Q/x0aGDMZZ
         iPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Y3eU/w+btAOyZHyBXYt+hk25vT05aSPhsIXUT8uHW4=;
        b=bzRh59U+Fakaan3C5CFEtfEB85toh/PYH0IdhIIeGt7Wd/Lc/d5r2ZMvoRmkEC6k8y
         pZODkSr901BckJ7fAgcf+4pVmPsO5ZkMb2L3tsT38KxGHASOMYeRwJckm9ecLAOico0X
         zWs1CqDpxnD6aUxZlFM8U5Dgka+pTef9Jk21s47JEQtDkiqy98ZCSBRm7tN+ivSsoRnN
         /2ArU/Gx8++gvaw/6wI2D+wE1kSgYA2RV/AE8qHE2rTtQ6EpCPhhy10Iv3GE+tetxyEc
         YwZZt8i57abJIsttiziCBxJnVt0tc8x/GjCKJgaIYfdFrhgoMqhgOmD7GVBsFw6InERL
         Q9Lw==
X-Gm-Message-State: AOAM533MlvjwqxGEyCZwZf6ap/tmIrNHiIrrAdDtNPXWhKJs2RTyXpaV
        1CyYYh7Lz00TNfncAD7bOHKq7w==
X-Google-Smtp-Source: ABdhPJxJz34W7UwGbIHBo7cdYQHAxdsuQZtFizYaWq04IKjBgju6JFGWyLfVxAGBflzW20SnrJlKWQ==
X-Received: by 2002:a17:903:2305:b0:163:64c7:f9ff with SMTP id d5-20020a170903230500b0016364c7f9ffmr5879166plh.46.1653560157179;
        Thu, 26 May 2022 03:15:57 -0700 (PDT)
Received: from sunil-laptop ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id ji13-20020a170903324d00b0016240bbe893sm1092596plb.302.2022.05.26.03.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:15:56 -0700 (PDT)
Date:   Thu, 26 May 2022 15:45:50 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 2/5] riscv: cpu_ops_spinwait: Support for 64bit hartid
Message-ID: <20220526101550.GB19431@sunil-laptop>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
 <20220525151106.2176147-3-sunilvl@ventanamicro.com>
 <a7910ff4-0bce-befa-f961-a82a8a1025a1@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7910ff4-0bce-befa-f961-a82a8a1025a1@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 05:27:51PM +0200, Heinrich Schuchardt wrote:
> On 5/25/22 17:11, Sunil V L wrote:
> > The hartid can be a 64bit value on RV64 platforms. This patch modifies
> > the hartid variable type to unsigned long so that it can hold 64bit
> > value on RV64 platforms.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >   arch/riscv/kernel/cpu_ops_spinwait.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/kernel/cpu_ops_spinwait.c b/arch/riscv/kernel/cpu_ops_spinwait.c
> > index 346847f6c41c..51ac07514a62 100644
> > --- a/arch/riscv/kernel/cpu_ops_spinwait.c
> > +++ b/arch/riscv/kernel/cpu_ops_spinwait.c
> > @@ -18,7 +18,7 @@ void *__cpu_spinwait_task_pointer[NR_CPUS] __section(".data");
> >   static void cpu_update_secondary_bootdata(unsigned int cpuid,
> >   				   struct task_struct *tidle)
> >   {
> > -	int hartid = cpuid_to_hartid_map(cpuid);
> > +	unsigned long hartid = cpuid_to_hartid_map(cpuid);
> >   	/*
> >   	 * The hartid must be less than NR_CPUS to avoid out-of-bound access
> 
> This line follows:
> 
> if (hartid == INVALID_HARTID || hartid >= NR_CPUS)
> 
> INVALID_HARTID is defined as ULONG_MAX. Please, mention that you are fixing
> a bug:
> 
> Fixes: c78f94f35cf648 ("RISC-V: Use __cpu_up_stack/task_pointer only for
> spinwait method")
> 
> NR_CPUS alias CONFIG_NR_CPUS is an int. You should convert it to unsigned
> before comparing it to hartid to avoid build warnings.

Thank you for the feedback. Have modified the patch and commit message
as per your suggestion in V2 version. Please check.

Thanks
Sunil
> 
> Best regards
> 
> Heinrich
> 
