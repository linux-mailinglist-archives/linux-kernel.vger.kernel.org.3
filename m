Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8510F5A526D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiH2Q7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiH2Q7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:59:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9765B9A9BE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:59:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c2so8597811plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pNNDtWhRQjr1AbDSAN5+sxqnMgrurCAJQVg6nJa7vfw=;
        b=X1qDKkSS9TNEmj3bF7vdVkXX21PIwg6DSgGwldzYDeoH3mrqhKbD5dIiG/W/rE/c88
         hqD+dF0v7EStFR9p/AywuaafIIdLE67ZDf4RdqvUo5u9CrVs2bt2xR6MnsjQ66h/7QNv
         HQHEZQNcgqFKT6wlRymcQavXXBoN6H40vWOog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pNNDtWhRQjr1AbDSAN5+sxqnMgrurCAJQVg6nJa7vfw=;
        b=Dd9MzJ2rC8kAF62+S9kuq0hxAA2nyl0DfPnmxJV2XursVsS1dxxFtHcWEHl5zbfye/
         VYkSSRfHdeiqn2ugfn3+d52GJu0YLNfxWgkaaRhR4gXr9qPlYoY+EKJid1qIWs6PN6pF
         BmCvsVG9YDNzkbGiQkaE2YU/qWTEIR7ljtV0MWstxJSSu/eZbMi4GK0PQGWdFwXal8+b
         /TsIdLAmpWKesG3oQsUCPpCASroz8SsyHt5IFJyksM7uyKnMdrWUr2cdn960xshtOhBW
         eQ4aa1ZJ4V7zsCAf23wKRSMKaOgRZ04hiJlQP7UMpvbs2MNPBJxHA8HHjFubLDEAYpu8
         hMOg==
X-Gm-Message-State: ACgBeo2tyqIhZl87FyVhuUyJHlv97EbSC6HMSIkRLO9RsBS6SyjzfbVz
        BL2Ho0/aKEBM98YgJyfinMEF8SuaXP64rnuJ
X-Google-Smtp-Source: AA6agR5sfws+mCqY/K5lEnwq82XyHLdfD/bjbyZhdtjkJMjSkhiHXuzf/ICFICRCTas1JUIPZAOP2w==
X-Received: by 2002:a17:903:245:b0:16f:85be:f33b with SMTP id j5-20020a170903024500b0016f85bef33bmr17275867plh.96.1661792356817;
        Mon, 29 Aug 2022 09:59:16 -0700 (PDT)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com. [209.85.210.178])
        by smtp.gmail.com with ESMTPSA id nh16-20020a17090b365000b001fd8316db51sm3303267pjb.7.2022.08.29.09.59.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 09:59:16 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id x19so6914556pfr.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:59:16 -0700 (PDT)
X-Received: by 2002:a05:6e02:16ca:b0:2e9:c225:3f82 with SMTP id
 10-20020a056e0216ca00b002e9c2253f82mr10397435ilx.254.1661791913591; Mon, 29
 Aug 2022 09:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220825164205.4060647-1-dianders@chromium.org> <YwhwIX+Ib8epUYWS@hovoldconsulting.com>
In-Reply-To: <YwhwIX+Ib8epUYWS@hovoldconsulting.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Aug 2022 09:51:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XV2Tjuh+AfaQ3gdnBvy27okb2zgbQ6e+23KGBZo38Y7w@mail.gmail.com>
Message-ID: <CAD=FV=XV2Tjuh+AfaQ3gdnBvy27okb2zgbQ6e+23KGBZo38Y7w@mail.gmail.com>
Subject: Re: [PATCH 0/7] arm64: dts: qcom: Fix broken regulator spec on RPMH boards
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 26, 2022 at 12:02 AM Johan Hovold <johan@kernel.org> wrote:
>
> > Douglas Anderson (7):
> >   arm64: dts: qcom: sa8155p-adp: Specify which LDO modes are allowed
>
> >   arm64: dts: qcom: sa8295p-adp: Specify which LDO modes are allowed
> >   arm64: dts: qcom: sc8280xp-crd: Specify which LDO modes are allowed
>
> These two should be rebased on
>
>         https://lore.kernel.org/all/20220803121942.30236-1-johan+linaro@kernel.org/
>
> which disallows mode-switching for all but the UFS regulators (this
> series addresses the DP PHY LPM regression we've discussed elsewhere).
>
> >   arm64: dts: qcom: sc8280xp-thinkpad-x13s: Specify which LDO modes are
> >     allowed
>
> And this one should not be needed at all with the above series applied.
>
> >   arm64: dts: qcom: sm8150-xperia-kumano: Specify which LDO modes are
> >     allowed
> >   arm64: dts: qcom: sm8250-xperia-edo: Specify which LDO modes are
> >     allowed
> >   arm64: dts: qcom: sm8350-hdk: Specify which LDO modes are allowed

Thanks! v2 has been sent and it's rebased upon your series:

https://lore.kernel.org/r/20220829164952.2672848-1-dianders@chromium.org
