Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7D9599B23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346735AbiHSLgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347810AbiHSLgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:36:47 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A97DCFD1;
        Fri, 19 Aug 2022 04:36:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso7283684pjb.2;
        Fri, 19 Aug 2022 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=5LGW9rYSz18XgZMkFUADUvSFUMOH4ST+9Q4YxH0TzZ0=;
        b=SSN3q/LRlgZ4zRACIl3XpnnOjXUdgJez0tg5vV9UlA0xStqFjcp/BwLsG1KpsWnhVk
         r9DdTNXy54KcbBnGJrjGT5p91WlHb2W+CrdJlTH4BvSxiWFrxqAtLOu3ZJTFrrsu+4mb
         ycqlR0+wd+5A+8XiCDcEpB1t3CMJTK/GWb7wqSLcC3/3ePeaRTwW734iKrMUl6dwnNSc
         5Jk47UgLJh9PLUEInRdhwyQ2JVtEWmeczRZ5P7qmP+Bkip8ZXyjoeLVoEvCrvwr9qh+b
         7gqqnbNFqxYNLgiScUh8lieOcngCAa33V7J1onUDYhw699WXqiH2yxfVt7GTTK6owL6n
         XcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=5LGW9rYSz18XgZMkFUADUvSFUMOH4ST+9Q4YxH0TzZ0=;
        b=GOCACliS5/337IUDyqZrHELOqaFunxqnk8kG6IAyXnPKjXhk7JBdJDuhCq6Rq4rm0M
         H+aGc6agmovnFqYmmAh70aUL5aOqyJDvlgRDVDp32+uGQ7jBW8b4DmLdA6tUpd0hTl+n
         ysVTha9U5CmM/j0zwBiXawlj82K3inA432Z9VGa6//D1M/af/rVGzxBnAn6w9MSB9qn9
         sfwU2D7htoBaP+1d9AopI705Y00Gfbjq8JMncNiDu51uAuPITL3SFR2lm+aMNiZsM5Yb
         JctEIVCBIDYxMJEnA/4pfpJ69uEneC2/jOIegq/f0Ib5wVkLYnAbeLbGgJFL3NvIUAZ4
         HO2w==
X-Gm-Message-State: ACgBeo36d0sRGkavdbD+ngTW9Cm4LdG0UYAWetVpy0h3Hvau8fEubtPD
        6vxr4b6Xnot1+jtxJtZLfuQ=
X-Google-Smtp-Source: AA6agR5X3RgKedGWLlR95mP2bpbnswyG229Mo+h3QEGQIaEPXJZE9XcQgnah/ROXIUHWDRGgBQm4eg==
X-Received: by 2002:a17:90a:c782:b0:1f7:a6cf:2f41 with SMTP id gn2-20020a17090ac78200b001f7a6cf2f41mr13578699pjb.128.1660909005679;
        Fri, 19 Aug 2022 04:36:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x6-20020aa79a46000000b0053602e1d6fcsm1421765pfj.105.2022.08.19.04.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 04:36:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Aug 2022 04:36:44 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dwmw@amazon.co.uk,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v2 14/16] hwmon: (mr75203) parse thermal coefficients
 from device-tree
Message-ID: <20220819113644.GC3106213@roeck-us.net>
References: <20220817054321.6519-1-farbere@amazon.com>
 <20220817054321.6519-15-farbere@amazon.com>
 <20220818202839.GA3431511@roeck-us.net>
 <e0b133e7-ac81-acf4-3783-44edf58d6426@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b133e7-ac81-acf4-3783-44edf58d6426@amazon.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 10:57:58AM +0300, Farber, Eliav wrote:
> On 8/18/2022 11:28 PM, Guenter Roeck wrote:
> > The calculation was just changed to use new defaults in a previous
> > patch. This patch makes it quite clear that the coefficients
> > are implementation (?) dependent. So the previous patch just changes
> > the defaults to (presumably) the coefficients used in your system.
> > That is inappropriate. Adding non-default corefficients is ok
> > and makes sense is supported by the chip, but changing defaults
> > isn't.
> The calculation was changed in previous patch to match series 5 of the
> Moortec Embedded Temperature Sensor (METS) datasheet.
> In our SOC we use series 6 which has a slightly different equation and
> different coefficients.
> I did the changes in steps.
> With this last change, both series 5 and 6 are supported, in addition to
> calibrated vs. non-calibrated modes.
> In addition the data sheet just recommends default values but they also
> specifically mention that actual values might vary from product to product.
> 
Please mention all this in the commit description.

Guenter

> --
> Regards, Eliav
