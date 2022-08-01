Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68436586262
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 03:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbiHABxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 21:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbiHABxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 21:53:08 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF912087
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 18:53:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sz17so17742503ejc.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yTvm3wwagmTX69a1KC3CUigiKtFCy3zwt67VVBZyDak=;
        b=GPqW1cTLq5YaJ7qIRYRVxx9+6cQZp1Moby7K1w3+gO0s7t18ND9NWqsag2/40InWoK
         frmyFWE9D6dlG3SRq6yPU3uRZ9Q6Wgx273hlmzeamoXLcqIvI15Emjaa07ckgKpiRLy7
         ujzHufZKrkUfcQgC1OCDvBe0/DZ3tumedxGlufI5ZEkC0creBoIhLcJ4S8mBx+bEeJ3b
         RuW3SvhyOFWT12JUy0oJkTlk7gJmkS6hBfklSHiVGI/06hRu3m+H5kE4AtoI95230Gjo
         Q9Z3vxklJJXLUUQeeu9FJHY2xA46Tb2LU2FiI8cN/JFuHu6BJu4FQTuNjaog7wmZq5Ul
         giLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yTvm3wwagmTX69a1KC3CUigiKtFCy3zwt67VVBZyDak=;
        b=PzeIlvLO4jX+g4+atldFNY8yfo5h6qZS9KlCoOsOIrjHHF1pEebMX6FLhnXxsaGVKZ
         lQrjhtqFD0fZqQhNBgcUs7vNcS3arMqyiK2rT6S/sBW/I36aSSow0x/PbuBAQXPL6Spe
         W6Sy0YfF9wZxaAIJc1Dqf0RMzC7bDgWsOl+GVNYcMzsArzH2EQdhd0BUyKNV6QM2WMPa
         cPZyZFzAv8Jme3VBBK+Pc4uFAhaNjdM4gcLuowIWeX4Wat9lMBV0KuYNFE14CE1flksL
         D/iZQulNnTYYN5kamp3EaAd5CJ52b149rbqbHk1HGLjemjEXYghQ2j5zAi+AgI5AkW0Z
         eh/Q==
X-Gm-Message-State: AJIora+qruOzOcTdnxsheeTS6fv9mFSGULLvzXKimZtaRXwBE8VSC/RN
        3Ruos3GN2lIF2ocPIjGe/wi7uw==
X-Google-Smtp-Source: AGRyM1sYxTmAAq2ftLjn15qJjzoPeYDwFeWVqT5gRbWJYURnOvZmEA+/36cenRUMOT6AnJ4ECGUniw==
X-Received: by 2002:a17:906:7950:b0:72f:d4a4:564d with SMTP id l16-20020a170906795000b0072fd4a4564dmr10730422ejo.479.1659318785656;
        Sun, 31 Jul 2022 18:53:05 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.98.208])
        by smtp.gmail.com with ESMTPSA id b1-20020a05640202c100b0043cf2e0ce1csm6043374edx.48.2022.07.31.18.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 18:53:05 -0700 (PDT)
Date:   Mon, 1 Aug 2022 09:52:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf symbol: Fail to read phdr workaround
Message-ID: <20220801015259.GA101027@leoy-ThinkPad-X240s>
References: <20220731164923.691193-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220731164923.691193-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 09:49:23AM -0700, Ian Rogers wrote:
> The perf jvmti agent doesn't create program headers, in this case
> fallback on section headers as happened previously.
> 
> Fixes: 882528d2e776 ("perf symbol: Skip symbols if SHF_ALLOC flag is not set")

It's good to change fix tag as:
Fixes: 2d86612aacb7 ("perf symbol: Correct address for bss symbols")

I saw stable kernel maintainers have back ported patch "perf symbol:
Correct address for bss symbols" for stable kernel branches, the
suggested fix tag would allow this patch to be landed on stable kernels
as well.

I think I need to manually send the patch "perf symbol: Skip symbols
if SHF_ALLOC flag is not set" to stable kernel mailing list, this
patch missed fix tag.

> Signed-off-by: Ian Rogers <irogers@google.com>

With updating fix tag:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
