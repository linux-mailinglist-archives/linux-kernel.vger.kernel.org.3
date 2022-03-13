Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF0A4D7404
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 10:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiCMJlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiCMJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 05:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA48712F166
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 01:40:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A15260FCB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510E0C340E8;
        Sun, 13 Mar 2022 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647164442;
        bh=yN+bM3PjYMladZwdjGcofNA5/OEc+f2QdWCFqlFvN0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rpu0Wz/R7h9ldgtZ1sYhwzOjzOAIfWtBz+8vkwrm9hoNwGPN6S+SikQsGBywsiM0t
         dd0cZYEHF8fAqR7/ZoNvVBbzOJF7LlQ5u2GA1WkxIjBa19YVuELfoA328ehtk+dznO
         STSVEwTxPuHA7ltrZAUQ3dx8kTFLvVDLBQ/4GpfH2YJ3rkj0qmNKPIOst9lnodFy0B
         9EXeB/+gOkAta9gQa7zGQU9hWrV0vjPZ7FYCdUvKZav2eJJwLEzf3Ykxto8zkta9OY
         wgjEg+fjqdkUwEwvCA7IK8CvIZxMYZ4jQjPVEzuPJf1yyx9Hhb9WS7WWS0x61hfb8+
         n4pu8lSTrH60Q==
Date:   Sun, 13 Mar 2022 18:40:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: tracing : bootconfig : Early boot config for non intrd systems
Message-Id: <20220313184038.a82969517f8c0eb0d1ecfcfb@kernel.org>
In-Reply-To: <20220313164857.cdd7aa7d7977bfff6c91fdff@kernel.org>
References: <20220307184011.GA2570@pswork>
        <20220308163600.3109f19854c7b051924f262b@kernel.org>
        <20220308174829.GA2471@pswork>
        <20220309170124.82dcfadbcda6f8ab6ed51797@kernel.org>
        <20220309190651.GA3735@pswork>
        <20220312155358.d6bc78866f4ca31e9a37e23a@kernel.org>
        <20220312101524.5d23c258@rorschach.local.home>
        <20220312101606.41a9fc64@rorschach.local.home>
        <20220313164857.cdd7aa7d7977bfff6c91fdff@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022 16:48:57 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Sat, 12 Mar 2022 10:16:06 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Sat, 12 Mar 2022 10:15:24 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Sat, 12 Mar 2022 15:53:58 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > 
> > > > OK, please try below patch. You can embed your bootconfig in the kernel via
> > > > CONFIG_EMBED_BOOT_CONFIG_FILE.
> > > > 
> > > >   
> > > > >From 7478a8fbfe4669ee61fcb12b85b36d7e36f992ba Mon Sep 17 00:00:00 2001    
> > > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Date: Sat, 12 Mar 2022 14:59:30 +0900
> > > > Subject: [PATCH] bootconfig: Support embedding a bootconfig file in kernel  
> > > 
> > > I'm going to try this out, because there was a few times I could have
> > > used this.
> > > 
> > 
> > Oh, and can you send this as a separate patch so that it triggers my
> > scripts?
> 
> OK, let me clean it up and add a document how to use it.

I found that the current patch causes a build error with allyesconfig.
I think I need to check CONFIG_EMBED_BOOT_CONFIG_FILE in Makefile and
copy it to default.bconf file.
Let me try to fix it.

Thank you,

> 
> Thank you,
> 
> > 
> > Thanks,
> > 
> > -- Steve
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
