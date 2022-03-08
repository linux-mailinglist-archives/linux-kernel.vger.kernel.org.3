Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE4F4D20EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349828AbiCHTHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349841AbiCHTHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:07:50 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813C53E18
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:06:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso179350pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fKKD+3hXAeIEEWs0Yh0fwesV2YwX9bcSV9zNUsAN1go=;
        b=TiAz7VQN6cqOR+YCGQONQ1puu9/mIbyi+3VaF2Y+0BaZGeb5d0zwRpgV+wE8vfCZR2
         Pgq+thE1e9/4lXjLiLuSG2aKfs9V+qPTceSPGx1VZpZ/g/nRHQ1xsr06c/+SZh0uL6ZD
         l59TPYzzVMS9JLJRtFAh9Cax5j2QTPG0/KiPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fKKD+3hXAeIEEWs0Yh0fwesV2YwX9bcSV9zNUsAN1go=;
        b=W7imjT32npKJ0xmqWNJkBlQf0aagZAlawPFHhWvAvPhaLy7OOvUNzZ6IS/ZOLjZB1i
         GGVYUvnn4TCs1Mbpde1EtL0iRs9tvA82IltTITVHRdrf79naH97zYxYaw6IiS08hBMoV
         l8DKgIZNd2NcCp/Z3c/u+5qPkVSbQo6na/JNcDdKz+xCTi/0D6KkaasFCVOWBOfAGbB0
         6yQ4/Zgn5d46wvebGpGVS5vnszwWkjVOHTciDycaxDqThHyHfR42beqUlIW7ZMUgynAx
         x0ZEuIM3MmFJ5SzixvYZ7HWYmk6hzB+rkei3sw8afS0CxX74xUmOjo0IoLY6Hbtrg+9F
         bRMQ==
X-Gm-Message-State: AOAM533Um6kxc6NMeDkUnxCEvgDQzUeZuixe4UXpymQvEdNJIqyqQHXg
        6+K3NDpJ3FEHV9BkBWE73vsXmg==
X-Google-Smtp-Source: ABdhPJwSOD+gGbHatfnouDV590+C0yrq8QOnBDEG0WOdkHpfzRz+TxjH6jpl1Ho2oEWdFX5xJuG7yw==
X-Received: by 2002:a17:90a:aa8c:b0:1bf:5273:ba28 with SMTP id l12-20020a17090aaa8c00b001bf5273ba28mr6261331pjq.226.1646766412904;
        Tue, 08 Mar 2022 11:06:52 -0800 (PST)
Received: from google.com ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with ESMTPSA id x29-20020aa79a5d000000b004f0ef1822d3sm19910654pfj.128.2022.03.08.11.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:06:52 -0800 (PST)
Date:   Tue, 8 Mar 2022 11:06:49 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lin Huang <hl@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Derek Basehore <dbasehore@chromium.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 01/15] dt-bindings: devfreq: rk3399_dmc: Convert to
 YAML
Message-ID: <YiepSZXhmUZVwjKo@google.com>
References: <20220308000945.706701-1-briannorris@chromium.org>
 <20220307160918.v3.1.I875ab8f28c5155a7d2f103316191954d4b07ac13@changeid>
 <bf59a2bc-a708-27de-866a-346085dcee7d@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf59a2bc-a708-27de-866a-346085dcee7d@canonical.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 07:03:15PM +0100, Krzysztof Kozlowski wrote:
> On 08/03/2022 01:09, Brian Norris wrote:
 
> Apologies for jumping in late in discussion, but how about moving it to
> memory-controllers or interconnect directory? devfreq is Linux specific
> and DMC sounds a lot like dynamic memory controller.

Sure! Will do in v4.

> > 
> >  .../bindings/devfreq/rk3399_dmc.txt           | 212 -------------
> >  .../bindings/devfreq/rk3399_dmc.yaml          | 294 ++++++++++++++++++
> 
> file name:
> rockchip,rk3399-dmc.yaml

Ack.

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml

> > +  devfreq-events:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 1
> > +    maxItems: 1
> 
> Rob previously asked about max, but it seems it is only one phandle,
> right? Then the type - 'phandle'.

Sure! Don't know why I didn't notice that.

> > +  rockchip,ddr3_odt:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      When the DRAM type is DDR3, this parameter defines the DRAM side ODT
> > +      strength in ohms. Default value is 120.
> 
> Here and in all other places - instead of describing default value in
> description, just add "default: 120".

Yep. Most of these properties are actually deprecated in the end, but
doesn't hurt to use the facilities available.

> Best regards,
> Krzysztof

Thanks for the reviews! I'll roll them all into v4 shortly.

While I'm at it: I think I have Reviewed-by's for all the DT patches
(except this one). Given it also touches Rockchip device trees, maybe
this all needs to go through Heiko / linux-rockchip? Or if not, it'd be
nice if Heiko spoke up to tell the devfreq maintainers instead.

Regards,
Brian
