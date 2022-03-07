Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8034D0428
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbiCGQaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbiCGQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:30:17 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D09E58E4B;
        Mon,  7 Mar 2022 08:29:21 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nRGEY-0000LM-00; Mon, 07 Mar 2022 17:29:18 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 89E38C1280; Mon,  7 Mar 2022 17:29:09 +0100 (CET)
Date:   Mon, 7 Mar 2022 17:29:09 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] MIPS: Refactor early_parse_mem() to fix mem=
 parameter
Message-ID: <20220307162909.GA18728@alpha.franken.de>
References: <1646108941-27919-1-git-send-email-yangtiezhu@loongson.cn>
 <1646108941-27919-2-git-send-email-yangtiezhu@loongson.cn>
 <20220304151052.GA27642@alpha.franken.de>
 <20220304153517.GA28487@alpha.franken.de>
 <alpine.DEB.2.21.2203041634040.47558@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2203041634040.47558@angie.orcam.me.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 05:11:44PM +0000, Maciej W. Rozycki wrote:
> On Fri, 4 Mar 2022, Thomas Bogendoerfer wrote:
> 
> > > > With this patch, when add "mem=3G" to the command-line, the
> > > > kernel boots successfully, we can see the following messages:
> > > 
> > > unfortunately this patch would break platforms without memory detection,
> > > which simply use mem=32M for memory configuration. Not sure how many
> > > rely on this mechanism. If we can make sure nobody uses it, I'm fine
> > > with your patch.
> > 
> > maybe we could add a CONFIG option, which will be selected by
> > platforms, which don't need/want this usermem thing.
> 
>  FWIW I don't understand what the issue is here beyond that we have a bug 
> that causes a system to hang when "mem=3G" is passed on the kernel command 
> line.  That is assuming that system does have contiguous RAM available for 
> the kernel to use from address 0 up to 3GiB; otherwise it's a user error 
> to tell the kernel it has that memory available (I did get bitten by that 
> myself too): garbage in, garbage out.

I did a quick test with an IP30:

>> bootp(): ip=dhcp root=/dev/nfs console=ttyS0 mem=384M
Setting $netaddr to 192.168.8.208 (from server )
Obtaining  from server 
9012640+181664 entry: 0xa800000020664a60
Linux version 5.17.0-rc3+ (tbogendoerfer@adalid) (mips64-linux-gnu-gcc (GCC) 6.1.1 20160621 (Red Hat Cross 6.1.1-2), GNU ld version 2.27-3.fc24) #155 SMP Mon Mar 7 13:12:01 CET 2022
ARCH: SGI-IP30
PROMLIB: ARC firmware Version 64 Revision 0
printk: bootconsole [early0] enabled
CPU0 revision is: 00000934 (R10000)
FPU revision is: 00000900
Detected 512MB of physical memory.
User-defined physical RAM map overwrite
Kernel sections are not in the memory maps
IP30: Slot: 0, PrID: 00000934, PhyID: 0, VirtID: 0
IP30: Slot: 1, PrID: 00000934, PhyID: 1, VirtID: 1
IP30: Detected 2 CPU(s) present.
Primary instruction cache 32kB, VIPT, 2-way, linesize 64 bytes.
Primary data cache 32kB, 2-way, VIPT, no aliases, linesize 32 bytes
Unified secondary cache 1024kB 2-way, linesize 128 bytes.
Zone ranges:
  DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000017ffffff]
  node   0: [mem 0x0000000020004000-0x00000000208c7fff]
Initmem setup node 0 [mem 0x0000000000000000-0x00000000208c7fff]

after that it's dead (it doesn't have memory starting at 0x0).
Most SGI systems will act broken with mem= in one way or another.
And I already had the need to limit the amount of memory.

>  I think having a CONFIG option automatically selected to disable the 
> ability to give a memory map override would handicap people in debugging 
> their systems or working around firmware bugs, so I would rather be 
> against it.

I'm thinking about a CONFIG option, which isn't user selectable, but
selected via Kconfig only. But that would give to differents semantics
for mem=

So can I just limit amount of memory without interfering with normal
memory detection ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
