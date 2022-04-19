Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DD5061A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239671AbiDSBYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbiDSBYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:24:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E8F286ED
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:21:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y10so12479309ejw.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zxbQ6TRPNn9gexb0jaIoX0c5WCAB0YeHHh5XcVddlu4=;
        b=kUEg6N6xcZzu6vy23WArx+eRurR58Zws4VxetIoj7RYKnV/b97rc954MFQJvofcy6z
         /v+kBQ2M2XVZHnrzej9b3KWSchdiXfLUXlRoebxpJR4Ud+JqzAMNPlZlIvloTDX9SvSs
         goD3bIlVMMK0TecPMWAG/pVf/CGPh+Red09LmHLo8InfAzqkb51v3+VMcQp1Xlyp6QJO
         E8goocgcYGWCi/0tPcoXu+fnBijeXF0P3mvWLRi/8yvo9bmrEdRhVRZdYHnqFOtSwkey
         JQk6WdllD/yOUCd+6GRXnaGxLmws+bcUp96IOdozXA/N/BvSPmB+RqJHHMsqFn2X/9Ah
         WEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zxbQ6TRPNn9gexb0jaIoX0c5WCAB0YeHHh5XcVddlu4=;
        b=ZQjf1fdxACw1SwZ1rrdoxHzuA8e41xUpaZzwMxYhrO5uqLog/4lrJEI2mX5LRppmah
         LrzFdStBGbECUd0BLpwI+Dw85DoV0mpy87LTvmWEr7BoCpsx+aap62qygbu80RSsHndk
         ieSPgCl1QZeIk5tSilb6xORw5/C5of8YK19EHCoVQosIy74hlc2ktdzvVYSmxtSudp4K
         4IglDz6toE/yr+J1b0cuOGuS+DEt4Qj7UkfeHXAx5qSBmLM6ZvwFl4yuE6DYsmrLQ7Hs
         8BShtFseNE6bY8pLOFOwVTKL0wBaUhE+Ednm8TxxQDTEQGjTotjUz5JFF7j/tq6eOfh5
         9rIA==
X-Gm-Message-State: AOAM533EhvjUurcW+aSJJUE3pgtU8FUjMFRSHrRcdEOKLFKn+TbpglyU
        iBc4WRi8rnuSUxy3ntbAy/+5JEFAT38z9oE9GtxpHw==
X-Google-Smtp-Source: ABdhPJziwyj2afz/fzBMlMpMXsEiyH76Q2F7T1jddYljRwBxHA9iyxPKtGshpN6XD5v9WsIB64K6zw==
X-Received: by 2002:a17:907:7f88:b0:6ef:e068:f5aa with SMTP id qk8-20020a1709077f8800b006efe068f5aamr390588ejc.238.1650331279998;
        Mon, 18 Apr 2022 18:21:19 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id b25-20020a056402139900b0041904036ab1sm7838317edv.5.2022.04.18.18.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 18:21:19 -0700 (PDT)
Date:   Tue, 19 Apr 2022 09:21:14 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf report: Set PERF_SAMPLE_DATA_SRC bit for Arm SPE
 event
Message-ID: <20220419012114.GF166256@leoy-ThinkPad-X240s>
References: <20220414123201.842754-1-leo.yan@linaro.org>
 <Yl3eisj26sHBjokV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl3eisj26sHBjokV@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 06:56:26PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 14, 2022 at 08:32:01PM +0800, Leo Yan escreveu:
> > Since commit bb30acae4c4d ("perf report: Bail out --mem-mode if mem info
> > is not available") "perf mem report" and "perf report --mem-mode"
> > don't report result if the PERF_SAMPLE_DATA_SRC bit is missed in sample
> > type.
> > 
> > The commit ffab48705205 ("perf: arm-spe: Fix perf report --mem-mode")
> > partially fixes the issue.  It adds PERF_SAMPLE_DATA_SRC bit for Arm SPE
> > event, this allows the perf data file generated by kernel v5.18-rc1 or
> > later version can be reported properly.
> > 
> > On the other hand, perf tool still fails to be backward compatibility
> > for a data file recorded by an older version's perf which contains Arm
> > SPE trace data.  This patch is a workaround in reporting phase, when
> > detects ARM SPE PMU event and without PERF_SAMPLE_DATA_SRC bit, it will
> > force to set the bit in the sample type and give a warning info.
> 
> Thanks, applied.

Thank you, Arnaldo!

Leo
