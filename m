Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54B54B94AB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiBPXpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:45:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238599AbiBPXpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:45:43 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E05B24467B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:45:30 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s8so1707914oij.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=urbTff3ySXfX9ztkV2WSW1OMaQe9/9WZx066jydpeK4=;
        b=UzcSTBuyQpdljM0EhR7KpOMLMhNNmtZphfI7ahI46AEzDy5QHc3Q8LaLJJ88O2gr4o
         4PE3i+XfXarTxFLdZUUHSYQg7TIOsZQojW4+XKTcUGHm2J1o5agTYsm/IURoH0UmKm0v
         g228bJBGD5Y5aNyrqxIRE6jNVhnLBxnSzAEX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=urbTff3ySXfX9ztkV2WSW1OMaQe9/9WZx066jydpeK4=;
        b=bDEoBUTRXn/PeQ4vhbEmH5ep/Wxarwtt3/VzmICEbZevS/TlK5BsQXSVCLqky10TNR
         WzmT0ARtdpjqFuasJAucxzhMvXV/nHBy/pTOaLaapmGc7fnhUAL2iQoAZM17q4UOG0sG
         We9KtBUD8bdRSlJahIzcAj35e8iSkb6Bn59FMXo73yySrI/wokJ4fov4+owb3cCL7xOg
         GisYEojV7k//3YDkYuAEoZJ3WZo9zuwnyvDa/gjSwdj2UTHYfKZwNGDhnmOwbqC8DNP8
         dAa4vOaB98vRMRRqCVjajuV9UxNEdzht72jPCnZZ/L7S7k8pDizD69Mom6tGtBjnkNmp
         UK9Q==
X-Gm-Message-State: AOAM533UABP26POGDr8rO2ZSUt7oaB5ojz+otbqj3W6p8+TfWbb0V7K/
        MByfpfEbtlhTphKDmj0SjkCSJv1LzTU0yL5gn9iPWQ==
X-Google-Smtp-Source: ABdhPJwC+FZjkkt2k3aFm5upT8ZPjK+9KsMueCF3faJbdaaR7O9txcNN340aCsdpy2KadNskAEcn2MGE3nVZyZRZ0i4=
X-Received: by 2002:aca:df44:0:b0:2ce:285f:cb99 with SMTP id
 w65-20020acadf44000000b002ce285fcb99mr1720720oig.40.1645055129570; Wed, 16
 Feb 2022 15:45:29 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Feb 2022 15:45:29 -0800
MIME-Version: 1.0
In-Reply-To: <1643828199-8564-3-git-send-email-quic_khsieh@quicinc.com>
References: <1643828199-8564-1-git-send-email-quic_khsieh@quicinc.com> <1643828199-8564-3-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 16 Feb 2022 15:45:29 -0800
Message-ID: <CAE-0n50aJykz-PGiZQ1oxfpRHpFJK9Oo2rZ3VVX320Pcd5uM5A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/msm/dp: enhance debug info related to dp phy
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-02-02 10:56:38)
> DP phy should be initialized and exited symmetrically to avoid
> clock being stucked at either on or off error. Add debug info
> to cover all DP phy to identify clock issues easily.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
