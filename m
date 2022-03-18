Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8CA4DD3FC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 05:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiCREmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 00:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiCREmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 00:42:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8166D2AA852
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 21:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E5BB0CE247E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 04:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3E2C340E8;
        Fri, 18 Mar 2022 04:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647578460;
        bh=Pzb4wO6iDHHWxXmW2gHDzPoirgP7sfeBSmWcMBaW6kk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t1i1oYJroEpeLwzRvslpeCf6axg+L1lqBqJkduu19PXVfEviT1CU90ngjXVHoSmfD
         s/5YuH1P3uJ4em89vdfaI+J57q1WIjCrqyX3snPGQVjjsu028ZKommmEoAWCQVQylb
         C7/I7xsG2qdxfj0yoN7J9l/kqaiUAYlNFLV+uY7OXoMYVWjyqm+RF2bK03DsxJaKaT
         ft9w7Rb7Yw9zoJW53Ark7fGA77VWQrf7Xg20mopr9ZqcQiKrvGNrcyhItFEEdgTCVU
         5FF9kZnPi94cgOtWtD//E+sTyC9D04BIYzQLRxrVPZBXNJVqfrKWfj846GZjTnBdYa
         2vopThRqbhOvw==
Date:   Fri, 18 Mar 2022 13:40:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 03/13] fprobe: Add ftrace based probe APIs
Message-Id: <20220318134054.0fbbbdcd677c1e39a283cf43@kernel.org>
In-Reply-To: <CAADnVQJSZhJo5XK-h6t8oHuNtiPxYx9Zjav=wvm92m-cpTpghw@mail.gmail.com>
References: <20220317152458.213689956@goodmis.org>
        <20220317152522.284233550@goodmis.org>
        <CAEf4BzaN_HnyAkVYeUmYoxvW01cFKR2FW0MwZJBL3gvkRw0TYg@mail.gmail.com>
        <20220317194937.08584828@gandalf.local.home>
        <CAADnVQJSZhJo5XK-h6t8oHuNtiPxYx9Zjav=wvm92m-cpTpghw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2022 17:26:23 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Thu, Mar 17, 2022 at 4:49 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 17 Mar 2022 15:03:33 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > Do I understand correctly that this patch set was applied in your
> > > tree? I was under the impression that we agreed to route this through
> > > the bpf-next tree earlier (see [0]), but I might have misunderstood
> > > something, sorry.
> > >
> > > Either way, the reason it matters is because Jiri's multi-attach
> > > kprobe patch set ([1]) is depending on Masami's patches and having
> > > fprobe patches in bpf-next tree would simplify logistics
> > > significantly.
> >
> > I knew Jiri's patches were to go through the bpf tree, but I missed that
> > those were dependent on this and you wanted these to go through as well.
> >
> > I had just finished my automated tests that ran these patches. I haven't
> > pushed them to my next branch yet so I can hold them off. I don't have
> > anything dependent on them.
> 
> Excellent. Thanks for testing.
> 
> > Would you be able to take these for-next patches directly (as they all have
> > been tested) and you can switch my signed-off-by to Reviewed-by.
> >
> > The first of the series is unrelated and will go through my tree. That's
> > the user_events patch.
> 
> Right.
> We're talking about this set:
> https://patchwork.kernel.org/project/netdevbpf/cover/164735281449.1084943.12438881786173547153.stgit@devnote2/
> 
> I believe it has a small doc difference vs what you've tested.
> Looks like our CI is green on it too.
> We'll do additional testing and add your SOB and Tested-by
> before pushing.

Thanks Alexei and Steve, I think this fprobe series is good to go through
bpf-next tree because it is currently used only from bpf with Jiri's patch.
Sorry Steve for confusion. I think I might better move you to CC when I
tagged it 'bpf-next'.

Thank you,

> 
> Thanks!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
