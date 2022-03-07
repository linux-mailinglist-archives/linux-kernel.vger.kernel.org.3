Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364544D000C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiCGN3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCGN3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:29:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6515B36B69
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:28:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FDC0B81243
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 13:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E997C340F3;
        Mon,  7 Mar 2022 13:28:52 +0000 (UTC)
Date:   Mon, 7 Mar 2022 08:28:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ftrace bug
Message-ID: <20220307082850.0278e961@gandalf.local.home>
In-Reply-To: <8bf3ddb5-e9fc-dcc9-ad7d-1677334f6386@broadcom.com>
References: <9a86b2c9-1009-1683-442e-61c5a7dc8cf3@broadcom.com>
        <8bf3ddb5-e9fc-dcc9-ad7d-1677334f6386@broadcom.com>
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

On Mon, 7 Mar 2022 13:00:05 +0100
Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> On 3/7/2022 12:26 PM, Arend van Spriel wrote:
> > Hi Steven,
> > 
> > I wanted to use FTRACE on an ARM platform and I hit the following 
> > warning which results in ftrace bug. This happens upon loading a module. 
> > Looking up the warning I suspect the branch target is too far off. The 
> > module is quite large and therefor not loaded in the modules section. Is 
> > there a way to exclude a module. In ftrace_module_init I see a check for 
> > !mod->num_ftrace_callsites. Is there a way to avoid creating ftrace 
> > callsites in a module?  
> 
> Could it be accomplished by this?
> 
> CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
> 

You mean with something other than "lockdep.o".

You can do that to remove all ftrace callers from the .o file.

You could add the problem functions with "notrace" (which you should be
able to see what functions those were from the ftrace_bug output after the
"cut here").

You could keep an entire directory from having ftrace to it with:

ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)

in the make file for that directory, and it will remove it totally.

But this should be considered a work around, by removing this, you lose all
the functionality you get with ftrace (tracing, ebpf attachments, and live
patching).

-- Steve

