Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E75527B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 03:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiEPBVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 21:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiEPBVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 21:21:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E8FEE0B
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 18:21:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so2665987pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 18:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DnZUEuoro7vADmaPy0ctVU/6juHiWDe559Ju8L33O3w=;
        b=c0996tba1uBLb2uOkYSNKritvSTe4uCArCuyafC6mKmW43WVbEXu7fVJ7Mq9E+qa/R
         HQdVrYao0vp3KWB3xCqdRUyASqssrS/pGBBu8NxQ+xghxCuvDBFzI/fiz+fPQV5/P2MI
         3mmtu6c+7AJ9Mj8Rs+nrtVCVo/8o68QOW74uSqbuffWI/i/QFCvirGYFnHmgj05g6yjY
         Mk2J0mpP9+m0Xhnd5q9nDaIsQyHKLBeUlYKvq6hkIu0FsXc0XFDOdJyn23HWgZolWlPT
         wwpurQi8TQH5GfyFp3PQhrAH4jiU8VWwBYkIvb7Vr/St2KUUkqaX4gZfENKKWnjZWTWL
         azJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DnZUEuoro7vADmaPy0ctVU/6juHiWDe559Ju8L33O3w=;
        b=nLZFXxIaQj04E06PxlZV5E1XDhsofV3sMhqgUr+C0t5pIRlVUoypGi8AdtLtiNJEco
         Vsm3dK3UBbGywN2NX9JR62wZNqE9jGzuzCJehJdIQY/IlJaVVyiNUcIyVUvrvQfXaYJl
         6YiN8kYy0qC/kmtlOvtDeiC0wG6DGl38j8mL1HJrX9eiueJgd6eU8fCslvd/KLmDDJI3
         b6L5Sp8uk4AyE29LggnSGhHvoCZI7vkAreuqtZ/iFf67sFtrZrnX5glZoWfOI0Nxo5RI
         4UA9TUs4mVdl3YbDY0in+iYwCEbZ3SiiphcQ20IGvgbMpKmR5FKcm4J7ArtASpFshrUh
         lJ2w==
X-Gm-Message-State: AOAM530lZJeO3oiO+w4EVnJrZJ34PofSlHRbLyaEORrXRLysZ+a5mkKH
        dx1M5lIpuA69iZfr6KnPjkn4Fg==
X-Google-Smtp-Source: ABdhPJw5cq4PFCQoQ7M8kRFGpY0I8hMjldG1jZAYNRa1AfHZ9GnZekWC6gAMrm52Fvlq7s/fMVdLwQ==
X-Received: by 2002:a17:902:f78d:b0:14d:522e:deb3 with SMTP id q13-20020a170902f78d00b0014d522edeb3mr15476981pln.173.1652664091969;
        Sun, 15 May 2022 18:21:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([46.249.98.195])
        by smtp.gmail.com with ESMTPSA id n23-20020a63ee57000000b003db8f00aba0sm5555882pgk.0.2022.05.15.18.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 18:21:31 -0700 (PDT)
Date:   Mon, 16 May 2022 09:21:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "zengshun . wu" <zengshun.wu@outlook.com>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tor Jeremiassen <tor@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v5 2/2] perf scripts python: Support Arm CoreSight trace
 data disassembly
Message-ID: <20220516012121.GA56920@leoy-ThinkPad-X240s>
References: <20220515071838.3077178-1-leo.yan@linaro.org>
 <20220515071838.3077178-3-leo.yan@linaro.org>
 <CAP-5=fWx1ODacj2H--uH53j-jvcrTUJF2KwAyD65uU34kHYQfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWx1ODacj2H--uH53j-jvcrTUJF2KwAyD65uU34kHYQfg@mail.gmail.com>
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 02:18:53PM -0700, Ian Rogers wrote:

[...]

> This looks good to me and will run on python 2. The code would be more
> idiomatic in python3 using f-strings. I'd rather the code was
> idiomatic from the beginning, but others may disagree and prefer
> python 2 compatibility (python 2 is now end of life). f-strings are
> python 3.6+ and so have been supported for 5 years.

Using f-string is the right thing for me, will update.

Thanks for reviewing and suggestion!

Leo
