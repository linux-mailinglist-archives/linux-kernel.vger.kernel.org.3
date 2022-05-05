Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0188451BB12
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbiEEI5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350660AbiEEI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:57:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E814839F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:54:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j6so3124287pfe.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qsLVNCQbuqNelZfcG6SxH1A2kbkVX6IY27mcYuqmtzk=;
        b=hEBwtnbs2qsJgQ6Y3heHEf4jDHU69XMtUIPlTYr5E7Mwo4jsLOvz9FxXKLh854/sPQ
         bK9Gth2BLbto3q5+hQvwkKFE0dqt69oDvPedSJ95mr00ChZWS7EjAd9igGYRkKqQAsd2
         vAVyvodLYegU7aQNOfH9d6ESJyo/NghjtPrDm0OMGoQMhnk5/kgeq78jU0UexUtklvQN
         d8zh2PCMSOdzz4IpQCwJg/wqploxBlOovLM3o+VWlvLV2uJwjYt47XwBQAalSI8d0Vpi
         TjzqvaTSJuNxVpU96Oe1mAeBPa+GHUVLTiH5mTlQqpBjgFaBrB/3szDYyIUbhacHXiBC
         hoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qsLVNCQbuqNelZfcG6SxH1A2kbkVX6IY27mcYuqmtzk=;
        b=ixhuCrO0h2CM04PQtOUmAvCiAJOjZHbfxa3QZiAhsn9Gqwr7yRXq9O8nCRsk73BGXU
         S65rmB6pFNTOcdqxTXfNpfPLdkmBI06PEqr8dGhyObe8vKBuiV/jS5KFQJ1emgrHdP4K
         YNohQlBbhtlrRlQM8XWGfpkOPtGAzgzD3kD/S2hbEPC22e/MBpHrPMqxbv2T1LFD+dJy
         ccPYtfXWx8ZloT0MCfENDGVoO527YCJyMeCA6BH/C9wopa7k1Pl5ubg7sFGDRcclHswe
         KuZ+l4CwVxH4cbDYMnlLjPMysiYqOVB8Xd2wctk6+Qju66/QBN2tAQhdxWTUhFdfAEpy
         TUSQ==
X-Gm-Message-State: AOAM533vjqtJtJnCqK5ETXiFIQMKxCw7s7qnoqjMlsTH4KApitToi0XK
        cCb55V1vugbRCtxmCpi+Qug3Gw==
X-Google-Smtp-Source: ABdhPJxx/Nw6BtoZublv6LltW3nNlrc2IvnZviGEus5evK/SUN+o7dLcUxn30ZDTaOdfsZ3C01YK6w==
X-Received: by 2002:a62:8684:0:b0:50d:972b:d9d2 with SMTP id x126-20020a628684000000b0050d972bd9d2mr24615633pfd.4.1651740841059;
        Thu, 05 May 2022 01:54:01 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709028c9600b0015e8d4eb1ecsm955056plo.54.2022.05.05.01.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 01:54:00 -0700 (PDT)
Date:   Thu, 5 May 2022 14:23:58 +0530
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
Subject: Re: [PATCH v5 0/9] cpufreq: mediatek: Cleanup and support MT8183 and
 MT8186
Message-ID: <20220505085358.nmohfx3akk7to46r@vireshk-i7>
References: <20220504130540.5902-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504130540.5902-1-rex-bc.chen@mediatek.com>
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

On 04-05-22, 21:05, Rex-BC Chen wrote:
>   arm64: dts: mediatek: Add opp table and clock property for MT8183
>     cpufreq
>   arm64: dts: mediatek: Add MediaTek CCI node for MT8183
>   arm64: dts: mediatek: Add mediatek,cci property for MT8183 cpufreq

I guess these would also go through my tree? Please get them acked by
SoC maintainers.

I would also need an Ack from Rob for the binding patch.

-- 
viresh
