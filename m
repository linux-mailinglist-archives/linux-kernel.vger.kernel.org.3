Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E285245C5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350324AbiELG25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350207AbiELG2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:28:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AC8185CB5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 53D17CE2811
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F90C385B8;
        Thu, 12 May 2022 06:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652336930;
        bh=86ZkoUSlcv+cLdSEqCEOYta5lwjJpAX090c8eXe4Ytw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1MJpFJhUtfs+gP2fnP+9UIPJVJ9U3Qo8C96iGR+M5DH6AhIXKlDZYafTYqttPw4p
         cnYtjAmNEq9dwXyfHgdpd5/26eCbndIfoCqUdq+xxqpFqLpT6i6tzkfpeqrloePNbP
         0U6dh8l/JIGEb+gQv/UZCaG4F63M/p2LASAYK2NDrHlQgzfvLsaypf8vlhuREE7AnS
         p84q9bMHCvTDWRdzn4s1yLdHNLIBaN9r8CxeMAr3q+fUXuTqLWbGyQEjtHyExRMB1H
         DUaycNkNlRetVXRZfEKr5QjCC6yqUMdUtWBq6ncbgf6NymEW4g/o+PmOEAfPcGjDpp
         dfY1ohLwEl/UQ==
Date:   Thu, 12 May 2022 09:28:42 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Zhouguanghui (OS Kernel)" <zhouguanghui1@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "xuqiang (M)" <xuqiang36@huawei.com>
Subject: Re: [PATCH] memblock: config the number of init memblock regions
Message-ID: <YnypGu1Cu2xPQ1nA@kernel.org>
References: <20220511010530.60962-1-zhouguanghui1@huawei.com>
 <20220510185523.3f7479b8ffc49a8a7c17d328@linux-foundation.org>
 <YntRlrwJeP40q6Hg@kernel.org>
 <73da782c847b413d9b81b0c2940ab13c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73da782c847b413d9b81b0c2940ab13c@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 02:46:25AM +0000, Zhouguanghui (OS Kernel) wrote:
> 在 2022/5/11 14:03, Mike Rapoport 写道:
> > On Tue, May 10, 2022 at 06:55:23PM -0700, Andrew Morton wrote:
> >> On Wed, 11 May 2022 01:05:30 +0000 Zhou Guanghui <zhouguanghui1@huawei.com> wrote:
> >>
> >>> During early boot, the number of memblocks may exceed 128(some memory
> >>> areas are not reported to the kernel due to test failures. As a result,
> >>> contiguous memory is divided into multiple parts for reporting). If
> >>> the size of the init memblock regions is exceeded before the array size
> >>> can be resized, the excess memory will be lost.
> > 
> > I'd like to see more details about how firmware creates that sparse memory
> > map in the changelog.
> > 
> 
> The scenario is as follows: In a system using HBM, a multi-bit ECC error 
> occurs, and the BIOS saves the corresponding area (for example, 2 MB). 
> When the system restarts next time, these areas are isolated and not 
> reported or reported as EFI_UNUSABLE_MEMORY. Both of them lead to an 
> increase in the number of memblocks, whereas EFI_UNUSABLE_MEMORY leads 
> to a larger number of memblocks.
> 
> For example, if the EFI_UNUSABLE_MEMORY type is reported:
> ...
> memory[0x92]    [0x0000200834a00000-0x0000200835bfffff], 0x0000000001200000 bytes on node 7 flags: 0x0
> memory[0x93]    [0x0000200835c00000-0x0000200835dfffff], 0x0000000000200000 bytes on node 7 flags: 0x4
> memory[0x94]    [0x0000200835e00000-0x00002008367fffff], 0x0000000000a00000 bytes on node 7 flags: 0x0
> memory[0x95]    [0x0000200836800000-0x00002008369fffff], 0x0000000000200000 bytes on node 7 flags: 0x4
> memory[0x96]    [0x0000200836a00000-0x0000200837bfffff], 0x0000000001200000 bytes on node 7 flags: 0x0
> memory[0x97]    [0x0000200837c00000-0x0000200837dfffff], 0x0000000000200000 bytes on node 7 flags: 0x4
> memory[0x98]    [0x0000200837e00000-0x000020087fffffff], 0x0000000048200000 bytes on node 7 flags: 0x0
> memory[0x99]    [0x0000200880000000-0x0000200bcfffffff], 0x0000000350000000 bytes on node 6 flags: 0x0
> memory[0x9a]    [0x0000200bd0000000-0x0000200bd01fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
> memory[0x9b]    [0x0000200bd0200000-0x0000200bd07fffff], 0x0000000000600000 bytes on node 6 flags: 0x0
> memory[0x9c]    [0x0000200bd0800000-0x0000200bd09fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
> memory[0x9d]    [0x0000200bd0a00000-0x0000200fcfffffff], 0x00000003ff600000 bytes on node 6 flags: 0x0
> memory[0x9e]    [0x0000200fd0000000-0x0000200fd01fffff], 0x0000000000200000 bytes on node 6 flags: 0x4
> memory[0x9f]    [0x0000200fd0200000-0x0000200fffffffff], 0x000000002fe00000 bytes on node 6 flags: 0x0
> ...

Thanks for the clarification of the usecase.
 
> >>>
> >>> ...
> >>>
> >>
> >> Can we simply increase INIT_MEMBLOCK_REGIONS to 1024 and avoid the
> >> config option?  It appears that the overhead from this would be 60kB or
> >> so.
> > 
> > 60k is not big, but using 1024 entries array for 2-4 memory banks on
> > systems that don't report that fragmented memory map is really a waste.
> > 
> > We can make this per platform opt-in, like INIT_MEMBLOCK_RESERVED_REGIONS ...
> > 
> 
> As I described above, is this a general scenario?

The EFI memory on arm64 is generally bad because of all those NOMAP
carveouts spread all over the place even in cases without memory faults. So
it would make sense to increase the number of memblock regions on arm64
when CONFIG_EFI=y.
 
> >> Or zero if CONFIG_ARCH_KEEP_MEMBLOCK and CONFIG_MEMORY_HOTPLUG
> >> are cooperating.
> > 
> > ... or add code that will discard unused parts of memblock arrays even if
> > CONFIG_ARCH_KEEP_MEMBLOCK=y.
> > 
> 
> In scenarios where the memory usage is sensitive, should 
> CONFIG_ARCH_KEEP_MEMBLOCK be set to n or set the number by adding config?

We are talking about 20 or so architectures that are doing well with 128
memblock regions. I don't see why they need to be altered to accommodate
this use-case.
 
> Andrew, Mike, thank you.

-- 
Sincerely yours,
Mike.
