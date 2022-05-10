Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0699521367
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbiEJLU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiEJLUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:20:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F579187D84
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:16:28 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t13so14368600pgn.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=itXK+rSLc1QihSjSoLaf7Q70y9HboDnIPkUMbBBhjnc=;
        b=P3c5o4HPneI+4Z47/3z0XyAHSGtCqvR/q0W4Nq/bwgtUcYH0Uy0Jd0jWxYk3ghvprP
         M0MmtF9mSteO6SObGM+KeBSRL/Th4Qu4mVxig0ifQZanH/5wImDWSHEoJhwowNlgQztq
         +fdho63/Z8O8Z+lPnO6hj/iRJm5XvhSDG1+J1izpbMQslnk4JvepsnrwPHrDGzxgn5TR
         vcaqxwR/GfEGirCr+I2kPVsku19Q8PppQZVPQfxI8KglDGZCMvJ1WONiiaZUQFmDypie
         o8tTi9z3MKBG9nHO9duRSWery/b9fOyTFXWIIbFoAAf1r0nJxinLTdMxGhUiFTNW8gL+
         06eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=itXK+rSLc1QihSjSoLaf7Q70y9HboDnIPkUMbBBhjnc=;
        b=LVo31ge9PAqimJOLJlyRFiIbB1nszFVJZTHt+pJYjjE9xGq7RhyB42iuD1ILlNecSI
         GrTLirahPvw1Vym3k813AY81OmvR6Dju9pJbMO2InAmM9+IvFeSUYVLaG9eIwTTRFqAu
         dby2rbYnDMwILYBf4z9t3dOGjYSKlw2kB/tgD/buONGHu7wuqvP0m01c/+iUyp5iPnPy
         kC9Af17zdN2RYm+joxsmuJnS5bv+cUFYh4i3i+SXbAlMbWAcacIUnoeNfUoqwXXYu9v1
         PXgLG2tgPD6zdSofGmMQRtTSD74CSd4S+sQ37fH92mLVyvU0vj0EWhDLGSCYpn8CQa3U
         VhLg==
X-Gm-Message-State: AOAM530b5BLlcn+Ge3R3suSYE3hM4kkUeW+cbMmlEeqyCDhd84uOdpay
        w3sslYpfjGHrSXWYJlOxhWw=
X-Google-Smtp-Source: ABdhPJzVsABH4Oig0yRdlWGkgOiTbMOjWkvb+1zdab8hPOxvRkmGZAkmCY+fGQiGE352GRJimRZReg==
X-Received: by 2002:a05:6a00:21c2:b0:4fe:81f:46c7 with SMTP id t2-20020a056a0021c200b004fe081f46c7mr19960372pfj.5.1652181387580;
        Tue, 10 May 2022 04:16:27 -0700 (PDT)
Received: from localhost (193-116-127-232.tpgi.com.au. [193.116.127.232])
        by smtp.gmail.com with ESMTPSA id z29-20020aa79f9d000000b0050dc7628170sm10462375pfr.74.2022.05.10.04.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 04:16:26 -0700 (PDT)
Date:   Tue, 10 May 2022 21:16:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 28/29] x86/tsc: Restart NMI watchdog after refining
 tsc_khz
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
        <20220506000008.30892-29-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20220506000008.30892-29-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-Id: <1652180070.1r874kr0tg.astroid@bobo.none>
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
> The HPET hardlockup detector relies on tsc_khz to estimate the value of
> that the TSC will have when its HPET channel fires. A refined tsc_khz
> helps to estimate better the expected TSC value.
>=20
> Using the early value of tsc_khz may lead to a large error in the expecte=
d
> TSC value. Restarting the NMI watchdog detector has the effect of kicking
> its HPET channel and make use of the refined tsc_khz.
>=20
> When the HPET hardlockup is not in use, restarting the NMI watchdog is
> a noop.
>=20
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v5:
>  * Introduced this patch
>=20
> Changes since v4
>  * N/A
>=20
> Changes since v3
>  * N/A
>=20
> Changes since v2:
>  * N/A
>=20
> Changes since v1:
>  * N/A
> ---
>  arch/x86/kernel/tsc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index cafacb2e58cc..cc1843044d88 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1386,6 +1386,12 @@ static void tsc_refine_calibration_work(struct wor=
k_struct *work)
>  	/* Inform the TSC deadline clockevent devices about the recalibration *=
/
>  	lapic_update_tsc_freq();
> =20
> +	/*
> +	 * If in use, the HPET hardlockup detector relies on tsc_khz.
> +	 * Reconfigure it to make use of the refined tsc_khz.
> +	 */
> +	lockup_detector_reconfigure();

I don't know if the API is conceptually good.

You change something that the lockup detector is currently using,=20
*while* the detector is running asynchronously, and then reconfigure
it. What happens in the window? If this code is only used for small
adjustments maybe it does not really matter but in principle it's
a bad API to export.

lockup_detector_reconfigure as an internal API is okay because it
reconfigures things while the watchdog is stopped [actually that
looks untrue for soft dog which uses watchdog_thresh in
is_softlockup(), but that should be fixed].

You're the arch so you're allowed to stop the watchdog and configure
it, e.g., hardlockup_detector_perf_stop() is called in arch/.

So you want to disable HPET watchdog if it was enabled, then update
wherever you're using tsc_khz, then re-enable.

Thanks,
Nick
