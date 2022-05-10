Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B27C5214F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbiEJMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbiEJMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:18:05 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A99B5047E
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:14:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n18so16575305plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=4P2EaKGEH+jdcOlX4AfyzB/ukf7xEI4yNHJh/y1RIOk=;
        b=hXbDIpkhGyRok8d2v7bgOpLFS9XYvJYr9I+ID5KHWzxG4BbiZAjIAmNEK87ukmll7n
         7UJKz4lUEfAPthNA9yFFoSyJ1Ai2Z7WmqbDxRs6BvDlJ2HoZfwx/j5SCPo2XuN3NMWIH
         O4+MhBLI/8T0QAi2W8izPKsLZVnwyZYihJ3flz3DahvBjPR+vsZWxi9oXsCEJZoNsRmQ
         hJv3g7QSJpEWU89iflrnveCx/2PXNU7m8MKYR+vjbEkxSivEWUVmLq5CrpE5W62pXTu8
         360wskvzONw3pNMAfBoTnwIN1C9gv8QiAXJs5pw4BI8J2YNaxXpS4++DZ/osnV6pJYSi
         zmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=4P2EaKGEH+jdcOlX4AfyzB/ukf7xEI4yNHJh/y1RIOk=;
        b=7vfsszm/xdYAcAk/LBBYB8AarJ6TjlWRfqkp/yVIikMW9TFUzNKvkjXDvGKaI6YY02
         ZiHp6Vtk7g1ifcJOl4BPkJhKpo4NjxfDDQwR4ue87cmOi0vlbbZpSToob5E4V+Ayg9SO
         3xuUXqGVQwnCt1PD1l32WKUfGnOBLSP/vXqZuA31YNf4AGsW32pxHS/1jiIOhHiBFwQh
         YZID14ssKbL6F1r5IU0TkqcgGpB0T6ppwW3QTCB5rxLP9b1+6/NAr6dFIFnBltOHTkbS
         v77ci0pSuCFuGFWhFtLSlQSbYNvDLC+G20PX7AkymW2LVBvf/i8E+xb+CCjPPfOyiqdh
         bEBA==
X-Gm-Message-State: AOAM532hVM9YHpf3wk4d11pu8J2Rt96JOkhmsfd30Ki2vAk41rKfk7hD
        JzUARtHJ7GFi6wpnaTt6mKA=
X-Google-Smtp-Source: ABdhPJzJAToQf1bsuvOx1j/eutoC/7K7S0JvO2rKDs7VCIhTV7yNnNXkOt3ghkj3E+FkIR2Go2yu5A==
X-Received: by 2002:a17:90b:3b4c:b0:1dc:7edf:c92f with SMTP id ot12-20020a17090b3b4c00b001dc7edfc92fmr22394368pjb.91.1652184846778;
        Tue, 10 May 2022 05:14:06 -0700 (PDT)
Received: from localhost (193-116-127-232.tpgi.com.au. [193.116.127.232])
        by smtp.gmail.com with ESMTPSA id q4-20020a056a00150400b0050dc76281a1sm10909855pfu.123.2022.05.10.05.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 05:14:05 -0700 (PDT)
Date:   Tue, 10 May 2022 22:14:00 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 29/29] x86/tsc: Switch to perf-based hardlockup
 detector if TSC become unstable
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Tony Luck <tony.luck@intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
        <20220506000008.30892-30-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20220506000008.30892-30-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-Id: <1652184158.yhzceh3nwk.astroid@bobo.none>
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

Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
> The HPET-based hardlockup detector relies on the TSC to determine if an
> observed NMI interrupt was originated by HPET timer. Hence, this detector
> can no longer be used with an unstable TSC.
>=20
> In such case, permanently stop the HPET-based hardlockup detector and
> start the perf-based detector.
>=20
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v5:
>  * Relocated the delcaration of hardlockup_detector_switch_to_perf() to
>    x86/nmi.h It does not depend on HPET.
>  * Removed function stub. The shim hardlockup detector is always for x86.
>=20
> Changes since v4:
>  * Added a stub version of hardlockup_detector_switch_to_perf() for
>    !CONFIG_HPET_TIMER. (lkp)
>  * Reconfigure the whole lockup detector instead of unconditionally
>    starting the perf-based hardlockup detector.
>=20
> Changes since v3:
>  * None
>=20
> Changes since v2:
>  * Introduced this patch.
>=20
> Changes since v1:
>  * N/A
> ---
>  arch/x86/include/asm/nmi.h     | 6 ++++++
>  arch/x86/kernel/tsc.c          | 2 ++
>  arch/x86/kernel/watchdog_hld.c | 6 ++++++
>  3 files changed, 14 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
> index 4a0d5b562c91..47752ff67d8b 100644
> --- a/arch/x86/include/asm/nmi.h
> +++ b/arch/x86/include/asm/nmi.h
> @@ -63,4 +63,10 @@ void stop_nmi(void);
>  void restart_nmi(void);
>  void local_touch_nmi(void);
> =20
> +#ifdef CONFIG_X86_HARDLOCKUP_DETECTOR
> +void hardlockup_detector_switch_to_perf(void);
> +#else
> +static inline void hardlockup_detector_switch_to_perf(void) { }
> +#endif
> +
>  #endif /* _ASM_X86_NMI_H */
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index cc1843044d88..74772ffc79d1 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1176,6 +1176,8 @@ void mark_tsc_unstable(char *reason)
> =20
>  	clocksource_mark_unstable(&clocksource_tsc_early);
>  	clocksource_mark_unstable(&clocksource_tsc);
> +
> +	hardlockup_detector_switch_to_perf();
>  }
> =20
>  EXPORT_SYMBOL_GPL(mark_tsc_unstable);
> diff --git a/arch/x86/kernel/watchdog_hld.c b/arch/x86/kernel/watchdog_hl=
d.c
> index ef11f0af4ef5..7940977c6312 100644
> --- a/arch/x86/kernel/watchdog_hld.c
> +++ b/arch/x86/kernel/watchdog_hld.c
> @@ -83,3 +83,9 @@ void watchdog_nmi_start(void)
>  	if (detector_type =3D=3D X86_HARDLOCKUP_DETECTOR_HPET)
>  		hardlockup_detector_hpet_start();
>  }
> +
> +void hardlockup_detector_switch_to_perf(void)
> +{
> +	detector_type =3D X86_HARDLOCKUP_DETECTOR_PERF;

Another possible problem along the same lines here,
isn't your watchdog still running at this point? And
it uses detector_type in the switch.

> +	lockup_detector_reconfigure();

Actually the detector_type switch is used in some
functions called by lockup_detector_reconfigure()
e.g., watchdog_nmi_stop, so this seems buggy even
without concurrent watchdog.

Is this switching a good idea in general? The admin
has asked for non-standard option because they want
more PMU counterss available and now it eats a
counter potentially causing a problem rather than
detecting one.

I would rather just disable with a warning if it were
up to me. If you *really* wanted to be fancy then
allow admin to re-enable via proc maybe.

Thanks,
Nick

