Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB53510B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355341AbiDZVVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355337AbiDZVVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:21:43 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50490C8677
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:18:34 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e67799d278so16953454fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=UQdTLiFS6s5lb76z4V/zrcCjKl7kNha5dSW7q7Ju4iw=;
        b=i4UpTC9epX2dJK4owogRVosBAzugi615/pZuFaNT0GMn/rXImP/Z1IkC2BP9L9m3KO
         mOisseWijdZbjf0asGuv7vhXCkSH5GH52OL4ryQ5V/9AvT8Iyl7NkSWHt+uM/IKxVuKp
         8mCGvnSETOUjT5zWn1gPpmQuBa/iZlytHc92U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=UQdTLiFS6s5lb76z4V/zrcCjKl7kNha5dSW7q7Ju4iw=;
        b=CXe3yXDq6jwgqdsWmMVhVSC1d4xuYuROC+ylL6k5zXpzcma3ZAg1+Mhg85EM78J/Jy
         0zejQjRYgtxpjtmDy0i7fbyT2Onox9wyJ3K5ZT87wf1NY3meTmrSRru8FC6cSVAvMGcv
         pM14kzc55gV3jINaSMIFa+5CkIrL5sIlMLOo+vi9yqRf4KrGritjB/ooiw0ZAeKQnpsg
         zUf/X6YS/YQSg4nj4nCCyy2EYA3CkbGzabkFp0LmAE8cpTBr+AHFI3AzqHCFMYsbCzQZ
         MPmj3z7IvrTgwZPBDpjtolICGsQVykdhfEsfhp+6Zw4sTE1sRC7NM20Xi5QraWoq4wsP
         vThA==
X-Gm-Message-State: AOAM531LGJuQQdZlIkpnMUq4Cem+jUz/VhpSVWSQ6JvDxGt2mi2azSJX
        EscdWBn3sV7z3Eah6UYJLIlzCF0lYODnf1Pj2WUpR7Wrpf8=
X-Google-Smtp-Source: ABdhPJyW17NjxF3rs/I0KgToaqsIbXY3bjCBx58ePbAI217dDz1IltjBckzBntvCJY0CiDdmMaXOV9ldviATzU4d0f8=
X-Received: by 2002:a05:6870:15ca:b0:e9:551:6d1c with SMTP id
 k10-20020a05687015ca00b000e905516d1cmr8599802oad.193.1651007913723; Tue, 26
 Apr 2022 14:18:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 26 Apr 2022 14:18:33 -0700
MIME-Version: 1.0
In-Reply-To: <1651007534-31842-1-git-send-email-quic_khsieh@quicinc.com>
References: <1651007534-31842-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 26 Apr 2022 14:18:33 -0700
Message-ID: <CAE-0n50Hpt92HAZH2JF88LfXzGEJ8sa4cy5RsnKpFmZ5fWSzAg@mail.gmail.com>
Subject: Re: [PATCH v6] drm/msm/dp: remove fail safe mode related code
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Quoting Kuogee Hsieh (2022-04-26 14:12:14)
> Current DP driver implementation has adding safe mode done at
> dp_hpd_plug_handle() which is expected to be executed under event
> thread context.
>
[...]
>
> Changes in v6:
> --  fix Fixes commit ID
>
> Fixes: 8b2c181e3dcf ("drm/msm/dp: add fail safe mode outside of event_mutex context")
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
