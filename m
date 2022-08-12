Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F271D590B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiHLFMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiHLFMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:12:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344964C63A
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:12:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so6597660pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zNacVEXsqzKT8uPN/PxvboWwjSqS+MwFCYZdh4GOoOE=;
        b=VTGA3DQCFzJb1cgUEm/Q8H1WbR3898jJx6a92+b+sSghSuPClf1hhUyRTHYM7oHMYY
         BFwXRKpEFVMTCvdcoPxjgTRWpPaTbsA+J2aVPC38REINUlPrGvArR2/Z10tbNJGwh1tb
         e0gm+eZvZo27db+0+u2kMvrleLdLmE1DAS912WZd4s/H4OATtIYwJ/gUhG+LQNS40utM
         JlOI4pDpUbNgcDYoP/aRl68+A1zYQQ+4oROsF/vQVii4QVcwfVCF4FFtoPXArM3iUzDA
         wGj39063Q1e8juiFYC3+1g+Mr65Z3IWY0TlxWDQipcm/4dUzEcMq0VUkh0Uy/Xr1aBaZ
         L+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zNacVEXsqzKT8uPN/PxvboWwjSqS+MwFCYZdh4GOoOE=;
        b=i2EKDKm3rBWyKIJOzoLMunI1tvLDeaagQ6c4MhnUVU3bPucZUlK+BEu1WLGDPvAzLN
         6kEFz2fOEedey8rZSmY9bnNnguRv6ratMqSQmf/Hg2IyS8O1JujZzr/3kWGVjxLcrlGl
         6oq29+XtewPD57G0N0mASesv/FdvuWVzKtCUjseVPPwIY54bTke84pqurtH2G0tfKmvs
         D1IWMiTYa7KeOLncvoRnwwC+uVYRQWM++j4sFVOFnoHbgSiIRF525ojpUfvLTvsKcEaC
         o4bu2y/V0NbM2jd8/WPTBKsTyu8I4f0k7MzmmowT6zV+S61BkTpf+rsO0FQZK0mu5n5v
         JRmQ==
X-Gm-Message-State: ACgBeo1a8pp+cXLt9NObNFswTfmjmH+0V7uUSo+sLPi+h44d+a4ZrV4T
        X7oGlgmmsjlk6aMVPmWQbKegjw==
X-Google-Smtp-Source: AA6agR6Tq8vUG/JiVWntZX0SoFFXd5Luay0tKZEkGhNOY1jZTJ0fP9UNCFz4AiLYpvM+nBHzbeD9Qw==
X-Received: by 2002:a17:903:4051:b0:16d:c677:ecd2 with SMTP id n17-20020a170903405100b0016dc677ecd2mr2441305pla.81.1660281132555;
        Thu, 11 Aug 2022 22:12:12 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:4fcd:efd6:e25b:bec9])
        by smtp.gmail.com with ESMTPSA id t66-20020a625f45000000b0051be585ab1dsm606366pfb.200.2022.08.11.22.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 22:12:11 -0700 (PDT)
Date:   Thu, 11 Aug 2022 22:12:05 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] amba: Remove deferred device addition
Message-ID: <YvXhJRlHN9OAIA5l@google.com>
References: <0c6ef9a3-bbb1-9f1c-7f00-ceb05589594e@roeck-us.net>
 <CAGETcx8yKqEthtyd8Zb=mqMBNp1TPRXbQOoFp+OxeCoXnTs2kw@mail.gmail.com>
 <1196e002-c07d-44fd-b07a-aa5ae446ea0b@roeck-us.net>
 <YvQnbq2RhMOElQE3@google.com>
 <225747de-4348-58b3-19be-8b14356ab3a0@roeck-us.net>
 <CAGETcx895=9wPF+jnUfiycJ0k8d1S3BA0HLz42nCegtMBeo3LQ@mail.gmail.com>
 <971799be-8c15-fc81-ec71-bbca6483207d@roeck-us.net>
 <YvUzpSAQDktDPRbR@google.com>
 <YvVWEIn8veGL9Psa@google.com>
 <20220811195234.GA4018948@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811195234.GA4018948@roeck-us.net>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 12:55:08PM -0700, Guenter Roeck wrote:
> 
> Ah, it must be triggered by one of the configuration options I have enabled
> on top of versatile_defconfig. Sorry, I should have checked. Please try
> with the configuration below.
> 
> Guenter

Thanks for sharing your config options; I was able to reproduce the
crash after copying your config options to my repository :) The
following changes fixed the problem for me. Can you please give them a
try on your end to see if they work for you too?

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 90b31fb141a5..0315bc2853ef 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1117,7 +1117,9 @@ static int __driver_attach(struct device *dev, void *data)
         * is an error.
         */

+       device_lock(dev);
        ret = driver_match_device(drv, dev);
+       device_unlock(dev);
        if (ret == 0) {
                /* no match */
                return 0;


Thanks,
Isaac
