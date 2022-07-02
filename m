Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E715642F1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 23:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiGBVr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGBVr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 17:47:57 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D4ABC3C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 14:47:55 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g1so4280656qkl.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3yxd1JuZYYSXp25FfPMzZsUpsIGhEAwAifK8R297puA=;
        b=iZ1SRnu76ni04LkPk1t99mrix/HXpZ/JNm1Y5aE48QNoee2ALwxeDiafOJJGqyhRUT
         avGKr+IJtb0moRwACMDAqsyep8vnjeMPh1XILSovC+/oaqZS5oT9kSH/xnkVipl1Tcli
         ooD4XWJPv0M9R3JSpb9tPR9tZo4nN0EVJEuxJz+r6v9e6e90IleYM193LXpFnw9VySiH
         2EGTI6GjLqwn1NlCYpp2N/cQGHgk4WcT20SNtGQ0YObCf93+Vka5rfrFwCor7xNidG82
         /RHW5pXvVLyAwcQFyz0CC/V32G3ODOHPONFIsw52yuq9fBAOQJoVttu+5gGPgGrj1NUs
         1zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3yxd1JuZYYSXp25FfPMzZsUpsIGhEAwAifK8R297puA=;
        b=FwCntQhWuWfXubiUdVIxPFWJLwnPDy1+CzCLf+UASXTbVKjqz/+WEuTZitCDq7ctrB
         TfnqtzIXvIZhFyO0scliMACsBSNGZ8ULLSNzz614H3X3MlkhSkNLaJnNq03yFRgEq1Sm
         PojqI75jv1xS29a0lroElXMXexr6sMttwFoaZIaVN2ZVbJnpety/kbYHsQdCcLzGwxcu
         eqcqoN41HXcKCwlW/As8HRM6Ps0+WfblZC8zG8AVBL2UDyEfKOJk961xxeoxL7aC3fxk
         r92BVlai0DVe7WQcpb5cwbcldfB42J3fcHk7OBLqvVShKe55l6RWVOblfBN0xwLdfgzc
         hzVA==
X-Gm-Message-State: AJIora+OowpUyQLCVl8mBChPjDz/tby8Bf3L+ek0ep35Q3spKSPDU9VU
        vFf2K/ZV2OZnTXzEnY9jtmQ=
X-Google-Smtp-Source: AGRyM1s0pMZnO75QPJUtjh8ZY0i9k3NhV2Lt/n5KVPgi0zTa8bMmmuNfZUxYftR+xqHpVkLoZXx4PQ==
X-Received: by 2002:a37:416:0:b0:6ae:ea2e:c82c with SMTP id 22-20020a370416000000b006aeea2ec82cmr15269199qke.273.1656798474948;
        Sat, 02 Jul 2022 14:47:54 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:e838:b1c2:b125:986a])
        by smtp.gmail.com with ESMTPSA id d3-20020a05620a240300b006af45243e15sm15161960qkn.114.2022.07.02.14.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:47:54 -0700 (PDT)
Date:   Sat, 2 Jul 2022 14:47:54 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        elver@google.com, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 4/5] cpumask: Add UP optimised for_each_*_cpu versions
Message-ID: <YsC9CuiLRbhMAC51@yury-laptop>
References: <cover.1656777646.git.sander@svanheule.net>
 <3a92869b902a075b97be5d1452c9c6badbbff0df.1656777646.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a92869b902a075b97be5d1452c9c6badbbff0df.1656777646.git.sander@svanheule.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 06:08:27PM +0200, Sander Vanheule wrote:
> On uniprocessor builds, the following loops will always run over a mask
> that contains one enabled CPU (cpu0):
>     - for_each_possible_cpu
>     - for_each_online_cpu
>     - for_each_present_cpu
> 
> Provide uniprocessor-specific macros for these loops, that always run
> exactly once.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

Acked-by: Yury Norov <yury.norov@gmail.com>

> ---
>  include/linux/cpumask.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 7fbef41b3093..6c5b4ee000f2 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -750,9 +750,16 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
>  /* First bits of cpu_bit_bitmap are in fact unset. */
>  #define cpu_none_mask to_cpumask(cpu_bit_bitmap[0])
>  
> +#if NR_CPUS == 1
> +/* Uniprocessor: the possible/online/present masks are always "1" */
> +#define for_each_possible_cpu(cpu)	for ((cpu) = 0; (cpu) < 1; (cpu)++)
> +#define for_each_online_cpu(cpu)	for ((cpu) = 0; (cpu) < 1; (cpu)++)
> +#define for_each_present_cpu(cpu)	for ((cpu) = 0; (cpu) < 1; (cpu)++)
> +#else
>  #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
>  #define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
>  #define for_each_present_cpu(cpu)  for_each_cpu((cpu), cpu_present_mask)
> +#endif
>  
>  /* Wrappers for arch boot code to manipulate normally-constant masks */
>  void init_cpu_present(const struct cpumask *src);
> -- 
> 2.36.1
