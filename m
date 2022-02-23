Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2584C140E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbiBWNXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbiBWNXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:23:10 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39DDAB44B;
        Wed, 23 Feb 2022 05:22:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i20so3363661wmc.3;
        Wed, 23 Feb 2022 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vGb2ARjYKMt2Kvks9J2lDsUiX/tTNuHKRpCYsHVcRkI=;
        b=kNKKfuaa00aoAnTcnnO+KZaAksC+0IILYIogAnyAAhwNrakLcAe5J7O0QAwR0RDN/1
         Ze4OTeX6LbZ0Mpnq4ZeshG4K375CfLfFlr94dBoO5I+NX57CJ+PBkIWxoqfOOLCqvPnb
         OqjkLE7Z3EwN4+TfHKj0tFwX/njk68Vbf54LslksMqjZDyofemE9KCUoT1qYQwih0hka
         AVX+s7VJu6boMSoACspKaowjsJBZGTgEelCzkyXzLfZASWl70Img0zGWZZPF7EqkRLwd
         w/Qe8lxpSAENYseOIGLVH1UTpggc0nnfA/VWoqHPCw2PGTOex2OaIHOMp47ad7zZOeNk
         gnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vGb2ARjYKMt2Kvks9J2lDsUiX/tTNuHKRpCYsHVcRkI=;
        b=TXU6w9LasioNuUPzldTvyXTLeCARAhAByRBvLASVBNn2ZoVEmb22MtAlrvMErNC+WM
         uTy9FLmOQ35H3sjDcu7VkL7uEvEy6PoE29Y0cyt6/4bzBIApffm5RZK0FHjntvxTL67N
         FScEyeO7hc4C2AxGQuVCrGCb2MwTlZ9D60t0bxxB3UZotPW/SSe5lYHC07Dq2StIUYpP
         +PZ8E8Zbck6Wi6uTogydWBO+P2V3KoRAHU2G2gNGMVPCD7nvpUNSVpN9Ue9Go+UNy7Wz
         5yZOcDBJFkLIIxznCmjoWyFce38BC9OXUBa7haMwa2MQ/MWokGsO+gOb2JHMS9+PGt71
         AyFw==
X-Gm-Message-State: AOAM531PHxQ+5eVSQM2KeZ/8X3V2AUFxG1uhrw21YDUMa3GYLPRttM+y
        Kc9PkT7HW8Z6NF8IPfGOP5QVypySKl8=
X-Google-Smtp-Source: ABdhPJxBb9fVmzJnugIzRqLWFDZChGUnTqVK+AjpBU9JMUTg1LRe8IlxoBZPAE0QkkWoUccti5ECHQ==
X-Received: by 2002:a05:600c:3d06:b0:37b:f831:2a98 with SMTP id bh6-20020a05600c3d0600b0037bf8312a98mr7411709wmb.36.1645622560974;
        Wed, 23 Feb 2022 05:22:40 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id c14-20020a7bc84e000000b0038100c9a593sm153072wml.45.2022.02.23.05.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:22:39 -0800 (PST)
Date:   Wed, 23 Feb 2022 14:22:38 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Sumit Gupta <sumitg@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        kbuild-all@lists.01.org, bbasu@nvidia.com, vsethi@nvidia.com,
        jsequeira@nvidia.com, Thierry Reding <treding@nvidia.com>
