Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD8D47F2C8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 10:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhLYJgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 04:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhLYJgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 04:36:15 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F508C061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 01:36:15 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id v22-20020a9d4e96000000b005799790cf0bso13812728otk.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 01:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sroP+99PYY1sqFqgqdNQk02GgpKt/uXRxPmq42MiTbA=;
        b=nsJQtxDlylIm6dRRBzdTfQ7iYNeOVmEI11OFgIPNWxoOzy2XcJpNJ23mi9cUDQsFwd
         IsS7clec+npxjVjyiANrCjYXR3D1BsdIWiq+4zzIFqTlEWdVvcewfj8G7SgoXpVMxQ0a
         IMchIjTRmJJWAzePquZO+TJFAJGDKumiXfDB85wZ1c4cmjscMU47zzZ7p6Kpd0wJih/B
         GDGSxINczqYIg3YMU8A+MTElTbH774UZMbnr8qoihJC5gC02Qk1tsGHzzbiFzJcMqatV
         ib5YJyW+8UoBSWDST6Fb9WQywIgINbG32JCy8nrowxGhs0y/zjHsjJX0PNThLosSGzi5
         3IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sroP+99PYY1sqFqgqdNQk02GgpKt/uXRxPmq42MiTbA=;
        b=EOYZV1d05aEoJflq58hMb/GbJR63vJZBH7zhnB8+Yh8D61C44dlW0TSZhSvBF075X6
         g+KlM6hslUNFWPFWORDhrJdpf/MxA99VwLUmyLExmoONHfG8WDyl/5CMpV5/TlfUmc3d
         Ts44VrrzF71AU83vcedxhVVCJzYjyyQpDPJAb6p23TeYuiE/vgRm4hNEu1C3LdXkerUT
         OJi6Gs/dRlquhis+J0BoMzw8cakc8djuTDccUQUGQqHvlqypi/JbtWts/e9GI6fEfyOx
         PqWil8kvqpoRHG0WmacwoNdMft+szwa4xtItVqAYiLpAr6Dxu4OQbFIJ4xQB4uCBu8Vi
         AXhg==
X-Gm-Message-State: AOAM530yUNC8AIKfDMweZ/DVh7pBeJOJWrx9bIoBrwRixVvTfHUXT1dO
        R29O9IW7SDBTKRGoRrHkQ8CJLZ7MsvTfVddAon6j+w==
X-Google-Smtp-Source: ABdhPJydBlcJPibzbvxvGPgXeu/h06+DMbnQi6jSI7xPEHPY6+CUUy5PVJw4EGvEKDnb+sRWk+YU8lLqQUiN6pJ4eaI=
X-Received: by 2002:a9d:7f10:: with SMTP id j16mr6596628otq.92.1640424974367;
 Sat, 25 Dec 2021 01:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20211222075406.57191-1-qiang1.zhang@intel.com>
 <CANpmjNOmaSxqTjUd8y=A+sK0jGg6c00t8uvmOey+QrJsDamsmQ@mail.gmail.com>
 <PH0PR11MB58802F642473BA6213446AB7DA7F9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CANpmjNPU9Yw3RtsSrn0ZfdKQ7XUEp-Ecu9Wcx4HGhH3D+6-CrQ@mail.gmail.com> <PH0PR11MB5880B73436ADB3B8216C045DDA409@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880B73436ADB3B8216C045DDA409@PH0PR11MB5880.namprd11.prod.outlook.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 25 Dec 2021 10:36:03 +0100
Message-ID: <CANpmjNP2kz9eYY2V_A82fqWbvJuVt045e2Ni9NFrmuO-uAvGeg@mail.gmail.com>
Subject: Re: [PATCH] rcu: record kasan stack before enter local_irq_save()/restore()
 critical area
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "Miao, Jun" <jun.miao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Dec 2021 at 09:39, Zhang, Qiang1 <qiang1.zhang@intel.com> wrote:
[...]
> Hi Marco, Are the following modifications clear to you?

I understood now that the contention you're talking about is from
depot_lock, which wasn't clear before (I thought you intended to
reduce contention by shortening some other critical section).

> Subject: [PATCH] rcu: Reduce the consumption time of
>  local_irq_save()/restore() critical area

Subject: rcu, kasan: Record work creation stack trace with interrupts enabled

> In non-production KASAN kernel, a large number of call stacks are recorded,
> it takes some time to acquire the global spinlock(depot_lock) inside
> kasan_record_aux_stack_noalloc(), increased interrupts disable time,
> kasan_record_aux_stack_noalloc() doesn't care if interrupts are enabled or
> not when called, so move it outside the critical area.

I think this might be clearer:

"Recording the work creation stack trace for KASAN reports in
call_rcu() is expensive, due to unwinding the stack, but also due to
acquiring depot_lock inside stackdepot (which may be contended).
Because calling kasan_record_aux_stack_noalloc() does not require
interrupts to already be disabled, this may unnecessarily extend the
time with interrupts disabled.

Therefore, move calling kasan_record_aux_stack() before the section
with interrupts disabled."

> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Acked-by: Marco Elver <elver@google.com>

> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9b58bae0527a..36bd3f9e57b3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3068,8 +3068,8 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>         }
>         head->func = func;
>         head->next = NULL;
> -       local_irq_save(flags);
>         kasan_record_aux_stack_noalloc(head);
> +       local_irq_save(flags);
>         rdp = this_cpu_ptr(&rcu_data);
>
> Thanks,
> Zqiang
