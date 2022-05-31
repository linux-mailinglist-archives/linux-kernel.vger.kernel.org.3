Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD20F53985F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347858AbiEaU5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbiEaU5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:57:38 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBE52180A;
        Tue, 31 May 2022 13:57:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v106so19017104ybi.0;
        Tue, 31 May 2022 13:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40PFJ0KLH49o2a7cmdjfg2UDZMZZdNplRaKSZa0P70Q=;
        b=LBlxs6gYEgXpIHzbh/d2m73G/hVo58iw9hM6LSB/n8UZVrLtWmWJcf/Kcknu7MJ9vm
         VSem7YSJt0MJpSwq27DrpYfJs87MeGMiD8s1bGVpRcg7ChM/HxOIEmrCouq8t3T4GkLy
         qRPBLVQk+Y8Nmh9lcPFusObbG7vzv07rFgyazbunNxfOYZ7ZpCAgsycDEnDP/TYzMZc2
         0Y04REpfMJ1rBdirpsJZ8obMwZJXp67ko/TkIn/YxOaZhlzPR+TRulxC0Iv6bpR4301M
         mGEp2JR8EDIg7LqW/OzT3eyNzutKNAZBp+VUQuOepprYS6fQLo+ZjaO4z/MDjkqkqLyT
         B8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40PFJ0KLH49o2a7cmdjfg2UDZMZZdNplRaKSZa0P70Q=;
        b=6r6C2y3MWbMvJKlaf90OdMXdv2GmSGLZR7dfQrGgdCT0Ha1mLZ0XKE2fxiOAThbxFQ
         xk+D/pGsX/REw1tREJirpL+g6+bIlFLCzVHvYdCONLcjIZ4Sbwgu19OCScA8c1kHixaD
         TrjBJe3GcXUDNJM8lgjXtA/P3hi8cDoldqR743Uu7VFfV9sTkQkq9rqp1k1datbN6ZdZ
         mVD8nXxUymQLWSD+U974Z9NDW1Gf6P7EYD6MvhdV7RfUztrW52NIrCihb62/ca+D7rRz
         b0a1KcodqEw87GfQ+eyR9/07MfqRHx4jvTLW79PwSfAT62XQ8icpxqf4+IDfZiNmG5PX
         DZ9A==
X-Gm-Message-State: AOAM530Mik3Mcm17ivFExQLWYike46z92Go5JSgDpm9RLHmNUJ2X5++m
        YmIfprikvWQDuNVoumkC2WCXSH8B68y9lmSaYuMSRZ5J
X-Google-Smtp-Source: ABdhPJzQE7CiGqybeME8r7CuvSaMGGUpdihIcHV4tk3SkMKBdECTjWnhek2dsW+WK3DiuQFC0Ll3kcDD08GIokCy2FA=
X-Received: by 2002:a05:6902:1003:b0:64f:2e69:c97d with SMTP id
 w3-20020a056902100300b0064f2e69c97dmr59688647ybt.605.1654030656439; Tue, 31
 May 2022 13:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-2-konrad.dybcio@somainline.org> <20220531154631.GA25502@willie-the-truck>
 <CAF6AEGsWsHfQZnszG=NgP0BufxO-DP4LwvsAYkrz2wRhcJuOXw@mail.gmail.com> <20220531161910.GE25502@willie-the-truck>
In-Reply-To: <20220531161910.GE25502@willie-the-truck>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 31 May 2022 13:57:37 -0700
Message-ID: <CAF6AEGvF+5mf6jE9Xac1qR9P+-=ELLu_LzoJhUV-Dx2RYH20Ag@mail.gmail.com>
Subject: Re: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if specified
To:     Will Deacon <will@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Martin Botka <martin.botka@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        jamipkettunen@somainline.org, Andy Gross <agross@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 9:19 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, May 31, 2022 at 09:15:22AM -0700, Rob Clark wrote:
> > On Tue, May 31, 2022 at 8:46 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Fri, May 27, 2022 at 11:28:56PM +0200, Konrad Dybcio wrote:
> > > > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > >
> > > > As specified in this driver, the context banks are 0x1000 apart.
> > > > Problem is that sometimes the context number (our asid) does not
> > > > match this logic and we end up using the wrong one: this starts
> > > > being a problem in the case that we need to send TZ commands
> > > > to do anything on a specific context.
> > >
> > > I don't understand this. The ASID is a software construct, so it shouldn't
> > > matter what we use. If it does matter, then please can you explain why? The
> > > fact that the context banks are 0x1000 apart seems unrelated.
> >
> > I think the connection is that mapping from ctx bank to ASID is 1:1
>
> But in what sense? How is the ASID used beyond a tag in the TLB? The commit
> message hints at "TZ commands" being a problem.
>
> I'm not doubting that this is needed to make the thing work, I just don't
> understand why.

(disclaimer, it has been quite a while since I've looked at the smmu
setup with earlier tz, ie. things that use qcom_iommu, but from
memory...)

We cannot actually assign the context banks ourselves, so in the dt
bindings the "ASID" is actually the context bank index.  I don't
remember exactly if this was a limitation of the tz interface, or
result of not being able to program the smmu's global registers
ourselves.

BR,
-R
