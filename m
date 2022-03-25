Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCE84E7542
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359351AbiCYOpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345538AbiCYOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:45:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF9C53E11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 07:43:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bq8so1851919ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdaepbbRGWYsyaL2QkmSp7WtYYHThf/iqjZK0d+zPJ8=;
        b=dm/pO7aCRa1CzlKVqD1bJ4Ls9HUp9fNlvHw4n7CxSpTF7W9hnwFyoz95R0sfBwDHb2
         nAiu29CamPcQ9qjyahRRfHuzw+Hv1a35ANlR1cNzxRtsdrS2BULx5xJ6pkQhcm+9GrA+
         BSwDnimM+mRblUqWKImuZnAJxdpMBCGEQhCIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdaepbbRGWYsyaL2QkmSp7WtYYHThf/iqjZK0d+zPJ8=;
        b=i+c5J13XcxoJVXOXnEYlhdaBd3CDqeMp2YYeZcvrk7/9gIUHf3B+CQFhRLG6m7xATI
         Zu4mQ7vLsHs3I6UfZgjOPB7yxwliVYcb+Ez61JNZwglDfpRslzZw6Ov9Y/TGT3wfNrmX
         nPXzUTMuUpyfVn1iA3jPY71AHJebfi15jCzGXmUhnE4xh1xGlSmJPJx2eKaGtZ+wwbMA
         z7Tc5d7HTi7zaAMSCGEtgPUgAdPd7A3JK4FSfKVyEZc45iAds7nv3QQUCfRfLgDABXXH
         duC06/5N0t2HYZ72PxaMMnFTmB3Hz0QLL1r3kyj/SIFWHqsRVy40HNfozHyRGCCfKtjX
         Exdw==
X-Gm-Message-State: AOAM530xlprFr9BnEFiNqULd4Uf/GndWZx2Go1kgZ47GKhw0rsWMdonl
        Fh/NLltmykbnCYQNMLAfx3xIOopOIt0FxrAv4BY=
X-Google-Smtp-Source: ABdhPJzEP6tJGJX+NXks7rFAKrQXe0zHM+L1EDh54J1LhKpDFsrI26ATa3MiBikuKIT/Jf3t8dGGmw==
X-Received: by 2002:a17:906:2991:b0:6cc:fc18:f10c with SMTP id x17-20020a170906299100b006ccfc18f10cmr11840304eje.744.1648219414541;
        Fri, 25 Mar 2022 07:43:34 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe4d1edc6sm2416877ejc.61.2022.03.25.07.43.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 07:43:33 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id b19so11148261wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 07:43:33 -0700 (PDT)
X-Received: by 2002:a5d:4491:0:b0:203:f63a:e89b with SMTP id
 j17-20020a5d4491000000b00203f63ae89bmr9410635wrq.342.1648219413124; Fri, 25
 Mar 2022 07:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <1648217145-725-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1648217145-725-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Mar 2022 07:43:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X2mF45Fsi+2eSRPfUKa9LCmYSkv8E586aGxPTxC0JsWw@mail.gmail.com>
Message-ID: <CAD=FV=X2mF45Fsi+2eSRPfUKa9LCmYSkv8E586aGxPTxC0JsWw@mail.gmail.com>
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7280-idp: Configure cts sleep
 pinctrl to bias-bus-hold
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        quic_msavaliy@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 25, 2022 at 7:06 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> WLAN rail was leaking power during RBSC/sleep even after turning BT off.
> Change sleep pinctrl configuration to handle same.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v2: used bias-bus-hold as per review comments
> v1: intial patch used bias-disable
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

No objections from me now. ...but we should probably be changing _all_
of them? ...and by "all" I mean _both_ the sleep and wake state of the
pins and this config across all the devices. In the very least all the
sc7280 ones, but maybe even the sc7180 ones.

$ git grep "Configure a pull-down on CTS" -- arch/arm64/boot/dts
arch/arm64/boot/dts/qcom/sc7180-idp.dts:                 * Configure a
pull-down on CTS to match the pull of
arch/arm64/boot/dts/qcom/sc7180-idp.dts:                         *
Configure a pull-down on CTS to match the pull of
arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi:            * Configure a
pull-down on CTS to match the pull of
arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi:                    *
Configure a pull-down on CTS to match the pull of
arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts:      *
Configure a pull-down on CTS to match the pull of
arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts:
  * Configure a pull-down on CTS to match the pull of
arch/arm64/boot/dts/qcom/sc7280-idp.dtsi:        * Configure a
pull-down on CTS to match the pull of
arch/arm64/boot/dts/qcom/sc7280-idp.dtsi:                * Configure a
pull-down on CTS to match the pull of
arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi:     /* Configure a
pull-down on CTS to match the pull of the Bluetooth module. */
arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi:              * Configure a
pull-down on CTS to match the pull of

-Doug
