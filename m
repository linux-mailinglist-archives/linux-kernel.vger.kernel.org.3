Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F4C572E92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiGMGzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiGMGzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:55:36 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C0E7A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:55:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r186so2427928pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LPiteU3ZIDPphGuDd6qhaM0GwMlw0tFWabPide3YTOc=;
        b=A/kI71ePqkRtbdh4z6E8oeAEwMemeTtnsPnzauycFrQoDgCe+7rvrRi8TQvwCXXNyj
         RFLSAMfWDCCpRvvNJBs6c3ToSnFVUsOCdltIm1Qbeux9Y6+Mn/i2mWVDL7LQa/yDFxqc
         EMO9vGsRsf509RRlWOkCehzKiYr0eztVxUhdbzmelL2SSbnuoE7CJd0ypVnzhGEIB4/3
         tJ9DsgdifTfpn787hTxrdhBpblSzUQ3Xueyk4JWpNBe3RVThL191Yt99vaZ/525Fve8M
         JrZhOZ8tnZgkMYMhXTj2Yum+vqffdzlakiEqSwY+d+i4ij90oU1zd2xP+t8wC75XE77n
         94Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LPiteU3ZIDPphGuDd6qhaM0GwMlw0tFWabPide3YTOc=;
        b=EaUM1uf9arSp/5qCURNfh9nFprR1nu8qQ386wvlLSwUmBDqUT4zYDAwNXQKc2B3BW0
         agDPggq7gc9u4fIuUyyJCpG9hn59oIZ5119TDk7u4T/VmDu0EaZN8/5r/yMRE6JAC05g
         6nUzo9z/7kNdFn4luS83Az4jT0baPgn7tv73+iHAWW0bRa1+agt1pDLIgpCzCqewIK6v
         G7/fsKenoOmjWen3vJHmKLTFRh+uLX2F8p+ffE3eeIadfhL8Nuw4TsJrHVa/9De2ms9G
         nAsb0yywt0PIKW3Saz4p3PODUeb6sDiSn2fUZMVFd7ZxdjkZclBHhQjLSL6/Tpoesr7s
         Ce3w==
X-Gm-Message-State: AJIora+8rLs3sh9hmvmU8L2mLWeyHSUoO7oCyJdH2pM8us5UPtL1AQmV
        KaMdvgkhhx0P6LavncjWQourwQ==
X-Google-Smtp-Source: AGRyM1uSwqDpVinLdL7ntciXJbFOuFBhY5TCrb7J80kwb6l2HhsFvOzbue+FzpiDNyS4smvxav+8Og==
X-Received: by 2002:a05:6a00:b8b:b0:51c:2487:57b5 with SMTP id g11-20020a056a000b8b00b0051c248757b5mr1916239pfj.56.1657695334722;
        Tue, 12 Jul 2022 23:55:34 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902780e00b001620960f1dfsm8061328pll.198.2022.07.12.23.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 23:55:34 -0700 (PDT)
Date:   Wed, 13 Jul 2022 12:25:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 00/13] OPP: Add support for multiple clocks*
Message-ID: <20220713065532.qncnjpj5isjmsxf5@vireshk-i7>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
 <YsxSkswzsqgMOc0l@hovoldconsulting.com>
 <20220712075240.lsjd42yhcskqlzrh@vireshk-i7>
 <Ys2FZa6YDwt7d/Zc@hovoldconsulting.com>
 <20220712151045.vn4tpat4c4cplndo@vireshk-i7>
 <Ys2ZVeBHyhrUBC4m@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys2ZVeBHyhrUBC4m@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-22, 17:55, Johan Hovold wrote:
> Ok, thanks for the details. I'd still look into if there's some way to
> avoid setting clk_count when there are no clocks as it sounds like an
> anti-pattern that will just make the code harder to understand and
> maintain.

Here is an attempt from me :)

https://lore.kernel.org/lkml/cover.1657695140.git.viresh.kumar@linaro.org/

-- 
viresh
