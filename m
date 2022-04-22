Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E1F50BAD0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449029AbiDVO5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449008AbiDVO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:57:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEBA5C668
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 876BCB83030
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABECDC385A0;
        Fri, 22 Apr 2022 14:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650639245;
        bh=gazOv3DHwz5/g5JU36t4tIR2wD/+rqURHYT+c9grBjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jdrTK4BP6WS6eTnapdtlekyzr2kPvRmHd4xjE6QmL9lvdgzoMPDSBsTndO/SPJSa1
         fpvdhADnIXcgRe3oUjcjgahGJ8oNVN8qWj2GZg1VyMgtxq5J7CafT6nGvR9WMoRrKt
         x/+2+dGmjArLMR7r9W08M/dm8suQPbYpJTHNUMxPHH2QkNk6EOocg1zFfn0S9IYxzk
         uWQd5ZB7MXHVJoe0WWVkShKaVMCr83mtuBqGThDiyY54OuJ5XEIfumpJV3JQD2JoVX
         XbaXttMeQce57NIMegC5F1HAniBSaMbWxZ4wAqg/yRqdD+Y1mvoANBGW5ACnQO7wiX
         iT4KmxjIKiJ5w==
Date:   Fri, 22 Apr 2022 23:54:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Adam Zabrocki <pi3@pi3.com.pl>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Solar Designer <solar@openwall.com>
Subject: Re: [PATCH] x86/kprobes: Fix KRETPROBES when
 CONFIG_KRETPROBE_ON_RETHOOK is set
Message-Id: <20220422235401.a3ece3ed2b008dc790cdb6e2@kernel.org>
In-Reply-To: <20220422094350.2397cd2d@gandalf.local.home>
References: <20220415180723.GA13921@pi3.com.pl>
        <20220415181006.GA14021@pi3.com.pl>
        <20220422220523.bbad0538ef69b81cc7befe2a@kernel.org>
        <20220422094350.2397cd2d@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 09:43:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 22 Apr 2022 22:05:23 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > Can you pick this fix to urgent branch? Or Should I ask bpf people?
> 
> It looks to fix a bug from a commit pulled in from the BPF folks. I would
> have them take it.

OK, thanks!

Adam, can you resend your patch with my Ack and modify the PATCH tag as
"[PATCH bpf]", to "Alexei Starovoitov <ast@kernel.org>", "Andrii Nakryiko <andrii@kernel.org>",
 and Cc: "bpf@vger.kernel.org" ? 

Thank you,

> 
> Thanks,
> 
> -- Steve
> > 
> > > Fixes: 73f9b911faa7 ("kprobes: Use rethook for kretprobe if possible")


-- 
Masami Hiramatsu <mhiramat@kernel.org>
