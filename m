Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA273533E18
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbiEYNnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiEYNnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:43:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A316D38F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D609FB81DA7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A261C385B8;
        Wed, 25 May 2022 13:43:09 +0000 (UTC)
Date:   Wed, 25 May 2022 09:43:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <20220525094307.1f1fb561@gandalf.local.home>
In-Reply-To: <Yo4eWqHA/IjNElNN@FVFF77S0Q05N>
References: <YmLlmaXF00hPkOID@lakrids>
        <20220426174749.b5372c5769af7bf901649a05@kernel.org>
        <YnJUTuOIX9YoJq23@FVFF77S0Q05N>
        <20220505121538.04773ac98e2a8ba17f675d39@kernel.org>
        <20220509142203.6c4f2913@gandalf.local.home>
        <20220510181012.d5cba23a2547f14d14f016b9@kernel.org>
        <20220510104446.6d23b596@gandalf.local.home>
        <20220511233450.40136cdf6a53eb32cd825be8@kernel.org>
        <20220511111207.25d1a693@gandalf.local.home>
        <20220512210231.f9178a98f20a37981b1e89e3@kernel.org>
        <Yo4eWqHA/IjNElNN@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 13:17:30 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> For arm64 I'd like to make this static, and have ftrace *always* capture a
> minimal set of ftrace_regs, which would be:
> 
>   X0 to X8 inclusive
>   SP
>   PC
>   LR
>   FP
> 
> Since X0 to X8 + SP is all that we need for arguments and return values (per
> the calling convention we use), and PC+LR+FP gives us everything we need for
> unwinding and live patching.
> 
> I *might* want to add x18 to that when SCS is enabled, but I'm not immediately
> sure.

Does arm64 have HAVE_DYNAMIC_FTRACE_WITH_ARGS enabled? If so, then having
the normal ftrace call back save the above so that all functions have it
available would be useful.

-- Steve

