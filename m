Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC91538A59
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243783AbiEaEPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238733AbiEaEPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:15:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31BE90CDC
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 21:15:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w2-20020a17090ac98200b001e0519fe5a8so1076584pjt.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 21:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E8Ck4/4aVuZ3hawDIoqnmaAvPmgW6JpDltu0Lz2f7+s=;
        b=Kn1TcwXMVVij1nRJGFt3EODd55cBy9+5pBHeIMDR8p/oYQ5AASP5X+vD/xycrewvOJ
         vXC7szXgIQ6uDCQ1AhtwZF5Fbkmxc+jfzvHe/YcTzofCSzZ3ccf9rR+7sOHK1M2defUa
         hDHWYjmyN+7WCxR1rzpYIAAAJwLF5pB7fFfSSMffs7KCwU8vWboKERXQRDg8qlUrRcBR
         0IvSHtwvDyJyeC0y66hvbysj6LFvz9CB104kv0Gpy0ljlq3S0mnPpYhdgKqckAbi/HKh
         NdbZK+5oWzjhOuJTwy6zbb7cJkhu4JqEjU9yOdSURuMv/cKWQkLfITYS4H1SFMZHK9Pe
         QRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E8Ck4/4aVuZ3hawDIoqnmaAvPmgW6JpDltu0Lz2f7+s=;
        b=jfNk63VkIrERbq/5LQJWvMeHYKUOLBkQ8TlgfCBhJn67YXuNqV8Nc5whZ6F8gt3QlC
         9dO8iOnnJtbLGLLj7XkenB5E9lO24rfv2pjuumik4iU/507lcWw+Au3W5SuQ8CWO58bp
         JrgWg9glh9lSWx1kOT8owPrYNnQqvCHwh742j0U9NXU55/NPTEnf22ZG9Te6Z3K9Txln
         wRYCwpo4yY6kr+iorfSAND4oegjtlpUS7NdBqQgpV0nEqYzmYVNZcqdfXtl6GNqK2Hd6
         XnHACW5qQzCrKUfCa0gm8RCAD+Vm3txpZNHRYfDmrJlHDYJtMWrSL4tggn6SPWK0PNz2
         TmkA==
X-Gm-Message-State: AOAM532qTCkdwwHnSSmZVnVgV4AO8fqq3vGRBgXzRoC5F6V7g1FRgjIi
        wgrOmc1lMkZ2qrw4YptKlEK78g==
X-Google-Smtp-Source: ABdhPJxFIhtQXJ7r6Ak1Dj+5kS499XFfEHegca+7MEBfkXFmygsdJX6jSUbBOh4ufKUWDEzEmEO0Yw==
X-Received: by 2002:a17:902:d504:b0:163:f8e0:94bb with SMTP id b4-20020a170902d50400b00163f8e094bbmr4142634plg.159.1653970508310;
        Mon, 30 May 2022 21:15:08 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id e1-20020aa798c1000000b0050dc76281b8sm9899641pfm.146.2022.05.30.21.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 21:15:07 -0700 (PDT)
Date:   Tue, 31 May 2022 09:45:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/31] devfreq: exynos: Migrate to dev_pm_opp_set_config()
Message-ID: <20220531041505.egfe2kpi3bgb6l55@vireshk-i7>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <CGME20220526114410epcas1p27ad1ed594737423fb967f92529a1abd5@epcas1p2.samsung.com>
 <052c4937ce408a01de5cd7d7e359d333f9b11e57.1653564321.git.viresh.kumar@linaro.org>
 <9d492494-4a0a-f690-6a80-2bba5d8633b9@samsung.com>
 <d9a96812-fd4e-cf46-cbe5-63f0e1d373a1@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9a96812-fd4e-cf46-cbe5-63f0e1d373a1@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-05-22, 13:12, Chanwoo Choi wrote:
> I try to find the cause of this warning.
> I think that dev_pm_opp_clear_config needs to check
> whether 'opp_table' is NULL or not as following:
> 
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index fba6e2b20b8f..cbf8f10b9ff0 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2598,6 +2598,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_set_config);
>   */
>  void dev_pm_opp_clear_config(struct opp_table *opp_table)
>  {
> +       if (unlikely(!opp_table))
> +               return;
> +
>         if (opp_table->genpd_virt_devs)
>                 dev_pm_opp_detach_genpd(opp_table);

Does this fixes it for you ?

It isn't allowed to call this routine with opp_table as NULL, I should
rather have a WARN() for the same instead.

Can you check why exynos is passing NULL here as I don't see an
obvious reason currently.

-- 
viresh
