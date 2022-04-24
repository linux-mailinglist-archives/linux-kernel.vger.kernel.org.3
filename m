Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2404150D211
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 15:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbiDXNfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 09:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiDXNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 09:35:19 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082C56E8C5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 06:32:19 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id g28so3292068ybj.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 06:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRmaRiNmR93d3ALdKPyXM8y47NNkfnslNRnhmG/iMDk=;
        b=qca+pRIJH72KejbH7dQifTMVoEpBq603vlSllvC8/+XJV/Ih+tkDSp1xTIZKx2bE7P
         wCKyf1kNMUAqzbJ5iN0WRlbjk0QRWkYJp9ssmHO3QGsK+3ApoKmUX9kT32Ms56iktgng
         94KQiSr8dxktplNVKUpJiBdArm/g8UziNqYKaykdC8pjNZQu8koRjvXnsVAhPr19DzDy
         j0WOTu52VoVwREh+exoFNohOOkMc4YecRCzQywPfzzugMZW4px5vPpWtO1hKa4kKQfLA
         FbV++sAaqsLLj5haVMl5kJ5xr1BiOOgUUmy/PDByI68776hGr8Wk1eDH6O/itMx2D1Bj
         f7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRmaRiNmR93d3ALdKPyXM8y47NNkfnslNRnhmG/iMDk=;
        b=sBbiytYLAdTzkEkvL00CiomBq4mcFDp5BMCNUZ5TxZp3OiuasKPN56ThLw6dA0DPdn
         IcBvzdI04Hx0XoKjohFylHYuRgQ8ejuL5T03aFdtAQX6UUQjGqoRszVXs2cgEDDAXNHC
         qONWjHG00zBI95X9ulkyKAH9RYTIAPcKilz8LNSpoC9dgbefINcn6KhYNKDwjoUlvAf8
         nlLAyGD5BEsgcdEy+TOjecsQ4rn0NsoPETZrkiqJGB3Bv3ppk8esIT4Ya5G8TnRLuIL0
         FIfUWImARbwJ3rbvlIq2XcBfarESELDMBA+9oV8+M/Fc2YhXyW/OqPhlW57e8igsw/2G
         CWbQ==
X-Gm-Message-State: AOAM531yI5ZJ5nJtI/6LuOS180gfDJa4mYAMreDI4517MzM3yNlWN8J8
        BAeXrCYFO0JDe20rM7XZPkwr4GI3UHTsUdKzOuCrNw==
X-Google-Smtp-Source: ABdhPJzWaLOsN1IPUwLXHVCcp7mmvqOiHSQKQ2cBiUtnRf6Qy+787bBKwCWUR5ByN3ohMrg0M+I4sRr+GnYQSWZGN44=
X-Received: by 2002:a25:cc0b:0:b0:648:4590:6cb6 with SMTP id
 l11-20020a25cc0b000000b0064845906cb6mr3692673ybf.87.1650807138108; Sun, 24
 Apr 2022 06:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220424105949.50016-1-huangshaobo6@huawei.com>
In-Reply-To: <20220424105949.50016-1-huangshaobo6@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Sun, 24 Apr 2022 15:31:42 +0200
Message-ID: <CANpmjNPEErc2mZMSB=QyT3wq08Q4yGyTGiU3BrOBGV3R5rNw-w@mail.gmail.com>
Subject: Re: [PATCH v2] kfence: enable check kfence canary in panic via boot param
To:     Shaobo Huang <huangshaobo6@huawei.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, young.liuyang@huawei.com,
        zengweilin@huawei.com, chenzefeng2@huawei.com,
        nixiaoming@huawei.com, wangbing6@huawei.com,
        wangfangpeng1@huawei.com, zhongjubin@huawei.com
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

