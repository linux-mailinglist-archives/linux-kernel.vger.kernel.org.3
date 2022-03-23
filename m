Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED244E5327
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244298AbiCWNdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbiCWNdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:33:37 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C15475C2C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:32:07 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id v13so1010386qkv.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nPGspUnXDfSSjkwMaGFzPZOYPt1+G1sJy9ZdXHVCp+8=;
        b=Cr6TDAC63Uli7HQZ9nYheNpDiEzDDtVl9wd6iUyAqKes9XcIcVheNz/MbiPidhndJm
         d22sDoKrdyJxG/hbX8XM9lGTKhYvbyQmi4AdUQWymBaGa7MsCImsgrXTvT+hPw/6iULK
         kxomLZlBnF6wb3dQT7O7jtEj7/fdfwnCo7kpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nPGspUnXDfSSjkwMaGFzPZOYPt1+G1sJy9ZdXHVCp+8=;
        b=HdIWBuiCYDRhvkErtXX6dkUoMEFEykCS4vFFhUapGBcU48yvgv898j8wVGaeTFPH8m
         ZLRSor0U4FlJcIAw2SrnrEq26UHbry+psRGOBzEwRwnR9B5eqVX2eSo5ihetuxUSEAv5
         cfPEU2MosuFtdScRs9s4GDnfkpOM4dg7UGRJ42dF+X/PQ3S1kVAkNraBK1NCARpyAzHg
         SE4plr/1/uj1ht63f7piyDDNzDnge+YnbqIxqQLkxNl2TS19o9QkfPr01sFM6kbq1zkY
         iljRGI6Mff2URLdlcUSHCgKRzgfclH0VPdbA/f7jMxCSAZlWI/af11A4aFIK0PdZMY3G
         faAg==
X-Gm-Message-State: AOAM530nVnWmSEavGkv+KCyEes19pWKlLnt74QkuSQgoNJozJvDjNS5W
        wgwjsgXhmiCgY67Kjk6bScrhR5Y1SyNjqEcC
X-Google-Smtp-Source: ABdhPJzoo4UXmqA2kFsY4AxIOGuvgy0FfwekMuH1JcPG1w1Ujia1jCE5tPW3sGPBb6+u7rvXG496XA==
X-Received: by 2002:a05:620a:108f:b0:67b:465f:56ba with SMTP id g15-20020a05620a108f00b0067b465f56bamr18542419qkk.297.1648042326089;
        Wed, 23 Mar 2022 06:32:06 -0700 (PDT)
Received: from bill-the-cat (2603-6081-7b01-cbda-2ef0-5dff-fedb-a8ba.res6.spectrum.com. [2603:6081:7b01:cbda:2ef0:5dff:fedb:a8ba])
        by smtp.gmail.com with ESMTPSA id o13-20020ac87c4d000000b002e1e732dea5sm23955qtv.70.2022.03.23.06.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 06:32:05 -0700 (PDT)
Date:   Wed, 23 Mar 2022 09:32:03 -0400
From:   Tom Rini <trini@konsulko.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Sean Anderson <seanga2@gmail.com>, devicetree@vger.kernel.org,
        u-boot@lists.denx.de, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3] dt-bindings: nvmem: add U-Boot environment variables
 binding
Message-ID: <20220323133203.GD2226424@bill-the-cat>
References: <20220228131250.16943-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dicp5grlxus9uUnk"
Content-Disposition: inline
In-Reply-To: <20220228131250.16943-1-zajec5@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dicp5grlxus9uUnk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 28, 2022 at 02:12:50PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> U-Boot uses environment variables for storing device setup data. It
> usually needs to be accessed by a bootloader, kernel and often
> user-space.
>=20
> This binding allows describing environment data located in a raw flash
> partition. It's treated as NVMEM device and can be reused later for
> other storage devices.
>=20
> Using DT should be cleaner than hardcoding & duplicating such info in
> multiple places. Bootloader & kernel can share DTS and user-space can
> try reading it too or just have correct data exposed by a kernel.
>=20
> A custom "compatible" string allows system to automatically load
> relevant NVMEM driver but phandle can be also used for reading raw
> location.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--dicp5grlxus9uUnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmI7IVIACgkQFHw5/5Y0
tyzRfQwAt3O0IvBGs764YvWeHo1sL/8xI1tMnKQnfo+cZmVJBI60nE+Ghmu0Y3Rn
Me445fR/Ill/NBVMdUnp2bhPUWUI/puej7VqfB1t5mm3xCaeD2BRl+BVwIue73FX
vNf9Sk3tIBNrh8mDihG5XMNMq8UWkms+FDk/zjv2I7pfJ//Wpgo3nDlX5Wyle1hp
YDK3JlsgMI3wYMJQZ5g7+EknBgtTPndJ0DyjO2gCuZEOh688Tf3eXmC21+0aW/o/
2ErUXJmux8BxvRZqHH2bpH00sY/377FSlGowlI09GlR8VYvGFIfWIX0NFE4gauKG
wSavW952MP1pYMulvQIDBtg2aQNnigugCUM7Xm1xVHlvZQATqqdtIgusvEozkuKk
VSGnyWhYPANUINk7FORtIctrGkmNWe8JOeBtjMsLtmYJiRiCwvrYkNxfPGUuWYK2
10CnEzryX9Flx8ez8Sg/ywniMD77fwub90QQv9fqaKta/EqKSt08wruLoAtp/c12
mgGwY0fX
=rCXN
-----END PGP SIGNATURE-----

--dicp5grlxus9uUnk--
