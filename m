Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA985A7492
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiHaDk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiHaDkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:40:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2F18D3E5;
        Tue, 30 Aug 2022 20:40:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8375CB81E3B;
        Wed, 31 Aug 2022 03:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79C5C433D6;
        Wed, 31 Aug 2022 03:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661917251;
        bh=Il5YVxVcg7szkQ+GmwaV3LD8OB+7QYzLJ9JZruU/l7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tYw/COZBYfyqk9eBx6TDhe0Y8JFtlUOKUXqXMTW4Ii7BRwLVteJZsZ8kbjdNtRY/4
         zMUX+Rs15SoyLi5VPIawB3AYZaVEonNzHgpYS2h4JfnbZ3JSN4Qgwc+OfUJ4+8MAyJ
         UJoKMTYbT0Bt9TVVbuyOA7gHdA86QHjsLndfqtHYqtmK5TZGFRq40cxhAVGMDPcRtq
         3RKV2jeo9ZGAuHAqVbw0ENlcn3NtM4euRhWE3dE55/NSq9aJ3ebSym7XvRg7NPOhfF
         o64iveXPO8pS3OF8l0KHTck8QE8w99/2nNeQXKQ+jscoITly0LpS1JFJemy4leCnJh
         /56WCjnVNSEGw==
Date:   Wed, 31 Aug 2022 06:40:46 +0300
From:   "jarkko@kernel.org" <jarkko@kernel.org>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Message-ID: <Yw7YPjGHrM6X+WC+@kernel.org>
References: <20220830031206.13449-2-jarkko@kernel.org>
 <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
 <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
 <Yw7EX5GCrEaLzpHV@kernel.org>
 <d07577c3f0b4b3fff0ce470c56f91fb634653703.camel@intel.com>
 <Yw7LJa7eRG+WZ0wv@kernel.org>
 <c3c085d69311ed759bff5bb325a2c182d423f91f.camel@intel.com>
 <Yw7OEh7QP8tb7BR1@kernel.org>
 <Yw7RDhRrgJZ8M2EZ@kernel.org>
 <7d4e79a9b9751c479378dd0f21605dabc6507cc8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d4e79a9b9751c479378dd0f21605dabc6507cc8.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 03:28:20AM +0000, Huang, Kai wrote:
> On Wed, 2022-08-31 at 06:10 +0300, Jarkko Sakkinen wrote:
> > On Wed, Aug 31, 2022 at 05:57:22AM +0300, jarkko@kernel.org wrote:
> > > On Wed, Aug 31, 2022 at 02:55:52AM +0000, Huang, Kai wrote:
> > > > On Wed, 2022-08-31 at 05:44 +0300, jarkko@kernel.org wrote:
> > > > > On Wed, Aug 31, 2022 at 02:35:53AM +0000, Huang, Kai wrote:
> > > > > > On Wed, 2022-08-31 at 05:15 +0300, jarkko@kernel.org wrote:
> > > > > > > On Wed, Aug 31, 2022 at 01:27:58AM +0000, Huang, Kai wrote:
> > > > > > > > On Tue, 2022-08-30 at 15:54 -0700, Reinette Chatre wrote:
> > > > > > > > > Hi Jarkko,
> > > > > > > > > 
> > > > > > > > > On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> > > > > > > > > > In sgx_init(), if misc_register() for the provision device fails, and
> > > > > > > > > > neither sgx_drv_init() nor sgx_vepc_init() succeeds, then ksgxd will be
> > > > > > > > > > prematurely stopped.
> > > > > > > > > 
> > > > > > > > > I do not think misc_register() is required to fail for the scenario to
> > > > > > > > > be triggered (rather use "or" than "and"?). Perhaps just
> > > > > > > > > "In sgx_init(), if a failure is encountered after ksgxd is started
> > > > > > > > > (via sgx_page_reclaimer_init()) ...".
> > > > > > > > 
> > > > > > > > IMHO "a failure" might be too vague.  For instance, failure to sgx_drv_init()
> > > > > > > > won't immediately result in ksgxd to stop prematurally.  As long as KVM SGX can
> > > > > > > > be initialized successfully, sgx_init() still returns 0.
> > > > > > > > 
> > > > > > > > Btw I was thinking whether we should move sgx_page_reclaimer_init() to the end
> > > > > > > > of sgx_init(), after we make sure at least one of the driver and the KVM SGX is
> > > > > > > > initialized successfully.  Then the code change in this patch won't be necessary
> > > > > > > > if I understand correctly.  AFAICT there's no good reason to start the ksgxd at
> > > > > > > > early stage before we are sure either the driver or KVM SGX will work.
> > > > > > > 
> > > > > > > I would focus fixing the existing flow rather than reinventing the flow.
> > > > > > > 
> > > > > > > It can be made to work, and therefore it is IMHO correct action to take.
> > > > > > 
> > > > > > From another perspective, the *existing flow* is the reason which causes this
> > > > > > bug.  A real fix is to fix the flow itself.
> > > > > 
> > > > > Any existing flow in part of the kernel can have a bug. That
> > > > > does not mean that switching flow would be proper way to fix
> > > > > a bug.
> > > > > 
> > > > > BR, Jarkko
> > > > 
> > > > Yes but I think this is only true when the flow is reasonable.  If the flow
> > > > itself isn't reasonable, we should fix the flow (given it's easy to fix AFAICT).
> > > > 
> > > > Anyway, let us also hear from others.
> > > 
> > > The flow can be made to work without issues, which in the
> > > context of a bug fix is exactly what a bug fix should do.
> > > Not more or less.
> > > 
> > > You don't gain any measurable value for the user with this
> > > switch idea.
> > 
> > And besides this not proper way to review patch anyway because you did
> > not review the code. 
> > 
> 
> I did review the code, but I couldn't agree on the fix.  That's why I expressed
> my view here.
> 
> 
> > I'll focus on fix what is broken e.g. so that it
> > is easy to backport to stable and distro kernels, and call it a day.
> > It certainly does not have to make code "perfect", as long as known
> > bugs are sorted out.
> 
> Why cannot the fix which fixes the flow go to stable?
> 
> > 
> > You are welcome to review the next version of the patch, once I've
> > resolved the issues that were pointed out by Reinette, if you still
> > see some issue but this type of speculative discussion is frankly just
> > wasting everyones time.
> 
> Hmm.. Why pointing out a better fix (my perspective of course) is wasting
> everyone's time?

There was not a single inline comment.

BR, Jarkko
