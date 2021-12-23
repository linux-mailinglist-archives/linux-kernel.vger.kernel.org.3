Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008B247E432
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348658AbhLWNmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:42:42 -0500
Received: from mail-4018.proton.ch ([185.70.40.18]:36748 "EHLO
        mail-4018.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348679AbhLWNmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:42:35 -0500
Date:   Thu, 23 Dec 2021 13:42:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1640266953;
        bh=KcpuETzMNMdxDT2q0V4AwCRe4eDh3KXENxpCUjqyk4Q=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=P1Q1DQglL3/H+NbZPwD5FQ5BU9Uxk6pxEJUlWRgkAN0OLEHRoQXT9P6vmQVgI4Shq
         qswBkVMsLvmRRHD/3SjdYOuBD/GGsV6atIzIAPtvsIcihzg+XQOhNKJ4S5zw4d90GD
         yw00fU5YY0aXBm/7z9QW1y6keFUYtpbhm6KU5cycwBKvr1TY5EinTkhSnF0bxps/kb
         vJWQQ7wnICVOxl/imolN69xOrpDSgPFAomrww24G1XS9mkDEk/KWt9aiTZ7c6IFz9B
         aSiRxt4r6e7O5KrjN0k2a+YJ9Dp9EVAP0/Mu3FzFpyLIEkg43paDmTiPHdA5LXgzCF
         ZLdjYyzNmAUHg==
To:     =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        airlied@linux.ie, alexandre.torgue@foss.st.com,
        benjamin.gaignard@linaro.org,
        linux-stm32@st-md-mailman.stormreply.com, marex@denx.de,
        linux-imx@nxp.com, intel-gfx@lists.freedesktop.org,
        tzimmermann@suse.de, s.hauer@pengutronix.de,
        rodrigo.vivi@intel.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, yannick.fertre@foss.st.com,
        linux-kernel@vger.kernel.org, philippe.cornu@foss.st.com,
        mcoquelin.stm32@gmail.com, dmitry.baryshkov@linaro.org,
        shawnguo@kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: =?utf-8?Q?Re:_[PATCH_v2_1/6]_drm/plane:_Make_format=5Fmod=5Fsupported_truly=C2=A0optional?=
Message-ID: <PIq2EEI7giz2rOuv2cfySbdxwht8AaCye140X5C7NejjXT6kD67E3E28uvg4Ebhob12EJUBtAxGPFNOgZwSWLYEfMtdhRNt3mR8bBGBJmU4=@emersion.fr>
In-Reply-To: <YcRkB7uWyt4EbcZm@intel.com>
References: <20211222090552.25972-1-jose.exposito89@gmail.com> <20211222090552.25972-2-jose.exposito89@gmail.com> <YcRkB7uWyt4EbcZm@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, December 23rd, 2021 at 12:56, Ville Syrj=C3=A4l=C3=A4 <ville.s=
yrjala@linux.intel.com> wrote:

> > -=09/* If we can't determine support, just bail */
> > -=09if (!plane->funcs->format_mod_supported)
> > -=09=09goto done;
> > -
> >  =09mod =3D modifiers_ptr(blob_data);
> >  =09for (i =3D 0; i < plane->modifier_count; i++) {
> >  =09=09for (j =3D 0; j < plane->format_count; j++) {
> > -=09=09=09if (plane->funcs->format_mod_supported(plane,
> > +=09=09=09if (!plane->funcs->format_mod_supported ||
> > +=09=09=09    plane->funcs->format_mod_supported(plane,
> >  =09=09=09=09=09=09=09       plane->format_types[j],
> >  =09=09=09=09=09=09=09       plane->modifiers[i])) {
>
> So instead of skipping the whole loop you just skip doing anything
> inside the loop? Can't see how that achieves anything at all.

No, the check is skipped when the function isn't populated by the driver.
