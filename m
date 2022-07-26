Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE285808D3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiGZAxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiGZAxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 20:53:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC0327167
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:53:15 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bp15so23506077ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 17:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wvN812HJX/f4OQCgFtTSENSrwvfkdLlaJPljBTRD9iA=;
        b=EmLi77boATp1j5sFlXwc1PIt0zQyUIkOUvnmCGMddCioMWcEDCkCqAowbfhYPGZdvk
         Ji6G9wzGNF0snc/2LHXlPQhO0fnKR6V8QGajuxjPzfBB6ZEpLUyutnLwKnV2tr2VlY8D
         CbB1wtPusll4Oq84E5SELOdovai9pLJRXQlN/3A9MzUd4UvVaDsfEJh/FGYrD4pYc8KF
         HhPcE25o9BAHvqE8i87byn4vto0qHBAV15U5v7ew6/OORMkAaDtky+zTMMHDidi/bNO0
         P2vjZCMe4+jlrj85xaOV1d9mTYaDi0cgyvXwGgrt+zRBYzpnMhDqpT0S6rT2+1mUNSk3
         +ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wvN812HJX/f4OQCgFtTSENSrwvfkdLlaJPljBTRD9iA=;
        b=EGDCm7Fm0IWwWWpcf6Me/IX141vLvxCWnJ0eH7W18l73VLWnewXLRF9Iybqi6wtn2p
         /UvilwVuJKwLNAU0JpXUz+7DWTv66Mzqxdmk0bLAJ1RwDiidgyVO5jXhUl05IXL1U3Pj
         GtkfOBhGi4cI93LphqAXXnYLNBR7BVqm/BWEQJT6JzwYsvR7tAKLrX0au2zNxquZtUpj
         X8BvCgVS1D689exg1cnjEa1/ffjy42ow3CELA/6PCmd8pMtIDvzaeYPdPs1kU/Nbzc8R
         Z2kpjUkTTRpdsDBJayRVzJ1ckgsjg7pfQLS/vhPj8AXNw0nklU84f9d+Wgzxkk1QP2Pm
         tCCQ==
X-Gm-Message-State: AJIora+jrH7Q3qYxZV7GS2gCepNiZvdXy8z118sXnP49iHqHsE5JHJ8Z
        wyxg8NgZOpI2TtuU51w8Qco6TA==
X-Google-Smtp-Source: AGRyM1vMtKa9GoFOwwRjF56McF8u7TC7HmlZJR3DgwUAs0Drq6G14agxLmErcjsy8ldHGI0cgS7QuQ==
X-Received: by 2002:a17:907:1c1f:b0:72f:1ccc:bc3f with SMTP id nc31-20020a1709071c1f00b0072f1cccbc3fmr12178732ejc.281.1658796793730;
        Mon, 25 Jul 2022 17:53:13 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.97.243])
        by smtp.gmail.com with ESMTPSA id m15-20020a50ef0f000000b0043a2b8ab377sm7912001eds.88.2022.07.25.17.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 17:53:13 -0700 (PDT)
Date:   Tue, 26 Jul 2022 08:53:07 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf symbol: Correct address for bss symbols
Message-ID: <20220726005307.GA36862@leoy-ThinkPad-X240s>
References: <20220724060013.171050-1-leo.yan@linaro.org>
 <20220724060013.171050-2-leo.yan@linaro.org>
 <Yt7hGepLBAJJuvII@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt7hGepLBAJJuvII@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Mon, Jul 25, 2022 at 03:29:45PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > First we used 'perf mem record' to run the test program and then used
> > 'perf --debug verbose=4 mem report' to observe what's the symbol info
> > for 'buf1' and 'buf2' structures.
> > 
> >   # ./perf mem record -e ldlat-loads,ldlat-stores -- false_sharing.exe 8
> 
> Can you share the source code for your false sharing proggie? We need to
> have something in 'perf test' exercising these routines :-)

Sure, I am using the false sharing test case:
https://github.com/joemario/perf-c2c-usage-files/blob/master/false_sharing_example.c

... with build command:

$ gcc -g false_sharing_example.c -pthread -lnuma -o false_sharing.exe

Do want me to proceed for adding test case?  Otherwise, it's fine if
you will work on the enabling test case :)

Thanks,
Leo
