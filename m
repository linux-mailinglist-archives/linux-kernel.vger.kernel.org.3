Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6691751BB17
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350678AbiEEI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345018AbiEEI6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:58:46 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C450D4AE08
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:55:06 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id f2so4046921ioh.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XRbImXS7yZjOSKJpbk8D2qEogzCI5zzUCNGCXkZ4ORI=;
        b=itRUh1dwQfTmRruVf3tQRZTPHU7Q3LOQmD46K2PgD63vClU5QD1rKPPIjkhgtLXcuB
         b/DTrLyF+Zv4hWALhGeK13DLEj9w2CPGWsdw+DPkgS5YcTKdH4ODYx6Dib5R1UkVZg2O
         phpswVF3Zi0Eaqu52fpaMAOJXJQinwJvhUB2Ly7tNCVqb2YBT+tu57hcTnWvYaf49OGa
         zQFFXlZ7SawuqXjPhrVYSu1S+HF+r3uiA94IZ4dl4sVsVHlrGd7YpZW8pRxmEKc4nwJr
         owZsh7QYjRj9Bwc259EmGttM/+0UWE9ABmd+dMEQt2Hf05KbbZwwyk20anpZobX0p8bC
         JzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XRbImXS7yZjOSKJpbk8D2qEogzCI5zzUCNGCXkZ4ORI=;
        b=KzcBdTkq1WNafVy4nSI8C+WH8nKFEny4Xem4po5OCdowlWmnY2ThqTRTXp80gNjJ41
         mnXagSOBy0S1xrceGzO7TPwt9bld+DdPT4JV1FdgHem6zt3yEMMrauFip8lHD5aXBaFf
         nTula4wQp4r91XtBlQB/TngplWc5yZr57QtRirdwtOVH2iakn9HNQgeR0icVD3zz8ajP
         2Mgu2ZtiKiprnETo+vm/znmGBA74dCdQGQW+3m2iYxT2J7biaampLrS2yu3qTHisf+2t
         bJh/cQoTaCGlZFePq5XGOp4YHGMHLaQ6173+Q+eWfprysRr5Xf5uuzPBq0ss0A66AkzL
         eSUg==
X-Gm-Message-State: AOAM531zN+IoltBqxe/qsajRaASVudJa+40VMUHQGqF2c1+71SY/j4mv
        kPHXkFWqESlAVdCxU4CnJte4dAxuIkTGlQ==
X-Google-Smtp-Source: ABdhPJxk2kal36tmSOj1u1bseqzNs8vNHgDOt6a/BDP1nICDYU6wjZQCZwyllBJW4uJTWz/H755R5w==
X-Received: by 2002:a65:490d:0:b0:39e:58cb:b1eb with SMTP id p13-20020a65490d000000b0039e58cbb1ebmr21792988pgs.390.1651740298043;
        Thu, 05 May 2022 01:44:58 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902e84300b0015e8d4eb267sm935629plg.177.2022.05.05.01.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 01:44:57 -0700 (PDT)
Date:   Thu, 5 May 2022 14:14:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] MAINTAINERS: Add entries for Apple SoC cpufreq
 driver
Message-ID: <20220505084455.x575yl2evgty5x3j@vireshk-i7>
References: <20220504075153.185208-1-marcan@marcan.st>
 <20220504075153.185208-2-marcan@marcan.st>
 <20220504101750.wmuicq3dytnxrw5o@vireshk-i7>
 <e0445aa6-0c96-b80d-154e-274be0c1a025@marcan.st>
 <c374bea4-554d-2e50-4ac6-fb4a2e4fec67@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c374bea4-554d-2e50-4ac6-fb4a2e4fec67@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-05-22, 10:42, Krzysztof Kozlowski wrote:
> On 04/05/2022 16:52, Hector Martin wrote:
> > On 04/05/2022 19.17, Viresh Kumar wrote:
> >> This should be the last patch instead, or should at least be added
> >> after the files are merged first. If someone checks out at this
> >> commit, the files won't be available but still linked here.
> > 
> > Isn't that backwards? 
> 
> No, because we have tools for checking valid paths (in some places), so
> when using that tool, the history is not bisectable.
> 
> > If someone touches the files, we want them to be
> > able to get_maintainer.pl, so the MAINTAINERS entries should come first.
> > It doesn't really cause any issues if there are entries that point at
> > files that don't exist yet, right?
> 
> It hurts any current or future tools checking for valid paths.
> 
> > 
> > Though this is mostly a moot point because the purpose of splitting this
> > out is so we can merge this one patch through the SoC tree, at which
> > point the ordering isn't guaranteed (unless the whole series goes
> > through SoC). 
> 
> Just add each path change to respective commit adding that file. It
> should not be a separate commit, at first place.
> 
> Separate commits are for adding entire Maintainers entry.

And there is no need for this patch to go via SoC tree, we can handle
minor conflicts later on if required.

-- 
viresh
