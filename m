Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5455D26B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbiF1LEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbiF1LEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:04:52 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD8130F73
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:04:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g4so4959155pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MtflUKKrotQDzDJ77cvNHXiJL1xHtvO05S39qsKv6XQ=;
        b=KrkYTBOp1b37GnM869FLJX729JJDnog9KbXXc3du2sux+Ekt4oDTPKDKjmgyHzmvnF
         jqUdZfegUdbX7XVx3Mho2Rt+A92v/QmhhhDM7G6E2WPYfKLDqlLnWXZ79TRVLPQqgtVF
         l4EwVgJ3LvQVXKvoQP9n/iStaTd7JfBED1rh2HsYNQDVd7ehEgTzm/f8+EpYuyQFbOQd
         xbdS2ybASDQmIKDVdP6qxxZ/k+9PIPdDmTwKlmBlC22fvPrZDt9Tl9v+qc1EMTqB883U
         nE/NBW1R+7Xq73a9D3LrKJsURP5R8YnVp1QxUh575V0gh1S0hicKWvmKuUympvTCknHk
         uRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MtflUKKrotQDzDJ77cvNHXiJL1xHtvO05S39qsKv6XQ=;
        b=oqX2w0hkok4tyx1S+dUctRvYpiln7mK4WJ9swYNFsbEUgifRRxEvTEPiLpRnDwb310
         MZ9lEj28iFHWgz+qYv8NMGKZoTkR8DUa4l2UOhwl+NcBr6BkfiNDBC/ynS3eK3+BXUx0
         naAYefETkfCehK8CkmrbxrBwbIWg3oQQd5Yn20RfTb512WCjCiISJ8xuSaDQgg90R6N7
         pNg9Evu+oA+U2Mk9F/L2Jx/y4fudbUnYCSQ5g7femo/PZDnG7XzXzN8H8mW4LTRoVjwG
         ljOvqtdtOtpmy1vTUKsFdbBxF0JdR7+nki6JvNTh0kiTZW+rj4LWxxv2OMwd8eF3fDMe
         Nyhw==
X-Gm-Message-State: AJIora+mhr6olyuutfCAsywRyAUIQWhhoudk+8o/XAoAycr79O4To/ki
        9vBBM1rvoyC8dYVylAD/klpbpA==
X-Google-Smtp-Source: AGRyM1unj6gY1V/LkKYDSb4ffybTNB6/cr1mPA3NNjalBdt+PwAQjEFzwunF9JbUp9meFzfqyKAubg==
X-Received: by 2002:a63:ae48:0:b0:40c:3775:8b49 with SMTP id e8-20020a63ae48000000b0040c37758b49mr17052176pgp.268.1656414290452;
        Tue, 28 Jun 2022 04:04:50 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b0015e8d4eb2c0sm8954795plb.266.2022.06.28.04.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 04:04:49 -0700 (PDT)
Date:   Tue, 28 Jun 2022 16:34:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, Keerthy <j-keerthy@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5/5] OPP: Remove custom OPP helper support
Message-ID: <20220628110448.bercnxgwjmoiebsd@vireshk-i7>
References: <cover.1653991004.git.viresh.kumar@linaro.org>
 <2e6ee73dbc8a231377547a8e9497561cadb38166.1653991004.git.viresh.kumar@linaro.org>
 <565ff879-11e4-1ae4-08d8-1237a875ef12@gmail.com>
 <20220627060636.rfpok75zydgcwwo6@vireshk-i7>
 <4a8114f7-4ee6-a9ad-f5be-ceaf64be8a0e@gmail.com>
 <20220627064155.jo7iqz5h33l7a4vn@vireshk-i7>
 <d18a1f18-d78c-2db8-9b19-196dc88978c2@gmail.com>
 <20220627071937.uneeudaqzo2aa2me@vireshk-i7>
 <d2a8c329-4469-f68a-5b4b-789a93725ea4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a8c329-4469-f68a-5b4b-789a93725ea4@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-06-22, 13:04, Dmitry Osipenko wrote:
> What about to bump the "by-level" sorting priority, making it above the
> "by-rate" sorting and then always use the first clock for the "by-rate"
> sorting?

The order doesn't matter much really. If there are multiple clocks,
then we can't compare just one of them. If we don't want the level to
be introduced, which is fine, then we need to compare all the clocks.

> Then the multi-clock will work for Tegra without breaking dtbs
> and those for whom this sorting option won't be appropriate will have to
> add levels to the DT.

There was a recent discussion [1] around this, where using level was
considered sensible for such devices, like Qcom UFS.

-- 
viresh

[1] https://lore.kernel.org/lkml/65a4c28d-6702-3a9f-f837-1ea69a428777@linaro.org/
