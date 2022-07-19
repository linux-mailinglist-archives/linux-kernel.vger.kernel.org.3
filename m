Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3D579555
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiGSIiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGSIiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:38:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C52922BDA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:38:21 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c30a:1501:8302:3eab:dcff:989c] (unknown [IPv6:2a00:23c6:c30a:1501:8302:3eab:dcff:989c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 830A566019EC;
        Tue, 19 Jul 2022 09:38:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
        s=mail; t=1658219899;
        bh=pT9LsgDPXQ0N4ZUhydSJXzlbrrIU5pdJxpX8OgBtKKo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZAM2U4AliGF0UNCwIZdgWYgG1mlKiLMsrfpv5iI8xik1utJb6T2n3DYMDooKyGdii
         UyWldvFNAg0/J1orEkFTg/P7M1qwUbLupaEh8xIUuZwqUsE6yrKPII8o4NhouLdsE7
         jzf2IfHDBSYRMKl5bMZ5QH1Id9d2Fph58g2WEaAp3UiqQUFYOhf12OXgWJSihkncZY
         uOxJsKudggnNoyJ5DTodeHcrFrhRb/StTMuvFMFH7T29SjMeTg6Eojk9nCbcBGCRy3
         6lp9Ib0YSu/6E8x5UGiXqm1jnze3N7mN5qhqxQbYZyP57yYcEuGeHxGNUAucthTckc
         gA1I1JhXry0kg==
Message-ID: <946c008942f4ef4ca642818b23e9941c162383e3.camel@collabora.co.uk>
Subject: Re: [PATCH] drm/bridge: megachips: Fix a null pointer dereference
 bug
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Zheyu Ma <zheyuma97@gmail.com>, peter.senna@gmail.com,
        martin.donnelly@ge.com, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Jul 2022 09:38:16 +0100
In-Reply-To: <20220716081304.2762135-1-zheyuma97@gmail.com>
References: <20220716081304.2762135-1-zheyuma97@gmail.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-16 at 16:13 +0800, Zheyu Ma wrote:
> When removing the module we will get the following warning:
>=20
> [=C2=A0=C2=A0 31.911505] i2c-core: driver [stdp2690-ge-b850v3-fw] unregis=
tered
> [=C2=A0=C2=A0 31.912484] general protection fault, probably for non-canon=
ical
> address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> [=C2=A0=C2=A0 31.913338] KASAN: null-ptr-deref in range [0x00000000000000=
08-
> 0x000000000000000f]
> [=C2=A0=C2=A0 31.915280] RIP: 0010:drm_bridge_remove+0x97/0x130
> [=C2=A0=C2=A0 31.921825] Call Trace:
> [=C2=A0=C2=A0 31.922533]=C2=A0 stdp4028_ge_b850v3_fw_remove+0x34/0x60
> [megachips_stdpxxxx_ge_b850v3_fw]
> [=C2=A0=C2=A0 31.923139]=C2=A0 i2c_device_remove+0x181/0x1f0
>=20
> The two bridges (stdp2690, stdp4028) do not probe at the same time,
> so
> the driver does not call ge_b850v3_resgiter() when probing, causing
> the
> driver to try to remove the object that has not been initialized.
>=20
> Fix this by checking whether both the bridges are probed.
>=20
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Good catch!

Acked-by: Martyn Welch <martyn.welch@collabora.com>

Would be worth adding:

Fixes: 11632d4aa2b3 ("drm/bridge: megachips: Ensure both bridges are
probed before registration")

> ---
> =C2=A0drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> index cce98bf2a4e7..c68a4cdf4625 100644
> --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> @@ -296,7 +296,9 @@ static void ge_b850v3_lvds_remove(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This check is to avoid=
 both the drivers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * removing the bridge in=
 their remove() function
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ge_b850v3_lvds_ptr)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ge_b850v3_lvds_ptr ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0!ge_b850v3_lvds_ptr->stdp2690_i2c ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0!ge_b850v3_lvds_ptr->stdp4028_i2c)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto out;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drm_bridge_remove(&ge_b85=
0v3_lvds_ptr->bridge);

