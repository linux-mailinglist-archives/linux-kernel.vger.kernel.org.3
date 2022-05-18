Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FBF52B6F4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbiERJ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbiERJ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:57:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F5A3150D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:57:44 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r71so1727199pgr.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tc9+bvqYCqMUSJXb0nfQvcyKgjqV7Ocz6lWJsoBLOyQ=;
        b=am+ErBo1ZB0G/hYVBrcfY1g1WCS12VRPKU0MqxO1eFPOZMnO1PfcYkLY3tknTliDWw
         wBxg3LqZeg3ef3iGmyHkqn5SkRzAY1N5efuwoM7Ks+s38oDEoUJ05k6XRmLMQkuXE23j
         Ts51nH6G6UDl9pi4Jy0PmG8h/z4mbK/jT4Qi/3K+KzA3bYHCZ9R60zq74x+5dZidSzJ/
         eWrgC3XfDdl4Mzm+4qDElEQJiU4NCV3owan7qspY8A0AndODbOwqRy2U50Dzxc/nU3as
         5QpBsthosbzuJM2zWM2vnv8Db49i3VEpNpZVfEub7knFMi3uWBTIiRIJdYAeOvh0dkuN
         GJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tc9+bvqYCqMUSJXb0nfQvcyKgjqV7Ocz6lWJsoBLOyQ=;
        b=MYgo376JwKNQd29cgneNpbJd+xccRQy6gWxns5IwrMeVisOzlPfsSFnc1QIsk5uaio
         epiOx+kGWHDyl3+TrWr284X4rPultL5lzv89kKNNWS2cFkNeZkD7qmXjSs+oz5S7tEGB
         hVtrKxpPgjle4VXUpVS8xvtkyd9iKlbkFAbLDvLVX5W3PDw3ztaBiMwnne2fUJ4KPmVR
         CJMwYgurOhpWr2PNxeGV3Cm3nIug1UZ9FqIPn2eoDB+BhIkl9zsTJW5TUDgKWlCXHZ9w
         ZRAZGWZzCtrbP5Jgcoj5N+aozDlTpdtz2H78bAX3RIrEJi6IFHbH6rXHo5B9uyspw4ZI
         PsYA==
X-Gm-Message-State: AOAM530PGfJda59bUHF9ZcXCWynFowAeRahzw0g/45CqzWNA9xmaz1OZ
        F+6E5ywVOAM4VPfwadUz1RgLVA==
X-Google-Smtp-Source: ABdhPJwxN17DvvwgA27WGHd/CQU6EzFpAzCAl1BFGWWAOX6ggp1eIFb0ryL4HktPXI/Dtai14vWbIA==
X-Received: by 2002:a63:5a01:0:b0:3d8:22cb:9224 with SMTP id o1-20020a635a01000000b003d822cb9224mr22960915pgb.548.1652867863321;
        Wed, 18 May 2022 02:57:43 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([137.184.121.66])
        by smtp.gmail.com with ESMTPSA id s26-20020a056a001c5a00b005180ea859d7sm1419223pfw.123.2022.05.18.02.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 02:57:42 -0700 (PDT)
Date:   Wed, 18 May 2022 17:57:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org, german.gomez@arm.com,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] perf tools: arm64: Add support for VG register
Message-ID: <20220518095735.GB430350@leoy-ThinkPad-X240s>
References: <20220517102005.3022017-1-james.clark@arm.com>
 <20220517102005.3022017-5-james.clark@arm.com>
 <20220517131952.GE153558@leoy-ThinkPad-X240s>
 <ca02e8f5-04bd-01ff-7b57-0fd08a1e2359@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca02e8f5-04bd-01ff-7b57-0fd08a1e2359@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 10:44:57AM +0100, James Clark wrote:

[...]

> >> +	if (getauxval(AT_HWCAP) & HWCAP_SVE)
> >> +		attr.sample_regs_user |= SMPL_REG_MASK(PERF_REG_ARM64_VG);
> >> +
> >> +	/*
> >> +	 * Check if the pmu supports perf extended regs, before
> >> +	 * returning the register mask to sample.
> >> +	 */
> >> +	if (attr.sample_regs_user != PERF_REGS_MASK) {
> >> +		event_attr_init(&attr);
> >> +		fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
> >> +		if (fd != -1) {
> >> +			close(fd);
> >> +			return attr.sample_regs_user;
> >> +		}
> >> +	}
> > 
> > Just curious, since we can know SVE is supported from reading
> > auxiliary value, can we directly return the register mask as below?
> > 
> >   PERF_REGS_MASK | SMPL_REG_MASK(PERF_REG_ARM64_VG);
> 
> I was trying to cover the case where the system supports SVE, but
> the kernel doesn't have my changes to add the VG register yet.
> 
> Technically I could just attempt to open the event without checking
> for SVE first and see if it works or not. But I preferred to be
> explicit so it's obvious why we're doing that.

Understand; LGTM.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
