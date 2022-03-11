Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416B44D6843
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350357AbiCKSGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbiCKSGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:06:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307E81B0BC0;
        Fri, 11 Mar 2022 10:04:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5128B80EA4;
        Fri, 11 Mar 2022 18:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDDAC340E9;
        Fri, 11 Mar 2022 18:04:54 +0000 (UTC)
Date:   Fri, 11 Mar 2022 13:04:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org
Subject: Re: [next] arm64: allmodconfig: kernel BUG at
 include/linux/page-flags.h:509
Message-ID: <20220311130453.54a4e0b2@gandalf.local.home>
In-Reply-To: <20220311171123.GA1675@kbox>
References: <CADYN=9+xY5Vku3Ws5E9S60SM5dCFfeGeRBkmDFbcxX0ZMoFing@mail.gmail.com>
        <20220311112426.7e3cf434@gandalf.local.home>
        <20220311171123.GA1675@kbox>
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

On Fri, 11 Mar 2022 09:11:23 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> Maybe I am mistaken, but I remember reading in the case of a kernel
> allocated page shared with user space they must be reserved. It was
> stated that the PTE may not know the PFN belongs to user or kernel.
> 
> If this is not the case, I don't see why we couldn't allocate zero'd
> pages as you describe. We just need to make sure we don't crash user
> processes touching the page if it does get paged out (and ideally not
> slow down their execution).

Anything allocated by the kernel via alloc_page() will never be paged out.
As the kernel may use it in any location (including NMIs). The ftrace ring
buffer allocates its pages this way.

Now if you were mapping some file system page, then that would be a
different story.

-- Steve
