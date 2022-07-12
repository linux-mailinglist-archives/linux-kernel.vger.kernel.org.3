Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5D6572894
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiGLV0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiGLV01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:26:27 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09766D0E2A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:26:26 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id l11so3523712qvu.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ErGKC+iaVGBTzQ4jHmkuIH32JYO5Zpx2Ix6hmNqFWSQ=;
        b=TG1ivwDnuT3Vkxk4MKCpHTf+v9ML7AAOEnlSYRlMXskUid7ZFNTbhvEFarsn6JT0Ub
         tC2sfYUVKZ2yzLQ9FYaBTX2Sh3RuV2ZfaTfPT+c6EDJXFBz4ZtEDQQKZ1kT0Vft7ymdv
         oSfAl0gmDN038PXL0eI8r7ke1JDbgZK7y2Fxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ErGKC+iaVGBTzQ4jHmkuIH32JYO5Zpx2Ix6hmNqFWSQ=;
        b=jRheTY+MHXp5FJoYpo40WVUpMFTU9tB/lw7hvxk02Nua0g7xXUuHDiv6e072t5gFA7
         5U3iKx+XNNnSnbNCby17o+14JWxoSPPFpK/8RyFs6IjOdZsqrToP5/ACcocp065gnIUY
         zBsynwx8RQq0YAcPx+Yfa/Ra5KPLqwdXklxNd3LUFXkq+B8wliPY3hYipiH0APhU7a7G
         8po4/KnId5fqEre4MtEEl6BCpMeA/jv26fqPLMqjZ6gg7n0Y2A9nLb8vA1QPzggFfDnE
         i4qvEp/ppYlsCOAPIqfasejtqtYlxtQ3yM4bM0tF+jLZzbCdeHLQ9X/RPMyFVjnj7IT8
         eNiw==
X-Gm-Message-State: AJIora/9e8QyJzIAK709zswcRrE1sdz7u6RpURbjjfzlkGGDHnszoViP
        UsEcXV5YcEnbprz8/2U5GQDBig==
X-Google-Smtp-Source: AGRyM1tsesBESjrN/rzBRcxB2eekllPKVCNSlFdi1Hhzkd8QqzfFnsesUllulk/5eW9CYQHojG66Aw==
X-Received: by 2002:ad4:5baa:0:b0:473:6b81:a735 with SMTP id 10-20020ad45baa000000b004736b81a735mr200053qvq.30.1657661185205;
        Tue, 12 Jul 2022 14:26:25 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id t11-20020ac8588b000000b0031eb47652dcsm5779579qta.59.2022.07.12.14.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:26:24 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 12 Jul 2022 17:26:23 -0400 (EDT)
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x689 in
 intel_pmu_lbr_restore
In-Reply-To: <20220712204830.kvblayj37s3udt4b@guptapa-desk>
Message-ID: <487465e6-b034-f08-907-de37a0a173b5@maine.edu>
References: <66961a7d-a6d8-2536-9ed3-68c2e7f4e03d@maine.edu> <e71fa75-a718-ffb-c3f3-40cccf77ba9b@maine.edu> <4b15d3d1-389b-fee4-d1b9-8732859e3696@linux.intel.com> <20220711221658.4gpkizopmftpnav6@guptapa-desk> <32ccdda1-63bf-746e-48fb-935fa58285b1@maine.edu>
 <20220712204830.kvblayj37s3udt4b@guptapa-desk>
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

On Tue, 12 Jul 2022, Pawan Gupta wrote:

> On Tue, Jul 12, 2022 at 03:39:56PM -0400, Vince Weaver wrote:
> It appears this CPU does not support TSX feature (or disabling TSX). If
> the bug is easy to reproduce, bisecting can help.

I thought TSX was disabled via firmware update for all Haswell machines?

In any case, the fuzzer is triggering the
	unchecked MSR access error: WRMSR to 0x689
in intel_pmu_lbr_restore.  So either this is a false error and should be 
disabled, or else it's a real issue and should be fixed.

Unfortunately the fuzzer can take up to a few days to trigger the message 
(it's not easily repeatable) so doing a kernel bisect would take a very 
long time.

Vince

