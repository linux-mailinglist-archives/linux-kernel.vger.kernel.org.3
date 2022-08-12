Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519A35909D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiHLB1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHLB1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:27:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B155587
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:26:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id x23so18392204pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=IC2lOX4v95VrufPS47o61RIKEMbFjLQqPK43AtSv6po=;
        b=UE9z9/3M/BAUiXTOQrCRmLbiL2MAC3pvT3WlcBscTEAWfL722Wj6OXfNmvrinxoYaJ
         FvWholCLiJDnuaeJ5zzWb60iBctYTKpCdbSRbk5A5cNrLL7kWPBDoiLYr6pe/BP9Iu+b
         FTDNNsKlkkTxaeyHSnKwH4m+RJ44e2m2bIGRvQY7SO7Nrk/LeJ72oaToLUxsHlo7KBcx
         tYpOMlFTLHXf6cFevj1kZjUpTyzuQXR4mhnvbbFb+vnHsLn+Tdj7QpThMF8Z1Vvf+OGI
         aBWzD1NcT9GS+QlZvSEeVegmFHLmA/+D4CKMfeAnZSspbRjsqxgvwTy2RNF6MRbdOlX6
         K4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=IC2lOX4v95VrufPS47o61RIKEMbFjLQqPK43AtSv6po=;
        b=TSP1XZCkY+oPEuimzBzItbwB9U1n7YFsSzK+WhwnZj1s2T2Dc4Vyz1pDuY2JfpYUBd
         VBM6hTF5HCm4oajSKu5Pqpz9n5UO1g2NCfmHzqBT1hGxvJkBoY36k+RE65mmmR7e9VJK
         lVLpd6+G0pX9BSADR+ferNMYSvH23qQ0mR1LJLrBW34BQOSm+Tgj+Yc3Fk6cvd0TpCYU
         QdP5bHygRpre7FBSdU6XsS7xIDk5Frbw9ZWpG9uvefhT5PHMPoFVW7q42l89HkPT3V/s
         NvE+S/5VDdbPb9eGAuuUiaY6vUIpiJ/lGbmVKoPahCqEMA6IPtng1C+UECVfKbysw2lK
         4aPA==
X-Gm-Message-State: ACgBeo36Zr5nXrEB0x1CkeLSMZzvwi8pHrN6nKZGJVwXMTWrT+7sXpK3
        SEQJlPXdZ+ZcM4a/LRJwMmj3xA==
X-Google-Smtp-Source: AA6agR4a+3vDJ+tdb5s4TP+TqyslMWMcYsO4THIG/TPxnJ10mwssUEupQP1W6Ft56ScaJ0Re6cv3ow==
X-Received: by 2002:a17:90b:1bc6:b0:1f5:313a:de4b with SMTP id oa6-20020a17090b1bc600b001f5313ade4bmr11414402pjb.4.1660267618478;
        Thu, 11 Aug 2022 18:26:58 -0700 (PDT)
Received: from leoy-huanghe.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b0016a111c83cdsm324932plh.119.2022.08.11.18.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 18:26:58 -0700 (PDT)
Date:   Fri, 12 Aug 2022 09:26:51 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 00/15] perf c2c: Support data source and display for
 Arm64
Message-ID: <20220812012651.GA1643436@leoy-huanghe.lan>
References: <20220811062451.435810-1-leo.yan@linaro.org>
 <YvWB32rTsOHirOb4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvWB32rTsOHirOb4@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Aug 11, 2022 at 07:25:35PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 11, 2022 at 02:24:36PM +0800, Leo Yan escreveu:
> > Arm64 Neoverse CPUs supports data source in Arm SPE trace, this allows
> > us to detect cache line contention and transfers.
> > 
> > This patch set has been rebased on the acme/perf/core branch with the latest
> > commit b39c9e1b101d ("perf machine: Fix missing free of
> > machine->kallsyms_filename").
> > 
> > To make building success, a compilation fixing commit [1] has been sent
> > to LKML, this patch set is dependent on it.  This patch set has been verified
> > for both x86 perf memory events and Arm SPE events.
> > 
> > [1] https://lore.kernel.org/lkml/20220811044341.426796-1-leo.yan@linaro.org/
> 
> So, I tentatively applied this set after applying the patch for
> <asm/sysreg.h>, and its all now out in tmp.perf/core in my git tree,
> please check.

With discussing with Suzuki, he pointed it is not perfect for adding asm
include path in that way.  With the patch on tmp.perf/core branch, two
include paths are added into CFLAGS for arm-spe.c:

  -I$(srctree)/tools/arch/$(SRCARCH)/include/
  -I$(srctree)/tools/arch/arm64/include/

When we build perf on x86_64, then $(srctree)/tools/arch/x86/include/
takes more precedence than $(srctree)/tools/arch/arm64/include/; if we
want to include header file without relative path in c code, like
"#include <asm/cputype.h>", then it has chance to find the same name
file from x86's asm folder rather than arm64's asm folder.

At yesterday, I spent couple hours to find other methods (like
filter-out, CFLAGS_REMOVE, etc) in makefile but it's no lucky to make
success to give precedence for $(srctree)/tools/arch/arm64/include/.

So current patches on the branch tmp.perf/core can build successfully,
but if have any better method to resolve the header path precedence
issue, then I prefer to improve for this, which can allow us later
don't worry about it.  Any suggestion for this?

> I'm doing the usual set of container build tests, but any additional
> checking, including on the committer note I added to the first patch in
> this series, claryfing it is not really a "sync" with the kernel
> headers, is more than welcome.

It's fine for me for adding my Signed-off for the signature chain.
Appreicate for the amending.

Thanks,
Leo
