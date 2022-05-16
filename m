Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E381528855
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245116AbiEPPRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245072AbiEPPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:17:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB963BBCD
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:17:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so18782815ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jP1Z/t75Zd6+QfO0rBYQNP9W66P0QAZBvkxPxWMCEHY=;
        b=HzgnGElJcy8Kom4TATLPw1DcUEH44GqfdZxPziBJAjMYplYbhEaAxZbm4LdHD3D4/v
         hkCwqG4CD/WoFFMnuLnuuTvOxmSjctrf5dh2+OCPOpqZhPPBBbBGPYP3ORxEm3A66gsg
         h/CPTcnbxFRmyXJ8IzwezD1foSwtGz2VR8OrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jP1Z/t75Zd6+QfO0rBYQNP9W66P0QAZBvkxPxWMCEHY=;
        b=C3YcWBUPS6ZBfEp3CE5yleQLbRe20wsYyyRiHSTpXU3c8LXMwXiB3kInuzFS8fe6YC
         5JlSOwn/HyFgLxlTn8h48/NYAPODlwYTxkK3nPua1l+n8HmbA0S7kW9vdmbTA+u2TBjE
         +ajgZzY03Q0t2wkwFdUOc98ybLDQG+XgKhkeb2/GIBbZSt1bI9NPZXXV4XffGJWZc6fH
         7Toh++QQYUhQ5014EeZ5jLFqgbvVcdhmg5jf4TVW6rR6gQPg4GLK54SDgSXkCNpPFGTi
         fuLvSQOlDK17WCqn1b01J2UUm75MnXzMUlGgxRhoVkyduKcAPEmIzedhBk8ef9gcGbAm
         52dw==
X-Gm-Message-State: AOAM531FjAsMFNf0YxH3Jx1vQaSYaWsUFNtmrqqxcFkjH2olJZjNwr/0
        wn+LpJbPJTmU2eOXrQYcAG+dWIuHYwwHWRTiFdc=
X-Google-Smtp-Source: ABdhPJxV3V4COkGi0VWp/TQENRUMZpO6TdEFSaqbOLacCh98xpW4KIWUybn9np3MvrZP5wNZajtXrQ==
X-Received: by 2002:a05:6402:40cf:b0:427:cead:dca with SMTP id z15-20020a05640240cf00b00427cead0dcamr13925394edb.380.1652714226198;
        Mon, 16 May 2022 08:17:06 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id gx7-20020a1709068a4700b006f3ef214dc1sm19707ejc.39.2022.05.16.08.17.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 08:17:05 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id a5so17197084wrp.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:17:04 -0700 (PDT)
X-Received: by 2002:a5d:6d09:0:b0:20c:53a9:cc30 with SMTP id
 e9-20020a5d6d09000000b0020c53a9cc30mr14313656wrq.513.1652714224237; Mon, 16
 May 2022 08:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220513095722.v2.4.Ie8713bc0377672ed8dd71189e66fc0b77226fb85@changeid> <125970b0-af71-1695-a3ab-10a159ac63a5@linaro.org>
In-Reply-To: <125970b0-af71-1695-a3ab-10a159ac63a5@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 May 2022 08:16:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XR+WwWmrB1wGX65=szBc2PbGNOHbm2tiQT5Wp8CPG0Kg@mail.gmail.com>
Message-ID: <CAD=FV=XR+WwWmrB1wGX65=szBc2PbGNOHbm2tiQT5Wp8CPG0Kg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: arm: qcom: Add more sc7180 Chromebook
 board bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 16, 2022 at 12:05 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/05/2022 18:59, Douglas Anderson wrote:
> > This adds board bindings for boards that are downstream but not quite
> > upstream yet.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Use a "description" instead of a comment for each item.
> > - Use the marketing name instead of the code name where possible.
>
> These should be published with the patch adding their upstream DTS/DTSI.
> There is no point to list all possible boards in the world from any
> downstream source. For upstream there is no particular benefit for such
> bindings, for downstream you also said there is no.

Joe has been working on upstreaming these boards:

https://lore.kernel.org/r/20220510154406.v5.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid/

I think there is little chance that they won't go upstream at this
point. However, we're at a time in the merge window where it will be
several weeks before anything can land. If Joe were to include this
patch as part of his series I suspect it would be much more confusing
because it would add an unnecessary dependency between my series and
his and make it harder for Bjorn to apply it later. Keeping the patch
with my series means that the series can be applied more easily.

How about: I'll add a link to his latest posting in my next version.
Then, in the future (after these bindings patches have landed) then
future boards can go together with their bindings.

-DOug
