Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01734E3FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiCVNz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiCVNzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:55:54 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E4917A9A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:54:21 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y7so5477413ilv.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2DscZc3AEntEFvhf0cmEbjgQhmN19fYz2yomg4IX2A=;
        b=f5lj3SZg+5/T+XDU05uwNy/6FgMMhmfX4FPfg2pB9UQi/PLqUC8vVR8zps2GDhRoyF
         D3yy67ScBm/PKtLI24Fs6de+W4AlWNYub8bnniTEebRzROb9FxZV3YrmGPlWkWt2dr4v
         6nOr+GqcEfaADKVbBLftjdARjMxxyv1Efcymo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2DscZc3AEntEFvhf0cmEbjgQhmN19fYz2yomg4IX2A=;
        b=nvcm0WIw+fhQ7o91xbtr5mIh+GENsjXPwNH+r3c3YWaAxToGCLwJ3Xq+oBjvTeio15
         9oIVpis3SnenfOKTKwXnMURWtGqPgeJoctBhwZPLx/wcOexK4lGGBSVMZZejBhXKlzUn
         wKbG7rk+kvBZrrK5iavDWKHvn+V2gvY940d/Lfu4MNKSmGd1P75UrPpLiZu4m8zJ4Lg0
         tdGiG5skoC3Oc7bqRldfmDTLKvLOWsLa2JlMFwZZamUZ9ZT8I8VPdb9VmjQHcdiLVF1K
         6oSTkqvlADKEDZyZq73G9ASrNkDOvotU+sYQUOBG8ohtS7xBjtsM5GtQlATWeFfBCjI0
         jQkg==
X-Gm-Message-State: AOAM533bAALMnGnex/OCG6spzIEhbQEOVdX0OmBpNryOka+MO4LfV7Q0
        5GyDIa+FGhc5m8ndo7nHt0rmoTcYdj75Z0dV
X-Google-Smtp-Source: ABdhPJx0Sh2djfj6vcz0kije5cS7b0ViRTOVoVfs+aH5yakyAy+4StAXFa3oUL8MnXMCdV979BPw7w==
X-Received: by 2002:a92:b107:0:b0:2be:cb81:dd96 with SMTP id t7-20020a92b107000000b002becb81dd96mr12242526ilh.189.1647957260502;
        Tue, 22 Mar 2022 06:54:20 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id o2-20020a92c682000000b002c82a16db8csm3301496ilg.24.2022.03.22.06.54.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 06:54:19 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id q11so20245899iod.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:54:19 -0700 (PDT)
X-Received: by 2002:a5d:9e02:0:b0:645:d25c:30bd with SMTP id
 h2-20020a5d9e02000000b00645d25c30bdmr12441220ioh.208.1647957258853; Tue, 22
 Mar 2022 06:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220322092524.1.Ied05fc4b996737e3481861c6ab130a706f288412@changeid>
In-Reply-To: <20220322092524.1.Ied05fc4b996737e3481861c6ab130a706f288412@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Mar 2022 06:54:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xe_6s8PV=rqwu0BFyfTij-VSVJ6wRpv-VN9XvdFx4A+A@mail.gmail.com>
Message-ID: <CAD=FV=Xe_6s8PV=rqwu0BFyfTij-VSVJ6wRpv-VN9XvdFx4A+A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: switch panel compatible to "edp-panel"
 for limozeen
To:     Ivy Jian <ivyjian417@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pan Sheng-Liang <sheng-liang.pan@quanta.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 21, 2022 at 6:25 PM Ivy Jian <ivyjian417@gmail.com> wrote:
>
> some panel can't light up with new board with ps8640, switch compatible
> panel define to make it workable.
>
> Signed-off-by: Pan Sheng-Liang <sheng-liang.pan@quanta.corp-partner.google.com>
> Signed-off-by: Ivy Jian <ivyjian417@gmail.com>
> ---
>
>  .../boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dts     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
