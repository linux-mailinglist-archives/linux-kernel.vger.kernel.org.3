Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25662570F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiGLBdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiGLBdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:33:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156238E1E2;
        Mon, 11 Jul 2022 18:33:14 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v21so3441845plo.0;
        Mon, 11 Jul 2022 18:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=A7qUftFMsHtAgHz7tg5ybnJxuA39QPif4EqnUQa2+ls=;
        b=ilWwUWRBr2jcKjIgdGL97r01HtkS3jZpsabezxx1tUPUQ7nwzkvbBQbHRnZjyQHG4a
         MTQaJauz2iosj/AQx2pFgDEGzCjs6RZtqEpfF4gFACV0PkzxpUgLKQV0r7SkoOS8p+M6
         dkt68QM01GF7GmRIGvuVT1L4E6RCx066fAv8uES+/UuTbIGmK31aN4iXmUm6tF5eQPB7
         5cr+316tp2G1/YM/tLLU7xm2kSvI7d4CRF8fGbsy8L1SfQhezD8s3MKooY5XZQOW0peI
         yfloIeERrassAa9MWw/8ENoGPGt/oQ0X2g97fHelcTTOEjUWFON4xU58FfyK6IAAdjiL
         f9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=A7qUftFMsHtAgHz7tg5ybnJxuA39QPif4EqnUQa2+ls=;
        b=72Nna69Q1F9i9Y+pLDgwAgiBigMG/O9ZX/rMwDjwftA5LlmWdfG4wtrmivOCHlJoYr
         hPGJdj857P0yc3GbaAf/t2+TiX3q+YK3VlslBr80PsSnZljK5Wbz7WNcFM6wpv9iFcKH
         6eYlLq9ibcsNHc1dKK2AUbhuF/wVn7BaQM4GgB+A8u6kzEJXSWCiwyAObe6kEX7vGba/
         50M5uEX9l2rxOHFQWPzJlQkwBauRFLASEYIDARSuG6xTfymauM9ufpcuBLB/KNJ9kw1c
         91CY6HM3LXh2Quy4UC5a+GDw3CCZMASgAnNPA8pQfQdCNaBhR9s7cSlCERpwadZjLPWc
         YbnQ==
X-Gm-Message-State: AJIora8xUXzFpHxD3GUhKlduPltZopHqa6QdVf5hppuZeoVesBugSOuD
        eco87cROGZGRStT/lAabfdo=
X-Google-Smtp-Source: AGRyM1vCis+SHHXbUUZKdGWzSbZvOUw5k1uVmPkRtryAVoujeVtXJWzlAcnGlKYgxE8ZNZyVCCoiVA==
X-Received: by 2002:a17:902:ea09:b0:16c:3f7a:adf7 with SMTP id s9-20020a170902ea0900b0016c3f7aadf7mr11199465plg.103.1657589593546;
        Mon, 11 Jul 2022 18:33:13 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090ab94800b001ef42b3c5besm5450818pjw.23.2022.07.11.18.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:33:12 -0700 (PDT)
Date:   Tue, 12 Jul 2022 11:33:07 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 1/4] powerpc/mobility: wait for memory transfer to
 complete
To:     benh@kernel.crashing.org, haren@linux.vnet.ibm.com,
        Laurent Dufour <ldufour@linux.ibm.com>, linux@roeck-us.net,
        mpe@ellerman.id.au, nathanl@linux.ibm.com, paulus@samba.org,
        wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
References: <20220627135347.32624-1-ldufour@linux.ibm.com>
        <20220627135347.32624-2-ldufour@linux.ibm.com>
In-Reply-To: <20220627135347.32624-2-ldufour@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1657588908.mis26ebam4.astroid@bobo.none>
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
> In pseries_migration_partition(), loop until the memory transfer is
> complete. This way the calling drmgr process will not exit earlier,
> allowing callbacks to be run only once the migration is fully completed.
>=20
> If reading the VASI state is done after the hypervisor has completed the
> migration, the HCALL is returning H_PARAMETER. We can safely assume that
> the memory transfer is achieved if this happens.
>=20
> This will also allow to manage the NMI watchdog state in the next commits=
.
>=20
> Reviewed-by: Nathan Lynch <nathanl@linux.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/mobility.c | 42 +++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/pla=
tforms/pseries/mobility.c
> index 78f3f74c7056..907a779074d6 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -427,6 +427,43 @@ static int wait_for_vasi_session_suspending(u64 hand=
le)
>  	return ret;
>  }
> =20
> +static void wait_for_vasi_session_completed(u64 handle)
> +{
> +	unsigned long state =3D 0;
> +	int ret;
> +
> +	pr_info("waiting for memory transfert to complete...\n");

                                            ^ extra t (also below)
> +
> +	/*
> +	 * Wait for transition from H_VASI_RESUMED to H_VASI_COMPLETED.
> +	 */
> +	while (true) {
> +		ret =3D poll_vasi_state(handle, &state);
> +
> +		/*
> +		 * If the memory transfer is already complete and the migration
> +		 * has been cleaned up by the hypervisor, H_PARAMETER is return,
> +		 * which is translate in EINVAL by poll_vasi_state().
> +		 */
> +		if (ret =3D=3D -EINVAL || (!ret && state =3D=3D H_VASI_COMPLETED)) {
> +			pr_info("memory transfert completed.\n");
> +			break;
> +		}
> +
> +		if (ret) {
> +			pr_err("H_VASI_STATE return error (%d)\n", ret);
> +			break;
> +		}
> +
> +		if (state !=3D H_VASI_RESUMED) {
> +			pr_err("unexpected H_VASI_STATE result %lu\n", state);
> +			break;
> +		}
> +
> +		msleep(500);

Is 500 specified anywhere? Another caller uses 1000, and the other one=20
uses some backoff interval starting at 1ms...

> +	}
> +}
> +
>  static void prod_single(unsigned int target_cpu)
>  {
>  	long hvrc;
> @@ -673,9 +710,10 @@ static int pseries_migrate_partition(u64 handle)
>  	vas_migration_handler(VAS_SUSPEND);
> =20
>  	ret =3D pseries_suspend(handle);
> -	if (ret =3D=3D 0)
> +	if (ret =3D=3D 0) {
>  		post_mobility_fixup();
> -	else
> +		wait_for_vasi_session_completed(handle);

If this wasn't required until later patches, maybe a comment about why=20
it's here? Could call it wait_for_migration() or similar too.

Looks okay though from my basic reading of PAPR.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> +	} else
>  		pseries_cancel_migration(handle, ret);
> =20
>  	vas_migration_handler(VAS_RESUME);
> --=20
> 2.36.1
>=20
>=20
