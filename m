Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B70535134
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347840AbiEZPF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244390AbiEZPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:05:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D856A42C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:05:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 714D7B8205B
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D498DC34116;
        Thu, 26 May 2022 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653577551;
        bh=R/xetRo6lVmcMiToOdjleSOMxxio0iPr51IL0BL22C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8tPUE5hJeB9nV+6Tvo/pt8JM+UbTjGy/Y9bAZaDDxls+VbvDvpxDhzFnQgXQNsZ+
         XCDaS4POyir4RDlztRSHIFPdTYi/FTgSDl5yhNas40jizW2L2bYH9edZ3dAstKOzpu
         ATF4sgAdBCelmQ1xV8lXcGC4UT1eViMgYLeQO+n7PxS3P4nMg22oYs5eQXrDIDH0Kx
         fhJDopFm5oEJ+hKB8VH4rh3ev6cuGhEj6lIRrcDIK9jhP00zmFPzF2cmQ8jJuFDFUp
         +/xGSXOYLuD7qCKgAeNs5GE9ywWgAhUM1mrF3uGXz//prSuNd9LNAvYKx/aaNzFxu1
         AjrZ68Nqrvedw==
Date:   Thu, 26 May 2022 08:05:49 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 2/7] objtool: Extend UNWIND_HINT based ENDBR rules
Message-ID: <20220526150549.vqvggcuqmw2baslp@treble>
References: <20220526105252.440440893@infradead.org>
 <20220526105957.817269865@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220526105957.817269865@infradead.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 12:52:54PM +0200, Peter Zijlstra wrote:
> Extend the UNWIND hint driven rules for ENDBR placement. Currently
> objtool expects an ENDBR at any UNWINT_HINT_IRET_REGS that is at +0 of
> an STB_GLOBAL symbol, with the expectation that this is an exception
> entry point.
> 
> Extend this to also expect ENDBR at UNWIND_HINT_EMPTY at +0 for
> STB_GLOBAL symbols, with the expectation that these are also machine
> entry points (SYSCALL et. al.).
> 
> This guarantees all machine entry points are covered by objtool rules at
> the expense of a few additional false positives:
> 
>   vmlinux.o: warning: objtool: startup_64+0x0: UNWIND_HINT_EMPTY without ENDBR
>   vmlinux.o: warning: objtool: start_cpu0+0x0: UNWIND_HINT_EMPTY without ENDBR
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I can't remember if this was my bright idea, but it feels kind of
arbitrary.  Hopefully there won't be a lot of false positives.

Anyway, won't SYSCALL-type symbols typically be referenced elsewhere in
the kernel and thus be found by the regular IBT validation?

Do you have any examples of where this warning would trigger if there
were a missing ENDBR?

-- 
Josh
