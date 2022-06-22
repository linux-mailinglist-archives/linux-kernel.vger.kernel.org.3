Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0979554C30
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357882AbiFVOHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiFVOH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:07:28 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96486381B0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:07:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jb13so1910770plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e9oD0W0ylRYnkIlTyiKZwIapNVPUeC7hKoZrwz+0k8Y=;
        b=rc8s6ZIwt9RUA9gTUANp/tC0i4E9+YxpvS4tpGBDrQNBgjZ0eTnPSoj5FBbFcaxiWT
         0sH3ckRQNBBTBzaa6Xyb4MLHztJGB3DX4RnZrlNEl+dohrhjX42bNi60gasOnADB6E+v
         9lydJ6EKoFifKzMstT3ABLjNsuumcURA0fzgZzbD+7BmO9GYWVB990JViJcY+gaNXUnq
         jTQ6hNdIZ9CaCOnsTEs6YMlbZFVXbYT2lA9/6D/+U8G5fnBL9YCmSMxtSlCxfUQHT65Z
         dHOCQgXeFPw/LYlcme2wHVwPTOsVh7M7AcGFUFNbWnI6mM2dIRTztCnvJ/zM6wYAX4gg
         TkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e9oD0W0ylRYnkIlTyiKZwIapNVPUeC7hKoZrwz+0k8Y=;
        b=n4F/ESNoCHClBekMSlPXWkYbd0W2VMKUCEX4++KsHshKKQLPs8pHIEN2ByjnYu8rOT
         fZpRIqxZBMU+rVlj8MTSRvbKhv0h7Je8UPWiz6OxHLKmng+h0ai0B6KtYmDp6K4eQK3P
         rmF51oNhpcPjvn4mRIhj3fALO99c8QCbDPeSo+YgaxVzx0kGYn0j5KGM9eihfKXprgTC
         xJxU8JmmUMUZ7RGgIaUGmbDp2c2K5QckRNX8FbxAD3nqYl3kn1yCa2fvechycsgHupFI
         MvO5dj3Mpf+C3gcuU/IdiPIz2kDTNl8+FVgQn3u+VI13mJcIqObEK5WjcCDtBNR/BqEc
         tINQ==
X-Gm-Message-State: AJIora96fIqjn6E6HrDLGzVl5RNwqGn43U1J4ZSwRuuhOvU57mWPTvZh
        B1eNQXLw2FIS5bpQkiCGVIzagw==
X-Google-Smtp-Source: AGRyM1tNiYBj57sFkmJtXiMiuQlgRK9d7swr7qhm/sS8KIyogJ13HhMpOsZ4wLTWDH7PPHj4ALFQBw==
X-Received: by 2002:a17:902:e74b:b0:166:4d34:3be3 with SMTP id p11-20020a170902e74b00b001664d343be3mr34821376plf.102.1655906846962;
        Wed, 22 Jun 2022 07:07:26 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id mp15-20020a17090b190f00b001ec92c52285sm7633207pjb.21.2022.06.22.07.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:07:26 -0700 (PDT)
Date:   Wed, 22 Jun 2022 19:37:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 3/8] OPP: Reuse _opp_compare_key() in _opp_add_static_v2()
Message-ID: <20220622140723.msm3sxsuvtshotld@vireshk-i7>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
 <2e335a6c263704a8d465bd02896fc5fff0533fdc.1654849214.git.viresh.kumar@linaro.org>
 <eb9558fd-4f2d-4e83-f9a3-86ff5dd51784@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb9558fd-4f2d-4e83-f9a3-86ff5dd51784@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-22, 14:58, Jon Hunter wrote:
> FYI ... if I checkout commit 00d776d33da9 ("OPP: Reuse
> _opp_compare_key() in _opp_add_static_v2()") from next-20220622
> it does not compile ...
> 
> drivers/opp/of.c: In function ‘_opp_add_static_v2’:
> drivers/opp/of.c:933:25: error: passing argument 1 of ‘_opp_compare_key’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>     if (_opp_compare_key(opp_table, new_opp, opp_table->suspend_opp) == 1) {
>                          ^~~~~~~~~
> In file included from drivers/opp/of.c:22:0:
> drivers/opp/opp.h:228:5: note: expected ‘struct dev_pm_opp *’ but argument is of type ‘struct opp_table *’
>  int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
>      ^~~~~~~~~~~~~~~~
> drivers/opp/of.c:933:8: error: too many arguments to function ‘_opp_compare_key’
>     if (_opp_compare_key(opp_table, new_opp, opp_table->suspend_opp) == 1) {
>         ^~~~~~~~~~~~~~~~
> In file included from drivers/opp/of.c:22:0:
> drivers/opp/opp.h:228:5: note: declared here
>  int _opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
>      ^~~~~~~~~~~~~~~~
> 
> This breaks bisecting -next and so would be good to fix this.

Yeah, this was reported yesterday and is already fixed in my branch, along with
few more fixes.

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

It hasn't landed into linux-next/master yet though.

-- 
viresh
