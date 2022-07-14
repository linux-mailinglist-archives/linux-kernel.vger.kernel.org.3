Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B71B575281
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbiGNQMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiGNQMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:12:50 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42DE564FA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:12:49 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j27so1798001qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=CZLFeaVS7vWOEfaeQkprgU1KCxlSQm00dIhPzGkGGKU=;
        b=LDDvkmSjKKbscVokOXbYzqcdRhJ4gYz0B5kwXLAji/c8LxVZopE/LU4tDWJxFiBdFv
         owHKoL6rACGJmSckOjybjEjGktTvBk2e7KWkvSxEyKN0vwqpX7aQPB5SZlyUsOcXESQ6
         PVSrVS53MAGy33w5GcuejKTTOBQeb/xek54pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=CZLFeaVS7vWOEfaeQkprgU1KCxlSQm00dIhPzGkGGKU=;
        b=0pU3zh5Z7nExGJZYKQeV/a76grdAJBfs2yKYVisJpwhLsxZ+v81qvEI6Fol58ei0ty
         E+baC1L23TkntXZpCdIuEtSHMeJJVDMpkBtbzRGivguIHueE92vKXMGbjQen1SNVPcwa
         0maAoncHrBFWAZ4ZnwrcqEs8Y96N4kxCE6vn+VWpBIvxdVl4dWFRXFXiuwfAatts5368
         OhTe6KW3FKZgV2AXL98lBRs8myGz5CrQEX0UlaPLON6VtPWplnMCzVfgr3ie7A2I9uVM
         /bH9/j/1iufXTJbkRynQNzk2JFLcKubNJutcw5K0qlBkzVisDYNe3yTGkjBfpUTQq9Zx
         /JuA==
X-Gm-Message-State: AJIora9cKWvDgOaIyH7pp0ojxKczmO8AzcvoN3tcIWxKlbKpNwVOT03w
        5sbeHrrL6i6btyZWkgz5cTxPSCPI1wpAdg==
X-Google-Smtp-Source: AGRyM1sKc1UZIwcvXiITIgT3O8TjGW5qevBlln9Z5/qySGu99Qq2GdSQh0Mo9EfBNAkt+5zRlxwhxw==
X-Received: by 2002:a05:622a:c6:b0:31e:b32c:a280 with SMTP id p6-20020a05622a00c600b0031eb32ca280mr8777918qtw.211.1657815168945;
        Thu, 14 Jul 2022 09:12:48 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id bp13-20020a05622a1b8d00b0031e9fa40c2esm1880404qtb.27.2022.07.14.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:12:48 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 14 Jul 2022 12:12:42 -0400 (EDT)
To:     "Liang, Kan" <kan.liang@linux.intel.com>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
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
In-Reply-To: <0e3b3e6e-53b9-b426-71cd-911d3ecbfc24@linux.intel.com>
Message-ID: <15f85765-ff2f-5d32-5991-06ef225706f0@maine.edu>
References: <66961a7d-a6d8-2536-9ed3-68c2e7f4e03d@maine.edu> <e71fa75-a718-ffb-c3f3-40cccf77ba9b@maine.edu> <4b15d3d1-389b-fee4-d1b9-8732859e3696@linux.intel.com> <20220711221658.4gpkizopmftpnav6@guptapa-desk> <32ccdda1-63bf-746e-48fb-935fa58285b1@maine.edu>
 <20220712204830.kvblayj37s3udt4b@guptapa-desk> <487465e6-b034-f08-907-de37a0a173b5@maine.edu> <0e3b3e6e-53b9-b426-71cd-911d3ecbfc24@linux.intel.com>
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

On Tue, 12 Jul 2022, Liang, Kan wrote:

> 
> Could you please apply the below patch, reboot to the patched kernel and
> share the dmesg log?

here's the info with your patch applied:

[    0.000000] microcode: microcode updated early to revision 0x28, date = 2019-11-12
...
[    1.460296] NO HLE NO RTM. LBR has tsx 0
[    1.468217] Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    1.472292] ... version:                3
[    1.476275] ... bit width:              48
[    1.480275] ... generic registers:      4
[    1.484276] ... value mask:             0000ffffffffffff
[    1.488277] ... max period:             00007fffffffffff
[    1.492277] ... fixed-purpose events:   3
[    1.496271] ... event mask:             000000070000000f

Vince
