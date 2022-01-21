Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701CF495F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380374AbiAUMbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350448AbiAUMbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:31:11 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8343C061574;
        Fri, 21 Jan 2022 04:31:10 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id br17so33494850lfb.6;
        Fri, 21 Jan 2022 04:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=79L6i8rFUUOtwzeoLeDjC9k2mfL2FdLRUXa76vsFDJw=;
        b=AGjBDIOXoUkG0WuMu0HQrmGu33wKQPSfUhIY6ivP6BhL0csovOP7xRQZ0du3awli10
         0fl1KGh05mc6IYzortSNm3a0wuYANpyh8C3+M0pDb7Sc0fk06ZgtC1P5HId6mZ6FAYhh
         XZfupAVLh/6dQpP5wY9kLeH6dgSEW81rWAa9ySDqR9cVCrGJZdG3MV0HO7QtCVKyXaGY
         fJMxhd4xy1fiAvA3Vg2CmHwlqVlKjp2dNuJsOA1KHTiTuOSgkg3CVxpv2m9jL5fCwq4A
         kcCsH1MQ3hYLnNhnL2NQjiS0kM4nGLP1t59vrZZX7BShaRQyJD666Om8xP5C6e3zxejv
         N0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=79L6i8rFUUOtwzeoLeDjC9k2mfL2FdLRUXa76vsFDJw=;
        b=TuklBUq8zt31UQhudsiIcuFbZfH4kgqPTMf2CZftetWBiWcZvoei+rSTUGU+WeFBB/
         iJyn8PrQfMkwYwMjszzjpXZNKghh7dBkYwFWABFfWPw7FwcnyqrSNAqCV8pSJYei83SL
         wkYVrjzq+00BmeDx2G3qPtJYYJ4vvqyzVcc/wV1qYYB0Unva7Phs9xKkSCHp6ZE1gVfL
         wkvUDpQ4NQodreDxdNGYdyi2ISzfAfRWvvhg916W+VuySxetPxGom/IKBKBZv4tZDe68
         fK48i3J+8OQm8fDcliBMCrrzQ2q+AEh3dqLzjgQ0ITJa7Gevhx+TkWkDmkS4LakSRxmo
         jfFw==
X-Gm-Message-State: AOAM530mSfOnzo9Rgm16SdOdp2HVUZXA6FyD4b6Pr2gCAkP3VD8CtMQs
        fG4XzMY293UbSbOs9okVkk8=
X-Google-Smtp-Source: ABdhPJzb5RyAZIyKEiVTiCCg/2/nZZuIW0ojw1P9dkmg21kzJH3683nJ69AjQNBFD2HucJ4Sp7TsUQ==
X-Received: by 2002:a05:651c:1a06:: with SMTP id by6mr3002172ljb.244.1642768268982;
        Fri, 21 Jan 2022 04:31:08 -0800 (PST)
Received: from [192.168.2.145] (109-252-139-36.dynamic.spd-mgts.ru. [109.252.139.36])
        by smtp.googlemail.com with ESMTPSA id h2sm139058lft.58.2022.01.21.04.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 04:31:07 -0800 (PST)
Message-ID: <dc9b0c08-bd2a-6ffa-ad75-47afd036f3ef@gmail.com>
Date:   Fri, 21 Jan 2022 15:31:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Patch V3] memory: tegra: Add MC error logging on tegra186 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        krzysztof.kozlowski@canonical.com, linux-kernel@vger.kernel.org
Cc:     Snikam@nvidia.com, vdumpa@nvidia.com
References: <1642763962-32129-1-git-send-email-amhetre@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <1642763962-32129-1-git-send-email-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> @@ -529,12 +536,44 @@ static irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>  		u8 id, type;
>  		u32 value;
>  
> -		value = mc_readl(mc, MC_ERR_STATUS);
> +		switch (bit) {

Again, I see that the code wasn't tested :/ Shouldn't be too difficult
to create memory-read errors to check that at least basics work
properly. Please always test your changes next time.

So it must be "switch(BIT(bit))" here, please write it like this:

u32 intmask = BIT(bit);
...
	switch(intmask) {

> +		case MC_INT_DECERR_VPR:
> +			status_reg = MC_ERR_VPR_STATUS;
> +			addr_reg = MC_ERR_VPR_ADR;
> +			break;

Please add newline after every "break;" of every case. This will make
code easier to read a tad.

> +		case MC_INT_SECERR_SEC:
> +			status_reg = MC_ERR_SEC_STATUS;
> +			addr_reg = MC_ERR_SEC_ADR;
> +			break;
> +		case MC_INT_DECERR_MTS:
> +			status_reg = MC_ERR_MTS_STATUS;
> +			addr_reg = MC_ERR_MTS_ADR;
> +			break;
> +		case MC_INT_DECERR_GENERALIZED_CARVEOUT:
> +			status_reg = MC_ERR_GENERALIZED_CARVEOUT_STATUS;
> +			addr_reg = MC_ERR_GENERALIZED_CARVEOUT_ADR;
> +			break;
> +		case MC_INT_DECERR_ROUTE_SANITY:
> +			status_reg = MC_ERR_ROUTE_SANITY_STATUS;
> +			addr_reg = MC_ERR_ROUTE_SANITY_ADR;
> +			break;
> +		default:
> +			status_reg = MC_ERR_STATUS;
> +			addr_reg = MC_ERR_ADR;

Add newline here too.

> +			if (mc->soc->has_addr_hi_reg)
> +				addr_hi_reg = MC_ERR_ADR_HI;
> +			break;
> +		}
...
Note that you could use "git format-patch -v4 ..." instead of manually
changing the [PATCH] prefix.
