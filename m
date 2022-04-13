Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F854FF32B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiDMJSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbiDMJSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:18:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6EA51E66
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:16:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bh17so2614574ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hblV92aPuej0p7ID1pULy+QJqaua2alXaevi7dvbrUU=;
        b=WIKXHBwkh+EhYN8jqtAXZe/Tyt8mlkW3bASrYOTKf1/6ge/9WE1nIcoqoLkLWZkPr+
         FuERh7yZiwLbnv26+FajLXbbB75K2YiEWujiEgeWrDPIHmfIk8Ax23RC5q3WlZotvyTH
         ZpUT2qdGpTeLuIP41ve4yDKHzRrKtA2+OmLRM/YD4Ae18UQh0LFx79dI3RociC1gS1MV
         0GWLpcliTgiZZqqLFa3ItfdN0QMJhgbdBPT17kSAQJ3IPDziLjdvBNnmc/KVxUQ0y9T1
         girU0IDsD5jSag+T+B44HWzEzy4TZ6vL8lA/M2EitPrzeX1Kg+Xh/zsoXobUjvPHLE3P
         21ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hblV92aPuej0p7ID1pULy+QJqaua2alXaevi7dvbrUU=;
        b=ifWP9486xu4jSM+AEtjdWVY4heqI1YOOcI4nNeLkljIMkFEXJA3XPQ5/IBvsam+Qw/
         MNlZjEsdvJC1ujr+whH6ZBmZ4N1wfab02WdAhOIROfmDzCQ5WM/yXJeWZeO43BrRZJFe
         W/nC3IksDhINOcIZStts5appmKGoSJZv956iETJe7Cz1qehHuIzMQxwoD5HnjpiedJ3K
         nRv6Xg9uBOT2vi6Lam5UyQXDI8OlCRQHuX4i99dQUQMJQOpb0IEIZBfOwLMF8t62nCYS
         rpvFN6LY1tB/tWHCqUtJBhscoCoyeTPj7FLF8oFn0N2A5LXGxpNVE5c8+kDBeaQtrk2c
         P3pA==
X-Gm-Message-State: AOAM531c8ZQiDZiNejHVvp+wlnshjEy2FspGNBms2yAZBdoy30tZg7vK
        Sda7fhSqQZIuy5wwXxs4ocE+Gg==
X-Google-Smtp-Source: ABdhPJzxWtxkUmiepBnlWMtTjViNplCdRi9hB0wNwbQbHSHOc/I9rRLkD4QZgJDJkLGQcI1wZksGyw==
X-Received: by 2002:a17:906:7111:b0:6e8:973a:1515 with SMTP id x17-20020a170906711100b006e8973a1515mr11383665ejj.308.1649841369670;
        Wed, 13 Apr 2022 02:16:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id e12-20020a170906c00c00b006e66eff7584sm12637990ejz.102.2022.04.13.02.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:16:09 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:16:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE
 event
Message-ID: <20220413091604.GD521036@leoy-ThinkPad-X240s>
References: <20220413075124.635589-1-leo.yan@linaro.org>
 <c21b3409-a8a0-aae7-7634-5e648f0a49b1@arm.com>
 <20220413084941.GB521036@leoy-ThinkPad-X240s>
 <38078438-dbce-690b-ba79-5c3713f97816@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38078438-dbce-690b-ba79-5c3713f97816@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:14:00AM +0100, German Gomez wrote:
> 
> On 13/04/2022 09:49, Leo Yan wrote:
> > On Wed, Apr 13, 2022 at 09:15:40AM +0100, German Gomez wrote:
> >
> > [...]
> >
> >>>  	if (sort__mode == SORT_MODE__MEMORY) {
> >>> +		/*
> >>> +		 * FIXUP: prior to kernel 5.18, Arm SPE missed to set
> >>> +		 * PERF_SAMPLE_DATA_SRC bit in sample type.  For backward
> >>> +		 * compatibility, set the bit if it's an old perf data file.
> >>> +		 */
> >>> +		evlist__for_each_entry(session->evlist, evsel) {
> >>> +			if (strstr(evsel->name, "arm_spe_") &&
> >> This didn't work for me when the file recorded "-e arm_spe//" instead of
> >> "-e arm_spe_0//". Could you remove the trailing _? With that:
> > Sure, will change to "arm_spe".  Just curious, if there any local
> > change at your side so we have the different event name?
> 
> No local changes. I've always used "arm_spe//" and it always defaults to
> "arm_spe_0//". But it's still stored as the former in the data file. I
> haven't checked where this default happens though. Isn't it the same for
> you?

Yeah, this is same with me.  Thanks for explanation.

Leo
