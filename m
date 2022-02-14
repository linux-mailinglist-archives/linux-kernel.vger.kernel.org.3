Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD774B52FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355047AbiBNORw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:17:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355049AbiBNORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:17:50 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EBE4A902
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:17:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j26so16273088wrb.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ln2uKU+vMAyRV7UsLvWBhWdQgf4eoy4B8mnlBh7Uf4U=;
        b=T3wz3eCfR4tmrh0J4vy9sCp8J/jWIy5urKk6OO+cbCvyUbRGqP+i7nWcAg+4+AFO56
         efMVlkNlLVf5dyJ55keCtaW5IeVN/wZa6mDMknpCo9YrruU3Na5DTtj/E64R8K+MyatB
         GaYPPqu0t+7A+Ly1FCB5CGYul82Nyi3QWjgLOqC1Wx3LNNuOiqq19axcbeRXvlJLtyIT
         wAbGVXVwM92TBH+Gu7+1O0EHWUbcGE938fc7zurGcZnjA3okbevlx5hklAnzhxNyL5zM
         nt76eOh6Sg2mkJEgeTiXPIkMBHJh39svmpY2XgJhs6jWeND7ORQ67Hohn+YByQkCEGOJ
         XP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ln2uKU+vMAyRV7UsLvWBhWdQgf4eoy4B8mnlBh7Uf4U=;
        b=pmL0M2OupjfnXwUSgvADkUp85YZaIwEgIBsLDVX+b33n1KM8YddAKA5RRsZFgsgM+p
         +igbUKLBimK3kDc2yklpiDJQQkICeSafnss92HMFsCHpc9Sn1fR4u8xQ51Oj0Hl5wIWS
         cUnot+5/8xhkXaWTq+JoIcoBFa1TjSFjJSEfyndSL3zujPeJ3STl29zhwAa2LFMf6noY
         g3x4/Sag6AYWlx/QdqT8XtKh69a/ubkpdGuxmCv45q5Qrirqlu0N9SICX0r+0vfJ+atg
         /VBUq1maA3rXJb1X2WhtG+2jmrFeDozK1wJOHjqvTefzOWTu9JuUHgSWVyjeGqF1+Lvc
         077w==
X-Gm-Message-State: AOAM532jUUcp+R5mBLiv2Gg5CjH3VxzOZZgkhPmpmrmaZxmet4QVILZY
        SJ2nl04rUzYa+qsZCFBa7Zup0w==
X-Google-Smtp-Source: ABdhPJzuSHlgADVOkpRdKXvOYxCnoS/c5megiAinBNNs6xCgR6iJuRaS9XBuz50TVKdsIMN2FiYdDQ==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr11534462wri.40.1644848259878;
        Mon, 14 Feb 2022 06:17:39 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id y10sm11966398wmi.47.2022.02.14.06.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:17:39 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:17:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: power: supply: maxim,max14577:
 convert to dtschema
Message-ID: <YgpkgSmxAWCNHW9l@google.com>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
 <20220111174337.223320-3-krzysztof.kozlowski@canonical.com>
 <20220112112905.n6zb36kwop2kfm2n@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112112905.n6zb36kwop2kfm2n@earth.universe>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022, Sebastian Reichel wrote:

> Hi,
> 
> On Tue, Jan 11, 2022 at 06:43:35PM +0100, Krzysztof Kozlowski wrote:
> > Convert the Charger bindings of Maxim MAX14577/MAX77836 MUIC to DT
> > schema format.  The existing bindings were defined in
> > ../bindings/mfd/max14577.txt.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> 
> I expect this to be merged through MFD:
> 
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Do you need a PR?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
