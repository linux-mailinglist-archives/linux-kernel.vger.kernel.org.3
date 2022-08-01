Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4659358660E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiHAINK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHAINI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:13:08 -0400
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBF22B271
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:13:06 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id C85A1B0038D; Mon,  1 Aug 2022 10:13:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1659341584; bh=0CEGdFc6jqFGcm9ETJYOjovPpwGT0b4RqxxNc722Muk=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=clpgplu7q4G1G+2R/JZIKa12qUzghcFPVRPf4sI1dOAYubGn9hkQ9XXPhgD23Y2DL
         o2xcaz4nb8/r1l+iEZcz+iP5TBX15QM+Sdgfl05mrPYGP1R7o8VtTP2JbV63k1cuLp
         K8xu8sDoFf7hNZvxOzRXOprYK8TwaHsX89dJ5PsUcZrSlk9W9BwnQKfSK1QnsxLFWZ
         BVK63FgW+2kRwwocdkNW+wDqQuSMcnae6SauFrAT/8P6NylONL6BRx0Oy4nCMcSey8
         tev5sSe6s4B7prVFvhzL1k00nThBm6QMOa4AqvFMV8gVi8STzlxe/VxKngQrvIHV+T
         qq6YRQV0Rtwfg==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id C69C8B000FB;
        Mon,  1 Aug 2022 10:13:04 +0200 (CEST)
Date:   Mon, 1 Aug 2022 10:13:04 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, lkp <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [mm/slub] 3616799128:
 BUG_kmalloc-#(Not_tainted):kmalloc_Redzone_overwritten
In-Reply-To: <YueFZm1JHDZOKVw/@feng-skl>
Message-ID: <alpine.DEB.2.22.394.2208011011120.2493025@gentwo.de>
References: <20220727071042.8796-4-feng.tang@intel.com> <YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020> <YuY6Wc39DbL3YmGi@feng-skl> <Yudw5ge/lJ26Hksk@feng-skl> <CACT4Y+Y5aTQMuUU3j60KbLrH_DoFWq1e7EEF5Ka0c1F9a3FniA@mail.gmail.com> <YueFZm1JHDZOKVw/@feng-skl>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022, Feng Tang wrote:

> > Or does it make sense to prohibit KASAN+SLUB_DEBUG combination? Does
> > SLUB_DEBUG add anything on top of KASAN?
>
> I did a quick glance, seems the KASAN will select SLUB_DEBUG in
> many cases, as shown in the lib/Kconfig.kasan:
>
> 	config KASAN_GENERIC
> 		...
> 		select SLUB_DEBUG if SLUB
>
> 	config KASAN_SW_TAGS
> 		...
> 		select SLUB_DEBUG if SLUB

SLUB_DEBUG is on by default on all distros. This just means that debugging
support is compiled in but not activated. Kasan etc could depend on
SLUB_DEBUG. Without SLUB_DEBUG the debugging infrastructure of SLUB that
is use by Kasan is not included.

If you want to enable debugging on bootup then you need to set
SLUB_DEBUG_ON.


