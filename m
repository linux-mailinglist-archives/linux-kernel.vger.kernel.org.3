Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EFF570C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiGKVN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGKVN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:13:56 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651CEE39
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:13:54 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j29so7522812qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=8vTBmzv852xKhWrN9h9mYQ3XpcRNGRn6fXVgj6QYgw8=;
        b=PKGGj9RM5A+JX4lcrP1HKxNMQxBQ7Yqm5bImHQaaz+co5hEWpJr0AD9Ac5dwerESWZ
         6t2nN7TASEaCg7UvKsrANOp3zeKoA5YdfcVREuBUWyyZ2peDhiuKaqbBWzzpQqwEd7dn
         /br0nPtmqyyaG9bM3v7WSThELezUjK2PUuSso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=8vTBmzv852xKhWrN9h9mYQ3XpcRNGRn6fXVgj6QYgw8=;
        b=Ut7ykPjoS14j7MG1fpqbWDYKxI4uLUp1HC5Wjj+EzwuG/munlHO4UW+oGTh+IJCg8E
         /eXamRR1fpOLuLjI9YjIRM6pgXX2mPX6Ggo14jJmxwhLwofDSJiIfpZ834/pER7nVrdb
         I8s6Ub5eZ+rwBwR5dp1i3MJ1lsRzUU2s7AnCbx93RwSfLUJJRO8qvR/SswmOWAT+h6yO
         OUobkV82UStLFc5zYxYXBlOZQtA7nykKzSZRCk2DaYmIalyhrp3EVRDQmsFGuRYrFzQn
         zzNwPZZws6gpRO6/pLqTjiU/wDV4qKA/odq1Q40aMYwRm6aOCcRxFPUO/SX1BVGAiPVJ
         /5Rw==
X-Gm-Message-State: AJIora8nwk9tcLC5XnbHeJ7hr/Zp59QkeB2kp6dXMbTbfijr95bLmxx3
        JdslgZBUO631Xoi8lO9x9GvJRA==
X-Google-Smtp-Source: AGRyM1vRKchYufioyisseSRjD9AXUuhb5O0TI80r7JEQkCqxHm6U9I3uUypQjpbui5FT6oPUBrVexg==
X-Received: by 2002:ac8:7fd1:0:b0:31d:4c2d:c448 with SMTP id b17-20020ac87fd1000000b0031d4c2dc448mr15503431qtk.11.1657574033866;
        Mon, 11 Jul 2022 14:13:53 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id br15-20020a05620a460f00b006af290182c8sm7275293qkb.86.2022.07.11.14.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:13:53 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Mon, 11 Jul 2022 17:13:52 -0400 (EDT)
To:     "Liang, Kan" <kan.liang@linux.intel.com>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        pawan.kumar.gupta@linux.intel.com
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x689 in
 intel_pmu_lbr_restore
In-Reply-To: <4b15d3d1-389b-fee4-d1b9-8732859e3696@linux.intel.com>
Message-ID: <f22dd6fb-48b7-99cf-3d7a-348e5792c8@maine.edu>
References: <66961a7d-a6d8-2536-9ed3-68c2e7f4e03d@maine.edu> <e71fa75-a718-ffb-c3f3-40cccf77ba9b@maine.edu> <4b15d3d1-389b-fee4-d1b9-8732859e3696@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022, Liang, Kan wrote:

> 
> 
> On 2022-07-08 12:13 p.m., Vince Weaver wrote:
> > [ 7763.384369] unchecked MSR access error: WRMSR to 0x689 (tried to write 0x1fffffff8101349e) at rIP: 0xffffffff810704a4 (native_write_msr+0x4/0x20)
> 
> The 0x689 is a valid LBR register, which is MSR_LASTBRANCH_9_FROM_IP.
> The issue should be caused by the known TSX bug, which is mentioned in
> the commit 9fc9ddd61e0 ("perf/x86/intel: Fix MSR_LAST_BRANCH_FROM_x bug
> when no TSX"). It looks like the TSX support has been deactivated,
> however the quirk in the commit isn't applied for some reason.
> 
> 
> To apply the quirk, perf relies on the boot CPU's flag and LBR format.
> 
> static inline bool lbr_from_signext_quirk_needed(void)
> {
> 	bool tsx_support = boot_cpu_has(X86_FEATURE_HLE) ||
> 			   boot_cpu_has(X86_FEATURE_RTM);
> 
> 	return !tsx_support && x86_pmu.lbr_has_tsx;
> }
> 
> Could you please share the value of the PERF_CAPABILITIES MSR	0x00000345
> of the machine?
> I'd like to double check whether the LBR fromat is correct. 0x5 is expected.

How would I do that?  Just something like:
# rdmsr 0x00000345
32c4

or is it more involved than that?

Vince Weaver
vincent.weaver@maine.edu
