Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C2E52867C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244312AbiEPOHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243887AbiEPOHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:07:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CD43A728;
        Mon, 16 May 2022 07:07:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f2so13686306wrc.0;
        Mon, 16 May 2022 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sM2sRGLVCJ3Fk4PRrn+4dC0xyoX9H+fcNcN8bioAh10=;
        b=XEldJpEHMASSsGBrI5Mmn0Pi9N670GLUxxVJp9B5HOBl43K97MwoAJgO8rLsByNaeb
         lGFHZLdSMp5plsxPECl1hu/RCE92lA3mQMUkELx5ggDkbKbIrRbWl2CF5epTn2VVa9Bk
         EKleAupnQa510VCDAbAdsbYftuIScC1x7XiBfKKGJN4+Q4XS1jPWRU5vVJ/+q3ubfCcV
         CqQx3Zr2V7XIS4AOAoBetY/mlyaYWA5HTpaVMVfXp3aqrxwJLDkgz7shVZ2/UZ8uhN3P
         XQJSOuKhPUftPUtyRVyYYoaZl0WFTnNY6kIltroHODF1It8/lBZoYSRFsyKFcmYNaD1w
         gFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sM2sRGLVCJ3Fk4PRrn+4dC0xyoX9H+fcNcN8bioAh10=;
        b=e78sUnF+Z4iNBVcZOHuCis/BExhcDs2feMj/wXXIlPv0D9Yl1uOj/u1JKNh4wwo6pC
         4IShw9vpuGnPU/2I/LAA+be08DiOEAjpoygT2Cb7joxOkP8WIRtxWLhuZgVo6zQRAQhv
         3VTATRlxSGmOS/5VaXqK6FPHT9O7+oNtMjyc/2yKuEetmCZMhGHd1o1IXILks9YWMRFV
         UdHIvbvlB/jIBDIMAdL5MN25oC72mDeoA+JjrRalQytxOGagFxQTeAloOnb97j+51PvP
         jSr7whyaO8MgJy+Y04oNGRYu9HGpwkw9beeaxvUSfzGppfkdB0vxVB+eNGXnn2TBTXhX
         jV1g==
X-Gm-Message-State: AOAM530xGvzCSlfkviTjzerQX0qGfAOwpdHPBNe8HjfbaFGEnq3g632n
        BfAXCb/8+nI2YST+M8RhPQLBsDHvRXY=
X-Google-Smtp-Source: ABdhPJy6o0QTxOZPvxVZf6UA03LSbXaPI3cJ5caJlhMXQFfhV3BWO5alGfIPKD4PGJbIVes3G4Q8Uw==
X-Received: by 2002:a5d:4988:0:b0:20d:9b8:e560 with SMTP id r8-20020a5d4988000000b0020d09b8e560mr3799784wrq.33.1652710036571;
        Mon, 16 May 2022 07:07:16 -0700 (PDT)
Received: from orome (pd9e518f7.dip0.t-ipconnect.de. [217.229.24.247])
        by smtp.gmail.com with ESMTPSA id v8-20020adfa1c8000000b0020d050461c9sm5287367wrv.54.2022.05.16.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 07:07:15 -0700 (PDT)
Date:   Mon, 16 May 2022 16:07:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        jonathanh@nvidia.com, joro@8bytes.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu: Attach to host1x context device
 bus
Message-ID: <YoJakX0ms7rBF3ia@orome>
References: <20220516085258.1227691-1-cyndis@kapsi.fi>
 <20220516085258.1227691-6-cyndis@kapsi.fi>
 <20220516100721.GA1927@willie-the-truck>
 <4a170997-c893-1788-dcaa-8ed2193146ae@kapsi.fi>
 <099cf0f9-5c27-0247-7c5e-6704a9527b11@arm.com>
 <020a8244-760e-fe7c-594a-1d85e5645dbe@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pzcJQLU+ls3tyqds"
