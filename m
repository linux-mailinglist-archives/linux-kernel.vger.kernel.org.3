Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD85815BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbiGZOyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiGZOyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:54:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35451183A5;
        Tue, 26 Jul 2022 07:54:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F9241FB;
        Tue, 26 Jul 2022 07:54:34 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCBB33F73B;
        Tue, 26 Jul 2022 07:54:32 -0700 (PDT)
Date:   Tue, 26 Jul 2022 15:54:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [-next] Lockdep warnings
Message-ID: <20220726145430.bfwidmw6xmeppbfb@bogus>
References: <20220726104134.3b3awfphvafljdgp@bogus>
 <Yt/9z1+X3hDfXkbL@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt/9z1+X3hDfXkbL@FVFF77S0Q05N>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 03:44:31PM +0100, Mark Rutland wrote:
> On Tue, Jul 26, 2022 at 11:41:34AM +0100, Sudeep Holla wrote:
> > I was seeing the below lockdep warnings on my arm64 Juno development
> > platform almost 2 weeks back with -next. I wanted to check for similar
> > reports before post and forgot.
> 
> [...]
> 
> > However I don't see the above warning with the latest -next. When I tried
> > yesterday's -next now, I see a different warning. Not sure if they are
> > related. I haven't tried to bisect.
> > 
> > --->8
> > =============================
> > [ BUG: Invalid wait context ]
> > 5.19.0-rc8-next-20220725 #38 Not tainted
> > -----------------------------
> > swapper/0/0 is trying to lock:
> > (&drvdata->spinlock){....}-{3:3}, at: cti_cpu_pm_notify+0x54/0x114
> 
> Hmmm... do you have CONFIG_PROVE_RAW_LOCK_NESTING enabled?
>

Yes.

> IIUC that should be {2:2} otherwise...
> 
> > other info that might help us debug this:
> > context-{5:5}
> > 1 lock held by swapper/0/0:
> >  #0: (cpu_pm_notifier.lock){....}-{2:2}, at: cpu_pm_enter+0x2c/0x80
> 
> ... and this is telling us that we're trying to take a regular spinlock under a
> raw spinlock, which is not as intended.
> 
> The Kconfig text notes:
> 
>          NOTE: There are known nesting problems. So if you enable this 
>          option expect lockdep splats until these problems have been fully
>          addressed which is work in progress. This config switch allows to
>          identify and analyze these problems. It will be removed and the
>          check permanently enabled once the main issues have been fixed.
> 

Ah, I hadn't seen or read this. Thanks for digging this and sharing.
Sorry for the noise. Good I got to know this limitation, will try to
remember this.

Thanks again for your time Mark.

-- 
Regards,
Sudeep
