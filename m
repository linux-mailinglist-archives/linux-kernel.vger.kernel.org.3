Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1215ADCE6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiIFBaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiIFBa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:30:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FF8647C6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 18:30:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4FBAB815AE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775E5C433C1;
        Tue,  6 Sep 2022 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662427823;
        bh=2k5Cf0hW3tgV+89sebcqyCh1W3nfzEd+bh/IzTIAxbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kzihkAXHcCDK0QFtMnv3oRGa65bDVQGbIW11SiWsBVaHQtcZQb5xQZZ4yN9LOnf6f
         fY2shsKIB9m+RZokDSLSbddDf+2uc4ygODww5Pcqx/2GWcpw6e440vNNWlVlmFCzW/
         CLBlXjgjdEP0nlU4aWrOoqxVvRMPyLB+Bc0IXMtCrnwxXNyhUssakBjjlQDkCRpxWX
         hIl7QvnrAzln+7094yOG0IsMnkkOFqw1TLE4jS0zp4UNBKZDepimuICbXiS97WbHH+
         i8b+wyZP7nB0b2oraymdKBJsVb9TXWRQh7XcSQczS37JFBs3fW1GG7dkxUNEzENAI4
         ZzGXWiWQ+tQPA==
Date:   Tue, 6 Sep 2022 10:30:18 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: CONFIG_RETHUNK int3 filling prevents kprobes in function body
Message-Id: <20220906103018.50f46e8c21c4a40b2d635c75@kernel.org>
In-Reply-To: <YxYTvgTqRP0GMAjO@hirez.programming.kicks-ass.net>
References: <20220904230713.a461f8fe85329663226c755f@kernel.org>
        <20220905105758.176734eb@gandalf.local.home>
        <YxYRYwZ/zYO+u1ij@hirez.programming.kicks-ass.net>
        <YxYTvgTqRP0GMAjO@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2022 17:20:30 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Sep 05, 2022 at 05:10:27PM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 05, 2022 at 10:57:58AM -0400, Steven Rostedt wrote:
> > > On Sun, 4 Sep 2022 23:07:13 +0900
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > 
> > > > Can we use another instruction for padding instead of INT3? (e.g. NOP or UD2)
> > > > 
> > > > Or, can I expect the instruction length in __return_sites[] are always 5?
> > > > If so, I can just skip 5 bytes if the address is in __return_sites[].
> > > 
> > > Perhaps another option is to have a table of where the padding is placed
> > > (tagged), and that kprobes could check to see if the int3 is due to this
> > > padding or not?
> > 
> > I don't see need for that. If you want to be strict you can simply
> > follow the branches found earlier, if you want to be lazy, you can
> > decode until you run out of the symbol size.
> 
> Another lazy option is to teach the thing that 'ret' is followed by 0,1
> or 4 'int3' instructions depending on CONFIG_SLS, CONFIG_RETHUNK, but
> that'll get you into trouble with future SLS compiler options, like the
> aforementioned JMP-SLS option.

Yes, I agree... OK, let me try to decode branches to find the
nearest earlier target instruction.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
