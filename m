Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF5A4B1BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347081AbiBKB7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:59:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347045AbiBKB7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:59:30 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A092A3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:59:30 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id j2so20955707ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFbOrJB91dtVxjgEUlW+BHbOy4fENPTN+VGup/GPGvI=;
        b=aeJSwGK4rykn36fjxwiAifQ2+2Z3fzqooeZYqzv2HSpDW6trZ5eL8677kS4ve7tLAb
         nRHvWxcIg7fOShRWGGWiZI0QztkV5qQqv9TnwucdAyf3rR/tGcjbtVdrRSUr+xXWcLA2
         bnoOgTBm7nG4LySblTGJ2chjEd6Vvn5MMt4tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFbOrJB91dtVxjgEUlW+BHbOy4fENPTN+VGup/GPGvI=;
        b=ihwGyTheUmDjmJE13J6l3O5/oiQqiVoQRfY65osDm1vv2sT5bQk4DCz9QJ27cFbw4j
         OYgubhDli/53n9htXBTXHo2h55TYcC8aMt7gkDCmmEUHXf5NcoTh1papK6HNLROzaFOR
         oVO4shYjCOI5U4iZqRtB1L13vjzA9F+DL8i3s2DBuqKuSLyay7maTvC0NvMbgsBHJDcU
         GyhNDZvbo9Brdgs1W4aeAMi/dBADS9b5JBdVqvaKXbdF/8cHx1DtDy1M1uPc+7SoCkPM
         l2t82UQqWigRSfE7J++4A8uXDjVTtrVhXsdLNOilpPvbpZKf/YcUcZYwvpmBEGQsH3md
         SJZw==
X-Gm-Message-State: AOAM533y/5VZy3BF/yLAf5tJ2cvvw5E1eOAY7sszstrA9siCzWRL8ghc
        i69vm3VeEtPWcllrdtzo0xQeLTc9Mt0T3T45fOz/
X-Google-Smtp-Source: ABdhPJyeKsqysaL4TvIJFeamc+j405DBHQmC15tZqpzix8Oqnhrdb7vI+jS9cQQj4u9OuxoyR1INUXAwAjZxxxK+qdo=
X-Received: by 2002:a25:73d5:: with SMTP id o204mr10127820ybc.472.1644544769403;
 Thu, 10 Feb 2022 17:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20220209123800.269774-1-heiko@sntech.de> <20220209123800.269774-2-heiko@sntech.de>
In-Reply-To: <20220209123800.269774-2-heiko@sntech.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 10 Feb 2022 17:59:18 -0800
Message-ID: <CAOnJCUL6b=2dMJfJFTUj-3gshHGMYpgQEc0XUeSbkC4g7ayJkQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/14] riscv: prevent null-pointer dereference with sbi_remote_fence_i
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Wei Fu <wefu@redhat.com>,
        liush <liush@allwinnertech.com>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
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

On Wed, Feb 9, 2022 at 4:38 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The callback used inside sbi_remote_fence_i is set at sbi probe time
> to the needed variant. Before that it is a NULL pointer.
>
> Some users like the flush_icache_*() functions suggest a generic
> functionality, that doesn't depend on a specific boot-stage but
> uses sbi_remote_fence_i as one option to flush other cpu cores.
>
> So they definitly shouldn't run into null-pointer dereference

/s/definitly/definitely

> issues when called "too early" during boot.
>
> So introduce an empty function to be the standard for the __sbi_rfence
> function pointer until sbi_init has run.
>
> Users of sbi_remote_fence_i will have separate code for the local
> cpu and sbi_init() is called before other cpus are brought up.
> So there are no other cpus present at the time when the issue
> might happen.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/kernel/sbi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index f72527fcb347..c839acd668d3 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -15,11 +15,19 @@
>  unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
>  EXPORT_SYMBOL(sbi_spec_version);
>
> +static int __sbi_rfence_none(int fid, const struct cpumask *cpu_mask,
> +                            unsigned long start, unsigned long size,
> +                            unsigned long arg4, unsigned long arg5)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
>  static int (*__sbi_send_ipi)(const struct cpumask *cpu_mask) __ro_after_init;
>  static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
>                            unsigned long start, unsigned long size,
> -                          unsigned long arg4, unsigned long arg5) __ro_after_init;
> +                          unsigned long arg4, unsigned long arg5)
> +                          __ro_after_init = __sbi_rfence_none;
>
>  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>                         unsigned long arg1, unsigned long arg2,
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Otherwise, LGTM.
Reviewed-by: Atish Patra <atishp@rivosinc.com>


-- 
Regards,
Atish
