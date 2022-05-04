Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FEB51A20C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351233AbiEDOUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351159AbiEDOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:20:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938D919281
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 07:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FFDEB825A4
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5928DC385A5;
        Wed,  4 May 2022 14:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651673825;
        bh=bILCd1sxeIvbA+5tD85VdyDhv+PjR1QceeyC4i77F7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PLaT0ROECinBJfleAOFsjO8U4x0scBFNpxF4+15z0Su2w/B7oQ2INoyEjMXkuYAx3
         T6aZVqJIMp3545+ISNDEKzwef3R0jQu2UIQ+SFoR2onOzlfgD+XwyuFB+mq5lnX1Zd
         QCnAuTM3BrtCryngmeJs8xrx8xnq+2qre5Ng9L8uFNExQKjA+VYesn4luSRw6BBOE/
         dJCm9vXCVDiFq4yxNIhYWsot7K+7+/3ZqfZSlW66Gu8GfLrH5F/CTf9d50xAfc5N4h
         ISyZ5JMtDV2R7x1gI2gs5eNItXAGhDGGNkvxXRu9NZfFwWA39X+eNQarV01lyJKmR5
         VBoZ6TItaJNTw==
Date:   Wed, 4 May 2022 15:16:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, will@kernel.org, maz@kernel.org,
        qperret@google.com, tabba@google.com, surenb@google.com,
        kernel-team@android.com, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] KVM: arm64: Compile stacktrace.nvhe.o
Message-ID: <YnKK2IxdbVvcsOC2@sirena.org.uk>
References: <20220502191222.4192768-1-kaleshsingh@google.com>
 <20220502191222.4192768-3-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Hx6xiGRCvg0C4uF"
Content-Disposition: inline
In-Reply-To: <20220502191222.4192768-3-kaleshsingh@google.com>
X-Cookie: Mother is the invention of necessity.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Hx6xiGRCvg0C4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 02, 2022 at 12:12:02PM -0700, Kalesh Singh wrote:

> Recompile stack unwinding code for use with the nVHE hypervisor. This is
> a preparatory patch that will allow reusing most of the kernel unwinding
> logic in the nVHE hypervisor.

>  enum stack_type {
> -	STACK_TYPE_UNKNOWN,
> +#ifndef __KVM_NVHE_HYPERVISOR__
>  	STACK_TYPE_TASK,
>  	STACK_TYPE_IRQ,
>  	STACK_TYPE_OVERFLOW,
>  	STACK_TYPE_SDEI_NORMAL,
>  	STACK_TYPE_SDEI_CRITICAL,
> +#endif /* !__KVM_NVHE_HYPERVISOR__ */
> +	STACK_TYPE_UNKNOWN,
>  	__NR_STACK_TYPES
>  };

I don't immediately see a problem with it but I'm curious as to why
STACK_TYPE_UNKNOWN got moved to the end of the list here?  It does mean
that zeroed memory will default to STACK_TYPE_TASK but we're not
actually relying on that.  Otherwise

Reviwed-by: Mark Brown <broonie@kernel.org>

--/Hx6xiGRCvg0C4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJyitgACgkQJNaLcl1U
h9B05gf9He8i0lJSgnAoCwOnWz42y8l46CHTUSZJK53nFwnevW7nvl0Xdf1Rajhv
b1dBcynlwm2uAAHoeGen9HfX4sL0uj5e+mrg9IzoKq6GbqZfv9J2LNrCnI479gAU
GURaSasiSq3bEyxogf1eMsH2G4Kkams6LtgdSI7fr/P1JHIU+KItROmRh2zNC2jS
obAW/wC6HUJfsz1moQrO9/W1VLT8DeqBuYmTOIDZsiyJ3IKQhkZeQb2ztDU/TWeO
AUvI14Z1BWGgEisgaJx06/Y9x6nlayfkC1kEc2kMcOVPjWqqAoeHEWsL1ZmfLs9U
wlE20k5QYG+a2rgiqCSjVBtRSExj6Q==
=JjBs
-----END PGP SIGNATURE-----

--/Hx6xiGRCvg0C4uF--
