Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5761E570FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiGLBnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiGLBnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:43:00 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1135B31239;
        Mon, 11 Jul 2022 18:42:59 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 23so6262588pgc.8;
        Mon, 11 Jul 2022 18:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=efBjI108FNDgrH81mWfuEW+8lOWoiTSn59YlZxopuqo=;
        b=S0/JcCbhklzJm37yA+X+xY4YciQKLZDOx18f5yXiSPq1kMGboCRhiToigj+Mvrzunm
         mAfbLqPfOwBakJYmDJ83kMjo+cCxQUiU+0PZ/Vs6jRfHrJ2ll5aRu/NlNkENnE3Bp7oC
         1uD+lvUh0kdlbOwL8/5BhB9OVRl7qkcdvIn2cnIl0VBzqnNHqX88QjvhrWM0M+jJYwbP
         UiCvG60QWRRi50X46Oi1OrAK6lkfeoH6k0C1wRelddCBbXKUpzn1dNRPEi2jYqxwOC9P
         eMAqB8tZzwVqMnqT8yc/kP9cBV5zVdQAWgDQqtzMFTZQtbiNkd9Zl6rl3dfxC9D/ysmi
         Y5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=efBjI108FNDgrH81mWfuEW+8lOWoiTSn59YlZxopuqo=;
        b=GV/QcLb3caEV2IOnAt56Xkz2A5rV7x+Cs2w/OkE0bGNMqKXOOJ2xlSpyVfAOwKS4Dd
         Qpl9ZYYLw4gm/2Qjr+VarDJl+QTewdj5RqxUi0guN833w+0bNLKN/qOX2FeDTOWrr3UH
         y6bELoT/FKqoQoADwzna1pATCnrrWB9IGh3tuFavjXyd/K3EFDRzFJLgcq7z/qBGE5hV
         cnW1aeids1pHXH8fPFcU9hnv5f90+bwSBNk6C5b+4jArSmEJUbpYhp4WRSkL7May8iNq
         4igYLF+6iFNbKdX1gEJz+V8yr5VDIcXZz6COIOZgXsLAHUvyykOevUavSzlaZMBRkp9L
         giHg==
X-Gm-Message-State: AJIora/kaN9Jl2xv/iQRglWywrH08JiZvOsAPofMAnsaBgMmuLXIQIbd
        +0Ny1QJRpEJ/J7qKlkk/TQk=
X-Google-Smtp-Source: AGRyM1uIyDCldsts9kc/4nx1k4tXS/V3m+V4ip+typVuJlP8eqpmkGQF2/k95hww38sxRvIAXxI0xg==
X-Received: by 2002:a05:6a00:1818:b0:52a:dabd:a232 with SMTP id y24-20020a056a00181800b0052adabda232mr4646574pfa.70.1657590178596;
        Mon, 11 Jul 2022 18:42:58 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902f64c00b0016bf9437766sm5346915plg.261.2022.07.11.18.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:42:57 -0700 (PDT)
Date:   Tue, 12 Jul 2022 11:42:52 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 3/4] powerpc/watchdog: introduce a NMI watchdog's
 factor
To:     benh@kernel.crashing.org, haren@linux.vnet.ibm.com,
        Laurent Dufour <ldufour@linux.ibm.com>, linux@roeck-us.net,
        mpe@ellerman.id.au, nathanl@linux.ibm.com, paulus@samba.org,
        wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
References: <20220627135347.32624-1-ldufour@linux.ibm.com>
        <20220627135347.32624-4-ldufour@linux.ibm.com>
In-Reply-To: <20220627135347.32624-4-ldufour@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1657589870.vvurapsif3.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Laurent Dufour's message of June 27, 2022 11:53 pm:
> Introduce a factor which would apply to the NMI watchdog timeout.
>=20
> This factor is a percentage added to the watchdog_tresh value. The value =
is
> set under the watchdog_mutex protection and lockup_detector_reconfigure()
> is called to recompute wd_panic_timeout_tb.
>=20
> Once the factor is set, it remains until it is set back to 0, which means
> no impact.

Looks okay. We could worry about making it more generic or nicer if
another user came along.

Could you make the naming a bit more self documenting?=20
watchdog_nmi_set_timeout_pct(), maybe? Does the wd really care
that it is for LPM in particular?

Variables and parameters could have a _pct suffix too.

Otherwise

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/nmi.h |  2 ++
>  arch/powerpc/kernel/watchdog.c | 21 ++++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nm=
i.h
> index ea0e487f87b1..7d6a8d9b0543 100644
> --- a/arch/powerpc/include/asm/nmi.h
> +++ b/arch/powerpc/include/asm/nmi.h
> @@ -5,8 +5,10 @@
>  #ifdef CONFIG_PPC_WATCHDOG
>  extern void arch_touch_nmi_watchdog(void);
>  long soft_nmi_interrupt(struct pt_regs *regs);
> +void watchdog_nmi_set_lpm_factor(u64 factor);
>  #else
>  static inline void arch_touch_nmi_watchdog(void) {}
> +static inline void watchdog_nmi_set_lpm_factor(u64 factor) {}
>  #endif
> =20
>  #ifdef CONFIG_NMI_IPI
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdo=
g.c
> index 7d28b9553654..80851b228f71 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -91,6 +91,10 @@ static cpumask_t wd_smp_cpus_pending;
>  static cpumask_t wd_smp_cpus_stuck;
>  static u64 wd_smp_last_reset_tb;
> =20
> +#ifdef CONFIG_PPC_PSERIES
> +static u64 wd_factor;
> +#endif
> +
>  /*
>   * Try to take the exclusive watchdog action / NMI IPI / printing lock.
>   * wd_smp_lock must be held. If this fails, we should return and wait
> @@ -527,7 +531,13 @@ static int stop_watchdog_on_cpu(unsigned int cpu)
> =20
>  static void watchdog_calc_timeouts(void)
>  {
> -	wd_panic_timeout_tb =3D watchdog_thresh * ppc_tb_freq;
> +	u64 threshold =3D watchdog_thresh;
> +
> +#ifdef CONFIG_PPC_PSERIES
> +	threshold +=3D (READ_ONCE(wd_factor) * threshold) / 100;
> +#endif
> +
> +	wd_panic_timeout_tb =3D threshold * ppc_tb_freq;
> =20
>  	/* Have the SMP detector trigger a bit later */
>  	wd_smp_panic_timeout_tb =3D wd_panic_timeout_tb * 3 / 2;
> @@ -570,3 +580,12 @@ int __init watchdog_nmi_probe(void)
>  	}
>  	return 0;
>  }
> +
> +#ifdef CONFIG_PPC_PSERIES
> +void watchdog_nmi_set_lpm_factor(u64 factor)
> +{
> +	pr_info("Set the NMI watchdog factor to %llu%%\n", factor);
> +	WRITE_ONCE(wd_factor, factor);
> +	lockup_detector_reconfigure();
> +}
> +#endif
> --=20
> 2.36.1
>=20
>=20
