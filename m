Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B299A5511F4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbiFTH45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbiFTH4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:56:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B1510559
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 41A68CE1072
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D10AC3411B;
        Mon, 20 Jun 2022 07:56:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="OO9aB5fr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655711809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLwanBwq7MBlBiCW9Kg31t0HsMYeyEvH548H515apIk=;
        b=OO9aB5frM8qnScFyt+bd1Wgi+/zjDDh38IPz8GFRAOvXhPFchE3ZGE0qSWNkfLOteYDLUB
        xyw3aLbSk4Fn86onSo/mpC1TN3JBAOYnsuSLWVrN5wEMaI1OzwWLz23H7JJzTvdqC2M+wC
        RNSvkuSRfh4RuS6T3boIN9b9/9ZCDnc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 49c4cd10 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 20 Jun 2022 07:56:48 +0000 (UTC)
Date:   Mon, 20 Jun 2022 09:56:47 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] printk: allow direct console printing to be enabled
 always
Message-ID: <YrAoP+UVAKsLlnQQ@zx2c4.com>
References: <Yq+Jjoyn/wj7yzeQ@zx2c4.com>
 <20220619204326.556923-1-Jason@zx2c4.com>
 <87letsw8en.fsf@jogness.linutronix.de>
 <YrAC8F8lDc1JNkoq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrAC8F8lDc1JNkoq@google.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Mon, Jun 20, 2022 at 02:17:36PM +0900, Sergey Senozhatsky wrote:
> On (22/06/20 01:23), John Ogness wrote:
> > I'm wondering if we should output a message here. My suggestion is:
> > 
> > pr_info("printing threads disabled, using direct printing\n");
> > 
> > > +		return 0;
> > > +
> > >  	console_lock();
> > >  	printk_kthreads_available = true;
> > >  	for_each_console(con)
> > 
> > Otherwise it looks OK to me. But you may want to wait on a response from
> > Petr, Sergey, or Steven before sending a v3. You are adding a kernel
> > config and a boot argument. Both of these are sensitive topics that
> > require more feedback from others.
> 
> A tricky situation. I think John already mentioned in another thread
> that any such config/boot param potentially can become a default value
> for some setups; at the same time, well, yeah, I see what commit message
> talks about.

Moving it into the debug section of kconfig hopefully sends the right
message there. Plus the help text makes it clear there are performance
implications and such.

Jason
