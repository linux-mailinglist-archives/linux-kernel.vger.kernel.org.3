Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA344C9C55
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbiCBEEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiCBED7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:03:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979D6A6506;
        Tue,  1 Mar 2022 20:03:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59212B81EFB;
        Wed,  2 Mar 2022 04:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0A2C004E1;
        Wed,  2 Mar 2022 04:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646193794;
        bh=h/zNtPLk+QSkNGXZP+XwPVF+BSDCj+5WALXfsDs5SaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHjsFFdv9DqVVQbxs4E3m8ynC2YeDHf6beWVDxYurkOCYKpbuKunJ8qf2fx892D0M
         g9CLF/lL/smn0U3OsIrjAxouLHGLdatpoq4dAWOxqPSTb7fzaaIvCpYGO+miqEg6vx
         96PUcTW9NvKCOQlaoi9YV6k9v/HdGMP+RhPC20y5NcTFAzV4SazG76PNvCYYjSt+Qj
         O0dhj4bvWBkCJ0+HYlH0h7HD356Blq37pxzaG6Vpc0mYlS7XRrc6BQuROZUAIwH6p+
         GPjCOk929zFY3IYLd/Yyr0Q/yWo7ELJb7xZja9UXXvNbdDKOD9EB36FUwU+vZQFf9f
         GiCjsddALFKhA==
Date:   Wed, 2 Mar 2022 05:03:58 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Message-ID: <Yh7srrm9S9ml/yGL@iki.fi>
References: <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi>
 <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
 <Yh4fGORDaJyVrJQW@iki.fi>
 <Yh4i4hVcnfZ8QDAl@iki.fi>
 <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com>
 <Yh7Q5fbOtr+6YWaS@iki.fi>
 <Yh7SOgqdFxJdVPMq@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh7SOgqdFxJdVPMq@iki.fi>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 03:11:06AM +0100, Jarkko Sakkinen wrote:
> On Wed, Mar 02, 2022 at 03:05:25AM +0100, Jarkko Sakkinen wrote:
> > > The work that follows this series aimed to do the integration with user
> > > space policy.
> > 
> > What do you mean by "user space policy" anyway exactly? I'm sorry but I
> > just don't fully understand this.
> > 
> > It's too big of a risk to accept this series without X taken care of. Patch
> > series should neither have TODO nor TBD comments IMHO. I don't want to ack
> > a series based on speculation what might happen in the future.
> 
> If I accept this, then I'm kind of pre-acking code that I have no idea what
> it looks like, can it be acked, or am I doing the right thing for the
> kernel by acking this. 
> 
> It's unfortunately force majeure situation for me. I simply could not ack
> this, whether I want it or not.

I'd actually to leave out permission change madness completely out of this
patch set, as we all know it is a grazy beast of microarchitecture. For
user space having that is less critical than having executable pages.

Simply with EAUG/EACCEPTCOPY you can already populate enclave with any
permissions you had in mind. Augmenting alone would be logically consistent
patch set that is actually usable for many workloads.

Now there is half-broken augmenting (this is even writtend down to the TBD
comment) and complex code for EMODPR and EMODT that is usable only for
kselftests and not much else before there is fully working augmenting.

This way we get actually sound patch set that is easy to review and apply
to the mainline. It is also factors easier for you to iterate a smaller
set of patches.

After this it is so much easier to start to look at remaining functionality,
and at the same time augmenting part can be stress tested with real-world
code and it will mature quickly.

This whole thing *really* needs a serious U-turn on how it is delivered to
the upstream. Sometimes it is better just to admit that this didn't start
with the right foot.

BR, Jarkko
