Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAA5570FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiGLBqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiGLBqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:46:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F4A20BC7;
        Mon, 11 Jul 2022 18:46:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id z1so5982946plb.1;
        Mon, 11 Jul 2022 18:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=5WUpciY67nz9Y+WwyFmNq00Jkjc0+OHPotlv53pIbNg=;
        b=H07onmAMCuh0h3uRioN4skYiI3WXqG0mgSOsOcbeMXPOagZtwCDD7J2r99ohvufdNX
         0EyZWD2X+LnOn++zMCL5ybsHIpTrfmKLkLApRjW7yIbtTtW8JK3sfr3zZPYF8l+93Gcg
         9dxasbu6toefgvV1NjRCdUyEeAEkmCvPy/nQmVb+25+PQZuQdYvvcT7E0jR6oaARPLMI
         ZZP1F5eQKpGp3n1a8S3VV44YGPlw3k8PmZU7hrWClzhvcAtDpT3bjS0MkhRYzEmw2a+c
         cNtKtAOyE86KIh6QfSHSQyypweB9om2Vvs+S0W+47WYVHg8Y4g8A/FeVPtuVz3472JeL
         dJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=5WUpciY67nz9Y+WwyFmNq00Jkjc0+OHPotlv53pIbNg=;
        b=28GlollBelST2LWis/P2zC12JyfnpIrOFnwNuenCrmWFIMU1pRXReN+7SKqntFs46P
         1XMpKStMK83i1ZpUMMyLrkTNrVH3bsvReaFw4QvUuwGr6udaCyhbzO2FaFytD+VB+bHD
         VtjZIbJuq+mwmJXTCsC7I/t3lb3WwdIT4yB7y+txQ8d0SEHUFaKRf1/pN3Qw5DD+v032
         jTEkT1IkGjmcp5Ut6ooWuOgpcjX2OWl1z/MfvgpTt8IyoNX34bXUVP729hikJ28LPB5H
         GzG0r1gE/80rI7coP4KcedgoXzXge/XBArz62HyDz07rQE+NZ4XQ5ctkW2sUSY17tJAn
         k4/Q==
X-Gm-Message-State: AJIora+8lfUarhdTr/+wYGK+F0mOkK9wDzCyFpzEtrm+GfWgedV1u0rK
        aX3kamRXupXky4g/4bbX1rE=
X-Google-Smtp-Source: AGRyM1u2wYcmJaBc3iLp3t3fCVKjEPS+WhouJ3dul7UkswiLBWGwaGXfRwfb7gXJV+H/tHZ6FCpCeQ==
X-Received: by 2002:a17:903:1314:b0:16b:e832:7292 with SMTP id iy20-20020a170903131400b0016be8327292mr21546636plb.56.1657590399323;
        Mon, 11 Jul 2022 18:46:39 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id p123-20020a625b81000000b0052ab5740130sm5383922pfb.37.2022.07.11.18.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:46:38 -0700 (PDT)
Date:   Tue, 12 Jul 2022 11:46:33 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 4/4] pseries/mobility: set NMI watchdog factor during
 LPM
To:     benh@kernel.crashing.org, haren@linux.vnet.ibm.com,
        Laurent Dufour <ldufour@linux.ibm.com>, linux@roeck-us.net,
        mpe@ellerman.id.au, nathanl@linux.ibm.com, paulus@samba.org,
        wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
References: <20220627135347.32624-1-ldufour@linux.ibm.com>
        <20220627135347.32624-5-ldufour@linux.ibm.com>
