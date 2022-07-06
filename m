Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFED156936C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiGFUi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiGFUi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:38:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F936222;
        Wed,  6 Jul 2022 13:38:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m16so5219583edb.11;
        Wed, 06 Jul 2022 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=lzj4BKwrft3c5BU1ClV/hDkBP+dSx6Tr19/Gf1TGgU8=;
        b=icUqwG/0vVMdN/r6A7nm84dsxBrS9omrMTkearHOYkfRh2YcCP+LSvH3sNtu1cITM5
         4Yip53urCrq5u5wYXEfwsotwx1POpz/E/HDg1prnbAIpVB3JdwtPCPgBkxWXF/FH3EM0
         MKNdUISvpeRNG8WWsab8WUqvpPE7awWI4urkqUL2QOsaodKt0fMiSCMf8dNvLSmN6HTu
         dFL96bf7rzTCUS0nFpEmxjr+bp85gv0il6HIoS/55tkd4rBffUnNbQx7Bw3qUXhajKRH
         32p5c/Fb44Cu84NGIPdtFKnmw/RpFRMDD/cIoqpY/h05fWXg8wGxv75uGYyz2QooEwuF
         IfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=lzj4BKwrft3c5BU1ClV/hDkBP+dSx6Tr19/Gf1TGgU8=;
        b=Nx+9xPwaDJT3yyFVtz9SJmOBTed34PNwfxeSsZTQ3AuD7Xy1I9eO0ppe+WmnLzTEgy
         B5MLXrQfwXXdPWyjMLEXQnngxE2LYDSRwo//4TP7Um+xN5rzmi4V7KG8XhASLLrW5tG+
         buIABSpZE2NEA9vgoqT953S6pS675Vi/O8R3A5GaBi5BpKUXKCu50NB6Mn9fH1tQfpfO
         fYzH3lK1VEUOxZHMhr496VeZ8Af901eG7B4aN7syvtADzTsEqyDrp/8Nc+R8Ee9awWWl
         By2M3AumC5CIlecG7nachGEOTKx5AGQQqQlkjuI2PkylgwJHj9CUVFL95WercrikUzt+
         wCPA==
X-Gm-Message-State: AJIora9lEwJCBJYfTYrfiwVOc4XFIqNzhis5rPGDpBdIK6o0wb0khVCa
        jUDr8ENkI+zJLWjLyo3BuEpGWhs+0xY=
X-Google-Smtp-Source: AGRyM1uxDOb+Rm2+yptTJ52Ii4vEGGlQQ09xk5evqcRzCdX/oTW0/44spaHEX9PSIRJGt976ptsJZw==
X-Received: by 2002:a05:6402:11cd:b0:439:5cd:1ab7 with SMTP id j13-20020a05640211cd00b0043905cd1ab7mr50402275edw.394.1657139900782;
        Wed, 06 Jul 2022 13:38:20 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id ew6-20020a056402538600b0043a6dc3c4b0sm6495538edb.41.2022.07.06.13.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 13:38:20 -0700 (PDT)
Message-ID: <62c5f2bc.1c69fb81.90a5.aec9@mx.google.com>
X-Google-Original-Message-ID: <YsXyulhxHhaYOqtN@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 22:38:18 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] ARM: DTS: qcom: fix dtbs_check warning with new
 rpmcc clocks
References: <20220705202837.667-1-ansuelsmth@gmail.com>
 <20220705202837.667-3-ansuelsmth@gmail.com>
 <18e40247-7151-b50a-97fe-00ee88f47d9b@linaro.org>
 <62c565dc.1c69fb81.a4566.e9b2@mx.google.com>
 <bcb64218-2d2b-2f6b-dc79-303bac8c3bd3@linaro.org>
 <62c5de27.1c69fb81.c73fe.02c5@mx.google.com>
 <e1fed734-8629-5bf2-60ba-ee62243def6f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1fed734-8629-5bf2-60ba-ee62243def6f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:09:05PM +0200, Krzysztof Kozlowski wrote:
> On 06/07/2022 21:10, Christian Marangi wrote:
> > On Wed, Jul 06, 2022 at 05:07:12PM +0200, Krzysztof Kozlowski wrote:
> >> On 06/07/2022 12:20, Christian Marangi wrote:
> >>> On Wed, Jul 06, 2022 at 09:44:04AM +0200, Krzysztof Kozlowski wrote:
> >>>> On 05/07/2022 22:28, Christian Marangi wrote:
> >>>>> Fix dtbs_check warning for new rpmcc Documentation changes and add the
> >>>>> required clocks.
> >>>>
> >>>> There is no warning in the kernel, right? So the commit is not correct.
> >>>>
> >>>
> >>> Oh ok, the warning is generated by the new Documentation.
> >>
> >> Patches, especially DTS, might go via different trees, so the moment DTS
> >> is applied there might be no such warning.
> >>
> > 
> > I'm still confused about this topic...
> > With this kind of change, I notice I sent Documentation change and then
> > rob bot complain about dtbs_check having warning...
> > 
> > So the correct way is to send Documentation change and fix dtbs_check
> > warning in the same commit OR keep what I'm doing with sending
> > Documentation changes and fix DTS in a separate commit?
> 
> Binding is almost always separate from DTS and always separate from
> driver. The order depends on what you're doing. If you bring ABI break
> change to bindings, then the order does not matter, because each order
> will be non-bisectable. Because you broke ABI. That's the case in this
> patchset.
> 
> For other cases, usually bindings patches should be the first in patchset.
> 
> How it goes via maintainer trees is not your problem here. Patches might
> go together or might go separate.
> 
> Anyway it was not the topic of my comment. Comment was about not
> specific commit msg which does not fit the Linux kernel process and does
> not fit git history once applied by maintainer. It fits even less when
> backported to stable kernels, which you commit msg encourages to do.
>

It was a more generic question so sorry for the OT.

Will reword the commit description, thanks again for the clarification
about this generic topic.

-- 
	Ansuel
