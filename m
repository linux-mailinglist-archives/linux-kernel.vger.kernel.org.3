Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1E3521029
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbiEJJEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiEJJEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:04:46 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87A4237D2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:00:48 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id m128so29472442ybm.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eO3ms7tODqsWFFR0lo6xf6Y/6Pp0KmWpgeC64E2g7Bw=;
        b=blZpcZTC1aAM67v9QvdkBq4txzGmRtvjUPGrdMcxDyO+snf1+8rO3hzQj3ygN3TE5a
         /CZEi9wJNaHTtxcnb+IGFwefArSMjh8U3MrIyyGw2jva4QF3NGl8xT+IHVj+Egqk2tJx
         d51kPhEPWwoeNtgJaToG1vpVQAvjBX8wCGHhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eO3ms7tODqsWFFR0lo6xf6Y/6Pp0KmWpgeC64E2g7Bw=;
        b=XeXg0QsTGY5RHElk2lLgNAiNSx2+Pcc2jrsDtXuZSZnxV61AsKLeleYO9eZw0UzyHi
         zHu0irkXxv5qpZbYA0og5DhW5Bd3QBsiXCPK7ek8EfRj50cxGuVMRJaIqlXhCilHkzuI
         UHwlAOiLG7yRl6XDGpeYtbR23vMMNmrfXXiCHM3vgnrSL/C9SEnrTXdCS0MrtCnOooYv
         GV7T0EpRRuxHlkXilIj2Ig4WtKM1E4ftrdbwWAtBvPF/UbHGn8ALDnt7/m4cli67r8mf
         GU2yUVnVG2m2UjC2I7j3q/5nyzNQFfuh8Dy2BAWhT3zBcS0l6dFzGZHH1B4sg8b3rWHg
         byYQ==
X-Gm-Message-State: AOAM53159WN10uW+sKmsQeIJzua7tAxlygvIRThcCeB9fZ/uReHozGlN
        Jd5liXKOets6eTW1HLM1gyD4xcMwfGM5DTqX/oMwMw==
X-Google-Smtp-Source: ABdhPJywc47C1d4ddOcPYKW6XLz4Z89N3rNFu/hfNgPacLGXvBbF5iGBV4NcKQcWRjKlLBFR69yf93znBTCCNOk/y8M=
X-Received: by 2002:a25:7b01:0:b0:64a:5663:4d3b with SMTP id
 w1-20020a257b01000000b0064a56634d3bmr16184354ybc.461.1652173248192; Tue, 10
 May 2022 02:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220509120337.92472-1-cw00.choi@samsung.com>
In-Reply-To: <20220509120337.92472-1-cw00.choi@samsung.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 10 May 2022 17:00:37 +0800
Message-ID: <CAGXv+5Fp0c23=4C8QG6AcDS9furMqJhfrUF1Hj0RyBHebvCy6w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] PM / devfreq: Add cpu based scaling support to
 passive governor
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnson.wang@mediatek.com, mka@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 8:03 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> The devfreq passive governor has already supported the devfreq parent device
> for coupling the frequency change if some hardware have the constraints
> such as power sharing and so on.
>
> Add cpu based scaling support to passive governor with required-opp property.
> It uses the cpufreq notifier to catch the frequency change timing of cpufreq
> and get the next frequency according to new cpu frequency by using required-opp
> property. It is based on patch[1] and then just code clean-up by myself.
>
> Make the common code for both passive_devfreq and passive_cpufreq
> parent type to remove the duplicate code.
>
> [1] [RFC,v2] PM / devfreq: Add cpu based scaling support to passive_governor
> - https://lore.kernel.org/patchwork/patch/1101049/
>
> Changes from v2:
> : https://patchwork.kernel.org/project/linux-pm/cover/20220507150145.531864-1-cw00.choi@samsung.com/
> - Drop the following patch ("PM / devfreq: passive: Update frequency when start governor")
> - Move p_data->this initialization into cpufreq_passive_regiser_notifier()
>
> Changes from v1:
> : https://patchwork.kernel.org/project/linux-pm/cover/20210617060546.26933-1-cw00.choi@samsung.com/
> - Rename cpu_data variable to parent_cpu_data to avoid build fail
> - Use for_each_possible_cpu macro when register cpufreq transition notifier
> - Add missing exception handling when cpufreq_passive_register_notifier is failed
> - Keep cpufreq_policy for posible cpus instead of NR_CPU in order to avoid
>   the memory waste when NR_CPU is too high.
> - Add reviewed-by tag of Matthias Kaehlcke for patch1
>
>
> Chanwoo Choi (3):
>   PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
>   PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
>   PM / devfreq: passive: Keep cpufreq_policy for possible cpus
>
> Saravana Kannan (1):
>   PM / devfreq: Add cpu based scaling support to passive governor

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on next-20220509 in conjunction with the MediaTek cpufreq [1], CCI devfreq [2]
& SVS [3] series, as well as some fix-ups [4]. AFAICT the CCI devfreq device
is reacting and making frequency changes.


Regards
ChenYu

[1] https://lore.kernel.org/all/20220422075239.16437-1-rex-bc.chen@mediatek.com/
[2] https://lore.kernel.org/all/20220408052150.22536-1-johnson.wang@mediatek.com/
[3] https://lore.kernel.org/all/20220420102044.10832-1-roger.lu@mediatek.com/
[4] https://github.com/wens/linux/commits/mt8183-cpufreq-cci-svs-test
