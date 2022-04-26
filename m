Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509F850F34F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbiDZIFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiDZIFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:05:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F4C2FFE2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:02:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q8so6325096plx.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sY4O+RzpKnSGDKBPK1hz7c+s2+2s7DFvtQjl7kYI0kE=;
        b=km6eMTt1CnWFml1Gs1AUXYBobJZVkLujTH/tO/pU5SLaZN0ICyJbWPIkkcnemP/QA1
         uBGCV124HoS/Wh6KMj8Bu5BtDPoVSaPwQ7dogVw/boUrG5lzVOGygFntdpO43BdeWIgj
         mxEaGybKihC0VtzCb6lYr93OCVqwOkho4lehtZ5VCebI10At9BdrvMWR+10mBHXGdSMu
         eRb9Ee3pU0RYRT0AaKZxOsEo8wJSsATJiI14Dt8w0Tma082AQrxFKQp4EkHJa1kZV9J5
         ulbznt8l8ertyQxeTNzl+cN3GzGbPl0x5KktVuuQ9FpUKMbsiDEBftTmcS5EaNPBpoa9
         qCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sY4O+RzpKnSGDKBPK1hz7c+s2+2s7DFvtQjl7kYI0kE=;
        b=P+DcmMQcG4cuv7GsHJaSkUAikLCQrJAIvBVo5w/OzM658cFyPSFbGTu0ODxNgH4pVI
         LFaluJz2A9pSQy9/OPpTuPVdD7UWgrMb7f1le8A87JQfkRmx7xvXiE/zByFZNXohW0cp
         mfEuaN8jxkR8AY/8LD5LCtwXp7bjVwNtAa311n5vFzcQ/q5dQV8py+jege4GozSWVtX3
         PEkGAXXIM748gbRrhjO/sTmyKfW/aWWY26zRrzM9NHpa1fmC39xuITkcplzXjlNPkMiZ
         62E6zLWTVWlS39Hi0DiMED4Vpxczo7LLOJBKF+7DxEprm5XY7mgpvTxxNvh7iqDrxuDk
         9j9A==
X-Gm-Message-State: AOAM531o7atb6LEiGX4DTSrPqeCAqjFb8EkoPViXCnVRkAoOUhy+kfFm
        9xyvNu/MF9fFxAPO2YIXBFRI7X1QxSOSsw==
X-Google-Smtp-Source: ABdhPJzmefDjeFZNT16cNedZlqvBpDb8CQECn14oYN1fVVbtSKAEykCNzNcCSTqTrif4lsSBsUKE4g==
X-Received: by 2002:a17:903:1249:b0:154:c472:de6b with SMTP id u9-20020a170903124900b00154c472de6bmr22548931plh.38.1650960132296;
        Tue, 26 Apr 2022 01:02:12 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id w123-20020a623081000000b005056a4d71e3sm14145005pfw.77.2022.04.26.01.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 01:02:11 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:32:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, amit.kachhap@gmail.com,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] Introduce Cpufreq Active Stats
Message-ID: <20220426080210.hvzrsa4kmxesn6dv@vireshk-i7>
References: <20220406220809.22555-1-lukasz.luba@arm.com>
 <20220426031125.ozaxwecwvuby6wo3@vireshk-i7>
 <f6bb20c6-38a0-57d6-8979-d14e445da623@arm.com>
 <20220426075402.qjpato6sqy2kes4x@vireshk-i7>
 <9eac86b6-0221-0f62-ac4f-f9e3b1613422@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eac86b6-0221-0f62-ac4f-f9e3b1613422@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-04-22, 08:59, Lukasz Luba wrote:
> :) but I didn't dare to make it sysfs. I don't know if anything in
> user-space would be interested (apart from my test scripts).

Sure, I was talking about hierarchy in debugfs only. Will be useful if
you can show how it looks and what all data is exposed.

-- 
viresh