Subject: Re: [Patch v3 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194
 axi2apb binding
Message-ID: <YhY1Hhgz/O724oYL@orome>
References: <20211221125117.6545-1-sumitg@nvidia.com>
 <20211221125117.6545-4-sumitg@nvidia.com>
 <YcNv7xm19sFTlfjW@robh.at.kernel.org>
 <226fd57c-2631-ec7a-fc48-d6547d557681@nvidia.com>
 <CAL_Jsq+=hGG-cMwvM0sKFW=Rwa56=fqS379jL4ZjSyDKOia-RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ek0gW7MJ0WaqCJOs"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+=hGG-cMwvM0sKFW=Rwa56=fqS379jL4ZjSyDKOia-RA@mail.gmail.com>
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


--ek0gW7MJ0WaqCJOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 11:41:10AM -0400, Rob Herring wrote:
> On Thu, Dec 23, 2021 at 4:24 AM Sumit Gupta <sumitg@nvidia.com> wrote:
> > > On Tue, Dec 21, 2021 at 06:21:11PM +0530, Sumit Gupta wrote:
> > >> Add device-tree binding documentation to represent the axi2apb bridg=
es
> > >> used by Control Backbone (CBB) 1.0 in Tegra194 SOC. All errors for A=
PB
> > >> slaves are reported as slave error because APB bas single bit to rep=
ort
> > >> error. So, CBB driver needs to further check error status registers =
of
> > >> all the axi2apb bridges to find error type.
> > >>
> > >> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > >> Signed-off-by: Thierry Reding <treding@nvidia.com>
> > >> ---
> > >>   .../arm/tegra/nvidia,tegra194-axi2apb.yaml    | 40 +++++++++++++++=
++++
> > >>   1 file changed, 40 insertions(+)
> > >>   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvi=
dia,tegra194-axi2apb.yaml
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegr=
a194-axi2apb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegr=
a194-axi2apb.yaml
> > >> new file mode 100644
> > >> index 000000000000..788a13f8aa93
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-ax=
i2apb.yaml
> > >> @@ -0,0 +1,40 @@
> > >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >> +%YAML 1.2
> > >> +---
> > >> +$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-axi2a=
pb.yaml#"
> > >> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > >> +
> > >> +title: NVIDIA Tegra194 AXI2APB bridge
> > >> +
> > >> +maintainers:
> > >> +  - Sumit Gupta <sumitg@nvidia.com>
> > >> +
> > >> +properties:
> > >> +  $nodename:
> > >> +    pattern: "^axi2apb@([0-9a-f]+)$"
> > >> +
> > >> +  compatible:
> > >> +    enum:
> > >> +      - nvidia,tegra194-axi2apb
> > >> +
> > >> +  reg:
> > >> +    maxItems: 6
> > >> +    description: Physical base address and length of registers for =
all bridges
> > >> +
> > >> +additionalProperties: false
> > >> +
> > >> +required:
> > >> +  - compatible
> > >> +  - reg
> > >> +
> > >> +examples:
> > >> +  - |
> > >> +    axi2apb: axi2apb@2390000 {
> > >
> > > As axi2apb appears to be a bus, then all the child nodes (APB devices)
> > > should be under this node.
> >
> > axi2apb is a bridge which coverts an AXI to APB interface and not a bus.
>=20
> A bus and bridge node are pretty much one and the same in DT
> representation. A PCI host bridge has a PCI bus beneath it for
> example.

Sorry for taking so long to reply, this fell through the cracks.

These aren't really bridges as such. CBB (which we call /bus@0 in DT) is
a sort of large container for all IP. Within that there are various shim
layers that connect these "legacy" interfaces to CBB. I suppose you
could call them bridges, but it's a bit of a stretch. From a software
point of view there is no observable translation happening. The only
reason why we need this is for improved error reporting.

The TRM also doesn't make a distinction between the various bridges. The
devices are all just mapped into a single address space via the CBB.

My understanding is that this is also gone in newer chips, so matters
become a bit simpler there.

Reorganizing /bus@0 into multiple bridges and busses would be a lot of
churn and likely confuse people that want to correlate what's in the TRM
to what's in DT, so I don't think it's worth it.

For newer chips we may want to keep this in mind so we structure the DT
more accurately from the beginning, though as I said, things have been
simplified a bit, so this may not be an issue anymore.

Thierry

--ek0gW7MJ0WaqCJOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIWNRsACgkQ3SOs138+
s6FZOQ/+LbbpJ1EmeqjNCY26tK+hEL1Y8oOHW2uV65Aq9zQu/JVNRCaPVfasdvD9
9blDOZNeaBBp0Ri0NJbjKyInvBKS3W2/G9RBR2HxUQkibabTvfNuovoS3gNorw4/
EygTUAuWX6p2lAKu+mAN0JW4rnkQRrrnqbTXQiGa1nnfsBorzIil+MXY8MBb8mxV
AN1tIdITQli7dByU2OA3g431h1yBB+CFc5q1kXhgVxrd24s/bqmHHofHvOCbiTX8
8oXV2pEwUq+4IfCEZRl8J2LgV0jLqSTUYNheWfMaKhH5iS63XSzTTE1IjsV903y5
8UJpLvj7x8h3pj4WTOOv7skc8AoWL0F7vsFXccJDtvTvGbUrL+pBn/6zxfgicV3n
W2Qty4P+dL+RzukHXV6pMyXeZnSvAvrqkVrSwoaWddaaeIcQ3nQE08vQxLD5jWnD
+KTn4/wWEefqqoh9x/gvWiJqcCyKejWgSlqIL2FXVSHVcQ/d7ZeL99NHnDb/H/iE
osQl6tNezgI/FVTPkwTMgdJ6Qh9vy5yt8GyOEPe3H2tRb48hCgRF0VWwWfD8njun
Noe9m9m8DPYpQ+4sAQtiWZTQgLozMzD5y4Rx0O5Hdo71TfVE9B2u5vqN5pbplLKp
BkTOo8JyU415bhThgCa4K0F5XexhW1wjsamb78hccEWuP2+eWBg=
=IRCr
-----END PGP SIGNATURE-----

--ek0gW7MJ0WaqCJOs--
