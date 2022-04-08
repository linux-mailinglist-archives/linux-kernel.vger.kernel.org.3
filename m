Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B8D4F9E2F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbiDHUbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiDHUbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:31:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DD51DA8C2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:29:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q36-20020a17090a17a700b001cb57a8da1cso1008110pja.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=HD9KWxYgHovL4d+swYpmuaTcGaPIaYm36t/rSV4RSvg=;
        b=Q0KeoqDnCa8t9t7sVZPbYG3qKLWKWSwjPdVPsqLNyYAIkNInfvFrnib1WBJF0cFwPV
         cS88dBGtsAWScifpLSaO+kVpUGO8xGswNZgPNdhGOFmClE5dE1T/mSRm+cmRZvX03LET
         vP9besdhVUGIMppcb/yOkqKHoE8YUfnOTbgL48zbFm+MKrKJlL59Z62zG0lP5qZKbd8C
         P8ZQUoDvx7UGRpcUIa7VokvDC02Y2wGLGOTj7/BGPLKFLWg/j4a4j3DqqtljU//u7sps
         iKvkuYkzerCCmTAseaxt4wrz8EffCcexE6DaU0McLwY4AdgJaXXMFUzw3XUhZEHLN3IZ
         sYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HD9KWxYgHovL4d+swYpmuaTcGaPIaYm36t/rSV4RSvg=;
        b=jCqcMlbyiVA/0/QIpHcvjsnG0OICjUQhTFkO9dkslYkCF9NNu8XQEtxZ5PrNCL7gm1
         NLyf7UorHQE780c01KKGiUysLDgiiM6Se1JiDGXF0OFqND+PvhV4miHo470Du2G3TJvf
         33V+y83oNzSu6AOnPQcZAyR7ROV97Gz5KfyUEkXX2TAHRlcB4uwfiUEkTBuqGm4Cpn5h
         C/+HTOAuUiy60mt91c4W0yGn7w3VrRVMC3PEhogPE4LMUoFFXC5HsdrGWl7cdJrFTHiO
         1LLFl5Iyh+noRt/zxU3xl/XGLykzXiJNBOBAHPsD49uzVuevzgTQE9zky66vvsrIud1M
         NJAg==
X-Gm-Message-State: AOAM533sFV2mD4F2CmwT5APYrTm2hKIK6KF96rSpa+w2iIPLUUWfn/II
        x2C5SVwQQJtzVSywAV2YQv+NHQ==
X-Google-Smtp-Source: ABdhPJz1t8RKOgx1OockyWLTtqK9N64BneuYukw0ht7tEOMRQDgSerOayaO2vT0LBXJsp4/C/ABSyw==
X-Received: by 2002:a17:90b:4f8e:b0:1c7:3652:21bc with SMTP id qe14-20020a17090b4f8e00b001c7365221bcmr23626082pjb.38.1649449751645;
        Fri, 08 Apr 2022 13:29:11 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id x8-20020aa784c8000000b0050577c51d38sm3849034pfn.20.2022.04.08.13.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 13:29:11 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: Re: [PATCH V2 07/15] cpufreq: mediatek: Add opp notification for
 SVS support
In-Reply-To: <20220408045908.21671-8-rex-bc.chen@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-8-rex-bc.chen@mediatek.com>
Date:   Fri, 08 Apr 2022 13:29:10 -0700
Message-ID: <7hsfqn5nft.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rex-BC Chen <rex-bc.chen@mediatek.com> writes:

> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
>
> The Smart Voltage Scaling (SVS) is a hardware which calculates suitable
> SVS bank voltages to OPP voltage table.
>
> When the SVS is enabled, cpufreq should listen to opp notification and do
> proper actions when receiving events of disable and voltage adjustment.

So listenting for OPP notifications should be done only when SVS is enabled...

[...]

>  static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  {
>  	struct device *cpu_dev;
> @@ -392,6 +455,17 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  	info->intermediate_voltage = dev_pm_opp_get_voltage(opp);
>  	dev_pm_opp_put(opp);
>  
> +	info->opp_cpu = cpu;
> +	info->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
> +	ret = dev_pm_opp_register_notifier(cpu_dev, &info->opp_nb);

...but here youlisten to OPP notifications unconditionally.  Seems there
should be a check whether SVS is enabled before deciding to register.

Kevin
