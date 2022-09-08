Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70E75B2170
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiIHPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiIHPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:00:11 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1E66B65C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:00:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id b144so13410192pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=6mOtRJiMPyonv/bkW5gp+WSqwfTGGUhwL8zA7GLIfu8=;
        b=MBw0I19ZIV+EImtz/TADUZsN1wzNaUIByF+dV8m5aK05JyWyMK3B5ZH0lMheqOvBpH
         jXBQEEeEL5AEBwu0Cs2LE67tSIVtijmCZNuwhm1ZZNcZvyR59TjVq6ZuMRJFhO07aH0D
         cSu8CSkYhyKbx25YXsrGPKmifPxQ7Lr9QA6GG73XjswoQaLXOXqYLqOATe82EwIxAVq6
         RdThPwZ8c2v65T610vPdPkguHXjYNMZeAQdDRnwI3smvdM8Lfw/s4gLzo4eas5mOu6ta
         yeXcykalp8vfbVHGvJc9TJGa0vsgEhD8Hh4BSXC7BLTZ/fv5dpDJ+45yonelavKFrw58
         K8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6mOtRJiMPyonv/bkW5gp+WSqwfTGGUhwL8zA7GLIfu8=;
        b=g/kIHeU6GcVhVhDivc0GjKQNrHRn9tCVEPZBxL/BjcuZEwOc5N2K73KVbgoXWbNrjt
         dPGwyX43+S7TzpTE4PNpZE++ZNUzggWV8YiSoU1dcihzRv24DXwf6141xwmZauFrKFiA
         nkKyR85CkrIWh5UsNvWvlKxOlZ9+Ebgw33ThXpl4u69CPHa/3em6rBjTHKAOVqCFWC46
         UTKcx2waeU3PQZMBWZKIX2GOPhT7xGl9xWF9oaT1J+wUKnqbHSYCTGFT30Dwh1x3/Sm0
         qJdS4AJkVsBCNymIq4zeRm+mJaeL5CtHZJeNskuCT7j/R3TlwGTNg6YPBycWvtMsRMAP
         xzqg==
X-Gm-Message-State: ACgBeo2sA2eKrIjbVXI78gWylTHg0M4MyQ2dOk3iLhuGc++gtxDA+GCi
        YEIdFcJRDmWyiN/mCHBEBNYngw==
X-Google-Smtp-Source: AA6agR725v+e8+/Njs0timpLfPIxaymME9lYcuVqRRvk0am9g6wfKCRleYvdHse+nLSvS5YVvYwO5g==
X-Received: by 2002:a05:6a00:4146:b0:537:df7d:d5d2 with SMTP id bv6-20020a056a00414600b00537df7dd5d2mr9550317pfb.31.1662649209772;
        Thu, 08 Sep 2022 08:00:09 -0700 (PDT)
Received: from leoy-huanghe.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902f64300b0016c9e5f291bsm14622104plg.111.2022.09.08.08.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:00:09 -0700 (PDT)
Date:   Thu, 8 Sep 2022 23:00:03 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ali Saidi <alisaidi@amazon.com>, Kajol Jain <kjain@linux.ibm.com>
Subject: Re: [PATCH v7] perf: Add SNOOP_PEER flag to perf mem data struct
Message-ID: <YxoDc8k3YEbzw7KI@leoy-huanghe.lan>
References: <20220826060556.176681-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826060556.176681-1-leo.yan@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 02:05:56PM +0800, Leo Yan wrote:
> From: Ali Saidi <alisaidi@amazon.com>
> 
> Add a flag to the perf mem data struct to signal that a request caused a
> cache-to-cache transfer of a line from a peer of the requestor and
> wasn't sourced from a lower cache level.  The line being moved from one
> peer cache to another has latency and performance implications. On Arm64
> Neoverse systems the data source can indicate a cache-to-cache transfer
> but not if the line is dirty or clean, so instead of overloading HITM
> define a new flag that indicates this type of transfer.
> 
> Update notes:
> 
> This patch is to sync the headers between kernel and user space, commit
> 2e21bcf0514a ("perf tools: Sync addition of PERF_MEM_SNOOPX_PEER") for
> updating kernel header has been merged in the mainline code.
> 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Gentle ping ...

Hi Peter, could you pick this patch if it's okay for you?

Thanks,
Leo
