Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6489D5698A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 05:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiGGDOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 23:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiGGDOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 23:14:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384A3057A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 20:13:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b9so691664pfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 20:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FQhuv4p8GauGmBVlgFf1kFkX9TY2qVKxcRjGpSIYSz4=;
        b=irQFsrojtSsStyUhfXCi4mWWL4q6IPfix7TMvl1irtrA1pJeZfKoACzwL49rGnPNMl
         dUciv5tRK60KQdpQGN2QepuOWqDg7cvFey4tth/lWgKBND2cbZZ7S1UryCYuJzPDgLgS
         OoCuGcMyY5D1gJdMUAAltiAkqyll4XRR4LC1DH6gxotJYcrZBz4cdK2nH6a0tOd72IYR
         rhlKM4ZZvk2E6Uc3eT1JdoPKsBiFMunJFuV6ik+rbBZhmKx6Ml3lDQZgCc22rP2XS8QE
         Wpfq6QhKhi5y+ASGoSwWbZNaNSr1uoZTyYjruZLgwi81VjDjOyX4LloCFZcVuZHR2aXW
         Pd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FQhuv4p8GauGmBVlgFf1kFkX9TY2qVKxcRjGpSIYSz4=;
        b=5sCHFq3PxyKiOgeNJhcadSayoJx2ilWBUIrbjCMjJdnsQBRcBKurlunDOCrJtIm7dZ
         d56XBt23UlEBlJd0hXoKtmFfufPOzFoLbToCOdpIHIkyeUj0WhcKrFQjVe2OxnvMQVjW
         Im+gNZ7HqZIMsWUJVV1CTaTi4bRmf050LwlhZV1Q3lDA+QApZjZuKD89GwuopTtdu8DU
         nz+2w+Wl0LLGsxa55eSfwV+IPOhFL5ztPfpPsoodYPqUR3l5+K0Nwz74oKwz80twDjhO
         Pa4Qt6dbAMRN2a6XjYF9dA0WkZPHYjfgZ4dCB2+lRDxyig+IMNEV5tPoLjSSCTmA1plX
         tjlw==
X-Gm-Message-State: AJIora/P/G/8mCwekarQRr0ApO1H7VoLXoVO5kO2hGIEEjR+WL7+clCE
        AmOJIRUKN3OxZIWCD7Wd1VVrmg==
X-Google-Smtp-Source: AGRyM1s51eKTtJLYt46YMy0FM41IBP/1FzSuK5sgLZHnQ2CcALy2sFaVvmlTL3jlp61cz2TSV2bJzA==
X-Received: by 2002:a17:903:2441:b0:16c:9d1:192 with SMTP id l1-20020a170903244100b0016c09d10192mr3916934pls.67.1657163638648;
        Wed, 06 Jul 2022 20:13:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077154.netvigator.com. [58.152.77.154])
        by smtp.gmail.com with ESMTPSA id n2-20020a056a0007c200b0051c758a3957sm26195126pfu.149.2022.07.06.20.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 20:13:58 -0700 (PDT)
Date:   Thu, 7 Jul 2022 11:13:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        German Gomez <german.gomez@arm.com>
Subject: Re: [PATCH v3] perf test: Add ARM SPE system wide test
Message-ID: <20220707031352.GB631004@leoy-ThinkPad-X240s>
References: <20220701230932.1000495-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701230932.1000495-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 04:09:32PM -0700, Namhyung Kim wrote:
> In the past it had a problem not setting the pid/tid on the sample
> correctly when system-wide mode is used.  Although it's fixed now it'd
> be nice if we have a test case for it.
> 
> Cc: German Gomez <german.gomez@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Tested for both root user and non-privileged user, both works as
expected:

Tested-by: Leo Yan <leo.yan@linaro.org>
