Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A7350F326
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbiDZH5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiDZH5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:57:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3984713F58
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:54:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so1803823pjf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DOm03KhEQB3q11B9tWS8kXn8deLeAI3fOc4CQA04TnQ=;
        b=HTSDobnyjLbBxZllKftkYXsvfzqgLLHT/3FIbSO0oMMW+d64ndo7wFIUThrDwJ9rKR
         a212IzUQi3m5FAusINjRyEL7T3s6Ihk1708OHV17oJoaZA7K2bHk7u/h6x6IYRgQMHCJ
         DSnz4Qvm0ByHn6ISBLgK2QqelcHE7zgd3sAPc1IfCBx9rI0zi1i+5AZ8rhVmLjGjEuBN
         vto0+QWJhNjpGBhOcszPsrcR07Ie4GaulFVcYbJuST2oo2N1Ndghzi+oo7e3VNrvNp/s
         3uxUjlhm+nUVkUD3SGGMYxe3rl1+Hrpbbn8vgeWuN5h/RX5nW43v5Q+BK/sR+qMKl3F8
         V3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DOm03KhEQB3q11B9tWS8kXn8deLeAI3fOc4CQA04TnQ=;
        b=vrc/AsbknDnZQHaRSbiD5S+INNq7KkftyMbQVKSj8ZGx0t7PA3tRUD0cB2eikhsllp
         cBAE0b77Ry6DqHS7YPXhqM54GFSyf8mTqpjyH6qokReDgL28guFvPHrVhNmwZTKHzP3o
         jWeNLzC4032olKdp8ZU+HaQ60CXIxssAm0H3wD6gTRgpzbA7IiCWpaZ1txA+j1imNU0W
         HzXVF6Fg2L7cfpjHhaxLhdMzJ2YYEQNtxYiJ7TBaZvg+um/FolRreuYLrgsqYegBdidI
         6hBmoZnL/iS9Hr4w8vh0rxpY9/hoSwf9+NpAo/udi9uWn2m1taDuJhZK0/liqEEN5T9d
         MbaA==
X-Gm-Message-State: AOAM533+y5WUI3NtVTiIYkLA+UT3vncNKdcUwQDV0Xjd2qBBt2mPSNY1
        ONAujqHUYUlLqYKeeFVdscrJmQ==
X-Google-Smtp-Source: ABdhPJwU0NUNJ5rv+uRj0O/DcqdMEs/4OY0PbgRfiWNl4FAee8aZWVP+X06+ln8PpIaC1DevgOhKkw==
X-Received: by 2002:a17:90a:af98:b0:1d4:67d4:d122 with SMTP id w24-20020a17090aaf9800b001d467d4d122mr25381133pjq.166.1650959644736;
        Tue, 26 Apr 2022 00:54:04 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id t63-20020a625f42000000b0050a7eaff8c9sm14137187pfb.189.2022.04.26.00.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:54:04 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:24:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, amit.kachhap@gmail.com,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/5] Introduce Cpufreq Active Stats
Message-ID: <20220426075402.qjpato6sqy2kes4x@vireshk-i7>
References: <20220406220809.22555-1-lukasz.luba@arm.com>
 <20220426031125.ozaxwecwvuby6wo3@vireshk-i7>
 <f6bb20c6-38a0-57d6-8979-d14e445da623@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6bb20c6-38a0-57d6-8979-d14e445da623@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-04-22, 08:46, Lukasz Luba wrote:
> I haven't modify your current cpufreq stats, they are still counting
> total time (idle + running) for the given frequency. I think this is
> still useful for some userspace tools. These new proposed stats don't
> have such sysfs interface to read them. I don't know if userspace would
> be interested in this information (the running only time). IIRC Android
> uses bpf mechanisms to get this information to the userspace.

I saw some debugfs bits there, aren't you exposing any data via it ? I
am just asking about, not suggesting :)

-- 
viresh
