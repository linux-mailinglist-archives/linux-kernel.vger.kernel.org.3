Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34075511B57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbiD0OjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbiD0OjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:39:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4AAB7CF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:35:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so3834105ejd.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBjVwlfQHfJTzGZmbfEvXhaX1IO5OkSRicNnSdosqfE=;
        b=NSdJkx1jUjjiXuAhxMA30qKgzaND/A7AqoOWPp5E5YGLrXn7dcO3OQMupXUipJJWOA
         JUFRfFkfl9q1bKNHk3/zQMSwlO/gsV/x5hR66QT7FXzr1siOkocOBQR/F+ktgDFUNnWb
         X5fL4fh2Ok7wc8jM9Rp0R1OuGPLDz4fwit9ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBjVwlfQHfJTzGZmbfEvXhaX1IO5OkSRicNnSdosqfE=;
        b=w7Y1qqopGdFK8s1n/6Bo8T+QCfnfK4tCajuS2Dmuwg9tjDN9UGVPlQsianrxc4vEVw
         eQl8/9YAu3K2IxCg0kGEdoyK0TwXX498JMY1Y1WxsY/9BbC7csmpJGc3VyHA5lvK5po4
         Buh119J3xyAnvBLQuK5NJpPrmD+2a+lH/8z+lKEXTLPjbtDI2sqbiHhrEMim5g3Gc7aP
         5NQ7pGqLtvX51nJeX6EVHP/PQYzvtFTpTHnNHU2//v13bGEL0OQR69DGC48RUfUco5re
         tB9uStqubYSJtTISiR/Rm6fXf3DKLrL2DHDOSoyU75VGK01pdUKhHbFgOUz7W1A2X3Ln
         dzqQ==
X-Gm-Message-State: AOAM533xLGsofXnvMBEuonI/ARt+eLCQkTl3zVi+BgAyF/cNWYQKjst5
        6+daFbk5M7zhlJhXBopfqE+QeJsR35ZXgcAUxwg=
X-Google-Smtp-Source: ABdhPJxbD8o9e1mANl9drBkbh6Zyx4b27+vaK4fcc/LINSJQ+u9gCHy/oTcAZPyc4euTe9KuZzOEPg==
X-Received: by 2002:a17:907:94cc:b0:6f3:bfb8:9f04 with SMTP id dn12-20020a17090794cc00b006f3bfb89f04mr4846985ejc.507.1651070150023;
        Wed, 27 Apr 2022 07:35:50 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709064b0e00b006f3867ebe45sm5018839eju.123.2022.04.27.07.35.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 07:35:48 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so2542993wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:35:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3c99:b0:392:b49c:7b79 with SMTP id
 bg25-20020a05600c3c9900b00392b49c7b79mr26204171wmb.199.1651070147811; Wed, 27
 Apr 2022 07:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220427013226.341209-1-swboyd@chromium.org>
In-Reply-To: <20220427013226.341209-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Apr 2022 07:35:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UK522o=zak8ryR4e8yGTm=wGtMjxtfYNJ4DXk5ayAGhw@mail.gmail.com>
Message-ID: <CAD=FV=UK522o=zak8ryR4e8yGTm=wGtMjxtfYNJ4DXk5ayAGhw@mail.gmail.com>
Subject: Re: [PATCH] interconnect: Restore sync state by ignoring ipa-virt in
 provider count
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
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

On Tue, Apr 26, 2022 at 6:32 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Ignore compatible strings for the IPA virt drivers that were removed in
> commits 2fb251c26560 ("interconnect: qcom: sdx55: Drop IP0
> interconnects") and 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0
> interconnects") so that the sync state logic can kick in again.
> Otherwise all the interconnects in the system will stay pegged at max
> speeds because 'providers_count' is always going to be one larger than
> the number of drivers that will ever probe on sc7180 or sdx55. This
> fixes suspend on sc7180 and sdx55 devices when you don't have a
> devicetree patch to remove the ipa-virt compatible node.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Alex Elder <elder@linaro.org>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Mike Tipton <quic_mdtipton@quicinc.com>
> Fixes: 2fb251c26560 ("interconnect: qcom: sdx55: Drop IP0 interconnects")
> Fixes: 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0 interconnects")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/interconnect/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Ick, but seems like an expedient fix to get us back to working while
we try to come up with something better.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
