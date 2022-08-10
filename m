Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FD958F2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiHJTNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiHJTNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:13:15 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C980F1EAC2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:13:13 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-10e615a36b0so18945232fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=KuLf+etUhT8CcgIrZoHXO32gzepZ3ln/4TrZlz8orFg=;
        b=u5lEkBau5ums583shjRAJhrdbIjintCen6qFp4XH5imxJ+M8xX8H8MQ+5NIMhZBZ8i
         IeQN/5+ZiBbLVpnL/7xXFhH7xRoUbK0KetOMetUjHenIqQkyw54DJsvuA3z98GvAE9iH
         G0VEdnytyPseQBthMahRq+EFibRw4CB+uK4VWF72mRoXGJmV4vNdWD3JHmHRxpP+ACle
         6b5GLgxfxjOnvDTUikGtWEhDDGi4TAD5fObpvDyF1/LQLrBR1CHMddWmVd63y1I5VcnA
         WpkvX8puvnJPaELZz8V9QCipettf+POKSz9BDONtQo43feT+1fWaBJCaVwgM9SGBxHe2
         vcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=KuLf+etUhT8CcgIrZoHXO32gzepZ3ln/4TrZlz8orFg=;
        b=jVan51AK38NPGNJgKMp+L8AgAl1E6DS04tgilLkQCUR5DEIzQ+MCI65KLyz90gsCx/
         n1fQ6ml7Abomm4DdKQMBnFGk+89smr6htHLXjVR5ZaZvItP+XiRcLZ7OfBFoPh9t6Lna
         f+pW6596zz0f8AIt1EP/A30bCEvRWTM+o6TsrsbHvme+UxDuEg291aHj0iSObLRfy56u
         CyYY1CnSlP4ic9A/KoLJwcUeAPXRRSW5ERyrLkOd49Tn/z8nQyW5HMdI9l5UPmaS8Mzo
         kJa2RMl0qmX6awEr0IWcqrp54aM9sDUL+OPqPPDUgc8L6XUyKhxkpym4ocoPR9otfFkE
         9Ssw==
X-Gm-Message-State: ACgBeo3yeZvkAHow9T7HhTe7y5XKB4FkLZ4bF7DSV107aIHZQbYEDQU2
        UQa9oVAG8+z23JVjRVkJDQ+eOw==
X-Google-Smtp-Source: AA6agR7Nri3uTxawS16Y0qws9GGPb++KL1oO57PREQCriDiGj2oEfmlndbYlomXZr8j21bdRn38m3Q==
X-Received: by 2002:a05:6870:e390:b0:10e:893b:f1d9 with SMTP id x16-20020a056870e39000b0010e893bf1d9mr2028913oad.88.1660158793139;
        Wed, 10 Aug 2022 12:13:13 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n15-20020a4ad12f000000b00425678b9c4bsm789575oor.0.2022.08.10.12.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 12:13:12 -0700 (PDT)
Date:   Wed, 10 Aug 2022 12:15:49 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] power: supply: Lenovo Yoga C630 EC
Message-ID: <YvQD5S8m6290EcEJ@ripper>
References: <20220810030500.2793882-1-bjorn.andersson@linaro.org>
 <b06adc0e-6e24-5419-4e6f-33ae2029b828@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06adc0e-6e24-5419-4e6f-33ae2029b828@kali.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09 Aug 21:04 PDT 2022, Steev Klimaszewski wrote:

> 
> On 8/9/22 10:04 PM, Bjorn Andersson wrote:
> > This adds binding and driver for the Lenovo Yoga C630 Embedded Controller, to
> > provide battery information and DisplayPort support.
> > 
> > Bjorn Andersson (2):
> >    dt-bindings: power: supply: Add Lenovo Yoga C630 EC
> >    power: supply: Add Lenovo Yoga C630 EC driver
> > 
> >   .../power/supply/lenovo,yoga-c630-ec.yaml     |  88 +++
> >   drivers/power/supply/Kconfig                  |  11 +
> >   drivers/power/supply/Makefile                 |   1 +
> >   drivers/power/supply/yoga-c630-ec.c           | 547 ++++++++++++++++++
> >   4 files changed, 647 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/power/supply/lenovo,yoga-c630-ec.yaml
> >   create mode 100644 drivers/power/supply/yoga-c630-ec.c
> > 
> It will be so nice to drop the "some-battery" patches that I've been
> carrying in my kernel sources since 5.7 :D
> 

Not only that, this is the only patch I've been carrying ont op of
Torvalds' tree for a couple of releases now. As such, if this lands, I
expect to be able to run an unmodified v6.1 straight off on my laptop.

Regards,
Bjorn

> Tested-by: Steev Klimaszewski <steev@kali.org>
> 
