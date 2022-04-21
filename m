Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83F4509C48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387706AbiDUJdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386167AbiDUJdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:33:09 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391BCDED5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:30:20 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p12so2068231lfs.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67sfB0IzHVXeR5A8puxseus3O+X5kUTFhlECjiPj6x4=;
        b=fmIPbE1IBLcf3qYXbw+olE1xUMN93LGj1KaoeCohxNiXqe/IYmOR+GNMCYDO9BV3c5
         v8VrA2RrG9XLDbSN1FgCSuioGJ5TOoSErvJmCZpZsunnR+EtJv70QquoeihauNHuR0UP
         RirMlujj/Ha9r1dj1uUgIFTR3YrP1u/zjmXzkYSgv1J68uNJPbBu/73B2Sh2kwRKqugs
         inRGGd2FlV103fq8wddg04I7qf3rcM2wr7PTd0UYBkj36CXEV4Uf5QfdjYvDFLwyOON2
         aj5KJBCk1OJIDEVhC5GjAywZQAa/N1Xi6UfsgqhbtrtTWIeyitADL3C3l2X1Syi4OyB2
         9VCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67sfB0IzHVXeR5A8puxseus3O+X5kUTFhlECjiPj6x4=;
        b=tPY+wRsdttJGQYUOlLZEZQXsvrybSuhrSnloYs2VmZGJ5RPMOxbvmnialjQKUKlajv
         hGrVLk84x9YLo3tXdOOzDTyokl7ZoFWmLrhCpORQ3nPkhoSzGHPxcpJ53Ur7dFtriLT8
         +aeu61Hafd/er9HLTuXY9JCqdxc57yDr8MxKc/9c8tqPvuauXqCH6uRSw5J0RcXTMhGx
         Itf784j9kO368HLinnqQ3OhlQmcgm+D1wxTShzTOeZqhMtTLH84HW5QONNDCNL58v4AC
         cq9+y2muxmyQkRAJXgp175um3hr0EEN7EEdd2Mgxq/oaSzQLAnlqoBgXKrWLt94qd8r2
         qJ/A==
X-Gm-Message-State: AOAM533LMsWYqruqsOaxfAd3VmIQdByGn+vnKYCHh3K8LuWMgYB9Po6B
        wBbTbsYUwWh5Ky3xjZhCpaBPZbju02oH02FOF0jt/w==
X-Google-Smtp-Source: ABdhPJzoFpYEMBId0vI8slCjJdfA2UOYmWG5jdk+Km/dMYqYelRd2ehVOg2cAmAYllGKHBeStzko5XCzXa5i312zsiw=
X-Received: by 2002:ac2:5ddc:0:b0:46b:85a3:9c3 with SMTP id
 x28-20020ac25ddc000000b0046b85a309c3mr18314110lfq.130.1650533418465; Thu, 21
 Apr 2022 02:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220412033335.1384230-1-apatel@ventanamicro.com>
In-Reply-To: <20220412033335.1384230-1-apatel@ventanamicro.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 21 Apr 2022 15:00:05 +0530
Message-ID: <CAK9=C2UB-SKcb2Lf=m9VQZnOmkoY1W=kNeSJ40VcVXfr5WuPZQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: mm: Fix set_satp_mode() for platform not having Sv57
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Tue, Apr 12, 2022 at 9:04 AM Anup Patel <apatel@ventanamicro.com> wrote:
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

Can this be considered for 5.18-rcX ?

Regards,
Anup

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
