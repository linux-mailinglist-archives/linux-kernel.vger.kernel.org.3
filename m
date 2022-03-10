Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D664D4C75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243167AbiCJO4c convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Mar 2022 09:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347939AbiCJOvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:51:35 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19C819C35;
        Thu, 10 Mar 2022 06:50:32 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nSK7V-0004bE-W9; Thu, 10 Mar 2022 15:50:26 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, knaerzche@gmail.com
Subject: Re: [PATCH] drm/rockchip: remove redundant assignment to pointer connector
Date:   Thu, 10 Mar 2022 15:50:25 +0100
Message-ID: <4453075.DPozGzHrQt@diego>
In-Reply-To: <CAKwvOdkXNGRJkZDd7Cg8jhL9Ex7R+VPYqEEc+VpwDyi9NJKXQQ@mail.gmail.com>
References: <20220307181704.149076-1-colin.i.king@gmail.com> <CAKwvOdkXNGRJkZDd7Cg8jhL9Ex7R+VPYqEEc+VpwDyi9NJKXQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

looks like I wasn't in the original recipient list, so only got Nick's
answer.

Am Mittwoch, 9. März 2022, 00:10:31 CET schrieb Nick Desaulniers:
> On Mon, Mar 7, 2022 at 10:17 AM Colin Ian King <colin.i.king@gmail.com> wrote:
> >
> > The pointer connector is being assigned a value that is never read,
> > it is being re-assigned in the following statement. The assignment
> > is redundant and can be removed.
> >
> > Cleans up clang scan build warning:
> > drivers/gpu/drm/rockchip/rockchip_rgb.c:153:2: warning: Value stored
> > to 'connector' is never read [deadcode.DeadStores]
> 
> + Author & reviewer of:
> Fixes: 2e87bf389e13 ("drm/rockchip: add DRM_BRIDGE_ATTACH_NO_CONNECTOR
> flag to drm_bridge_attach")
> 
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >  drivers/gpu/drm/rockchip/rockchip_rgb.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> > index 2494b079489d..92a727931a49 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> > @@ -150,7 +150,6 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
> >         if (ret)
> >                 goto err_free_encoder;
> >
> > -       connector = &rgb->connector;
> >         connector = drm_bridge_connector_init(rgb->drm_dev, encoder);

I don't think this will work as expected.

Yes, the whole thing looks a bit broken right now, but the connector
field in the rockchip_rgb struct still exists and rockchip_rgb_fini also
still uses it when calling drm_connector_cleanup.

Same issue seems to exist in in rockchip_lvds.c with drm_connector_cleanup
it seems.

I guess drm_bridge_connector_destroy() is responsible for the cleanup so
the drm_connector_cleanup call both in rockchip_rgb and rockchip_lvds
as well as the local connector elements can go away as well?


Heiko


> >         if (IS_ERR(connector)) {
> >                 DRM_DEV_ERROR(drm_dev->dev,
> > --
> > 2.35.1
> >
> >
> 
> 
> 




