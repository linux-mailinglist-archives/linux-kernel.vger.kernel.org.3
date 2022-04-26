Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA63D50F1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbiDZHPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343739AbiDZHPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:15:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AC73B552
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:12:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so1755516pjf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FNi2yKH3BzHM0NYlo1t1Rca/MjXsHnj8mg34KQwoBDw=;
        b=PfkjDdYYs7ZbCk+iigYmzX0rcWDVLCRLHxdhbcyCpL1Oi/hu4TsHpHXe0VB+bQERDM
         OeN9XfnWMZLDI4b71vkawkrYT/yximLBqMTCzJ3BSIg9yI4X1V9lS9rfNazMlXD4g98u
         56NWVVfkltv1tdhNd47gtJztyIrTNwBZmlxUe5ZZrW+jYIOd8p6YItoIfFDlNEzhWhfA
         0ZtvuPBy/Qj+upRnJrFNKcYnQ9bFOV1Fe1Mr4A9AiQs/KZGLsNG30wQu46nwI6x9fNNq
         GkHs5ICEhlaWzZifFNCSmWdqbyE8Rey3BcGfUzHm17INW1vUyA/bZIevh68FJBUOX4ZD
         Z+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FNi2yKH3BzHM0NYlo1t1Rca/MjXsHnj8mg34KQwoBDw=;
        b=FXwoQX/jQCm5+Mb7brK07j76u/GbQsS2wR+VltjB+i9+FACZes65YtzaYSar02PU1+
         bE7naUkUhGBqbkkKjaV+hv90vIEG8rmmpY9unyf32Ng/hp1SweSVCpCcfyN8+yysq8rV
         ePaqrXUlHzkFXRSIzXCyBUM0hKifFs6RuwbAazmg5tejwZdyAQSNXWAiHw4hri9bRN5A
         x3wEXnp2Q3vVjSzUP/Zv/8A3QfQqj8yfJ+M5Y+yH8plkTw3e7zvhiaYWabeo+nzP5nyv
         yORIqovgTCWpAs4hitZWxwCiNtF7nrJNbh3mfhmnV2J2LN9qo8RTOh51iTlYQw+LokJY
         8UzA==
X-Gm-Message-State: AOAM532rEXRVaXQKvwDDxQ8S+VnZW8w+xwVCcHCN8YH9fhNreWzOZN+y
        QvQegBQbFermKKPxJJduumg5zA==
X-Google-Smtp-Source: ABdhPJxz06/zPV9mNrmr7SwX145M51KtrpPaZBApSFmkOfYzjfX8NarMH7eBaw8TMxoAmUPWg4mcuw==
X-Received: by 2002:a17:90a:5b09:b0:1cd:b3d3:a3f3 with SMTP id o9-20020a17090a5b0900b001cdb3d3a3f3mr25477341pji.9.1650957154235;
        Tue, 26 Apr 2022 00:12:34 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id x1-20020a17090a970100b001cd4989ff41sm1590844pjo.8.2022.04.26.00.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 00:12:33 -0700 (PDT)
Date:   Tue, 26 Apr 2022 12:42:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, maz@kernel.org,
        daniel.lezcano@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Enable EAS for CPPC/ACPI based systems
Message-ID: <20220426071231.zfdrok3ulgewomib@vireshk-i7>
References: <20220425123819.137735-1-pierre.gondois@arm.com>
 <20220426030810.wj7mdhjhzs2s6y7h@vireshk-i7>
 <20220426063739.6ljxtr6hpz7tber5@vireshk-i7>
 <6765104a-761c-4586-502c-2b98ee6016a1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6765104a-761c-4586-502c-2b98ee6016a1@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-04-22, 09:10, Pierre Gondois wrote:
> Hello Viresh,
> The 2 patches are relying on Lukasz' patch-set at:
> https://lkml.org/lkml/2022/3/21/282
> The serie was accepted by Rafael (cf. https://lkml.org/lkml/2022/4/13/701) and
> is currently in linux-next. More specifically, the missing patch causing the
> build failure is: 'PM: EM: Add .get_cost() callback'
> 
> From what I see, the branch cpufreq/arm/linux-next (from your repo) that was
> used in the CI is based on v5.18-rc1 and doesn't have Lukasz' patches. Should
> we wait for the patches to be in a rc version, or is there a process for this
> kind of case ?

Ok.

Rafael: Please pick these patches directly.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
