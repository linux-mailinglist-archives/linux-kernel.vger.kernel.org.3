Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2DE583245
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbiG0SoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiG0SoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:44:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12BA11E5BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:40:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o13so7439699edc.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fvcBspaXwtQ8UlPkEV+dRJPq7S+l9Y7n+jrnxZWjDBc=;
        b=W7zYwejzKcjmsfHqUm2v6YWHlBkLZ0/XcurfEMRBRJD2c+2wA28gDiDH+tAOWeqUBX
         LzeXW/PMHjUupnWeQe8NAwDszG8t3skLjD689OPl68wBRdro/GMMdLV4l7xkDl2yMIxZ
         zcIDGOaVUzMZbXZFOIIqveayAbIJ8CgSdQ18s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fvcBspaXwtQ8UlPkEV+dRJPq7S+l9Y7n+jrnxZWjDBc=;
        b=jY+tzJEEpbc3jeTzBBiChNkG642NaxxuTGZ89E67EAiaWIBMoQO92XTiXp4QkypViV
         6aTiFijuZInRj7zjNFms8eT7N4otm8LUE1M7gqPorMnZLtj2jUu43y5chLqLWEY+Pe0q
         wsxBIKiaLQEtUDf9kv+BJXDmOuVNiRfiWNWrhT9evWHfdC0dlH29KcsKrVHOIJHsxycw
         S6r0DWVpzNDm98Cp5lW1e5LeZQ9xh8jdaRfuRF/wPjO3K9F5s+VCOAdzLhVENzo4C/M/
         vhxdlh84YlC0vZG/939K1T58jhNs5HmB3DwDelgnulk+jwy94wPqNQFxb4ofHTMwGVCZ
         i6tA==
X-Gm-Message-State: AJIora9fm/MU9MAqFOkQOfgEDJzrnrAwpBdjYuwC3I4CCSZBHIKyPx8U
        gt4wG+P+iCDmJSySMB0Tx62c3zQDyhfOW8OK4qM=
X-Google-Smtp-Source: AGRyM1tr2bnRXGCChd+C2x2o7RPj5yp0gmeStE1n82QufEqy+OBKt0mYQoPKmVfXitbk6zhVCjb34w==
X-Received: by 2002:a05:6402:11cb:b0:43c:c7a3:ff86 with SMTP id j11-20020a05640211cb00b0043cc7a3ff86mr2539002edw.383.1658943642627;
        Wed, 27 Jul 2022 10:40:42 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id y19-20020aa7d513000000b0043a7293a03dsm10580045edq.7.2022.07.27.10.40.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 10:40:40 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id h8so25506061wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:40:39 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr15255140wrr.617.1658943639429; Wed, 27
 Jul 2022 10:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220726212354.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
 <20220727160320.GA2755147-robh@kernel.org>
In-Reply-To: <20220727160320.GA2755147-robh@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Jul 2022 10:40:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U8ek0FR=hZwemK5JcbUP=JsnRTtv7WzJKmOb-UFwHfXA@mail.gmail.com>
Message-ID: <CAD=FV=U8ek0FR=hZwemK5JcbUP=JsnRTtv7WzJKmOb-UFwHfXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document zoglin board
To:     Rob Herring <robh@kernel.org>
Cc:     Bob Moragues <moragues@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
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

On Wed, Jul 27, 2022 at 9:03 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jul 26, 2022 at 09:24:31PM -0700, Bob Moragues wrote:
> > Zoglin is a Hoglin Chromebook with SPI Flash reduced from 64MB to 8MB.
> > Zoglin is identical to Hoglin except for the SPI Flash.
> > The actual SPI Flash is dynamically probed at and not specified in DTS.
> >
> > Signed-off-by: Bob Moragues <moragues@chromium.org>
> >
> > Signed-off-by: Bob Moragues <moragues@google.com>
> > ---
> >
> >  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> > index 581485392404..63091df3cbb3 100644
> > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > @@ -475,6 +475,7 @@ properties:
> >
> >        - description: Qualcomm Technologies, Inc. sc7280 CRD platform (newest rev)
> >          items:
> > +          - const: google,zoglin
> >            - const: google,hoglin
> >            - const: qcom,sc7280
>
> Is just "google,hoglin", "qcom,sc7280" no longer valid? If it is valid,
> you need another entry.

If it makes people happy to have another entry then it wouldn't hurt,
but it has no long term benefit and I would recommend against it. The
next patch in this series changes the existing "hoglin" device tree to
have all 3 compatible strings and thus when both patches land then
make dtbs_check will pass. I assume that is the only goal of
documenting these boards here. Certainly if you had a device tree that
had only "google,zoglin" it would boot fine on zoglin devices and if
you had a device tree that had only "google,hoglin" it would boot fine
on hoglin device. This is true of all of the entries for Chromebooks
that have multiple compatible entries.

-Doug
