Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD77500693
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbiDNHKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240232AbiDNHJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:09:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685A353E06;
        Thu, 14 Apr 2022 00:07:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id p15so8263386ejc.7;
        Thu, 14 Apr 2022 00:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=oqwnBa3vRK8c7PWrMJXfLYeX+P589KiwcMk0Kfia4mA=;
        b=Qc9E+wfQBU77wff9QdMJNpl1nbiuPHN4F3Tp+X2wNcFaNgeeepIJiX2qPGwOp7oyZL
         B+2DJnGUjMdjqTO0wOENN9ShyxDU2usArOX9UTFZDGrNyNACPQcaNsEkdcn9RttdFG5S
         pHbHUzgtRFH9IrYdt26x2B57aNUWLOgFXhtycGubpXKFhGp4iyk462xtIRQSeOHumUK1
         hiLTHvnyNFwyU4k+opM2Ht6bRwaXJrk+OGPn3z8YGy7xYw6+U9tZbGQ+8+Onc37Bhxti
         6QisIl6d8mZgwVBgSgO1tvZsloUmjQTEsgBjzGSVqQQN130s6qag7kSLKpa0CbSF55JB
         rDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oqwnBa3vRK8c7PWrMJXfLYeX+P589KiwcMk0Kfia4mA=;
        b=7nbRKk/Nqa8n+jzsWdTxXXxOQE8VDkpEhIXimwFubgy8T/p1q5yjo22mg5EBz7SFlJ
         NRTHVQRi3cupzLkAUQ/78TLDyJoyZkR8rZ7mprFKZk4blZefQe582phkzJyPYVUQ7dew
         EipR2J6f10utf56eImHPC/sOPQIhBT4j+USbAFctf2ogri0sMwl+FQvOjSDTQZf2Vjb5
         lyVG++Fa5MH7comi4Y7ubtW0EzGHiEjCSHg0xDspGcmCjyUEV9UOIJ/EoQV/eP5QxPow
         BMBe7wbM6RMnxznvE94NoJuQNQ0t2WxyL31/SKM449hhl7ciEzv61yJ4b6x9vhjfdhYV
         DB4A==
X-Gm-Message-State: AOAM532UiLO3tj4EHTXSNPwEzSoj0ybIrcINK/YuVRnoVQhFN2X730qs
        OMvRYXhwJEWjQQVs9lXFOME=
X-Google-Smtp-Source: ABdhPJy9iBPa3gYce292bgP1ajNTxKBPZO03zfLAllYQv/BAhGL7Pb3FTNcFsG9XN8UgBHiQMNlAkg==
X-Received: by 2002:a17:907:2d90:b0:6e8:720c:d8e1 with SMTP id gt16-20020a1709072d9000b006e8720cd8e1mr1152183ejc.514.1649920050834;
        Thu, 14 Apr 2022 00:07:30 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b2c:c401:dd5:7d95:7a65:6518? ([2001:a61:2b2c:c401:dd5:7d95:7a65:6518])
        by smtp.gmail.com with ESMTPSA id g23-20020a170906199700b006e874c0f5eesm345987ejd.198.2022.04.14.00.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 00:07:30 -0700 (PDT)
Message-ID: <03fa4823b820b3eb2499a002a7570e79641b4a78.camel@gmail.com>
Subject: Re: [PATCH v1 3/3] iio: imu: adis16480: Fix getting the optional
 clocks
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Thu, 14 Apr 2022 09:07:29 +0200
In-Reply-To: <YlcBMGkdmGTq/mnr@smile.fi.intel.com>
References: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
         <20220413144124.72537-3-andriy.shevchenko@linux.intel.com>
         <PH0PR03MB67865D24BB7546CAF805D7BE99EC9@PH0PR03MB6786.namprd03.prod.outlook.com>
         <YlcBMGkdmGTq/mnr@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-13 at 19:58 +0300, Andy Shevchenko wrote:
> On Wed, Apr 13, 2022 at 03:38:47PM +0000, Sa, Nuno wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Wednesday, April 13, 2022 4:41 PM
> 
> > > The extended clocks are optional and may not be present for some
> > > SoCs
> > > supported by this driver. Nevertheless, in case the clock is
> > > provided
> > > but some error happens during its getting, that error should be
> > > handled
> > > properly. Use devm_clk_get_optional() API for that. Also report
> > > possible
> > > errors using dev_err_probe() to handle properly -EPROBE_DEFER
> > > error.
> 
> > This is a nice cleanup patch... But the subject might be a bit
> > misleading as it says "Fix". So I would expect a Fixes tag which
> > I'm not sure it's really worth it here. Yes, the code was pretty
> > much
> > doing clk_get_optional() "by hand" but I think it was still
> > functional.
> > So to me, this is more an improvement rather than a fix...
> 
> Actually it is a fix, but not critical since no-one complains aloud
> so far.
> The problematic part is logs exhausting if repetitive deferred probe
> happens.
> 

Still not really agree with it... In the commit message you state that
errors are not properly handled and so let's use
'devm_clk_get_optional()'. I don't think that is true because If im not
missing nothing there's no fundamental change between the previous code
and using 'devm_clk_get_optional()'. So to me this is an enhancement
because we were doing something "by hand" when we have an API for it.

That said, introducing dev_err_probe() indeed stops possibly annoying
error messages for EPROBE_DEFER (and that could be seen as a fix, not
really devm_clk_get_optional()). I honestly still don't see it as fix
but we are also not adding a Fixes tag so I don't really care :).

(But I still think the commit message is a bit misleading)

- Nuno Sá
> 
> 

