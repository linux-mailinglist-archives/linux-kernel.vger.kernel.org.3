Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0A5586864
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiHALqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiHALqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:46:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D56357CF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:46:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id rq15so13799970ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WBE7JiuZZ2jU9paVTeguzhA90wR1T04XPqUxNbs3ffc=;
        b=eYZqdT8l68Fwz64K4ZVZoUG/4DrNnQBSOtsniZYWu2BDmnvmyOXUjLMafRsLVqcSxq
         kEPGApKNCqqWpe7iw3twrQpmGvdnmKNSsScdKdO6obRbWpOX4iZoUorBrzakUtjMZH0a
         f+gUZKyAjBp7eicGlL4+d3fLfKFXkT6CJLxSJqk7kZKGApANplFW4EdlvAU7wY7255MO
         BCh4Nre9li7f6E5hhWDHjN8in3N/UKki744YAzmh9B0nT3FBJ2y/qGgFTD8YbB/RjqQH
         wleZ5h2KTbS2hcNhbqkaz36wx0IJPO9T0UzlSpyQyPlpnEZmizfRQXS/GQw0m9p9n1Aw
         lflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WBE7JiuZZ2jU9paVTeguzhA90wR1T04XPqUxNbs3ffc=;
        b=iNM/QPPeL3OL5QZn0STkOujEtZdMVz6x6sNfQfe0F0afUnfCf+WVHDNKopFyy9ZoZi
         OT4IrCFp1OiuxiLmr23KeGXWSDojQB+PDht5dOCK73dO5zVpVxiaf4S85UqncQYny7iu
         q/dM/jzE31HN3SKPV6yJ5j6bTN0FYNd9lPY6KXrQkZ2edjcAGrGms/GeoX/xD12Deem3
         sGJ5QwAmQbAUqMaZucL8GnNjfMfPkppckjwHMHYOFWmH0xbLhNwTvUfLux+pIu2K66MP
         tF2WXCyqZjuYbbNa5P4V3vitdOE7n9WRbbcMtBWjiB0dRxKqSdMlIonpGQU1AgsE+zsz
         P+8Q==
X-Gm-Message-State: AJIora+sqGcUHCULVwswvuyWdyBsXFTmIgWdHqmB/KJlXmPf2kIAj0J/
        pFNzt9hmR7hxuuvwfigumzBPpA==
X-Google-Smtp-Source: AGRyM1sE5hfkOOXQpHXoqKcX6x/Y4vdeFJD7RCZnlSrNZ0DGHQxXuLmXNQhU4Zbzmck5c7APkubPkw==
X-Received: by 2002:a17:907:1c11:b0:72f:20:e1ea with SMTP id nc17-20020a1709071c1100b0072f0020e1eamr12032887ejc.427.1659354363610;
        Mon, 01 Aug 2022 04:46:03 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.98.208])
        by smtp.gmail.com with ESMTPSA id wc7-20020a170907124700b0072b55713daesm1340370ejb.56.2022.08.01.04.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 04:46:02 -0700 (PDT)
Date:   Mon, 1 Aug 2022 19:45:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Adri=E1n?= Herrera Arcila <adrian.herrera@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, songliubraving@fb.com,
        james.clark@arm.com
Subject: Re: [PATCH 2/2] perf stat: fix unexpected delay behaviour
Message-ID: <20220801114558.GB73228@leoy-ThinkPad-X240s>
References: <20220729161244.10522-1-adrian.herrera@arm.com>
 <20220729161244.10522-2-adrian.herrera@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220729161244.10522-2-adrian.herrera@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 04:12:44PM +0000, Adrián Herrera Arcila wrote:
> The described --delay behaviour is to delay the enablement of events, but
> not the execution of the command, if one is passed, which is incorrectly
> the current behaviour.
> 
> This patch decouples the enablement from the delay, and enables events
> before or after launching the workload dependent on the options passed
> by the user. This code structure is inspired by that in perf-record, and
> tries to be consistent with it.
> 
> Link: https://lore.kernel.org/linux-perf-users/7BFD066E-B0A8-49D4-B635-379328F0CF4C@fb.com
> Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> Signed-off-by: Adrián Herrera Arcila <adrian.herrera@arm.com>

bpf_counter() is not enabled for delay in this patch, but I think this
is purposed to keep the same behaviour with before.  I would leave it
to Song for a call.

The patch LGTM and I tested with commands:

$ time ./perf stat --delay 2000 --quiet sleep 2
Events disabled
Events enabled

real	0m2.039s
user	0m0.007s
sys	0m0.016s

$ ./perf stat --delay 2000 --quiet echo "marking"
Events disabled
marking
Events enabled

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

P.s. I took a bit time to get clear how 'perf stat' set enable_on_exec
flag, which is set in the function create_perf_stat_counter(), so this
can enable PMU event for the case when delay is zero, and this can
avoid losing PMU tracing for workload.
