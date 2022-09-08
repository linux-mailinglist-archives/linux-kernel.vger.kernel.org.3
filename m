Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D045B227C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIHPgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIHPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:36:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2480EB2D9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:36:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r17so11568312ejy.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=knhMsKK0YzQCQKsiPtIuuMjv+O66fK9juB2+nIAHPk0=;
        b=KfiYrfk6/8vzQ2y9m2B3d70Ln6jxPro9iQHMcnyBVr51+6I6SfcI70dnJnHWqHCLbE
         aJ0jmwq7FZVQHflmDW5PlZ8FmTwwZILYAnf4a6PYNrrVqMzFdkKVGrjbC4QxwWgBTkYo
         /gKG+JxCo++yPZryygU/Hzbxj0P4QZa7oUe0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=knhMsKK0YzQCQKsiPtIuuMjv+O66fK9juB2+nIAHPk0=;
        b=3aiVeGZ+18Lnb22GF8//pUmOdU+tIOQfcT0HJ2AuqeRr086hhp8JW5FO8BQLyiSdmm
         aLvTcBD2lLjqfcOiDvZwGLyO3iKPvSKf5lknjHJJ4q4m7HIBWmgKEGhuVE/02GS2rhQO
         gpkzXVCZgibL1flgw5OzfWt7gGbBqdu5esOpzPmsBJ+Xi8qK1Q7sIjJjqOcaNWaRRNcd
         PEtSlBb0AK2y6v6smZ0gvotBjVDNTHbgTnvHlfPfKKnhahBftGt+csdPpI2Etsiv/lEc
         UYIjPUHpbqnG11vsbguGVtlARcfAs71HWI5+bFNw7fetw/ilNCX2v1freC25UjmknZ7R
         A9BA==
X-Gm-Message-State: ACgBeo2Eu2WzgaYFPMMGwWsHekVlThQGURNc5QvEmsgDT/hIpf6t2d0h
        SuKEwQ7RwQvAXrRYKr7ly15xNNYlfh4YUw8msTo=
X-Google-Smtp-Source: AA6agR7RJ1KQQ0WYQN+61AvMDcT5XjJQv6Ny8RAsnA0xc2GbtgLWkeCke3oMVQ7jv8QYintkfO2pJw==
X-Received: by 2002:a17:907:7ba3:b0:776:ff9d:5c2 with SMTP id ne35-20020a1709077ba300b00776ff9d05c2mr1707541ejc.311.1662651370244;
        Thu, 08 Sep 2022 08:36:10 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id jy5-20020a170907762500b007306d478c62sm1387335ejc.62.2022.09.08.08.36.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 08:36:08 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id k9so26781369wri.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:36:08 -0700 (PDT)
X-Received: by 2002:a5d:4d0c:0:b0:228:cd9f:5a4c with SMTP id
 z12-20020a5d4d0c000000b00228cd9f5a4cmr5725454wrt.138.1662651368080; Thu, 08
 Sep 2022 08:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220908085454.1024167-1-wenst@chromium.org>
In-Reply-To: <20220908085454.1024167-1-wenst@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 8 Sep 2022 08:35:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VgyOT0eJ9eqwqaHRw2L7ypsTkiyGeSyqu-rEBURj5TCg@mail.gmail.com>
Message-ID: <CAD=FV=VgyOT0eJ9eqwqaHRw2L7ypsTkiyGeSyqu-rEBURj5TCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel-edp: Fix delays for Innolux N116BCA-EA1
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 8, 2022 at 1:55 AM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Commit 52824ca4502d ("drm/panel-edp: Better describe eDP panel delays")
> clarified the various delays used for eDP panels, tying them to the eDP
> panel timing diagram.
>
> For Innolux N116BCA-EA1, .prepare_to_enable would be:
>
>     t4_min + t5_min + t6_min + max(t7_max, t8_min)
>
> Since t4_min and t5_min are both 0, the panel can use either .enable or
> .prepare_to_enable.
>
> As .enable is better defined, switch to using .enable for this panel.
>
> Also add .disable = 50, based on the datasheet's t9_min value. This
> effectively makes the delays the same as delay_200_500_e80_d50.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 51d35631c970 ("drm/panel-simple: Add N116BCA-EA1")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Yup, this looks like a good fix to me. Thanks! I guess that patch
you're fixing was from a time before I had analyzed the eDP panel
delays quite so closely.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Given how non-controversial these types of patches are, I typically
just apply them right away so I'll do that shortly. If this upsets
anyone then please shout and I'll change my behavior. ;-)

I've applied this one to drm-misc-fixes.

8f7115c1923c drm/panel-edp: Fix delays for Innolux N116BCA-EA1

-Doug
