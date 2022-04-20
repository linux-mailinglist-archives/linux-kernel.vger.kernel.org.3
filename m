Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72635508F1B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381420AbiDTSM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379742AbiDTSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:12:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23549101F9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:10:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h5so2327413pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=XaJY3EGAz8IrKktJ7jqA438SOYFnRuWQecgSNO+leBU=;
        b=6whRglUKuXephhd6SgaPhbA1evrYCdAON/20A5S1FZvtkfDJdh3JTWCwkEf1CkkFEn
         6A4XUPmM+ZvhiQnACXBxVvDutFmvnYnxjpIJk0guG/ywg6hUg+tt0ndE28xvR0SvdeSS
         AiMxmzDLcIWD3mhUVXtbQwXeAwiDLiO8hYC++cz7QJxUR4kE1C7akRCoKBdffeF26CAA
         yzIqO3yN8DaK/3T6M5u342oteB/TXx8slbO1S5tFzlMlVj/+9D9TYKIDJX2Bce0u3St4
         iA+UHj8ON91PN+Nz7cDdxPBuvJGvMz5l12EBljdN6SEAzE3S5z0NLu9PyiPkutueGQBv
         SwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XaJY3EGAz8IrKktJ7jqA438SOYFnRuWQecgSNO+leBU=;
        b=ykV+73Kzcsez4NhfkCEKDgvMirRwfuxisHzkz3VR59Zk1Ob5HWMUf1yyjRndUlR1jq
         63Iwzs539q3CgOsPBmk8tWtBBa+qD1Zb+5jSy7GeC1ip4/C+gjX1XnBGgLhv5LuC6q8P
         7u13lfh53Qq1GRoMvHKW8/oxhcnFKnXExPYavEaSxoyjYSk4d23sjPMSp6DKQRWeOCdQ
         1zj9+fvICvodfIqC6cCFgqqe0wGdCZQZGUp0UNqkDFbF2FhLSTKfgZ2uUe+9yma+sVQj
         YKfNQ7LeNPQKd9AEvkhQ1yRnh+lMjooGHRyaDh4EJfT2L8JSLsWFDsJ4gEnmXXKSJj5N
         E8nQ==
X-Gm-Message-State: AOAM530uWCyq3Pe4SbfIQpnc3YAZgaHbNN4ZJpRuurs8wQYCf68s2Qvf
        75OJkVK9o9u5UkMllUoynEE1Tg==
X-Google-Smtp-Source: ABdhPJyXMqgKR4UfzMmgODjJ0nqV/iezghtHQLHP5i9ubbX8iLWYJ9p/TXuwbBQV0KOTr/z5WohRsw==
X-Received: by 2002:a63:c008:0:b0:3a2:4b:ab0a with SMTP id h8-20020a63c008000000b003a2004bab0amr20287450pgg.588.1650478200471;
        Wed, 20 Apr 2022 11:10:00 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id g1-20020a633741000000b0039958c06c53sm20024838pgn.61.2022.04.20.11.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 11:10:00 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, angelogioacchino.delregno@collabora.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: Re: [PATCH V3 11/15] cpufreq: mediatek: Link CCI device to CPU
In-Reply-To: <20220415055916.28350-12-rex-bc.chen@mediatek.com>
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
 <20220415055916.28350-12-rex-bc.chen@mediatek.com>
Date:   Wed, 20 Apr 2022 11:09:59 -0700
Message-ID: <7hv8v3eidk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rex,

Rex-BC Chen <rex-bc.chen@mediatek.com> writes:

> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
>
> In some MediaTek SoCs, like MT8183, CPU and CCI share the same power
> supplies. Cpufreq needs to check if CCI devfreq exists and wait until
> CCI devfreq ready before scaling frequency.
>
> Before CCI devfreq is ready, we record the voltage when booting to
> kernel and use the max(cpu target voltage, booting voltage) to
> prevent cpufreq adjust to the lower voltage which will cause the CCI
> crash because of high frequency and low voltage.
>
> - Add is_ccifreq_ready() to link CCI device to CPI, and CPU will start
>   DVFS when CCI is ready.
> - Add platform data for MT8183.
>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

The solution of keeping the max of the CPU voltage from OPP and boot-up
voltage makes sense until CCI is ready.  Thank you for the rework and
the detailed technical explanations.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
