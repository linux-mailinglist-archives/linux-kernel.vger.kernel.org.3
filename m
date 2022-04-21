Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38A5509411
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 02:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383364AbiDUAJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 20:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376861AbiDUAJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 20:09:23 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9396313FB7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 17:06:35 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id g9so3184198pgc.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 17:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IfHap1dlOBr5gDAC0VqPSKp2nHM5B6kQ59uiY70TBVI=;
        b=pyAdiIQH847Xev3lFbrgJG64tw7GejGY/WfX3oAg312bnNLK4hmpIaqot9kWjxeJhe
         2jjJtnNAPBqtCVzpQ0xu+7wOG14ld8qf35HMQ53oF/ippK28GiOqjjLFn5kRpFL0c+A9
         NqbT74EPPobnFYZf20wWfr7XdlUWExPupT6eBZNWr8Jsom6kuYwxB1La5eoqnjgitVLw
         jNKH9utBxGcBurzt7e6rst1y2df/nOyedwS2kjvVLv8JwnI1Y+R5nUFSUskyk6Dd5v6+
         eJ6Ht02o3PtVMd3pOQ6vjXKCAza2An1tlXdgnSOd2pZEaPtaBMK/rR3yCp5wOH/ow0IM
         ysew==
X-Gm-Message-State: AOAM5328H8/skW/LEJcfpgeQsaOZLEPGXuKYZw7g26//gjopmy8YudlF
        UqkdBZPFwU0RR//SZeximctArQ==
X-Google-Smtp-Source: ABdhPJyBccHfNaH1A30eRpDRBC9j4Q7GiILCDsil3xPBkNRkvmISVOA5FX0e7H26MH7xr/3847BX1w==
X-Received: by 2002:a05:6a00:1ac8:b0:4fa:917f:c1aa with SMTP id f8-20020a056a001ac800b004fa917fc1aamr26016985pfv.2.1650499594990;
        Wed, 20 Apr 2022 17:06:34 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id u10-20020a62d44a000000b0050ad4053840sm639105pfl.149.2022.04.20.17.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 17:06:33 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
Subject: Re: [PATCH v24 3/7] soc: mediatek: SVS: introduce MTK SVS engine
In-Reply-To: <20220420102044.10832-4-roger.lu@mediatek.com>
References: <20220420102044.10832-1-roger.lu@mediatek.com>
 <20220420102044.10832-4-roger.lu@mediatek.com>
Date:   Wed, 20 Apr 2022 17:06:33 -0700
Message-ID: <7h5yn3s3jq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,


Roger Lu <roger.lu@mediatek.com> writes:

> The Smart Voltage Scaling(SVS) engine is a piece of hardware
> which calculates suitable SVS bank voltages to OPP voltage table.
> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> when receiving OPP_EVENT_ADJUST_VOLTAGE.
>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Can SVS work with one or the other clusters disabled?  It seems like it
should still be able to work.  However, if you disable the 2nd cluster
(e.g. by passing `maxcpus=4` on the kernel command-line, the SVS driver
will fail to probe.

I dont' think it's a blocker for merging this series, but making the
probe a bit more robust so it can handle the cluster being disabled
would be nice additional fix for later.

For example, upstream kernel on mt8183-pumpkin board is very unstable
with the 2nd cluster enabled (I'm still trying to debug why), but I have
to boot with `maxcpus=4` on the cmdline, otherwise kernel fails to boot,
so that's how I noticed this probe failure with SVS.

Kevin
