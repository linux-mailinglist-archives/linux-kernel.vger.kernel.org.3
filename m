Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DAD599595
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346971AbiHSHCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346852AbiHSHCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:02:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FBDE0FCF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:02:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50DFBB824EF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A18C433C1;
        Fri, 19 Aug 2022 07:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660892537;
        bh=VQhHb37Uf+6d/27TYo+El26p2h/LmtFBpZJFG3bvxVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ypzKVpaOX1/e+zkQqC7Doil8wBOCq0J05zzLkBEeMUA2y+gPdD97vdlLRnREaCFPT
         QJHOk28Vs5yfcXMJ9KtKz7tH4W1DYRz6gh7gJIymEJBuSmc+8o7vI0VdRhJwcLg4Mh
         avJhZh/qIwi3ne/fcxOlVGsQuiQ0APHh9KAJpuXA=
Date:   Fri, 19 Aug 2022 09:02:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     security@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 1/1] x86/mm: Use proper mask when setting PUD mapping
Message-ID: <Yv81dihastDVE3Po@kroah.com>
References: <Yv71VPSjyy26v/Xu@ziqianlu-desk1>
 <Yv71qbuHkSsLGhvJ@ziqianlu-desk1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv71qbuHkSsLGhvJ@ziqianlu-desk1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 10:30:01AM +0800, Aaron Lu wrote:
> commit c164fbb40c43f("x86/mm: thread pgprot_t through
> init_memory_mapping()") mistakenly used __pgprot() which doesn't
> respect __default_kernel_pte_mask when setting PUD mapping, fix it
> by using __pgprot_mask().
> 
> Fixes: c164fbb40c43f("x86/mm: thread pgprot_t through init_memory_mapping()")

Nit, you need a space before the '(' character or the linux-next scripts
will complain :(

Also, you cc:ed security@k.o and lkml.  As this is public, no need to
copy security@k.o at all.

thanks,

greg k-h
