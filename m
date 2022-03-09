Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A924D2A46
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiCIICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiCIIC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:02:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF16169200
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:01:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B87A60F26
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C027C340EE;
        Wed,  9 Mar 2022 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646812887;
        bh=v3kCSOlPYnjQWLgSvNmxaNEN5wv4j9rO5qcLBkRkMHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cDTY3XffBbD3A8QDjhNkD5yGc9ypqwpzzem4gW/Zd+oxcSuK8A5w/OrorKIxvhTLS
         JvsZslWk7G6hy+OI/3rC9P7I+ln0NweMjX2ClnC+sDiMnkqjoT5dUVlcrr4MEXT5+d
         COJ861hGPcAqeMT6xcirRBlbGwSYspIQrRBm/0L0QzISG4dEFE5gv5yZ7o2zx+QehK
         I9O6JDgw7f+sFTTdQmwppzb0zJxrE5slb25ewrK+PNgVbFEhn7xz04lun+WI+pVAE2
         uqtH70VBH/YqgZNr5tK/p+5lIORy1FlZRguXWPdekBuMrSHA8JMbZa5phEm6Rb7AqC
         usSm+biJJvGTw==
Date:   Wed, 9 Mar 2022 17:01:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: tracing : bootconfig : Early boot config for non intrd systems
Message-Id: <20220309170124.82dcfadbcda6f8ab6ed51797@kernel.org>
In-Reply-To: <20220308174829.GA2471@pswork>
References: <20220307184011.GA2570@pswork>
        <20220308163600.3109f19854c7b051924f262b@kernel.org>
        <20220308174829.GA2471@pswork>
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

On Tue, 8 Mar 2022 18:48:29 +0100
Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:

> Hello Masami Hiramatsu,
> 
> On Tue, Mar 08, 2022 at 04:36:00PM +0900, Masami Hiramatsu wrote:
> > Hello Padmanabha,
> > 
> > On Mon, 7 Mar 2022 19:40:11 +0100
> > Padmanabha Srinivasaiah <treasure4paddy@gmail.com> wrote:
> > 
> > > Hello Masami Hiramatsu,
> > > 
> > > Thanks for detailed explanation on boot time tracing using early boot configuration file.
> > > https://linuxfoundation.org/wp-content/uploads/boottrace-LF-live-2021-update.pdf
> > > 
> > > Also for https://lwn.net/Articles/806002/.
> > > 
> > > Latter link also states we can embed boot config into the kernel image for non intrd based system.
> > 
> > Ah, that was an original plan, but since no one interested in, I didn't implement it.
> > So we still need the initrd for bootconfig.
> >
> Ok.
> > > 
> > > I tried searching mailing lists not able to find pointer for same.
> > > 
> > > A hint/pointer on how-to will be very helpful. 
> > 
> > BTW, what is your problem, could you share your use-case?
> > 
> 
> I have hetrogenous system which donot use intrd.
> 
> The use-case is to capture __system wide__ event based tracing for
> boot-up sequence, which also covers early stage of default init programs
> used.
> 
> As buffer size is limited, will have hand-picked events set configured.

Hm, so I guess you will boot linux from your custom bootloader (or binary loader on sub processor?).

Can you even try to add a dummy initrd? or are you OK to rebuild kernel for embedding the bootconfig data?
If both don't work, the solution will be architecture or bootloader specific.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
