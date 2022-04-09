Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4DB4FA6A2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbiDIKCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiDIKCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:02:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D72C0E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 02:59:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id p15so21670464ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N4XJfs2B+Cri2iOejBgjUkpCtU57s9kSfpppvvyrQ3Y=;
        b=nCAc3eD+ukkUEzJ+5m0uI1Yk9ZLxaGw4gCZilaLJMFu3LwVidMWBJNsv4nCr4xaFGB
         XOIkpON+cxcV0sSDyCxcFz5tweWwxjl9pdmg0McvIABk/wSL/C+uMof2TytvT2k9Oarf
         PC2DoRXaIxsNglfmCcQxingTPZYXnWhaJ/boelOQH7dFSim74h9FwvMRioIuyTwgjFUC
         XlrKg1kHS2sba/oQ3SU1Uhbe8MnpsKj2wigGrocU99fnvELvlqkvlBEQowo5iObfwgsz
         iO9bddAjlwOWkyQGR9KkUmGJ6rXwkt7WgAXs/laz4ew5+arw4DsV9MMHAej1ogrYxiBn
         5v3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N4XJfs2B+Cri2iOejBgjUkpCtU57s9kSfpppvvyrQ3Y=;
        b=kSjpueJ31Za3Nvo+hiVPvMZCmZSf8sOjfnOglYh5xaDK+kcvYC36PPZuMHZLRm9E92
         kGzpq5ITAJrNPR5GUfewlsPT20bLcta3hllwRifYdUKsfrfxnvi8v4b9Op3sGPwjiGhR
         PHMhrXKABRWxch3mUVINX5DEByQfA5yi0KGSwhgERgBgJEYWirTnBWvOf4kxeqS9vR6g
         h+i+P9+CX91JXSs/u8MOCXzbR1sjPjC9uszu14ldTXwC2eUzaDEGtzc0CoJOvpW7vSsn
         a0KEn+4tNImUaaTbBlyt4MfEvn9JMUWb7/GsL1g7EzzGMCj4Zaz3dh2n+SK7py8gu1x+
         nrlA==
X-Gm-Message-State: AOAM5320QxnfK5dunTRppfiq5rVm97D+4cqdHTCYeGFe6x0e7quB2ut4
        Op1HEplSw/zzkOQFipTaswNBNQ==
X-Google-Smtp-Source: ABdhPJzia8lT1grS0oZhObzaXk1Mxby37e8QeLtr75r2MAWa1O9h8k6Ly94DLakgv4ib364h5bhSKA==
X-Received: by 2002:a17:907:72c7:b0:6e8:442c:1722 with SMTP id du7-20020a17090772c700b006e8442c1722mr8607936ejc.120.1649498388695;
        Sat, 09 Apr 2022 02:59:48 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.34])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090681cb00b006e86b594e1fsm785527ejx.207.2022.04.09.02.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 02:59:48 -0700 (PDT)
Date:   Sat, 9 Apr 2022 17:59:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Message-ID: <20220409095941.GA1000846@leoy-ThinkPad-X240s>
References: <20220408144056.1955535-1-james.clark@arm.com>
 <CAM9d7cji=xSAy673sXGf2GXFsKKsR7=pNKJceLtHX1sFFUZcKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cji=xSAy673sXGf2GXFsKKsR7=pNKJceLtHX1sFFUZcKg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 11:13:09AM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Apr 8, 2022 at 7:41 AM James Clark <james.clark@arm.com> wrote:
> >
> > Since commit bb30acae4c4d ("perf report: Bail out --mem-mode if mem info
> > is not available") "perf mem report" and "perf report --mem-mode" don't
> > allow opening the file unless one of the events has PERF_SAMPLE_DATA_SRC
> > set.
> >
> > SPE doesn't have this set even though synthetic memory data is generated
> > after it is decoded. Fix this issue by setting DATA_SRC on SPE events.
> > This has no effect on the data collected because the SPE driver doesn't
> > do anything with that flag and doesn't generate samples.
> >
> > Fixes: bb30acae4c4d ("perf report: Bail out --mem-mode if mem info is not available")
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Tested-by: Leo Yan <leo.yan@linaro.org>

It's a bit awkward that after the commit bb30acae4c4d we cannot be
backward compatible and any old perf data file will be failed to
support by 'perf mem report' tool.

Thanks,
Leo
