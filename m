Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC14CB5CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 05:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiCCEG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 23:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiCCEG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 23:06:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A237D163D6A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 20:05:42 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id bd1so3389814plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 20:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CIp7VVuWt9UyGTVpPLb7+VHA+YcMDNT9FMgsXkanxKg=;
        b=PhEeZ5ArChIlaQ8fLKd1T3w/HxXGqb9unw7hAxYEkfPFOO3AUp6fQVUkY7rFiuBc8W
         IFvXGH6wmPMkHdzJnzFqLt3fUZp/xc78RdLYhcpBdIcCPsWDIPWEE00/QOUwgI/3ytna
         G2V8FQbuFxN16+jOFY3dApIAd+5FJ79cW4eAOF5BQDEX6yvuh+ueoFCB52QgutqmY5Je
         uQRyuc4KMGrr9QRP0apbIso2Z0bx/6EdKgOzbBX66nsMi2J1tlhWHn63qj/4138mZP6H
         CAJ8+f1Ss5TckSxzwocuIRZZqwrVzCmrtTUcxZ3+p0dsK72hHJwqINP7vvlkqp7DnZpy
         YE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CIp7VVuWt9UyGTVpPLb7+VHA+YcMDNT9FMgsXkanxKg=;
        b=1ST1IevOgpy/2s/nhTQgFPIzLuQETCP2YYp8fJo+d+OOINpQiVmxbZycmUmmXy7tAi
         D4IVgzYRM2iXC4rwykaAWIq41LGOVxhUSzRNa8nYzE/1BHs7Qiy9KDjZx6bTD0xhhnvy
         VeaWwaLZDKlw/AhQy5d5kNZLO/K/iWjN4JEpw5Wx4VdWmii1Mm6J0qe/Qq5fTmdtgsFM
         TBJk8dr1NXrRSzP6i3jsfpq82j0Xui0jaYDFHHMWfLG5HQz+lUsTh9KTnWGP+7XufjH/
         jRcwPyNVmj2dbCf4a8vgViDVrqxX4TU9lcUBLKNXJ5HridpTd3YC/6wyA6J23/J8UGUQ
         eB9Q==
X-Gm-Message-State: AOAM530L/KqovOV+VitxH1yIDfzh1Z1jcsYWwkdvOwsWJRHMsnvnLJa8
        D395kSj7WNgdxmmx0J1cwilNfQ==
X-Google-Smtp-Source: ABdhPJxIGr193KVkbJwozHZtcGXgR2EUiiWeNS22x4PqNWxU3rWMb4wKTDN8yRE4MgGOUzHrJAJR7w==
X-Received: by 2002:a17:90a:d90b:b0:1bc:4ec7:d867 with SMTP id c11-20020a17090ad90b00b001bc4ec7d867mr3226102pjv.226.1646280342001;
        Wed, 02 Mar 2022 20:05:42 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id t5-20020a654b85000000b00373cbfbf965sm615600pgq.46.2022.03.02.20.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 20:05:41 -0800 (PST)
Date:   Thu, 3 Mar 2022 09:35:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Introduce "opp-microwatt" and Energy Model from DT
Message-ID: <20220303040539.ocnslxyswnvua3o7@vireshk-i7>
References: <20220302112917.27270-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302112917.27270-1-lukasz.luba@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-22, 11:29, Lukasz Luba wrote:
> Hi all,
> 
> This patch set solves a few issues:
> 1. It allows to register EM from DT, when the voltage information is not
>    available. (Some background of the issues present on Chromebook devices
>    can be checked at [1].)
> 2. It allows to register 'advanced' EM from the DT, which is more accurate
>    and reflects total power (dynamic + static).
> 
> Implementation details:
> Existing machinery in the OPP framework now handles "opp-microwatt", similarly
> to "opp-microamp". It also has helper exported function to get power from OPP.
> For the EM, it adds a new callback in OPP framework to use this new API and
> read power while having an opp pointer. It's agreed to work with OPP-v2.
> 
> Comments, suggestions are very welcome.
> 
> changelog:
> v5:
> - added dual-macro to conditionally setup needed callback and compile
>   on !EM kernel gently
> - removed 'advanced' word from OPP patch header description
> v4 [2]

Applied. Thanks.

-- 
viresh
