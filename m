Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E88D4C5542
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 11:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiBZKtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 05:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiBZKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 05:49:21 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F6F8BE0E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 02:48:47 -0800 (PST)
Received: from g550jk.localnet (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 37606C8605;
        Sat, 26 Feb 2022 10:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645872526; bh=9e0zUHAtpcm6p+onT65QRQtjl2auPw0iVuGvjSiv8aI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VQLDBrl3kARN6PYZKg9xYlq+rxV9ReqaEywy7CvNxzow9aF51kRIz8nJse/iJ9Y4X
         Eayrjv/87/94l1ymZBA01kPYdRWY7vHfJ6w5B7Ea58kHnVN05EDZ5TMNY2L15doIml
         IH3XDWpU03rw/C9JcIqtFLgDtI7OVrWOAwzSEhA0=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: add missing dependency to DRM_PANEL_EDP
Date:   Sat, 26 Feb 2022 11:48:45 +0100
Message-ID: <4384381.iIbC2pHGDl@g550jk>
In-Reply-To: <20220123204322.345725-1-luca@z3ntu.xyz>
References: <20220123204322.345725-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, any feedback on this patch?

On Sonntag, 23. J=E4nner 2022 21:43:23 CET Luca Weiss wrote:
> With CONFIG_DRM_PANEL_EDP=3Dy and CONFIG_DRM_KMS_HELPER=3Dm the compilati=
on
> fails:
>=20
>   drivers/gpu/drm/panel/panel-edp.c:843: undefined reference to
> `drm_panel_dp_aux_backlight'
>=20
> Add a dependency on DRM_KMS_HELPER to fix this.
>=20
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> I briefly tried "select DRM_KMS_HELPER" but that causes a circular
> dependency.
> If someone has a better idea how to solve this, feel free correct me.
>=20
>  drivers/gpu/drm/panel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 434c2861bb40..fda97837ecb3 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -102,6 +102,7 @@ config DRM_PANEL_SIMPLE
>  config DRM_PANEL_EDP
>  	tristate "support for simple Embedded DisplayPort panels"
>  	depends on OF
> +	depends on DRM_KMS_HELPER
>  	depends on BACKLIGHT_CLASS_DEVICE
>  	depends on PM
>  	select VIDEOMODE_HELPERS