Content-Disposition: inline
In-Reply-To: <020a8244-760e-fe7c-594a-1d85e5645dbe@kapsi.fi>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pzcJQLU+ls3tyqds
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 16, 2022 at 02:20:18PM +0300, Mikko Perttunen wrote:
> On 5/16/22 13:44, Robin Murphy wrote:
> > On 2022-05-16 11:13, Mikko Perttunen wrote:
> > > On 5/16/22 13:07, Will Deacon wrote:
> > > > On Mon, May 16, 2022 at 11:52:54AM +0300, cyndis@kapsi.fi wrote:
> > > > > From: Mikko Perttunen <mperttunen@nvidia.com>
> > > > >=20
> > > > > Set itself as the IOMMU for the host1x context device bus, contai=
ning
> > > > > "dummy" devices used for Host1x context isolation.
> > > > >=20
> > > > > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > > > ---
> > > > > =C2=A0 drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++++++
> > > > > =C2=A0 1 file changed, 13 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > > b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > > index 568cce590ccc..9ff54eaecf81 100644
> > > > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> > > > > @@ -39,6 +39,7 @@
> > > > > =C2=A0 #include <linux/amba/bus.h>
> > > > > =C2=A0 #include <linux/fsl/mc.h>
> > > > > +#include <linux/host1x_context_bus.h>
> > > > > =C2=A0 #include "arm-smmu.h"
> > > > > @@ -2053,8 +2054,20 @@ static int arm_smmu_bus_init(struct
> > > > > iommu_ops *ops)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto err_reset_pci_ops;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0 #endif
> > > > > +#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
> > > > > +=C2=A0=C2=A0=C2=A0 if (!iommu_present(&host1x_context_device_bus=
_type)) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D bus_set_iommu=
(&host1x_context_device_bus_type, ops);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto err_reset_fsl_mc_ops;
> > > > > +=C2=A0=C2=A0=C2=A0 }
> > > > > +#endif
> > > > > +
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > +err_reset_fsl_mc_ops: __maybe_unused;
> > > > > +#ifdef CONFIG_FSL_MC_BUS
> > > > > +=C2=A0=C2=A0=C2=A0 bus_set_iommu(&fsl_mc_bus_type, NULL);
> > > > > +#endif
> > > >=20
> > > > bus_set_iommu() is going away:
> > > >=20
> > > > https://lore.kernel.org/r/cover.1650890638.git.robin.murphy@arm.com
> > > >=20
> > > > Will
> > >=20
> > > Thanks for the heads-up. Robin had pointed out that this work was
> > > ongoing but I hadn't seen the patches yet. I'll look into it.
> >=20
> > Although that *is* currently blocked on the mystery intel-iommu problem
> > that I can't reproduce... If this series is ready to land right now for
> > 5.19 then in principle that might be the easiest option overall.
> > Hopefully at least patch #2 could sneak in so that the compile-time
> > dependencies are ready for me to roll up host1x into the next rebase of
> > "iommu: Always register bus notifiers".
> >=20
> > Cheers,
> > Robin.
>=20
> My guess is that the series as a whole is not ready to land in the 5.19
> timeframe, but #2 could be possible.
>=20
> Thierry, any opinion?

Dave and Daniel typically want new material to be in by -rc6 and I've
already sent the PR for this cycle. I can ask them if they'd take
another one, though, if it make things simpler for the next cycle.

Thierry

--pzcJQLU+ls3tyqds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKCWpEACgkQ3SOs138+
s6HS5g/+NDlKp3MuR8qOz2HUhNTb5hZJliQREJuGJiH3Lb+xlTr9HRTYFTog5h2o
/8FYXEz/xNe0Ksteb58UEMgTzATGtPWYulLdKMfCLgHRSw9jwEG6IOtCweZv5fNf
9oAzyL/ZTpTOF330ce1BRfk/PvlNVLnetImK4b8OGmaj9ZMgvfNhgJpzq0jSkf7S
hTZozfgJ++nan7UBRnZofuYzhpbDGrTAbxhTgksppbF0nM6AykU1je/eQBZL6I05
ASNkCmDqun5PBmXYyMZChBXBhJl6Di2qKGy1kuFwrT2/K8a1WghA+J4ZiW6nGCH+
9jcbkiXYNiq6T8mwywq3zxONLKKB2gDr07doUPHr2ERBfmXtG+X6lxXq97Zq+eyV
N8RGawUV8cCELULq/U9t7k9WjNtCLNiLIhXKGj7c1QNK8PervlLaJqY2+t1HQzwt
JFWZcP2I1S3246kEhCbh+mPTKS+J5HkOgfgbVRkjcDY/lZrcK1QLmvsL95UFIt1f
pPRcBG9O2CNtjsN2rH8mOHs7dMpR6G1562YhRiRjGJubFFCg5Tmt/Mt7KyER4HGS
kosQh4xTIxzi6Cs0RIXDO/2krGcibkv3vlWJBsxNczzpoq63d7TIjXM5WaV0UKqL
UreHGegFDP9Q2xzfuJhqmaYOYg/E/VuRbZOO19Zn28tLtD/wiGY=
=fv4K
-----END PGP SIGNATURE-----

--pzcJQLU+ls3tyqds--
