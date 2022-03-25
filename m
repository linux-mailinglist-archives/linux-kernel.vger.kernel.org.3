Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE964E72C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358499AbiCYMMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345960AbiCYMMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0464BD4C89
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:11:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8ECF618F2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8737AC340E9;
        Fri, 25 Mar 2022 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648210261;
        bh=k425P4V7HyPF0scZcAaiy6OXeqX9yJ95TNKIlZKXKGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eMZF75ekPfhQ0rVdUQDCvurnR/7aNC7s8lMP9NQC/FAUwwC7SU81mn/azOy5D+XB7
         JJM3JNoIW2BJqToDwoSzw8mEOCLEknJcAVNMKpAbkZth4pl3bknOhSwk8/Dr5UjHVu
         ALtydUfiHX+tUs2WHypQ0f3hAG9ylU0AdypL7dpdVh20URJ37zULLmTwa6jSOZv58M
         yZOec65WCH0E/5cFrPgB0MosBDTgqslRUThTbWhsFBu49sJvdWg1TbTcX5K4bXySwd
         evBb734uRm3CiYTJnf/S3lpQPDtoaplyQA6X3GWhOpySofLGZtvDgl9HyQVpTfXTd8
         FDdqovoTil/NA==
Date:   Fri, 25 Mar 2022 13:10:56 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: Re: [GIT PULL] ipc: Bind to the ipc namespace at open time.
Message-ID: <20220325121056.dcvm3u2fe2bvn6om@example.org>
References: <cover.1644862280.git.legion@kernel.org>
 <877d8kfmdp.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wgBB8iPd0W=MQWnQJukMAPAqgsC0QX2wwiSvcct9zu_RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgBB8iPd0W=MQWnQJukMAPAqgsC0QX2wwiSvcct9zu_RA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 11:12:21AM -0700, Linus Torvalds wrote:
> On Wed, Mar 23, 2022 at 1:24 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >
> > Please pull the per-namespace-ipc-sysctls-for-v5.18 tag from the git tree:
> 
> Ugh.
> 
> I pulled this. Then I stared at it for a long time.
> 
> And then I decided that this is too ugly to live.
> 
> I'm sorry. I think Alexey has probably spent a fair amount of time on
> it, but I really think the sysctl code needs to be cleaned up way more
> than this.

Apparently it's my fault that the purpose of these changes is not clear. I
did this refactoring not for the sake of refactoring as such.

In my original patch [1], I was trying to fix the situation where the user
cannot change the /proc/sys/fs/mqueue/* options inside rootless container.

But then I split the changes into refactoring which fixes the hack and
permission changes which I wanted to discuss and propose later.

[1] https://lore.kernel.org/lkml/0f0408bb7fbf3187966a9bf19a98642a5d9669fe.1641225760.git.legion@kernel.org/

> The old code was horribly hacky too, but that setup_ipc_sysctls() (and
> setup_mq_sysctls()) thing that copies the whole sysctls table, and
> then walks it entry by entry to modify it, is just too ugly for words.
> 
> And then it hides things in .extra1, and because it does that it can't
> use the normal "extra1 and extra2 contains the limits" so then at
> write() time it copies it into a local one AGAIN only to set the
> limits back so that it can call the normal routines again.
> 
> Not ok.
> 
> Yes, yes, the old code did some similar things - to set the 'data'
> pointer. That was disgusting too. Don't get me wrong - the existing
> code was nasty too. But this took nasty code, and doubled down on it.
> 
> I really think this is a fundamental problem, and needs a more
> fundamental fix than adding more and more of these kinds of nasty
> hacks.
> 
> And yes, that fundamental fix is almost certainly to pass in 'struct
> cred *' to all those sysctl helper functions.
> 
> Then, when you do the actual 'sysctl()' system calls, you pass in
> 'current_cred()".
> 
> And the /proc users would pass in file->f_cred.
> 
> And yes, that patch might be quite messy, because we have quite a lot
> of those random .proc_handler users.
> 
> But *most* of them by far (at least in random code) use the standard
> proc_dointvec_minmax() and friends, and won't even notice.
> 
> And then the ones that are about namespace issues will have to
> continue to do the nasty "make a copy and update the data pointer",
> but *MAYBE* we could also introduce the notion of an "offset" to those
> proc_dointvec_minmax() things to help them out (and at least avoid the
> "make a copy" thing).
> 
> Anyway, I really think we must not make that sysctl code even uglier
> than it is today, and I think we need to move towards a model that
> actually makes sense. And that "pass in the right cred" is the only
> sensible model I can see.
> 
> I haven't tried to create such a patch, and maybe Alexey already tried
> to do something like that and it turned out to be too ugly for words
> and that's why these nasty patches happened.
> 
> But at least for now, I can't with a good conscience pull this.
> 
> Sorry,
>                    Linus

OK. I'll try to come up with some other solution.

-- 
Rgrds, legion

