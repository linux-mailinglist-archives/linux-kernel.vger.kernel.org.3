Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0333255D60C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243931AbiF1EAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243898AbiF1EAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3474429836
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 21:00:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFB8B616AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8086C3411D;
        Tue, 28 Jun 2022 03:59:58 +0000 (UTC)
Date:   Mon, 27 Jun 2022 23:59:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Message-ID: <20220627235957.78aed6cd@gandalf.local.home>
In-Reply-To: <20220624190819.59df11d3@rorschach.local.home>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
        <20220616113400.15335d91@gandalf.local.home>
        <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
        <20220617155019.373adda7@gandalf.local.home>
        <3BAD2CD9-3A34-4140-A28C-0FE798B83C41@oracle.com>
        <355D2478-33D3-4046-8422-E512F42C51BC@oracle.com>
        <20220624190819.59df11d3@rorschach.local.home>
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

On Fri, 24 Jun 2022 19:08:19 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 20 Jun 2022 00:57:23 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
> 
> > > Yes, I'm sure. I just checked out v5.18 and built it with the
> > > same CONFIG. trace_printk() on that kernel generates function
> > > names as expected.    
> > 
> > I moved my development work to another system, and bisected. The
> > result:
> > 
> > 91fb02f31505 ("module: Move kallsyms support into a separate file")  
> 
> Hmm, right below that it says:
> 
>    "No functional change."
> 
> I'm guessing it may not be as reliably reproducible.

I take this back. I bisected it down to this commit as well.

I found another patch in that series that has a function change, so I do
not trust this. This most definitely has a functional change, as the output
of kallsyms changes with it. I'll report it against that patch submission.

-- Steve


> 
> And is this an issue with trace-cmd output or reading the trace file?

