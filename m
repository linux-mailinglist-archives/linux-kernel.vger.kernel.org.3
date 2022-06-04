Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633D253D4B1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244721AbiFDBkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiFDBkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:40:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6051FCF3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:40:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o6so2882257plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AivyL9V8Uc1O7GX3xn/Ov3A+U/0bQ+9dt+dRzOycXs0=;
        b=L7+Bs1SPe4yG6zfNwb1n+93MU6mDc5f33dScy1wKlOYkBfGrmGKnBWVMYJmoUqeAgR
         BM2WNlFvDNQaMEkPdisL8/mnliuVV/aRYCwNIWgpMF0B3O4q+NH2i+zMbFhbqF/jm7YH
         S7AgH0nplAHARjqaUOWlS8bqqa58L8NmiqzdgwgFaOtUSMwo6xwxMm4aNVKw4OMoCX2z
         uZkWp/HlUwtmvbHRtlj0CTS5kkJCMyY2jwgZp61drNAt8HYWlCvIwj5Y2iyhki/+FwGw
         7sYN/aNRUzKY8erhvTgECbENBNnj2Bv9qHgJgB4WyD8f50jOmRjBQ0Tro2cel29bQ5JR
         f8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AivyL9V8Uc1O7GX3xn/Ov3A+U/0bQ+9dt+dRzOycXs0=;
        b=xHAiwbBUW0fORpU5ZyAMIBIdPzihKQaomzaqSzyhGumNTDt32A6au9DKZgx+qyPSrt
         gf7iEyxHN7hw0vTef6HPDCLcMh+/Ue1uInpBnLbL95+HGHfMKR2FfujD2F1v+IjSRvpW
         iP2ygtvJK/3IIMTg2pzzO1Qur/mN+Kt31X0A3ykOkzuCsBK88XeLjD5NwNdxUAagWcAM
         cT91ACy23ENUN1EBKDK7zWDGBoE1udt5kqXVRzctIMXTvea7Ym1x3yIz9B6IhDCop33B
         17miqPktNuZEi/r9UsfqO+YfYZw/oyGVhRVBpakhfGK+0ik35RQpVaky3cV9IPxmBytw
         r6Fw==
X-Gm-Message-State: AOAM532foSt9jecavHvKUAwPuUBiLaMKRt4vLgDuU3jy3xsfkXVs5GuA
        yG9MGYeevc9m3v7lCyTAPdgLcA==
X-Google-Smtp-Source: ABdhPJwlvd7X8WnoraYcDZ3PZxnuu4vdj0qqJFZznpL4RKod2iBAB6fs58L3ry69UWUaOG/O0NMXbw==
X-Received: by 2002:a17:902:cf06:b0:161:53b6:474d with SMTP id i6-20020a170902cf0600b0016153b6474dmr12729126plg.63.1654306814377;
        Fri, 03 Jun 2022 18:40:14 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id h4-20020a62b404000000b0050dc76281bcsm6048270pfn.150.2022.06.03.18.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 18:40:13 -0700 (PDT)
Date:   Sat, 4 Jun 2022 09:40:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/12] perf c2c: Support display for Arm64
Message-ID: <20220604014005.GA53464@leoy-ThinkPad-X240s>
References: <20220530114036.3225544-1-leo.yan@linaro.org>
 <Ypph9lA1qavXXZI5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ypph9lA1qavXXZI5@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, Jun 03, 2022 at 09:33:10PM +0200, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 30, 2022 at 07:40:24PM +0800, Leo Yan escreveu:
> > Arm64 Neoverse CPUs supports data source in Arm SPE trace, this allows
> > us to detect cache line contention and transfers.
> > 
> > This patch set is based on Ali Said's patch set v9 "perf: arm-spe: Decode SPE
> > source and use for perf c2c" [1] and Ali's patch set doesn't need any
> > change in this new round.
> 
> IIRC there is a kernel part there, please let me know when that part
> gets merged so that I can process this 12 patches long set.

This patch set is not dependent on any kernel patch, it bases on Ali's
patch set "perf: arm-spe: Decode SPE source and use for perf c2c".

Let me use a new patch set to include all relevant patches (include
Ali's patches for setting data source and this patch set), will send
out soon.  Hope this would be easier for picking up.

Thanks,
Leo

P.s. James' patch set for enabling SVE register is dependent on kernel
changes, James is on vacation, I will monitor the latest status and
update in the corresponding patch set thread.
