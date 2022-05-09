Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A13751F83B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiEIJdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiEIJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:15:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F85E184336
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:11:28 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g8so11722020pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 02:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7QpxuoVC9zQ059fU/VCO45VAfx6s8GhPEiX2c3POePM=;
        b=NcDYpNTw04yugULw2lGRPP8uvp5iDaWIg0Cp83izxqM6A+vpvp3r73InUADA5S/+yl
         /bUQgAbVun7lO/SrKqe3BscfTx87KV0KGXXOUtm05SEuQT2T/EzBfyBziD+Ru1pSxYxB
         uRheeODB9N5K98Z+wxZkt75t7PyiIEBycBKZiwdobxmqb20wJMq6/69yPJXXtLYiBUta
         p7NLsTeoh0mDe6rxbNgt23gvteCIu4YTAqeHIQTdeOWvQcu5t3cD5n6Q5aaK/JxJcWrw
         qwQLl3kimsJcId7BZDfqPXNvL/Aw5boIH8aoSWxaIuiyYhEyH5CRxIzACxYLjwd96QS9
         TttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7QpxuoVC9zQ059fU/VCO45VAfx6s8GhPEiX2c3POePM=;
        b=qM3BmDYHpbvT4Z8SluX9yggtcYG4uxt5PPZruDJcZiwzqzdccyo5zS89l5viwVYZ1G
         nKGdYZVY+K3nTfoCROVtqYOpyjdTImO7tYyoUu56h8zCXzypNOz5Mg81HzeACWj6hWCU
         ixIMDTUDeUhRwpNm94rwX3e0xoKubcfjtDXgZ82UX0gSDcdNXRch1J+czs0v4dzk00Cb
         cO642n301Lmg3F/f0Uw3jCeUJiihAAXqc8sN1LkwIxEODpm+HmwD+U5hK2wPJszGr3uu
         9ivGaxW9T700IFC3dEup24dqYOW4QtRcHemTv4M6qQQHklNynpRHdSapfhvWccLvMCew
         +yIg==
X-Gm-Message-State: AOAM53121xq0IeLyu2bQFy9tsVXOehC5GNaHPkzpup8J6535SrxTzxBk
        sItbAka4JbFr4NHCHt+A+Z2Ldg==
X-Google-Smtp-Source: ABdhPJxOwO6usL9axVziBSOIzqmZTG8IQH2ceVvogPLS2D4/RbZmODDEy76gkcTU+6D0WXe67qjY/A==
X-Received: by 2002:a63:d43:0:b0:3c1:475e:8341 with SMTP id 3-20020a630d43000000b003c1475e8341mr12236858pgn.533.1652087488293;
        Mon, 09 May 2022 02:11:28 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id h27-20020a056a00001b00b0050dc76281d7sm8361307pfk.177.2022.05.09.02.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 02:11:27 -0700 (PDT)
Date:   Mon, 9 May 2022 14:41:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] drivers: cpufreq: sun8i-r40: Add cpufreq support
Message-ID: <20220509091125.tps3zwaq276jlgh3@vireshk-i7>
References: <20220509084853.17068-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509084853.17068-1-qianfanguijin@163.com>
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

On 09-05-22, 16:48, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
> 
> OPP table value is get from allwinner lichee 3.10 kernel.
> 
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  arch/arm/boot/dts/sun8i-r40.dtsi     | 47 ++++++++++++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>  2 files changed, 48 insertions(+)

Applied. Thanks.

-- 
viresh
