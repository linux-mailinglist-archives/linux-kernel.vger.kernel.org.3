Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9B858B962
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 06:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiHGEfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 00:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiHGEfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 00:35:14 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7172F1B1
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 21:35:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x23so5909681pll.7
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 21:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Stge8ij00ak/lu/+zv2sql6FgjCXn7x2g+8N+A6jXAo=;
        b=qvDhVQ6TJRd1C1ouWtzwzHxKSh90MkOwKvRqlZqFpgO0luBVQSus02sT1ws1F5oRy9
         OI9/yRPwsR6Lfawewc7s+apgHvD1wI7HsRBzouZBneXhRgZPWwRF1qL+f0Chpzf4d1nk
         pcepDErdQ4FdZy5qCGTEL1qxgUN8DGrT2CuThdDAUaQhAUkRyYsve8zqB1K6Jb/dUeqA
         3vKFSaYaBqDDWJBSIT0uYDDEVH8+1X/myWvDWz6PSIk6O0mPoz/kPBcnDFfMfqmQRuum
         SBsiSsTR4rS+LZu8W+fnw2X6LX0hteNJYM0Ln5khYgQFZZe6WdkjmRA/o/sCG2r4gDYE
         mgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Stge8ij00ak/lu/+zv2sql6FgjCXn7x2g+8N+A6jXAo=;
        b=oZM0j+btwd+SSWUC/uqzOSOdetj/ygtc0iS2/rdczRA5BADA7x5YIK/egQ3+EYj6GU
         dcsoqLSQwmmgB8BrbeESsZ2dc4i54ub1QItj1XmgFAC1ujTGyQVqcHjof0i5Solx9o9B
         1CaYOawPnGyl4vDhVyWAQ87d00o7ED7mw3t66+qNh7vLmZgGKEmY2IXOBkqg9nrO8z8I
         B+Oz/rNRx4gVv34kXOMWzbzVfEfP0IuQcWvxG23/uC+GXo1KzY0nv+2Mb40wEsfnaLXU
         IPXkaQ1fOMct9PkTkmt9h0wiZWr9fOzRprEgLOLR+C/bdy3+XLDjzZj7f4PyK9DcrAcU
         06mQ==
X-Gm-Message-State: ACgBeo35XiaWGpfzTGS/6zPBArggdJR1OwlyqlP0NOBscQjwy7X8K3uH
        /gz1VIrFd9wo6zZfDNCSnMr3TA==
X-Google-Smtp-Source: AA6agR6PvYHJPx63cx/TWBSIzUDKEHuEneqcgqwfRXdhc+m5SJaEhC7MNTdbMjOwgp5EGfmyVmS7JA==
X-Received: by 2002:a17:90a:9383:b0:1f4:fd59:7e47 with SMTP id q3-20020a17090a938300b001f4fd597e47mr15352310pjo.172.1659846912638;
        Sat, 06 Aug 2022 21:35:12 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id g14-20020aa79dce000000b0052d51acf115sm5894801pfq.157.2022.08.06.21.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 21:35:12 -0700 (PDT)
Date:   Sun, 7 Aug 2022 12:35:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 05/14] perf test: Add asm pureloop test shell script
Message-ID: <20220807043508.GD34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-6-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-6-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:47PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Add a script to drive the asm pureloop test for arm64/CoreSight that
> gathers data so it passes a minimum bar for amount and quality of
> content that we extract from the kernel's perf support.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
