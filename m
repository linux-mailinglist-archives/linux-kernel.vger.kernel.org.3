Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F9D50DD7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiDYKEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbiDYKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:04:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212E5766B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:01:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q8so2680660plx.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PApZnh3qRXman8Ophw4OOA7A/2sG8ifMcY3MbuoLa18=;
        b=pcQbwIzZ8x74dXgdi7OBlsMWpxbq8EDM9028htUhVGWemcyFCvsSP1XLm4Wn9i+oum
         LYJgF3S0BjrgnyvGmCAXpd7yTc86lesWt8fXZETMqA4vNYgT4yopSZROF+Y5hTMHNUlO
         RpIVMVboBu8c4OUzgtL0HRmXSjqwwr/rek3H978V1531j83iVL3NH+6i0rqcIP3rvzrq
         LhvLHDu5PFV8vdQZ645/tcvXcnIKr/zZW69GPJfX4z4ZUTBu7pxPkJPog+0edRvuJDyh
         HJ9DzKY80rW+SPmGRxKuPilEu+gGfhj0caRZb+YfR/vWhRwZeNH/3OROVsQ1sUOwe2uS
         10rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PApZnh3qRXman8Ophw4OOA7A/2sG8ifMcY3MbuoLa18=;
        b=eDWh6p3dMoIXczYj9KY7Mgt/V8/8Fh1i5nXzJL7TcquIUkHY+E5jAkkvW0kOQvyuXR
         bWfrl/oOn+LnrHzTHVtkXXiOm2f3ElskdXhmTuhbiG7vKzbB7bHRL/495jRvQwrqJj2g
         to0e6QaOtUmmQ7oE4rNmF+ZJ2jaEz4jTPDHJkynGImx2a74KOrexD+Pyz/yPD7BUjZlA
         C73nMNkmwseh3XylF27euw3fRTqaq4gmWW327yq/YxdsKv0vIFeHRuNXORq5unlsGHBb
         vRfWc2hW7gk7QUuDXiBg5bo9gNJrYQ8K0Det7MjTldXJESIdVrdREq1FshiRs7JX1oJy
         HThw==
X-Gm-Message-State: AOAM532YrLNbkr1rRwTICZXnlDJ+wQY9je8uqNU4rRL6epeSfMye5LGU
        N2AFD/HsGhZMU3xNect66fr+vg==
X-Google-Smtp-Source: ABdhPJzQojLiY848HqAktLkmWjk+9Gu/+RD85Df6pBBCgMUEKyHRB6p3bOCBqDrMilhn2Wj8891rlw==
X-Received: by 2002:a17:902:b586:b0:159:684:c522 with SMTP id a6-20020a170902b58600b001590684c522mr17046705pls.39.1650880861518;
        Mon, 25 Apr 2022 03:01:01 -0700 (PDT)
Received: from localhost ([122.171.250.232])
        by smtp.gmail.com with ESMTPSA id bh3-20020a056a02020300b00378b62df320sm9207671pgb.73.2022.04.25.03.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 03:01:01 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:30:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V4 07/14] cpufreq: mediatek: Add .get function
Message-ID: <20220425100058.4kbvmpi63ygni6k5@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
 <20220422075239.16437-8-rex-bc.chen@mediatek.com>
 <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
 <64c690e8edf493ec0a4a14e0fdaad2d8e88e6da7.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64c690e8edf493ec0a4a14e0fdaad2d8e88e6da7.camel@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-04-22, 17:34, Rex-BC Chen wrote:
> We found that the pulses of cpu voltage could be observed when
> frequency is fixed (scaling_max_freq == scaling_min_freq) if using
> cpufreq_generic_get as '.get' callback in MT8186.
> cpufreq framework will constantly (~ 1 sec) call 'update' if the policy

Which function gets called here in that case ? I would expect
cpufreq_driver_target() to not make a call to MTK driver in that case, after it
finds that new and old frequency are same (it will check the corresponding freq
from cpufreq table).

> frequency is NOT equal to hardware frequency in
> cpufreq_verify_current_freq.
> The problem is that there might be a tiny difference between the policy
> frequency and the hardware frequency even they are very close.
> e.g. policy frequency is 500,000,000 Hz however, hardware frequency is
> 499,999,726 Hz for MT8186 opp15.
> 
> To prevent the voltage pulses, we currently use the software cached
> values as you pointed out.
> I wonder is it possible to add a tolerence for checking difference
> between policy frequency and hardware frequency in cpufreq framework so
> that we can use cpufreq_generic_get as callback without pulse issue.
> Or any suggestion would be appreciated.

-- 
viresh
