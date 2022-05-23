Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B5530CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbiEWJ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiEWJ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:57:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856503F895
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:57:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 171FE219FB;
        Mon, 23 May 2022 09:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653299845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FCbT/atTPZtFOzFHjzdEug1Tv8X+SYILWhf9FeCnaKA=;
        b=jMs7yL9LFWWjmfAhW2WV4WPEFtMuXihCxubLK/yiEC9XdYQqpRHWyAyUHLkAxYGvwld18/
        63WSOLMRV0dwYYIXIlM0JtAanyTB7N82QLC8+WKkhYbMYoOSpq93z/XovahiFiu4jYa9te
        Vf4D/p1VwDsU8wqgk0m+lN5PQkmZ8P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653299845;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FCbT/atTPZtFOzFHjzdEug1Tv8X+SYILWhf9FeCnaKA=;
        b=30TQp+hYXcsEWeBJO+oQN0Tv8s7Ssgxe4tfEruQ6Ps8THh2Q6oVvExdJeOZQ2QzR7uUgAs
        io/yECPLCdy6q/Aw==
Received: from [10.163.29.78] (unknown [10.163.29.78])
        by relay2.suse.de (Postfix) with ESMTP id D2ECD2C141;
        Mon, 23 May 2022 09:57:24 +0000 (UTC)
Message-ID: <5a9363dbd049697e8f3c232885f499f18cb8d607.camel@suse.cz>
Subject: Re: [PATCH 1/2] x86: Fix return value in frequency invariance setup
 for XEON_PHI_KNL/KNM
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 23 May 2022 11:57:23 +0200
In-Reply-To: <20220521100224.GB2578@worktop.programming.kicks-ass.net>
References: <20220520161022.5972-1-ggherdovich@suse.cz>
         <20220521100224.GB2578@worktop.programming.kicks-ass.net>
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

On Sat, 2022-05-21 at 12:02 +0200, Peter Zijlstra wrote:
> On Fri, May 20, 2022 at 06:10:21PM +0200, Giovanni Gherdovich wrote:
> > knl_set_max_freq_ratio() should return true on success and false
> > otherwise. If the last line of the function body is reached, it means no
> > appropriate value for turbo_freq was found: the setup is unsuccessful and
> > it should return false.
> > 
> > Fixes: 8bea0dfb4a82 ("x86, sched: Add support for frequency invariance on XEON_PHI_KNL/KNM")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > ---
> >  arch/x86/kernel/smpboot.c | 2 +-
> 
> You seems to have missed all that code moved in tip. This no longer
> applies.

Right. I'll rebase and resend. Plus, as per Dave Hansen's comments on
the other patch, I need to have a second look at it.

Giovanni



