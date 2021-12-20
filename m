Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3642F47B540
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhLTVfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:35:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:61415 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhLTVfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:35:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240227055"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="240227055"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 13:35:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="616545840"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.42.105])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 13:35:04 -0800
Message-ID: <f9faa3ee2614af088c510bc3c68080712665cd8f.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] x86/sgx: Add accounting for tracking overcommit
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-sgx@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Dec 2021 13:35:03 -0800
In-Reply-To: <YcDxhWZ7lzB2BB8N@zn.tnic>
References: <20211220174640.7542-1-kristen@linux.intel.com>
         <20211220174640.7542-2-kristen@linux.intel.com> <YcDZ4++GQN+ODm50@zn.tnic>
         <9e08e13208950e9fd955a46994b7fef705751dd6.camel@linux.intel.com>
         <YcDxhWZ7lzB2BB8N@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-20 at 22:11 +0100, Borislav Petkov wrote:
> Bah, that thread is not on lkml. Please always Cc lkml in the future.
> 
> On Mon, Dec 20, 2021 at 12:39:19PM -0800, Kristen Carlson Accardi
> wrote:
> > If a malicious or just extra large enclave is loaded, or even just
> > a
> > lot of enclaves, it can eat up all the normal RAM on the system.
> > Normal
> > methods of finding out where all the memory on the system is being
> > used, wouldn't be able to find this usage since it is shared
> > memory. In
> > addition, the OOM killer wouldn't be able to kill any enclaves.
> 
> So you need some sort of limiting against malicious enclaves anyways,
> regardless of this knob. IOW, you can set a percentage limit of
> per-enclave memory which cannot exceed a certain amount which won't
> prevent the system from its normal operation. For example.
> 
> > I completely agree - so I'm trying to make sure I understand this
> > comment, as the value is currently set to default that would
> > automatically apply that is based on EPC memory present and not a
> > fixed
> > value. So I'd like to understand what you'd like to see done
> > differently. are you saying you'd like to eliminated the ability to
> > override the automatic default? Or just that you'd rather calculate
> > the
> > percentage based on total normal system RAM rather than EPC memory?
> 
> So you say that there are cases where swapping to normal RAM can eat
> up all RAM.
> 
> So the first heuristic should be: do not allow for *all* enclaves
> together to use up more than X percent of normal RAM during EPC
> reclaim.

So, in your proposal, you would first change the calculated number of
maximum available backing pages to be based on total system RAM rather
than EPC memory, got it.

> 
> X percent being, say, 90% of all RAM. For example. I guess 10% should
> be enough for normal operation but someone who's more knowledgeable
> in
> system limits could chime in here.
> 
> Then, define a per-enclave limit which says, an enclave can use Y %
> of
> memory for swapping when trying to reclaim EPC memory. And that can
> be
> something like:
> 
> 	90 % RAM
> 	--------
> 	total amount of enclaves currently on the system
> 

This would require recalculating the max number of allowed backing
pages per enclave at run time whenever a new enclave is loaded - but
all the existing enclaves may have already used more than the new max
number of per-enclave allowable pages. How would you handle that
scenario? This would add a lot of complexity for sure - and it does
make me wonder whether any additional benefit of limiting per enclave
would be worth it.

> And you can obviously create scenarios where creating too many
> enclaves
> can bring the system into a situation where it doesn't do any forward
> progress.
> 
> But you probably can cause the same with overcommitting with VMs so
> perhaps it would be a good idea to look how overcommitting VMs and
> limits there are handled.
> 
> Bottom line is: the logic should be for the most common cases to
> function properly, out-of-the-box, without knobs. And then to keep
> the
> system operational by preventing enclaves from bringing it down to a
> halt just by doing EPC reclaim.
> 
> Does that make more sense?
> 

Thanks for your more detailed explanation - I will take a look at the
VM overcommit limits. Since obviously the original implementation did
have a default value set, I had still a remaining specific question
about your comments. Are you suggesting that there should not be a way
to override any overcommit limit at all? So drop the parameter all
together?

