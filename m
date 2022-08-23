Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9E259E61F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242178AbiHWPhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbiHWPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:37:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAB6C12E8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:27:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A17B612E6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1606C433D6;
        Tue, 23 Aug 2022 11:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661254005;
        bh=xusDJzFbQXYfZaVCTdgH+Yb1GNWkV4ady1wSxu89sMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D91VDK1iDSjUOCqmpN8YS63cSEh0/hwSKJP4ZsVm0AP4G0t9wvFmOkRvHeuGsxPog
         cFTjBqp6jAYjfWX8Hr9gh2TdtRTpiQZL6IqZQzEN3wxZpsyfVaseZaT+f+XgPGoqUu
         umkqiU+B4DvdwPaW1RNNn+wCb9UOlAARkDUGp/WvjDMPbn6q3kEuNB5yXK2iNUoiMz
         t15pz5Wql2MKbAkAj+Xt8e8V1p2sDQ2M8PdybtIcV1j4FBFdFLag02PFIlbCFWkJaD
         v4v/LtsOocMmltsB7wuBymBFqwhmvia6RokTvzeCVpIOLzBuGviTO3IaQ84a1SjagU
         M7OtU3GXdVIuQ==
Date:   Tue, 23 Aug 2022 12:26:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     catalin.marinas@arm.com, weiyongjun1@huawei.com,
        guohanjun@huawei.com, oleg@redhat.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Clearing TIF_SVE but not TIF_SME in za_set()
Message-ID: <YwS5cN7GlbdR5IQU@sirena.org.uk>
References: <20220823015627.4161141-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Grr7xBdWJnPqcDeU"
Content-Disposition: inline
In-Reply-To: <20220823015627.4161141-1-bobo.shaobowang@huawei.com>
X-Cookie: You can't take damsel here now.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Grr7xBdWJnPqcDeU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 23, 2022 at 09:56:27AM +0800, Wang ShaoBo wrote:

> Clearing target's TIF_SVE but not current's TIF_SME in za_set(), as it indicates
> target's SVE storage unavailable.

> +++ b/arch/arm64/kernel/ptrace.c
> @@ -1084,7 +1084,7 @@ static int za_set(struct task_struct *target,
>  	if (!target->thread.sve_state) {
>  		sve_alloc(target);
>  		if (!target->thread.sve_state) {
> -			clear_thread_flag(TIF_SME);
> +			clear_tsk_thread_flag(target, TIF_SVE);
>  			ret = -ENOMEM;
>  			goto out;
>  		}

We didn't set TIF_SVE so we have no reason to clear it here, we know it
can't have been set since there was no sve_state allocated.  The clear
of TIF_SME is happening on the wrong task though, and TBH is just
redudnant for similar reasons.

--Grr7xBdWJnPqcDeU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMEuW8ACgkQJNaLcl1U
h9A/nwf+PMHHOdTHrCmXoakUYx/xyO07zoxAKWSbovxyoCSP1CReutGiC9tQM1VM
zbcDMjxZoxhbyLBuEeJaIPNt0v9ZzN89iSU7RGxS7D+rEv5KoGUGAyYckbKpSYfW
ul6Zz4rWh1LBCJwtrq60jUtApmTj+pu8xNKNK8Itd9KC5xia/TRCiVd4DAGvV1j1
pojDGfI1dgPhHUhZlpslMD+Hs3v6w0uQ7jhXcqERSwMuRpxz9FSQ1YIYKYNJg4Mj
omda9PxYr5rVMNNbw+DQ1E/LjtKzL+sgl4HWBdiLk8B9maABxnAwFrokHPxLxabS
abDtlQ7ReZIHMsIuLbexgD01HAsRIw==
=Y+xl
-----END PGP SIGNATURE-----

--Grr7xBdWJnPqcDeU--
