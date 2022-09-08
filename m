Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E291F5B2285
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiIHPhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiIHPg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:36:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364DCF9F87
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:36:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m1so24964381edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xrdt2Am83Q2/xE5e8Mu2ETEx+zDbeqSljE6QTT1gvG0=;
        b=G0Te9Xax4qhzFqNgN7Wf9BDii2Ft+4lhIjZ1oSLn0xbKxfuhq7YAyuYF2rHp+dHDHz
         lOvwCVLQkCmnJkDCfSoNLsrotggCNQpN1QfIvTeT0KHp+EAdBmkKmG6eNakRU6U0obDw
         /9L3PKD5T/APWa7bq8F+MmMlHgtzZRWjEV/vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xrdt2Am83Q2/xE5e8Mu2ETEx+zDbeqSljE6QTT1gvG0=;
        b=nbmUTP0VTEQ2btUFUbJ3InLC4prcgHOHyWFHQVS1g1bgHDweTf6GlPff2PgFhv17Ao
         JUtyHl/uv9Xx4ZESptp+kLrWzRWf3BTgyc3xvp0K011aDD6yLw09waBFovOnnmM4vtog
         kQ0sWndRptbpOU5IwRcrezR3S/BqlpJfoFrMkOFLOtKWcgPib6svKFY62b4Byw7+4iWp
         BzMFhfsjYWuZsCU/esttRnqAhuBDb4bKLTkSNq8UbFAxvoiYvsuVbV8SgVyUj2cotlqG
         SBDmxkEJDKrSL43woLJ0cQ3tN0VOYiHrGsnteKP2L1ARwZAAe7oDPZmrPYJJdNNKKhnD
         1VlA==
X-Gm-Message-State: ACgBeo1p0gANcKjkexGq7xZMOU3fyk3QGq3g1YWqO2D6R308o5C7afIO
        nUCk8qvqyqBuRxpUeNsv6Zi6WcNUxRc46SGilig=
X-Google-Smtp-Source: AA6agR5jOFzL5G5pTIsSZHMIet0RjKd3vacxUIrZSYunvn4lcf2RLtzYYsl+48ClDyOQzG+yel/5RQ==
X-Received: by 2002:a05:6402:2804:b0:439:83c2:8be2 with SMTP id h4-20020a056402280400b0043983c28be2mr7787816ede.292.1662651406893;
        Thu, 08 Sep 2022 08:36:46 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id h18-20020a05640250d200b00445f9faf13csm12987170edb.72.2022.09.08.08.36.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 08:36:45 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id ay12so11106798wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:36:45 -0700 (PDT)
X-Received: by 2002:a05:600c:42c3:b0:3a6:431:91bf with SMTP id
 j3-20020a05600c42c300b003a6043191bfmr2569148wme.188.1662651405144; Thu, 08
 Sep 2022 08:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220908085454.1024167-1-wenst@chromium.org> <20220908085454.1024167-2-wenst@chromium.org>
In-Reply-To: <20220908085454.1024167-2-wenst@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 8 Sep 2022 08:36:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wb+mTZ0OuwmqtgaKdeQJ68MN2havUp0ZpNZ=DfXBhThw@mail.gmail.com>
Message-ID: <CAD=FV=Wb+mTZ0OuwmqtgaKdeQJ68MN2havUp0ZpNZ=DfXBhThw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel-edp: Add Innolux N120ACA-EA1 panel entry
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
> This panel has the same delay timing as N116BCA-EA1 from the same
> company, which is also the same as delay_200_500_e80_d50.
>
> Add an entry for it.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 65e3a5361c80..15e18a64b03d 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1890,6 +1890,7 @@ static const struct edp_panel_entry edp_panels[] = {
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
>
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
> +       EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
>
>         EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
>         EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "M133NW4J-R3"),

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...and landed in drm-misc-next:

758d7b3483b6 drm/panel-edp: Add Innolux N120ACA-EA1 panel entry

-Doug
