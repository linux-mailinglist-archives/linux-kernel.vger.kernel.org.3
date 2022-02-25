Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18AB4C45BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbiBYNQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiBYNQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:16:40 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8537F181E57;
        Fri, 25 Feb 2022 05:16:06 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y5so1658450wmi.0;
        Fri, 25 Feb 2022 05:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PR0fVE6nKdbpIIw7hJEF8MSW4jXjDeHQgC3lme605B8=;
        b=anJqAJyqR1JJuKkVL5flu3y/k4W+jFAWd/iGY0wrg5hQcRUWZfJAwh9AmqHSsSpFna
         mtygh6JpGd7rbFet8a3QIrcyZ/lxy6eSRMb8eHARVTPUGHuPNVEgLaajW5/iZTclku7y
         I+CKNcMURZ5WOKfTmxeAGyRWeB25TJm4OKGO2g3zx8aNR0nYAbST6fZQ72+6Zuon9GmP
         yEQVzo/PBqgXoAtTBPjO1FquPb/BvrxbKebokI5qjsn/1czkJO0luF44Pj6/0Co+Zcwc
         W2AAZL8402+Ej8udlpP4WL3uI8j4HeMuRcRrCWW/EHrUC2n8ITZxDHolNJmVDTyW6uln
         WEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PR0fVE6nKdbpIIw7hJEF8MSW4jXjDeHQgC3lme605B8=;
        b=76x7kqX21mhw3l8af2O1INu0kzSPEUT5L1p6NxWiu7Lwc4dZWy2VfpSKCrCteZS9C0
         moZt0bDIyn3tpZG2SPLOw7zaHd2RrElgZntYRzO2R2eLrWeVMkDllJlBo8YVOobm7tz7
         OzL/l2ypekT2FkmHsc1fMgl8mXaSp901QL1EBMG+6u1NdZ3FOmLnri4k05tz88ogDWlk
         MnolsUWLr/mdalPr85IjQSXcJXDLzibLK7tnNc8XUkhGm+KtOAeUXjnSM7QzRDtAOJqm
         cXEf1n4nPrafWwReLmf2boxRJ6M+KH1Ib/EwNmLUapub6Abi5TNQSALJT+ugkm2z+h3X
         Wuog==
X-Gm-Message-State: AOAM533A77VvFxle8YrpxeSDQDCNozVp6KIxW/9vBaMiHDnF6CdYk7n7
        U/CECEonc/pr44EkaRAQ3Hs=
X-Google-Smtp-Source: ABdhPJyq4qAAE2JwMqRKyRmCEqKdxr+spBqAPqTGrh1UYZFlm2gbd/sq9mwJ58JcFT9kLFmHqjb/pw==
X-Received: by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id c4-20020a7bc844000000b0037bb9867726mr2715536wml.160.1645794965095;
        Fri, 25 Feb 2022 05:16:05 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c1c0700b0037c2c6d2a91sm2337948wms.2.2022.02.25.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:16:04 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:16:01 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     sboyd@kernel.org, jonathanh@nvidia.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        mturquette@baylibre.com, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com
Subject: Re: [PATCH v2] clk: tegra: tegra124-emc: Fix missing put_device()
 call in emc_ensure_emc_driver
Message-ID: <YhjWkVnjGvTkOgnM@orome>
References: <20220112025200.95C4BC36AEB@smtp.kernel.org>
 <20220112104501.30655-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fsBpXhVaVDYjKv6h"
Content-Disposition: inline
In-Reply-To: <20220112104501.30655-1-linmq006@gmail.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fsBpXhVaVDYjKv6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 12, 2022 at 10:45:01AM +0000, Miaoqian Lin wrote:
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling path.
>=20
> Fixes: 2db04f16b589 ("clk: tegra: Add EMC clock driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> Changes in v2:
> - add fixes tag.
> ---
>  drivers/clk/tegra/clk-tegra124-emc.c | 1 +
>  1 file changed, 1 insertion(+)

Stephen, Mike,

I don't have anything else for clock tree this cycle, so perhaps best
for you guys to pick this up directly:

Acked-by: Thierry Reding <treding@nvidia.com>

--fsBpXhVaVDYjKv6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIY1pEACgkQ3SOs138+
s6F9DxAApzyiKCjUIjlfxY3qWe0+3n4QDbO17EIyirLw6UzgcmFRXkV1Qru1Vcc7
aJHjdcBYlHRX4X6/sIlxqG/QavChcvYDBW4pSNKdlAXoF9EJiifV1j/hnpW5RM3a
L5ShTie7gsvPyNW5+HqpYcmwHUoHRE2VEU/VRZAza1nAf64nygHYiOPo4u0K01NX
9qs8gWUh/4kJBkCQxruiFnnqpe9UblsGVJ85HMADVLzacamzmMVkjBKSYGvg6eSr
0YycbJkX3G1W54saPY7wfUiSGSZuUQZBrnmgWjJHJ+k7jQxIj5UvrHlBxZwglrOc
LMVCxHqiDlzuIM6daT/hHWE5FaVTmVGVsBqYIgUMK6KXwZ2YbZUh/WiJ57pnK9uE
xqR05HAkRapHy40rpr6uLz0uFmu9prvLahxl1W7PyD2ENbWym8765j5ZstxeFzw4
zY95aC/NSieGa/IU0Gdlen1t1dkhkxT23rwwI1wAlEF7WXuxGER/EMYBWtFAAiR/
SY0PE97YYEawIIfbxLQr3OzcWT+54M+KTz/aTjVk8ahIrVJ3SSXX54NNSTmIi1p4
Jiv5rQCZgejYfVnTc6IpIqXfnYJxly8B4s4pAApjw6fhNWT9fbIy0JzFYxThCW5+
pAIVe+5N1ymwR2F8NYxDqGpNhrDJixgDwRp4Zw+tK5D2bEg8kuM=
=Vhua
-----END PGP SIGNATURE-----

--fsBpXhVaVDYjKv6h--
