Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772A056A3FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiGGNpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiGGNo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:44:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE25167C9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:44:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h23so32460920ejj.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UG3BBJeQ9RIjyjrD9MOB3B5ohCStf2aBTETpevs+XUA=;
        b=X39mUG+jYTlLCiofyr0kiIG3mDhenlIh8E2uip6pT9ESNsQWC+IFZws1LCAOeKhmv2
         uMZOU76uVeoFJf0TVrVQej/MyqWt41MdhSk3TUzUTlJ/+jsZFtPuXwe/GO9aR4WfUsgy
         FwL4VdBDHlh1wInQKar1y4jfn6kh8wQDtQXrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UG3BBJeQ9RIjyjrD9MOB3B5ohCStf2aBTETpevs+XUA=;
        b=BZA0FSiCJpR6aq1U0kUxBMiZVcNI5aPrjqQzVmzv/u06s97OKZwarEOuT73S+VNn6z
         E8bxM8QRGyN+Gk9SzotatSHlsMJ20OSPDGe3PQOp2OEt5GAmeIllI5koMWp8+R91nAbB
         Msb9Um0kvIivdfy1mdP8y+Ip4wZz5cOIfpoGOCCOvg162WB/jVg/kovQpTCAN/s/yahj
         Xzh/2LNJXWV0QOhTANAMufX3t6m8n2SePB58XHgINwyzXDjA88ghQRN4PhgDzdApko7H
         581n5kLSi3IlntvSyW1ivyrHxjh5Lbh5Ntsrpi594hW6osWa29DWTrCXBS+EsHPjdNt+
         UXig==
X-Gm-Message-State: AJIora/I47vWFKVzXRRzjVh1NmwBHYNfv0ae944ZMKpPUDpE718sQApq
        aU7qqbxshRPc2OszcYGW2DX8F6dtjyLeZvd1Q6o=
X-Google-Smtp-Source: AGRyM1vgAgOU0wdkBz5g9MEJcFjG+ccwLJrjXJOUk+IE5LgVC9j1q9EUUB9fqPyNJNSOVeeBFCb1QA==
X-Received: by 2002:a17:907:9715:b0:726:2a3b:9f84 with SMTP id jg21-20020a170907971500b007262a3b9f84mr44021933ejc.414.1657201496070;
        Thu, 07 Jul 2022 06:44:56 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id p4-20020a056402154400b0043a46f5fb82sm10128466edx.73.2022.07.07.06.44.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 06:44:54 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id h17so13242268wrx.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:44:54 -0700 (PDT)
X-Received: by 2002:adf:ead2:0:b0:21d:8b49:6138 with SMTP id
 o18-20020adfead2000000b0021d8b496138mr959496wrn.138.1657201493566; Thu, 07
 Jul 2022 06:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <1657197381-1271-1-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1657197381-1271-1-git-send-email-quic_srivasam@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Jul 2022 06:44:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XD8vDPqkax1z6cB7ujOv_82YqkzZA1YNaPAGO+by4xJw@mail.gmail.com>
Message-ID: <CAD=FV=XD8vDPqkax1z6cB7ujOv_82YqkzZA1YNaPAGO+by4xJw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Move wcd specific pin conf
 to common file
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        quic_rohkumar@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 7, 2022 at 5:36 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
>
> Move wcd specific pin conf to common file to support various
> herbronie variant boards and to avoid duplicate nodes in dts files.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
> Changes Since V1:
>     -- Remove redundant documentation.
>     -- Update the pincontrol header comment.
>
>  .../dts/qcom/sc7280-herobrine-audio-wcd9385.dtsi   | 64 ++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts  | 61 ---------------------
>  2 files changed, 64 insertions(+), 61 deletions(-)

Looks fine to me now, thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
