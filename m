Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D33564AAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiGCX7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiGCX7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:59:12 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E001168;
        Sun,  3 Jul 2022 16:59:10 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 7E6A5C020; Mon,  4 Jul 2022 01:59:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656892747; bh=/s5clT6IWo80j/dSUJtMS1xJOw5uFEM/eLTNpBGITF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUHVsoZ6FnoAeJo54iM7H3L7+amUZHThbp32QIOjKOj+8TbUkqVTLjl+3v6nUnBql
         vMbA/pIL0FhIHCobk2WwZiMVNnltiLOeVZ1VUDU4+7kS2NAY2tJQ7j/TVPUSCeFu7Y
         Z4s729f4pDWasQhTUmu2ex3+ajrIzqxOTebrsIaTBnsEUE4wl+jzaf6Q9zHolUv0Eu
         2dvsgBOr5oH/OQbGPCcWoQHvePfhaU3/tKJ5ocO2IvxXQ5j1TWPrbJZJRNRdJBvLqp
         T0eXXahjAs9EQYnmT8nxr2UfsWxmsbJ5ic05i8chafHJtDFY4iin25DnxYRJ0vC5Le
         oQ3TgO/bgxjRQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id C6B5EC009;
        Mon,  4 Jul 2022 01:59:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656892746; bh=/s5clT6IWo80j/dSUJtMS1xJOw5uFEM/eLTNpBGITF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzbH1/+dkymrgLFP8H7mwQJQ0p8fVQ1CPObTRB/aXO/kuFYX8u3+b+MZKQg65zahA
         R2jtsbzhpz3Iq8mYk9d+pxKDMg4rtn1BpVlsx7dfi51lB43W2NY5gTxzCo8GQ2K49o
         YcLWyrALc5W0MTiK9mI250sjZUp9rAAUDcf7tqoHXCv0h4SbK16K71LzovHrw0nug3
         yAYoDJtDsLMSbtkQFDN8TNPHvvFmD2qpRgGQxW7zdXVV/aOHanmkS67pe22ollVrro
         sMxuVEs+Vh7/QJbebFl+XlTnYamiBdUUxAI8NGeSsuapBw34VpVbpdPSrtcSOPVOY8
         L5maSxeVH1xWQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id f4bbac8c;
        Sun, 3 Jul 2022 23:59:00 +0000 (UTC)
Date:   Mon, 4 Jul 2022 08:58:45 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse: Allow names to start with digits
Message-ID: <YsItNWBYfZ5UoUPf@codewreck.org>
References: <20220612061508.1449636-1-asmadeus@codewreck.org>
 <YsAUqwzeO8U6cIJA@codewreck.org>
 <YsA4+A7TSjzUKDWK@kernel.org>
 <YsBosxs9TVB0aLrf@krava>
 <YsDZ8mTnCQzpejOM@codewreck.org>
 <YsGduWiTvkM2/tHv@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsGduWiTvkM2/tHv@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Olsa wrote on Sun, Jul 03, 2022 at 03:46:33PM +0200:
> > not sure if there'd be any other way of testing, there's nothing else in
> > 'perf list' that starts with a number.
> 
> maybe we could do it same way we did for fake pmu events like below

hmm, I'll have to defer to you on that honestly.

It looks good to me though and I've tested your diff (test succeeds even
with 9pnet module unloaded).

Just a note though, this makes test no longer checks the sys event
directories exist for all other tests in these arrays (test__events,
test__events_pmu and test__hybrid_events); if we have guarantees the
probes exist I believe at least a few should keep checking the format
path correctly.
It might be worth adding a check_format flag to test_event() and add a
new list that doesn't check formats just for 9p?

If you're ok with that I can resend this as three patches: my original
patch, a patch with your diff and test_event() keeping current
behaviour, and a last patch adding that last flag and testing 9p without
format check.

(and if you don't think it's worth checking probe existence same thing
but even simpler)
--
Dominique
