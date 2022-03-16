Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AC64DABC6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbiCPH0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242653AbiCPH0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:26:21 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C0B5F8DE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:25:05 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r10so1641120wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8BgdaLCDN6ytbgA7o8PQn3N09wAKTlqYsotJMbZ94HQ=;
        b=t7PLX2bnFJvh2OuH8ldQ3pGj0uGpLjvI9yGGDUiqTDd7SSumcM4cnuTcNRyMpaRwAC
         h5HtFuQ/ZdMrdt2qM+73TPfgoqxj+IcVeFIA256djzYWu7ghKi5saQi0lFK3vl71MPD1
         02oa4G8StCr3dhefjZqhhiTuzY/JBONjGDmZTPnsxwlf2yb1U/mztbaxUu2ndWHRXc7q
         +WWXFgf4jFI/4r3oUahqOe+JpxT03Ep9hmPGg3S83ztNt8A2YPQqgPIjE09lYpOjIBT9
         4GMdGjAX1+hIFKtm0KnIyuYypZghIOV5P6DTbMmIVJ5HufNysqVkMaEI/nklElepRLn4
         Edaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8BgdaLCDN6ytbgA7o8PQn3N09wAKTlqYsotJMbZ94HQ=;
        b=jSFnaP/DYpdeAN8406KXso4YkVPOo48ncm3EQj5U56EmOUMHyyYhIWiy3h5fZOxdVO
         hcuYAjMQQkQIYl8KJKLHhjZRitU4s3BUysIOR1LgJdj7+l11jGI2w91O47VMu50B8pHx
         DggmAHcIWQ0ca/LxCpuFjjm8BmtjWYKvfDnkVKz1WbQxvob8gHqsK/BI2O0+OvbkX8D0
         tv712SligXUNaJ9V5v30cRKkU2LO64ceGs9k62WiR0tQMi0j335PBN9u06Jgwwi6ONb8
         HHIu5bnIvW24E7iZvXBW1YksGlyP/Pgn9IBdl9JJjXh0SjevxZHluJGGH1FFW5imluzS
         Klzg==
X-Gm-Message-State: AOAM532uYKl6wiUxNu+AYil7MrHGtxglIWh6RWaCxwGN7FHrU8P4OD5s
        3BaaLRKiSQyFH7gXdj+vTqY/yw==
X-Google-Smtp-Source: ABdhPJwUBkwggjNof9CJhQ+Bfj+6ZOtK4GoDq5/024E6T6MIY1EyUUZpVIGGx2JSQ6fwq8YH99lWww==
X-Received: by 2002:adf:e38f:0:b0:1f0:3383:77d9 with SMTP id e15-20020adfe38f000000b001f0338377d9mr22651010wrm.599.1647415504002;
        Wed, 16 Mar 2022 00:25:04 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d59ae000000b00203dcc87d39sm1559468wrr.54.2022.03.16.00.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 00:25:03 -0700 (PDT)
Date:   Wed, 16 Mar 2022 07:25:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add ChromeOS fingerprint binding
Message-ID: <YjGQzeIz7kGPOV1H@google.com>
References: <20220314232214.4183078-1-swboyd@chromium.org>
 <20220314232214.4183078-2-swboyd@chromium.org>
 <e7f9466e-03c9-7754-0dc6-a04823d1047a@canonical.com>
 <YjB0JOKysPpg2KGF@google.com>
 <9ec3c26a-3b85-4bea-5a5b-de9ac570cfca@canonical.com>
 <YjB46Sq3IwvgR8MB@google.com>
 <CAE-0n51uDh2Cf_wGpAVH1t=T0A1eTT=+KU3WMtxtyPL3kLDAdA@mail.gmail.com>
 <YjC1OLsB8/JXLEzF@google.com>
 <CAE-0n511YyyfXoCOKpzm3ca0-sE9_wpby31XDu-eGQts=-kV2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE-0n511YyyfXoCOKpzm3ca0-sE9_wpby31XDu-eGQts=-kV2Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022, Stephen Boyd wrote:

> Quoting Lee Jones (2022-03-15 08:48:08)
> > On Tue, 15 Mar 2022, Stephen Boyd wrote:
> >
> > > Quoting Lee Jones (2022-03-15 04:30:49)
> > > > It's tough to say from what I was sent above.
> > > >
> > > > But yes, sounds like it.
> > > >
> > > > We do not want any device 'functionality' in MFD ideally.
> > > >
> > >
> > > I put it next to the existing cros-ec binding. The existing binding is
> > > there because of historical reasons as far as I know. Otherwise it
> > > didn't seem MFD related so I didn't Cc mfd maintainer/list. New file
> > > additions don't usually conflict with anything and this is in the
> > > bindings directory so the driver side maintainer would be picking up the
> > > binding.
> >
> > That's not how it works unfortunately.
> >
> > This file is located in the MFD bindings directory, so I would be
> > picking it up (if it ends up staying here).
> 
> The way it works is arbitrary 

Correct.

> and up to maintainer's choice.

Which *should* be reflected in MAINTAINERS and by extension
get_maintainer.pl.  As is the case here.  :)

> I'll move it out of the mfd directory :)

That does sound like a good solution, thanks Stephen.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
