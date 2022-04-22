Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755CD50BC00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449398AbiDVPsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449378AbiDVPsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:48:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449DE5D64B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00F94B830D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608ABC385A8;
        Fri, 22 Apr 2022 15:45:43 +0000 (UTC)
Date:   Fri, 22 Apr 2022 11:45:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <20220422114541.34d71ad9@gandalf.local.home>
In-Reply-To: <YmJ/l4vJoEpFt68l@FVFF77S0Q05N>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
        <20220316100132.244849-4-bobo.shaobowang@huawei.com>
        <YmFXrBG5AmX3+4f8@lakrids>
        <20220421100639.03c0d123@gandalf.local.home>
        <YmF0xYpTMoWOIl00@lakrids>
        <20220421114201.21228eeb@gandalf.local.home>
        <YmGF/OpIhAF8YeVq@lakrids>
        <20220421130648.56b21951@gandalf.local.home>
        <YmJ/l4vJoEpFt68l@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 11:12:39 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> As an aside, I'd also love to remove the REGS/!REGs distinction, and always
> save a minimum amount of state (like ARGS, but never saving a full pt_regs),
> since on arm64 the extra state stored for the REGS case isn't useful (and we
> can't reliably capture all of the pt_regs state anyway, so bits of it are made
> up or not filled in).

Note, the reason for the addition of REGS was a requirement of kprobes.
Because before ftrace, kprobes would be triggered at the start of a
function by a breakpoint that would load in all the regs. And for backward
compatibility, Masami wanted to make sure that kprobes coming from ftrace
had all the regs just like it had when coming from a breakpoint.

IIUC, kprobes is the only reason we have the "regs" variant (all other use
cases could get by with the ARGS version).

-- Steve
