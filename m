Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30648487752
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 13:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346598AbiAGMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 07:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbiAGMFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 07:05:21 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62E3C061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 04:05:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i22so10624280wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 04:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0fJMEtzExslnnr0EE8eXwCGBvIQxk/jbdwPaaLTTA00=;
        b=IJQa1FuCgd2GxfNawwlcKxlFhFzK0wLrdh4JPB+nC1eC3xsz0mlpEWd5oqyzZfqQHZ
         bxB5KMAWYsqxWstNRcvz/BKZ+zTMeaK8HcGEgPBNTMasbSRHxf+lRtJClFHU86ekAQV6
         ZQovDZ7IpBCY8oPOLxipZSJc7IowlcIdTT3ogdt38IFqzN4NvtmKGQ3qBwd2XY5j6TDE
         nK2p63QbaQtKgJJLl8cCixAQfFAkBPxQrnUt0joGPP6xhE2hBgCXPYkpAgiBDoiYWOzN
         rEKVSdzeEKx7ne3IEUsSaKcPtnnjAGHdSGLuN2fIrB24mHesHV76BlNHEyW47d6qN5Qz
         QFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0fJMEtzExslnnr0EE8eXwCGBvIQxk/jbdwPaaLTTA00=;
        b=F6e7w9/dA8mh0ycDnGQoi5m/sKByPv9VaCVR+E4Op/w2/PxOnuEpQpWpQM70Y/0H99
         4/pf+PYFxNiCea/GHvah87TMmQabLrlhfmM8DQMgIZIEotR9Yp4IwoLVwupoJehT/DlY
         gL66247mwTTzfdLuIq5yeAzU5gHu9gZU4NGTPbuBhn6LPo1G/o3foZT7Fyuwh+Xhbugc
         vBOap1LqtKQpsbbOQO4sUD1cH2Fv6wQPHfRAOWeVbmsGehAm5SJsNnaZC8zx/5BopVVm
         YyS4N3DhZRPFqQZcKlB3764/wpYdDS9aZ7r8fDr9zjfyk7kQETHCJWQ+fejBz1Sc/4lv
         76DA==
X-Gm-Message-State: AOAM530/nNfmC07YZmrHvOQxnQoP5VrScmgx06/6Jcz3ekD7LFOZouKY
        62Tr1/Vyiy/XhmpaEwW3KsvtEiL068WmwSL6
X-Google-Smtp-Source: ABdhPJxTsNsWkeEQ2mnZJnaLdfoL07T6yJwIyYu0AsBAWgmFKi0xzsj2RTXPP/QWacpb0CHHCScWhA==
X-Received: by 2002:a05:6000:49:: with SMTP id k9mr56277757wrx.190.1641557119381;
        Fri, 07 Jan 2022 04:05:19 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:4875:220c:f3a4:c74e? ([2a01:e34:ed2f:f020:4875:220c:f3a4:c74e])
        by smtp.googlemail.com with ESMTPSA id n7sm4282059wms.46.2022.01.07.04.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 04:05:18 -0800 (PST)
Subject: Re: [PATCH] thermal/int340x_thermal: Check for null pointer after
 calling kmemdup
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, rui.zhang@intel.com,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220105065652.2340271-1-jiasheng@iscas.ac.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <24d097f7-59a5-cd7d-3fc8-c3ce5fd9e88b@linaro.org>
Date:   Fri, 7 Jan 2022 13:05:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220105065652.2340271-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2022 07:56, Jiasheng Jiang wrote:
> As the possible failure of the allocation, kmemdup() may return NULL
> pointer.
> Therefore, it should be better to check the return value of kmemdup().
> If fails, just free 'buffer.pointer' and directly return is enough, same
> as the way that 'obj' fails above.
> 
> Fixes: 0ba13c763aac ("thermal/int340x_thermal: Export GDDV")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 823354a1a91a..999b5682c28a 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -462,6 +462,11 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
>  	priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
>  				   obj->package.elements[0].buffer.length,
>  				   GFP_KERNEL);
> +	if (!priv->data_vault) {
> +		kfree(buffer.pointer);
> +		return;
> +	}
> +

There is another kfree on error before

Please replace those by a goto out_kfree;

>  	bin_attr_data_vault.private = priv->data_vault;
>  	bin_attr_data_vault.size = obj->package.elements[0].buffer.length;

out_kfree;
>  	kfree(buffer.pointer);
> 

Why there is no error code returned to the caller?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
