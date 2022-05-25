Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A1533443
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 02:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbiEYAVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 20:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242923AbiEYAVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 20:21:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106EBC27
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:21:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ee42so4419762edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=po9Z+ZnC7Ru+UUqihsKbLp4miOkDQWGaTskPH6Fy5Dg=;
        b=DogEVOs1h9Ij4NbEnwQCFgHrnO+6c/aG33k1MdmT+QsVZDGJ5A1Xid8Y6NhT55/YZB
         wcIwCwdH49o+G8LNtX6oQ89Hi/v8+WA2AYdKpNkXEYzqSv3TpfNn42nSqr/xaiyJvA1P
         K9imYTOTjx9raNfGaw0DwbkGCwB+CKBzlOR6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=po9Z+ZnC7Ru+UUqihsKbLp4miOkDQWGaTskPH6Fy5Dg=;
        b=L9nKJt0Kt3BWCWpBouF1QRpbBtyNVDCQ3bRGfxZrnE5BtieJ54ED5byYaX20VuWGg1
         92t3PfjjcNL2BcOq4ENjtKke3FadNyMbakVthGS8rvyDm1yPYF/c7KTWvuhDFhxRgLDD
         uMvgUncQckjXr+CRZgmIHlo39ujp5YjnUSDFFLlDhlOE63Y541vM6siDGJdiRv4tpsfn
         EE4Buy65eXcLpJQPC+gHEhf20DYZBqg/3t3qVdWZhfz5NSUCUm4L4tJe5bbrKT5C9eQa
         W5mxIfg9OdWL+hMCT4bH4ErKR7HzomIP07bxze8Ij00y07fnV2US1hCFoDHjniBaKyn7
         aIsg==
X-Gm-Message-State: AOAM532wpodtrEPUbxT8u9acBUlS03VTLfIYmYhFOjz6pBrq76cswT1H
        BNc5Ov2DTb69hobBq44RYZ6NXPBoNSUTlEpkgco=
X-Google-Smtp-Source: ABdhPJwCkiZXZCjEuukCto8py6SH97RHvqCudgbGfoWahlMCvDA9Ulwg/z8EwoQNKgLTney0GxrymA==
X-Received: by 2002:a05:6402:368b:b0:42b:42c7:f63f with SMTP id ej11-20020a056402368b00b0042b42c7f63fmr19146870edb.409.1653438065489;
        Tue, 24 May 2022 17:21:05 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id mm24-20020a170906cc5800b006fe9ba21333sm6198243ejb.113.2022.05.24.17.21.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 17:21:04 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id x12so3648452wrg.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:21:03 -0700 (PDT)
X-Received: by 2002:a5d:5009:0:b0:20d:846:f4da with SMTP id
 e9-20020a5d5009000000b0020d0846f4damr25355018wrt.301.1653438063415; Tue, 24
 May 2022 17:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <1653082028-10211-1-git-send-email-quic_khsieh@quicinc.com> <1653082028-10211-2-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1653082028-10211-2-git-send-email-quic_khsieh@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 May 2022 17:20:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VRNAC3=VAZcw5H1jReGzdbTCbD83OqRcYztrzhPD3PAg@mail.gmail.com>
Message-ID: <CAD=FV=VRNAC3=VAZcw5H1jReGzdbTCbD83OqRcYztrzhPD3PAg@mail.gmail.com>
Subject: Re: [PATCH v11 1/3] phy: qcom-edp: add regulator_set_load to edp phy
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 20, 2022 at 2:28 PM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> This patch add regulator_set_load() before enable regulator at
> eDP phy driver.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
