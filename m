Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7414B2DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352998AbiBKTsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:48:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244171AbiBKTsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:48:19 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AFD2A0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:48:16 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k41so4945549wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=juTeh7Pj90KLSN4yGW9MUvSWd5K4ZGezg8meChmllJM=;
        b=p2lbra2wVZWj/aHaZPHIqpQTjCq8ADCTKLacm7/mJcjw0XVpPj1tfMaXyKZq0OKBF9
         G2+oiZlPgwYGQ7qDX37e2rY+Hx+zmVLE5yjEULvC3SRlO2gWL3a9Q/cVTW/BAintjBvr
         xfpZOJ0KIRKc0l3Z/wqqpycd9cefOtaoM9nPvC3sLeZyABvxTo00k1ZVaS/65pgLX+ux
         7gV7Zo/84KYowLY6RpwlduRc2VKPdU5T/OpsabIv2mHSID67mFJJJkfyf2DsudwQMtA1
         QdbivyByiKN4KwBsg/IAYGEcn6MPBoQ5JbmXsVo1gR0i9kEMuE6cP+8nJ8TmZWvczbob
         XqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=juTeh7Pj90KLSN4yGW9MUvSWd5K4ZGezg8meChmllJM=;
        b=vyrDCZkxpwnsTt/l6gzeKbgQ8YcJgLrcZ8HgpjaV6xkbQbck1ye4yKQSRWG9aN6SD5
         kOmLGpBOcMmUPQSaUeBLSzXxVLT5sNq9L+kO2QpkzlIFhLn3jpSZVGZzQI3fRHUOeUIe
         xB2LH8gdp0wdkZZ3Xyb8/mIGsOlyOadoZwIrrv6q+OZuPcmapz9WtsL+pxOVAxSf0WuF
         TBruifxUapHFZGgWopTcAqpdB/40PFelUZxu6p/whaWQOGH/QCO0w+09o0tmxK4yh2Zb
         9euaav37o0f/hUhAeVXUGzFfHD2AUQE4kvVQwpkSMks5pCAx2modqPTi45qRtUYMHcZx
         HawQ==
X-Gm-Message-State: AOAM531teKVRzfK/YvIbASJ0rcAG4Os2ejiw3Rm8jAIO2xGCcYxWIKGr
        836yscfYW2h4Q1wBQFo2ag4mzQ==
X-Google-Smtp-Source: ABdhPJwm4fSf5P60cAv4b4rom2weLwFPNsnAL5uORWpD8q0HuZ07dx4i7uD5lDxTuzkeJC2w/piyVQ==
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr1552313wmj.109.1644608895139;
        Fri, 11 Feb 2022 11:48:15 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id j15sm104487wmq.6.2022.02.11.11.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 11:48:14 -0800 (PST)
Date:   Fri, 11 Feb 2022 20:48:07 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     davem@davemloft.net, heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] dt-bindings: crypto: convert rockchip-crypto to yaml
Message-ID: <Yga9d5C2f1ubOok8@Red>
References: <20220211115925.3382735-1-clabbe@baylibre.com>
 <dba5684a-1e5f-a4d4-604b-651751636cf3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dba5684a-1e5f-a4d4-604b-651751636cf3@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Feb 11, 2022 at 02:13:00PM +0100, Johan Jonker a écrit :
> 
> 
> On 2/11/22 12:59, Corentin Labbe wrote:
> > Convert rockchip-crypto to yaml
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> > Changes since v1:
> > - fixed example
> > - renamed to a new name
> > - fixed some maxItems
> > 
> > Change since v2:
> > - Fixed maintainers section
> > 
> >  .../crypto/rockchip,rk3288-crypto.yaml        | 66 +++++++++++++++++++
> >  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
> >  2 files changed, 66 insertions(+), 28 deletions(-)
> 
> >  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> 
> There's more possible to this document:
> 
> dt-bindings: crypto: rockchip: add support for px30
> https://github.com/rockchip-linux/kernel/commit/3655df1bc6114bda2a6417f39772a3cb008084ea
> 
> crypto: rockchip - add px30 crypto aes/des support
> https://github.com/rockchip-linux/kernel/commit/ee082ae4f609f3b48f768420b31d8600448bd35a
> 

Hello

The great advantage of out of tree code is that we can ignore it.
Anyway, if one day this code goes upstream, I think the new compatible should be in a new driver/module, both v1 and v2 are too different for me to be shared in the same driver.

But before upstreaming this code, the one in mainline should be fixed first, it fail self tests. (I have some patch partialy fixing it in progress)

Regards
