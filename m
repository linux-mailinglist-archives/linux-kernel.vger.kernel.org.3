Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE534FAE46
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 16:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243230AbiDJOhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 10:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243298AbiDJOhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 10:37:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81F041614
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 07:35:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z12so2730023edl.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eTOdXk23m0jnDdzRGCxaR/MFXhCBLn0KmXc705LQ8io=;
        b=tYI1JyIFHFrHxxOvc576qb1b2qrpxDEj7uajtZkxxxbP//OHX6b8tpkcaMrxgncmua
         Kl4X8exdveN7R3HkpJv7yWBfznp5G1V1YjzMy3FRUhqIBy5Rfah0kpAsu/26CiEPsYXG
         RwQ17Lea3XNoY1sF5CzJ7nhPYQ22woI5g+hwX7D/z3n2nnaFj/gbke5Ean/2WUnfgetC
         /21FdUUv93ZkooS8jezWHqW8/FBwsjG9p6mNj5bY111Fz0ISzX0p0aC65O3jBSLTPONH
         vAPtKdTiWV3VtA/evfGNjcv4/c0R0D923QvZQhj5gdqYrn9eBVHTmlinhrM1w3B6Wzbk
         4fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eTOdXk23m0jnDdzRGCxaR/MFXhCBLn0KmXc705LQ8io=;
        b=rEh6nsgv/RehVaebIMhLPFvO7WXeHcPrvOOw2942PHHoozXX19EUKSsCLZCcYOa4PH
         5e8bU5NuvHov8KxAoWeLiFiWVQc6HPl5lj5CSLHSurHLe+aqqqvGbQOqb9PfuUDobjmE
         exl3AcS/xaQE8QRmN1kNi8VvemMxNrZlWObZ/nS9lZEGtU1W6NI23Gslv9duI5L4qBE2
         3upv+6kDq/zRvSbHYuEKHms99ysW0nOPPJc3q2Dl8RGh4KpAWo42PB5v5F4ZtuT3y0Ux
         E0IDz7Dgt2U07Nodq0G0i8Av6ozEb+oY/KhVtFx5CfmzwssaXYF29mZEztGXWpkqsNpg
         sLEg==
X-Gm-Message-State: AOAM530g/Er4dvKuyeBPrJl0e4FtAUsXARK9pfS6fS2tDqBcVA0Ne6kZ
        oJvnJqoSLChXrsH7H1KdhtseLw==
X-Google-Smtp-Source: ABdhPJxreNnaYua1edc9AwH1IrWzc7BaRzLjxEf+3cBwCy80r76YN6goNZuhnEDAWvwRKvMoMZHppw==
X-Received: by 2002:a05:6402:158e:b0:41d:176:7594 with SMTP id c14-20020a056402158e00b0041d01767594mr18638652edv.214.1649601325090;
        Sun, 10 Apr 2022 07:35:25 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id c13-20020a17090654cd00b006e0db351d01sm10912522ejp.124.2022.04.10.07.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 07:35:24 -0700 (PDT)
Date:   Sun, 10 Apr 2022 22:35:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        leo.yan@linaro.com, German Gomez <German.Gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: arm-spe: Fix perf report --mem-mode
Message-ID: <20220410143517.GA226043@leoy-ThinkPad-X240s>
References: <20220408144056.1955535-1-james.clark@arm.com>
 <CAM9d7cji=xSAy673sXGf2GXFsKKsR7=pNKJceLtHX1sFFUZcKg@mail.gmail.com>
 <20220409095941.GA1000846@leoy-ThinkPad-X240s>
 <YlGiZRZlrBCmO+YG@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlGiZRZlrBCmO+YG@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 12:12:37PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Apr 09, 2022 at 05:59:41PM +0800, Leo Yan escreveu:
> > On Fri, Apr 08, 2022 at 11:13:09AM -0700, Namhyung Kim wrote:
> > > Hello,
> > > 
> > > On Fri, Apr 8, 2022 at 7:41 AM James Clark <james.clark@arm.com> wrote:
> > > >
> > > > Since commit bb30acae4c4d ("perf report: Bail out --mem-mode if mem info
> > > > is not available") "perf mem report" and "perf report --mem-mode" don't
> > > > allow opening the file unless one of the events has PERF_SAMPLE_DATA_SRC
> > > > set.
> > > >
> > > > SPE doesn't have this set even though synthetic memory data is generated
> > > > after it is decoded. Fix this issue by setting DATA_SRC on SPE events.
> > > > This has no effect on the data collected because the SPE driver doesn't
> > > > do anything with that flag and doesn't generate samples.
> > > >
> > > > Fixes: bb30acae4c4d ("perf report: Bail out --mem-mode if mem info is not available")
> > > > Signed-off-by: James Clark <james.clark@arm.com>
> > > 
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Tested-by: Leo Yan <leo.yan@linaro.org>
> > 
> > It's a bit awkward that after the commit bb30acae4c4d we cannot be
> > backward compatible and any old perf data file will be failed to
> > support by 'perf mem report' tool.
> 
> oh well, I think we should put in place a mechanism to run perf record
> before some change, then make sure that a new perf is able to process
> it after a rebuild.
> 
> If its something unsurmountable, then a proper explanation should be
> done with a workaround to process those older files, even if pointing
> out  to the perf version that is able to process the old file.

I will follow up to add a sub test case for Arm SPE with 'perf mem'.

I tried to find possible workround for old perf data files but failed,
the 'perf mem' tool reports error in a very early time so I cannot add
workaround in Arm SPE specific code (e.g. arm_spe_process_auxtrace_info()).
I will check furthermore, as a backup will send a patch to remind
suitable perf version.

A backlog task for me is to setup an automatic testing envoirnment
for daily testing perf on Arm64.  I will setup an automatic testing
for this.

> Anyway, applying this pa tch.

Thanks!

Leo
