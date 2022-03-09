Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354F74D314F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 15:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiCIO4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 09:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiCIO4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:56:35 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB161693AC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:55:36 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id bc27so2158928pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 06:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dxj4frE2eCuqonVDS5bQZcQRra2ODtuFVo9Dvr2UfAM=;
        b=Lx64DbIQRSA61d6Xh4UQh+hEzAkwZEmkFFvrSkKyC5q8t/Q5VPDpuUjZRJpI9PhvLH
         /NV3lFRxEMOeVk9DjRpY1YX2aPqvkmwDcMJHK8b63Xu5WptxcvmCXhJ5RVo/+vv6LoTk
         jXlChGgEExi3ofGacl2IKyjejnMfj2gTfSHSNCE1k9uXQOacQRQynU6K20iuNYe1k7mJ
         grZ8CdQL0vNoPtDghRHKJye07qiRQVRmxFGEIljRz4WR1PvSNHi6KjbAQKNczko9P4pM
         CsjuvNUFf3ZNvwcKeBSzY9mnHT91BzyH2grKbBGkDACc6ar7T37veEu5njOjDzZjaWzk
         YJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dxj4frE2eCuqonVDS5bQZcQRra2ODtuFVo9Dvr2UfAM=;
        b=Wve/e7oCYq7asjbyr2ChD1IQHVAHf0SUsz58+sioaj06banhm88aLKwsxEiokIhCfm
         V7pmvJ3l2O775w+fj0E6VZmPNRCO96U1dHZttPnaWqA8QtVp4uyEFtvZ5+li4X+COBZ3
         GtQWe99nQF3ivp2UjC3Y1UX2Np8ghrnEo0lm2WOlEtPB53+SFBCylwB+4W8fT+bEF2nA
         wTmVr0JTY56L0XyvlcmlhykabhYcNtItSLm9Wh90mwciElCiDzby1wlENRUzxjZXPwhe
         fHBKrY0RHVcKPlgCcY8t9cjFnj6Y6xfV9tf7HYcRiiPbLspyfZ4lBZjUtvE6/Q2NqfZF
         TMJQ==
X-Gm-Message-State: AOAM530vFlKh+8eabnAS9Nfj0LlyJ7jXFwM7MjezU+EQKWIPFwyN3A5o
        r+wkIDb8vbmOMWU6EkBEP2IfHVy6B8oazINdi3YcKA==
X-Google-Smtp-Source: ABdhPJzK9dlHuNBGU9ukp9ZvpYdg3LfIvQ/WqY63hqVDNchAfC7PzmtrJJ1LPB1EWTXUUKE7JO7WKWsjNPkMDZm28u4=
X-Received: by 2002:a05:6a00:889:b0:4e0:dcc3:5e06 with SMTP id
 q9-20020a056a00088900b004e0dcc35e06mr24123462pfj.29.1646837736094; Wed, 09
 Mar 2022 06:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20220221072835.10032-1-jose.exposito89@gmail.com> <20220221085509.fies6j3hjsiz55rz@houat>
In-Reply-To: <20220221085509.fies6j3hjsiz55rz@houat>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 9 Mar 2022 15:55:24 +0100
Message-ID: <CAG3jFyuFH2PX2shWZHS90Dsv-2H1OLdNYnvdN+R-d67T3E4APA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: switch to devm_drm_of_get_bridge
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022 at 09:55, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Feb 21, 2022 at 08:28:35AM +0100, Jos=C3=A9 Exp=C3=B3sito wrote:
> > The function "drm_of_find_panel_or_bridge" has been deprecated in
> > favor of "devm_drm_of_get_bridge".
> >
> > Switch to the new function and reduce boilerplate.
> >
> > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
>
> Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Applied to drm-misc-next
