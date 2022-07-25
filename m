Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1528F57FA3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiGYH24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiGYH2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:28:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93AD11C12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:28:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m8so12711831edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMEnrGB4HYdP/eTvNNcIwLpDOuUcAudKRal9PHh2i7k=;
        b=hq5GgIgKeCBfU14aRy/moRxb86DWt6ZbGJn/vYeSSUv00MJguhXNpZ7RQ6rVHvg4DQ
         /mlok3N0gF2bs+nPxCC7EcDSY4d/n+G+DJUF8cVWzbimrmXVQdhz6TZZ1uKPjY1cpG7V
         Eci2TpATgrR0EdSrzys5pQIZbqoJltVSdt4mrjLiRsdmLS2DpXCkqJCVHxNGTFMXL6QE
         N8yJvqDHsH8s56sggqrtjgpMc5h9JECZqx++CZ48s3kAzHdz8KWEYP6SGBkuMDa+9XFu
         zFaO1tFyCkbcBDPvWwwATJAhesMYynG7ffKWtyTxiuZfA8om/x3MXXmbdIdDX3nZ7KMU
         eNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMEnrGB4HYdP/eTvNNcIwLpDOuUcAudKRal9PHh2i7k=;
        b=DjQ0O96bfhrlX+/Ez4Vt3DpLwM0k+bcfWiJO3ZmAJRUDAj2sgkb+zrw9IUujFOFURV
         tNZ2Tw5GkXsEce72AzR1iBhL2XXxCUwEMej2nWP95U7IVvibYr91W0Degx4hmprKtoPd
         qsf//olEBIjJGLis1vgoZhKTu5S+5XjrvGNsfdcCqsJPLXh3Pzwida7FBnEt/4S9DdKh
         WDlfLhs38fbzBiAKAb4JsbdvKYhACEIcyQi++VHAyKkUEjH8LYnaj6dkMTkp6gU5XfnS
         4Z939TeKO1h20sm7i9SYycOaqanAc0CyR3/DXUNswMwzHMbJbi6D0hzZET8ZbpX3u1wf
         HYwQ==
X-Gm-Message-State: AJIora/nabRhT0d7FhDO65LSQwa8VGsAoAvDoTzQKzImVwIEphnPynP8
        3iPf1VEAIvmf2QrKSdFxnev1Oyl3r9BoF/10Rkw=
X-Google-Smtp-Source: AGRyM1vdcAIHTjS02QftTovrDwGv8zlIcrR9fl04Bm4gKAIHUl3rgnkBKb7VLEoYIUbwOj6oZjkCrW9gXNf8bkHM6o4=
X-Received: by 2002:a05:6402:1768:b0:43b:c4b0:ffd3 with SMTP id
 da8-20020a056402176800b0043bc4b0ffd3mr11443522edb.163.1658734129332; Mon, 25
 Jul 2022 00:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220723214537.2054208-1-yury.norov@gmail.com> <20220723214537.2054208-2-yury.norov@gmail.com>
In-Reply-To: <20220723214537.2054208-2-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 09:28:12 +0200
Message-ID: <CAHp75VfOmN=cTEs7gbwxZ7W3hXjBo67N4AmHHiDfcVfFzHkMLA@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: drop dependency on <asm/machdep.h> in archrandom.h
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 12:19 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> archrandom.h includes <asm/machdep.h> to refer ppc_md. This causes
> circular header dependency, if generic nodemask.h  includes random.h:
>
> In file included from include/linux/cred.h:16,
>                  from include/linux/seq_file.h:13,
>                  from arch/powerpc/include/asm/machdep.h:6,
>                  from arch/powerpc/include/asm/archrandom.h:5,
>                  from include/linux/random.h:109,
>                  from include/linux/nodemask.h:97,
>                  from include/linux/list_lru.h:12,
>                  from include/linux/fs.h:13,
>                  from include/linux/compat.h:17,
>                  from arch/powerpc/kernel/asm-offsets.c:12:
> include/linux/sched.h:1203:9: error: unknown type name 'nodemask_t'
>  1203 |         nodemask_t                      mems_allowed;
>       |         ^~~~~~~~~~
>
> Fix it by removing <asm/machdep.h> dependency from archrandom.h

...

>  EXPORT_SYMBOL_GPL(pm_power_off);

^^^ (Note this and read below)

...

> +EXPORT_SYMBOL(arch_get_random_seed_long);

It can't be like this. Brief browsing of the callees shows that.

-- 
With Best Regards,
Andy Shevchenko
