Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3DA5749F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiGNKCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiGNKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:01:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF99050040;
        Thu, 14 Jul 2022 03:01:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sz17so2464592ejc.9;
        Thu, 14 Jul 2022 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnb6dmJVJ8w+0s7YTlnQHUZqrxFXtH+uKxV3IXY9L40=;
        b=BBvvyLCcMtbUvehMM2snxdWnz/o57eYWts/1kZVSRIHaFo8g/gbOmGiq9dzzXSEEY0
         6k4yuafUZ2DfJIEW7EXBBiY3yx2jCIGEhmOmjKP22SZ2e7TgfdMAJQzTzlknpq7BJRQS
         t0Au1FhwOBHM91G0Z5KDYb4F2wkMK+fgnJ3LWNwr3DFNSpSj5lwo7K6OcDA/AydjV3WY
         TcPh8k6afACQV76dCekexaxcFLiJWupnOa88OtAJSPDck8XhHjtEs7aFXNcAex8PuneQ
         Y56Aaf/JVTGK+EuNVOJRRp0XHITuunFgYTU/qdIqOwhC5n6+5k0aZvAG5x03pLaYXI76
         Arpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnb6dmJVJ8w+0s7YTlnQHUZqrxFXtH+uKxV3IXY9L40=;
        b=rcA457bD/FrEtLcD+hmNWfHGC1hlmeUNn8j4q2mWD7QpfzdmILTCjcrqbJmNv0W0gt
         HMWfAGkmvXDiVgNTNkvmOaAidi4rH9bC8k9xkC1TdgsXS0IH/XdDlYpeSTtVKkb/SXZB
         SBapDPjmIez/cMA71P79KMp1JGFyc8mgm06GMmdtkjbGzeFSUsqcchLg18NL5fM6cnRa
         X/qdM1/Y4UlNWXi0QFdUORYhc5FVyc3upfoqBsLoNoYmqqj+Ai3H5eK/Hz7HXBk+0kKz
         gnzbycWKVuO0So3o3uT3GM7vRr5wjMmi9fLMue9Pc4gGMhW1q1fKX0t0scR6od6tUSaG
         uLwg==
X-Gm-Message-State: AJIora87U2g0Ak8Cy9knbWr5W80wyUFWWwTpSAkgPCa4VjXVw6SRz2Km
        bIhxQ9Q5OFewgjdIeM/IWHIppPjw+zk6PbWW03s=
X-Google-Smtp-Source: AGRyM1sCQn8e+iDOsrWhFzdhSNCJDhCc4UgyWLSakUOGtksbk5r0HgvpK3Fsmib9vFWsJBhOgZej6MmBSRRPHyBcaPw=
X-Received: by 2002:a17:907:971a:b0:72b:6bab:abc2 with SMTP id
 jg26-20020a170907971a00b0072b6bababc2mr8046604ejc.551.1657792912428; Thu, 14
 Jul 2022 03:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220714013131.12648-1-zhouzhouyi@gmail.com> <87tu7k6o7n.fsf@jogness.linutronix.de>
In-Reply-To: <87tu7k6o7n.fsf@jogness.linutronix.de>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 14 Jul 2022 18:01:41 +0800
Message-ID: <CAABZP2x-OiwX7-nRvdPz0NU1D5kgUoL4MQOgTqLK1KgLcrZ5DA@mail.gmail.com>
Subject: Re: [PATCH linux-next] powerpc: use raw_smp_processor_id in arch_touch_nmi_watchdog
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, Nicholas Piggin <npiggin@gmail.com>,
        ldufour@linux.ibm.com, pmladek@suse.com, Julia.Lawall@inria.fr,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
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

Thank John for correcting me ;-)

On Thu, Jul 14, 2022 at 5:25 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2022-07-14, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > use raw_smp_processor_id() in arch_touch_nmi_watchdog
> > because when called from watchdog, the cpu is preemptible.
>
> I would expect the correct solution is to make it a non-migration
> section. Something like the below (untested) patch.
I applied your patch (I have made a tiny modification by removing the
return statement after "goto out;") and
passed the test in the ppc VM of Open Source Lab of Oregon State University.

Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Many Thanks
Kindly Regards
Zhouyi
>
> John Ogness
>
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index bfc27496fe7e..9d34aa809241 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -450,17 +450,23 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>  void arch_touch_nmi_watchdog(void)
>  {
>         unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
> -       int cpu = smp_processor_id();
> +       int cpu;
>         u64 tb;
>
> -       if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
> +       cpu = get_cpu();
> +
> +       if (!cpumask_test_cpu(cpu, &watchdog_cpumask)) {
> +               goto out;
>                 return;
I think we should remove the return statement here.
> +       }
>
>         tb = get_tb();
>         if (tb - per_cpu(wd_timer_tb, cpu) >= ticks) {
>                 per_cpu(wd_timer_tb, cpu) = tb;
>                 wd_smp_clear_cpu_pending(cpu);
>         }
> +out:
> +       put_cpu();
>  }
>  EXPORT_SYMBOL(arch_touch_nmi_watchdog);
