Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0540350BD36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449748AbiDVQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449943AbiDVQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:38:29 -0400
Received: from pi3.com.pl (pi3.com.pl [185.238.74.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBFD5EBC8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:35:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pi3.com.pl (Postfix) with ESMTP id 671254C15C8;
        Fri, 22 Apr 2022 18:35:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1650645330; bh=FO0yyrh9CoC+u1Lc94sRriq5qS8DXWjE4mxYlctLJzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kn9vC4ilOOjCoQXzWsaFyJswqtrdUZZ03/p7QDrYWh85CpUIcfS2WOeSkXML66BLv
         1d/Y+drQstpm6VUSy17TyVMaTj6+giizeRvWsjf0s4RnyKrcLMjyiPfWjwso9LLtZE
         RBWYwIzoBHuM8aJTrAHTKDQA0AxnyRXqr+vDKkJrbrAAtT71cjWvu2UYCkgEsAXgpk
         Lj0NBR/GZ9OWcqBSNUBk1yG7dId4Uj3P/qcbqq+kZcgtgARPvoJixX8rzAM5OXfxE2
         ha2MIVNb1C1tlzO7MToyrejzIPdEQ2VedzmVLICWm54mi2yIhVj20TnOi2PSKSYrW9
         AG4Wn7Kj1btyw==
X-Virus-Scanned: Debian amavisd-new at pi3.com.pl
Received: from pi3.com.pl ([127.0.0.1])
        by localhost (pi3.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6ZMQBYqF8TaA; Fri, 22 Apr 2022 18:35:27 +0200 (CEST)
Received: by pi3.com.pl (Postfix, from userid 1000)
        id 23CA24C11A3; Fri, 22 Apr 2022 18:35:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1650645327; bh=FO0yyrh9CoC+u1Lc94sRriq5qS8DXWjE4mxYlctLJzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tcuQLEOdCirJsBOUFgKeuxl0qGZcyni3BSn/j5Bu3+zKXE+J7qdBt6GxVLi5Mzcah
         M1DJWUBfutFQtLkEKhUJHznY8AnTG5JJ+PNNPuU8/qcn0yvkame8BvyK/7gRJDQAyZ
         GW59KTJrGe8YEsxc3lmj8wOSD3ocZSKAFC3CPiMuyN0LigG7nmRu5mP77Gfl7TTiOq
         lvwM1y6r1vqd4w6kFbhcyDG3seHUDxralAvhWnhXCqXw0+dWokBX/TzA2Q4TYVFsrx
         ViIarHtge01lZ46MGS/cbkR3IdmTpYh2eweqjgBYMIAjxDaVRMAwM9kYJuW1flkZS2
         lXyr5bvckL8QQ==
Date:   Fri, 22 Apr 2022 18:35:27 +0200
From:   Adam Zabrocki <pi3@pi3.com.pl>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Solar Designer <solar@openwall.com>
Subject: Re: [PATCH] x86/kprobes: Fix KRETPROBES when
 CONFIG_KRETPROBE_ON_RETHOOK is set
Message-ID: <20220422163527.GA7810@pi3.com.pl>
References: <20220415180723.GA13921@pi3.com.pl>
 <20220415181006.GA14021@pi3.com.pl>
 <20220422220523.bbad0538ef69b81cc7befe2a@kernel.org>
 <20220422094350.2397cd2d@gandalf.local.home>
 <20220422235401.a3ece3ed2b008dc790cdb6e2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220422235401.a3ece3ed2b008dc790cdb6e2@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sure, I will do it.

Thanks for help,
Adam

On Fri, Apr 22, 2022 at 11:54:01PM +0900, Masami Hiramatsu wrote:
> On Fri, 22 Apr 2022 09:43:50 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 22 Apr 2022 22:05:23 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Hi Steve,
> > > 
> > > Can you pick this fix to urgent branch? Or Should I ask bpf people?
> > 
> > It looks to fix a bug from a commit pulled in from the BPF folks. I would
> > have them take it.
> 
> OK, thanks!
> 
> Adam, can you resend your patch with my Ack and modify the PATCH tag as
> "[PATCH bpf]", to "Alexei Starovoitov <ast@kernel.org>", "Andrii Nakryiko <andrii@kernel.org>",
>  and Cc: "bpf@vger.kernel.org" ? 
> 
> Thank you,
> 
> > 
> > Thanks,
> > 
> > -- Steve
> > > 
> > > > Fixes: 73f9b911faa7 ("kprobes: Use rethook for kretprobe if possible")
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 
pi3 (pi3ki31ny) - pi3 (at) itsec pl
http://pi3.com.pl

