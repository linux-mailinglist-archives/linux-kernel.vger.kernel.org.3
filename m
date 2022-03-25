Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE404E6F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347529AbiCYIEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiCYIEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:04:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D0CC505
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:02:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7AC911F745;
        Fri, 25 Mar 2022 08:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648195355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PHQxxXTuR6hrfYJPw1zKBfMtPGBekCZ9kdNm3NyIPHg=;
        b=bzjKwNj56ll6TArKusysl2QRiwwXRn1n4J5lzWDv4eC3MtLkanJHWcSkkf7i2QBhdJPObH
        /ONRsOofa/GlKdJ/evuJwa8BGuMlj98+xLBI3Zqk79+BTdrbiKZPqAh7RUxeXN4TUd0UKt
        qDRKDCmytf7iF+iOC2gTmkZrctP7CDE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 571C1A3B87;
        Fri, 25 Mar 2022 08:02:35 +0000 (UTC)
Date:   Fri, 25 Mar 2022 09:02:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, minchan@kernel.org, surenb@google.com,
        vbabka@suse.cz, rientjes@google.com, nadav.amit@gmail.com,
        edgararriaga@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/2] mm: madvise: return exact bytes advised with
 process_madvise under error
Message-ID: <Yj13GkQoc7I/q5TK@dhcp22.suse.cz>
References: <cover.1648046642.git.quic_charante@quicinc.com>
 <0fa1bdb5009e898189f339610b90ecca16f243f4.1648046642.git.quic_charante@quicinc.com>
 <Yjxutr35QLGhjJ57@dhcp22.suse.cz>
 <602dcc82-519b-bafd-19e6-b373abe572d4@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <602dcc82-519b-bafd-19e6-b373abe572d4@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-03-22 21:15:57, Charan Teja Kalla wrote:
> Thanks Michal for the inputs.
> 
> On 3/24/2022 6:44 PM, Michal Hocko wrote:
> > On Wed 23-03-22 20:54:10, Charan Teja Kalla wrote:
> >> From: Charan Teja Reddy <quic_charante@quicinc.com>
> >>
> >> The commit 5bd009c7c9a9 ("mm: madvise: return correct bytes advised with
> >> process_madvise") fixes the issue to return number of bytes that are
> >> successfully advised before hitting error with iovec elements
> >> processing. But, when the user passed unmapped ranges in iovec, the
> >> syscall ignores these holes and continues processing and returns ENOMEM
> >> in the end, which is same as madvise semantic. This is a problem for
> >> vector processing where user may want to know how many bytes were
> >> exactly processed in a iovec element to make better decissions in the
> >> user space. As in ENOMEM case, we processed all bytes in a iovec element
> >> but still returned error which will confuse the user whether it is
> >> failed or succeeded to advise.
> > Do you have any specific example where the initial semantic is really
> > problematic or is this mostly a theoretical problem you have found when
> > reading the code?
> > 
> > 
> >> As an example, consider below ranges were passed by the user in struct
> >> iovec: iovec1(ranges: vma1), iovec2(ranges: vma2 -- vma3 -- hole) and
> >> iovec3(ranges: vma4). In the current implementation, it fully advise
> >> iovec1 and iovec2 but just returns number of processed bytes as iovec1
> >> range. Then user may repeat the processing of iovec2, which is already
> >> processed, which then returns with ENOMEM. Then user may want to skip
> >> iovec2 and starts processing from iovec3. Here because of wrong return
> >> processed bytes, iovec2 is processed twice.
> > I think you should be much more specific why this is actually a problem.
> > This would surely be less optimal but is this a correctness issue?
> > 
> 
> Yes, this is a problem found when reading the code, but IMO we can
> easily expect an invalid vma/hole in the passed range because we are
> operating on other process VMA. More than solving the problem of being
> less optimal, this can be looked in the direction of helping the user to
> take better policy decisions with this syscall. And, not better policy
> decisions from user is just being sub optimal(i.e. issuing the syscall
> again on the processed range) with this syscall.
> 
> Having said that, at present I don't have any reports/unit test showing
> the existing semantic is really a problematic.

OK, thanks for the clarification. I would tend to not change the
existing semantic. For one doing so is always a regression risk so the
reasoning should be really strong.
[...]
> > but so it sounds the problem you are trying to fix IMHO. I think it
> > would be better to live with imprecise return values reporting rather
> > than aiming for perfection which would be fragile and add a future
> > maintenance burden.
> >
> Hmm. Should atleast this imprecise return values be documented in man
> page or in madvise.c file?

The man page says:
"
On success, process_madvise() returns the number of bytes
advised.  This return value may be less than the total number of
requested bytes, if an error occurred after some iovec elements
were already processed.  The caller should check the return value
to determine whether a partial advice occurred.
"

which is pretty broad and AFAIU it matches the current behavior. It
doesn't explain what exactly the return value is. It just mentions that
the caller should check for partial advice without any further guidance
- e.g. where should a new call start. I think that such a guidance would
be a bad in general. On a partial success the caller would need to
re-evaluate ranges anyway.

So I guess we are good on the man page side for now.
-- 
Michal Hocko
SUSE Labs
