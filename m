Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB077586BDB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiHANWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiHANWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:22:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D92B31DE0
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:22:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso6080898wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=bYiybKe240H/UzM6bAAOcpT8lfmz1vttebIHklWhVHk=;
        b=Q4JAv4HONdpQLBE/p/Ek3s0qcIa99xPlmMQ0qaA86GYZBjiBksNVlJDFCtCNsDplKf
         icszQncbkedSDsvTbTz10AINYhpW7Uysvn7z08WhYvZJyzx0Ekwv/Rhc3CV1yBIMLSpF
         8/YLuAkU0FH6Kuqypq+Ul2fo0XMW7w7lSosBfjy8ozr73Tdqq7lv5auiVzuHSe+tuIUL
         j/v/bTB+K7bKaLfYnKHXKXIp49M+lskgRiKmWD1WM5bzINZROEMqnf6X4ZuCwFBMBVgU
         UKkzxEjJ91p72zTPfpyd0F1MiPMiNhPMcmfYBu41vDYCzoB41prTnSIQQwtG5ItbMtok
         g2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=bYiybKe240H/UzM6bAAOcpT8lfmz1vttebIHklWhVHk=;
        b=yY1xCHX76Ob5mlUupBWxNiywTuGvGIvi2tJFIEUENLUdPSbDP1my88zlGitlgyM8bk
         W3WGFLSBwHksvXvG2schRMpUI7moOgYOZZmN7ODXP5vUumzfAHxw26l8b18EcyLc84Ud
         +rEuyFLlg/kYxQCvuTKGE2/Jc711YnwWFeTIqEc5dXldJcR+yQoQWlKLL7k+KZ3EM4YB
         Eeu7w6T8A1+Ao3aDL88Lj+XFpP7hiMwVj/fG+mBKV6hdt+4FI5T0mpA96iX14lady9U7
         Wl6Ni6nsjF1vrtHwTDpnVPIHzg6zQhUGSBqNgxg67rORIXq3dOTxpA94l67nIAn72GBS
         VEOA==
X-Gm-Message-State: AJIora+5GepSvIA1gb4to08EG2Wa5gx4GhrPTVq/Nm2NkloFRMUlnitc
        pjO10YLAqfV61fj4+kMuPzjkhPI289cTwA==
X-Google-Smtp-Source: AGRyM1sT8kgP7yoLPnEkIsmp/wb38CVp0J6ciW5gur1tk5aeufcJISOIsWxNDTEwThdHnIyZadSdCA==
X-Received: by 2002:a05:600c:35ce:b0:3a3:1b7f:bbd8 with SMTP id r14-20020a05600c35ce00b003a31b7fbbd8mr10672603wmq.22.1659360158676;
        Mon, 01 Aug 2022 06:22:38 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b0021f1ec8776fsm7942298wru.61.2022.08.01.06.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:22:38 -0700 (PDT)
Date:   Mon, 1 Aug 2022 14:22:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 1/1] platform/x86: p2sb: Move out of
 X86_PLATFORM_DEVICES dependency
Message-ID: <YufTmwg/A94XjrQ8@google.com>
References: <20220718145328.14374-1-andriy.shevchenko@linux.intel.com>
 <2b1b4cd1-faec-85a1-5ad2-e2b29290e0c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b1b4cd1-faec-85a1-5ad2-e2b29290e0c1@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022, Hans de Goede wrote:

> Hi,
> 
> On 7/18/22 16:53, Andy Shevchenko wrote:
> > The P2SB library is used for various drivers, including server
> > platforms. That's why the dependency on X86_PLATFORM_DEVICES
> > seems superfluous.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > v2: added X86 to the dependencies of P2SB (Hans), added Rb tag (Hans)
> 
> Lee I presume that since you've merged the original series
> (in your ib-mfd-edac-i2c-leds-pinctrl-platform-watchdog-5.20
> branch) that you will take this fix on top ?

The point of supplying an immutable branch is that whoever maintains
this subsystem can pull from it and apply this patch on-top.

> This fix is necessary to fix a bunch of randconfig build
> failures in the current linux-next.
> 
> >  drivers/platform/x86/Kconfig            | 12 ++++++++++++
> >  drivers/platform/x86/Makefile           |  4 ++++
> >  drivers/platform/x86/intel/Kconfig      | 12 ------------
> >  drivers/platform/x86/intel/Makefile     |  2 --
> >  drivers/platform/x86/{intel => }/p2sb.c |  0
> >  5 files changed, 16 insertions(+), 14 deletions(-)
> >  rename drivers/platform/x86/{intel => }/p2sb.c (100%)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
