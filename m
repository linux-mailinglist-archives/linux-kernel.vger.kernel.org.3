Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F010D50A5D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiDUQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390511AbiDUQKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:10:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFCC4739D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:08:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z99so7129117ede.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/PzIKSjMeAOGbI6c4RWxm0pVUCyssgrVjMCd8c5Dag=;
        b=nSF4LY4d2BN1+JKzCgg54cIZdi/67BsPH/yDBzQffgGlo9dfl+XlmWXoZzWzMAXnIp
         qdZnwGxZTweXi0UkZvcPT3csTHegVQ7l9Yr8NqemyuxGmINZvpE6WVK/kWcyEnj1B29C
         R+2ri3hviOx0Pn502v6FXWj/8GgnrITxJ4CN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/PzIKSjMeAOGbI6c4RWxm0pVUCyssgrVjMCd8c5Dag=;
        b=G2e5R/X1j+mUAsOJ+zW/Dy4Hwu0HOuDJeqU+Ycvm1jzGyFnYYVvr6Z2KDnG2vaRJVz
         irDObq5hsfQoJhFn03UgaHhWa/4l8LbKo4Q08t1/UteVL25279pYXlF5EpoHVPQAt/qD
         FmEcaeN5pLd1pP5INxIJVALgjgd4pMnYkhAPDOJM7+B9fJLKcU1AcdTSCB9DDGFU0k4P
         WItsp7eVqUJQYPA48rf/TU/4RgztC7sEt5OhL9RAOUu3Y6+GqzHpLjVRAG940laxt/bp
         +hBfrdrbL7yhy5ijS3sUsOcSRf5FOvWsO28ovk/HpZnvFGzCN+GU9VeChn9YqFms3FwC
         c77Q==
X-Gm-Message-State: AOAM530k3WtiKVvMwXbYmyU/hP4qdq9LkeDUAHNk9bnkbiwtD95zJltw
        m/jL3zoAQjI4+RXn1TqQif3GOVZ2CdA5wn4dFxw=
X-Google-Smtp-Source: ABdhPJxHf7i9KoQrXf8NcD5Go2gtZVZFBsJRS8r5qjEl6AQndl6oZ5uOSJa964gZIceJsIQ9nOv6SA==
X-Received: by 2002:aa7:d915:0:b0:41d:8b43:f929 with SMTP id a21-20020aa7d915000000b0041d8b43f929mr267955edr.131.1650557280508;
        Thu, 21 Apr 2022 09:08:00 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7cb83000000b0041b573e2654sm11562919edt.94.2022.04.21.09.07.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:07:58 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id p18so7371061wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:07:58 -0700 (PDT)
X-Received: by 2002:adf:a29c:0:b0:20a:a246:a826 with SMTP id
 s28-20020adfa29c000000b0020aa246a826mr355251wra.422.1650557277978; Thu, 21
 Apr 2022 09:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <1650551811-24319-1-git-send-email-quic_sbillaka@quicinc.com>
 <1650551811-24319-2-git-send-email-quic_sbillaka@quicinc.com>
 <CAD=FV=Ug-ZRiMrVyVH+OT1fMhyUnAixP2FfWKTQpLZXka0U_=g@mail.gmail.com> <MW4PR02MB718603608E45FB53A8D942C7E1F49@MW4PR02MB7186.namprd02.prod.outlook.com>
In-Reply-To: <MW4PR02MB718603608E45FB53A8D942C7E1F49@MW4PR02MB7186.namprd02.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 21 Apr 2022 09:07:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UOALugpmgJK8dHxK=b_GO+c12d3xmGE3HiqJK+yznViA@mail.gmail.com>
Message-ID: <CAD=FV=UOALugpmgJK8dHxK=b_GO+c12d3xmGE3HiqJK+yznViA@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] drm/msm/dp: Add eDP support via aux_bus
To:     "Sankeerth Billakanti (QUIC)" <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 21, 2022 at 9:00 AM Sankeerth Billakanti (QUIC)
<quic_sbillaka@quicinc.com> wrote:
>
> >> +       }
> >> +
> >> +       /*
> >> +        * External bridges are mandatory for eDP interfaces: one has to
> >> +        * provide at least an eDP panel (which gets wrapped into panel-
> >bridge).
> >> +        *
> >> +        * For DisplayPort interfaces external bridges are optional, so
> >> +        * silently ignore an error if one is not present (-ENODEV).
> >> +        */
> >> +       rc = dp_parser_find_next_bridge(dp_priv->parser);
> >> +       if (rc && dp->is_edp) {
> >> +               DRM_ERROR("eDP: cannot find the next bridge, rc = %d\n", rc);
> >> +               goto edp_error;
> >> +       } else if (rc && rc != -ENODEV) {
> >> +               DRM_ERROR("DP: cannot find the next bridge, rc = %d\n", rc);
> >> +               goto error;
> >> +       }
> >
> >The above wouldn't be my favorite way of doing this. Instead, I would have
> >written:
> >
> >  if (rc) {
> >    DRM_ERROR("Cannot find the next bridge, rc = %d\n", rc);
> >    goto err;
> >  }
> >  ...
> >
> >err:
> >  if (dp->is_edp) {
> >    disable_irq(...);
> >    dp_display_host_phy_exit(...);
> >    dp_display_host_deinit(...);
> >  }
> >  return rc;
> >
>
> If rc is ENODEV for DP, then we need to return 0. Shall I add like below ?
>
> err:
>   if (dp->is_edp) {
>     disable_irq(...);
>     dp_display_host_phy_exit(...);
>     dp_display_host_deinit(...);
>   } else
>         If (rc == -ENODEV)
>             rc = 0;
>   return rc;

I wouldn't. Then you're essentially going to "err" for a case that you
don't consider an error. I would instead have just handled it right
away.

rc = dp_parser_find_next_bridge(dp_priv->parser);
if (!dp->is_edp && rc == -ENODEV)
  return 0;

This also is better IMO because it means you aren't assuming that
`dp_priv->parser->next_bridge` is "valid" (or at least NULL) after
dp_parser_find_next_bridge() returned an error.

-Doug
