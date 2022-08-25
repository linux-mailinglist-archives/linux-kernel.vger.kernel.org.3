Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043365A1BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 23:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244216AbiHYV7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 17:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbiHYV7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:59:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E71879A5C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:59:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id v14so5554573ejf.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZWZIyKcotrv3NEmO67KClX9EqNqs0MIDHUX0uHrtkjE=;
        b=g8/rsxUneSNTvyAX/My2MOeR5KSLY9Rg/6OmuA3mo6wuxVL4yZk8GRe4P42gRuSGYY
         5o/riDIc3W226S/XAgbuMlSnghvwTZQj9UIRcIL71AI+lwfaqe+0yd9ZMeDrBW+XReH0
         HeG7kNZkWgj06gz6aqBW2Pg4+wFveT436fTg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZWZIyKcotrv3NEmO67KClX9EqNqs0MIDHUX0uHrtkjE=;
        b=uUuZj+9wmHlqZuwlt0f2bsFEVS5EwW1ragrtiqMsUuJgoWDJjutXpJVOXb6tCy8dFt
         dxowOFNdhMIgt9qcYJ0JSx20Yu19LOVfpSK+CpKpbEW7WnVIKrNUq+Qmp6FFSaaKCtdK
         oli9ghW2qWQOJBTKTxLjw9M9yfTXBN4i510WGV9srZQbSnRU2s4+E1IPGzV1eVIWJTyr
         tVb1i2xxfVQuTMldnPDdzAbewGiIzxl31syaxvZDFD95jNnwNHgLA+ip3Y/RK3dr9kX6
         02TQ86hl4MkS/N+40++LxzoiQ9LCVwlcGjFba7iNpiVbiu3jTfxLZOARp1xUPk2ZLoQA
         SypA==
X-Gm-Message-State: ACgBeo2dvBzETFEKtn9IwKrB+zUJCsRVB0+XNqD73JYd19fCSQiW9Tb0
        pc4PtNhSyKijT+jIGOxDCAE4GfYgP+rI8chwRPE=
X-Google-Smtp-Source: AA6agR6Ch+dY+MGn4YKAfaZT735wSL031iVkMKEm/EtaRFqRCsCjrz2Cmo8u2bvqFny/6EX4XsqBXQ==
X-Received: by 2002:a17:907:b013:b0:73d:c708:3f22 with SMTP id fu19-20020a170907b01300b0073dc7083f22mr3541797ejc.608.1661464752628;
        Thu, 25 Aug 2022 14:59:12 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402180800b0043d5c9281a3sm287992edy.96.2022.08.25.14.59.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 14:59:11 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id r83-20020a1c4456000000b003a5cb389944so3420554wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 14:59:11 -0700 (PDT)
X-Received: by 2002:a05:600c:42c3:b0:3a6:431:91bf with SMTP id
 j3-20020a05600c42c300b003a6043191bfmr9014430wme.188.1661464751060; Thu, 25
 Aug 2022 14:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220825164205.4060647-1-dianders@chromium.org>
 <20220825094155.1.Id59c32b560c4662d8b3697de2bd494d08d654806@changeid> <20220825213053.5xxiljfjkhnpy53p@halaneylaptop>
In-Reply-To: <20220825213053.5xxiljfjkhnpy53p@halaneylaptop>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Aug 2022 14:58:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VPFvMoPvdYmdXAp+oEBDyNzuaTBNd=g4=+T=itiyVoAw@mail.gmail.com>
Message-ID: <CAD=FV=VPFvMoPvdYmdXAp+oEBDyNzuaTBNd=g4=+T=itiyVoAw@mail.gmail.com>
Subject: Re: [PATCH 1/7] arm64: dts: qcom: sa8155p-adp: Specify which LDO
 modes are allowed
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 25, 2022 at 2:31 PM Andrew Halaney <ahalaney@redhat.com> wrote:
>
> On Thu, Aug 25, 2022 at 09:41:59AM -0700, Douglas Anderson wrote:
> > This board uses RPMH, specifies "regulator-allow-set-load" for LDOs,
> > but doesn't specify any modes with "regulator-allowed-modes".
> >
> > Prior to commit efb0cb50c427 ("regulator: qcom-rpmh: Implement
> > get_optimum_mode(), not set_load()") the above meant that we were able
> > to set either LPM or HPM mode. After that commit (and fixes [1]) we'll
> > be stuck at the initial mode. Discussion of this has resulted in the
> > decision that the old dts files were wrong and should be fixed to
> > fully restore old functionality.
> >
> > Let's re-enable the old functionality by fixing the dts.
> >
> > [1] https://lore.kernel.org/r/20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid
> >
> > Fixes: 5b85e8f2225c ("arm64: dts: qcom: sa8155p-adp: Add base dts file")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> > index ba547ca9fc6b..ddb9cb182152 100644
> > --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> > +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> > @@ -43,7 +43,6 @@ vreg_s4a_1p8: smps4 {
> >
> >               regulator-always-on;
> >               regulator-boot-on;
> > -             regulator-allow-set-load;
>
> I could see this deserving its own commit or a line in the commit
> message, but not a big deal to me:
>
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

Ah right. I mentioned it in the cover letter but forgot to mention it
in this commit message.

I'll assume that this isn't a big deal but if Bjorn wants a quick spin
with this mentioned in the commit message (or broken into a separate
commit) then I can do so. I'll wait for direction before spinning,
though.

-Doug
