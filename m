Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323774E8694
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 09:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiC0HmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiC0Hl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 03:41:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79870389D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 00:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1450360F71
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 07:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A652EC340EC;
        Sun, 27 Mar 2022 07:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648366817;
        bh=uvNqC6FYSmHZzEP2jIiGJCsBXoTHRrNBW+V3s9qnniM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DlvBMXDB8Txvep4tW3NHi+uthhwM605Q46pX0y/tWlFiwMZf+hqLkwxGndrdq+bac
         eeyDuIuTxU5LE5/ZSq0IQ15gNRONBiazD1kSNT6V/XZ+JEZvI1Kpz/4TNu1pgtZ2Tn
         IbiaxTEj+Q1CQPdclkCvoedwiEN9YoT6e6dJbW7RG1P8FpSAiFa4nlHVWm+mabMvoq
         HEhdnzUEI3cHVBK3M0YoxojABGep9rWKcTLybJyx9l6RbK1ps5MPgozk5sN3qFB2CJ
         ie3i7QoDafP2Fn3+dlAV/wgff6WvvIEoQnAHQ63QhI229KfDV8k98na5kKl8rU3Hr2
         yY0s8UhkhQGgw==
Date:   Sun, 27 Mar 2022 10:40:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        YongTaek Lee <ytk.lee@samsung.com>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Subject: Re: [PATCH 0/8] memblock: introduce memsize showing reserved memory
Message-ID: <YkAU2JlcX7nlvbwp@kernel.org>
References: <Yj1zVkryTVoAnxsX@kernel.org>
 <20220324070158.22969-1-jaewon31.kim@samsung.com>
 <CGME20220324065919epcas1p4c79da5f6ec4fa0311409ca24a38785d8@epcms1p3>
 <20220325083846epcms1p372559472ceb511cc45d39c110563063a@epcms1p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325083846epcms1p372559472ceb511cc45d39c110563063a@epcms1p3>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 25, 2022 at 05:38:46PM +0900, Jaewon Kim wrote:

> >--------- Original Message ---------
> >Sender : Mike Rapoport <rppt@kernel.org>
> >Date : 2022-03-25 16:46 (GMT+9)
> >Title : Re: [PATCH 0/8] memblock: introduce memsize showing reserved memory
> > 
> >Hi,
> > 
> >On Thu, Mar 24, 2022 at 04:01:50PM +0900, Jaewon Kim wrote:
> >> Some of memory regions can be reserved for a specific purpose. They are
> >> usually defined through reserved-memory in device tree. If only size
> >> without address is specified in device tree, the address of the region
> >> will be determined at boot time.
> >> 
> >> We may find the address of the memory regions through booting log, but
> >> it does not show all. And it could be hard to catch the very beginning
> >> log. The memblock_dump_all shows all memblock status but it does not
> >> show region name and its information is difficult to summarize.
> >> 
> >> This patch introduce a debugfs node, memblock/memsize, to see reserved
> >> memory easily.
> >> 
> >> Here's an example
> >> 
> >> $ cat debugfs/memblock/memsize
> >> 0x0f9000000-0x0fb000000 0x02000000 (   32768 KB )   map reusable linux,cma
> >> 0x0b1900000-0x0b1b00000 0x00200000 (    2048 KB ) nomap unusable test1
> >> 0x0b0200000-0x0b0400000 0x00200000 (    2048 KB )   map unusable test2
> >>  (snipped)
> >> 
> >> Reserved    :  746924 KB
> >>  .kernel    :  137027 KB
> >>   .text     :   28158 KB
> >>   .rwdata   :    3238 KB
> >>   .rodata   :   13468 KB
> >>   .bss      :   12570 KB
> >>   .etc      :   79593 KB
> >>  .unusable  :  609897 KB
> >> System      : 3447380 KB
> >>  .common    : 3152468 KB
> >>  .reusable  :  294912 KB
> >> Total       : 4194304 KB (  4096.00 MB )
> > 
> >Most of this information information is already available at various
> >places, like the existing memblock debugfs, /proc/iomem and DT sysfs.
> > 
> >I don't see why we need yet another debugfs file to expose it.
> 
> Hi.
> Thank you for your reply.
> 
> Especially I'd like to create a node showing all reserved memory status, their 
> total size is same as the physical memory size. This was very useful when I 
> compare reserved memory and kernel init time memory between different chipsets,
> or between different sw release versions.

I'm still not following. The reserved region sizes are available in the
existing memblock debugfs.
Why the names are important? What is the value of having names for *some*
of the reserved regions?
 
> Thank you
> Jaewon Kim

-- 
Sincerely yours,
Mike.
