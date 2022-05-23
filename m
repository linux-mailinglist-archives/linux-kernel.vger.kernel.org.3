Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E027530D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiEWJ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiEWJ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:56:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D21388
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:56:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 915EB1F8D4;
        Mon, 23 May 2022 09:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653299762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ScMPs37Cycx6LNMRaJcpPoJxsRrKJk2lsxHkF3D0KAI=;
        b=izwznmolT+Zc6Spf1IKNTmGw5gBqNK2iOsgzIaZ2aywJqmYtRA2sGK2t8kwKcvniw/BjGI
        KAok4Fd/gNx0SIeONdPh+BvkegM0O24qrdaAce35fQXs3fMHLGJCt/VUp+6A8ukOhiJ8qj
        T9sUL63mkbxiDNofKGPs1gatsdwawHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653299762;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ScMPs37Cycx6LNMRaJcpPoJxsRrKJk2lsxHkF3D0KAI=;
        b=HKPNOz/P2Y/SpbvG8M6TptM5NfAWLbuZiJduXcSp9rtleaTzjbU4YLIkh02bdftsjMh2nx
        bd2r7KRCXIA0qaAA==
Received: from [10.163.29.78] (unknown [10.163.29.78])
        by relay2.suse.de (Postfix) with ESMTP id 2A0FC2C141;
        Mon, 23 May 2022 09:56:00 +0000 (UTC)
Message-ID: <0f19dba47d9b86e79ba043018c4d5d13e4e4425b.camel@suse.cz>
Subject: Re: [PATCH 2/2] x86: fix platform info detection in frequency
 invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 May 2022 11:56:00 +0200
In-Reply-To: <7dffbd70-d7db-6d58-abbb-19006cd9e4a2@intel.com>
References: <20220520161022.5972-1-ggherdovich@suse.cz>
         <20220520161022.5972-2-ggherdovich@suse.cz>
         <7dffbd70-d7db-6d58-abbb-19006cd9e4a2@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-20 at 09:44 -0700, Dave Hansen wrote:
> On 5/20/22 09:10, Giovanni Gherdovich wrote:
> >  	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
> >  		goto out;
> >  
> > -	if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
> > -	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
> > +	if (x86_match_cpu(has_glm_turbo_ratio_limits)) {
> > +		skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1);
> >  		goto out;
> > +	}
> >  
> > -	if (x86_match_cpu(has_knl_turbo_ratio_limits) &&
> > -	    knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
> > +	if (x86_match_cpu(has_knl_turbo_ratio_limits)) {
> > +		knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1);
> >  		goto out;
> > +	}
> >  
> > -	if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
> > -	    skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4))
> > +	if (x86_match_cpu(has_skx_turbo_ratio_limits)) {
> > +		skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4);
> >  		goto out;
> > +	}
> >  
> >  	if (core_set_max_freq_ratio(&base_freq, &turbo_freq))
> >  		goto out;
> 
> But didn't the last patch in the series carefully change the return
> value for knl_set_max_freq_ratio()?  Now, the only call site is ignoring
> the return value?  That seems odd.

Thanks for having a look! You're right. I need to either check these
return values, or not have them at all.

> 
> Also, this is a mess.  These constructs:
> 
> static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
>         X86_MATCH(XEON_PHI_KNL),
>         X86_MATCH(XEON_PHI_KNM),
>         {}
> };
> 
> static const struct x86_cpu_id has_skx_turbo_ratio_limits[] = {
>         X86_MATCH(SKYLAKE_X),
>         {}
> };
> 
> static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
>         X86_MATCH(ATOM_GOLDMONT),
>         X86_MATCH(ATOM_GOLDMONT_D),
>         X86_MATCH(ATOM_GOLDMONT_PLUS),
>         {}
> };
> 
> are rather goofy.  A single array like rapl_ids[] that points to the
> handler function would do us a lot more good here, say:
> 
> static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
>         X86_MATCH(XEON_PHI_KNL, 	&knl_set_max_freq_ratio),
>         X86_MATCH(XEON_PHI_KNM, 	&knl_set_max_freq_ratio),
>         X86_MATCH(SKYLAKE_X,		&skx_set_max_freq_ratio),
>         X86_MATCH(ATOM_GOLDMONT, 	&skx_set_max_freq_ratio),
>         X86_MATCH(ATOM_GOLDMONT_D,	&skx_set_max_freq_ratio),
>         X86_MATCH(ATOM_GOLDMONT_PLUS,	&skx_set_max_freq_ratio),
> 	X86_MATCH(ANY,			&core_set_max_freq_ratio),
>         {}
> };
> 
> That would get rid of all the goofy gotos and actually puts all the
> logic in one place.  BTW, I'm not 100% sure about the 'ANY' line.  I
> think that's how those work, but please double-check me on it.

That's good advice. I'll do that consolidation.

> 
> While it's generally best to keep bug fixes to a minimum, I think this
> one is worth a bit of a cleanup because it will remove a bunch of spaghetti.


Thanks,
Giovanni

