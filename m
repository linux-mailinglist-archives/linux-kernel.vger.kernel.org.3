Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155F350BDBA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352109AbiDVRAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345433AbiDVRAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:00:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399EA5FF2B;
        Fri, 22 Apr 2022 09:57:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t25so15314769lfg.7;
        Fri, 22 Apr 2022 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bPH7VaBfkFbtZZotNuuTdskPihD6+M4P5/MTINbvQUc=;
        b=Pe+UOZBQErS+Z8nmGZrZH2ly5AmAXR/nub2maR1YBDg2mW5cI8XFN7kRpzR9zJR1g/
         RCcytxziQK15Y/+UhDwpzPO/z8urhmQ15jD9UMpIVuXdvYk4ZA9FMtQi/zELESwjYQ6k
         oawpnRmK4g3hu3fT3s6md4XsDn4X61bzFwlVcJy4oKKXIIa+Wf5SbsrYbGooZQtu9T6w
         mMrQaS3i1Iz83k0/NJ+NcahILWGnEI8wU5g8Ena+3kmorM7mSBcU3mLHYmzUGfSY57bG
         E+QiOx9uS0cC7R96ZHgDOYCEZyLap5NE8EK+uYgY9glo5SCpnjSPQ7hN8GC1SPl/HsYy
         6IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bPH7VaBfkFbtZZotNuuTdskPihD6+M4P5/MTINbvQUc=;
        b=XEiKvmg7xsYSXSZYVx/nLyolc7T/6RvikXHAvkNkh+jvOxdHOfpGJ0SkCTpejBuWuu
         7cVV/dJx9ir3mL7fzph2FOZFcSsmdzYfqq66PcOvZUnSPe4g7zlp/b6WPBB7bwcOizQt
         zy+RBChim9fHOwMIVFrO63EpsNmwtJL1tSPAGPCOiXaX+vSXKKhsurWYmIJYgOgF6sxd
         HwZGI1SDFG/FStu42hZnLcapg1U3MgKzqry1M8evemEydgOfEPE1WHQzk738wFjlDRKV
         j+4Qnd/ZjaM9fYy0bf6KapptCywlA3wTAFVqZXwgFMmJP33Bk9HAp3QjgL3pGCSLBAwv
         u2wg==
X-Gm-Message-State: AOAM532c6sb/kFQjdzrACwzo+q7gjzd4MMKryO5RL+6mJjBl1l1yUIdz
        cNe5zK93yEllcseydASIz8k=
X-Google-Smtp-Source: ABdhPJzdFQvGzdSLbrSe+adt+pVkjulM8+IbVohfTKqNcWpqfyrWUedIVpFG1a8BPbVbvzAdinxkHQ==
X-Received: by 2002:a05:6512:2213:b0:471:c296:b659 with SMTP id h19-20020a056512221300b00471c296b659mr3848330lfu.24.1650646630354;
        Fri, 22 Apr 2022 09:57:10 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id r9-20020a2e8e29000000b0024da2131ed9sm269715ljk.100.2022.04.22.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:57:07 -0700 (PDT)
Date:   Fri, 22 Apr 2022 18:57:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, xinlei.lee@mediatek.com,
        lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rex-bc.chen@mediatek.com,
        jitao.shi@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6, 5/5] dt-bindings: pwm: Add interrupts property for
 MediaTek MT8192
Message-ID: <YmLeYOOCNciqhykt@orome>
References: <1650284456-16407-1-git-send-email-xinlei.lee@mediatek.com>
 <1650284456-16407-6-git-send-email-xinlei.lee@mediatek.com>
 <a92d3b46-ace4-2d19-fef9-c59cd1a596ce@collabora.com>
 <20220421134808.sqnecvysuzlgdsz5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xn43fwg7L9AIf1Ta"
Content-Disposition: inline
In-Reply-To: <20220421134808.sqnecvysuzlgdsz5@pengutronix.de>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xn43fwg7L9AIf1Ta
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2022 at 03:48:08PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Thu, Apr 21, 2022 at 12:17:00PM +0200, AngeloGioacchino Del Regno wrot=
e:
> > Il 18/04/22 14:20, xinlei.lee@mediatek.com ha scritto:
> > > From: Xinlei Lee <xinlei.lee@mediatek.com>
> > >=20
> > > Add interrupts property of pwm for MediaTek MT8192 SoC.
> > >=20
> > > Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> >=20
> > Hello Xinlei,
> > the pwm-mtk-disp.c driver does not support interrupts.
> >=20
> > Please add interrupts support to the driver first, and only then
> > add that in the dt-bindings.
>=20
> in my understanding the linux driver state and the binding documentation
> are somewhat independent. Here I'd say adding the irq information to dt
> without the driver supporting it is fine.

Agreed. I've applied this along with the rest. It doesn't have Rob's or
Krzysztof's stamp of approval, but it's a trivial change and looks fine
to me.

Thierry

--Xn43fwg7L9AIf1Ta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJi3mAACgkQ3SOs138+
s6GaAw//VlLPxZ1xhdfymBfdZxhQ5KeACuZ6k/asJF7IV7j+qF8lPEGixgDeaLZF
g139oHKqts/KjwLRBEerRUOKC1om/nZNbnF5phGdFXBhNCHPbgPEDXwDh64O6gNN
VYiOS3e+9/UWgo18fkjE0vAtlf5BOytzKE3dxheacU29YENfK5mfajrP5OqsMmgs
SXvoMWRuq2ni51pPlj1sNIoeK3FBwvM8D4yFHV8Ns/jpDRmIXqBafYUc0qu3l5yQ
fX0ojlbaDppJ8YFyRPn7PDY36hA8siLvW9WCJ4GB0sAZeG1ZlA2zvMSFxNLz+OIE
Xg76o+1+zMuWsHCCvay7Q+ylNlyyVCS4Kp33Ho8BMIHS2WLm1L0wUvaUGAHH4f4h
I6TcMGxu++kh6g1LXFAZ8HCwUG8J+HdJiYgfKEH8DQuqzYfWl54GA1Gi65+zpCfA
EoMbL4Ja/pb3QjlgtzoGWoGF9qMUigUy5DlICAJJs+JsI84YGj2UNCFS3uXCHOsC
/Mh5APkBEz0hI8eF7jWhdpjsD1Fsl04aaHjGn0iIIKw8fHE1XoJXN85aU5jdKS77
bvuAn7dcSlpasoPaUgIBnje0T7SGp3YKzaJs+PiRE5rxHitjMRLa0umLL/tKMhUE
vJCoUPamD5R+OoQIeG8sXKQYV/+As6q8kGd21nwJI4AIJ8QhaIM=
=c+hp
-----END PGP SIGNATURE-----

--Xn43fwg7L9AIf1Ta--
