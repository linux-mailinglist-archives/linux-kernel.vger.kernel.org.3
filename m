Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D4459ADCA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346122AbiHTMFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 08:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346079AbiHTMF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 08:05:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6309D126
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 05:05:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jl18so6179138plb.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 05:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=UmPuZ8O3dYiyD+vc1priW5cqdq1OYTozHJW9fGRlTUA=;
        b=bpr1HVUXbpGrVM2Q6z1JZBZ/Mo90PI158qYLneoo596+GUCCEnh77lYzufDco7VIIk
         4IbphxsHfE3FPqQKT+dYjxdUYaaiCByl7PdiAdCb1Bh04VvaBRUD+R+qrcUFcpbBE6J9
         6hnsFNgOjkXfIiMtImEGDyJfRSnCDZpHfUh0hPA6hDOduY985x8AL7plNOBTz12n5aTc
         0YjerZ7y1Ibjces+hb8BRX5sDLVlT1ZxLk8IiRjHBqLNBUrnTyA9Xf3upmbI3TftscBv
         yoPN8D9rsMXE6MSc/ClMZdyV15posxLNWSItMO3C81ukz7a5iLTBSoqPFWSyOcre25JP
         qd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=UmPuZ8O3dYiyD+vc1priW5cqdq1OYTozHJW9fGRlTUA=;
        b=033rS7lk3WtiN6+S3fAytksGgPDzPTQDw06BBHVHv+bHyRF0Dx7bbK+ORAlTH2wCX/
         lUMXciVCxHe/AplwiMyU87vZtqI/h3sPOue/4jL1Y3GNUjJ8SEmdjTxFb8WLQ2f90Hc+
         +oq73WC7Ne220CE3+eDXDnBErzceY8AlQ5SOvXz7GT1zUAC7VuCuOtFzgjcPLpg7TC8A
         F2q+p6/u97S12kKK/ygIoWVMQDUFMxDq1KGxJpdkb73VboGydPoyt5wHgQPvNfdgqQBD
         wITiqza10CkTaZYmiu90re7zg60YrPRcbH4MWH1OSCWRcS9M985LBDZBjqIib321P4FI
         A+DQ==
X-Gm-Message-State: ACgBeo0umJLWfhE9JEcqG9IiREudssmdlNhium3ZexzVu5hPR3stWKZD
        9IxUnwWBbz+IaPgeF+++1EZ2
X-Google-Smtp-Source: AA6agR4tK/FDR2wHHLaIhkJLu5ClWsXN18j5ZVIZlrKXr4A9g1wFRHMDO/I6eb7YX7tDhCvIadL3oA==
X-Received: by 2002:a17:90a:6308:b0:1fa:b280:7a45 with SMTP id e8-20020a17090a630800b001fab2807a45mr19229018pjj.159.1660997125839;
        Sat, 20 Aug 2022 05:05:25 -0700 (PDT)
Received: from thinkpad ([220.158.158.232])
        by smtp.gmail.com with ESMTPSA id f68-20020a625147000000b0052a297324cbsm5093474pfb.41.2022.08.20.05.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 05:05:25 -0700 (PDT)
Date:   Sat, 20 Aug 2022 17:35:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kishon@ti.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mie@igel.co.jp, kw@linux.com
Subject: Re: [PATCH 2/5] misc: pci_endpoint_test: Fix the return value of
 IOCTL
Message-ID: <20220820120520.GD3151@thinkpad>
References: <20220819145018.35732-1-manivannan.sadhasivam@linaro.org>
 <20220819145018.35732-3-manivannan.sadhasivam@linaro.org>
 <Yv+qSDUEs+6T8b9+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yv+qSDUEs+6T8b9+@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 05:20:40PM +0200, Greg KH wrote:
> On Fri, Aug 19, 2022 at 08:20:15PM +0530, Manivannan Sadhasivam wrote:
> > IOCTLs are supposed to return 0 for success and negative error codes for
> > failure. Currently, this driver is returning 0 for failure and 1 for
> > success, that's not correct. Hence, fix it!
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> This needs to come first in the series,

Yeah, I thought about that but then I had one more patch touching this driver
and if this comes first then that patch should be at 4/5. I was not sure if
that's fine since two patches touching the same driver would be at different
positions in a series.

Anyway, since you said, I'll just move this to 1/5 and other one to 4/5.

> along with a Fixes: tag, and a
>  cc: stable tag so that it can be properly backported and fixed up
> everywhere.
> 

Okay.

Thanks,
Mani

> thanks,
> 
> greg k-h

-- 
மணிவண்ணன் சதாசிவம்
