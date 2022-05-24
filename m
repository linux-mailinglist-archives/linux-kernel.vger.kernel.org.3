Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2275325ED
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 11:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbiEXJEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 05:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiEXJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 05:04:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DE310563
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:04:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 042E621A4D;
        Tue, 24 May 2022 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653383082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A7NyfAa48TjeKEQchKUAaAfIWA9p5/ETJsap4I7VllI=;
        b=o5n4IVqMH/wWR3I72ClRqC65TUDqJuUW2vDXe1MMU/NyxHg4yK0iCAVy2Rm1gXi91xMiJb
        ktl/NlLwJASqEG66AqrvTNzg5cSBPVlGfR+XwLG27Gh1MWpT32d0Fx6wcSCLn+tAPXh4FM
        mZh3vCtc/zTFprtq2jtcD7ZTVmulq5A=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 644EC2C142;
        Tue, 24 May 2022 09:04:41 +0000 (UTC)
Date:   Tue, 24 May 2022 11:04:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Balbir Singh <bsingharora@gmail.com>, akpm@linux-foundation.org,
        ammarfaizi2@gnuweeb.org, oleksandr@natalenko.name,
        willy@infradead.org, linux-mm@kvack.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each processg
Message-ID: <YoyfqAApe+RyUyGk@dhcp22.suse.cz>
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
 <YoSZE7Iak3AYA4VE@balbir-desktop>
 <6284a2ef.1c69fb81.e53cd.32b2@mx.google.com>
 <YoTjJH7+QD+DSrW8@dhcp22.suse.cz>
 <6285e519.1c69fb81.4f3fe.8057@mx.google.com>
 <YoX0TWoNw3HqH/X/@dhcp22.suse.cz>
 <628c9cb4.1c69fb81.aec05.30a1@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <628c9cb4.1c69fb81.aec05.30a1@mx.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-05-22 08:52:02, CGEL wrote:
> On Thu, May 19, 2022 at 09:39:57AM +0200, Michal Hocko wrote:
> > On Thu 19-05-22 06:35:03, CGEL wrote:
> > > On Wed, May 18, 2022 at 02:14:28PM +0200, Michal Hocko wrote:
> > > > On Wed 18-05-22 07:40:30, CGEL wrote:
> > > > [...]
> > > > > 2. process_madvise is still a kind of madvise. processs_madvise from
> > > > > another process overrides the intention of origin app code ifself that
> > > > > also calls madvise, which is unrecoverable. For example, if a process "A"
> > > > > which madvises just one part of VMAs (not all) as MERGEABLE run on the OS
> > > > > already, meanwhile, if another process which doesn't know the information
> > > > > of "A" 's MERGEABLE areas, then call process_madvise to advise all VMAs of
> > > > > "A" as MERGEABLE, the original MERGEABLE information of "A" calling madivse
> > > > > is erasured permanently.
> > > > 
> > > > I do not really follow. How is this any different from an external
> > > > process modifying the process wide policy via the proc or any other
> > > > interface?
> > > 
> > > In this patch, you can see that we didn't modify the flag of any VMA of
> > > the target process, which is different from process_madvise. So it is
> > > easy to keep the original MERGEABLE information of the target process
> > > when we turn back to the default state from the state "always".
> > 
> > This means that /proc/<pid>/smaps doesn't show the real state, right?
> 
> Maybe we can add extra information of KSM forcible state in /proc/<pid>/smaps
> like THPeligible. 

That information is already printed and I do not think that adding
another flag or whatever would make the situation much more clear.

> Really, Michal, I think it again, 'process_ madvise' is really not good. In
> addition to some shortcomings I said before, If new vmas of the target process
> are created after the external process calls process_madvise(), then we have to
> call `process_madvise()` on them again, over and over again, regularly, just like
> Oleksandr said [1].

I can see that this is not the most convenient way but so far I haven't
really heard any arguments that this would be impossible.

Look, I am not claiming that process_madvise is the only way to achieve
the goal. I really do not like the proc based interface because it is
rather adhoc and limited. We have other means to set a process wide
property and I do not see any strong arguments agaist prctl.

But more importantly I haven't really seen any serious analysis whether
per-process (resp. per MM) property is even a desirable interface.
Especially in the current form when opting out for certain VMAs is not
possible.
 
> [1]: https://lore.kernel.org/lkml/1817008.tdWV9SEqCh@natalenko.name/

-- 
Michal Hocko
SUSE Labs
