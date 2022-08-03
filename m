Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B3588F4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbiHCPZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbiHCPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:25:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733AF264E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:25:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 17so16813014pfy.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vY5Gs44ObcZqhnAkDw1pnGHq29Y4iUKBpPeypGL8C04=;
        b=lJgAtu/cwXyf8s1wIwQZ0CNNCCdmo3JMXJHH0lscHNOrNNBxXncxE/VrJgKSC2OmjC
         NOerG+8+aBL44+OZSHHph5NPJruytt71lzo8W8GEOnfS5lwOAUxXXIw2UcxyknUXR/1L
         lrVum/jmFqx0a1SppZUxYzDhGpaUJrzClIxxqSDWVBqc1ZjPa2kFfiJJMtWL/QhR5YOu
         /SaveEvW+ChdAin3Rtr7GwieqNMZCrxQJSNTs8AQckr40CoFwDoWcA9et803Nq9RtZ7J
         lrZ+le+z4NnubOJuVZXbTqF06axzexzf8tC/L2kW1P/kN1hk1pcSDjSyrqdoaXFeehIc
         6pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vY5Gs44ObcZqhnAkDw1pnGHq29Y4iUKBpPeypGL8C04=;
        b=puzGvyoyMIFR3zMYHxzIgv8E6k1flPSHZRsHWe6RTQDKapyJhz/Uf3wozg0V0Nson+
         2KToY1DVOn4wwr7Siurvpa5oQUBuyCrTLtBkkv05sEqepKj1Ccm7EeEGp0to20DXD7wq
         AqpuxwNcPDrelcH4oUWA140p5DD7wLV7uLC9xkPp9sdkzOXS4FO+H6SSBuvEfnTzehoN
         so83SRvJQL0/w+gU5W1r0wFyJKwM7fCwm8JPLh7cafXErTIAGSja3y5sgSw71T+7VYEp
         DHBYyBZkfOLzPFmAdR5qZRHwYVLqXp9cSZ/L58MrGDbQVDz+DWoBHiiH8DAtVVh/B0hz
         ZVdQ==
X-Gm-Message-State: AJIora/w8+sdz37jc2vuOOz+rr9xAn7be0KM7gSrDueJCaQswE0aSV3R
        OtRH3xesVAzlYPcCMQExoWkpPHWzM9Hrhtyo
X-Google-Smtp-Source: AGRyM1vmGDb1Z3T7ofJ95dzDpNMA/3hyYgDtd8/HkcsQWLW3sJTFg2aNQGuKVlVz5njqGZrL2NFrHg==
X-Received: by 2002:a05:6a00:1a0c:b0:528:6baa:a2e3 with SMTP id g12-20020a056a001a0c00b005286baaa2e3mr26609309pfv.27.1659540332794;
        Wed, 03 Aug 2022 08:25:32 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.83.16clouds.com. [173.242.120.83])
        by smtp.gmail.com with ESMTPSA id h23-20020a17090a055700b001f3162e4e55sm1756596pjf.35.2022.08.03.08.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:25:32 -0700 (PDT)
Date:   Wed, 3 Aug 2022 23:25:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf symbol: Fail to read phdr workaround
Message-ID: <20220803152527.GA133193@leoy-ThinkPad-X240s>
References: <20220731164923.691193-1-irogers@google.com>
 <20220801015259.GA101027@leoy-ThinkPad-X240s>
 <CAP-5=fVSjCQ4jeAeyP5THnQVyXDpKd6Ob33C7PDwFB_6+YSXuw@mail.gmail.com>
 <YufJP5YqeEBM51HL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YufJP5YqeEBM51HL@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo, Ian,

On Mon, Aug 01, 2022 at 09:38:23AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> I also think we could have something like a 'perf test' mode where, when
> asked to, it would enable tests that involve downloading such files to
> perform tests, such as this dacapo benchmark, and then would test if the
> output matches expectations.

I am working on testing script for java symbols, one of the steps shared by
Ian is:

  # /tmp/perf/perf record -k 1 java -agentpath:/tmp/perf/libperf-jvmti.so \
    -jar dacapo-9.12-MR1-bach.jar -n 10 fop

The question is how we can specify the path for the lib
libperf-jvmti.so in the testing script?

If we can run the test case from the root folder of Linux kernel
source code, the lib libperf-jvmti.so can be found in the folder
$linux/tools/perf, but for the integration testing the lib should be
placed in an installed folder.  Any suggestion if we have exited
way to specify the path for libperf-jvmti.so, or need to introduce a
new shell envorinment variable for the lib path?

Thanks,
Leo
