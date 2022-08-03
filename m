Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26619588E23
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbiHCOBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiHCOBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:01:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4EE2A400
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:01:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m8so21539609edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BX0MHXFB9OMLas/3vw1gWSW/wKlLfG1bTlBU7/A5LJY=;
        b=NgWFEGgqhpFOMAezMzzFaK7vGV+stSnIqJjbdEM3QqRLao4HHCRJ6LwcqWOcDrMmwd
         a0gNzN/9aGOGsFxsbpAEiMb/bknSNrVfjlM3GIgVJFuSpLQlFbJO+zEKTxBYLvzDzmfr
         yJdg+x5hmAYuyctBRyTquSAt7q/6fDMtx20is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BX0MHXFB9OMLas/3vw1gWSW/wKlLfG1bTlBU7/A5LJY=;
        b=alo6mmsBJ1GesIitHywf2D1JbVTXEjMi0qHreqCLtD94jRmlHwHlLudH4vhallGa9F
         xyLYjJzjTsN0XangWcpwTWvtz8mAreb0k/IOMHkjuvQov/DOaU81DuEMcKf3Vu5KEoL0
         Oiysu1vbu+/vdl8x7oc2Ab93yPocXk4vcj236jnbRtrsxYVFWzV4NR6cNqIWkhftmPYA
         s65VJfZ2Tuq1j8pGXK7JajGWLmVBPCfTwP6g6/ImMVdtLTsVVbhEOURHfron6HxZ/v60
         c0Avl1BCMOCBWCJQIzGyBY+BwJ9gn8E7K46LlnYqSo+YGk4GRS7+StMvavBvcNuA0eu7
         1NCA==
X-Gm-Message-State: AJIora8fSh6BczjnTnsB2yg2W4PgAQD5mSAc8sMga4FGV1aBCovPsaI0
        mRfPsXsnUNuIQqnD96ED0sEdm2P1/L25zVpxJHY=
X-Google-Smtp-Source: AGRyM1s/0IpiYk5RX5MCaP4VX5c0C4WG/kF0rGvSgYnGccImnxFRQ/QRNJ9uHhC79nDQq8zq4SscbA==
X-Received: by 2002:a05:6402:3907:b0:431:6776:64e7 with SMTP id fe7-20020a056402390700b00431677664e7mr25748831edb.0.1659535279648;
        Wed, 03 Aug 2022 07:01:19 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id c12-20020a056402120c00b0043cc2c9f5adsm9550956edw.40.2022.08.03.07.01.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 07:01:18 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id z22so21586730edd.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 07:01:18 -0700 (PDT)
X-Received: by 2002:a5d:5889:0:b0:21d:bccd:38e3 with SMTP id
 n9-20020a5d5889000000b0021dbccd38e3mr15858645wrf.659.1659534911179; Wed, 03
 Aug 2022 06:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220802223738.898592-1-dianders@chromium.org>
 <20220802153434.v3.6.I969118a35934a0e5007fe4f80e3e28e9c0b7602a@changeid> <3f79c5b1-9ce8-6aeb-300a-565ba018ae11@linaro.org>
In-Reply-To: <3f79c5b1-9ce8-6aeb-300a-565ba018ae11@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 3 Aug 2022 06:54:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UVSBvpAs4bBHTh6tGXazU1+OLg4+Opfg8guXQ1ShhnNA@mail.gmail.com>
Message-ID: <CAD=FV=UVSBvpAs4bBHTh6tGXazU1+OLg4+Opfg8guXQ1ShhnNA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] drm/msm/dsi: Improve dsi_phy_driver_probe() probe
 error handling
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 3, 2022 at 12:32 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> > @@ -634,88 +631,71 @@ static int dsi_phy_driver_probe(struct platform_device *pdev)
> >               phy->cphy_mode = (phy_type == PHY_TYPE_CPHY);
> >
> >       phy->base = msm_ioremap_size(pdev, "dsi_phy", &phy->base_size);
> > -     if (IS_ERR(phy->base)) {
> > -             DRM_DEV_ERROR(dev, "%s: failed to map phy base\n", __func__);
> > -             ret = -ENOMEM;
>
> Here (and in a few cases later) this changes the error code from crafted
> -ENOMEM to the proper one returned by msm_ioremap_size(). This should be
> mentioned in the commit message.

Good point. Unless something comes up I'll plan to spin a v4 with this
change to the commit message tomorrow.

-Doug
