Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F256B4EC5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346421AbiC3NwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346430AbiC3NwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:52:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4148010BBF4;
        Wed, 30 Mar 2022 06:50:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lr4so33225506ejb.11;
        Wed, 30 Mar 2022 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DOMbg6u/qsHzVPLO4CX/iXdj5nd/37ZO9EctcnuGwKw=;
        b=mgUtXIWGGCaJy+j7qeKmMJvhlKiYfD7tkdrZafb1qe35U/pS4S3unocriKPhGS4+hT
         3/3fowb713GwLMB8qjnLhtwV+oxagEuEVzWXWTeSm3JhgrXIfYJKKpJLES1O/kImmRYc
         D+yzgJzo3tWe7Alx4rBwseOsu9JiC+7gt8VKckavLRQ5JZFNT4QpvkVjjML0F6pWDEsk
         XG2q2YU25fJyCfooYcguyXW+mBkBghaMA10jE+TPazO7vz4cfuusJ4lBdl3bdvO8LME9
         pnYAgSdQO0Q+RTuHNggACqMoHvW5seB3Q47QHpVFoZyzApHvDvPFeFeIDB85FTNyHqgu
         S7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DOMbg6u/qsHzVPLO4CX/iXdj5nd/37ZO9EctcnuGwKw=;
        b=CraLNW4tZhPNMlvC4q1Dk+evNvS+00y74RBH+gJbhAv4gPJcRhPKu0m7r2pHud7wNx
         9dz691tECxxwJ1OsTen9LVxzv3PlBsw57s+n2nKtEyJ60M012C69EmGbIeRDBxXHnaUm
         1isK65oqSNAAbh9vW6dRYfuLBZPXumndNi3e/0UAJ31maQFNnR9n7L+vnBF8TYoenEJc
         A7eeny68XjIkOaooOO/szX2oGaBDUjKOv85Z7ll6sSc9Oi+Bq1rFtEgTBchepHiVVjbl
         FaINjTnV7PhaoO9nrAe/Nkdl5qp7AAR291orrjBs/DLTrSple/8DPLW+YMlp0B+OK1/c
         kSGA==
X-Gm-Message-State: AOAM532/Zl0sosRixmo7Lw5Vpkc4XeDzoscjMVkPdy+yzC33AaPCrYXV
        mhTfjH0jHPXpZfV2C6SLGrs=
X-Google-Smtp-Source: ABdhPJwuseZJHcoeiDnRdo76QsCzWvCHpPAXbyt18czmeftZ5/dW2ljdcJj3NwOKE6eiFnrEI0uCzw==
X-Received: by 2002:a17:906:27d1:b0:6df:ccdd:1a8d with SMTP id k17-20020a17090627d100b006dfccdd1a8dmr41388826ejc.751.1648648224453;
        Wed, 30 Mar 2022 06:50:24 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090600d600b006dfbc46efabsm8258773eji.126.2022.03.30.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:50:24 -0700 (PDT)
Date:   Wed, 30 Mar 2022 15:50:22 +0200
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/7] libperf: Add perf_evsel__{refresh, period}()
 functions
Message-ID: <YkRgHmEc2GDtXfZp@krava>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <20220325043829.224045-4-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325043829.224045-4-nakamura.shun@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 01:38:25PM +0900, Shunsuke Nakamura wrote:

SNIP

> +int perf_evsel__refresh_cpu(struct perf_evsel *evsel, int refresh, int cpu_map_idx)
> +{
> +	return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_REFRESH, refresh, cpu_map_idx);
> +}
> +
> +int perf_evsel__refresh(struct perf_evsel *evsel, int refresh)
> +{
> +	int i;
> +	int err = 0;
> +
> +	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> +		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_REFRESH, refresh, i);
> +	return err;
> +}
> +
> +int perf_evsel__period_cpu(struct perf_evsel *evsel, __u64 period, int cpu_map_idx)
> +{
> +	struct perf_event_attr *attr;
> +	int err = 0;
> +
> +	attr = perf_evsel__attr(evsel);
> +	if (!attr)
> +		return -EINVAL;
> +
> +	err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_PERIOD,
> +				    (unsigned long)&period, cpu_map_idx);
> +	if (err)
> +		return err;
> +
> +	attr->sample_period = period;

what's the point in updating attr? this will be used after
event is created right?

> +
> +	return err;
> +}
> +
> +int perf_evsel__period(struct perf_evsel *evsel, __u64 period)
> +{
> +	struct perf_event_attr *attr;
> +	int i;
> +	int err = 0;
> +
> +	attr = perf_evsel__attr(evsel);
> +	if (!attr)
> +		return -EINVAL;
> +
> +	for (i = 0; i < xyarray__max_x(evsel->fd); i++) {
> +		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_PERIOD,
> +					    (unsigned long)&period, i);
> +		if (err)
> +			return err;
> +	}
> +
> +	attr->sample_period = period;

same as above

thanks,
jirka

> +
>  	return err;
>  }
>  

SNIP
