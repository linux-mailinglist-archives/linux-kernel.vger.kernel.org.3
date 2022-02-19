Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D5B4BC508
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 03:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbiBSCq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 21:46:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbiBSCqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 21:46:54 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89B110D8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:46:36 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so5910552ooi.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 18:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=DQm3dzVCY1FyK1nVTRS3Y8VEmZfIVCq9w/XynD1Yj4Q=;
        b=PhWFIs+RJpcr112/Fdp4ospixnQKGstbiHUuquknUgzAbkRicCb5xc6wiV/c0B23wO
         su1uhMIWVBnzciMlN37pXRteUNFruOlD8eWek/kU2o3rK3aND6Rli4kf0nZ0yoYzcezL
         3fsYiVrV+KODKAj59h3YVuNk6nO0Egvk657TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=DQm3dzVCY1FyK1nVTRS3Y8VEmZfIVCq9w/XynD1Yj4Q=;
        b=8NZFxtDnRcVa2p38vkkczv32eIbd81kExGy59+Ci34zhnSuMw9z+7+jfXvbWwb+uPB
         XPgMwD6Zqz1A8fIXED/VhOu7edAp0el5F5Uvjq5FJLYZhUKG1Ow2bdV8FfyZEI886oFa
         aAKPJ+46BIqsl3BmTqC4YOzARkvBMYahZ5JL9A9kIu/0hKTejD4yAllKzRJsb85HZYnK
         Z2crk32MOUjtyG4kaxA2L3J2r0tkPDHceJUH73I3GZCHv1SR26UxvLL5S4iLm2KzbNiV
         KkWShn6Q7d3cpuGc2UTHAGr56BDWsUSYuZPEQ9R0Ry/Iaj06zTLbK6m+Ki69esaHtGF0
         j3JQ==
X-Gm-Message-State: AOAM531Gamaj/5RLz75KH9zhejk8i14m5l5uc0Xjj3/3VSa0kpAVrAPt
        UVk6fFCwokg9w+FqXrssP6g7oKDD8wsKORJ/OKV1Lw==
X-Google-Smtp-Source: ABdhPJzFvL6nErM3soIDJLjgaoUiL8QWvYjB63p3eOVAaiDWZwdZorNdm+S4sLm3ReMhkrjp8/WuExFuCR1PoiRprhU=
X-Received: by 2002:a05:6870:5829:b0:c8:9f42:f919 with SMTP id
 r41-20020a056870582900b000c89f42f919mr4194397oap.54.1645238796075; Fri, 18
 Feb 2022 18:46:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Feb 2022 18:46:35 -0800
MIME-Version: 1.0
In-Reply-To: <09b00fe9-1770-1723-3c4c-6c494da87e8d@linaro.org>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com>
 <1644851994-22732-8-git-send-email-quic_srivasam@quicinc.com>
 <a209336a-9108-f1ac-ee6d-a838df115c6d@linaro.org> <b663f63f-4a5a-3a2a-9be7-fa7258ce93c5@quicinc.com>
 <09b00fe9-1770-1723-3c4c-6c494da87e8d@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 18 Feb 2022 18:46:35 -0800
Message-ID: <CAE-0n5009g2WwnTsmUeKs5jgrnrUf21SgEL1s65C3FL+HJefkQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] pinctrl: qcom: Update clock voting as optional
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        quic_plai@quicinc.com, robh+dt@kernel.org, rohitkr@codeaurora.org,
        tiwai@suse.com
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivas Kandagatla (2022-02-16 07:38:02)
>
>
> On 16/02/2022 14:41, Srinivasa Rao Mandadapu wrote:
> >
> > On 2/16/2022 7:50 PM, Srinivas Kandagatla wrote:
> > Thanks for Your Time Srini!!!
> >>
> >> On 14/02/2022 15:19, Srinivasa Rao Mandadapu wrote:
> >>> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> >>> b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> >>> index 5bf30d97..4277e31 100644
> >>> --- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> >>> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
> >>> @@ -143,6 +143,7 @@ static const struct lpi_pinctrl_variant_data
> >>> sc7280_lpi_data =3D {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ngroups =3D ARRAY_SIZE(sc7280_groups)=
,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .functions =3D sc7280_functions,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .nfunctions =3D ARRAY_SIZE(sc7280_func=
tions),
> >>> +=C2=A0=C2=A0=C2=A0 .is_clk_optional =3D 1,
> >>
> >> This is forcefully set assuming that sc7280 is always used in ADSP
> >> bypass mode. Which is not correct.
> >>
> >> Can't you use devm_clk_bulk_get_optional instead?
> >
> > Yes. Agreed. Initially used devm_clk_bulk_get_optional, but Bjorn
> > suggested for conditional check instead of optional.
> >
> > Again Shall we go for optional clock voting?
>
> That means that the condition has to be dynamic based on the platform
> using DSP or not. Which is impossible to deduce without some help from DT=
.
>
> I would prefer to stay with optional clock unless Bjorn has some strong
> objection on not using int.

I think we need the combination of optional API and bool flag. My
understanding is it's optional on sc7280, but not on the previous
revision, so we want to be very strict on previous revision and less
strict on sc7280. Hence the flag. Maybe we should change it to
clk_required and then assume optional going forward. Then the callsite
can use one or the other API?
