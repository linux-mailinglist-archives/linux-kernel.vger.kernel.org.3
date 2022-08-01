Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7500A58681A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiHAL1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiHAL1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:27:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E4A654C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:27:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m8so13286942edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 04:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dat9EDJ040kndZ5sQxnXUzu3M1MzMzRUr44UWyA8lX8=;
        b=cv9HYwCdIDZqoezKrlQReS9ds2IdjVRJsQDacwHmGJgt8BqryJt6NFU5QPx+2y0k2I
         u3aYQV4ynH359nR07D5C/tHcVp9yhlzd7Khe6WD1z1/EntaVMP/IC5OT5kt99Il3YBZI
         Vw5IhXXS9DX7BfF1BI9h9ogX/ZQ2dCtWnFVsSZSM+Het+o9OKAqXYfizvDtbKJKSUKGS
         KzEk7EsM99f5SOpzNT3W0mmlj4EP+0TeZL4HRHe2EEb+pcMLOFTV9EnaNWKejiOrhpCe
         jsjTiXAyO8aStJwj6tef9kPpS/HUgS/HWGikeL8totedX97UFN5ly7BpVL0OJmsmL2z2
         X0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dat9EDJ040kndZ5sQxnXUzu3M1MzMzRUr44UWyA8lX8=;
        b=qStQALQlqNNcDnYjPhrvnknKp+aoz38/dFAec37CvNGNlAZdRq1sBqEnSAlT/djRue
         kX1gDW45aQm0dRUtJGcJyAkxoGXKugbbQRNU89jusohUyoigVRtmHt+WUrET/kE/OPeX
         UcP26RE08C1IXDT1p95TZwysS4fo9mZIwHWi2Wfumsb5fH1CJTXyhUZbDUeB5OiGFgTo
         gIHbERXPvPaGiQxy6U00XQIEfFR6ED0SfXij+cNEbdBXeV96tWGRxMq32ieIT43G6CuD
         qt5fDj8JvCYf2m9k18b3AXw0UoiU6PuUEOvtEAW+yk1XhzwMn2d6ZDV4KSH5j/asL8op
         AFow==
X-Gm-Message-State: AJIora81yJGNTKJ4FphtyIhU7l5sIAiaWo+M6yBeZV+2J1FDZOnZ1DHa
        3BAjnPJyabsM/Zyldhj9D8lOCw==
X-Google-Smtp-Source: AGRyM1vg0Oq8o4qygVWEYpvOuucQ6QroIxWwBd6jz5TMXL3lbGD6M5oPEcui+hva6pDc8rebAeinuQ==
X-Received: by 2002:a05:6402:5cb:b0:434:eb48:754f with SMTP id n11-20020a05640205cb00b00434eb48754fmr15986528edx.421.1659353253624;
        Mon, 01 Aug 2022 04:27:33 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.98.208])
        by smtp.gmail.com with ESMTPSA id v14-20020a170906380e00b007262b9f7120sm5029347ejc.167.2022.08.01.04.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 04:27:33 -0700 (PDT)
Date:   Mon, 1 Aug 2022 19:27:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Adri=E1n?= Herrera Arcila <adrian.herrera@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, songliubraving@fb.com,
        james.clark@arm.com
Subject: Re: [PATCH 1/2] perf stat: refactor __run_perf_stat common code
Message-ID: <20220801112726.GA73228@leoy-ThinkPad-X240s>
References: <20220729161244.10522-1-adrian.herrera@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220729161244.10522-1-adrian.herrera@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 04:12:43PM +0000, Adrián Herrera Arcila wrote:
> This extracts common code from the branches of the forks if-then-else.
> enable_counters(), which was at the beginning of both branches of the
> conditional, is now unconditional; evlist__start_workload is extracted
> to a different if, which enables making the common clocking code
> unconditional.
> 
> Signed-off-by: Adrián Herrera Arcila <adrian.herrera@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
