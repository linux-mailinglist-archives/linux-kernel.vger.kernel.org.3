Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D905355DC52
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbiF1Jse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344501AbiF1Jre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:47:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4706B2A40F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:47:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k129so5590396wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0VFdljwMybe6T8UivZGMyK3nayzUV0u5vlT+A7LeDd0=;
        b=aRmN1lCHYRKl3wmo8j3UeNRRPt9ajAeGcvX6kQpk2MTwKoHx5s9OFgnazm/22LuwX4
         FNjtjVmjIGBmbY+Ey9vCnlli+ejU4i+S4Tj/RE2Wc3ea7GsjrjprxadbDGvAmry1Sv7O
         Zj5zw1imfUwLIP5AHrIJOMJ3Ag0x/GpurH57Vu6mkiUya1KKs513dpaxuyhy6QQYfBu5
         HTY+WEFXIn59NW52D9uAA38Lkm2OS12aho+3FVlgYKiKZy5h/VtQw44KJneioVUFOcKg
         I5nv8Im9zgZKNF9/RRmO8MnprKnIg95GaNvVNrSDV7pIExCOQIxaBa38HC8Yiw+H2UIn
         JXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0VFdljwMybe6T8UivZGMyK3nayzUV0u5vlT+A7LeDd0=;
        b=kDdhzEfrPadMnz9Tp076RiVH3/HKlpnR7f1Dits9Gf2GqmwD8Jv+3Ahv6FluSJVFrW
         IVF2wMULX68e2BZog/FUKDduSAdLZ4vJBjUzs17GDzszr0TL8nSemn5vwRWXuKEUlWkB
         yN96BrytgxjH65iYHGFoPpeNSLnkLWM6//bZRsWFu9Nb2UQOtV1rsfum7WicK2CVjuN9
         r9mV6dKAbrecjyh203CmYy3fgy7h3dyBim+BRpBzBpxu/LnSzgDuheSz0qOJpEy+Kx2a
         /6IerouVGNem6pDupG2wvTkyhjXc6UgUgyr5mKRVQTSnJIzWDOkzSnlTgXhxXAS5/34e
         h5kg==
X-Gm-Message-State: AJIora+3/DlsOkKF54i+WmV2EHxH1HCUpz6HePMnDhpHl0FKadz3C3pp
        PDza/38nfQl0+kUAHakAhWwHT1rsrRKsfw==
X-Google-Smtp-Source: AGRyM1vaCEYST0pbNKarU3LCLV6amip8h15gSNbCyd5v/aJWii9Z1EyADiyxZ/bSZQJ7PfwbpdLpNg==
X-Received: by 2002:a05:600c:5022:b0:39c:7f6c:ab44 with SMTP id n34-20020a05600c502200b0039c7f6cab44mr20324271wmr.97.1656409632836;
        Tue, 28 Jun 2022 02:47:12 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b0021b866397a7sm13425784wri.1.2022.06.28.02.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:47:12 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:47:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 01/11] mfd: intel_soc_pmic_bxtwc: Don't shadow error
 codes in show()/store()
Message-ID: <YrrOHtDjI+P6Iq0r@google.com>
References: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
 <Yrlyw1eMFy4kd0JB@google.com>
 <YrrNxEIMuYLpzCd1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YrrNxEIMuYLpzCd1@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022, Andy Shevchenko wrote:

> On Mon, Jun 27, 2022 at 10:05:07AM +0100, Lee Jones wrote:
> > On Thu, 16 Jun 2022, Andy Shevchenko wrote:
> 
> ...
> 
> > > +	ret = kstrtoul(buf, 0, &bxtwc_reg_addr);
> > > +	if (ret) {
> > >  		dev_err(dev, "Invalid register address\n");
> > 
> > Is that really what failure means, on every failure?
> > 
> >   "Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing
> >    error."
> 
> As far as I can see in either case the address is invalid.
> Basically we may drop this confusing error message here, if
> this what you prefer.

Your call.  I just wanted you to consider it for a moment.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
