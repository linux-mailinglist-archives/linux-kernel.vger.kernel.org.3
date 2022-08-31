Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3A85A82DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiHaQR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiHaQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:17:26 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1BBD0773
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:17:25 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so25196220fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=686yqyz15WcAe19p1RSiWp4rGukhfeVW4c13nzq/ZBg=;
        b=pzHklyjlaVKSVk0F7QkOvEokdGUn1nAa+C+rU2Zpt3LfdREQD/SLrqB62f1qrxBYGt
         asVopJVcz3cvPhGY8DRimPwTooiNgRJXfElx6H9tV5JB3AGGOSYli58E02woQ8IZyFFG
         WVHO6J7VO82IbW63UU4mLZywmaqrqrcNF2Qn76/PMZ/A5q/keO58rXQQZDqtNu9UkVgF
         Gc8vbBA54Gm3MxCqeTmJu/leG48+TeC7kzR4YgJ+AIFE/hVWdArSgjtzEU6tjGXFOBG4
         cNxwGyk5M/p63hIWqbm6fIMYtRNeN2WY1baxt+TODYoFW2Evs0gL0cPf6iVs0Gsk88Nw
         J/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=686yqyz15WcAe19p1RSiWp4rGukhfeVW4c13nzq/ZBg=;
        b=Y3s7Gxs2jwhoMu/RTN8ieIOJo2eDiyWCRVgXjxUknTPlr05rPhkjTekIS5opQ+wZwo
         upnz7x1Op5HRTM3kIxyS8QJvsjgWrV0MpqUJ56uN03oZrkn5NAFkMekSfw+tG1AZL+dw
         tXGN9tGHP0djj3gSDRxD+mLHGgQxe2p+lm+CiMAjR63+1oDfw8kBAFONQORHDjrhU2s9
         EqTfdN2DFqkVr6ZQBp4nTmZf/O8jK3pcf+1241A9l88iJOssM6MAzsEAjwu8KFfifBh+
         rRp1QFIJipzmwWkm/m6evfZUayYFSy2A612waQFrzSnX1xeN33DIKLshiCJH8dGApzpL
         imbQ==
X-Gm-Message-State: ACgBeo1Ns82ybKnalfeMyS8P/RP0+/uCZx8PDAf+rM/7tVq5/uFkwn1/
        69OYBANIqxO2U2UEsGsYKtPtld0B5fmIbufCBxNZQQ==
X-Google-Smtp-Source: AA6agR4Klh8aMsFIsvjGYZiAAcmTScaNnG3yfe9Ho+c99cPGWW3sFacLNoQfpvuitCb2L2Rmr40M6d7wF+cvtUcgGPg=
X-Received: by 2002:aca:170f:0:b0:343:171f:3596 with SMTP id
 j15-20020aca170f000000b00343171f3596mr1491289oii.181.1661962644939; Wed, 31
 Aug 2022 09:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220831143150.304406-1-cui.jinpeng2@zte.com.cn>
In-Reply-To: <20220831143150.304406-1-cui.jinpeng2@zte.com.cn>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 31 Aug 2022 09:17:14 -0700
Message-ID: <CALMp9eT1yz0q1xn2nPtKBbnx_ixX4ivFk=qOayz70k_hxooaoQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] KVM: selftests: remove redundant variable tsc_val
To:     cgel.zte@gmail.com
Cc:     pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Aug 31, 2022 at 7:31 AM <cgel.zte@gmail.com> wrote:
>
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
>
> Return value directly from expression instead of
> getting value from redundant variable tsc_val.

Nit: I think you mean 'superfluous' rather than 'redundant'?

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> ---
>  tools/testing/selftests/kvm/include/x86_64/processor.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 0cbc71b7af50..75920678f34d 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -237,7 +237,6 @@ static inline uint64_t get_desc64_base(const struct desc64 *desc)
>  static inline uint64_t rdtsc(void)
>  {
>         uint32_t eax, edx;
> -       uint64_t tsc_val;
>         /*
>          * The lfence is to wait (on Intel CPUs) until all previous
>          * instructions have been executed. If software requires RDTSC to be
> @@ -245,8 +244,8 @@ static inline uint64_t rdtsc(void)
>          * execute LFENCE immediately after RDTSC
>          */
>         __asm__ __volatile__("lfence; rdtsc; lfence" : "=a"(eax), "=d"(edx));
> -       tsc_val = ((uint64_t)edx) << 32 | eax;
> -       return tsc_val;
> +
> +       return ((uint64_t)edx) << 32 | eax;
>  }

This does beg the question: "Why?"
