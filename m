Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274F54FCD97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345770AbiDLE0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiDLE0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:26:37 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18292140A5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:24:20 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v75so17890311oie.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=wT1ipJ+z6nc0cV5pPdBgKr4CL6t1pZ10f3e64vOVaAk=;
        b=IzYw+aFrZYlAA3irCMBEMNlVetWN6Cvq/bEgM3Lo/0TkezivNTRXdVhVaADc9HZagw
         4pwlOwWufF8wBtrEoYbXfGM6mTBkfxWbVM9SgTIM6FeBIeCD/4yH/v8NP/e5h6CL/mis
         I6N7CIwas+HFuSJTLS2XUNrOdtf1d/DFTwtuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=wT1ipJ+z6nc0cV5pPdBgKr4CL6t1pZ10f3e64vOVaAk=;
        b=cdxda1J235mgk0s4iGOwzaXPGoekghIBorQXu3fjIz4n+RbFO26ZAgCj7Zh4Bc55/q
         exFQ1wEok52iXQ8dZ5BnDSzFpr6lD63BrTV+cO7gtoprKIyQWluP411yd00ABbzD1F/7
         KKSX/zp+Y40TmlVGFFg2bDynIXAHtTKDfaeUvRzeumqBaPb1CZI5NTTmdgCmBUeiD7Iw
         Bm50PF57Mb78MD8oPW1FlMf/vu+U+xU5VyDz010v2m0mTE6VCyck+LQh1p3e3RAqpl7o
         4urzaLQzntTbtsHHVwVk2PrqMyssARuTarBgTH00PeGTN95JBsE7drna1T8hlWpD5iYQ
         L0kQ==
X-Gm-Message-State: AOAM532N+UBUck00e0f8JNGpAhgY5qqtDyR7MmIHGs+HHIroDPQ7KxVy
        x3mWp4DrbaQ6BAIuGdneTCzegIccec85luN3TgbnEw==
X-Google-Smtp-Source: ABdhPJwQbxRfXrEl+yilyKFLG7gYsvTkWk6/J2NgE5ytQbVcrhyDZVAFL6sku9A05Sz3mgEknv8z6X2l0idsd9GHrnE=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr922783oie.193.1649737459493; Mon, 11
 Apr 2022 21:24:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Apr 2022 00:24:19 -0400
MIME-Version: 1.0
In-Reply-To: <1649451894-554-1-git-send-email-quic_khsieh@quicinc.com>
References: <1649451894-554-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 12 Apr 2022 00:24:19 -0400
Message-ID: <CAE-0n514Cv1ruTO_dN9mSBtjbYNzscty479QJ2tyXt=q8WNE-Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: add fail safe mode outside of event_mutex context
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Quoting Kuogee Hsieh (2022-04-08 14:04:54)
> There is possible circular locking dependency detected on event_mutex
> (see below logs). This is due to set fail safe mode is done at
> dp_panel_read_sink_caps() within event_mutex scope. To break this
> possible circular locking, this patch move setting fail safe mode
> out of event_mutex scope.
>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
