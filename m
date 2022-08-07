Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED03458B927
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 06:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiHGEDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 00:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGEDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 00:03:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66E81056D
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 21:03:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso6313674pjl.4
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 21:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=24begAuPfMumQx1ZI6r2ZNtmvYf6DMOmJ+U4rP45nPo=;
        b=VU37IegVGSvmgOs9Xuwtg44Enmj9uhWl1s3zmuUgO8JkDkz792LdLF0NqMo3itg6G5
         I7+RHcAHUiKvWjLEBZpQccyJftxDsOVHFDNGPM5Q4F9uFC07EMBiItKR60XzCIb4CpTF
         9GsfGFeWuHSz56ftUuV3KlzYkOaCr9m/idHwRnBoqKvzze5r3IG0g5Kp6BBjGjAB/qij
         IuF40LbM/Nq9FVVhW/opNA904FpGVf7Gv7+F/neTQ/R3vzhixun4F4pTmxO5yXncRi45
         vAC8lRE4NxRtATjY0OSUxQKWySqTx6eDN2GKpJeuMihju647G5KEZmGmojCIj0NFTlVp
         RnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=24begAuPfMumQx1ZI6r2ZNtmvYf6DMOmJ+U4rP45nPo=;
        b=SER0+IxHPHnUsKAKNTx3p/b2eOS+hWcqGMolou8nXYmUHOnMSeXBGWK0+hSnHbDk6W
         kGvD3b973gkfG17ETaqhPQj3rS7x5jyFl1OpRoFA7pmXs4J6/WzNXxPmPViRuvQ2sZtB
         QmhRN/UbwNLfkS5kT33XOSYZnrLls2FfJFnNqddtmiu77zrkJfv+qne8cgCrz/QU8gWF
         vumYgQa4JU/WYJop0GIeuNJa89mvyykKq23eDoflezAd+EY9G1whzcxHAuY+7MtNE0Jz
         keytkzwkimrzUkKGg8fSWBVCcK8q6NSXmKpxg/CD/IR45erKZjOvys/Z1zI692RvAc51
         0uvQ==
X-Gm-Message-State: ACgBeo1aiiSO8aZK86WSc1RXT76CoFduQCAwgk4zfYDJVYheEJogeRc2
        DMwMVxGwvHQn84TonbdjlOUwzQ==
X-Google-Smtp-Source: AA6agR6YuclF+p6eRhKo+nhhI6zJNd54KElED6BMkPTKYIOT937y3uW2HTfp2lb+iy6JA1f5w64ZCQ==
X-Received: by 2002:a17:90a:e7d1:b0:1f5:665:4607 with SMTP id kb17-20020a17090ae7d100b001f506654607mr23600015pjb.77.1659845011029;
        Sat, 06 Aug 2022 21:03:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id 131-20020a621589000000b0052aaf7fe731sm5831150pfv.45.2022.08.06.21.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 21:03:30 -0700 (PDT)
Date:   Sun, 7 Aug 2022 12:03:26 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 04/14] perf test: Add asm pureloop test tool
Message-ID: <20220807040326.GB34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-5-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-5-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:46PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Add test tool to be driven by further test scripts. This tool is pure
> arm64 ASM with no libc usage to ensure it is the same exact
> binary/code every time so it can also be re-used for many uses. It
> just loops for a given fixed number of loops.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
