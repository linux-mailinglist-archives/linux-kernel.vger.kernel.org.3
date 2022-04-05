Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB254F2496
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 09:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiDEHW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiDEHVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:21:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4389718B1A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 00:18:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q19so10926346wrc.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 00:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWmIF7kdZQxOjvhVF27iSPZYouYPyeTWvrXCvBCoo6M=;
        b=0J2XyiFI8hdOaU2qz1ah0ep9G8tAOnRKLZ6ukhI9wkUUo5KnuOQbgSO39MPE+PxSaB
         9fcCB22vkp4p2Jdpl7epatdu/IwwsG9xRFG2SwyTCN+cpHriPBOGT/AKUPpuWy7fEuiY
         FzcMI0o+dtoUMfwOq08y1Kw7kpkXYyUZOrIpMNT1feIrO+Rh7tighQYA7aaD6T7QiiSq
         9DY2OOtK0QP/SEvUIQDPuB8zsSZ0Em0pmi8MMmHCPVlZCGQa75UypwxrnnT+r5toac+U
         FgCrpJLlWeg1dgw8SkcY9FbRtdnJvx/Upq8B+DHwAntkGhm7NtuJppmAqEy2SBCRcBcZ
         bHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWmIF7kdZQxOjvhVF27iSPZYouYPyeTWvrXCvBCoo6M=;
        b=CvfkPv5sYwIPnRZEW1gwFpH+bWJ9rYRtP3HHk0hfYENiJRZCEaFGbjh2JnGKq7j6nN
         p03gAyfvChxoHP/1kdf2g4siv90eCg+ZMyRipgJ4SgKi7QB1M0HyMyfcpxKbFaYsnXj1
         A02N2nWb3JODiezEPVWeUm/IZg2zX9CUXIPFhv7nUDaR5YZNWY9y4dpCzyodJsQdRpRy
         2qMjOJppIcFJVEhKJX4Y9lq2pXZ0AMmHfkkyKuULPejfR+m9gHzedhsfgyvQzfWe0Zn9
         7Slx1FgYlOJ3fl1QcoSmLv0MCoGh3SNXiMJdG/ik29DHOyFrPXt+/P1PWrUjEooD9/7N
         VNDw==
X-Gm-Message-State: AOAM532YWmbXSKdh2eviegLMREfXJXpZqp059/NZrH4vJePnEH1QjzEy
        TdDChqHzwAkFkNKnkL+qDx/4DvDiX3paYGyVGBBqVg==
X-Google-Smtp-Source: ABdhPJxEY7vXcjMbr9oQrtXXmbTMIbRAKE4OTBjGL+A63xeISLJrnIJ5bBgyZuPVxJhL+9+JmuYgJizmKmiifNf9NNM=
X-Received: by 2002:adf:f88e:0:b0:206:ce5:af99 with SMTP id
 u14-20020adff88e000000b002060ce5af99mr1455734wrp.313.1649143121363; Tue, 05
 Apr 2022 00:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220329072911.1692766-1-apatel@ventanamicro.com> <20220329072911.1692766-3-apatel@ventanamicro.com>
In-Reply-To: <20220329072911.1692766-3-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 5 Apr 2022 12:48:28 +0530
Message-ID: <CAAhSdy0ZZAVPr68VK2k+0HQDZHyaCGTv1FgQKHqh2=T1wYzZtg@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: selftests: riscv: Fix alignment of the
 guest_hang() function
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        KVM General <kvm@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR RISC-V (KVM/riscv)" 
        <kvm-riscv@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 12:59 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> The guest_hang() function is used as the default exception handler
> for various KVM selftests applications by setting it's address in
> the vstvec CSR. The vstvec CSR requires exception handler base address
> to be at least 4-byte aligned so this patch fixes alignment of the
> guest_hang() function.
>
> Fixes: 3e06cdf10520 ("KVM: selftests: Add initial support for RISC-V
> 64-bit")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

I have queued this patch for RC fixes.

Thanks,
Anup

> ---
>  tools/testing/selftests/kvm/lib/riscv/processor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
> index d377f2603d98..3961487a4870 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -268,7 +268,7 @@ void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
>                 core.regs.t3, core.regs.t4, core.regs.t5, core.regs.t6);
>  }
>
> -static void guest_hang(void)
> +static void __aligned(16) guest_hang(void)
>  {
>         while (1)
>                 ;
> --
> 2.25.1
>
