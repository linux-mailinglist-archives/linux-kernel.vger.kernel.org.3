Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464C352CD3B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiESHfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiESHfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:35:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07872939DF;
        Thu, 19 May 2022 00:35:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AF4641FA0F;
        Thu, 19 May 2022 07:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652945733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WA3P3Yd2lxv73NDxT18QFWzkWGzddg7LEtU36iFPhmo=;
        b=UoTGPrQ3knts+jw0/WFPROddiHBAOW740xl0DH4nGxzgrbqnkY3wz2B2JCGASlF0l4AwGx
        L5NsfyuwJekOFu32uxNxNpAeq7Q5q8gqU+eSSi2pOqLH3ucTwoMUTeM08nokwV6ELfnl1l
        t0zKkMuO+OuJhAaXrjb3zwQy1i06emc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 819522C141;
        Thu, 19 May 2022 07:35:32 +0000 (UTC)
Date:   Thu, 19 May 2022 09:35:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, ammarfaizi2@gnuweeb.org,
        oleksandr@natalenko.name, willy@infradead.org, linux-mm@kvack.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Hugh Dickins <hughd@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each process
Message-ID: <YoXzQqZ5Yluv8JMa@dhcp22.suse.cz>
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
 <YoOrdh85+AqJH8w1@dhcp22.suse.cz>
 <62845e2b.1c69fb81.cbf4a.1200@mx.google.com>
 <YoTiqm4sQCtq8C1C@dhcp22.suse.cz>
 <6285e264.1c69fb81.3f416.71a8@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6285e264.1c69fb81.3f416.71a8@mx.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-05-22 06:23:30, CGEL wrote:
> On Wed, May 18, 2022 at 02:12:26PM +0200, Michal Hocko wrote:
> > On Wed 18-05-22 02:47:06, CGEL wrote:
> > > On Tue, May 17, 2022 at 04:04:38PM +0200, Michal Hocko wrote:
> > > > [CCing Hugh and linux-api]
> > > > 
> > > > On Tue 17-05-22 09:27:01, cgel.zte@gmail.com wrote:
> > > > > From: xu xin <xu.xin16@zte.com.cn>
> > > > > 
> > > > > For now, if we want to use KSM to merge pages of some apps, we have to
> > > > > explicitly call madvise() in application code, which means installed
> > > > > apps on OS needs to be uninstall and source code needs to be modified.
> > > > > It is very inconvenient because sometimes users or app developers are not
> > > > > willing to modify their app source codes for any reasons.
> > > 
> > > Hello, Michal.
> > > > 
> > > > Would it help to allow external control by process_madvise?
> > > >
> > > 
> > > Maybe, but it will be much more complicated to achieve this by
> > > process_madvise(). process_madvise works on a serires of VMAs in
> > > essential, So all the eligible VMAs have to be traversed. The problem
> > > about this has been discussed in [1],[2].
> > > [1]https://lore.kernel.org/lkml/1835064.A2aMcgg3dW@natalenko.name/
> > > [2]https://lore.kernel.org/lkml/20220513133210.9dd0a4216bd8baaa1047562c@linux-foundation.org/
> > 
> > I can see that this is not a trivial interface to use but I do not
> > think this would be too hard to be usable. There is certainly some
> > coordination required between the external and the target tasks. But
> > that is to be expected IMHO. You do not really want to configure merging
> > without actually understanding what the application does and whether
> > that is really OK. Right?
> > 
> > Besides that, as far as I remember, the process_madvise interface
> > doesn't really require exact vmas to be provided and a single range can
> > span multiple VMAs.
> 
> Yes, but all the eligible VMAs still have to be traversed after all. It may
> induce more latency than needed because the target task has to be
> stopped to avoid races.

Does it really? I mean, you are right that some sort of synchronization
(e.g. freezing) is required to prevent from address space modifications.
My question is whether this is really required for something that is
mostly an optimization. Missing some VMAs or failing because of racing
modifications is should be toleratable. Or am I wrong on that?
 
> > > > > So to use KSM more flexibly, we provide a new proc file "ksm_enabled" under
> > > > > /proc/<pid>/. We can pass parameter into this file with one of three values
> > > > > as follows:
> > > > > 
> > > > > 	always:
> > > > > 		force all anonymous and eligible VMAs of this process to be
> > > > > 		scanned by ksmd.
> > > > > 	madvise:
> > > > > 		the default state, unless user code call madvise, ksmd
> > > > > 		doesn't scan this process.
> > > > > 	never:
> > > > > 		this process will never be scanned by ksmd and no merged
> > > > > 		pages occurred in this process.
> > > > > 
> > > > > With this patch, we can control KSM with ``/proc/<pid>/ksm_enabled``
> > > > > based on every process. KSM for each process can be entirely disabled
> > > > > (mostly for debugging purposes) or only enabled inside MADV_MERGEABLE
> > > > > regions (to avoid the risk of consuming more cpu resources to scan for
> > > > > ksmd) or enabled entirely for a process.
> > > > 
> > > > I am not really familiar with KSM much but I am wondering whether the
> > > > proc based interface is really the best fit. We have a very similar
> > > > concern with THP where processes would like to override the global setup
> > > > and that has been done with prctl interface. Is there any reason why
> > > > this should be any different?
> > > > 
> > > At least for now, I can't find a simpler implementation than proc file,
> > > unless we add a new syscall used for changing another process mm's flag
> > > in user space.
> > 
> > What is the problem with the prctl extension?
> >
> 
> What's the meaning of the prctl extension?

Add a new prctl "command"

> I don't quite get your point. Can prctl control external process?

Not directly but the properties set by prctl are usually inherited so it
is trivial to create a spawn process to set up the property and exec
into the target application. The target application is not really aware
it has been executed like that so it doesn't really need any
modifications.

But please note that I am not really suggesting to go with prctl. I am
just saying it is a better interface than proc one. I am still not
convinced this really required and I would prefer process_madvise more.
 
> > > Speaking to THP, the interactive UI of KSM is relatively simpler because
> > > KSM dosen't have global knob like THP. OTOH, THP trades space for time
> > > (consume memory) while KSM trades time for space (save memory), so THP
> > > tends to be enabled system wide while KSM not.
> > > 
> > > > Another question I have is about the interaction of the per-process
> > > > tunable with any explicit madvise calls. AFAICS you have made this knob
> > > > per mm but the actual implementation currently relies on the per-vma
> > > > flags. That means that one can explicitly disallow merging by madvise
> > > > for a range. Is it wise to override that by a per-process knob? I mean
> > > > there might be a very good reason why a particular memory ranges should
> > > > never be merged but a per-process knob could easily ignore that hint
> > > > from the application. Or am I just confuse?
> > > For now, there is no any hints for letting KSM never merge some memory
> > > ranges.
> > 
> > I am not sure I understand. Could you be more specific?
> 
> Not like THP, KSM doesn't have anything like VM_NOHUGEPAGE, so apps
> cann't explicitly disallow merging by madvise. If it is really necessary for
> a particular meory ranges of a process to be never merged, we have to submit
> one more patch to achieve that.

What about MADV_UNMERGEABLE?
-- 
Michal Hocko
SUSE Labs
