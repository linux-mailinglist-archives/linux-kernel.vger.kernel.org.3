Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93E14D6A79
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiCKXQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiCKXQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:16:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB0DD3AC7;
        Fri, 11 Mar 2022 15:15:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D31DB80E9F;
        Fri, 11 Mar 2022 23:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A591CC340E9;
        Fri, 11 Mar 2022 23:15:02 +0000 (UTC)
Date:   Fri, 11 Mar 2022 18:15:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org
Subject: Re: [next] arm64: allmodconfig: kernel BUG at
 include/linux/page-flags.h:509
Message-ID: <20220311181500.0be31225@gandalf.local.home>
In-Reply-To: <20220311181328.GA1904@kbox>
References: <CADYN=9+xY5Vku3Ws5E9S60SM5dCFfeGeRBkmDFbcxX0ZMoFing@mail.gmail.com>
        <20220311112426.7e3cf434@gandalf.local.home>
        <20220311171123.GA1675@kbox>
        <20220311130453.54a4e0b2@gandalf.local.home>
        <20220311181328.GA1904@kbox>
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

On Fri, 11 Mar 2022 10:13:28 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Is that true as well for the user process that has this mapped? Will the
> user process virtual memory that maps to this ever page it out? I
> believe that was the concern. My understanding is by reserving in
> kernel, even though it won't page out on that side, marks the user side
> entry to not let it page out.

My memory of the purpose of SetPageReserve() is a bit fuzzy, and there's
not much use of it in the kernel. Just a hand full. I'll try to investigate
it some more.

> 
> The other thing is that this patch applied to 5.10.X on ARM64 does not
> appear to hit this. Is it some weird interaction with something else or
> was 5.10.X just getting lucky?

Perhaps it's because you allocated the page with kzalloc and not just
getting a page directly?

Again, my knowledge in this area is lacking. I'm looking more into it.

-- Steve
