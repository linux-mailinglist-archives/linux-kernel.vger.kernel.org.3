Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A395256966B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbiGFXlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbiGFXlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:41:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F72CDF4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:41:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r21so830414eju.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xSETzouKg/rOxXWWzl1JwOt0BuNPakzEaOoj6a2GoLI=;
        b=IxBqK5tmc7tpVhb7wmWPyrj0hlivFlyKIYSCqREINUK8iTsa7zWRJhaslDLxs2uoNw
         JxRJN6oAY+Sqr8U7Vun8GgpL6l9X7v3p/fbPzYKnSBLmakeWsndk6lzcxanwF6nNkDUM
         XuqXjIqH5DE60sp8jfIobG3ZRDjsRgc6TBUlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xSETzouKg/rOxXWWzl1JwOt0BuNPakzEaOoj6a2GoLI=;
        b=QeaV0jtzE6aGcfvKxr0wD1GgAihCtsGwxgYAe5ZnLXLsOwMdyAgqCaLMGDweub5nO+
         IfD9dH7QBgx9N6F07EBAJdzmpfqvVEum9F31qslh+E8KTFlOaUIa4KY+QOgRP8vGYyF2
         kg7K4wpqkjHTbZwAu1vKxxJpYMXe0WIWoy8Y+B1MWbBx6sVeDI1JmU6xD1gQO+bV+flK
         3VUwOai1wFsc6v+ZX0+9JaN/gl6qZ1nbAqiOxP6aShzFT4uk0MgkzgQuIKMuLVyCiOmI
         fk2BOG/ocsPMhP0+JIMvy0UeijKICtgS2ORM6gj7UUXT/XxhDFgYDLWTpGZlxuegwwYr
         MHAQ==
X-Gm-Message-State: AJIora/rNYvPde2fb3kukoMBmTUhY2ol58GB6KcM6xA1MbLGzyt1eF1G
        9JmOmwu3Aa4B+k5MA+toum6pYFqGF8wl14/NOBU=
X-Google-Smtp-Source: AGRyM1tDcdIJT/k855+XW1Urk/ov8LKJqg5qPMNvcIO3Cpk6mV3Uc+8IDnC9jwf1+Rp+AD3XXElPEw==
X-Received: by 2002:a17:907:2cf6:b0:72a:5268:c05e with SMTP id hz22-20020a1709072cf600b0072a5268c05emr38105775ejc.38.1657150870986;
        Wed, 06 Jul 2022 16:41:10 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id t17-20020a1709067c1100b00711d5baae0esm18249595ejo.145.2022.07.06.16.41.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 16:41:08 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so9773650wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:41:07 -0700 (PDT)
X-Received: by 2002:a05:600c:2049:b0:3a0:536b:c01b with SMTP id
 p9-20020a05600c204900b003a0536bc01bmr1115145wmg.151.1657150867195; Wed, 06
 Jul 2022 16:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <cfc2c27a-444d-8bd8-84a7-b6b1f99258f9@linaro.org>
 <SG2PR03MB5006AB4C7E356CE321F628D9CC809@SG2PR03MB5006.apcprd03.prod.outlook.com>
 <8f9651b2-ca9a-413c-d94f-9ecf3717343c@linaro.org>
In-Reply-To: <8f9651b2-ca9a-413c-d94f-9ecf3717343c@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Jul 2022 16:40:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WtKRFQr5jSQvsr08x9dgHrvenUWWtX_SKuCLuSvSH7WQ@mail.gmail.com>
Message-ID: <CAD=FV=WtKRFQr5jSQvsr08x9dgHrvenUWWtX_SKuCLuSvSH7WQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [V1,1/2] arm64: dts: qcom: Add LTE SKUs for
 sc7280-villager family
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jimmy Chen <jinghung.chen3@hotmail.com>,
        Andy Gross <agross@kernel.org>,
        alan-huang@quanta.corp-partner.google.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jul 6, 2022 at 3:04 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/07/2022 11:36, Jimmy Chen wrote:
> > To keep the consistency of the format for Chromebook items,
> > we basically add these items based on the rules discussed in the previo=
us patch series here
> > https://lore.kernel.org/all/20220520143502.v4.1.I71e42c6174f1cec17da302=
4c9f73ba373263b9b6@changeid/.
> >
> > We are little configured with =E2=80=9Cone entry - one enum =E2=80=9C. =
Do you mean something like below example?
> > We suggest keep items separated as it is more readable.
> >
> >       - description: Google Villager
> >         items:
> >           - const: google,villager-rev0
> >           - const: google,villager
> >           - const: google,villager-rev0-sku0
> >           - const: google,villager-sku0
> >           - const: qcom,sc7280
> >
>
> Is this a reply to something we discussed? There is no quote here, but I
> remember pointing out some issues with one of Google patches recently.
> Unfortunately my mailbox receives like 300 mails per day, so this does
> not help...

Jimmy did add a link to the series where the previous discussion was
in his reply, though he provided a link to patch #1 in the series and
not patch #4 (where the discussion was).

Relevant links:

* You saying you liked the enum [1].
* Me saying I liked them separate and that switching from a
"description" to a comment was opposite of what Stephen had previous
voted for [2], but could change if there was overwhelming need to make
them an enum.
* Rob saying he prefers an enum but lets sub-arch maintainers decide [3].
* Bjorn (the sub-arch maintainer) landing the patch without the enum [4].

[1] https://lore.kernel.org/r/a2bcac04-23ad-d1ae-84f1-924c4dbad42b@linaro.o=
rg/
[2] https://lore.kernel.org/r/CAD=3DFV=3DWgYbD9GN_wiR29ikZMzEjKUSZGH588+nny=
d3O-dNgChQ@mail.gmail.com/
[3] https://lore.kernel.org/r/20220601232614.GA504337-robh@kernel.org/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?=
h=3Dfor-next&id=3D5069fe941f76c9f37abc98636a7db33a5ac72840

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
