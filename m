Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67064D0D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbiCHBfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiCHBfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:35:45 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015742DD4C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:34:50 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id 127so7362336vsd.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 17:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70vcTxDy0/rKnYaWS7HhnpmsoYEPlz/ZI+BRplv7m3Q=;
        b=rBRlLilFZl5w+zZ7fJXA7EWyxWU2m9F69aZDzWqtQAZUTBtRgIoaRmCQUvSWF2yBEz
         PhG/N3gC81KZgqB/LV3viGW97zf6m8t3MKCQL+UurOfJDpLiRjXTemLtvdllFy6OlOfD
         2S7D4YTkePMUMkEOr/Ja0cNAU4tJy7NgIlBYPuCELje+hJDHVuQs2Pb/nRIMUn7kxxsX
         e+SuwbOJqtgJLh21FNCOaiaNV/b5KF7EKkZ3c4ucHpNvGfd6i3E9lfxz+rkrnjRTRx1V
         2gq0haiaTQKukxAR7FnbW4KYMTw+VWwloDXIkRsF039lFqwryVxCOpOqcjuoWnIpLj7a
         BB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70vcTxDy0/rKnYaWS7HhnpmsoYEPlz/ZI+BRplv7m3Q=;
        b=FOa5SLeixmjarrCp5Rfht98S0nrtG+hQ5EgK5mEnj7aojQcKSC8gGctvYJLOZhhasr
         8krgAE+/BNu6/zMOtZ0/1ZxMrqp1KBiE5z5fSNOcGlQUUNP0loDUrT2GbG4Cpi6yTx5H
         IjvpMFUNbyPLVagMG+YKa7mGK7cpSPCmAg8Jyv3biAYGFzH/Xf2UYnLrQovtPjNqCUV9
         sDePKO+Kg0NXRsoNeHQlZKAxK/G3NUqln0WAzhYuhKglRwEyB8RO/oUuUtlBCuEjsWow
         UqVMiaz47UZDyZvA0BiVUn+Dk5slyf8sLzHyzEFnfXByqQ8GN/Xh3siF1ekyhTRZq/N9
         Yo7g==
X-Gm-Message-State: AOAM531m8pT8DA34sdtjxAu68U6XFvA5XGfORk8+1PGTmZgKb0r2CYJe
        XbWVWUQ2mIex6TDAmLAdVBEqITqPL6yKy8NgL4YRsw==
X-Google-Smtp-Source: ABdhPJyPpWBVTzFkk9Fypv5G31W0/jWQ9elwnMs+hezt4tZzh+4UXVoT2KytL6C64vxUJOg7kHXpUUXkaYE87lgbstg=
X-Received: by 2002:a05:6102:d8a:b0:320:777a:131b with SMTP id
 d10-20020a0561020d8a00b00320777a131bmr6094916vst.46.1646703288745; Mon, 07
 Mar 2022 17:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20220307190625.254426-1-maz@kernel.org>
In-Reply-To: <20220307190625.254426-1-maz@kernel.org>
From:   David Decotigny <ddecotig@google.com>
Date:   Mon, 7 Mar 2022 17:34:12 -0800
Message-ID: <CAG88wWYDWmSTSN6+td8aQ9SA9rCVwyZ8WUpikaSsD5SymdmUCg@mail.gmail.com>
Subject: Re: [PATCH] genirq/msi: Shutdown managed interrupts with unsatifiable affinities
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 11:06 AM Marc Zyngier <maz@kernel.org> wrote:
>
> When booting with maxcpus=<small number>, interrupt controllers
> such as the GICv3 ITS may not be able to satisfy the affinity of
> some managed interrupts, as some of the HW resources are simply
> not available.
>
> In order to deal with this, do not try to activate such interrupt
> if there is no online CPU capable of handling it. Instead, place
> it in shutdown state. Once a capable CPU shows up, it will be
> activated.
>
> Reported-by: John Garry <john.garry@huawei.com>
> Reported-by: David Decotigny <ddecotig@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  kernel/irq/msi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 2bdfce5edafd..aa84ce84c2ec 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -818,6 +818,18 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
>                 irqd_clr_can_reserve(irqd);
>                 if (vflags & VIRQ_NOMASK_QUIRK)
>                         irqd_set_msi_nomask_quirk(irqd);
> +
> +               /*
> +                * If the interrupt is managed but no CPU is available
> +                * to service it, shut it down until better times.
> +                */
> +               if ((vflags & VIRQ_ACTIVATE) &&
> +                   irqd_affinity_is_managed(irqd) &&
> +                   !cpumask_intersects(irq_data_get_affinity_mask(irqd),
> +                                       cpu_online_mask)) {
> +                           irqd_set_managed_shutdown(irqd);
> +                           return 0;
> +                   }
>         }
>
>         if (!(vflags & VIRQ_ACTIVATE))
> --
> 2.30.2
>

Thanks! I tried that patch, and it worked for us.
