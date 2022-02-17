Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2D14BAD18
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiBQXNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:13:16 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBQXNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:13:14 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587EC2DCFB4;
        Thu, 17 Feb 2022 15:12:52 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id c10so1690991ljr.9;
        Thu, 17 Feb 2022 15:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7Fv9iaLU1K6vjoxOcHxKGaRqkglRuk5iz5YNCohBSrU=;
        b=GOo5/hBWZpSj+M0IcEV2EK7F2yNLJQiWEV9fk5VCPVNEr6VRpiCvAta1NDLzs2EbT+
         FHWx7GmcxX770eR77ZByYi+pDUacqJZkBLkTVR/n/hAAahbwQC8G+GEu9OUPcz5c3h+F
         q9S/IJYsEP7aJ4F8sQBiGhyAodf8waAmNfr6HZpsXM/vlR41EEElFWnkv/YLXox3uEIH
         Ow1xBmq65TwyLQ5MjtaqRV+bpCpdCtRE0KWy9YWw92Oe2nIesIK6SuSxA+5XTRWT+Cdq
         0orsrF42JVuFrLE6il/He/9paQue6qbR7JFuFYYe7p4UI/043u2S1ClyXgz2W0T7uSYc
         o4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Fv9iaLU1K6vjoxOcHxKGaRqkglRuk5iz5YNCohBSrU=;
        b=6D9lJKhuYygO6roGOT5aia6Q+o9lnofgpDdWGOgsQtJGC2zgzIOg7LZ8J5detGzVjn
         9Cgg9IomvOtl7/++WFEJrda5hwo7MJ1NhG8MiXKG7LPEYtm/bHXAXH3FtD/Yvtu7yF2A
         +LU+K/XZ1CGUqZ8uCZwU+Vj2uugxn+hC3u0PS8+LbFOkDIseedO3FjropvDyTZnXWdFo
         RuSzYOetMciiT0qMBGBultcGSF4nx3UA31UtHiIpu0i0sP8r6K4zBDaW56KtebFVQb7+
         MJvvuXslnKGhkiDtui7NeRVfJAszDYYK/7Zk0GRsD9cnf+nPp5OoyeZH5kKOLFRM7941
         +ukQ==
X-Gm-Message-State: AOAM5337SV+qy6Un4VZorUCVffJJSJf/GgU9m00v2MXF46Ub+AABWvlN
        wAaeIroc1tgGUMjpolYa5rsbFdLcDgU=
X-Google-Smtp-Source: ABdhPJxt562ZlKFmYJNNqARRDYwOB2vxSB+j5UTQOJY/uj2hNg5IKwjG4q9KbRm1kvzSoNK57nSbiQ==
X-Received: by 2002:a05:651c:1a29:b0:243:c0eb:dd5f with SMTP id by41-20020a05651c1a2900b00243c0ebdd5fmr3811132ljb.323.1645139513058;
        Thu, 17 Feb 2022 15:11:53 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id v10sm118073ljj.2.2022.02.17.15.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 15:11:52 -0800 (PST)
Message-ID: <a869b705-c10e-ed0b-4119-35ef0a028311@gmail.com>
Date:   Fri, 18 Feb 2022 02:11:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] PM: domains: Prevent power off for parent unless child
 is in deepest state
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220217124950.211354-1-ulf.hansson@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220217124950.211354-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.02.2022 15:49, Ulf Hansson пишет:
> A PM domain managed by genpd may support multiple idlestates (power-off
> states). During genpd_power_off() a genpd governor may be asked to select
> one of the idlestates based upon the dev PM QoS constraints, for example.
> 
> However, there is a problem with the behaviour around this in genpd. More
> precisely, a parent-domain is allowed to be powered off, no matter of what
> idlestate that has been selected for the child-domain.
> 
> For the stm32mp1 platform from STMicro, this behaviour doesn't play well.
> Instead, the parent-domain must not be powered off, unless the deepest
> idlestate has been selected for the child-domain. As the current behaviour
> in genpd is quite questionable anyway, let's simply change it into what is
> needed by the stm32mp1 platform.
> 
> If it surprisingly turns out that other platforms may need a different
> behaviour from genpd, then we will have to revisit this to find a way to
> make it configurable.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Clarified commit message - based upon discussions with Dmitry.
> 	- Updated a comment in the code, suggested by Dmitry.
> 
> ---
>  drivers/base/power/domain.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5db704f02e71..c87588c21700 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -636,6 +636,18 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
>  			atomic_read(&genpd->sd_count) > 0)
>  		return -EBUSY;
>  
> +	/*
> +	 * The children must be in their deepest (powered-off) states to allow
> +	 * the parent to be powered off. Note that, there's no need for
> +	 * additional locking, as powering on a child, requires the parent's
> +	 * lock to be acquired first.
> +	 */
> +	list_for_each_entry(link, &genpd->parent_links, parent_node) {
> +		struct generic_pm_domain *child = link->child;
> +		if (child->state_idx < child->state_count - 1)
> +			return -EBUSY;
> +	}
> +
>  	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
>  		enum pm_qos_flags_status stat;
>  
> @@ -1073,6 +1085,13 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
>  	    || atomic_read(&genpd->sd_count) > 0)
>  		return;
>  
> +	/* Check that the children are in their deepest (powered-off) state. */
> +	list_for_each_entry(link, &genpd->parent_links, parent_node) {
> +		struct generic_pm_domain *child = link->child;
> +		if (child->state_idx < child->state_count - 1)
> +			return;
> +	}
> +
>  	/* Choose the deepest state when suspending */
>  	genpd->state_idx = genpd->state_count - 1;
>  	if (_genpd_power_off(genpd, false))

Thank you, looks good. Although, this should be v3.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
