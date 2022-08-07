Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA25E58B99D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 06:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiHGEuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 00:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiHGEuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 00:50:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F06910550
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 21:49:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y1so307120plb.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 21:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=34UjCepJnEGaWEv4BfkeG4LKGUcOI8nSXw84phYU8Eg=;
        b=dM8DFJfSgrhpRskf9ZeMiafMH3CJsu8E05DaCY8m+PCxb4cJsX6XEyRs9z+U4r8kMP
         LWIbjpx8AQRUHOOCeNs2PDdgwDBWV9bybCOvlx5cYbrsCyc39JkSIoNh/r6vnj/K4WOE
         c/2gaenN1g58I1hiIef4/lRClQoTcfD51cOh3B/KVkTaGaVVHZUcZsZLvJXnLbfKwSMe
         fQ7A/LiruXV8AHo0zyAmWrDLlGpv4MoC8W4TJ65b89a3cZ1XC1uYO0vX6ff2qBdgsfU7
         HXrLLkjYoF9m8PzPk+f7k0jF5IAUC38n+UxFET6B7p8FlB9W8ZoNKQoIiRADVkob5Omo
         Xrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=34UjCepJnEGaWEv4BfkeG4LKGUcOI8nSXw84phYU8Eg=;
        b=JvkDAabkw4JQgfo/PA5mR3wBFjqeiRFnKkIrOq1VnzxGfehL7eVpdHGiOCDvJo5xjB
         FgzDphtVeEwpnrRijQlhg2EsB1hY4oLXTrBplLlyJxZGbAmxB8X0C2pdB0aZykmw0Dng
         TvxFmjgRVQMraGVFMUoIKnN+uos5bLMm5gSMk7q6o8OHeeMQBl/+7QZEAiRieQkSabwn
         zL/AvZNIMcoTplg3yULpuq/SeXcZm9WjpNgR9jseOiOTWzdYyE6u4Gj9mLdMGJQuGzm/
         UMIicVn9LDW82gXf7dt4hLm+qg6dH1EyxPkkiQXz/BoOkjYOxmLsiu84nZvlUfd9So/L
         czXA==
X-Gm-Message-State: ACgBeo24N2afh3oaZBHFAfFx7DZGF1kco5Yy/gZwOdbbYHZHfykk6iFF
        JLGsO5uyWdNEhN3KQV72EcuSdQ==
X-Google-Smtp-Source: AA6agR5eHEAUjmqwG9nepAwZ8onWN32a8yXDMIxpkLTl/f00s4EngmtbICM6uqG7J1YMgkRenowjJg==
X-Received: by 2002:a17:90b:4c8e:b0:1f7:2083:a91b with SMTP id my14-20020a17090b4c8e00b001f72083a91bmr6849514pjb.119.1659847798384;
        Sat, 06 Aug 2022 21:49:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id 141-20020a621493000000b0052d14966783sm6080132pfu.15.2022.08.06.21.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 21:49:57 -0700 (PDT)
Date:   Sun, 7 Aug 2022 12:49:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 07/14] perf test: Add memcpy thread test tool
Message-ID: <20220807044953.GF34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-8-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-8-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:49PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Add test tool to be driven by further test scripts. This is a simple C
> based memcpy with threads test to drive from scripts.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
