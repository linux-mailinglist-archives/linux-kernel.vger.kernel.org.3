Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBAA47446F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhLNOEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbhLNOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:04:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841AAC061574;
        Tue, 14 Dec 2021 06:04:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 246BC6150E;
        Tue, 14 Dec 2021 14:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F62C34606;
        Tue, 14 Dec 2021 14:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639490690;
        bh=jD+hAXEJnh6UeOGOrFz3TYzQsO4CU3xfpx+9AcTlJko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgPmF9hoseYABsDDYgAWN9QkYz0X27zT34P/gMG2Zxn3fADxaJ9XLgvdMchmHY2c1
         kft8UacTk/5/vwUvYOxKfqy1pedpJjxXEcnV7/gQOEtx6lJHIH1nG7m8LQt8y1dv6G
         AtsNDmaGNM01F/NMjOFZa1zU5m3t07Z+DPmVnl2OfGc/UNHPrY3hYJejYZZUgfV+3h
         Lf2WKP4q+Nz/meKfuNFY1jSvzH2ig+E+lG0P59W/xLvaVAsJ4gKxSYRWtKfm3SbhEu
         DEp7QbLDoApzEhS8JljTI/2x0Ci6/WbGdBikF1ekXLSA9ZgxsT5ZmCBdLAkS6oOAvw
         fuVKS853ANugQ==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v13 0/5] arm64 userspace counter support
Date:   Tue, 14 Dec 2021 14:04:35 +0000
Message-Id: <163948145564.2060329.17036263207999776606.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211208201124.310740-1-robh@kernel.org>
References: <20211208201124.310740-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 14:11:19 -0600, Rob Herring wrote:
> Another version of arm64 userspace counter access support. No changes from
> the last version except rebasing and rewriting a commit message.
> 
> The arm64 support departs from the x86 implementation by requiring the user
> to explicitly request user access (via attr.config1) and only enables access
> for task bound events. Since usage is explicitly requested, access is
> enabled at perf_event_open() rather than on mmap() as that greatly
> simplifies the implementation. Rather than trying to lock down the access
> as the x86 implementation has been doing, we can start with only a limited
> use case enabled and later expand it if needed.
> 
> [...]

Applied to will (for-next/perf-user-counter-access), thanks!

[1/5] x86: perf: Move RDPMC event flag to a common definition
      https://git.kernel.org/arm64/c/369461ce8fb6
[2/5] perf: Add a counter for number of user access events in context
      https://git.kernel.org/arm64/c/82ff0c022d19
[3/5] arm64: perf: Add userspace counter access disable switch
      https://git.kernel.org/arm64/c/e2012600810c
[4/5] arm64: perf: Enable PMU counter userspace access for perf event
      https://git.kernel.org/arm64/c/83a7a4d643d3
[5/5] Documentation: arm64: Document PMU counters access from userspace
      https://git.kernel.org/arm64/c/aa1005d15d2a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
