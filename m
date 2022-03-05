Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5253C4CE4FD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 14:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiCEN1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 08:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiCEN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 08:27:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AE244761;
        Sat,  5 Mar 2022 05:26:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3360FB80BE7;
        Sat,  5 Mar 2022 13:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E94DC004E1;
        Sat,  5 Mar 2022 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646486808;
        bh=fM8MLz1GwvBs2cvfUtWJCjMtw5Xf1RDOc8eABrLldLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4IYZ9h20AWr9yqWCMW/MA7rOCR2E5+tj1WrBdqGAUpjCKiykuVA1OQpCkCHR5J2f
         MKATFpDtLOoM3G36Un89G8gbZ2vVug9La+F9UULFwIU9a3Qxq9NJtdo9Ta864Y8v18
         mMnUDLT2m0vWdV53UAX9mu2Wv1hx+IyYy14YWSC+bWQTXqlt1ejbwLE4qqiy1cPRF5
         VDvvVwzJnl8/nBQlJQEHdt0ZuAto2dl8gtvZtVT/USUxpmMm7pcJm1XhIBj/k+Zy8O
         8n86T1QsdDbugDeLczeIP/zDQudB7ZYHqU4sW6soOCz/MiMaLRpIXvK3sdcfByH9TK
         zLHqNt2QLcFtQ==
Date:   Sat, 5 Mar 2022 15:26:39 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
Message-ID: <YiNlDxF9WppxbkiX@kernel.org>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <Yh3tgr+g/6IElq0P@kernel.org>
 <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn>
 <Yh4uUoYT+YS5Jxsv@kernel.org>
 <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
 <alpine.DEB.2.21.2203041627150.47558@angie.orcam.me.uk>
 <4e10d7a4-3b3e-a220-8cd2-565614288950@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e10d7a4-3b3e-a220-8cd2-565614288950@loongson.cn>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 02:19:41PM +0800, Tiezhu Yang wrote:
> 
> 
> On 03/05/2022 01:05 AM, Maciej W. Rozycki wrote:
> > On Wed, 2 Mar 2022, Tiezhu Yang wrote:
> > 
> > > > As for memmap= option, it does not specify the memory map but rather alters
> > > > the memory map passed by the firmware. Particularity in MIPS implementation
> > > > it allows to add a single range of available or reserved memory.
> > > > 
> > > > AFAIU, for the kdump use-case mem=X@Y should suffice.
> > > 
> > > We can modify some code to make mem=X@Y work well,
> > > but according to Documentation/admin-guide/kernel-parameters.txt,
> > > the common way is mem=X and memmap=X@Y, so mem=X@Y for mips seems
> > > odd, the intention of this patchset is to make mem= and memmap=
> > > work well and consistent with the other archs.
> > 
> >  It is not the MIPS implementation that is odd, it is the others that have
> > changed the semantics that are.
> > 
> >  When I added `mem=...' support to the MIPS platform, back on Dec 11th,
> > 2000, which I needed for a system with with memory holes until I got
> > proper memory probing implemented, AFAIR the only other implementation was
> > for the x86 and naturally what I did for the MIPS platform was exactly the
> > same.  It used to be documented too, but the documentation was removed
> > sometime back in 2003 when someone has changed the x86 semantics for
> > reasons unknown to me and without letting people working on other
> > platforms know, so things diverged.
> > 
> >  Please review:
> > 
> > <https://lore.kernel.org/linux-mips/alpine.LFD.2.21.2010050133330.333514@eddie.linux-mips.org/>
> > 
> > as it has been already discussed.
> > 
> >  If you have a system that hangs with `mem=3G' and which does have
> > contiguous RAM available for the kernel to use from 0 through to 3GiB,
> > then please either bisect the problem or try finding the root cause as it
> > used to work at least those 21 years ago.  Conversely if your system does
> > *not* have such RAM available, then use the correct option(s) instead that
> > reflect your memory map.
> > 
> >  It is preferable that the memory map be determined automatically either
> > by the firmware and then passed to the kernel somehow, or a device tree
> > entry, or probed by the kernel itself.  You shouldn't have to specify
> > `mem=...' by hand except for debugging or as a temporary workaround.
> > 
> >  For example I have an x86 system that Linux does not how to interrogate
> > for RAM beyond 64MiB, so I do use `memmap=128M@0' (for legacy reasons the
> > x86 platform has a special exception to always exclude area between 640K
> > and 1M from being used even if not explicitly specified, but we do not
> > have a need for such legacy such legacy concerns with the MIPS port).  I
> > consider it an interim measure however until the kernel has been fixed.
> > 
> >   Maciej
> > 
> 
> Hi Mike, Thomas and Maciej,
> 
> Thank you very much for your feedbacks and discussions.
> 
> To be frank, I think mem= and memmap= are used for debugging and testing
> in most cases, the intention of this patchset is to refactor the related
> code to make them work well on mips.

mem= works fine on mips and there is no need to change it.

If you must supply complex memory layout on the command line, consider
implementing support for memmap=exact and multiple memmap= parameters on
the kernel command line, like x86 does.
 
> Now, if put the current patch #2 as the first patch, and then modify the
> current patch #1 to support both mem=limit and mem=limit@base (if @base
> is omitted, it is equivalent to mem=limit), the other patches #3 and #4
> remain unchanged, make sense?
> 
> I will send v5 for your review.
> 
> Thanks,
> Tiezhu
> 

-- 
Sincerely yours,
Mike.
