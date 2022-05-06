Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C19851D000
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 06:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388918AbiEFEN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 00:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388910AbiEFEN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 00:13:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE61580EE
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 21:10:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id bo5so5286523pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 21:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HWTXD5zHq3nd78I0G2fQMtnfTf3zPffmr3z3YODc2yE=;
        b=aR0VAQ9OF8rz6eQoqyBQTSUoRG1tLt8chlxZ7ClCT/tuhYEdA3a5Gh/iaELz13eEkr
         PBavQpH1sdaY3bEweCwZWdgIhFSfB/YYlZl2qjgtO7BExLo5nu/9IO+RhHqMhDE5ZdbH
         vvnGCIfOhBJph1IlZfdMCOgYrJnnX9v5wDmlHyplO/9ZLQp/NUkxuWjWri+UdXFGVuv9
         b2J8stRaPwjuTj3Y69zqMCHZghk1X5tLqyTi38zyJOz6TZ13XByZe4OeAPc7ZvszAuaz
         UKpY4h35iS/5mRA9+AdvBVAMTNYCrNCPDeawqkhL7M34fFcF+936qQ+ZqmBBCkGu4lQt
         5Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HWTXD5zHq3nd78I0G2fQMtnfTf3zPffmr3z3YODc2yE=;
        b=QCzr1iOD6FY32avRns/RF5EcL4P/BkI42W3uJEZlNz9HvxC19r0H9hpioXH3cKIh6c
         FoPGsB6OUtQu3TU5KOZPkPmSP7pQ19XjKY8x9adfvu7UK9yOkDbId2GbfXOYIZZaePA7
         kOSgy3pn6HjLhg0+P/lQAdfMq/1FOqC2t8UpZiclY9btfUQ1Rct3R8UsOPmcRAFGlLmu
         7gTLbBwGzkEieAUr4wVk9R3ObjoXHkCuDuZNSG+YkXabyd/IQp+I5jSYOdmpDRpy+/Kw
         MDE4qsiVQbaWEa464UWnGy1584CVNkrupU6bPJSXuoZ/sByrlv/zxo3c4+4yGcICThCG
         FSLw==
X-Gm-Message-State: AOAM533PwNP8v3Zq1bTaf40OlK2E9lJlVX0D5q+EGWqJYmGJlqgRVUmd
        5TDI3Q8xoN3AyVLqelLc0Qnbiw==
X-Google-Smtp-Source: ABdhPJyPhc9ZE92xdZuHazul24NTSEAlSyUkTK1yoU17JLWDhr1xi6vZM3E6tgyq2zn7V0wXzXZyrg==
X-Received: by 2002:a05:6a00:bd9:b0:50e:dad:b285 with SMTP id x25-20020a056a000bd900b0050e0dadb285mr1439657pfu.40.1651810213390;
        Thu, 05 May 2022 21:10:13 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id iy11-20020a17090b16cb00b001dc37aef4ffsm2347771pjb.48.2022.05.05.21.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 21:10:12 -0700 (PDT)
Date:   Fri, 6 May 2022 09:40:11 +0530
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
Subject: Re: [PATCH v6 03/10] cpufreq: mediatek: Move voltage limits to
 platform data
Message-ID: <20220506041011.kbqawkzquyzo7yfq@vireshk-i7>
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
 <20220505115226.20130-4-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505115226.20130-4-rex-bc.chen@mediatek.com>
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

On 05-05-22, 19:52, Rex-BC Chen wrote:
> Voltages and shifts are defined as macros originally.
> There are different requirements of these values for each MediaTek SoCs.
> Therefore, we add the platform data and move these values into it.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 84 +++++++++++++++++++++---------
>  1 file changed, 58 insertions(+), 26 deletions(-)

Applied. Thanks.

-- 
viresh
