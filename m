Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485684D6E95
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 13:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiCLMHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 07:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLMHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 07:07:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8618972B8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 04:06:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A8DA60B21
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 12:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43545C340EB;
        Sat, 12 Mar 2022 12:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647086788;
        bh=Qmxx7R+RnvkfnWZfNeYD7t3XzGrx3KORhI3L8qTe8SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mb32UQKROIKdCcaWy71L4Ie4Q7LvIDr29N8/T23C+e5CHvFQVs7bFnQVKXlOt57nR
         +Ie+TJRLWSTvlusPvZnsv9J62eTiLI4VzYVwYjXgXAnw/2YBa1xPXgu+ZBtk57tjb5
         SNoy1RAzF58jfNx9CwCO2vm6yEE3EkKjcbGKxtM2J4gES8r1laRKvz6QrxyWvYra33
         oPKrCAc17lRCt1j9Lyn7lpO6vhSOXz02ulJr5hAemQb/uj+7/miKVYD/App8HxDK4I
         LZJPcpyo0VZqDF4bCQIqsr5Gthk8Omwt6F7XaJRw7sppPO9pM2vN9D5K1Bqk8aNtIF
         3WDKkVFv1zyFw==
Date:   Sat, 12 Mar 2022 14:06:20 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Oliver Glitta <glittao@gmail.com>, lkp@lists.01.org,
        lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: Re: [mm/slub] ae107fa919: BUG:unable_to_handle_page_fault_for_address
Message-ID: <YiyMvBouXGLk/xWP@kernel.org>
References: <20220311145427.GA1227220@odroid>
 <667d594b-bdad-4082-09d5-7b0587af2ae3@suse.cz>
 <20220311164600.GA1234616@odroid>
 <YivzD7PYilkFwjFt@ip-172-31-19-208.ap-northeast-1.compute.internal>
 <a8dc8bc4-9a00-b2f7-1f68-273f7a14a14c@suse.cz>
 <Yix+Pn9a9yKIiXC4@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yix+Pn9a9yKIiXC4@ip-172-31-19-208.ap-northeast-1.compute.internal>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 11:04:30AM +0000, Hyeonggon Yoo wrote:
> On Sat, Mar 12, 2022 at 10:21:25AM +0100, Vlastimil Babka wrote:
> > On 3/12/22 02:10, Hyeonggon Yoo wrote:
> > > On Fri, Mar 11, 2022 at 04:46:00PM +0000, Hyeonggon Yoo wrote:
> > >> On Fri, Mar 11, 2022 at 04:36:47PM +0100, Vlastimil Babka wrote:
> > >>> On 3/11/22 15:54, Hyeonggon Yoo wrote:
> > >>>> On Wed, Mar 09, 2022 at 10:15:31AM +0800, kernel test robot wrote:
> > >>>>>
> > >>>>>
> > >>>>> Greeting,
> > >>>>>
> > >>>>> FYI, we noticed the following commit (built with gcc-9):
> > >>>>>
> > >>>>> commit: ae107fa91914f098cd54ab77e68f83dd6259e901 ("mm/slub: use stackdepot to save stack trace in objects")
> > >>>>> https://git.kernel.org/cgit/linux/kernel/git/vbabka/linux.git slub-stackdepot-v3r0
> > >>>>>
> > >>>>> in testcase: boot
> > >>>>>
> > >>>>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > >>>>>
> > >>>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > >>>>>
> > >>>>
> > >>>> [+Cc Vlastimil and linux-mm]
> > >>>
> > >>> Thanks.
> > >>> lkp folks: it would be nice if I was CC'd automatically on this, it's a
> > >>> commit from my git tree and with by s-o-b :)
> > >>>
> > >>>> I _strongly_ suspect that this is because we don't initialize
> > >>>> stack_table[i] = NULL when we allocate it from memblock_alloc().
> > >>>
> > >>> No, Mike (CC'd) suggested to drop the array init cycle, because
> > >>> memblock_alloc would zero the area anyway.
> > >>
> > >> Ah, you are right. My mistake.
> > >>
> > >>> There has to be a different
> > >>> reason. Wondering if dmesg contains the stack depot initialization message
> > >>> at all...
> > >>
> > >> I think I found the reason.
> > >> This is because of CONFIG_SLUB_DEBUG_ON.
> > >> It can enable debugging without passing boot parameter.
> > >>
> > >> if CONFIG_SLUB_DEBUG_ON=y && slub_debug is not passed, we do not call
> > >> stack_depot_want_early_init(), but the debugging flags are set.
> > >>
> > >> And we only call stack_depot_init() later in kmem_cache_create_usercopy().
> > >>
> > >> so it crashed while creating boot cache.
> > > 
> > > I tested this, and this was the reason.
> > > It crashed on CONFIG_SLUB_DEBUG_ON=y because stackdepot always assume
> > > that it was initialized in boot step, or failed
> > > (stack_depot_disable=true).
> > > 
> > > But as it didn't even tried to initialize it, stack_table == NULL &&
> > > stack_depot_disable == false. So accessing *(NULL + <hash value>)
> > 
> > Thanks for finding the cause!
> > 
> 
> ;)
> 
> > > Ideas? implementing something like kmem_cache_init_early() again?
> > 
> > I think we could simply make CONFIG_SLUB_DEBUG_ON select/depend on
> > STACKDEPOT_ALWAYS_INIT?
> 
> Oh, sounds better.
> 
> If we make CONFIG_SLUB_DEBUG_ON select STACK_DEPOT_ALWAYS_INIT,
> that is simple solution. but stackdepot will be initialized on
> slub_debug=- too.
>
> But I think no one will set CONFIG_SLUB_DEBUG_ON=y if not debugging...

If memory wasted by stack_table is a real concern, we may free it after
parsing slub_debug or add a condition taking into account
CONFIG_SLUB_DEBUG_ON and slub_debug=- to the 

	if (slub_debug & SLAB_STORE_USER)
		stack_depot_want_early_init();

But I agree that if somebody runs a kernel with CONFIG_SLUB_DEBUG_ON=y, the
goal is to have slub debugging on, so making CONFIG_SLUB_DEBUG_ON select
STACK_DEPOT_ALWAYS_INIT totally makes sense to me.
 
> I don't think making CONFIG_SLUB_DEBUG_ON depend on
> CONFIG_STACKDEPOT_ALWAYS_INIT is good solution. only KASAN selects it.
> 
> -- 
> Thank you, You are awesome!
> Hyeonggon :-)

-- 
Sincerely yours,
Mike.
