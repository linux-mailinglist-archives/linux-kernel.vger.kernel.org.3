Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BEE4F0F5C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359072AbiDDG3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355250AbiDDG3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:29:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4D137AAD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:27:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n9so2641910plc.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 23:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GUHkECGWKY4l3E498xDgM7CvWt62/0VfG1HSPGMaIYw=;
        b=scJfEMJYuAspUIdp6WETBXjmUi8vHfbOFJipjAChHFRwm9v2gRdff8COQwUulA04DB
         UiwVkCkVA0GgE9U6B3N8S/XMfLvureAjj5VmIhUsm9Vi3auk0cgF1PbUnn8l5y08tuO4
         GQJ83GQVILft88fjmMPTDp6va0aNZYuppB+20YqTNngW2iTu+sVggidfEea+042eLi1A
         BWyLPzP9pLYyXtNvI/uTBLqBP/qGaLq9QLmUYQ0/j1au0QL+uJ4HAaLP4he73ilT6fDw
         3x8BlQyLYjc1arBlFin1yppYELsR9EL4RiYqOdbtMTAUjf+n0Np50NsbxtrpAqx6TQNO
         sUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GUHkECGWKY4l3E498xDgM7CvWt62/0VfG1HSPGMaIYw=;
        b=xaVGhhzVcX83YqjPW92H558askt5D/c+mnKrRv2PWqx1FZkZn2gtstgzNqmBS+J7Xv
         129W0PMS5C8nB1ObUitFGLEq8/yyIfqdHCex7vAfjpJp+fWll0Q6tJgJBODRGiIrlFaq
         bs8PRTyj7Q5aZW7WaTpHfHzsNwbv5zbo8NHGQhX53cgp58vhs1yXiXGEhzxJSTySJhht
         avjkUyDWpGjV93n75z4Z0zbCOSBsDZYdp6sKYXLtG/LcHe/hMCYQIKWJDLxMwDhZnW4i
         0jE0o8os5Qa1wziEPtyxawN5CEqaDJ2yBoHh4lf4keMplPDfS9hqL2c6qsPr7p7ShbU9
         Na3A==
X-Gm-Message-State: AOAM5328uetqM08p6TPLQi/p9bf9ImX27xAw1EaC43fKFipEIvYpEGz7
        pkPjw62pMUuFx9TMNLxfEhBL1A==
X-Google-Smtp-Source: ABdhPJyzknAqgsqF4eVMxtFdkqCsqFhKIN8KyYVMzApIqf7PI/18GfuGS4Iwk429QxcL3onQPTAyWQ==
X-Received: by 2002:a17:903:32c4:b0:156:8fd2:4aae with SMTP id i4-20020a17090332c400b001568fd24aaemr7346804plr.150.1649053632831;
        Sun, 03 Apr 2022 23:27:12 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id be11-20020a056a001f0b00b004fb29215dd9sm10015506pfb.30.2022.04.03.23.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 23:27:12 -0700 (PDT)
Date:   Mon, 4 Apr 2022 11:57:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Prepare cleanup of powerpc's asm/prom.h
Message-ID: <20220404062710.m6bzpg5gsx4x7tm5@vireshk-i7>
References: <4cb0c4573cce165657ad1f7275c4b3852cbcd115.1648833416.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb0c4573cce165657ad1f7275c4b3852cbcd115.1648833416.git.christophe.leroy@csgroup.eu>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-04-22, 19:24, Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up, first add missing headers in
> users of asm/prom.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/cpufreq/pasemi-cpufreq.c      | 1 -
>  drivers/cpufreq/pmac32-cpufreq.c      | 2 +-
>  drivers/cpufreq/pmac64-cpufreq.c      | 2 +-
>  drivers/cpufreq/ppc_cbe_cpufreq.c     | 1 -
>  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 2 +-
>  5 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> index 815645170c4d..039a66bbe1be 100644
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -18,7 +18,6 @@
>  
>  #include <asm/hw_irq.h>
>  #include <asm/io.h>
> -#include <asm/prom.h>
>  #include <asm/time.h>
>  #include <asm/smp.h>
>  
> diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
> index 4f20c6a9108d..20f64a8b0a35 100644
> --- a/drivers/cpufreq/pmac32-cpufreq.c
> +++ b/drivers/cpufreq/pmac32-cpufreq.c
> @@ -24,7 +24,7 @@
>  #include <linux/device.h>
>  #include <linux/hardirq.h>
>  #include <linux/of_device.h>
> -#include <asm/prom.h>
> +
>  #include <asm/machdep.h>
>  #include <asm/irq.h>
>  #include <asm/pmac_feature.h>
> diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> index d7542a106e6b..ba9c31d98bd6 100644
> --- a/drivers/cpufreq/pmac64-cpufreq.c
> +++ b/drivers/cpufreq/pmac64-cpufreq.c
> @@ -22,7 +22,7 @@
>  #include <linux/completion.h>
>  #include <linux/mutex.h>
>  #include <linux/of_device.h>
> -#include <asm/prom.h>
> +
>  #include <asm/machdep.h>
>  #include <asm/irq.h>
>  #include <asm/sections.h>
> diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
> index c58abb4cca3a..e3313ce63b38 100644
> --- a/drivers/cpufreq/ppc_cbe_cpufreq.c
> +++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
> @@ -12,7 +12,6 @@
>  #include <linux/of_platform.h>
>  
>  #include <asm/machdep.h>
> -#include <asm/prom.h>
>  #include <asm/cell-regs.h>
>  
>  #include "ppc_cbe_cpufreq.h"
> diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> index 037fe23bc6ed..4fba3637b115 100644
> --- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> +++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> @@ -13,9 +13,9 @@
>  #include <linux/init.h>
>  #include <linux/of_platform.h>
>  #include <linux/pm_qos.h>
> +#include <linux/slab.h>
>  
>  #include <asm/processor.h>
> -#include <asm/prom.h>
>  #include <asm/pmi.h>
>  #include <asm/cell-regs.h>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
