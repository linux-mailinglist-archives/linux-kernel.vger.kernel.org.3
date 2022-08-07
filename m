Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF1258B92A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 06:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiHGENO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 00:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiHGENK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 00:13:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524C1B1FD
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 21:13:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q9-20020a17090a2dc900b001f58bcaca95so4858737pjm.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 21:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CBDQhy2aeTBlls3zoFxkclz+Cxr66E9lxfgdg+Soit4=;
        b=jcxUoZ3UyqFjnh/HaMnXn5NDV+gcKq+Iw9EHZkFbZxOBPhj6Wq1vV6Gr7UWQm2748l
         CLD+1mJTBWpFe16fDs688C0UhooC2p7ilflGR7IMirfwYzO3N1WWt0jpPnd2nzlhElfk
         zyPRi/uXeyDjHKP9sl27daaEt5NvW8AJiIcQ/QwlLR3JuOGbi3Im+x4cKru8FvVJqd1w
         j7NMzwYMkdGg1BC2fcZqZXx+0+rlbvvmgr5kBb/jHILXM2gYloBgXchf5dNZlxWfW66S
         OxdLT9soq2y/YwF8zaVGBOw7wIyk8H4V9vIzUegbMydk7pdB4AJ6vHWK4KZlItoISh3n
         sVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CBDQhy2aeTBlls3zoFxkclz+Cxr66E9lxfgdg+Soit4=;
        b=Zq692jxz4em6He6nIYG03atc7PD1RpHKCokPhUBK5ipgVslmqb3vXYy943ipmiB0Xe
         MCgA2M9f/lFGlIQNMh7ZXMMxI0K6qiNUlveFBTmFifprOrZzN3uOwbwZ7N2TGtjYm557
         7d+OAJlbYd/vVQJpkMskvpN+BsFmTKvDEu+zHNG85nCduZh5vGl0t1znbFrFJJSmwUa9
         oq17MF4kTEgjuUdqFNurPlxmJscEil6M20ZWJpMViQgFsGX5WSti4kztk1VHbitaQZY6
         d/YzF8nS0eC/KJx5kgxwZDiDuHdU1/UjFnMdf8OKgJBEWmECap5Yri8wjnyKx/gm/efW
         HCKg==
X-Gm-Message-State: ACgBeo0VWy+Y6lI980FsG4+lKQFiM8T3/1c52+NR61V5FfntJf0QEbrI
        IfZ1oxCpPaXW6OauLRakRFzlgbhLy1UB2NemBJA=
X-Google-Smtp-Source: AA6agR4xM1graXn3qBWOTqN+0KOZYoY0qycaShmmYXTZREj3ga8V2FDckoxQnxxHqbLKr1ESetTqKg==
X-Received: by 2002:a17:902:da92:b0:16e:f4a4:9f93 with SMTP id j18-20020a170902da9200b0016ef4a49f93mr13571528plx.27.1659845578988;
        Sat, 06 Aug 2022 21:12:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902860a00b0016d33b8a231sm5697014plo.270.2022.08.06.21.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 21:12:58 -0700 (PDT)
Date:   Sun, 7 Aug 2022 12:12:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 08/14] perf test: Add memcpy thread test shell script
Message-ID: <20220807041254.GC34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-9-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-9-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:50PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Add a script to drive the threaded memcpy test that gathers data so
> it passes a minimum bar for amount and quality of content that we
> extract from the kernel's perf support.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
