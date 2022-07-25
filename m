Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3CA57FDAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiGYKiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbiGYKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:38:09 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B700110FFB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:38:07 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id by8so12581051ljb.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WblVDAGa7l0gl09iYHhJiD3c+VrUQlVzxlQgD2JVeC8=;
        b=sC6Kvd2H6jTgkv3SWYSI3sn4WpwdtYcRbUhpTWHjvf6/Kqz7WH1XaUBINpI8HQWR1R
         RV77bjMwWs7pxdwi7LhuUBOR0uPrpOHXQH+4z4kYxgbqM3mlNAi/sqFV7PjDEMLIrBaA
         IMaCfPJmtdRwODD71kibngt65K4oZwKfRhx9q1OfvgV/aiau9F6g9J5TXt8qMvijBm4A
         j6iPaLrm0YWe7x2ywD0ulnG01UW+qN2eTr2fJCifGW2GvBxsVt9JPknsS8pj5ScUlcHF
         USxamzkubzS4jEVKlGd3ucLFGNGmfn/HAkKMnRrm+eXJeYOA4uB33X3z2k3A5DuZ4s7k
         y+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WblVDAGa7l0gl09iYHhJiD3c+VrUQlVzxlQgD2JVeC8=;
        b=oAOHPlju3G3cF9S3SwqRtLV2hkU8phgvxtdexLe/HLmvZ/7uHirm8MZx1XrtE7ckl+
         0AugaEG5DQ5xi7wG1AArCwXcA/FMSn2MG5uEsEKaymFhot853FRX+hIWsQdiE9uigiXn
         7BnuxsBRcpDJmeVzOe25+5ROpo1XWdh09AFMeXHwthDsPoMNQvVantQJqTYJbGjkIK64
         32F7k5dNGfF+LYk/ozaiFWtBrFT6544e78MeZfs+6t/ZU46illauCI3QCzHXLMY7do9J
         bkeNdY8PNDRt+6NZ9EhqndXNRlwm2Y7XOmi+A7nWeBIcJT6bSHzU13wcR5P8N/sH6sHY
         ZibQ==
X-Gm-Message-State: AJIora+OiNwFiypln5htDLP4QxlMF/hJrUYzBbd484+x0/hRwRPUVBY0
        TgDR5dLkSM6/3pFDjVfzD0iTcg==
X-Google-Smtp-Source: AGRyM1u+F4emxtEcYdg76LJLGmbLthvfxGhEC0/SmLXlx3VdnfeG4Ds3qoY8sUa+JZvKuMuBUxfcHw==
X-Received: by 2002:a2e:721a:0:b0:25d:eaf8:6a5b with SMTP id n26-20020a2e721a000000b0025deaf86a5bmr3968228ljc.257.1658745486130;
        Mon, 25 Jul 2022 03:38:06 -0700 (PDT)
Received: from localhost (h-46-59-88-103.A463.priv.bahnhof.se. [46.59.88.103])
        by smtp.gmail.com with ESMTPSA id z19-20020a05651c11d300b00253ceefb668sm2583065ljo.60.2022.07.25.03.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 03:38:05 -0700 (PDT)
Date:   Mon, 25 Jul 2022 12:38:04 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>, rafael@kernel.org,
        rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v1 17/33] thermal/drivers/rcar: Switch to new of API
Message-ID: <Yt5yjAAT3y4YSgl1@oden.dyn.berto.se>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-18-daniel.lezcano@linexp.org>
 <YtZ1IExNlsYaJkC9@oden.dyn.berto.se>
 <18ade2d0-ebda-0526-71f3-65a0b2685068@linexp.org>
 <Yt2W5UCXaB3Memzg@oden.dyn.berto.se>
 <e2a56ac3-057c-2b17-7bde-7e860a86807d@linexp.org>
 <Yt3KDSO248WebZ/w@oden.dyn.berto.se>
 <Yt3Vmt/AAzqzDzBF@oden.dyn.berto.se>
 <28e915c2-4871-b648-f5ac-78d6ecb32768@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28e915c2-4871-b648-f5ac-78d6ecb32768@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2022-07-25 12:00:30 +0200, Daniel Lezcano wrote:
> 
> Hi Niklas,
> 
> On 25/07/2022 01:28, Niklas Söderlund wrote:
> > Hi (again) Daniel,
> > 
> > I figured it out, the thermal zone is disabled after this change. For
> > both rcar sensors with the new API thermal_zone_device_enable() is never
> > called.
> > 
> > In the old API the zone is enabled in the call chain of
> > devm_thermal_zone_of_sensor_register(). While after this change the zone
> > is not enabled by the core when calling thermal_zone_device_enable().
> > 
> > If I add a call to thermal_zone_device_enable() together with the new
> > API everything works as before. But I'm not sure if the correct solution
> > is to add a call to thermal_zone_device_enable() in the sensor drivers
> > or in the call chain of the new API?
> > 
> > On 2022-07-25 00:39:10 +0200, Niklas Söderlund wrote:
> > > Hi Daniel,
> > > 
> > > I tested your branch, unfortunately with the same result for
> > > rcar_gen3_thermal. Manipulation of emul_temp file do not trigger
> > > actions.
> 
> Thanks for investigating, I updated the branch. Does it fix the issue ?

I tested the branch with the head [1] and it restores the expected 
operation for both rcar_gen3_thermal and rcar_thermal sensors.

Thanks for the fix, with this change I'm happy with this new API.

1. commit e9b792a531c10756 ("thermal/of: Remove old OF code")

-- 
Kind Regards,
Niklas Söderlund
