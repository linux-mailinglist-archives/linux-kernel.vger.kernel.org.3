Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88EA4C0C46
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 06:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiBWFyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 00:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbiBWFy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 00:54:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFDF49C94
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:54:00 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 4so9082070pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 21:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kSSqgPqSgWwd9l6HqioycoWO2GD1CoGqpsv+gFNiT9I=;
        b=lleu1EoJfeSbDrSg3KzCO1+3m8SVssae8KUkcgXKPl9xaovGjOmRD9ENgRn963QQza
         NV4ZIta1kYJgoCQMKZG6ca74wQ0YD6ytzpivDwubCIG6H0ZbL4g9Gp7igHb6ptHnAWe+
         rt9lpOPkbAnsRxeTMhlbbOqCbq9VdbKBkm+DdVxtSLzGJJq/mMIibXx5g4qisDht+Vgw
         eRXGnsztIxv9MmoeMGIYCb5N3NPr2sWH2XAnmX9fHNfeEohjN//08tlxK9COCDa1hVPx
         SZXMBK1L44IkxlxYcmoz027UHSiWCE8hKEmbLLQ8V/agZ0mE4aj1O982vSf0p5azgEay
         be/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kSSqgPqSgWwd9l6HqioycoWO2GD1CoGqpsv+gFNiT9I=;
        b=qAADgBP4IjhDpUWvxmK3hG3Et1nokSCBeQ/bnMGoDzg3tkzW5R/+xRea5ywhPrE/Nw
         OLsBcBLC714KGo/b2FLg9gh5RqyMBU5+iSbEYcyCsfBwyivP+RFOXxGNXUqNahA8CDrH
         5glJCRpEN8FSRwrQ8oclfKxBvzCYjft3mInfqKQPlZNMk5JP0vZ3ffJXUmEGayGXLnRO
         qHvckIaePhQ9iyiYiSfdSKACl5A+Z3S0EGcPxUZlz+ugDpyyAQeaqgtHusbA7iGgxqGW
         58LUW0IR4U1tCtTVHHpcgi5ekp9Gr7iGGXRx0foF2QSRfXAkL8h6M5HZbwXJDBmdyVCe
         //jg==
X-Gm-Message-State: AOAM530lHVj6gT8Rk28tZ5KRGYIWjhF1SE4WO2fkMoskhh0xkJgM0BSR
        1Ay9aCSepdZovkWeB/AJZLlp4A==
X-Google-Smtp-Source: ABdhPJzt4RsyrslagFveen7bbfrlT+7Wph+LOX6nJ+TVqH5apt4xn9feR+OBelHjxUz1Ju2kplKZgA==
X-Received: by 2002:a17:902:9045:b0:14f:14e7:f3aa with SMTP id w5-20020a170902904500b0014f14e7f3aamr25249517plz.69.1645595639866;
        Tue, 22 Feb 2022 21:53:59 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id l36sm5692148pgb.34.2022.02.22.21.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 21:53:59 -0800 (PST)
Date:   Wed, 23 Feb 2022 11:23:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, nm@ti.com,
        sboyd@kernel.org, mka@chromium.org, dianders@chromium.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [[PATCH v2 2/2] OPP: Add 'opp-microwatt' parsing for advanced EM
 registration
Message-ID: <20220223055357.t3wulpla64vt3xus@vireshk-i7>
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <20220222140746.12293-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222140746.12293-3-lukasz.luba@arm.com>
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

On 22-02-22, 14:07, Lukasz Luba wrote:
> +static int _of_find_opp_microwatt_property(struct device *dev)
> +{
> +	unsigned long freq = 0;
> +	struct dev_pm_opp *opp;
> +	struct device_node *np;
> +	struct property *prop;
> +
> +	/* We only support "operating-points-v2" */
> +	np = dev_pm_opp_of_get_opp_desc_node(dev);
> +	if (!np)
> +		return -EINVAL;
> +
> +	of_node_put(np);
> +
> +	/* Check if an OPP has needed property */
> +	opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> +	if (IS_ERR(opp))
> +		return -EINVAL;
> +
> +	prop = of_find_property(opp->np, "opp-microwatt", NULL);
> +	dev_pm_opp_put(opp);
> +	if (!prop)
> +		return -EINVAL;
> +
> +	return 0;
> +}

Please follow everything just like opp-microvolt is defined. Create a new field
in the struct dev_pm_opp, initialize it only once when the OPP is created, that
field should be used here instead of parsing the DT here again. There also needs
to be a debug file in debugfs for this new field.

Search for "supply" and "microvolt" in the OPP core, you will see all the places
that need it.

-- 
viresh
