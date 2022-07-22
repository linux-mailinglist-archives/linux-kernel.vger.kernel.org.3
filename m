Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E66757E2E5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiGVOQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiGVOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:16:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A317A024B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:16:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id va17so8889704ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxeR7Lo5PYoDSgSUtAiC935tL0yHF6pLSDAauA9BG7w=;
        b=MR4DklGeYf0D/wYM8Tyks/4W15tt7jHZxpOHeWkrP8SiiLYJgMMJZeb9xKy35RcKBs
         K02sZymDAJh71V2xCJ/MwdvDF50YToUQ5aK/Gclm4R1CHh8YMaSpCriWuruPQwmdVmmO
         nAg3zgaWjMnm7XHZdvJjYWVs694bvxq+EB2rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxeR7Lo5PYoDSgSUtAiC935tL0yHF6pLSDAauA9BG7w=;
        b=KWDBaAInDO96OSC8cMSzHqXz3h4iHhotZJqrgZl6DrVlv1gY+iMnehGENkYzCdFhsJ
         nUzXRw2iQQZSBeg1LjkZK6uzB3nB5MBp9hvDeWKymbLzHazw7aGmBUUVqlwk7IGyYBRB
         520UXyBiwznjp1v5UVVSQWDVOePflp0/VZRf6s21iaBIrcheDcH2FY3fWER79cjNIMqg
         t2uT3mU/gCpo06rwN8g/0YIK2JnG+Tsxgu43ZWjAiuxKvDrq0OMEvIAfMpA2ckHlMPsS
         6AkipoIMgE7i/I+1o7yI9KP1jfdR5TO+w+5fRufzeVS7muxhWLQCBA3QHd9C8v+5wzaj
         xDLA==
X-Gm-Message-State: AJIora+7fjKVpSEK1XvffnOHYdWPcjpSbd9gJhVvt6REN9P28jv5gIr7
        AdV0KvD0QkkrJ1vdUCEPAKXmqkng/s5O0DCJqYA=
X-Google-Smtp-Source: AGRyM1sGLc89RtJrp1UHBwC31h3XluWoR29LOjYaqjjXEeQUJyRgImRBJciwbkcZM/xpqKV1t1dMGQ==
X-Received: by 2002:a17:907:a0c7:b0:72f:b204:c281 with SMTP id hw7-20020a170907a0c700b0072fb204c281mr104969ejc.720.1658499387230;
        Fri, 22 Jul 2022 07:16:27 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id fw9-20020a170907500900b0072aebed5937sm2009462ejc.221.2022.07.22.07.16.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 07:16:26 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id b26so6713015wrc.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:16:26 -0700 (PDT)
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id
 b13-20020adff90d000000b0020cde324d35mr76737wrr.583.1658499386136; Fri, 22 Jul
 2022 07:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220722081127.228971-1-jinghung.chen3@hotmail.com> <SG2PR03MB500658668FBB9BE1DC2B3F24CC909@SG2PR03MB5006.apcprd03.prod.outlook.com>
In-Reply-To: <SG2PR03MB500658668FBB9BE1DC2B3F24CC909@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Jul 2022 07:16:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WgzOn7EsGgWd-qkEMccBQQn1id1u_0Ph1V6qExfCEioA@mail.gmail.com>
Message-ID: <CAD=FV=WgzOn7EsGgWd-qkEMccBQQn1id1u_0Ph1V6qExfCEioA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: arm: qcom: document sc7280 and
 villager board
To:     Jimmy Chen <jinghung.chen3@hotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 22, 2022 at 1:11 AM Jimmy Chen <jinghung.chen3@hotmail.com> wrote:
>
> This adds a LTE skus for Chromebook Villager to the yaml.
>
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> -Add this patch
>
>  Documentation/devicetree/bindings/arm/qcom.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Please carry forward tags from previous versions unless you've done
something to justify removing them. From v6:

Acked-by: Rob Herring <robh@kernel.org>
