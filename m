Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82F4CD9B6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiCDRGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiCDRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:06:35 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E59719CCD1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:05:47 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 39EED92009C; Fri,  4 Mar 2022 18:05:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3295992009B;
        Fri,  4 Mar 2022 17:05:46 +0000 (GMT)
Date:   Fri, 4 Mar 2022 17:05:46 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
cc:     Mike Rapoport <rppt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] MIPS: Modify mem= and memmap= parameter
In-Reply-To: <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
Message-ID: <alpine.DEB.2.21.2203041627150.47558@angie.orcam.me.uk>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn> <Yh3tgr+g/6IElq0P@kernel.org> <cfd74b5b-39c3-733a-5226-515991f91f39@loongson.cn> <Yh4uUoYT+YS5Jxsv@kernel.org> <8956c625-c18d-846e-3e65-7920776b27f3@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022, Tiezhu Yang wrote:

> > As for memmap= option, it does not specify the memory map but rather alters
> > the memory map passed by the firmware. Particularity in MIPS implementation
> > it allows to add a single range of available or reserved memory.
> > 
> > AFAIU, for the kdump use-case mem=X@Y should suffice.
> 
> We can modify some code to make mem=X@Y work well,
> but according to Documentation/admin-guide/kernel-parameters.txt,
> the common way is mem=X and memmap=X@Y, so mem=X@Y for mips seems
> odd, the intention of this patchset is to make mem= and memmap=
> work well and consistent with the other archs.

 It is not the MIPS implementation that is odd, it is the others that have 
changed the semantics that are.

 When I added `mem=...' support to the MIPS platform, back on Dec 11th, 
2000, which I needed for a system with with memory holes until I got 
proper memory probing implemented, AFAIR the only other implementation was 
for the x86 and naturally what I did for the MIPS platform was exactly the 
same.  It used to be documented too, but the documentation was removed 
sometime back in 2003 when someone has changed the x86 semantics for 
reasons unknown to me and without letting people working on other 
platforms know, so things diverged.

 Please review:

<https://lore.kernel.org/linux-mips/alpine.LFD.2.21.2010050133330.333514@eddie.linux-mips.org/>

as it has been already discussed.

 If you have a system that hangs with `mem=3G' and which does have 
contiguous RAM available for the kernel to use from 0 through to 3GiB, 
then please either bisect the problem or try finding the root cause as it 
used to work at least those 21 years ago.  Conversely if your system does 
*not* have such RAM available, then use the correct option(s) instead that 
reflect your memory map.

 It is preferable that the memory map be determined automatically either 
by the firmware and then passed to the kernel somehow, or a device tree 
entry, or probed by the kernel itself.  You shouldn't have to specify 
`mem=...' by hand except for debugging or as a temporary workaround.

 For example I have an x86 system that Linux does not how to interrogate 
for RAM beyond 64MiB, so I do use `memmap=128M@0' (for legacy reasons the 
x86 platform has a special exception to always exclude area between 640K 
and 1M from being used even if not explicitly specified, but we do not 
have a need for such legacy such legacy concerns with the MIPS port).  I 
consider it an interim measure however until the kernel has been fixed.

  Maciej
