Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D66855D3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiF0Gpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiF0Gp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:45:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BE73881
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:45:28 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n10so7366789plp.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bH3Vt7XX7aybZeFwi1CTdnlCoZZeRmTfAiO/nez5hfo=;
        b=ykFyF40ED8ltV1C22vrrCu2Ahxrq6lDUEHVRJJMWmLISGsTYVnUmByK/WyYZAoFJEs
         B77swVbdEz6e+oEZpaCTgE7Hylf9Yb4qjD1AgGIoCJ8RD+MrjKrI5Jzy6D9vBdJplVae
         7c4aw1Z1c1SkbrHp2rQGTuUna8Soo5ErVHrT5kZo6hpBqOGkEiYtHauCfhmOFHxhV3E+
         zgN/C30pAgiLj6MF5qA727QeEDMlQ1tRsxevl8fyMpQ981JkaJ8cqYjKcrHG0nMcghWE
         P9Yz0E5CiyTfhYjTcXLUNV7+9waiX+sM8Fhix46lgrs218sgFUTqtBihxvmnWEXWe4aY
         xJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bH3Vt7XX7aybZeFwi1CTdnlCoZZeRmTfAiO/nez5hfo=;
        b=KiWpqH9j7vXp5zcN5IFUp9W9f9hhhr2dnXzwPz0tKecs3PSfKG+kwLnCyh6jisvcxh
         045F4X8Dy4OZz5lOry5DMFLnW6iac8TqSjiQn+FpH6U8Bw2ATcGEqRzvU48Kai/fnDDc
         eoHrY18CWjE87lSJ+KyAB+SCBTCI+Hg136HAcZxhzzXYBYrf5wIf6UqBLh4naPoBCqZu
         1fFImUjNMrEf6/zeqaV/UEA1lGR8yPJCJZTPlj93xUub0dFPHZA+/EVT0jAeVBI4R/hM
         yxDHbm8hECZ7BM7MBvvEOE1sipYjx1i0x8m3UVyHYjmtLpodtd8IbI1f2SYV2NicvwQM
         iszQ==
X-Gm-Message-State: AJIora+MgdoQAaETo9jIBevXePV1ulqIf9DfPFNh1p17QVOIZjCnuhNQ
        n2UW1wgp3DmU74gtQ7b3ghl5Jw==
X-Google-Smtp-Source: AGRyM1skjSIr2LG5qz1p7HriNtf5RQBG+zI/jwqerqVBvWNFUvR0glyAewRI0itDcsi27L2Yi8fzKw==
X-Received: by 2002:a17:902:f20a:b0:16a:22ef:b17f with SMTP id m10-20020a170902f20a00b0016a22efb17fmr13305957plc.168.1656312328184;
        Sun, 26 Jun 2022 23:45:28 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id jf5-20020a170903268500b0016a1d007637sm6295143plb.110.2022.06.26.23.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 23:45:27 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:15:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/31] soc/tegra: Migrate to dev_pm_opp_set_config()
Message-ID: <20220627064526.2nkezq4nufpkl4y2@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
 <20220624004831.po35sowzfo4c47b3@vireshk-i7>
 <20220624005700.oj4etaajbutvsym7@vireshk-i7>
 <73d39022-c6fc-0c21-cb68-9714846f02bf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d39022-c6fc-0c21-cb68-9714846f02bf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-06-22, 01:14, Dmitry Osipenko wrote:
> Looks okay. If you'll solve the cpufreq problem where OPP config is set
> by two drivers for the same cpu device

This is supported, there is some early freeing of resources on the
removal path though, the reasoning for which I already gave in another
email. Though, I am open to sorting that out as well, but nothing
breaks the code for now AFAICT.

> and will keep the set_opp()
> helper that is needed by the Tegra 3d driver, then it all should work
> for Tegra.

I have responded to that as well on another thread.

> Looking forward to the next update of the OPP patches, thank you.

All that I have is already pushed to linux-next, I don't have any more
changes. Yes I still need to send the updated changes to list.

-- 
viresh
