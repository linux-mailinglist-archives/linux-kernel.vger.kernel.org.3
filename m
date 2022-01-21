Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E2C4967C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiAUWTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:19:45 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:42930 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiAUWTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:19:44 -0500
Received: by mail-oi1-f173.google.com with SMTP id y14so15549708oia.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+KROCKs5Cfv2lia9fBs5xXIA1Be4iGBDCLnlB4oEsE=;
        b=JHZ9WkaS8WKit5H0lPDI3TWQlp8ac9MBrthmLtFK7YPR9bfEtSbPB2cQuQwViCf42z
         HvIOojFnPXuiYOxR/PjDOmQ487D798O4pELit1C0QTLFfFRyfWHvNNENMomHvnRx3dJ1
         wcN12QcrWLDrVzceRMAQ0YSamb1PPstgFikPm6FvCu4ZsT8XwHytOJejXoo86zwoRwJc
         0Wm4KI/xBPXZC56UulGsA0xEBAucV98AvCsnPBsENB1CkcCt/xxYiuO4bXkhqNvd7ONS
         Qc+pGnoF4GVXwhh/8XPx7OL1N1Y4lUFCaU2DtvGTI/C1x15LD+Vu3wOouZ9kvZKIY7UA
         PWjQ==
X-Gm-Message-State: AOAM530TvVAZjwxqscMv2SeNVCSaysf/QOpD2YoC3jMrtE1pwaL423Yj
        zbNOa+l9joqijSqXYVVWXQ==
X-Google-Smtp-Source: ABdhPJySybsEqUSvFny//jTcVlWR9AXxtIa+ANnQQ8NC/v4r52guDQxgHe0X6yy1l6wsfey80iar7g==
X-Received: by 2002:aca:c10a:: with SMTP id r10mr2298993oif.16.1642803581591;
        Fri, 21 Jan 2022 14:19:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l38sm85605otl.45.2022.01.21.14.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 14:19:40 -0800 (PST)
Received: (nullmailer pid 1700921 invoked by uid 1000);
        Fri, 21 Jan 2022 22:19:40 -0000
Date:   Fri, 21 Jan 2022 16:19:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] device_property_read_u16 reads out only zero
Message-ID: <YesxfEDbK/qFizFG@robh.at.kernel.org>
References: <CAMdYzYquceSBrOsvO8rW9wmJA_RO=HSwv_waVoS=0hsP414T-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYquceSBrOsvO8rW9wmJA_RO=HSwv_waVoS=0hsP414T-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 05:48:52PM -0500, Peter Geis wrote:
> Good Evening,
> 
> I seem to have come across a strange bug with drivers/base/property.c
> while expanding the new cyttsp5 driver to handle device-tree
> overrides.
> 
> With the property:
> touchscreen-size-x = <1863>;
> The following code:
> u32 test_u32 = 32; /* canary to catch writing a zero */
> u16 test_u16 = 16; /* canary to catch writing a zero */
> int ret;
> 
> ret = device_property_read_u32(ts->dev, "touchscreen-size-x", &test_u32);
> if(ret)
> dev_err(ts->dev, "read_u32 failed ret: %d\n", ret);
> 
> ret = device_property_read_u16(ts->dev, "touchscreen-size-x", &test_u16);
> if(ret)
> dev_err(ts->dev, "read_u16 failed ret: %d\n", ret);
> 
> dev_err(ts->dev, "read_u32: %d, read_u16: %d\n", test_u32, test_u16);
> 
> returns the following:
> [    1.010876] cyttsp5 5-0024: read_u32: 1863, read_u16: 0
> 
> This was as of 5.16-rc8, using the
> gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu compiler.
> I honestly am at a loss here, any insight you can provide here would
> be appreciated.

The property "touchscreen-size-x" is a u32. Calling 
device_property_read_u16 is an error though one is not returned here. 
You get 0 because that is what the first 2 bytes of the property 
contain. DT data is big-endian.

I suspect making this a hard error would break some users, but we could 
try a WARN.

Rob
