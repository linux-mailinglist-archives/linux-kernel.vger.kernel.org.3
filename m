Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4587520476
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbiEIS0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240214AbiEIS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:26:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D2250E32
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 247D3B818E4
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 18:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DCBC385B2;
        Mon,  9 May 2022 18:22:05 +0000 (UTC)
Date:   Mon, 9 May 2022 14:22:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <20220509142203.6c4f2913@gandalf.local.home>
In-Reply-To: <20220505121538.04773ac98e2a8ba17f675d39@kernel.org>
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

On Thu, 5 May 2022 12:15:38 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> OK. But my interest is that the ftrace on arm64 can provide a limited
> access to registers via pt_regs or not. I don't mind the contained values
> so much because in the most case, 'users' will (most likely) access to the
> ARGs via BPF or tracefs (and we can just warn users if they try to access
> the registers which is not saved.) But if the arm64 ftrace only provides
> a special data structure, arch-independent code must have 2 different access
> code. That is inefficient. That is my concern.
> IOW, I'm interested in interface abstraction.

Note, ftrace now has a ftrace_regs structure that is passed to the
callbacks for the function tracer.

It then has an arch dependent helper function ftrace_get_regs(fregs), that
returns a pt_regs from the fregs only if the fregs has a full pt_regs to
return. If not, it returns NULL.

This was suggested by both Peter Zijlstra and Thomas Gleixner when I
introduced FTRACE_WITH_ARGS, where all functions can now get the arguments
from fregs, but not the full pt_regs. If a ftrace_ops has the REGS flag set
(using ftrace_regs_caller), the ftrace_get_regs(fregs) will return the
pt_regs, or it will return NULL if ftrace_regs_caller was not used.

This way the same parameter can provide full pt_regs or a subset, and have
an generic interface to tell the difference.

-- Steve
