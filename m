Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7FD53C368
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 05:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiFCDhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 23:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiFCDhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 23:37:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A16D60E8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 20:37:06 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g184so6310158pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 20:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8NU2H/rGkzMEGnRhbeP8HcREPvdELz1mjoNpn1J8y28=;
        b=G5hjpbI7XV6h8rDNmIjZ3hqDfqAkjgI23LJF2iF9Be0olDOfWL9wJpH7ZNZ2WsHoJk
         +hSDFHSQ92r9u0M2Dch9H5yDGFXl1018AxFQlc7uf6ivvYzp73997ibMFQpQXdODhvDU
         SmSbCmCc0HydGfuwe92D+n7Qix74SKPAtHSaWkJAuyGOBn7ah3+2Ad2iOzDy0gSxRmdS
         UY3rGOn9FYQt/MrOLqTpckQDklqFMNXx1b6/0SblGFKTBBPR1roaGarjTmVOTMvdSD+1
         N9ascL1nb9KOHUOtoJsWmApn3TRZYZqbgzm+1sekoP3HvbGS3ykPKPNDG6WruQ0+MV5v
         zE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8NU2H/rGkzMEGnRhbeP8HcREPvdELz1mjoNpn1J8y28=;
        b=e5fTBgaOjHDIhDWoC4JXkkDcXl58FkbWESdDwOteDJ8eKFcBdz+T++uG/pYYuExitu
         B5nB26+jYmi0afVaOgHAKSPHJCPd9rxpgzKDeYYLh46dC6CHgHMzuM/RthXAwY/LRuNc
         kkKjS5vQX17F03Dzqj170VXHFS+/oJdusB68N2rGRKMBykUM9H1S+qMAiZVOHRNlBrAB
         iII8jeC9bg4OygH1QhwxFCZGTmSGTpHfYlQJ+H+oXAWUNQkxU507WZH1dOUxbeuJkBQd
         pbtm5r12m86ubByFdPYQDlzHhxXioEgJ1EevhMiOzq/HHizmVISEOAmVIyV4mbHwgVS0
         jQJA==
X-Gm-Message-State: AOAM532Ammlmtzrcpyjz57R4WHsCKkV37QZO+9sdFUrNUo2I5q8rBUgW
        M4w3+LpZozxNVGYzouehGNCxjg==
X-Google-Smtp-Source: ABdhPJzMsOrexH9kVH+VLEwd+tYMcu34iM1PfCuW82bxkvjyz1uRPfZZ/PhcVkUAaPMsjb39aXLaHQ==
X-Received: by 2002:a62:d045:0:b0:518:404d:9dc8 with SMTP id p66-20020a62d045000000b00518404d9dc8mr8346001pfg.60.1654227425535;
        Thu, 02 Jun 2022 20:37:05 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902714600b0015e8e7db067sm4271349plm.4.2022.06.02.20.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 20:37:05 -0700 (PDT)
Date:   Fri, 3 Jun 2022 11:36:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Joe Mario <jmario@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Adam Li <adam.li@amperecomputing.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/12] perf c2c: Support display for Arm64
Message-ID: <20220603033657.GA41034@leoy-ThinkPad-X240s>
References: <20220530114036.3225544-1-leo.yan@linaro.org>
 <57a826ad-5ceb-ba1d-b80c-452f72720889@redhat.com>
 <20220601102505.GA408721@leoy-ThinkPad-X240s>
 <CAP-5=fVqjZOvncE3iTAF6Wfqrn3_UxGsrBJkiaT=qMs5xdq9LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVqjZOvncE3iTAF6Wfqrn3_UxGsrBJkiaT=qMs5xdq9LA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Thu, Jun 02, 2022 at 09:59:29AM -0700, Ian Rogers wrote:

[...]

> This is great Leo! I've not been able to test the changes but I didn't
> have any coding comments (happy to give an Acked-by). Do you think we
> can add a test for this? The test can skip when c2c isn't supported.

It would be great if recieve your ACK tags :)

Yeah, agree that it's good thing to add test for perf c2c.  Just note,
after rough thinkіng, seems to me the right thing to do is to add a
testing shell script in the folder tests/shell and use a tiny
multi-threading program for accessing the share cache line from
different nodes (or rollback to different CPUs).

I would like to use a separate patch for adding the test case, this
would be easier for upstreaming current patch set.

Please let me know if this is fine for you or not.  Thanks for reviewing
and suggestions!

Leo
