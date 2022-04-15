Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB605024C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350049AbiDOFtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347361AbiDOFtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:49:42 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC5A41301
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:47:14 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2ef5380669cso58326937b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+S0ex0Gmk8XR+HZHfmZwrGjOF8Dda3fikKUL+qrwCA=;
        b=pVBDiBdSvrangewc/J0Wo8xQrAbEWLkPPucthMJqZGiYdMCnJv5tXJgxd3Ee0mrr+d
         VHMNA8zD2X0+0KIhrTnRAnVmSMvOniaOL7O6xtaMdXFNsIboKf3RyAjqFlK3gRQkk5DE
         n1LzKfSRxdOMC5rGWM+nkJ5diYejlN8nnYmiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+S0ex0Gmk8XR+HZHfmZwrGjOF8Dda3fikKUL+qrwCA=;
        b=lHH/aLAerBcmoP8bXSe4BQJoIjyheU+UtSc/FjE7k6YehFgnJL2ixUoW8iSM4w/j/h
         MIMqffBr6HFDSAy9W3oIv1Yw6DVqYR5VKJahvppDAP+aUvTCc20EoA3GA2mCE12RfCWV
         rURpZ+ErHnQOLnNoFNZAAzfI+L4aEeMeqzGhc2GunajPp3Bfk3CVLbonPznGXfVv3Scn
         6Zell6geMErphKUwPh5daFeGYKqR+e0Xvura+7qth5MTofzfjjVNwbu9jdYi9TgHPZEz
         zs2kaNc7Vb38DgQfngYUnHI1vsy2XrfUypJsrjNyDLfh9uUFnFEjBGZLs9XqXcB2eOGZ
         3+vg==
X-Gm-Message-State: AOAM530qdwprSM1AK0AVLKfGb0ySh6+rZqJHceT9JxtEadmwTMO9esMe
        ZfkNFwmhKINT5kqHYmsCzXPCRqIECMJ1C6OcZjc6Sxfbcw==
X-Google-Smtp-Source: ABdhPJxvTmOAh1p5L0hp1zJBgO/cplpMgmeLO/Z++i8g7Xe/Vw/VUIitCelofGK1vcH22lkr09B6dnPpt+PN4Di+nHI=
X-Received: by 2002:a81:ad47:0:b0:2ee:927d:ff39 with SMTP id
 l7-20020a81ad47000000b002ee927dff39mr4935600ywk.249.1650001634010; Thu, 14
 Apr 2022 22:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220412033335.1384230-1-apatel@ventanamicro.com>
In-Reply-To: <20220412033335.1384230-1-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 14 Apr 2022 22:47:03 -0700
Message-ID: <CAOnJCUJUy1sE49hu6yyUzdsVwnLMXA0zOPBMzn8MTTYUdSnWtg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: mm: Fix set_satp_mode() for platform not having Sv57
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 8:34 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> When Sv57 is not available the satp.MODE test in set_satp_mode() will
> fail and lead to pgdir re-programming for Sv48. The pgdir re-programming
> will fail as well due to pre-existing pgdir entry used for Sv57 and as
> a result kernel fails to boot on RISC-V platform not having Sv57.
>
> To fix above issue, we should clear the pgdir memory in set_satp_mode()
> before re-programming.
>
> Fixes: 011f09d12052 ("riscv: mm: Set sv57 on defaultly")
> Reported-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/mm/init.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 9535bea8688c..b0793dc0c291 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -718,6 +718,7 @@ static __init void set_satp_mode(void)
>                 if (!check_l4) {
>                         disable_pgtable_l5();
>                         check_l4 = true;
> +                       memset(early_pg_dir, 0, PAGE_SIZE);
>                         goto retry;
>                 }
>                 disable_pgtable_l4();
> --
> 2.25.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>


-- 
Regards,
Atish
