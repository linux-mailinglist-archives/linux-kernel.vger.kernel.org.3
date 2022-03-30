Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC24ECE96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiC3VLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiC3VLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:11:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5902526565
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:09:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w25so25909060edi.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIWUmlaDC6yTdkOws5vD5QTYsCbCyE6p7xDvHws/iio=;
        b=I1RLXU6q/tBCEt2oknEeNRaPbNXZjphrUkxnrg8fmmotMEKyRIkyjUdi87mFJntny8
         L0rFNrc1dIUelM7aed1PvlC7mO8H7z+jz5ULiY97z/g53LtVRw1KrL1Ba+NFKBQhm2Gw
         nxBZREsYkwdn8ah8iCdmgXvB+XkWHsn2mumxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIWUmlaDC6yTdkOws5vD5QTYsCbCyE6p7xDvHws/iio=;
        b=3DBJfZMbV5VgmibCllXvFsWpo5MkI/ggo3Sjava0DZeZW7E/FB2Uk63hDWbpIYA0X4
         J1nKBDg2utUkizeHJSC2uPtKkvT2T8HWK/pB46tAOkmDMGswJAwTwyEeRq81AcfIOTtL
         o80+BI+TaKDiOb4/FDLFl79UoiS2j/hEeVH51ljVBoODodnoSh3LIMzx79NATPsObIUG
         7JjpRGqEmEAvwKYavpXM85jQMSRD7qmfUvdjAEtbB0dko3oJ555X6Mkwq1AjGolWR8wi
         taRUFqvAMnD9yxl9R8abPnko6xnSHZOSVhqW0/KGRWiJ39s0cBclcPawsbBi+VopcgVr
         XBIg==
X-Gm-Message-State: AOAM530WCOSWKuqOrNS7cZfsyTHEP+IAxiOAoRhl8JD8Gta6KWOwvU5G
        mvN/3YyGlEoV9yeZdCPt7OgmUurvsx7DQA==
X-Google-Smtp-Source: ABdhPJxE69KcTI1yuHW7tegvwWsI2spMNOb39m7i/P86O3KxKqN1oJFXGY9Y6sKx2K8x16oe6cjHkw==
X-Received: by 2002:a05:6402:51d4:b0:410:a328:3c86 with SMTP id r20-20020a05640251d400b00410a3283c86mr6419539edd.55.1648674564715;
        Wed, 30 Mar 2022 14:09:24 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906671200b006e05929e66csm8586913ejp.20.2022.03.30.14.09.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 14:09:22 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id w21so26443995wra.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:09:20 -0700 (PDT)
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id
 n4-20020a056000170400b00203d857aa7amr1279796wrc.513.1648674559933; Wed, 30
 Mar 2022 14:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220330090435.1.Id1522250dd07a6b574c1cc7826023fc6acd141b4@changeid>
In-Reply-To: <20220330090435.1.Id1522250dd07a6b574c1cc7826023fc6acd141b4@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Mar 2022 14:09:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VK-gsp1mqU14ks9ocP3-LTvpa=fVNR_RaUBO83e1usuw@mail.gmail.com>
Message-ID: <CAD=FV=VK-gsp1mqU14ks9ocP3-LTvpa=fVNR_RaUBO83e1usuw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Fix AUO B133UAN01 panel id
To:     Matthias Kaehlcke <mka@chromium.org>
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

On Wed, Mar 30, 2022 at 9:04 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Two digits are swapped in the AUO B133UAN01 panel id (0x8495 instead
> of 0x8594). This went initially unnoticed because the panel is still
> detected, though it is set up with a conservative default timing. Fix
> the digit swap.
>
> Fixes: ec57376fba5a ("drm/panel-edp: Add AUO B133UAN01")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Doh! OK, pushed the fix to drm-misc-next w/ my Reviewed-by tag.

d049a24b15d8 drm/panel-edp: Fix AUO B133UAN01 panel id

-Doug
