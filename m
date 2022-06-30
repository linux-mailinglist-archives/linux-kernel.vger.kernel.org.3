Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4FA560DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 02:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiF3AXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 20:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiF3AXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 20:23:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CCCE4E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:23:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i64so16569493pfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bDOI/zGOgy4m2A46KlbmsZQqwXs7u16Ivj5OzK4Omws=;
        b=dBAbOQvACTkWGpYJZOYa/5H1HMw07URAlIcpTn2jVmcLyMyX0d6J5/z3eVKWA25JrH
         J8BYM4elvOVARY+ou+ESfx4Wym+pWl0k7GW3DRQepmSXpJQk+POg9EVe+rVCKa/3uILR
         f2iDtBo+4pVPde+7owd6f5WGub2b8jDDwEO10azRYJyUzt5JOIDmf4gz6nFn2gAlPlRi
         Mw026bPJiMBkvM6zEK2H6MAMVHoBK2l7JrSFJSuOt7WH1lSN2IIf/RR7vG1aaCfSCnhc
         LEG4HQ4QOwrq6OpN5bNdk1L2eeLmu9g8uItUaAWxTQyUvfE0c/HXTdzf2yb9gFUobQlZ
         77qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDOI/zGOgy4m2A46KlbmsZQqwXs7u16Ivj5OzK4Omws=;
        b=LhwdAwen3wny6ckE9Iyd0nP0FbHJxE1+ks+hCxoV8xAREjXrCFYmePvnXhKLqQgnCM
         mu45PV+4oiOhMBuqkzIr9LoAd7uiF7utRYJfg8Gbs5RI8RMA4LCejJCPTaiIt0Z+QNZm
         gk68/W8FuGcjNPsVxA+vamxmNe5Hyyze0eZs+WzrOaNlyU1bX9YHrcTDXJ/AoMzH2pZU
         aejS1gFzYclCza9SKL7FUjXBLepRImjiHGEMStzTavTGYI1ut0cLTzRn2gDIs5+1SD/e
         B6bhslObqTZ2iRm8FdNR6413S0fyMuOvW2tQkyoyJwv+KOUuHbNnollR5nRox0NMpRY0
         Lp8A==
X-Gm-Message-State: AJIora/q2BmZxeN4tdrZdH3ZnVWTIRLEEANhQeKkJyvV3x3vSGsndCME
        eNoOXizVdpOTwHWZ3gscngriEQ==
X-Google-Smtp-Source: AGRyM1sxK5ymsefnvphBWk7lsdcyv9A0WQiBrMsM4q2L26HWA3zQJvGsemB0leRtjJVtuBmKMr3/6g==
X-Received: by 2002:a05:6a00:a1f:b0:525:3ad6:fb7e with SMTP id p31-20020a056a000a1f00b005253ad6fb7emr2137905pfh.68.1656548587355;
        Wed, 29 Jun 2022 17:23:07 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id 142-20020a621494000000b0052285857864sm12472325pfu.97.2022.06.29.17.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 17:23:06 -0700 (PDT)
Date:   Thu, 30 Jun 2022 05:53:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/31] soc/tegra: Migrate to dev_pm_opp_set_config()
Message-ID: <20220630002303.qdqzx2czz7d3msnk@vireshk-i7>
References: <449b344f037c7ef1970bc84d31e0d4c4cb4d2951.1653564321.git.viresh.kumar@linaro.org>
 <20220624004831.po35sowzfo4c47b3@vireshk-i7>
 <20220624005700.oj4etaajbutvsym7@vireshk-i7>
 <73d39022-c6fc-0c21-cb68-9714846f02bf@gmail.com>
 <20220627064526.2nkezq4nufpkl4y2@vireshk-i7>
 <ecc72279-0892-d5ab-689d-87b8fba5147e@gmail.com>
 <20220627072104.ir7kujhezxhzl6a7@vireshk-i7>
 <20220628070943.5tfyad63rh6niq6x@vireshk-i7>
 <a0155aeb-b209-07e1-747a-594a755f54fc@collabora.com>
 <f2acd51e-24f6-aa84-cfd4-372dd5e30aa0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2acd51e-24f6-aa84-cfd4-372dd5e30aa0@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-22, 18:03, Jon Hunter wrote:
> Today's -next is also working fine for me too!

Thanks.

I hope all the trouble with core update was worth it :)

-- 
viresh
