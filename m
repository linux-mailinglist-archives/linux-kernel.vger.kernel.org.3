Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC72552C4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 23:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbiERUxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242829AbiERUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:53:42 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E520AE6C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:53:41 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t144so912985oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=UNqWZZ/W5ko5bopxO2cXE64dq+vAay+pJVcB9JPEK7k=;
        b=MZU6ZApL+VJ2nR/SOYL+8sNV8dz7t8gWj15O7ujNs2F9Fz+Vn9RCogVeN1vvAnRWRS
         ilsC9DGDD64NEGVFzpPB1wzxKAVfzks8J0UC+0ZH1/CCa+nGcAPbTMg0RH+kWk0nCnip
         XhfMZL6B6uOhpLcXD57lGxIbgFNNO8i1wISrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=UNqWZZ/W5ko5bopxO2cXE64dq+vAay+pJVcB9JPEK7k=;
        b=xoPm4LwHgyR6e9hMFGlPdYwvVwJoF9SPo+Emaj7gxjPgJu/HEGcmCXkEJzEGVp5BAd
         EkApYQqqsV0ECCNUWMrm/a0gWPUMyG1Cq744e3S2KxWgSvMvAB+w/L5LpJcwaK+AH10R
         Aj/zZXUKkvrTwN3WXRIeu78XlZ8xJL+tCpjj7mVyIHDOp2O/BJhT+xsXD0TRP6Q9d0PK
         pN7iO/9tOJzQwDMr8aQMbm9vqDfXeZ3q5Bvc8gZdII2yqKbpdFmexy/Ydaq0TZtO32kT
         c3yvVhTjcfIxUWvG7dL2j8+/IIKMiRoJxQXtLlAJZ3Zx43RxdMtjFMExa8c5k8EMi8RC
         8R3Q==
X-Gm-Message-State: AOAM53240VDcwaAkgJYhuJGMNGM3ygCE+tFKcuF+z6z3/9qkTDCIHV8y
        GrajX0DGe95hflmCJVHk5gblgD36yGYpQJqHOfHDCw==
X-Google-Smtp-Source: ABdhPJydobKed7t7rxB1Dk5wydK9YkQwNJ01ZtS6wCryK3YwFULkGDQ1slIBbwUS+XCTTygMr92gMAt/aKu+AoKQ+Hw=
X-Received: by 2002:a05:6808:23c3:b0:326:bd8d:7993 with SMTP id
 bq3-20020a05680823c300b00326bd8d7993mr892931oib.63.1652907220416; Wed, 18 May
 2022 13:53:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 May 2022 13:53:40 -0700
MIME-Version: 1.0
In-Reply-To: <1652905444-10130-3-git-send-email-quic_khsieh@quicinc.com>
References: <1652905444-10130-1-git-send-email-quic_khsieh@quicinc.com> <1652905444-10130-3-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 18 May 2022 13:53:39 -0700
Message-ID: <CAE-0n53o234QGNiDZ20Bmtrxcr03wUEbTgM82i1-sF4VhT=JsQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] phy/qualcomm: add regulator_set_load to dp phy
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-05-18 13:24:03)
> This patch add regulator_set_load() before enable regulator at
> DP phy driver.
>
> Changes in v2:
> -- no regulator_set_load() before disable regulator
>
> Changes in v3:
> --  split into two patches

Same changelog comment

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
