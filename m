Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E79566220
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 06:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiGEEI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 00:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiGEEI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 00:08:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0999DE4E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 21:08:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s21so6417665pjq.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 21:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jlwigwlQcoYrdhkSBW2yT+ZrjXNWxDoG9Qdpdv63Uew=;
        b=bOFzd4V7IdTxyt1oHggTxGQErW7qbQZy3wf3TXGcorZf/khYnmfvymzgzeLCK7zxGr
         qWUS67+BzgMhud6EP93G5FhLZe6JoTJqSZskRMV0fuXBcEe/c/Y9y3/Nm7nDkOgQN8Ef
         ZH5QHllrTye9o5kvP3A65PQHqn6pJujKXzoogqxmAoknTGiiULqDvZFgxFYhcYFzr4u1
         Xh7yjcqGW/4KkoNTDmVDk3HBAyqbtcgNWNvDY7HtB0qPEn7kqI6AFG+Y/sfmJukGklfI
         2bpW0Xt3fvffhdLk+Vz/CKAwHA0yZm68G0IK+qL89On1kJEoIdHrJMAxrWa/bNluCt3d
         budA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jlwigwlQcoYrdhkSBW2yT+ZrjXNWxDoG9Qdpdv63Uew=;
        b=tdDu6JQHoXn05aMb0CqptvkPq4RhfeZ683aPDs7GfMFmpH0Wu8B85potsUZYD4HMtE
         UvUkhvJFTlvLzUP6Wkm/J01tdWPyFVPMjKmYtL2cqYOZ8jZFMW6UvRgbGVD3aTo4vkVB
         sdaosrVYXBk/p2SqaYhnd5Edjoc8gebZ+AhTWYBkZCi/pfDrr3nkSibDZRb0qqkEM4gE
         pMEebEnWSZVpgbSFB16A3JnNktrWV2fDzxhZzvqKQoLIf8/PG1lNaYEv/tUFhVf4Fr6U
         uX0rG/pVp5Znpw7Bf1moKvBL5n2HwjkXbboOlAdCkw8di5f0lwmEOIlaSO/+CWyNap8D
         AxNw==
X-Gm-Message-State: AJIora+ZIvGKX802I0Rn8M70Q+qtTMO7Lcko54WfcLDG26dE4X2PIQYA
        Ac1o4Hu+GQpOKGQGNOsIbI1pcA==
X-Google-Smtp-Source: AGRyM1tNI2QNHBytqnLJKVyWohCZSupL/dSQ4ZO3W5+QzMRn/9xTNXOmN0sXqWjo7ei3cYWMv/T6NA==
X-Received: by 2002:a17:902:c405:b0:16b:e7aa:2f22 with SMTP id k5-20020a170902c40500b0016be7aa2f22mr6341600plk.170.1656994104538;
        Mon, 04 Jul 2022 21:08:24 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709027ed600b0016a0fe1a1fbsm22257702plb.220.2022.07.04.21.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 21:08:23 -0700 (PDT)
Date:   Tue, 5 Jul 2022 09:38:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5/8] OPP: Allow multiple clocks for a device
Message-ID: <20220705040821.w5hrj5qmm6tbtpap@vireshk-i7>
References: <c6f100e4-8a35-ebf0-f833-06ff0d8a2fb6@collabora.com>
 <20220630005028.fddtcbkoksbygwc5@vireshk-i7>
 <8367c38b-8cd3-cde1-5833-874769ef3350@collabora.com>
 <20220630095245.otvo53ezd4avoujw@vireshk-i7>
 <b899ff5f-b424-5f44-7c94-deb013ff6bbc@collabora.com>
 <20220630101540.5dafkegrmcattt2c@vireshk-i7>
 <20220704120915.s3ermueulcofg7nj@vireshk-i7>
 <58cc8e3c-74d4-e432-8502-299312a1f15e@collabora.com>
 <20220704155225.n4kmgwnvsuksbo2p@vireshk-i7>
 <7c661c98-0cd2-1732-d60c-3202643926a5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c661c98-0cd2-1732-d60c-3202643926a5@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-22, 21:04, Dmitry Osipenko wrote:
> On 7/4/22 18:52, Viresh Kumar wrote:
> > On 04-07-22, 16:17, Dmitry Osipenko wrote:
> >> Actually the freq was 0 and it was 1 on the next loop like you suggested.
> >>
> >> Previously, the _read_opp_key() was always reading the opp-hz. Now it
> >> skips reading the rates in _read_rate() because opp_table->clk_count=0
> >> for the tegra30-devfreq driver the uses devm_pm_opp_of_add_table_noclk().
> > 
> > This is exactly what I wrote in an earlier email :)
> > 
> > Anyway, I have pushed two patches on top of my opp/linux-next branch
> > and they should fix it in a good way now I suppose. Can you please
> > give that a try.
> > 
> > This is how the diff looks like:
> > 
> > PM / devfreq: tegra30: Register config_clks helper
> > 
> > There is a corner case with Tegra30, where we want to skip clk
> > configuration via dev_pm_opp_set_opp(), but still want the OPP core to
> > read the "opp-hz" property so we can find the right OPP via freq finding
> > helpers.
> > 
> > The OPP core provides support for the platforms to provide config_clks
> > helpers now, lets use them instead of devm_pm_opp_of_add_table_noclk()
> > to achieve the same result, as the OPP core won't parse the DT's
> > "opp-hz" property if the clock isn't provided.
> 
> Works, thanks you!
> 
> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Finally, thanks a lot Dmitry :)

-- 
viresh
