Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC337534BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbiEZIaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiEZIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:30:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98163C3D0B
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:30:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 133-20020a1c028b000000b003974edd7c56so83052wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SqD+//mjmyM8nN2hVLImGoL1fyQQfgdM4ycaASE7xag=;
        b=FkLQsnrsRRKNuLsePdSf+0SgS1LunWp3nDcqi2+thLADwb7djOu0kwiX1L5uoccyHf
         bbs8Ry5KBtmkqXecqJ8Nq8+xruRZf25pqRYUnnfgp+1y8vOpatE1lx6Xw01ODVai42hC
         ICEdzJppkQmBbZ0Ydc5DbB29clebg2vMNvDhujqorDg3p8K/PakcKCVxt0EC5EBCSqTf
         PqliSq9J2rS8ZuGfoNv0lNNgBEVsFMRDraQbQQa6jQx3PeoJVgG/7WQUl+jFH5b4UDjh
         6ZASfJl5SuwxOvEYKXxCmf2NVLROCjYzbyGtckwHJ2GetIKlxZSDjQaXNL8Hw8tirvkL
         dVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SqD+//mjmyM8nN2hVLImGoL1fyQQfgdM4ycaASE7xag=;
        b=e0Qp7fil6zgTdbxKP+N7W1gldjod5Y2vJRxtU01eZarlNLiVPnaEI0z5AN2QSBYaDG
         oPRknPeyynT+aA09jcaoEg5B1ao6QLLCP5hAo0t402Iy4FyQL3SLtVRZCkYGU2DJoa2j
         p/rgsjgyh+bXvhg1x0EYT4hP48LRwQHJuK7tW8wtYT7YMYwCT1aifgsLc5XPtLYn0g65
         IwtSCo2+uJcQXmKTp5nk6sxfT5SURgbtzKPgDATjOotA61Pi46HKulhdHLQxxz4eQnaP
         ODEyNPvhhnPh4W3yfQmDdHacc512e5rUosHV88G8hTEvFoVs6HqRQyBbHEFGdzYKciTW
         caNw==
X-Gm-Message-State: AOAM533QnwE2SfZP5NMMtBH2WtD55qVkEs3CxdxfUD/oWOH+QjLijMlx
        rg1M/5z91qDU3iLubV2nTO+iyg==
X-Google-Smtp-Source: ABdhPJwPfB+MTUo+/GlPxn+Tr1A9uarAX1twWrzeWeehJ8MKhcxFVbR33ybN71LPdJTLOGnvUwIC2Q==
X-Received: by 2002:a1c:7510:0:b0:394:1961:708 with SMTP id o16-20020a1c7510000000b0039419610708mr1185522wmc.201.1653553809149;
        Thu, 26 May 2022 01:30:09 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b003974df805c7sm1269581wmq.8.2022.05.26.01.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 01:30:08 -0700 (PDT)
Date:   Thu, 26 May 2022 09:30:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>, lgirdwood@gmail.com,
        robh+dt@kernel.org, kernel@pengutronix.de, s.hauer@pengutronix.de,
        alistair23@gmail.com, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, amitk@kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-hwmon@vger.kernel.org, linux-imx@nxp.com, linux@roeck-us.net,
        rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v21 1/4] mfd: silergy,sy7636a: Add config option
Message-ID: <Yo86jpMrKR0Dj/HB@google.com>
References: <20220525115554.430971-1-alistair@alistair23.me>
 <20220525115554.430971-2-alistair@alistair23.me>
 <Yo5vjlsc0J1S70zN@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yo5vjlsc0J1S70zN@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022, Mark Brown wrote:

> On Wed, May 25, 2022 at 09:55:51PM +1000, Alistair Francis wrote:
> > Add a specific MFD_SY7636A config option.
> > 
> > As part of this change we can use MFD_SY7636A as a dependency for all
> > SY7636a components and also remove the name from MFD_SIMPLE_MFD_I2C as
> > it no longer needs to be selectable.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Full disclosure; I've already made my cut for v5.19.

This is due for v5.20.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
