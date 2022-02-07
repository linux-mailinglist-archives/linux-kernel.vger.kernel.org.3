Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B294AB7B7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351809AbiBGJgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 04:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345030AbiBGJf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:35:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4201DC043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:35:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r7so9388725wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 01:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TCP4D7FjgMKnby1e08gVg89o79MvrPT+OFv+Q8blaaw=;
        b=ogrUu/AfnxSajBawUTAzhtl8hLHhL27U55AVn39abbS66VthBN2tMwBOrOl3xMel+M
         qcydCYRurHTN44lCd9x0SEZQ1xWAGK/kf7FCmswWvYVMdoQomDqI7uBjuqYS+hkkbsLH
         M0aU74LkynnNMWzcR83MoJglFkamGY4FGKSAthZ4e6ZfWaRlRuJuCuW6zwtdP5LaEJ5K
         754Hu2ipMrf9lbi3w7cSa9wVeqU94CaV0PlO9mrimZQZKRfMxHnUYifUturxVEDlt+nJ
         DSvz2SHZnrxS+h8kwo2kPAnt+8Pw0JYWRcAWqzR29lntazxq3gkLeaPbCE3bGj69p3UE
         WauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TCP4D7FjgMKnby1e08gVg89o79MvrPT+OFv+Q8blaaw=;
        b=T2taW211ZBUi9HLR/uqDp7DmPa4BCd3FTyB9pVD0iUIE8Z7Ay/z0LiVfAwCrH0bmKd
         Z9Y1Q179nhOqdXdiFai++RjNEINXuvNiT5cA7WKRwImFALUZtt+cKyh3mFsFmL5CGE6n
         bbuhk0OVkjy2TjnboIUrmmTQGkV3kiGtCqGzXcUBoE45UUWBYprX/U0PUDiBRqLzDhUX
         R6Mqv598li/dYnlkHrVcRnPjGuN8PEVwAh5s19bGBk6kQy3UiiJDsGVlNzxCHzlVklFA
         khP+2TGKO04lFUG8Z4T6u6zRDuIJSrgoNqrMp6uDFR4YZV6FdDw1Xo8N4MzJn3rywD7L
         67dw==
X-Gm-Message-State: AOAM5339cIcYas1cnTebDcXME87XoQZqYUxkxt+NlBdqqSOhwmrvtn+v
        qlt1Pi8dyKal38Krri0tmzrdNw==
X-Google-Smtp-Source: ABdhPJw22S5Q4w+myvg3aIQzNPQRoUolNTKEHd2CXwdqN9FlAuhosQe7sBTyghe8NdwcT3vntxlSiw==
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr9022814wma.168.1644226524796;
        Mon, 07 Feb 2022 01:35:24 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g15sm9584075wri.82.2022.02.07.01.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 01:35:24 -0800 (PST)
Date:   Mon, 7 Feb 2022 09:35:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/4] leds/power/regulator/mfd: dt-bindings:
 maxim,max77693: convert to dtschema
Message-ID: <YgDn2iupBQL1lr9p@google.com>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
 <63255060-8df8-660d-52bf-198d77c884d5@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63255060-8df8-660d-52bf-198d77c884d5@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Feb 2022, Krzysztof Kozlowski wrote:

> On 11/01/2022 18:50, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > Changes since v1
> > ================
> > 1. MFD: Use absolute path to schemas, add additionalProperties=false.
> > 2. Regulator: mention all allowed properties,
> >    additionalProperties=false, add min/max values for voltages and
> >    current, don't use patternProperties when not needed.
> > 
> > Dependencies
> > ============
> > The final patch - MFD maxim,max77693 bindings conversion - depends on
> > all previous. Therefore this could go via Rob's or Lee's trees.
> > 
> 
> Dear Lee,
> 
> This patchset was reviewed and there are no outstanding issues. Could
> you pick up entire set via MFD tree?

Nothing from LED or Regulator?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
