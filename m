Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2734758B9BD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 07:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiHGFtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 01:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiHGFs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 01:48:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0059FF3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 22:48:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 13so4548586plo.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 22:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KZGw1PnHsXxrYwCyXKBLZGs4Yl0JJ1Too94jRTJKoa0=;
        b=k9ieTByRp257nB1pQB06VrPzSLeXQtwbFMtklYPxezobo1Fzoio1z4Zey8sfGgRNh+
         RADp322TENPrOh3/Q4k2X6EXQb4L6dLLQaNPN8Lc03Ong+0bWKvB02zW5TNiM3WJ8SpW
         eapJLPKPc2ab6wgblIY04RPHORohLCj3qS7pHUpija1zz6uXSOF35j2gVtaqDQXeLffj
         49maLAboTYsCRRCtj/9RpVHtWcT1F+hcYZmHYng5SZsQhZSP8dwhDo/oeNhd3saQmIVN
         2V1sKz89Qv9aFr0VSj26+AI/b6rPR3w5Asa/gWDk4XgaiDdWZkYdlTvXCngpzNjUvhQ5
         BZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KZGw1PnHsXxrYwCyXKBLZGs4Yl0JJ1Too94jRTJKoa0=;
        b=J1ge9IhYd3maB32f4S/jKDkeAuaB+atv2Y2A56BaGYWBtjs7J2/xpoTcZ+hUfbs+Td
         VLxJUdijVXt+lMY3wicHA6YXU79+RSt7aopFhDEm3XLFZ0tWhzYIYQLoVi865GTmytSe
         kE+B+koX5iaF2gwZjpk1p8WC8dlPlhhVkeRCl2RuFh1ZjpYCMKbempSiurXy9AAJUoVL
         W0X5VzTxsw4n/g0IYC7D1ib6Ku8OMYxkC6DlcrU02xRJ0OaShFiuX63rn5gkLJ62S6ss
         Lua7DVRXUohEEegmqyzZFXAmhflp18ki4IINyqC9DzZmHDWUZ5ptPlbsAmGk0CPydS6v
         5dEg==
X-Gm-Message-State: ACgBeo0g6Re5dx2mPIqU5y6SvZi5l9QMXhe0SqmnL0LUPSfpa4gYEJ8w
        jayrkBcvrjwZTHKtx6tKcb3TVg==
X-Google-Smtp-Source: AA6agR65OvLjWIiqwaCVUlT0OrSK6YQzHH7bKQz1av2dopEKBoPbdOgfedcQT/OlrFhLK8W6lw80Mw==
X-Received: by 2002:a17:90b:681:b0:1f2:147a:5e55 with SMTP id m1-20020a17090b068100b001f2147a5e55mr15175599pjz.159.1659851338432;
        Sat, 06 Aug 2022 22:48:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id ie9-20020a17090b400900b001f327021900sm5604846pjb.1.2022.08.06.22.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 22:48:58 -0700 (PDT)
Date:   Sun, 7 Aug 2022 13:48:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 13/14] perf test: Add git ignore for tmp and output
 files of CoreSight tests
Message-ID: <20220807054854.GK34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-14-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-14-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:55PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Ignore other output files of the new CoreSight tests so they don't
> fill git status with noise we don't need or want.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> index faa23b5d32f5..a653311d9693 100644
> --- a/tools/perf/.gitignore
> +++ b/tools/perf/.gitignore
> @@ -22,6 +22,7 @@ perf-archive
>  perf-iostat
>  tags
>  TAGS
> +stats-*.csv
>  cscope*
>  config.mak
>  config.mak.autogen
> @@ -29,6 +30,7 @@ config.mak.autogen
>  *-flex.*
>  *.pyc
>  *.pyo
> +*.stdout
>  .config-detected
>  util/intel-pt-decoder/inat-tables.c
>  arch/*/include/generated/
> -- 
> 2.32.0
> 
