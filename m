Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F6551D8B6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392333AbiEFNVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239008AbiEFNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:21:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA7563524
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 291CE62001
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93933C385A9;
        Fri,  6 May 2022 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651843058;
        bh=8051614L8Sll2Zr5aA68WUcaidhoMT52a/Hv54vHn7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AKNofkHd+W5jZB2AZzS3JakpjcYUdwsJ5lhSMaMPr/jsNkKgriuq/16GKNXj/9KhL
         942ryDnREYmhsCWZvckdyD/dsAFlWLWPXAsMrVTLxjWRfa6ROVUh2AG/C5PdrW6HeC
         v6wU5qRy9GRzaoIqZyfvw53Q3A8XKHgYXkC4wNbLb6bNMpwMWZkKpQEDEGpywhHIb3
         mWc8rolzOAoRq5fHsRTDcEYIeQybA/RALUKHKmDcmRQJDdLtne4kAupY0vA9rlVTsG
         6K16alpLhGktu1kfepH05hJPkSZMZApv3RS8Qw65vUe/enrX38ojZg52LuZB5ChdiM
         /nRPAUsZ0tcuw==
Date:   Fri, 6 May 2022 14:17:33 +0100
From:   Will Deacon <will@kernel.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64,trace: Add page fault traceponits
Message-ID: <20220506131733.GE22892@willie-the-truck>
References: <20220420070109.1010257-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420070109.1010257-1-sunliming@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:01:09PM +0800, sunliming wrote:
> The arm64 architecture lacks some tracepoints support, this patch
> adds page fault tracepoints. The code and arch policy is mainly
> inherited  from x86.
> 
> Experimented on my centos8 virtual machine:
> 	dracut:/# echo 1 > /sys/kernel/tracing/events/exceptions/enable
> 	dracut:/# cat /sys/kernel/tracing/trace
> 
> The results:
>               sh-6098    [001] .....  1186.024675: page_fault_user: addr=0xffffe153cc00 pc=0xffffa4117338 esr=0xffffe153cc00
>              cat-6126    [000] .....  1186.024677: page_fault_kernel: addr=0xffffa4323740 pc=schedule_tail esr=0xffffa4323740
>               sh-6098    [001] .....  1186.026085: page_fault_user: addr=0xaaaad23fae34 pc=0xaaaad231c0fc esr=0xaaaad23fae34
>              cat-6126    [000] .....  1186.026106: page_fault_user: addr=0xffffa414565c pc=0xffffa414565c esr=0xffffa414565c
>              cat-6126    [000] .....  1186.026222: page_fault_user: addr=0xffffa4214e10 pc=0xffffa4145670 esr=0xffffa4214e10
>              cat-6126    [000] .....  1186.026243: page_fault_user: addr=0xffffa420fd88 pc=0xffffa41456ac esr=0xffffa420fd88
>              cat-6126    [000] .....  1186.026282: page_fault_user: addr=0xffffa4117338 pc=0xffffa4117338 esr=0xffffa4117338
>              cat-6126    [000] .....  1186.026308: page_fault_user: addr=0xffffe153cc00 pc=0xffffa4117338 esr=0xffffe153cc00
>              cat-6126    [000] .....  1186.026365: page_fault_user: addr=0xaaaad231bd84 pc=0xaaaad231bd84 esr=0xaaaad231bd84
>               sh-6098    [001] .....  1186.026372: page_fault_user: addr=0xaaab04330098 pc=0xffffa411be68 esr=0xaaab04330098
>              cat-6126    [000] .....  1186.026394: page_fault_user: addr=0xaaaad22ef420 pc=0xaaaad22ef420 esr=0xaaaad22ef420
>              cat-6126    [000] .....  1186.026414: page_fault_user: addr=0xaaaad23ee9b0 pc=0xaaaad22ef424 esr=0xaaaad23ee9b0
>              cat-6126    [000] .....  1186.026426: page_fault_user: addr=0xffffa40c3110 pc=0xffffa40c3110 esr=0xffffa40c3110
>              cat-6126    [000] .....  1186.026450: page_fault_user: addr=0xaaaad22f23f8 pc=0xaaaad22f23f8 esr=0xaaaad22f23f8
>              cat-6126    [000] .....  1186.026467: page_fault_user: addr=0xaaaad23f0030 pc=0xaaaad22f240c esr=0xaaaad23f0030
>              cat-6126    [000] .....  1186.026481: page_fault_user: addr=0xaaaad23fae3c pc=0xaaaad231be40 esr=0xaaaad23fae3c
>              cat-6126    [000] .....  1186.026530: page_fault_user: addr=0xffffa40d63d8 pc=0xffffa40d63d8 esr=0xffffa40d63d8
>              cat-6126    [000] .....  1186.026554: page_fault_user: addr=0xffffa431f650 pc=0xffffa40d63f8 esr=0xffffa431f650
>               sh-6098    [001] .....  1186.026556: page_fault_user: addr=0xaaab04358d28 pc=0xffffa411be70 esr=0xaaab04358d28
>              cat-6126    [000] .....  1186.026571: page_fault_user: addr=0xaaaad24015d0 pc=0xffffa40d640c esr=0xaaaad24015d0
>              cat-6126    [000] .....  1186.026600: page_fault_user: addr=0xaaaad2332be8 pc=0xaaaad2332be8 esr=0xaaaad2332be8
>              cat-6126    [000] .....  1186.026703: page_fault_user: addr=0xffffa416c438 pc=0xffffa416c438 esr=0xffffa416c438
>               sh-6098    [001] .....  1186.026749: page_fault_user: addr=0xaaab04369d70 pc=0xffffa41193d8 esr=0xaaab04369d70
>              cat-6126    [000] .....  1186.027610: page_fault_user: addr=0xaaaad2307754 pc=0xaaaad2307754 esr=0xaaaad2307754
>              cat-6126    [000] .....  1186.027711: page_fault_user: addr=0xaaaad24014c4 pc=0xaaaad23310e4 esr=0xaaaad24014c4
>              cat-6126    [000] .....  1186.027892: page_fault_user: addr=0xaaab04359a80 pc=0xaaaad23052f0 esr=0xaaab04359a80
>              cat-6126    [000] .....  1186.027916: page_fault_user: addr=0xaaaad236cf80 pc=0xaaaad236cf80 esr=0xaaaad236cf80
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  arch/arm64/include/asm/trace/common.h     | 12 +++++
>  arch/arm64/include/asm/trace/exceptions.h | 54 +++++++++++++++++++++++
>  arch/arm64/kernel/Makefile                |  1 +
>  arch/arm64/kernel/tracepoint.c            | 24 ++++++++++
>  arch/arm64/mm/Makefile                    |  3 ++
>  arch/arm64/mm/fault.c                     | 19 ++++++++

We already report page faults via perf (see the calls to perf_sw_event()),
so why isn't that sufficient?

Will
