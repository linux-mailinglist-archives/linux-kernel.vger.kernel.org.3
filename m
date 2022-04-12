Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EA04FDE51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352191AbiDLLmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352425AbiDLLhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:37:48 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF851B0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:17:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r133-20020a1c448b000000b0038ccb70e239so1419371wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FgjY7H1ZyME0qwy3R/u6paw0pnftya7ZX2HN8cgGzfA=;
        b=ne3w86K753pIjNk60LVZmDgZk8VZDfs/glLnxVo4/VjTxiJ6UUTFrdIqsVmpW2sL/o
         MTagu3acV1bPiyXknAH6hYt7apWs2Yrguz5IEXOA1kjzVU2QYLmyyGrdO+zWkcb5WwyA
         TmgzpPSGfITPJtjuphY0J81bzhOdlhsOQ6dfHZ/iFjoeidISUZdair1sW3IVK8BghOW0
         jB2b2hRCF9JtEKU6vX1NspPynkxij9wXhxT01iP/NcRT5Si1var8squBmK+g0BY1cemh
         jEK8dRqXHKWFFF9Pv7qTmXE0tqTPo3VsiGGgo6pgzHDtaQX4FjEG8VL0ukEeGFSuX7T9
         4PTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FgjY7H1ZyME0qwy3R/u6paw0pnftya7ZX2HN8cgGzfA=;
        b=m6hOAejj/GNaMxCI2tr4IiDxqLjjY4E9KkebMt3qyl9NIMVKkRehWNbC2LOUzdKPZk
         qkl5lPtYSm7E28X4SvC3KzI8iF6dOSg+moG2Wa90IJKtRm59z64rSV1JBa+XCbLU+vj6
         TsJ+AhoCHf9ZELQ3F0UoJzbSKgxb/Z/J2ER/AlFrdaovAMTTyN5RcKIAN+alBPZEUHgN
         yNE9mQtPN5bjlzY6RUAomLHR8mpaB6jCozYgE2ibFoHjLJGgeoRSGz2gFJQum6B1lVBO
         u2ShSBw69ORqbkTmDx2+Pt0iMva+Z6l008jRjna+XRngZ1E9sOJsUxQ44zNfUXjh2QZk
         ociw==
X-Gm-Message-State: AOAM532L1zvb+wiWcqbTrOHqiyC65xIyMWPT6vQIGvUDpsSm6S4aBlY4
        Vb08ahVKKV8Saiu6KSvZznxN9p72eGh5gCBxTNjFRg==
X-Google-Smtp-Source: ABdhPJxFEQ5ap88OFgjsOLJn9UFZkYYgmfWEoc8ZKgSxPxYiQjW5JyNj/W++bqErekphko+y61J+q4WmOuKQF2iY9nY=
X-Received: by 2002:a05:600c:1c9c:b0:38e:3270:373d with SMTP id
 k28-20020a05600c1c9c00b0038e3270373dmr3340130wms.199.1649758635934; Tue, 12
 Apr 2022 03:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-11-james.clark@arm.com>
In-Reply-To: <20220304171913.2292458-11-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 11:17:04 +0100
Message-ID: <CAJ9a7VgHFcdqHyKX4R3Uv-pCNzQ=q1Zj7-798K+-FOgHMskyiQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] coresight: etm3x: Cleanup ETMTECR1 register accesses
To:     James Clark <James.Clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        Anshuman.Khandual@arm.com, mathieu.poirier@linaro.org,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 at 17:19, James Clark <james.clark@arm.com> wrote:
>
> This is a no-op change for style and consistency and has no effect on
> the binary output by the compiler. These fields already have macros
> to define them so use them instead of magic numbers.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x-core.c  | 2 +-
>  drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 7d413ba8b823..d0ab9933472b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -204,7 +204,7 @@ void etm_set_default(struct etm_config *config)
>          *  set all bits in register 0x007, the ETMTECR2, to 0
>          *  set register 0x008, the ETMTEEVR, to 0x6F (TRUE).
>          */
> -       config->enable_ctrl1 = BIT(24);
> +       config->enable_ctrl1 = ETMTECR1_INC_EXC;
>         config->enable_ctrl2 = 0x0;
>         config->enable_event = ETM_HARD_WIRE_RES_A;
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index e8c7649f123e..68fcbf4ce7a8 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -474,7 +474,7 @@ static ssize_t addr_start_store(struct device *dev,
>         config->addr_val[idx] = val;
>         config->addr_type[idx] = ETM_ADDR_TYPE_START;
>         config->startstop_ctrl |= (1 << idx);
> -       config->enable_ctrl1 |= BIT(25);
> +       config->enable_ctrl1 |= ETMTECR1_START_STOP;
>         spin_unlock(&drvdata->spinlock);
>
>         return size;
> --
> 2.28.0
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
