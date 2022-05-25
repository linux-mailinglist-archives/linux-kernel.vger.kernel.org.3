Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8911D53427D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbiEYRwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343601AbiEYRwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:52:33 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1AC2BF9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:52:25 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y8so2339275iof.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCOJwAVhHqabf7q+ofFTKhfH08ncrowINh8zKJmKO8o=;
        b=fH5vloMgnO8q0+QKAIm8czJR7NH9BJmMdne5Ag+L/GDQCO0gBO5HLcleZSz3O+/WrY
         Jov0PppgY6/ita+gQd8tm5Ri0XYd1n6NlOefOktjw+IPnLkpFgwbbp+iDrgqP9Emrwva
         xOU3+QDLodh1nWYbHoJAVL+ToVbcVfbPiIGjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCOJwAVhHqabf7q+ofFTKhfH08ncrowINh8zKJmKO8o=;
        b=IAdC1PLVCwIEvnvDMf+ZCrTogbcjbmIjQ+E1sdptpxHF+rgm2x9BJ07uk7Qx7CkXCQ
         x9BDDYS7SubMtGeRveAd8LBiEvzsXLDErasx997TtJla5hB7uXJrMjkGcpkQHuSxDOtW
         FNxF5NcWpcHKiNmysamOKTS0wpkpwAQ5PPK9XPK4UTxE8f+y9baHcy8j87SKOPsVidXa
         +QyDMsH8uBkTFtwi87kFgtLsHd4eNr4x/evP2w0MgvxIlqZUZkCu4z7VSeNiFoSnQkPz
         8emgi4blL1V6jocFOVYn4AidCMkZaxzSpuDgqt6ePkVnHpqEpcRIGLtHszIx9Z5UtNDQ
         WoEw==
X-Gm-Message-State: AOAM5321AFS+LdB/lLdCZFKLi9iB1GZYmgxyin4Gsc2R9lz87ABOs3KU
        tNClKHP3dY9spuGx+RjT8RlH+Stnx+2aKadEphY=
X-Google-Smtp-Source: ABdhPJy7z3ARAdCJmLVEQcG68GS67h/wFh7SQGWGytkQTAB4tmi8TAYhj5E865/fBCmN8X60wOowtw==
X-Received: by 2002:a05:6602:2c0c:b0:5f0:793f:cb9e with SMTP id w12-20020a0566022c0c00b005f0793fcb9emr14819937iov.122.1653501145240;
        Wed, 25 May 2022 10:52:25 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id c20-20020a02c9d4000000b0032e174e945csm4326926jap.32.2022.05.25.10.52.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 10:52:24 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id b4so7459553iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:52:24 -0700 (PDT)
X-Received: by 2002:a6b:6b10:0:b0:660:d279:31bb with SMTP id
 g16-20020a6b6b10000000b00660d27931bbmr10484568ioc.47.1653501144197; Wed, 25
 May 2022 10:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220525014308.1853576-1-judyhsiao@chromium.org> <20220525014308.1853576-4-judyhsiao@chromium.org>
In-Reply-To: <20220525014308.1853576-4-judyhsiao@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 25 May 2022 10:52:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UfT_TuAS9DaKQ4D3dE_cY=rqPHvSuvkD7SS1egVuFKbA@mail.gmail.com>
Message-ID: <CAD=FV=UfT_TuAS9DaKQ4D3dE_cY=rqPHvSuvkD7SS1egVuFKbA@mail.gmail.com>
Subject: Re: [v3 3/3] arm64: dts: qcom: sc7280: include sc7280-herobrine-audio-rt5682.dtsi
 in villager and herobrine-r1
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Judy Hsiao <judyhsiao@google.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
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

On Tue, May 24, 2022 at 6:43 PM Judy Hsiao <judyhsiao@chromium.org> wrote:
>
> Include sc7280-herobrine-audio-rt5682.dtsi in villager and herobrine-r1 as
> these boards use rt5682 codec.
>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts | 1 +
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts  | 1 +
>  2 files changed, 2 insertions(+)

Should have carried my review from v2:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
