Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B15E531409
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbiEWQTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbiEWQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:19:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1F267D05
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:19:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id wh22so29771120ejb.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYw/iw5eqrvTTFbNpKOcnoOJ2Kv/wRzV7gaeDkDmyZQ=;
        b=KDH1oST/AiaJHfrLYMayk+iaWXCj9iTxFERlgdeUB03jl/+nfweM5fzOIq8/qjW08r
         3Fj9imjyG3zRV9STnTobKyogHyXmWveRTF4GF4xagV61AHpplVxFI5Y6xaMHgxAaykhW
         ws3hZc9n0E3Ro2t3IZkwttto2+eI3UteEWiaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYw/iw5eqrvTTFbNpKOcnoOJ2Kv/wRzV7gaeDkDmyZQ=;
        b=Qwr+Wq3p7s5lYL//kpYGFy/1Xr/Sin7CDPNkO40qS0QgeYOpUc/OVv7OYBIi1qJ3em
         DDI9/fdZEJwFvD5ru+T+3csY47sPvESbLYTssi4L3HX/9EauWEFxyU9+BhjKGOwlKbRV
         2NNvOR4LvV5H98Ux7PDXmAX8hrkkHRwn2Twe3rYCTiyvPJKLHlU+Ob56HkJg319DbsnZ
         KxW6oG+RPLp512YLHrHEqpu8PEHV/921z1kH+OXOkFyB5zTXcz7CFypNnq31Sbfyr3N9
         wBKz28mRWXXWbK+r/p7znjvTUBhlUCrGgRn9BQ6GerKVlvB05t5PO6NR1yR9p1ssrvAW
         E6pQ==
X-Gm-Message-State: AOAM531SKOig2nuwjamlToPQTCQ5e5FJYJbTUGCWnC69uCP4wlPgxrNU
        OCY8C12v8viL8sCv17kjWxVCSwnK8N3h6vJa
X-Google-Smtp-Source: ABdhPJxuHkZbeSp2gdtttvR9hql81s5ykp64PKQLJPQqmVtYj/ReTM8N5fvxeA8bLV+X2d5BrLdRPw==
X-Received: by 2002:a17:906:c14c:b0:6f4:6e30:9ace with SMTP id dp12-20020a170906c14c00b006f46e309acemr20105551ejc.678.1653322757542;
        Mon, 23 May 2022 09:19:17 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id my44-20020a1709065a6c00b006f3ef214de4sm5811289ejc.74.2022.05.23.09.19.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 09:19:17 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id k30so22099367wrd.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:19:16 -0700 (PDT)
X-Received: by 2002:a05:6000:1548:b0:20f:c4e3:637a with SMTP id
 8-20020a056000154800b0020fc4e3637amr10495998wry.513.1653322756477; Mon, 23
 May 2022 09:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220520143502.v4.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220520143502.v4.5.Ie8713bc0377672ed8dd71189e66fc0b77226fb85@changeid> <a2bcac04-23ad-d1ae-84f1-924c4dbad42b@linaro.org>
In-Reply-To: <a2bcac04-23ad-d1ae-84f1-924c4dbad42b@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 23 May 2022 09:19:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WgYbD9GN_wiR29ikZMzEjKUSZGH588+nnyd3O-dNgChQ@mail.gmail.com>
Message-ID: <CAD=FV=WgYbD9GN_wiR29ikZMzEjKUSZGH588+nnyd3O-dNgChQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] dt-bindings: arm: qcom: Add more sc7180 Chromebook
 board bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
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

On Sun, May 22, 2022 at 1:01 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/05/2022 23:38, Douglas Anderson wrote:
> > This adds board bindings for boards that are downstream but not quite
> > upstream yet.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Normally this bindings doc would go together in the same series that
> > adds the device trees. In this case, Joe has been sending patches
> > supporting these Chromebooks. His most recent posting is:
> >
> > https://lore.kernel.org/r/20220510154406.v5.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid/
> >
> > If he were to add this patch to the end of his v6, however, it would
> > make things a bit more complicated simply becuase it would cause
> > conflicts with all the other patches in this series. ...so steady
> > state it would be correct to keep it in the series with the device
> > tree files, but for this one time I think it makes sense to keep all
> > the Chromebook board bindings patches together.
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Use a "description" instead of a comment for each item.
> > - Use the marketing name instead of the code name where possible.
> >
> >  .../devicetree/bindings/arm/qcom.yaml         | 92 +++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> > index 3d150d1a93cd..277faf59db57 100644
> > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > @@ -263,6 +263,16 @@ properties:
> >            - const: google,homestar
> >            - const: qcom,sc7180
> >
> > +      - description: Google Kingoftown (rev0)
> > +        items:
> > +          - const: google,kingoftown-rev0
> > +          - const: qcom,sc7180
> > +
> > +      - description: Google Kingoftown (newest rev)
> > +        items:
> > +          - const: google,kingoftown
> > +          - const: qcom,sc7180
> > +
> >        - description: Acer Chromebook Spin 513 (rev0)
> >          items:
> >            - const: google,lazor-rev0
> > @@ -364,6 +374,48 @@ properties:
> >            - const: google,lazor-sku6
> >            - const: qcom,sc7180
> >
> > +      - description: Google Mrbland with AUO panel (rev0)
> > +        items:
> > +          - const: google,mrbland-rev0-sku0
> > +          - const: qcom,sc7180
> > +
> > +      - description: Google Mrbland with AUO panel (newest rev)
> > +        items:
> > +          - const: google,mrbland-sku1536
> > +          - const: qcom,sc7180
> > +
> > +      - description: Google Mrbland with BOE panel (rev0)
> > +        items:
> > +          - const: google,mrbland-rev0-sku16
>
> Similar question to patch #3, this could be:
>
>
> +      - description: Google Mrbland
> +        items:
> +          - enum:
> +              - google,mrbland-rev0-sku0     # AUO panel (rev0)
> +              - google,mrbland-rev0-sku16    # BOE panel (rev0)
> +          - const: qcom,sc7180
>
> and the file gets smaller and easier to read.

Ah, I guess this answers the question of the description that I asked
in the previous patch. Of course, this goes opposite of the feedback I
got from Stephen in previous versions of the patch where he requested
that I use "description" instead of comments for things. ;-)

In any case, for now I'll hold off waiting for other opinions here
since I still feel that the "one entry per dts" is easier to read /
reason about.

-Doug
