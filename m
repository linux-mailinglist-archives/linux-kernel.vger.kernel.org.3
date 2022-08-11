Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605E858F7CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiHKGle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiHKGla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:41:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199EF625C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:41:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f28so15739019pfk.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=8Ls4pFvfLJMWwcmLhID1I6I1DLBX05K+UJVFFV9Za6M=;
        b=vMy0JbabQGaviBO27so/kcHKd/6i1tm8ma6oUqJlmeqnvqIleBB4FN3SZyCTA9oApz
         JNVMSIbKSiyvqVgKfgwtyb7g072G8H4fScIPRFqpkddCUr04cYfniC5FZ1r/9h4gNa2L
         jzK2fZVX+eu34dd7p4EjUOlm5GbRQcgAAQ8f5LBgVzVpJ4Bh9OeBEURXBlffgwIDTfC/
         0sbZdEnh3BbofV/dOE/NiLP+0HCBB2k64zNG2AC8CoNKbNMDue3Cjiv6TLFTXVa9duFf
         VNksgovC8IjiE8CV/i16v4GLtLX4rDL0Cag7P0M/ZTCyRzizPlGJeTmgPEFZHw2Vhnwi
         4cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=8Ls4pFvfLJMWwcmLhID1I6I1DLBX05K+UJVFFV9Za6M=;
        b=Asx9/ukk9COJpnRboyC/rZfDXTiUkz6f6XiV2PUhfk2Nf++YuhBXkLds+D1l+fuGh7
         bAUmTHGxlVcFvcVqY0RaSeBpUU9hNIrWANN8PmV87GkF57vsG6DJ/DJ+CIEw8mG2UhBH
         vOSoVWizQDwthFNnvw2pN96BVmS4kppGO1Q5Az0gwGSrkPwQY9mi2EFyx5J+N0bJ4B5F
         apfMgXVY4vQNuaCOGv6yFgT1nECpiFCZ6CtQpOu1nAfAX4Shc68YwEpfVCke3Z5O2Vu5
         7SuRye+Bz2LZRBNxodu2XbzTw9IBpaci6BfCSXJFDZ+Icr+eVKm7+GsEmZuXjCinvoAo
         COxQ==
X-Gm-Message-State: ACgBeo1rsXuAFN4TULGCjZzxl7QdY3REUwiHaV2lQp32Coifk9cvTegx
        XAaJqXvQzg16TK9P+IG6RwvS3g==
X-Google-Smtp-Source: AA6agR7nKY/UN1mSywz2fbtTnLwsfY0AOBEbt40itndC5bJz8PmSiqPAd8PaShPIGIhT3T81iZYDEw==
X-Received: by 2002:a63:4566:0:b0:41d:353:46b4 with SMTP id u38-20020a634566000000b0041d035346b4mr23099189pgk.316.1660200088455;
        Wed, 10 Aug 2022 23:41:28 -0700 (PDT)
Received: from leoy-huanghe.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090a2dc100b001f21f5c81a5sm2795643pjm.19.2022.08.10.23.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:41:28 -0700 (PDT)
Date:   Thu, 11 Aug 2022 14:41:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 00/17] perf c2c: Support data source and display for
 Arm64
Message-ID: <20220811064122.GA860078@leoy-huanghe.lan>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
 <YvO0nAZ1znppjKjZ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvO0nAZ1znppjKjZ@kernel.org>
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

On Wed, Aug 10, 2022 at 10:37:32AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Jun 04, 2022 at 12:28:03PM +0800, Leo Yan escreveu:
> > Arm64 Neoverse CPUs supports data source in Arm SPE trace, this allows
> > us to detect cache line contention and transfers.
> > 
> > This patch set includes Ali's patch set v9 "perf: arm-spe: Decode SPE
> > source and use for perf c2c" [1] and rebased on the latest perf core
> > banch with latest commit 1bcca2b1bd67 ("perf vendor events intel:
> > Update metrics for Alderlake").
> > 
> > Patches 01-05 comes from Ali's patch set to support data source for Arm
> > SPE for neoverse cores.
> 
> Leo, please remove touching the kernel perf_event.h on the first patch,
> I see it doesn't affect the kernel right now as it is done just from
> synthesizing perf records from hw trace data, and we haven't received
> any review comment from Peter Zijlstra (I think he is in vacations).

Done!  The new patch set іs in below link, which dropped the patch for
kernel perf_event.h:
https://lore.kernel.org/lkml/20220811062451.435810-1-leo.yan@linaro.org/

One question: should I later continue to upstream the first patch for
syncing the kernel header perf_event.h after Peter.Z comes back?


> Also please refresh it:
> 
> ⬢[acme@toolbox perf]$        git am ./v5_20220604_leo_yan_perf_c2c_support_data_source_and_display_for_arm64.mbx
> Applying: perf: Add SNOOP_PEER flag to perf mem data struct
> Applying: perf tools: sync addition of PERF_MEM_SNOOPX_PEER
> Applying: perf mem: Print snoop peer flag
> Applying: perf arm-spe: Don't set data source if it's not a memory operation
> error: patch failed: tools/perf/util/arm-spe.c:387
> error: tools/perf/util/arm-spe.c: patch does not apply
> Patch failed at 0004 perf arm-spe: Don't set data source if it's not a memory operation
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> ⬢[acme@toolbox perf]$

To fix the merging conflict in the new patch set, I also dropped the
patch "perf arm-spe: Don't set data source if it's not a memory
operation", since this patch has been merged into the mainline kernel.

Note, when verified the patch set, I found a compilation error, so I
sent a separate patch to fix it:
https://lore.kernel.org/lkml/20220811044341.426796-1-leo.yan@linaro.org/

Thanks a lot for continuous tracking this series.

Leo
