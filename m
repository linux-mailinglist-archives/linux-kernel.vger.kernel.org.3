Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E575357D9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiE0Cnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiE0Cng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:43:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8F3E27B4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:43:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cv10so3402681pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tCbjiRdRJoa16DjQmzqPUCTmyJlX3Xm3EGzU7SZYB48=;
        b=unI1dKwt13z46NWgVcF/f6pY8q2na7j7rEnLYqAopnP8WrbK43li4m/7OrNqQgY9L1
         tg/JstaAehFqkxIwHpJgys1nBKK+Ie+D6igCIYYx0nkp4UBbjuH/S7khiG+IbDISFjzp
         jd7+rzQiMg0GyPVwsjNcF1wCq5aPT2cpJRJ9yKA8u3b8h/xMHogF7ylAtLtEUfs1bSl8
         Ep71Vjn4mZmTU8BFCJ8aOVE6zRDP0m7jk0M1a2nkrIj3rVzJaJGGPmWJDjTljv+1g2H0
         w34qphgI5t2B+h+EsIUXiwkTJmJOWcoVPxQ8jHiK75fn4LEC+P2fNcXxgMii8P3srV/s
         HnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tCbjiRdRJoa16DjQmzqPUCTmyJlX3Xm3EGzU7SZYB48=;
        b=bkxOCQC3v3GKRnINRhnYn8pU0A+dc3yPPwAAE01ZVkAhx2GMPNRAVDPTaqPVkzQATo
         RE6dlAZBRJuf3SkPP5ewT2cVSRWJv1Vl+OVqe0byKtfyevjHyvDhx0atXLRfAm9LJuP6
         puPXGZZS6QvS5GRy3nvvZXjiP4eYcGDSLbV8cJZ0B6sZTQA4Oe2ZyuSY9ujKbbFnUcv9
         rsris30gVhOnwkIqQwDd5kHoPc3cmxH5jqosN8/TiWmtoM5xEf0+O1U1+gUKPYhmhRLe
         StUou9nWywodLvZTHncRTIwKQbhCy9Y9fBF/6Upa0s7xfv7q4QB3z4pqyV3GZTyeMkRn
         DaoQ==
X-Gm-Message-State: AOAM532ZgTazo/YWRodMG+PWjD1JXJEMTmy4ztI8nmfDxlrQuvYz3sz5
        QpwQ6Bued6QGsnaUCDsmtOXaFQ==
X-Google-Smtp-Source: ABdhPJwTBXjt8npUnZjAyIbizyejh0fXkxDPHH1uh3aRf1Bdies2ajElDTSMQ5AtJ4B6lGs7lFNjuA==
X-Received: by 2002:a17:902:d483:b0:162:3f26:7fb3 with SMTP id c3-20020a170902d48300b001623f267fb3mr17006488plg.82.1653619414325;
        Thu, 26 May 2022 19:43:34 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id q31-20020a631f5f000000b003fae8a7e3e5sm2178914pgm.91.2022.05.26.19.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:43:33 -0700 (PDT)
Date:   Fri, 27 May 2022 08:13:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 18/31] media: tegra: Migrate to dev_pm_opp_set_config()
Message-ID: <20220527024332.u7kuuudaccade63s@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <67b10cc516558405bfff0fc7749cee9d3bf02fc0.1653564321.git.viresh.kumar@linaro.org>
 <f92bc466-734e-b040-b8d5-0add023fe341@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92bc466-734e-b040-b8d5-0add023fe341@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-05-22, 14:57, Krzysztof Kozlowski wrote:
> On 26/05/2022 13:42, Viresh Kumar wrote:
> > The OPP core now provides a unified API for setting all configuration
> > types, i.e. dev_pm_opp_set_config().
> > 
> > Lets start using it.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/memory/tegra/tegra124-emc.c | 14 +++++++++-----
> 
> Wrong subject prefix - it's memory.

Oops, fixed it, thanks.

-- 
viresh
