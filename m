Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE84A5A0B78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiHYI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbiHYI2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:28:21 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADEF51438
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:28:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i7so14587641qka.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ke6WIRIWSNDEQe/wY0VHI5geaK0bwRFL8irWBp0pDpo=;
        b=IiQ9DagLmvJrc2PH/b+b2bVepeX1fBVAFaNiG1SwksacAWJAh1+eCBSQbyb7l8QBXP
         20PRaE/io0D4NCnN4Sdn09JEZ34u5Qzub6ztxa8UOiAHv0KX1ESeTtN6u67Pv9Ocms5T
         GxlBMRFam91kV7W1tYRDFkH9yUKq2Un53ctVSILX91Im0e0Y9+aHI6uX9BAVAfKTYdcm
         ndKxw1vU+deMVPSDDTaWVOCnLW+8l0m9Ix9eggSvE/OxWHm0wORpY7hTvVk/lKZJyGE6
         MhKDflEZmO9/j1+yq4qMerYRPrvgGe54LfFtCIlRWE/tHcSK4uQzT+/wxZ80l1E+aKNY
         khag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ke6WIRIWSNDEQe/wY0VHI5geaK0bwRFL8irWBp0pDpo=;
        b=csTR1ZUEWV7ai2CkFbInSeLTFI2eSs5uolG9bEXSi6Q4Hclvnw95M2gha+CI9s08MH
         hWIgitPIf2U495HWKMlJb+B2+LWZVvkbz0sf3ymsb15KLcPk2I29kM26M5rqUe7zlXCb
         Q/1eXdUjTcKqzsSyyFQLyRLb03tTLTGcSeBJhs2/gV33mVvryCIS36kZ90cjBml38Su2
         YDOgMCtxBj+eTsRc+bV/ps1WhhSAcc2jh0bk14Q02OjKkk796DIbVECdbYQXSR4Wv/Wo
         4UsfE0ZJBlYiNyFVwW3Fm65XRx44aCW3xlQfrfkB0i03oiOGCOfFuPw1rPlT0KUUtI/+
         nNZQ==
X-Gm-Message-State: ACgBeo1qsNwo4x/wJMqmISCA8nQQ9dzhwrB8tQtCOc3V/d/moqxJjAP4
        76FkSpfMgGlBA41IbssLglKhuo5lpXTUJslQpA4=
X-Google-Smtp-Source: AA6agR4DJ53INtNlu0lOezpb9LaiBIkX/3rdV/bGy/sY6NFF90ttZFEFF3Jxb2Fj2tRYJqgMnJirjDIKJehog7WouIU=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr2183968qkf.320.1661416099613; Thu, 25
 Aug 2022 01:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220825060819.74303-1-liaochang1@huawei.com>
In-Reply-To: <20220825060819.74303-1-liaochang1@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 11:27:43 +0300
Message-ID: <CAHp75VdyYY08uwJGi0m4-L9=9rLmFzkeJGTi2-NC=prbgKvo3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] genirq: Record dangling hwirq number into struct irq_data
To:     Liao Chang <liaochang1@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michael Kelley <mikelley@microsoft.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,PDS_BTC_ID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 9:11 AM Liao Chang <liaochang1@huawei.com> wrote:

Use spell-checker, please. Or ask somebody for proof-reading of your
commit messages and comments in the code.

> Following interrupt allocation process lead to some interrupts are

leads

> mapped in the low-level domain(Arm ITS), but they are never been mapped

never mapped
  ...or...
they have never

> at the higher level.
>
> irq_domain_alloc_irqs_hierarchy(.., nr_irqs, ...)
>   its_irq_domain_alloc(..., nr_irqs, ...)
>     its_alloc_device_irq(..., nr_irqs, ...)
>       bitmap_find_free_region(..., get_count_order(nr_irqs))
>
> Since ITS domain find a region of zero bits, the length of which must

finds

> aligned to power of two. If nr_irqs is 30, the length of zero bits is

the power

> actually 32, but only first 30 bits are really mapped.

the first

> On teardown, low-level domain only free these interrupts that actually

the low-level
   ...or...
domains

> mapped, and leave last interrupts dangling in the ITS domain. Thus the
> ITS device resources are never freed. On device driver reload, dangling
> interrupts prevent ITS domain from allocating enough resource.
>
> irq_domain_free_irqs_hierarchy(..., nr_irqs, ...)
>   its_irq_domain_free(..., irq_base + i, 1)
>     bitmap_release_region(..., irq_base + i, get_count_order(1))
>
> John reported this problem to LKML and Marc provided a solution and fix
> it in the generic code, see the discussion from Link tag. Marc's patch
> fix John's problem, but does not take care of some corner case, look one
> example below.
>
> Step1: 32 interrupts allocated in LPI domain, but return the first 30 to
> higher driver.
>
>    111111111111111111111111111111 11
>   |<------------0~29------------>|30,31|
>
> Step2: interrupt #16~28 are released one by one, then #0~15 and #29~31
> still be there.
>
>    1111111111111111 0000000000000 1  11
>   |<-----0~15----->|<---16~28--->|29|30,31|
>
> Step#: on driver teardown, generic code will invoke ITS domain code
> twice. The first time, #0~15 will be released, the second one, only #29
> will be released(1 align to power of two).
>
>    0000000000000000 0000000000000 0  11
>   |<-----0~15----->|<---16~28--->|29|30,31|
>
> In short summary, the dangling problem stems from the number of released
> hwirq is less than the one of allocated hwirq in ITS domain. In order to

the allocated

> fix this problem, make irq_data record the number of allocated but
> unmapped hwirq. If hwirq followed by some unmapped bits, ITS domain
> record the number of unmapped bits to the last irq_data mapped to higher
> level, when the last hwirq followed by unmapped hwirq is released, some
> dangling bit will be clear eventualy, look back the trivial example

eventually

> above.
>
> Step1: record '2' into the irq_data.dangling of #29 hwirq.
>
>            111111111111111111111111111111 11
>           |<------------0~29------------>|30,31|
> dangling:  000000000000000000000000000002
>
> Step2: no change
>
>           1111111111111111 0000000000000 1  11
>          |<-----0~15----->|<---16~28--->|29|30,31|
> dangling: 0000000000000000 0000000000000 2
>
> Step3: ITS domain will release #30~31 since the irq_data.dangling of #29
> is '2'.
>
>            0000000000000000 0000000000000 0  00
>           |<-----0~15----->|<---16~28--->|29|30,31|
> dangling:  0000000000000000 0000000000000 2

> Fixes: 4615fbc3788dd ("genirq/irqdomain: Don't try to free an interrupt
> that has no mapping")

All tags must be one-liners. I.o.w. do not split a tag to multiple lines.

...

> + * @dangling:          amount of dangling hardware interrupt, Arm ITS allocate
> + *                     hardware interrupt more than expected, aligned to power
> + *                     of two, so that unsued interrupt number become dangling.

unused
becomes

> + *                     Use this field to record dangling bits follwoing @hwirq.

following

-- 
With Best Regards,
Andy Shevchenko