In-Reply-To: <20220627135347.32624-5-ldufour@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1657590189.b3s2aqv3sj.astroid@bobo.none>
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
> During a LPM, while the memory transfer is in progress on the arrival sid=
e,
> some latencies is generated when accessing not yet transferred pages on t=
he
> arrival side. Thus, the NMI watchdog may be triggered too frequently, whi=
ch
> increases the risk to hit a NMI interrupt in a bad place in the kernel,
> leading to a kernel panic.
>=20
> Disabling the Hard Lockup Watchdog until the memory transfer could be a t=
oo
> strong work around, some users would want this timeout to be eventually
> triggered if the system is hanging even during LPM.
>=20
> Introduce a new sysctl variable nmi_watchdog_factor. It allows to apply
> a factor to the NMI watchdog timeout during a LPM. Just before the CPU ar=
e
> stopped for the switchover sequence, the NMI watchdog timer is set to
>  watchdog_tresh + factor%
>=20
> A value of 0 has no effect. The default value is 200, meaning that the NM=
I
> watchdog is set to 30s during LPM (based on a 10s watchdog_tresh value).
> Once the memory transfer is achieved, the factor is reset to 0.
>=20
> Setting this value to a high number is like disabling the NMI watchdog
> during a LPM.
>=20
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 12 ++++++
>  arch/powerpc/platforms/pseries/mobility.c   | 43 +++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
> index ddccd1077462..0bb0b7f27e96 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -592,6 +592,18 @@ to the guest kernel command line (see
>  Documentation/admin-guide/kernel-parameters.rst).
> =20
> =20
> +nmi_watchdog_factor (PPC only)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Factor apply to to the NMI watchdog timeout (only when ``nmi_watchdog`` =
is
> +set to 1). This factor represents the percentage added to
> +``watchdog_thresh`` when calculating the NMI watchdog timeout during a
> +LPM. The soft lockup timeout is not impacted.

Could "LPM" or "mobility" be a bit more prominent in the parameter name
and documentation? Something else might want to add a factor as well,
one day.

Otherwise the code looks okay.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +
> +A value of 0 means no change. The default value is 200 meaning the NMI
> +watchdog is set to 30s (based on ``watchdog_thresh`` equal to 10).
> +
> +
>  numa_balancing
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/pla=
tforms/pseries/mobility.c
> index 907a779074d6..649155faafc2 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -48,6 +48,39 @@ struct update_props_workarea {
>  #define MIGRATION_SCOPE	(1)
>  #define PRRN_SCOPE -2
> =20
> +#ifdef CONFIG_PPC_WATCHDOG
> +static unsigned int nmi_wd_factor =3D 200;
> +
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table nmi_wd_factor_ctl_table[] =3D {
> +	{
> +		.procname	=3D "nmi_watchdog_factor",
> +		.data		=3D &nmi_wd_factor,
> +		.maxlen		=3D sizeof(int),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_douintvec_minmax,
> +	},
> +	{}
> +};
> +static struct ctl_table nmi_wd_factor_sysctl_root[] =3D {
> +	{
> +		.procname       =3D "kernel",
> +		.mode           =3D 0555,
> +		.child          =3D nmi_wd_factor_ctl_table,
> +	},
> +	{}
> +};
> +
> +static int __init register_nmi_wd_factor_sysctl(void)
> +{
> +	register_sysctl_table(nmi_wd_factor_sysctl_root);
> +
> +	return 0;
> +}
> +device_initcall(register_nmi_wd_factor_sysctl);
> +#endif /* CONFIG_SYSCTL */
> +#endif /* CONFIG_PPC_WATCHDOG */
> +
>  static int mobility_rtas_call(int token, char *buf, s32 scope)
>  {
>  	int rc;
> @@ -702,13 +735,20 @@ static int pseries_suspend(u64 handle)
>  static int pseries_migrate_partition(u64 handle)
>  {
>  	int ret;
> +	unsigned int factor =3D 0;
> =20
> +#ifdef CONFIG_PPC_WATCHDOG
> +	factor =3D nmi_wd_factor;
> +#endif
>  	ret =3D wait_for_vasi_session_suspending(handle);
>  	if (ret)
>  		return ret;
> =20
>  	vas_migration_handler(VAS_SUSPEND);
> =20
> +	if (factor)
> +		watchdog_nmi_set_lpm_factor(factor);
> +
>  	ret =3D pseries_suspend(handle);
>  	if (ret =3D=3D 0) {
>  		post_mobility_fixup();
> @@ -716,6 +756,9 @@ static int pseries_migrate_partition(u64 handle)
>  	} else
>  		pseries_cancel_migration(handle, ret);
> =20
> +	if (factor)
> +		watchdog_nmi_set_lpm_factor(0);
> +
>  	vas_migration_handler(VAS_RESUME);
> =20
>  	return ret;
> --=20
> 2.36.1
>=20
>=20
