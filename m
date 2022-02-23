Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA864C06C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiBWBPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiBWBPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:15:10 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A471B3BBC0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 17:14:43 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id q17so41443100edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 17:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DNij7dJZj5zCpqmuUWdIbA82PPs/8sAPmCNMapkES6s=;
        b=XNspZZ4driA4cb2FKagm4/dWDOnodKxf+OlobbFuUf8VqQkTUrI4L+94mfIP+VU5lS
         omlhFibWic8kSV97vsaLuQs/u0HoESkoOrDFKA9ipYeYB22OExU6AEswJ1FRgW5r+nYW
         1n1HgpWnoPj2VblVKVuPMFn6SjEanltt9efvK7zczVo87/IHGED+Y01JDdO63DJfIBTu
         4paJX+NOPmwk2OXHNradQ5SEVcaDuUZLbIYGpk6lPW0+kGhJtn7SfuwwKAm2Qecgwi4s
         Zx5W5K0IQkKAVVZGC8uGWEtcLrUzGo7c0l81pl4ZTUxoEbpqZluGwGbcgxH1cGKmgB35
         E5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DNij7dJZj5zCpqmuUWdIbA82PPs/8sAPmCNMapkES6s=;
        b=WsIhlzLzxeA6RKfeNNTFxZDZidycEwbdsRbZk9Andwtk1h8xNtXRwF0UJSobI0/GJW
         S9lWFSgMTmwt26lXAE64zjq4TYN0nEJoj0jQEuGcN4fJYiSsVa5n/59/gxMwWNf1J6iZ
         wRsvJqH0Mwqqt+q5Ez0pL/btsosF2WVux2MDfMhMmktXZunbbEm/MhmjrNomlR27kx/u
         lFRgzRVtAVPp/8Y7YdqmEVb/7tnDyoG2gtb1uFU5hShs8W2piF5PSahj1elaeWo6i+dC
         0ruI7LUkoQM4NRFz7V/P4jmw6KdiypILifqEXCDQYwz7DzmPtKoyMcaKRQkRSieKk5kE
         LHfg==
X-Gm-Message-State: AOAM533TfJsQhyuC/HPTfXcXuuyeOJgOhwABHUOnHF4779tsnt084x3l
        Nj8G1GxEPDHY2cl/rmAR/OXI1Q==
X-Google-Smtp-Source: ABdhPJzFf7MKIat98fe1ra0oh3XxS6M4SiPYcL3oOvRcS3tqDQFQR0ugtEpr0i1sUZvufrEyRCc+gA==
X-Received: by 2002:a05:6402:278f:b0:410:d242:465e with SMTP id b15-20020a056402278f00b00410d242465emr29984419ede.292.1645578882145;
        Tue, 22 Feb 2022 17:14:42 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.223])
        by smtp.gmail.com with ESMTPSA id n25sm10775059eds.89.2022.02.22.17.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 17:14:41 -0800 (PST)
Date:   Wed, 23 Feb 2022 09:14:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf arm-spe: Use advertised caps/min_interval as
 default sample_period
Message-ID: <20220223011436.GA414932@leoy-ThinkPad-X240s>
References: <20220221171042.58460-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221171042.58460-1-german.gomez@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 05:10:42PM +0000, German Gomez wrote:
> When recording SPE traces, the default sample_period is currently being
> set to 1 in the perf_event_attr fields, instead of the value advertised
> in '/sys/devices/arm_spe_0/caps/min_interval':
> 
> Before:
> 
> $ perf record -e arm_spe// -vv -- sleep 1
> [...]
>   { sample_period, sample_freq }   1
> [...]
> 
> Use the value from the above sysfs location as a more sensible default
> (it was already being read, but the value not being used)
> 
> After:
> 
> $ perf record -e arm_spe// -vv -- sleep 1
> [...]
>   { sample_period, sample_freq }   1024
> [...]
> 
> Signed-off-by: German Gomez <german.gomez@arm.com>

The change looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
