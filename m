Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F9348118E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 11:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239690AbhL2KQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 05:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbhL2KQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 05:16:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B1C061401
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 02:16:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w20so34468035wra.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 02:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=b+zE01u0JpXpyPFug8aJeTgsvJdxFWBY5Ed+UEXJSbA=;
        b=nFApkzhsRA48nGUu+5m10zgx/O8dTMBvvVv1kZzQwiqMHrMxHsItuQb0vBSLa7PUz0
         H5wJ9THDs0vtzxZRwJMcrBdgc05TslxDqhMj0PLv5Rl5bvj0mjFHBxn4Rv768Oj9gyAX
         OO63YnO6HU7LFncpBZ9CNKqug1Ps4gJRdVgHkSqt1rcMUtwoqpWiVS2I8zw0DKquhvmq
         DUBOUyj7NmEMqPSqH8kKTbjsCVw3cJy06PWUmLM5SrVJFDr5XinFywfp1IfAIOX3EnD6
         hYwt1IgD0ZTXATvchXACobxPOQh9Ib2lra6iAMhic7D2RvBRaF2UU0NU8HVzXJeTSvQq
         o6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b+zE01u0JpXpyPFug8aJeTgsvJdxFWBY5Ed+UEXJSbA=;
        b=1vKX2L5i+DWaK9uWKrrE5pMnzm3+3K0t4J6KIz00xhI08F5J/iJC69PH/P4/cwthdf
         S3vWHEaJZzp7/AxWGQeYsBiPvTm198tjsNg2AHEzYzSbR4/UEsjD0LaRcsgqD1mk0fgU
         F0cUpDm7DateKBhalthogkdbXF/wXfUvcwLXLKByi5Hg5pGVbXI1qmxYVum1R7Jr+28D
         YsIX6su7PTfrQXgi94LfmlJKOdOgpslezrLsI/fM4jvduLkG32lFuunUZ5hq+/+khR/D
         q0heLBO2gKxawP0IpMHCpQs/3kWoyfVVXabHmqAiPrw9qo8a5QDlCX9CXeb7sekNvTh1
         Uvng==
X-Gm-Message-State: AOAM531n4VCNHN2Haz6bi5/WMX4iiNWxpyqm0j6R59EwOAVxPwfS+HPN
        1HwtSn0CSBxQuk0MKfMSq6/grg==
X-Google-Smtp-Source: ABdhPJx0iWeXqxZaRi6Rm3ozmbJecqRY7o7RGp5qWfmkkNU1k7L7xFc8xl0Wrcp57XJhzm0SxQHnJw==
X-Received: by 2002:a5d:56c2:: with SMTP id m2mr20111241wrw.313.1640773006492;
        Wed, 29 Dec 2021 02:16:46 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id o5sm3040713wmc.39.2021.12.29.02.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 02:16:46 -0800 (PST)
Date:   Wed, 29 Dec 2021 10:16:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Subject: Re: [PATCH v6 6/9] misc: smpro-errmon: Add Ampere's SMpro error
 monitor driver
Message-ID: <Ycw1jNNGlkaj3QnI@google.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-7-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211224041352.29405-7-quan@os.amperecomputing.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021, Quan Nguyen wrote:

> This commit adds Ampere's SMpro error monitor driver for monitoring
> and reporting RAS-related errors as reported by SMpro co-processor
> found on Ampere's Altra processor family.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> Change in v6:
>   + First introduced in v6 [Quan]
> 
>  drivers/mfd/smpro-mfd.c     |   1 +

Separate patch please.

>  drivers/misc/Kconfig        |   7 +
>  drivers/misc/Makefile       |   1 +
>  drivers/misc/smpro-errmon.c | 571 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 580 insertions(+)
>  create mode 100644 drivers/misc/smpro-errmon.c

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
