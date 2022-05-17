Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A07D529FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbiEQLDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiEQLDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:03:33 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE201A39F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:03:31 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c14so16579840pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PjHTBfrAvfYwUJ31KQJIFgiibplD85RYkwP/rJccONE=;
        b=HdRX54HJiXnCxR1xsL8soi2Ob1QbMm+BEwNXSWrF/bBRQLDYy+tBIkEDTwQfrgn2+K
         sfApkdKQvdUqQC+89PadTZ3z8ExzT3fFQiGrCE4qZTc3tUIYk6LeNUuNoXPcAPaBEMr7
         8eeu0ZIIlwnwwg709xOh6EdcEqrmaIrNtcfiVZrOf1JLK3oH8j50ipb26Gd4UNgMWwCP
         MqnqHFA+9PNNbWqfLdpGBodbuW3oxe2obNj94sAtZFeCqCnqfkUByUBtZe7jOBQ0TDjF
         sfVGlfBiZA0V+DKOBaYiA+feepDzDGhRwVPYpQCeda1XY+fdSl96+YBhV6FmHXvoVH+8
         oRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PjHTBfrAvfYwUJ31KQJIFgiibplD85RYkwP/rJccONE=;
        b=RJaBTUOTdit705HsIVzQpUoDyNTxa0IIXqZDCEmgdJ3ByCGr5zjiMplnoRoEasFB1g
         jiErac7R+RR4CKLJLnFV1NNpJJrwLOzC3IRwgLcs9l4hHBRkDxzq8zmWEOt7X4IDtg6W
         M5vZqaCmXBU6xXENR3pDPfdNlpew06io8Y4BZDeMgo9KTdlGgcTaG3mwnhHgv3Gi/V8q
         sk22oZzbgWP25n1QiUypgYDWa5KOOuh656cdUMSPmcW1MkHkjRwB+exR7r9DxL946Qtf
         AYSgayUTEbyQnsLK4+K/mROsdVXe/ddKdl6QXGnymzWHLJjanHoatEO4STKpcSPAlTBj
         0rzA==
X-Gm-Message-State: AOAM5335nF3b08PH3rMiLxlra/MrO8VaOHLLJs/aPfnsVjpUBkuLiu41
        1GTJKXdSOyj4OMjfwoi/G8/p3I0e5fMyCKj5200=
X-Google-Smtp-Source: ABdhPJzTOF6Tfl/amP70At7Vqtv/u46P4Fmt0pgzrECol0LhB40mtHBWn9tL4P2c6H6fAq5clNwhIQ==
X-Received: by 2002:a65:6e88:0:b0:382:3851:50c8 with SMTP id bm8-20020a656e88000000b00382385150c8mr19442523pgb.270.1652785411251;
        Tue, 17 May 2022 04:03:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([46.249.98.195])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79155000000b0050dc76281e3sm8473071pfi.189.2022.05.17.04.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 04:03:30 -0700 (PDT)
Date:   Tue, 17 May 2022 19:03:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org, german.gomez@arm.com,
        mathieu.poirier@linaro.org, john.garry@huawei.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] perf tools: Use dynamic register set for Dwarf
 unwind
Message-ID: <20220517110322.GC153558@leoy-ThinkPad-X240s>
References: <20220517102005.3022017-1-james.clark@arm.com>
 <20220517102005.3022017-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517102005.3022017-3-james.clark@arm.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:20:03AM +0100, James Clark wrote:
> Architectures can detect availability of extra registers at
> runtime so use this more complete set for unwinding. This
> will include the VG register on arm64 in a later commit.
> 
> If the function isn't implemented then PERF_REGS_MASK is
> returned and there is no change.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

This patch looks good to me:
Reviewed-by: Leo Yan <leo.yan@linaro.org>

Just curious, do you think should update the test (e.g.
arch/arm64/tests/dwarf-unwind.c) to use arch__user_reg_mask()?

Thanks,
Leo

> ---
>  tools/perf/util/evsel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5fd7924f8eb3..787bbcbcd2ae 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -896,7 +896,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
>  					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
>  					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
>  			} else {
> -				attr->sample_regs_user |= PERF_REGS_MASK;
> +				attr->sample_regs_user |= arch__user_reg_mask();
>  			}
>  			attr->sample_stack_user = param->dump_size;
>  			attr->exclude_callchain_user = 1;
> -- 
> 2.28.0
> 
