Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1183E58543D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiG2RMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiG2RMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:12:14 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E466C106
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:12:10 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id d1so2490699qvs.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bB6h+a2TXAiaK1l6PDGK1rNQ6Pg8IYnzzV4HOHqvP7k=;
        b=A6xFbfHz0XVqVR3JyFvyrvVoiH6xcHynYZYp8VD7cnQKWsQyvOjMtNHUV0k61x9Wj4
         vVGWjLhg0jotH3/8HAGLQY5tGKWpHzj3XulucpR/XV/MgIkZhij+nRMLaZ2Bg5Fv5GnM
         1ZBSKPN8DLTtt3+XiliESIeOEJS+JfcdgXlU4UfNDZrU4hMMyRx7lNjvaNG974HhwZCF
         DSYulr3ikoMe21oEr0wf9Y3BWk40iL7EfeAvTqc4GGeeDyNt4Nn3iN9twq+MZnTcastO
         axxgd0OohYfiI2y2g2J2rSFFOkdIC+cs6fpedqTpWIicIqT1FmzhXTqG5YycTFYdEQQx
         +7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bB6h+a2TXAiaK1l6PDGK1rNQ6Pg8IYnzzV4HOHqvP7k=;
        b=0BLwo22lnx4d8NO3FULurxxW3Q3hMbMw90EkVCCBYF4uGY1MmJ5NMeKrKYR2fGS5jL
         256gHtsfiuqkwk4zthotZFC5jvNzcEuJJF/UGuNh8YKkqpi9zg4V93oAR+1wdAhM8vF6
         EuqqurU3bLTswBSULvgm1fGP/wpOdSdXKlNAuMFPzNOYs0EX+1JKLu18Bq6eP2WLI/be
         EIkQR63LY2x2pShwonw4pux/p0v2J7wb2iK7Xp9VIxR4pttYpIJvdbqetXXqQyVYTYOF
         mfncas0s9a3B659az2Ur91faaXCe/GsV4IGjBISC+0xoh0gbk69mtmIHVIyFnQl6fCTc
         RQiw==
X-Gm-Message-State: ACgBeo3xoY2FedmVoT5FUh/19LM4vPFAw53C7C61JFnzcafY1BX9Bnv/
        U2wa8hPliGYgCUBtLW321aKKG3fGYrQZXZDqxd4EAQ==
X-Google-Smtp-Source: AA6agR4uP9KEwUm6KCouYMQ1SndV5cG0W/ceJ1ZOnlf8Qnb1n2DEYDZ938oj+gtj5eMS3FH7FJtdQ/CZcB41WlifjWw=
X-Received: by 2002:a05:6214:20a5:b0:474:6a76:1ccd with SMTP id
 5-20020a05621420a500b004746a761ccdmr4162000qvd.44.1659114729470; Fri, 29 Jul
 2022 10:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <CA+khW7hVwRQwXshymZCotPZyHmWXj7gjZvJO1_NnjnBSNjYj+A@mail.gmail.com>
 <20220729044317.31975-1-liulin063@gmail.com>
In-Reply-To: <20220729044317.31975-1-liulin063@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 29 Jul 2022 10:11:54 -0700
Message-ID: <CA+khW7iknv0hcn-D2tRt8HFseUnyTV7BwpohQHtEyctbA1k27w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Do more tight ALU bounds tracking
To:     Youlin Li <liulin063@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Youlin,

On Thu, Jul 28, 2022 at 9:44 PM Youlin Li <liulin063@gmail.com> wrote:
>
> 32bit bounds and 64bit bounds are updated separately in
> adjust_scalar_min_max_vals() currently, let them learn from each other to
> get more tight bounds tracking. Similar operation can be found in
> reg_set_min_max().
>
> Before:
>
>     func#0 @0
>     0: R1=ctx(off=0,imm=0) R10=fp0
>     0: (b7) r0 = 0                        ; R0_w=0
>     1: (b7) r1 = 0                        ; R1_w=0
>     2: (87) r1 = -r1                      ; R1_w=scalar()
>     3: (87) r1 = -r1                      ; R1_w=scalar()
>     4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
>     5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0xffffffff))  <--- [*]
>     6: (95) exit
>
> It can be seen that even if the 64bit bounds is clear here, the 32bit
> bounds is still in the state of 'UNKNOWN'.
>
> After:
>
>     func#0 @0
>     0: R1=ctx(off=0,imm=0) R10=fp0
>     0: (b7) r0 = 0                        ; R0_w=0
>     1: (b7) r1 = 0                        ; R1_w=0
>     2: (87) r1 = -r1                      ; R1_w=scalar()
>     3: (87) r1 = -r1                      ; R1_w=scalar()
>     4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
>     5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0x3))  <--- [*]
>     6: (95) exit
>
> Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")

This change looks to me like an improvement, rather than a bug fix. We
probably don't need this tag.

> Signed-off-by: Youlin Li <liulin063@gmail.com>
> ---
>  kernel/bpf/verifier.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0efbac0fd126..888aa50fbdc0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8934,10 +8934,13 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>                 break;
>         }
>
> -       /* ALU32 ops are zero extended into 64bit register */
> -       if (alu32)
> +       if (alu32) {
> +               /* ALU32 ops are zero extended into 64bit register */
>                 zext_32_to_64(dst_reg);
> -       reg_bounds_sync(dst_reg);
> +               __reg_combine_32_into_64(dst_reg);

This __reg_combine_32_into_64 can be replaced with simply
reg_bounds_sync, because the above zext_32_to_64 has already
propagated 32 to 64. Using reg_bounds_sync would be more efficient.

It turns out we can now fold reg_bounds_sync into zext_32_to_64. Can
you do that and resend? IMO that will make the code slightly cleaner.

> +       } else {
> +               __reg_combine_64_into_32(dst_reg);
> +       }
>         return 0;
>  }
>
> --
> 2.25.1
>