On Sun, 24 Apr 2022 at 13:00, Shaobo Huang <huangshaobo6@huawei.com> wrote:
>
> From: huangshaobo <huangshaobo6@huawei.com>
>
> when writing out of bounds to the red zone, it can only be
> detected at kfree. However, the system may have been reset
> before freeing the memory, which would result in undetected
> oob. Therefore, it is necessary to detect oob behavior in
> panic. Since only the allocated mem call stack is available,
> it may be difficult to find the oob maker. Therefore, this
> feature is disabled by default and can only be enabled via
> boot parameter.

This description is still not telling the full story or usecase. The
story goes something like:
"""
Out-of-bounds accesses that aren't caught by a guard page will result
in corruption of canary memory. In pathological cases, where an object
has certain alignment requirements, an out-of-bounds access might
never be caught by the guard page. Such corruptions, however, are only
detected on kfree() normally. If the bug causes the kernel to panic
before kfree(), KFENCE has no opportunity to report the issue. Such
corruptions may also indicate failing memory or other faults.

To provide some more information in such cases, add the option to
check canary bytes on panic. This might help narrow the search for the
panic cause; but, due to only having the allocation stack trace, such
reports are difficult to use to diagnose an issue alone. In most
cases, such reports are inactionable, and is therefore an opt-in
feature (disabled by default).
"""

Please feel free to copy or take pieces above to complete the commit message.

> Suggested-by: chenzefeng <chenzefeng2@huawei.com>
> Signed-off-by: huangshaobo <huangshaobo6@huawei.com>
> ---
> v2:
> - it is only detected in panic.
> - it is disabled by default.
> - can only be enabled via boot parameter.
> - the code is moved to the specified partition.
> Thanks to Marco for the valuable modification suggestion.
> ---
>  mm/kfence/core.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 9b2b5f56f4ae..0b2b934a1666 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -29,6 +29,8 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
> +#include <linux/notifier.h>
> +#include <linux/panic_notifier.h>

Please keep these includes sorted alphabetically.

>  #include <asm/kfence.h>
>
> @@ -99,6 +101,10 @@ module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ulong, 0644)
>  static bool kfence_deferrable __read_mostly = IS_ENABLED(CONFIG_KFENCE_DEFERRABLE);
>  module_param_named(deferrable, kfence_deferrable, bool, 0444);
>
> +/* If true, check kfence canary in panic. */

It should be "on panic". E.g. "If true, check all canary bytes on panic."

> +static bool kfence_check_on_panic;
> +module_param_named(check_on_panic, kfence_check_on_panic, bool, 0444);
> +
>  /* The pool of pages used for guard pages and objects. */
>  char *__kfence_pool __read_mostly;
>  EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
> @@ -727,6 +733,30 @@ static int __init kfence_debugfs_init(void)
>
>  late_initcall(kfence_debugfs_init);
>
> +/* === Panic Notifier ====================================================== */

Blank line between /* === ... */ and function.

> +static void kfence_check_all_canary(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> +               struct kfence_metadata *meta = &kfence_metadata[i];
> +
> +               if (meta->state == KFENCE_OBJECT_ALLOCATED)
> +                       for_each_canary(meta, check_canary_byte);
> +       }
> +}
> +
> +static int kfence_check_canary_callback(struct notifier_block *nb,
> +                                       unsigned long reason, void *arg)
> +{
> +       kfence_check_all_canary();
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block kfence_check_canary_notifier = {
> +       .notifier_call = kfence_check_canary_callback,
> +};
> +
>  /* === Allocation Gate Timer ================================================ */
>
>  static struct delayed_work kfence_timer;
> @@ -804,6 +834,9 @@ static void kfence_init_enable(void)
>         else
>                 INIT_DELAYED_WORK(&kfence_timer, toggle_allocation_gate);
>
> +       if (kfence_check_on_panic)
> +               atomic_notifier_chain_register(&panic_notifier_list, &kfence_check_canary_notifier);
> +
>         WRITE_ONCE(kfence_enabled, true);
>         queue_delayed_work(system_unbound_wq, &kfence_timer, 0);
>
> --
> 2.12.3
>
