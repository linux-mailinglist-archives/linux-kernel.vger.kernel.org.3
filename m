Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E71537613
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiE3HyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiE3HxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:53:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5148B3054B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:52:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so9980830pjt.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B2+w4CyIic04O74zsrr6J9+GENsUdcPxtqUHqciF3k4=;
        b=Q6l/LLUJpBKs6UbTNbbyAyCSplHUSXQg+QSc7jsKHgHPx+ORbJNODgrdDW4eT2ruJQ
         wBiAkAt+Zw0pjmdUoFjYoeliM4zzlYHvSuWeVG4POyrMu2tAgXdTrCYZPXcMXxSNooz0
         ZgnYSZ2o/8+Pu9cgADwesgYA+jTarZ5JxKT4YAg0PhyokaVxPqUn6tPYCi3we+cyBQ9K
         ZWMx0pt42nq8B9a15nMMRQv9/35W2WIX7O8M7jlBKMjQjANXJsQ7ItsavXzsIiHwF7hV
         2jpQt0tsf7tvszb5AWu7SUnnVSzgd2WIMq1lWpiYOLTWEF/9ZzeH8nQrmSM4vK31eamU
         E01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B2+w4CyIic04O74zsrr6J9+GENsUdcPxtqUHqciF3k4=;
        b=eflXD4V/osp9v/3WvCTfPlPeLV9QgnMVdUwQ2QZ+DZxT2t7UOjs12k7N017gFxBad1
         F9RE6T0C0wwGJdR7Wvl0VNMwWdY6Q+etjCaUSlojdd6zAK+G47gtCTG6+K1hxJuYGlcv
         BKsA5vE5o0TXcRp/tsXVTX1qIcihckByjRlaV+DtdDA0uRjWNUFpdzdGPDjVQcpYz+du
         8+UQdGelQICVxUnNsUV/A1TW+Ms1HbILCU363zm/yTOccPyYw31Tbdkp767b02ABGMSN
         JuMG6SoKIvoAABr0wJXGt3hc46ujsw+2F3kEvkwsYwj+1UYTHRZvbsC1RGblb4zWF83p
         Dq4A==
X-Gm-Message-State: AOAM533R2R73GHFbUWGSBr6Holl0An79XVUjpGIBvzxDpQVQABeiJmt2
        a/0mrmV6BqnNtGaTy0L1VuzPPQ==
X-Google-Smtp-Source: ABdhPJxXiWB4Udg+C4V+oB24Pg38eAB7p/6ABy0vwd/GBnFZwjfvY6tXy6qK8sBqrFdCIbsVNcdijA==
X-Received: by 2002:a17:902:f682:b0:163:f4e9:5145 with SMTP id l2-20020a170902f68200b00163f4e95145mr430859plg.63.1653897178844;
        Mon, 30 May 2022 00:52:58 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id c11-20020a624e0b000000b005182deb6c1bsm8182208pfb.62.2022.05.30.00.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 00:52:58 -0700 (PDT)
Date:   Mon, 30 May 2022 13:22:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/31] cpufreq: tegra20: Migrate to
 dev_pm_opp_set_config()
Message-ID: <20220530075256.lpw6bhupejy2dnqi@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <4b38ceed657bfcf87ff9ab0dd69dd1f2f5658b24.1653564321.git.viresh.kumar@linaro.org>
 <793e49ea-aeb0-a47a-9fe8-742a6397bb35@collabora.com>
 <5c0e697e-abca-bcf0-cf68-d9c240d82527@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c0e697e-abca-bcf0-cf68-d9c240d82527@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-05-22, 19:59, Dmitry Osipenko wrote:
> > Please keep the PTR_ERR_OR_ZERO.

Ahh, sorry about that. Fixed.

> > tegra20-cpufreq tegra20-cpufreq: failed to set OPP config: -1042688000
> 
> With that fixed, now there is another error:
> 
> [    1.761945] cpu cpu0: _of_add_opp_table_v2: no supported OPPs
> [    1.761960] cpu cpu0: OPP table can't be empty

So we failed to find any OPPs which work with the hardware version of
updated with dev_pm_opp_set_config(). I tried to follow the path and
see if there is something wrong here. Failed to find that :(

> I see this on Tegra30, but not on Tegra20. Apparently OPP table
> refcounting is broken on Tegra30 by this patchset. To make it clear,
> there are no error without these OPP patches applied. I may take a
> closer look if will be needed, just ping me.

Yes, it would be very helpful as I don't have the necessary hardware.

-- 
viresh
