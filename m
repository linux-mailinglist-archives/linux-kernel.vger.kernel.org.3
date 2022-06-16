Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE1654E6A3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378032AbiFPQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378015AbiFPQFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:05:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD502F671
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:05:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m24so2463237wrb.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AQ7qlkhh96UMFX80I0oPzgb29Zzo2DjDhjaG+QTFgpA=;
        b=QmWj/JA8OVWbppLVG/3EC8TPh3nSRBqJExnTNJ0V2ddHuIvw+fogHkFNcBqkC6DxYm
         vbbLji8qIb0Z4x+Q4mxj0S3XkNvWXBtnyARJhVAnJZEY3MGLEfjEvg7fXKUvpqd2qzhJ
         dnPyaXiQ5KLLuN6gWY5+HC8NDijqC6E0MatSIucyYRPitrTZUPMmxLGlXE5cLN89+jDq
         TgcArkH7ClRRgPAtAhSatBy42u1PxIK0q2fY4zkBkI8dGSEuc+8aD6m/aM0KuNPq3F4h
         hsi5ale6H0rsuRos0Y0IO+Qi6OVZ7IY1eXGSDSjd5XO9pKVNX5ysVkLHtkIWm+sjx/Ch
         2E1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AQ7qlkhh96UMFX80I0oPzgb29Zzo2DjDhjaG+QTFgpA=;
        b=BMoykRGcxtLjyU8VRwiK7zC49d3LEfBaJgnBCf525g4K21soM7Ft2Nj5jmCax5pCAZ
         U53t7mVSIhvXebiPEg1SxhPsAmcdFMnbJqlVK3TJEr/SL5cog66si13QlX69mPnqLT54
         tPL5V+Hs9lA6OW2/SJ/p+3P5yVd4g4bAXmBiOGJN4d+E7lZDX+M52Ccugdb7DPpYfw+B
         fmFzOEkF4IfP44xxs9VifJBGeLwPDs3BgeyRCzp0r+1qBZBjCedgtUOLxfyd3sfex4Ls
         vL2LlxN+1tDHq56toi1QXtlulcY6f+o0QWM5+AUWz6dpoVNRj1Jf1U5Wa7bwcXq4NYOb
         NhKg==
X-Gm-Message-State: AJIora91MupzjZlHFUNMhyj7GxNx2NEJ6zAj5LSAs+qlxa7JcdJ7eh1y
        1ea5eU8U969dHgmslmX3VooFpg==
X-Google-Smtp-Source: AGRyM1tAn6VpvKTHgYfDc86Vm5PrW9dZhN2IQ6wAo1US+n4F0nH52hlA4+g2jdr6L5RtcVNR9b+0oQ==
X-Received: by 2002:a05:6000:1a8b:b0:219:ad61:f4e3 with SMTP id f11-20020a0560001a8b00b00219ad61f4e3mr5491929wry.190.1655395505897;
        Thu, 16 Jun 2022 09:05:05 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id b5-20020a056000054500b00212a83b93f3sm2238755wrf.88.2022.06.16.09.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:05:05 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:05:04 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YqtUsERFmt9gSnuF@google.com>
References: <20220616092737.1713667-1-sebastianene@google.com>
 <20220616092737.1713667-3-sebastianene@google.com>
 <YqsBN2qtjCkNtVM0@kroah.com>
 <fe96c19c-b8eb-2443-1476-3dff7ea47f6b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe96c19c-b8eb-2443-1476-3dff7ea47f6b@roeck-us.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 06:08:51AM -0700, Guenter Roeck wrote:
> On 6/16/22 03:08, Greg Kroah-Hartman wrote:
> > On Thu, Jun 16, 2022 at 09:27:39AM +0000, Sebastian Ene wrote:
> > > This driver creates per-cpu hrtimers which are required to do the
> > > periodic 'pet' operation. On a conventional watchdog-core driver, the
> > > userspace is responsible for delivering the 'pet' events by writing to
> > > the particular /dev/watchdogN node. In this case we require a strong
> > > thread affinity to be able to account for lost time on a per vCPU.
> > > 
> > > This part of the driver is the 'frontend' which is reponsible for
> > > delivering the periodic 'pet' events, configuring the virtual peripheral
> > > and listening for cpu hotplug events. The other part of the driver
> > > handles the peripheral emulation and this part accounts for lost time by
> > > looking at the /proc/{}/task/{}/stat entries and is located here:
> > > https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > The robot reported stalls on vcpus?
> > 

Hi,

> 
> I have seen this a number of times when people fix issues reported by
> the robot in their submissions, just because the robot asks them to
> do so. This should really be part of the change log, such as
> 
> v17: Fixed the following issues issues reported by the kernel test robot:
>      ...
> 

I will add this in the changelog for v7.

> Guenter

Thanks,
Seb
