Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D415A9BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiIAPkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiIAPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:40:05 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A1413D4F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:40:02 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q9so16735659pgq.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vuo/t6RdovOf0Lb/pPMYcgQcOB4sKN3+auDmHvyqSTU=;
        b=XpVO7FXKl+VH+69yTJtdYHvIXoeFp5TqgPV2b0jvkYsISm5Pne4PuGD7boNxZ62Fze
         uVPkehRYViCp+qjACgYd5KvIUy515pyejazu7wUMBFNjDl6tCAuyzVdF57H4cUBupGmJ
         DrtxP2uybPgMAKEEP0orVMlreGdzUDHto+GTPgY6LhM7uVkhSYGckNhOjaYTPPHH6m6y
         eMYFj5V0AI1IrKLhmLzfhhfftJqf3uOUjkhcr3Tp2BsMZ/M5hL0gTwhd+lqJ2pjjzeFn
         BS8r/unO/eue5g1kcvou99QnE/C4TUuzIY6kQB/WDjLYmo31GVqfmvLneibSxc6Pz9j2
         h6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vuo/t6RdovOf0Lb/pPMYcgQcOB4sKN3+auDmHvyqSTU=;
        b=fjeddsVvN0qRTYxdDdOT5GS2C65I5SBvejsFEaKpX0BPHYrOVmqpdt5nJo5RA1RUSg
         xVBRBCCgbpStlx0+qbndu94UniJGy5yEyJcflPSinxGeVIXUWyoWO6o8TRzgDg1wUGFw
         nYav8AB9SqDHENHu621Q3XQ6XYaryynwnnZfnrZPNhjXrq8SJBIiVHOkAvyaqR+9dJi0
         AyqnA17gEbZ266jm28KPEMEARlsD964+EDihVacOH8vs5mEBU2bCOBAYuWa/r4ItvNom
         DArXUCuH+DhdigT4L4qHExG4ZA2ojMiZOKxMp0blyHdmSnanbuJAYdO1Wl1m77w8AHyL
         3H6w==
X-Gm-Message-State: ACgBeo2m2Wnq5yX1t69U/6O5UKhrs/i/2mTYdXDvXXB5xx1Fc0Ij5TlD
        6inrCgNTXT4acle8Z3/RYFbazIIaKM0VkA==
X-Google-Smtp-Source: AA6agR4MVXrWR5O63dX0D75ziQ25pFm/DkjiUDe7FjKOVlNiB35U1e8vs1MDXK715VXi0qwzZha4LQ==
X-Received: by 2002:a05:6a02:20d:b0:430:3886:59e8 with SMTP id bh13-20020a056a02020d00b00430388659e8mr6326358pgb.516.1662046801264;
        Thu, 01 Sep 2022 08:40:01 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g12-20020a65594c000000b003fdc16f5de2sm5436516pgu.15.2022.09.01.08.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:40:00 -0700 (PDT)
Date:   Thu, 1 Sep 2022 15:39:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM/VMX: Do not declare vmread_error asmlinkage
Message-ID: <YxDSTU+pWBdZgs/Q@google.com>
References: <20220817144045.3206-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817144045.3206-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022, Uros Bizjak wrote:
> There is no need to declare vmread_error asmlinkage, its arguments
> can be passed via registers for both, 32-bit and 64-bit targets.
> Function argument registers are considered call-clobbered registers,
> they are saved in the trampoline just before the function call and
> restored afterwards.
> 
> Note that asmlinkage and __attribute__((regparm(0))) have no effect
> on 64-bit targets. The trampoline is called from the assembler glue
> code that implements its own stack-passing function calling convention,
> so the attribute on the trampoline declaration does not change anything
> for 64-bit as well as 32-bit targets. We can declare it asmlinkage for
> documentation purposes.

...

> diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
> index 5cfc49ddb1b4..550a89394d9f 100644
> --- a/arch/x86/kvm/vmx/vmx_ops.h
> +++ b/arch/x86/kvm/vmx/vmx_ops.h
> @@ -10,9 +10,9 @@
>  #include "vmcs.h"
>  #include "../x86.h"
>  
> -asmlinkage void vmread_error(unsigned long field, bool fault);
> -__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
> -							 bool fault);
> +void vmread_error(unsigned long field, bool fault);
> +asmlinkage void vmread_error_trampoline(unsigned long field,
> +					bool fault);
>  void vmwrite_error(unsigned long field, unsigned long value);
>  void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
>  void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);

If it's ok with you, I'll split this into two patches.  One to drop asmlinkage
from vmread_error(), and one to convert the open coded regparm to asmlinkage.
