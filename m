Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28EE4FF31D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiDMJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiDMJP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:15:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D025205EF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:13:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b15so1581425edn.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A6HjxEs9rpj/RCezhjuC+/JyeFmy0zQ3DUyU3NxIzRk=;
        b=YBZIIcr+RyzRPqywHaCL+NsxvKXHOMq3vhIP31VtwaR075dDIzYs3Qxk5xJMgaj/6Z
         Dp2/mxKYeEgQFgueu7NW3TQPPfE8KFqrpMI3DNybOTlPIuZlqBSouKOw9e4Hax5h7t3N
         Os8CgIrVI7khM8+q3xhMAR6CVgUr7heK+QzIFGri3G/UyvSZlAwBBxUI4gehw8jzX4MT
         SFS6ruQ1vKqZkcNE8I+keDuZUjeAHTe265JkO9GjrcRgHnHl56pU2TLISjnQke8qLp7f
         e/ppnNcXB8W0o/x4t+R+Ei2k5XNpIhbYneQRyG+fyMFGUaYsumniVcbxXIdc0QtXSN41
         JKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A6HjxEs9rpj/RCezhjuC+/JyeFmy0zQ3DUyU3NxIzRk=;
        b=hTPQzmphGem27KGSzvnodsa9X1mnp0z8/CBtsa5FkyckuRfKOn92v5LMLWwAVXyZwZ
         ypGvhAIBa/AusHrgRpR8S2klPPN/rlhC2tPpa5+kgTEdrLvWsKHjdq3K/RxlntodbPmV
         DwdA6293M34Lq96x6hM6F4kS78DkdNw0b/HgErVUAFsj8RWm5jMqpvkN1Jit8KdZ06kQ
         Kubqp+raYsPmcY83mb3J5ZZvoIk9cU2rFD4cW/DPDQMSScXSRMm8iG5q2o6qTdtTYigp
         /xYgvw9JzZo8wQYhPXc+iq6oBlIfC49zzyoe4Z79Qs5R25gweInqO2jJ/v8auxX8VYyI
         eX9Q==
X-Gm-Message-State: AOAM5335/0VlqHFI4C9bP8CFHod0HLWYSuIVe9lCg6zT7U2mcFVL3JqL
        cFgmQt2nINSi85i0mPnD4ZPnyw==
X-Google-Smtp-Source: ABdhPJywFNs8Pk/V9Pd4WdH1qY02jHRTKwXrYl7/fffog1DLPnFCScj6xyXnI1fkJNoBupCMRkKwQw==
X-Received: by 2002:a05:6402:28b6:b0:41d:8c2e:c97e with SMTP id eg54-20020a05640228b600b0041d8c2ec97emr9222466edb.45.1649841214041;
        Wed, 13 Apr 2022 02:13:34 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id k7-20020a17090666c700b006e8688d5fcbsm5290477ejp.135.2022.04.13.02.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:13:33 -0700 (PDT)
Date:   Wed, 13 Apr 2022 17:13:27 +0800
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
Message-ID: <20220413091327.GC521036@leoy-ThinkPad-X240s>
References: <20220413075124.635589-1-leo.yan@linaro.org>
 <c21b3409-a8a0-aae7-7634-5e648f0a49b1@arm.com>
 <20220413084941.GB521036@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413084941.GB521036@leoy-ThinkPad-X240s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:49:41PM +0800, Leo Yan wrote:
> On Wed, Apr 13, 2022 at 09:15:40AM +0100, German Gomez wrote:
> 
> [...]
> 
> > >  	if (sort__mode == SORT_MODE__MEMORY) {
> > > +		/*
> > > +		 * FIXUP: prior to kernel 5.18, Arm SPE missed to set
> > > +		 * PERF_SAMPLE_DATA_SRC bit in sample type.  For backward
> > > +		 * compatibility, set the bit if it's an old perf data file.
> > > +		 */
> > > +		evlist__for_each_entry(session->evlist, evsel) {
> > > +			if (strstr(evsel->name, "arm_spe_") &&
> > 
> > This didn't work for me when the file recorded "-e arm_spe//" instead of
> > "-e arm_spe_0//". Could you remove the trailing _? With that:
> 
> Sure, will change to "arm_spe".  Just curious, if there any local
> change at your side so we have the different event name?

I think I know the reason now, though the PMU event is 'arm_spe_0',
but we could use '-e arm_spe//' to record, so finally the event name
is 'arm_spe'.

Thanks,
Leo
