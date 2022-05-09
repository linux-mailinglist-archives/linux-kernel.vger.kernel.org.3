Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBFA52018B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbiEIPwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbiEIPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:52:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92FA2D76C5;
        Mon,  9 May 2022 08:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B4E3B8172F;
        Mon,  9 May 2022 15:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BF9C385B1;
        Mon,  9 May 2022 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652111300;
        bh=0o6i/khs9xGoGHyAd0bai2xuSS3ZhiI169q7SJoXynE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cbu2djXI9wVzfcyzyXWhowzZSI35BvSYN9w6wCzFM8roanq/3vKuNROqDkVIBTAGu
         eXP6CqSGs5FmDULU/Q0p4wVTAcXr5wlO+E1lFH7mqpNyRL2mVNzWp9TZI/8nfcqlAq
         3/Stty+uMXoX+YqU8Yb4SPD8xFh/MY8VGaP+EWkN9x94aVDC6rz56H0sF74vmZ+YIj
         H1JFQofijaLpQXKFRlhAB6F9H6h62jgTuwmobir0V23+NOnijTbwdMD0L4CUqcu80P
         zL2uO/iqgFZn0O2I+pwBdnNrs9NhKPdRMcHaJrnjhIOj9fU/kAmvIvDKz2wHkDEWjS
         28vSzOlWkhe2w==
Date:   Mon, 9 May 2022 16:48:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, german.gomez@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 1/6] perf: arm64: Add SVE vector granule register to
 user regs
Message-ID: <Ynk3vTtJApO13peb@sirena.org.uk>
References: <20220509144257.1623063-1-james.clark@arm.com>
 <20220509144257.1623063-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kWHxwAIOcGn9XJL6"
Content-Disposition: inline
In-Reply-To: <20220509144257.1623063-2-james.clark@arm.com>
X-Cookie: Boycott meat -- suck your thumb.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kWHxwAIOcGn9XJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2022 at 03:42:49PM +0100, James Clark wrote:
> Dwarf based unwinding in a function that pushes SVE registers onto
> the stack requires the unwinder to know the length of the SVE register
> to calculate the stack offsets correctly. This was added to the Arm
> specific Dwarf spec as the VG pseudo register[1].
>=20
> Add the vector length at position 46 if it's requested by userspace and
> SVE is supported. If it's not supported then fail to open the event.
>=20
> The vector length must be on each sample because it can be changed
> at runtime via a prctl or ptrace call. Also by adding it as a register
> rather than a separate attribute, minimal changes will be required in an
> unwinder that already indexes into the register list.

> +static u64 perf_ext_regs_value(int idx)
> +{
> +	switch (idx) {
> +	case PERF_REG_ARM64_VG:
> +		if (WARN_ON_ONCE(!system_supports_sve()))
> +			return 0;

These WARN_ON_ONCE()s seem a bit loud but I do see they are idiomatic
for this code so

Reviewed-by: Mark Brown <broonie@kernel.org>

--kWHxwAIOcGn9XJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ5N70ACgkQJNaLcl1U
h9ARVQf9G0mw/2Bx5k3Bh/9t98gHB+qEtoXMXhzgkJjMUiXzj3E9uwkUmvKNR58B
PkM4MMWPCy3pQAP/Pc0zgLSKyOM30z54SdCucVVRP+ma8+y4+cBUnxvp5462F8x7
mKMbLjp3E1D1vl+4y/nqCOEKctytWfJEMUvMPd36n3Hwt4fg/7gzv14wCaJzZMrk
TZJe/W8LsNFr/pQMpPA5yKgonJKP8QCC97028L1BUq8tNWNMSWp1rtStgwDm6f7d
ZeuCqrHHljaqY9/3QuuX5LBXMr3b3WyrzVdguH1xSDChvnKQHHUpneY0oNUvDFCh
O7zct9SC04onTfuDNr1orFH6uAliQg==
=TX9r
-----END PGP SIGNATURE-----

--kWHxwAIOcGn9XJL6--
