Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9422A52105C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbiEJJOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbiEJJOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:14:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447942555BB
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 02:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 688AD614E1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 09:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267ACC385A6;
        Tue, 10 May 2022 09:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652173817;
        bh=GXpVDYbkF84LLdJ5bx4YwYoSn9Krmcs/u8uVEyFBHiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oLb653JNx2KBVbvxGYK7oIFvppbFBTPIYSJD85hFi0sCGzZ1akOP6cPOLeqVNVLjf
         GLBNMceSMifw+ciRgtuIiZn0keibYMP1pMVYnR8HY4fjLkGHijzfBfdPgUWwDBn4b9
         0/3/bvyL6OXPJgxD5cn7/81QNgOSCuEXc+ceYs8g7dGbVfE04bi2zMd2Gs7DGNDWkc
         6fYkMlfUr9ckP7s1qG1kHlkcT3c+wVO5K2B5vS7zwIL2kAlgi2mu6phelLWTwM6mVZ
         uVvdtlvolPNog6AqZ+S11H1LQsVrxO5YHSTo/n0do/5r45zuhHxbk4qC+56zWo55qN
         58h8zSW774MTg==
Date:   Tue, 10 May 2022 18:10:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-Id: <20220510181012.d5cba23a2547f14d14f016b9@kernel.org>
In-Reply-To: <20220509142203.6c4f2913@gandalf.local.home>
References: <YmFXrBG5AmX3+4f8@lakrids>
        <20220421100639.03c0d123@gandalf.local.home>
        <YmF0xYpTMoWOIl00@lakrids>
        <20220421114201.21228eeb@gandalf.local.home>
        <YmGF/OpIhAF8YeVq@lakrids>
        <20220421130648.56b21951@gandalf.local.home>
        <YmJ/l4vJoEpFt68l@FVFF77S0Q05N>
        <20220422114541.34d71ad9@gandalf.local.home>
        <YmLlmaXF00hPkOID@lakrids>
        <20220426174749.b5372c5769af7bf901649a05@kernel.org>
        <YnJUTuOIX9YoJq23@FVFF77S0Q05N>
        <20220505121538.04773ac98e2a8ba17f675d39@kernel.org>
        <20220509142203.6c4f2913@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 9 May 2022 14:22:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 5 May 2022 12:15:38 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > OK. But my interest is that the ftrace on arm64 can provide a limited
> > access to registers via pt_regs or not. I don't mind the contained values
> > so much because in the most case, 'users' will (most likely) access to the
> > ARGs via BPF or tracefs (and we can just warn users if they try to access
> > the registers which is not saved.) But if the arm64 ftrace only provides
> > a special data structure, arch-independent code must have 2 different access
> > code. That is inefficient. That is my concern.
> > IOW, I'm interested in interface abstraction.
> 
> Note, ftrace now has a ftrace_regs structure that is passed to the
> callbacks for the function tracer.
> 
> It then has an arch dependent helper function ftrace_get_regs(fregs), that
> returns a pt_regs from the fregs only if the fregs has a full pt_regs to
> return. If not, it returns NULL.
>
> This was suggested by both Peter Zijlstra and Thomas Gleixner when I
> introduced FTRACE_WITH_ARGS, where all functions can now get the arguments
> from fregs, but not the full pt_regs.

Hmm, I thought the ftrace_get_regs() is the all-or-nothing interface, or
is there any way to get the arguments from fregs?

> If a ftrace_ops has the REGS flag set
> (using ftrace_regs_caller), the ftrace_get_regs(fregs) will return the
> pt_regs, or it will return NULL if ftrace_regs_caller was not used.
> 
> This way the same parameter can provide full pt_regs or a subset, and have
> an generic interface to tell the difference.

If it can provide a partial (subset of) pt_regs, that could be good for me
too, since at least kprobe-events on ftrace can check the traced register
is in the subset or not and reject it if it doesn't saved.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
