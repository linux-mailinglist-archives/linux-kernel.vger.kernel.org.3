Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B924FB056
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 23:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbiDJVTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiDJVTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 17:19:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D47424AE;
        Sun, 10 Apr 2022 14:17:29 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z16so12931688pfh.3;
        Sun, 10 Apr 2022 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amVR16GyPmaXgXRfnOWV2/JFp0ofkaxxky40KG8lyB0=;
        b=QeMlkDEgxQjiSluao5CAZXhXOZu1x48Vh34v656xUcO5PPTcLwwZsEPlXyFu6P+3nj
         hP7Wk8lubU6e1bD2nMvev7HdLtnb4u/QpbTJVEbHbbkrMnIOdfUjheg/rliZkJQYZgep
         Q9SE3Sd251ehrXWBlCt0pp+BNR4dPIWmaZ/MTyQzH7E7gwT/f7JBagwoVu3j22z7OiHC
         YUu5aWv/Tf2DEXiZ9iv7NdpUva668OlMl8EpuUagiIUDDS+sPngKpnhNE8o1sJ4kwfBv
         io+/QC1JVlJ5mXTKI3iGdv4HEUinJJtWnxUoLj/Twe12gS1kw2ozIeTqwrX1+8Y8Ljsx
         R55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amVR16GyPmaXgXRfnOWV2/JFp0ofkaxxky40KG8lyB0=;
        b=m8O1SHzA7Od0aP0kg8AORRVaZ4O6pYS0mOc8WV9DR5uoZA0syTg4LClvPTLt00h0ow
         JnFrCdgl36ckr7CXTAYBPl/AWjlRlSqxMEIR0GhcNLR7a5MYAtjLJII44UccPOBXvswY
         mqVq6qYR93jJuAwgntVNZk0X3QtisEamXjnUb6qZwxJF5aGbE37aN2f6PH4VOL+9tmZA
         jFRGIjCzagZNuVTkTVYshwbmpBJKAvKDDGTFaPX7hAyJM8sIAmOSrfiKJ8f7bzeUZK67
         90Bm4iaJ+UMG7fezOYOfMrUbQE3dT0s4YrrLxCdXgffz5EpVKEMpAz9SbdSkHdTD/0Ct
         WtJA==
X-Gm-Message-State: AOAM532/iCTMlzqt8Hn8gVIYQW/ljYGGfertbLCLe1uJt4HKKXh0ilHD
        dDDT/9AOjNjP5fJ3/h0UMCr7Ak+CcAqFmQOYHbU=
X-Google-Smtp-Source: ABdhPJxNNRfj9YmDq1W26AK8eKZva0BjvIFLZ2HXbF10bTccLvZ+vTCpK6t+a6Wxi1K+TqgcHmYxHihYWheGfzm2hgw=
X-Received: by 2002:a63:7c06:0:b0:398:31d5:f759 with SMTP id
 x6-20020a637c06000000b0039831d5f759mr24028460pgc.513.1649625449274; Sun, 10
 Apr 2022 14:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220210224933.379149-22-yury.norov@gmail.com>
 <164962245994.4207.10090580398155704963.tip-bot2@tip-bot2> <573841649622719@mail.yandex.com>
In-Reply-To: <573841649622719@mail.yandex.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Sun, 10 Apr 2022 14:17:18 -0700
Message-ID: <CAAH8bW-=baSvb6pY+9t=5Fn6DA56G3eTJP0uBeXDZsVuDkHr9g@mail.gmail.com>
Subject: Re: [tip: irq/core] genirq/affinity: Replace cpumask_weight() with
 cpumask_empty() where appropriate
To:     Ozgur <ozgur@linux.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 1:35 PM Ozgur <ozgur@linux.com> wrote:
>
>
>
> 10.04.2022, 23:27, "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>:
>
> The following commit has been merged into the irq/core branch of tip:
>
> Commit-ID: 911488de0565f1d53bd36174d20917ebc4b44c0e
> Gitweb: https://git.kernel.org/tip/911488de0565f1d53bd36174d20917ebc4b44c0e
> Author: Yury Norov <yury.norov@gmail.com>
> AuthorDate: Thu, 10 Feb 2022 14:49:05 -08:00
> Committer: Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Sun, 10 Apr 2022 22:20:28 +02:00
>
> genirq/affinity: Replace cpumask_weight() with cpumask_empty() where appropriate
>
> __irq_build_affinity_masks() calls cpumask_weight() to check if any bit of
> a given cpumask is set.
>
> This can be done more efficiently with cpumask_empty() because
> cpumask_empty() stops traversing the cpumask as soon as it finds first set
> bit, while cpumask_weight() counts all bits unconditionally.
>
> Hello,
> in this patch, struct cpumask *nmsk will also be affected because is called ncpus = cpumask_weight(nmsk);
> right?

Sorry, I don't understand that. The line that you mentioned can't
modify nmsk neither before
nor after this patch. Can you clarify your concern in greater details?

Thanks,
Yury

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20220210224933.379149-22-yury.norov@gmail.com
>
> ---
>  kernel/irq/affinity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index f7ff891..18740fa 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -258,7 +258,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>          nodemask_t nodemsk = NODE_MASK_NONE;
>          struct node_vectors *node_vectors;
>
> - if (!cpumask_weight(cpu_mask))
> + if (cpumask_empty(cpu_mask))
>                  return 0;
>
>          nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
>
>
> Ozgur
