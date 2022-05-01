Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCB15168DF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 01:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356022AbiEAXgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 19:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEAXgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 19:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE1B289A4
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 16:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B77C96115E
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 23:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFDAC385A9;
        Sun,  1 May 2022 23:32:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oQ3jQi7X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651447960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GE6lZAjesmjb+aem5YmC+Z3tKQktFTDOlomcr8HArSs=;
        b=oQ3jQi7XvL1V4/lwH/aLGh/c62AoxCXzS13M6lFSJsh5KhSJE0j8ojXkbUwBmtm15Ikchx
        nf8W3hk72pVZ+8oURMcxvCZTXBS+ERJzmCjHAY9NbPsbPzLIjsYNgHKQZfyAbmFwZ1BJiI
        dS/aI02NJJxbYtt+k6M1E+fF8oLmgEo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7f4ae49c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 1 May 2022 23:32:39 +0000 (UTC)
Date:   Mon, 2 May 2022 01:32:37 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Changes in kernel 5.18-rc1 leads to crashes in VirtualBox
 Virtual Machines
Message-ID: <Ym8YlXYM4HQg8tq7@zx2c4.com>
References: <7f01221d-f693-adf8-f5a5-d71944b44162@lwfinger.net>
 <Ym7Hw9GDPP838JoH@zx2c4.com>
 <6bd35831-2d7a-77ee-55e9-755ca752b0c8@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6bd35831-2d7a-77ee-55e9-755ca752b0c8@lwfinger.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

On Sun, May 01, 2022 at 04:07:39PM -0500, Larry Finger wrote:
> 1. Yes, the problem happens with 5.18-rc4 and -rc5.

Do you still have your bisection logs handy? Something about this seems
a bit fishy to me, and it might be helpful.

> 2. My answer here will be incomplete. There are no stacktraces or console ouput 

You're going to have to make it more complete somehow...

> on the host from any of the guest crashes, either in dmesg or under journalctl. 
> The desktop just disappears. The VirtualBox log files show nothing for the Linux 

What do you mean "just disappears"? What is the "desktop"? Do you mean
that the X server segfaults or something? Can you attach a debugger
somewhere and try again? There's got to be something you can do to get
more info.

> guest, and the following for the Windows instance:
> 
> 00:00:57.908011 GUI: UIMachineLogicNormal::sltCheckForRequestedVisualStateType: 
> Requested-state=0, Machine-state=5
> 00:01:24.502961 GIM: HyperV: Guest indicates a fatal condition! P0=0x1e 
> P1=0xffffffffc0000005 P2=0xfffff8054c61e97c P3=0x0 P4=0x28
> 00:01:24.503053 GIMHv: BugCheck 1e {ffffffffc0000005, fffff8054c61e97c, 0, 28}
> 00:01:24.503054 KMODE_EXCEPTION_NOT_HANDLED
> 00:01:24.503054 P1: ffffffffc0000005 - exception code - STATUS_ACCESS_VIOLATION
> 00:01:24.503054 P2: fffff8054c61e97c - EIP/RIP
> 00:01:24.503054 P3: 0000000000000000 - Xcpt param #0
> 00:01:24.503054 P4: 0000000000000028 - Xcpt param #1
> 
> Running a 3rd party dump analyzer shows that the crash happens at 
> ntoskrnl.exe+3f7d50. I have installed the Windows debugger, but I think the 
> learning curve will be steep. At this point, I have no further info available.

Can you email me the minidump files from the crash? In another life
that's not supposed to intersect with lkml, windbg keeps me up at
night...

Also, if you've got some easy steps at repro, that'd be helpful. If I
have to install OpenSUSE in a VM or something and type some commands and
twiddle things here and there, let me know what it takes to get an
environment going. Or, better, if you've got a VM already baked with vbox
installed in it with a VM inside of that that exhibits the issue, that'd
let me take a look.

Jason
