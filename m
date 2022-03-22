Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458844E3999
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiCVHbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbiCVHbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:31:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4041A830
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:29:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r13so8595577wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0YkoUKNzjuiQ40bBDt8w4L9lmMMcuLtJwHkvLD3JA/E=;
        b=GovikLzyh7hZjV1lSyaqPEVj9O5/8aFxdXFlof2jR/1GZTCYrV6kAzJRJa9jxUc83f
         Sn4iqcPfBwGfnc4WmvZSppCTdwpvqE3PbWbXuXYYLrEgXAFRvXFadgb7PlcW3W9HUvu7
         e18Jz5BLcii5ZOa6nN0t4FGoDKeOVb+E3BL/HZJMujMyEN6REpiLdRMSQ/blr53hVonx
         UCgcjq6i/LQwEX608lRI4w7EZr6Xe5nKrJ1QZhDXsszWSWSPz8X0eOQPfVBKjDlNc3b7
         F+aK1WuNwKBqO2fQrLwJgJy7/QFxDCJYLZssqJuP3ZDnVYStbmCu2XENDTr0taXNUgkd
         twIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0YkoUKNzjuiQ40bBDt8w4L9lmMMcuLtJwHkvLD3JA/E=;
        b=PE1wIdv7bgwCvrXwMVT02UOX0JW7dXsB7tcsyE1g0moAIn21lEICuCOmIN/nO5SJsr
         fPdTIl2dWoJ6unFLtBuzKZkI3SVQ1HNekdmWY5RkZmq2juM37ZT5babcUH81WyqlJ0vw
         qAUg+RptMgDs2IU1P+x7o5TbylihE53XBm92wRxtVYaq3RgcxE5yDxh0fZOA7o3gEL4d
         yLXkbxc/KTNGmbTvNlyX/j1vvMX8e5bYhpHfWormpsYI6pXRtBW+FjWDEyt9NHTV/a9v
         kTPgv8F7+nI/SbDj5NuFu8DR2KKWpgvQ7u8l9neZv0+NGFV9A6j7KKR7uwWp44wP+q9D
         +YYQ==
X-Gm-Message-State: AOAM532I8Cjw3Cb/VizfOSxlrqCWQcRaAp1fyzSUkqoI7S0rPWOkw7TY
        MMHdobwZwYtySqXt8fR/ovyLu0k+DsAr1Q==
X-Google-Smtp-Source: ABdhPJz0F8ts40ypwTzsh/L0YJQnCCbV+t/F+2IebS9NQZvhQiD4uL1Q4o+YBvdHvfmy/NkyfWEuPg==
X-Received: by 2002:adf:f5c4:0:b0:205:2836:f1e5 with SMTP id k4-20020adff5c4000000b002052836f1e5mr1252036wrp.519.1647934191160;
        Tue, 22 Mar 2022 00:29:51 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm21964949wri.0.2022.03.22.00.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:29:50 -0700 (PDT)
Date:   Tue, 22 Mar 2022 07:29:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: add
 microchip,lan966x-cpu-syscon compatible
Message-ID: <Yjl67RKiPR5bpfYR@google.com>
References: <20220313003122.19155-1-michael@walle.cc>
 <YjjVwhFCYRX3Alhy@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YjjVwhFCYRX3Alhy@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022, Rob Herring wrote:

> On Sun, 13 Mar 2022 01:31:22 +0100, Michael Walle wrote:
> > Add the Microchip LAN966x CPU system registers compatible.
> > 
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Applied, thanks!

Ah, this is the one Stephen messaged about.

Are you able to drop this at all?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
