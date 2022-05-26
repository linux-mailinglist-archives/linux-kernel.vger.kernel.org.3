Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B458B53520C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347796AbiEZQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiEZQ2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:28:52 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E494C7B9FF
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:28:50 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 137so1719888pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ZV2y77FSAdklT7BKF+Tws43T4buN/hfHfm1U5B1OUTY=;
        b=2l+TLfCq3eeZ8fnL4KvNPyIePz/kfWJ3xDqUw9rjbwjbepocHIx4xOokRfKmQZXcjq
         sB5yKd3QPZI5WpbmUONnogFtTwkfTufAtkNQonFhta858pKIj2mrLBfwaThv1XLZ5qUw
         HKIfY772DkudNhL4y/3qsv/BKNLOeELnYiOseGovKA4UxOyeMFRh4NyVQGIC8uqaGZim
         9DhOn5r6/7Sk/fsjJsyGjQPLb6Cq8vkxTNiyMwYleEyaUXMu9ZHZuHnsnYj9aY4063pL
         anmx7dkc0QrcCB3o/tKUCMuIy3+/gM0QRdQoNMrZ6w6nZ8SVa+ajkscjDC/GqA7XbnmK
         m6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZV2y77FSAdklT7BKF+Tws43T4buN/hfHfm1U5B1OUTY=;
        b=Fpv8ZKh8VUrAMgBiHveCgyzsIhWSmq8Okwf9QMY7egsGaLTWcyEXYfsBIjurZAa9xb
         AmYFHi1Qk4RuHDfdM65dL5JtUzBqoR354kpwD/lXH3fhKN/zOVQbqRO4DoMWjfq+mcJR
         rWvw6WifTJT6u3ISgDtnu9+NhLkXau4FJmsw4lWAe2vIpjJDZKRWFd9GDQraaPqJTyr9
         qmMQ1e+n3uBVAkHOWQjnafWUZ0hWBP41zw0/0tX4djpVGpgteqvb/49PJJyP75BsVooW
         98GKM2hg5uHOknmzklDEWBb5JL3RSlP8tLgnVIiY96MZzCPwzHJSU1ww1B9WX9wGz2ES
         dU6g==
X-Gm-Message-State: AOAM532csenTrC6+QMAsTvDc20V/tpNZhTRlsXJKHNobtkMBz619nROS
        haLcVZByXQeVCf9eLZTB3h/ZfA==
X-Google-Smtp-Source: ABdhPJzsd/UhDYfCsKi9Q0HQ1PX++LTeTnaX8uCbHKcHAw1xfbhM6zfM0BCJpYZwUgFFGZu7q+LWNw==
X-Received: by 2002:a05:6a00:15c2:b0:518:9911:4952 with SMTP id o2-20020a056a0015c200b0051899114952mr22033146pfu.64.1653582530334;
        Thu, 26 May 2022 09:28:50 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z12-20020aa785cc000000b0050dc762818bsm1714033pfn.101.2022.05.26.09.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 09:28:49 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] mtd: rawnand: meson: fix the clock
In-Reply-To: <20220513123404.48513-3-liang.yang@amlogic.com>
References: <20220513123404.48513-1-liang.yang@amlogic.com>
 <20220513123404.48513-3-liang.yang@amlogic.com>
Date:   Thu, 26 May 2022 09:28:49 -0700
Message-ID: <7hwne88dha.fsf@baylibre.com>
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

Hi Liang,

Liang Yang <liang.yang@amlogic.com> writes:

> EMMC and NAND have the same clock control register named 'SD_EMMC_CLOCK'
> which is defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is
> the divider and bit6~7 is the mux for fix pll and xtal. At the beginning,
> a common MMC and NAND sub-clock was discussed and planed to be implemented
> as NFC clock provider, but now this series of patches of a common MMC and
> NAND sub-clock are never being accepted.  the reasons for giving up are:
> 1. EMMC and NAND, which are mutually exclusive anyway
> 2. coupling the EMMC and NAND.
> 3. it seems that a common MMC and NAND sub-clock is over engineered.
> and let us see the link fot more information:
> https://lore.kernel.org/all/20220121074508.42168-5-liang.yang@amlogic.com
> so The meson nfc can't work now, let us rework the clock.
>
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Thank you for your persistence in working on multiple iterations of this
until we came to a final agreement.

Kevin
