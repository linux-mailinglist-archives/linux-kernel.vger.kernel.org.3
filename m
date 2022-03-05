Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426814CE700
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiCEUe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiCEUex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:34:53 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B5440907;
        Sat,  5 Mar 2022 12:34:03 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qa43so24137189ejc.12;
        Sat, 05 Mar 2022 12:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iRvcicpW31ssW5r9oly5gB1Jn0H2VSHG/yswIIm2KLw=;
        b=h2rzaYMMIY7+yZdtdthApaiXz6OdTxwE+WEDECbyCLOuSWmH2gJ8E12+d1JOa/sBKo
         ufP4czZrQ+F6y8vHt62WzSuzUEO15kaxrkSrm51XShP9h+BPfampfTalCvX1ENAQy2/G
         nJg0WLGOJjz3NsVAHLUbl3KMMYj/J0xgvC17g11se9AoUSG/FYzAb1YfUwvWM66qMKER
         2UmuOafs9O9vugYMjdb/XZLFsqCUwt3xAWIH6BSuYXdU0PlIV+aLmZQx786Sn4PskwS+
         TNhmzEZYS8t41OuGUvYYohFgeUG8XKsU+GF1hptOVkXhtuiA1S+QRdmaREjHp/mbhGk0
         PLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iRvcicpW31ssW5r9oly5gB1Jn0H2VSHG/yswIIm2KLw=;
        b=oWmgfJpGOM/tTVHryAv4tw8pbY2ZVr9mnlnQo+4engnN2dHApz4kYQCsX0/wqH2nfo
         slAu4ZrDv2QZkfMGKiGMI1+HGfKnSr+FQ7qezWinswalKXkmS18R8P2wLH4OXxTjmQIT
         RQZcoSBtab0a/E0iAVTXP/PDajfMOEQbV1K7tMu4PaBsr1TwInuhWiDB0lPwADUJU2nY
         HbSnQYHH7Qr+QumVBPc/tQDy36FpELJ+LY6GmkyK+kNURnbEbn+wAeJ98iMLdmbGMNLx
         uzSUlZQQjCuMhIe7ZO1nbWhaN7ouL4XneJo/ooWEjHNQUGhUjSfFDV0oxyBjUC3nqBrC
         vLTg==
X-Gm-Message-State: AOAM533l9JUuekxw7mVFl/zELeUW2agYSh4T9jK6qS3JPyZ5vdia/ZIt
        Luix//N07iYGZbZa5Yimh6Y=
X-Google-Smtp-Source: ABdhPJyTyFVGBTcggCU/yk5GZy/0XgJt5rgJaIyhBU8TB913TGeFCouLatTcv8EMpzu3wbpyubGBeQ==
X-Received: by 2002:a17:907:3f24:b0:6da:68fa:b2cc with SMTP id hq36-20020a1709073f2400b006da68fab2ccmr3773242ejc.734.1646512441918;
        Sat, 05 Mar 2022 12:34:01 -0800 (PST)
Received: from krava (94.113.247.30.static.b2b.upcbusiness.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709066d4900b006da888c3ef0sm3181402ejt.108.2022.03.05.12.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 12:34:01 -0800 (PST)
Date:   Sat, 5 Mar 2022 21:33:59 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        coresight@lists.linaro.org, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] perf: Set build-id using build-id header on new
 mmap records
Message-ID: <YiPJN1yaFKILinpE@krava>
References: <20220304090956.2048712-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304090956.2048712-1-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 09:09:55AM +0000, James Clark wrote:
> Changes since v1:
>  * Add read lock around dso find
>  * Bracket style fix
> 
> Hi,
> 
> We are seeing an issue with doing Coresight decode off target where
> initially the correct dso from ~/.debug is used, but after a new thread
> in the perf.data file is passed with its mmap record, the local version
> of the dso is picked up instead. This happens if the binary exists in the
> same path on both devices, for example /bin/ls.
> 
> Initially when parsing the build-ids in the header, the dso for /bin/ls
> will be created, and the file will correctly point to
> ~/.debug/bin/ls/2f15ad836be3339dec0e2e6a3c637e08e48aacbd/elf, but for any
> new threads or mmaps that are also for /bin/ls, they will not have a
> build-id set so they point to /bin/ls on the local machine rather than the
> debug folder.
> 
> To fix this I made it possible to look up which existing dsos have
> build id's set that originate from the header and then copy that build-id
> onto the new dso if the name matches. Another way to do it would
> be to stop comparing the mmap id so it matches on filename only, but I
> think we do want to differentiate between different mmaps, even if they
> have the same name, which is how it works in this version.
> 
> Applies to perf/core 56dce8681
> 
> James Clark (1):
>   perf: Set build-id using build-id header on new mmap records

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  tools/perf/util/dso.h    |  1 +
>  tools/perf/util/header.c |  1 +
>  tools/perf/util/map.c    | 20 +++++++++++++++++---
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> -- 
> 2.28.0
> 
