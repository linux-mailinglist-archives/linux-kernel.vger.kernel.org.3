Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92C753F86F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbiFGIoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiFGIn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:43:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1465ED029F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:43:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso20196944pjl.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 01:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nWZrrCkmODQO2L81wBptIQ/FtOI3FJ3gTRz0UShB7Jk=;
        b=eEf7h7znNG6Yj2uM2z78B+GTzNOp6+yxOEb/GEOn6YkJi5bZX54EU4z1RFLeM1aKab
         DJ/JDC8Z8HD33X7EJf0QZnlHM0oUQhWwewoq1nkT7iPfuuCURakz/jeYx+ylSSSxFVb2
         YTBvtKGyd0y59ocgBtXjgjs/Guq1gcmaPwWnTlUGncER6B8qfnJ+vZ5wThw083Ayzdi0
         H7S3cHlq84AEWdVoxrwq+Qf+gyXmiypjykOP81sAM0WRekz7ads66CRHP0+C6GpKFlEJ
         Wuc1q6vCX2zaLSvR0DxzHMEfbZQyOFz8dMKP050uvChyQiRwN6IEibPf0eTRTAFbbfzr
         xMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nWZrrCkmODQO2L81wBptIQ/FtOI3FJ3gTRz0UShB7Jk=;
        b=hC5BGqTxXWeWDjewWVhULU2TUvQAtNEtf7Q6oC+j8iBrZSdXxreOkfKTvVmGuPX66G
         PvWoLt93DazQjkZeRx9XG6zGeICtmEF6oCNZZVEB+YU4+zovRWUh1qyVDLrjXcgwmVEC
         tjWae1S4aJsRIVRGYHj6tTU5Q7T6hXmHg1UvomW+BmouwW074nCVATJmtQKeDXYeV1WF
         CMC34SeH6tWhVP1uDde8XH1rEpqYNdG9ax7WeIjGTgc/Mi/EoSljaAkwU2WvvTui2vX0
         kTQezCU3+pMyGpkyPntXlfWz1HxS63fR+OjFmo/oGrMEDqyQj1+Eix7TH3G0pLol8VRE
         /nBg==
X-Gm-Message-State: AOAM533bxrZKD3It0PZg0AyBeY48WQZr2ruKVdjWGQWiQeF3XB5oB/6J
        lNtptmwIG4CDps4cNShHI86EMQ==
X-Google-Smtp-Source: ABdhPJy2w9iMG3l1xy59r+1E/HWZi6vXpWRinRgoPn7ZlS022LmUN9BqNIjwVEqVFDIj62EinYv/0Q==
X-Received: by 2002:a17:903:1108:b0:15f:bce:19f8 with SMTP id n8-20020a170903110800b0015f0bce19f8mr28174271plh.7.1654591433595;
        Tue, 07 Jun 2022 01:43:53 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902e9d300b0015e8d4eb1b6sm11873231plk.0.2022.06.07.01.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:43:53 -0700 (PDT)
Date:   Tue, 7 Jun 2022 14:13:51 +0530
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
Message-ID: <20220607084351.i4s5veww6irmaf3t@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <4b38ceed657bfcf87ff9ab0dd69dd1f2f5658b24.1653564321.git.viresh.kumar@linaro.org>
 <793e49ea-aeb0-a47a-9fe8-742a6397bb35@collabora.com>
 <5c0e697e-abca-bcf0-cf68-d9c240d82527@collabora.com>
 <20220530075256.lpw6bhupejy2dnqi@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530075256.lpw6bhupejy2dnqi@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-22, 13:22, Viresh Kumar wrote:
> On 29-05-22, 19:59, Dmitry Osipenko wrote:
> > > Please keep the PTR_ERR_OR_ZERO.
> 
> Ahh, sorry about that. Fixed.
> 
> > > tegra20-cpufreq tegra20-cpufreq: failed to set OPP config: -1042688000
> > 
> > With that fixed, now there is another error:
> > 
> > [    1.761945] cpu cpu0: _of_add_opp_table_v2: no supported OPPs
> > [    1.761960] cpu cpu0: OPP table can't be empty
> 
> So we failed to find any OPPs which work with the hardware version of
> updated with dev_pm_opp_set_config(). I tried to follow the path and
> see if there is something wrong here. Failed to find that :(
> 
> > I see this on Tegra30, but not on Tegra20. Apparently OPP table
> > refcounting is broken on Tegra30 by this patchset. To make it clear,
> > there are no error without these OPP patches applied. I may take a
> > closer look if will be needed, just ping me.
> 
> Yes, it would be very helpful as I don't have the necessary hardware.

Hey, any updates on this ? I am looking to resend the series soon, would be nice
to fix this before that.

-- 
viresh
