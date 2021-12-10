Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC91946FAF7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 07:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbhLJHA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbhLJHAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:00:50 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ABCC0698CD;
        Thu,  9 Dec 2021 22:57:07 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y8so5674944plg.1;
        Thu, 09 Dec 2021 22:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kR78Vf9G/BpR7pM6V254GxdHt+F2Tbo/465DsK1qwKE=;
        b=IFsqpF0iQ2yOjzbxp5S4JHaKVkeqOG4VTmlNuqN+jfmsljTZbfrMD/cJxRhBLvxi2a
         9K+6vhZRqofHqd7+ko6vYbnQABBIhEykYsTJ4olKQsu2gnm03Jd9Qb2WSG1Pj0fdeVh4
         ZIBAhnX0oC5/47PiOn4yuvxDXUrRNXvYI1Wheg7aveZD2YD/cQUArZvvQOZYUNq+XrkS
         3Hhkixu+Ugb+FuXK7kDYBrhOAsCMj5ybstU0moOAUeGO2LuEJ06nHEHgEbsBMWTe0sh1
         xLdNnvMVa7Sstb9nctQerCvPj2Z191aZFTfN91ywKuaEZRzF088NOe1Mjrsok476dDcZ
         dOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kR78Vf9G/BpR7pM6V254GxdHt+F2Tbo/465DsK1qwKE=;
        b=VU/LdqW7Hmn3SJxmUJqmHdjDXSza5KxKwELvWifzBk/vk/uq/1+sDvFP0T8ZoUn+ZU
         YU35LQk7xf3d/5TCbp1eKPbOjE50+35vSG3UtiJ04+im1A2VdX+GFWBIHxAXNzUUloNd
         xxA26ct3oauYgBU7g5lR1NE9QbnorB/7+tsjCrtKwbYxydSlLaiVbEn+HyP8GvpmlKxM
         z25PHUL0h/J5ucvxDxg4zPOtW/aiG+iSdjZ/0FRVp5XgnJIyhZKa9CfIlvSNGnfeKRDt
         qsoObEv6XwkuJklEqFoBbLB6QA+UsZnPDh2p37+SSbXjZXsOzcQt+CMjGEAbhhX7UzkS
         kLAQ==
X-Gm-Message-State: AOAM530qpD9mtiFOfSplOfbPbTT0U3Mu4wq+c10cEGRHnBs7FimakjUQ
        ZpIhVPdBlqsltGPGJR/bQTPHDhnYz5U=
X-Google-Smtp-Source: ABdhPJzQqiZpOZPRrLmfyUo+pIckIWEO48+EG7ury7tg1kbEr0hT0s/WZydwAB+KsAjlmhJlrwMUgA==
X-Received: by 2002:a17:902:e0d4:b0:142:8897:94e2 with SMTP id e20-20020a170902e0d400b00142889794e2mr73277767pla.58.1639119426164;
        Thu, 09 Dec 2021 22:57:06 -0800 (PST)
Received: from [172.30.1.18] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id i191sm1571372pgd.90.2021.12.09.22.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 22:57:05 -0800 (PST)
Subject: Re: [PATCH v3 6/6] PM / devfreq: Add a driver for the sun8i/sun50i
 MBUS
To:     Samuel Holland <samuel@sholland.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20211118031841.42315-1-samuel@sholland.org>
 <20211118031841.42315-7-samuel@sholland.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <21922806-e64c-1c41-1373-55603604cf34@gmail.com>
Date:   Fri, 10 Dec 2021 15:57:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211118031841.42315-7-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 11. 18. 오후 12:18, Samuel Holland wrote:
> This driver works by adjusting the divider on the DRAM controller's
> module clock. Thus there is no fixed set of OPPs, only "full speed" down
> to "quarter speed" (or whatever the maximum divider is on that variant).
> 
> It makes use of the MDFS hardware in the MBUS, in "DFS" mode, which
> takes care of updating registers during the critical section while DRAM
> is inaccessible.
> 
> This driver should support several sunxi SoCs, starting with the A33,
> which have a DesignWare DDR3 controller with merged PHY register space
> and the matching MBUS register layout (so not A63 or later). However,
> the driver has only been tested on the A64/H5, so those are the only
> compatibles enabled for now.
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>   drivers/devfreq/Kconfig          |   8 +
>   drivers/devfreq/Makefile         |   1 +
>   drivers/devfreq/sun8i-a33-mbus.c | 511 +++++++++++++++++++++++++++++++
>   3 files changed, 520 insertions(+)
>   create mode 100644 drivers/devfreq/sun8i-a33-mbus.c
> 

(snip)

Applied it. Thanks.


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
