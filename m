Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91651EF4B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiEHTIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379417AbiEHSoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:44:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6BBDF40;
        Sun,  8 May 2022 11:40:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p12so10508341pfn.0;
        Sun, 08 May 2022 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=k+SEgZtU6OqEyglEHf513mkMo6bNpZuHdtrr6hv8Nq8=;
        b=SAISvop68z0vD+mD4/R20kGa98LoxlJ+uBQk0DwsI/NyJTYD4AgTjvxG/cZhEyCY55
         QQ3SLLUjtdJgU0qiyWSXJwBQJ1Dm1Cqw9gC6hbJpC+Ys49b5zv2oQx9sTlFh3uZk9I9q
         Dc5NC9mWIxfyvsYQPbdctiRdViKHc2567iQIdjzj7Rys84xVnudPom0sITZGL2N1PLXK
         NOFdhrTejbSV8+TyQlL4p9MUJq3Ezd9ryw9wHeHjAGXwv9b6bqVYbkx3rRfcAhF+F0z5
         6f/0ckPo16wbrbpb8DeCKrh73d/xV0AlWEKIpkIfQBKC9JwMhGYrUlLbxmIdiMhvU25a
         G5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k+SEgZtU6OqEyglEHf513mkMo6bNpZuHdtrr6hv8Nq8=;
        b=5tL2NlzNIHeaNRzZYvwLByTNgWQib5+IovFmClCyf9XptGsCwb8xWkFqS27Kz6YCdh
         rIykPXtMhFiInMA5VMrKgJsAJg84DGLbfwHx7xmWtm1Xb0JrgiX28G621SxSXnovVXff
         kcIdDI3j5ReDtMml+rO/HjIB9+2izsNg96oA896P0woNQBYEuHyhuv2Gknc6Ms/nvJb8
         GJLjYpv1TpfOK2oI6+GW3cac+QBiuNcOr86o3BYGticVCQBY1qcMeUKNU1ws1IjWpOH5
         dusN8PsT2doL6LOZUY+fdMYRMZDL5c9FxFTA/FJJKkVdYOSZulzlmA6cf+K5mNIVSY7u
         MK4A==
X-Gm-Message-State: AOAM531JDlUhNaEY/ITLnW2YkUtD3MbCdUw/W9acVLzbA4eJ/THap3Bv
        rgNXv0hi851wfELqhqw+xBI=
X-Google-Smtp-Source: ABdhPJzlbs1CoS4KmQp8exvRi+/96RIvfDY0MOLHGDeTBFMfC636egYHAxJMCYFRKhQuaQwr+BNoFg==
X-Received: by 2002:a05:6a00:b8b:b0:50d:6080:6be7 with SMTP id g11-20020a056a000b8b00b0050d60806be7mr12703385pfj.56.1652035213112;
        Sun, 08 May 2022 11:40:13 -0700 (PDT)
Received: from [172.30.1.41] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id s186-20020a625ec3000000b0050dc76281a2sm6970759pfb.124.2022.05.08.11.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 11:40:12 -0700 (PDT)
Message-ID: <2b8f0e62-ab3c-23bd-f9e8-590df3af12be@gmail.com>
Date:   Mon, 9 May 2022 03:40:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 0/2] rockchip / devfreq: Coordinate DRAM controller
 resources between ATF and kernel
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20220406014842.2771799-1-briannorris@chromium.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20220406014842.2771799-1-briannorris@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 22. 4. 6. 10:48, Brian Norris wrote:
> On Rockchip RK3399, there are a few hardware resources that are shared
> between firmware (ARM Trusted Firmware) and kernel (power domain
> driver) that need to be coordinated properly for DRAM DVFS to work
> reliably. See patch 1 for plenty more description.
> 
> These fixes are based in part on the specification in the RK3399, and in
> part based on extrapolation and observation. Any confirmation about the
> behavior of PMU_CRU_GATEDIS_CON0, etc., is welcome.
> 
> Otherwise, see the patches.
> 
> Regards,
> Brian
> 
> 
> Brian Norris (2):
>    soc: rockchip: power-domain: Manage resource conflicts with firmware
>    PM / devfreq: rk3399_dmc: Block PMU during transitions
> 
>   drivers/devfreq/rk3399_dmc.c      |  13 ++++
>   drivers/soc/rockchip/pm_domains.c | 118 ++++++++++++++++++++++++++++++
>   include/soc/rockchip/pm_domains.h |  25 +++++++
>   3 files changed, 156 insertions(+)
>   create mode 100644 include/soc/rockchip/pm_domains.h
> 

Applied them. with Heiko reviewed-by tag for patch1.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
