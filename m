Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8775A85B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiHaSeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiHaSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:33:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9747F10401C;
        Wed, 31 Aug 2022 11:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED65D61CD4;
        Wed, 31 Aug 2022 18:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0491AC433D7;
        Wed, 31 Aug 2022 18:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970507;
        bh=+ENo/svJBBC8Oy4/G43ZPL5LzEhYc0IYqehWhykl2uQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAoVdWs61ULAlNVAt01rj/N33V4akfFULiD7EYlyIwssgT2ZKXJDGWU2EAkD8zhMH
         1VflqdgaiooFjmthhZ/iRz0umOa+4Vnj1YsL8KOuTcC6acXmka4to+u7XSAjBx0QVB
         UpYqVZqOmXazQw+TnhE82NS/E0UxEBtHinl144vltTzkNgQNpv1hTLUs+ZLrjO4VLw
         f5n0qP6EtZik5PxRxhmSkYj79/t2iFWcojSxPrEfl4CAeYneblrt3NZrKQp2WNg8WU
         E1y+EivfKecc1G7jjN9tl2GSQ0fkmRONTJnXzekju8OzR5B7M8jGmaFjMkeZd/Bgbx
         HLu0dAuA6Nc/w==
Date:   Wed, 31 Aug 2022 21:28:23 +0300
From:   "jarkko@kernel.org" <jarkko@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     "Huang, Kai" <kai.huang@intel.com>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Message-ID: <Yw+oR3FKlwbeOl6I@kernel.org>
References: <20220830031206.13449-2-jarkko@kernel.org>
 <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
 <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
 <Yw7EX5GCrEaLzpHV@kernel.org>
 <d07577c3f0b4b3fff0ce470c56f91fb634653703.camel@intel.com>
 <Yw7LJa7eRG+WZ0wv@kernel.org>
 <c3c085d69311ed759bff5bb325a2c182d423f91f.camel@intel.com>
 <Yw7OEh7QP8tb7BR1@kernel.org>
 <a91f65ad5c392b6e34f07bc6d3f35c89a76a98db.camel@intel.com>
 <op.1rrt4aecwjvjmi@hhuan26-mobl1.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.1rrt4aecwjvjmi@hhuan26-mobl1.mshome.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:18:00AM -0500, Haitao Huang wrote:
> Hi Kai
> On Tue, 30 Aug 2022 22:17:08 -0500, Huang, Kai <kai.huang@intel.com> wrote:
> 
> > On Wed, 2022-08-31 at 05:57 +0300, jarkko@kernel.org wrote:
> > > On Wed, Aug 31, 2022 at 02:55:52AM +0000, Huang, Kai wrote:
> > > > On Wed, 2022-08-31 at 05:44 +0300, jarkko@kernel.org wrote:
> > > > > On Wed, Aug 31, 2022 at 02:35:53AM +0000, Huang, Kai wrote:
> > > > > > On Wed, 2022-08-31 at 05:15 +0300, jarkko@kernel.org wrote:
> > > > > > > On Wed, Aug 31, 2022 at 01:27:58AM +0000, Huang, Kai wrote:
> > > > > > > > On Tue, 2022-08-30 at 15:54 -0700, Reinette Chatre wrote:
> > > > > > > > > Hi Jarkko,
> > > > > > > > >
> > > > > > > > > On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> > > > > > > > > > In sgx_init(), if misc_register() for the provision
> > > device fails, and
> > > > > > > > > > neither sgx_drv_init() nor sgx_vepc_init() succeeds,
> > > then ksgxd will be
> > > > > > > > > > prematurely stopped.
> > > > > > > > >
> > > > > > > > > I do not think misc_register() is required to fail for
> > > the scenario to
> > > > > > > > > be triggered (rather use "or" than "and"?). Perhaps just
> > > > > > > > > "In sgx_init(), if a failure is encountered after ksgxd
> > > is started
> > > > > > > > > (via sgx_page_reclaimer_init()) ...".
> > > > > > > >
> > > > > > > > IMHO "a failure" might be too vague.  For instance,
> > > failure to sgx_drv_init()
> > > > > > > > won't immediately result in ksgxd to stop prematurally.
> > > As long as KVM SGX can
> > > > > > > > be initialized successfully, sgx_init() still returns 0.
> > > > > > > >
> > > > > > > > Btw I was thinking whether we should move
> > > sgx_page_reclaimer_init() to the end
> > > > > > > > of sgx_init(), after we make sure at least one of the
> > > driver and the KVM SGX is
> > > > > > > > initialized successfully.  Then the code change in this
> > > patch won't be necessary
> > > > > > > > if I understand correctly.  AFAICT there's no good reason
> > > to start the ksgxd at
> > > > > > > > early stage before we are sure either the driver or KVM
> > > SGX will work.
> > > > > > >
> > > > > > > I would focus fixing the existing flow rather than
> > > reinventing the flow.
> > > > > > >
> > > > > > > It can be made to work, and therefore it is IMHO correct
> > > action to take.
> > > > > >
> > > > > > From another perspective, the *existing flow* is the reason
> > > which causes this
> > > > > > bug.  A real fix is to fix the flow itself.
> > > > >
> > > > > Any existing flow in part of the kernel can have a bug. That
> > > > > does not mean that switching flow would be proper way to fix
> > > > > a bug.
> > > > >
> > > > > BR, Jarkko
> > > >
> > > > Yes but I think this is only true when the flow is reasonable.  If
> > > the flow
> > > > itself isn't reasonable, we should fix the flow (given it's easy
> > > to fix AFAICT).
> > > >
> > > > Anyway, let us also hear from others.
> > > 
> > > The flow can be made to work without issues, which in the
> > > context of a bug fix is exactly what a bug fix should do.
> > > Not more or less.
> > 
> > No. To me the flow itself is buggy.  There's no reason to start ksgxd()
> > before
> > at least SGX driver is initialized to work.
> > 
> 
> Will it cause racing if we expose dev nodes to user space before
> ksgxd is started and sensitization done?

I'll to explain this.

So the point is to fix the issue at hand, and fix it locally.

Changing initialization order is simply out of context. It's
not really an argument for or against changing it

We are fixing sanitization here, and only that with zero
side-effects to any other semantics.

It's dictated by the development process [*] but more
importantly it's also just plain common sense.

[*] https://www.kernel.org/doc/html/v5.19/process/submitting-patches.html#separate-your-changes

BR, Jarkko


