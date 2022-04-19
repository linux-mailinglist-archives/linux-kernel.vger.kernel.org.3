Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63004506974
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350911AbiDSLMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiDSLL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:11:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FBC2B1AF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:09:16 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m15-20020a7bca4f000000b0038fdc1394b1so1316196wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k9SQS6DEx7PcK3aZSt7NFnPshwNlUhuY2vj8QCcgdU8=;
        b=f8jTBzdCgR6gZoEBSlPxq90yrNFz+cJET9rvKb4SBbgJ3hbal36VvgdomSIglGgnO2
         3m52LyW2/NdxIy6Gtfurhq600ou6nWq7Vo8VlhKKUxdcfpzNbNSLAAfHScLAiqIPJnli
         D04SCxBNOYYZDuahNhtsJDUlWB5unMRdTrn/kJnFc31Ui5htITjZeD61zi+pb1l97IW/
         9L2Qo1bthVeE7l1MPTQDaeETEDSUvtMflBQ2dm1j4rDzIRWNfzKlW/Uw0sUAHMuob9pS
         l8EMODJrZvsH0VNyDN0nBwcr4Kae1lvAroCpPCxGh5764YFDnTKwa7A2Abu/qUz8uQLW
         /tNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k9SQS6DEx7PcK3aZSt7NFnPshwNlUhuY2vj8QCcgdU8=;
        b=EHDMi3YBnYudwcVLurLoTjlfMYyXlS20TNWTKGNpVvnGgX6MKDy8+lFj+gMoHKzYMg
         LojihT+qeC8uvp+juQ6CeJyldyeXpCxE6FaX8E0U6T4MOPVHXSrci59+XoOWZ1ohOk5n
         /hcDu7JzqqymTALEVCmRHY9LaZNyAiLijVRTo7txvKgPqBywhAaFqNTU4TnR62a6ym7A
         K2SP7EjJbZeSUXl5GYtYsuxde9k9wYSNtNz2xpN0TEYmndPp0djU6QT8RHMU3ch/iRkk
         RqTqUjUlkYYXR0QygRAs0BNeqWjmnP7lNkgOdNpthROz5de6xf2utVdU1K+w+vdu5G+N
         hBuQ==
X-Gm-Message-State: AOAM531uTo5mtkCha/uyPuOBcwVI8rktJGZ49G7/EQz+PKaR3z007dJq
        oOrd/PUkfnCXtpNE2JJyf9zMNQ==
X-Google-Smtp-Source: ABdhPJyom0pejQx9+muBJ4LXKjDgivoBsIZxgzm1mENjReqSKOE98rUgPTpWVyVn3NH52/xaRjs95g==
X-Received: by 2002:a05:600c:4f87:b0:392:9236:3c73 with SMTP id n7-20020a05600c4f8700b0039292363c73mr11110988wmq.158.1650366554533;
        Tue, 19 Apr 2022 04:09:14 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id 7-20020a05600c024700b0038ec0c4a2e7sm18549936wmj.11.2022.04.19.04.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:09:14 -0700 (PDT)
Date:   Tue, 19 Apr 2022 13:09:11 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 24/33] dt-bindings: crypto: convert rockchip-crypto to
 YAML
Message-ID: <Yl6YV9nLVI4qYsPP@Red>
References: <20220413190713.1427956-1-clabbe@baylibre.com>
 <20220413190713.1427956-25-clabbe@baylibre.com>
 <44efe8b6-1712-5b87-f030-2f1328533ee8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44efe8b6-1712-5b87-f030-2f1328533ee8@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Apr 13, 2022 at 09:31:13PM +0200, Krzysztof Kozlowski a écrit :
> On 13/04/2022 21:07, Corentin Labbe wrote:
> > Convert rockchip-crypto to YAML.
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - rockchip,rk3288-crypto
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 4
> > +
> > +  clock-names:
> > +    maxItems: 4
> 
> This is not needed and dt_bindings_check should complain.
> 
> > +    items:
> > +      const: aclk
> > +      const: hclk
> > +      const: sclk
> > +      const: apb_pclk
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  reset-names:
> > +    maxItems: 1
> 
> The same.
> 

I forgot to test the intermediate patch...
Before I send a new version, does the final document is okay ?
