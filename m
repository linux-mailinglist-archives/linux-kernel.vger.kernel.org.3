Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4268A5847D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 23:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiG1VsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 17:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiG1VsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 17:48:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DCE550A5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:48:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z15so3752806edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=96laK3X9C3HRNTHwHkJ/JwZirLHA0u1Wc3B+YkpYnbk=;
        b=dwGp1I6EVE9BIy633N3+06sVbzUdtGVoRiYhkuozOlTlbau/f2pEglaX1R7+dsByqT
         engBs/RHc9QlFai8NY3/kFpFsoGgjOWsOVz3WpfAHHD+/6AdSDu5yQGx3Qus4XIQufAd
         eGX++gEOJCCFMUw5AnUlbLqBp473kx5spGSIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=96laK3X9C3HRNTHwHkJ/JwZirLHA0u1Wc3B+YkpYnbk=;
        b=SU7iefazUQ/kv0L3s/qEF9D2T2Xc401NFr5YsDJPTcQLiBn5fz4ZwOA4VGgWNUYVJF
         xcdARtd8j9jaA4fAW6j+45K2wSJ7++C+y8umukRvajW0XLiXcKuA6dg5QDqBVZ3iJGFb
         vTPpsmudKYV9tKqeIbx2tXCFo9rpt0E4HghIRdhK4Uztu8s8CM5T7z7vTCAN11OHzFvT
         cBB3J2iKRLcKyKSJGD18WD0OrwpQQmOWUfgVKECjYzuuf7GRUOOyPi2OUdVtkfay5h0o
         EERNRl8ROYuklgbTSII1u8BTWM1B6anJoZ0WLriAYrb7N8Gwi8mmNlhWOC2fpKue3TPq
         tg5A==
X-Gm-Message-State: AJIora/PyhIf7d9Pd9n3TJSrjof46OZhbVeHcA+7WUt/exrc72cANRiB
        j+pYaK2zRLm0ok1/PE+POF+Fl+VCQmALSpfq
X-Google-Smtp-Source: AGRyM1vuirjv/pEKWOoWHNpKiUX7f0KeemKhj4cw+g1JFUs2CzTqwrun12WGeuYepEblI65UXDN6TQ==
X-Received: by 2002:aa7:cd84:0:b0:43c:532b:65e9 with SMTP id x4-20020aa7cd84000000b0043c532b65e9mr929584edv.330.1659044891143;
        Thu, 28 Jul 2022 14:48:11 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id uz12-20020a170907118c00b0072aed3b2158sm851453ejb.45.2022.07.28.14.48.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 14:48:09 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id n185so1673612wmn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:48:08 -0700 (PDT)
X-Received: by 2002:a05:600c:2e48:b0:3a3:1ce3:3036 with SMTP id
 q8-20020a05600c2e4800b003a31ce33036mr776502wmf.188.1659044887677; Thu, 28 Jul
 2022 14:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220728143215.v3.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
In-Reply-To: <20220728143215.v3.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Jul 2022 14:47:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U2U5drgkUP57_hszWT+OEKhqcySOAog00NQ09AhtQ8Qg@mail.gmail.com>
Message-ID: <CAD=FV=U2U5drgkUP57_hszWT+OEKhqcySOAog00NQ09AhtQ8Qg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: qcom: document zoglin board
To:     Bob Moragues <moragues@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 28, 2022 at 2:33 PM Bob Moragues <moragues@chromium.org> wrote:
>
> Zoglin is a Hoglin Chromebook with SPI Flash reduced from 64MB to 8MB.
> Zoglin is identical to Hoglin except for the SPI Flash.
> The actual SPI Flash is dynamically probed at and not specified in DTS.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Bob Moragues <moragues@chromium.org>

A nit from my point of view is that I would have expected your
Signed-off-by to be the first tag. As I understand it the tags are
usually supposed to be a top-to-bottom history of what happened. You
signed off on the patch and then people added reviews / acks. I don't
personally think this is important enough to spin a v4 for, though the
last word would be Bjorn.

> ---
>
> Changes in v3:
> - Fixed Author
> - Fixed duplicate Signed-off-by

Technically this should have been:

Changes in v3:
- Really really fixed Signed-off-by

Changes in v2:
- Fixed Author
- Fixed duplicate Signed-off-by

...but that's also not really worth spinning for.

I think this looks good now. Though unofficial (and not stable git
hashes), I've been trying to keep track of some patches during this
dead time till -rc1. I've put your two patches here:

https://github.com/dianders/kernel-staging/commits/qcom/arm64-staging

-Doug
