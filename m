Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D536B56A96E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbiGGRVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiGGRUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:20:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5763335D;
        Thu,  7 Jul 2022 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H/z41n38fMrVHxK1y42Tj7P6QUPD60u5+XY8Ng8yfX4=; b=4Sn1wsXPrs/yPqmi1PLgRr5BWp
        FHSQgVgDsdRtzm9v9KaJo4XwQvosGgRCB7c7Aj9ffpCIFDLnjZke7fTotJFHHaB3oPbWA0shGuBnZ
        Qu/XhyKGfvyau20y8SvAUG6NuttXxvPKwYkrbpWh2+fZH9g+37n5HSanJywA/TwDrh1UXDuz+WpMg
        t9l5gG9ew20hIBgsxIUM1HmFi4Eplosy6rE0RonRn+oVCf3LWSQosjXtELHUJ882+qdzGFUSaPwvF
        21DHzBDyfz13iiBdtvfoh8DHWaYMKFlAZK2Gq7gH7w4otB1Q/j1xwhfdPKeGGB8o18f4nvkhbUrsH
        3Tc6zh2g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9VBG-00HCSD-Gf; Thu, 07 Jul 2022 17:20:46 +0000
Date:   Thu, 7 Jul 2022 10:20:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     rostedt@goodmis.org, cl@linux.com, pmladek@suse.com,
        mbenes@suse.cz, christophe.leroy@csgroup.eu,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, oleksandr@natalenko.name, neelx@redhat.com,
        daniel.thompson@linaro.org, hch@infradead.org, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] module: kallsyms: Ensure preemption in add_kallsyms()
 with PREEMPT_RT
Message-ID: <YscV7ujYs6Q60N+E@bombadil.infradead.org>
References: <20220704161753.4033684-1-atomlin@redhat.com>
 <YsXNVSAtO+VDggcI@bombadil.infradead.org>
 <20220707165750.tk4fadpv3d4zr2mb@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707165750.tk4fadpv3d4zr2mb@ava.usersys.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 05:57:50PM +0100, Aaron Tomlin wrote:
> On Wed 2022-07-06 10:58 -0700, Luis Chamberlain wrote:
> > Hey Aaron, thanks again!
> 
> Hi Luis,
> 
> No problem :)
> 
> > On Mon, Jul 04, 2022 at 05:17:53PM +0100, Aaron Tomlin wrote:
> > > To disable preemption in the context of add_kallsyms() is incorrect.
> > 
> > Why, what broke? Did this used to work? Was the commit in question a
> > regression then? Clarifying all this will help a lot.
> 
> Sorry for the confusion! If I understand correctly, nothing broke
> intrinsically.
> 
> Rather with commit 08126db5ff73 ("module: kallsyms: Fix suspicious rcu
> usage") under PREEMPT_RT=y, by disabling preemption, I introduced an
> unbounded latency since the loop is not fixed which is generally frowned
> upon.

This is incredibly important information which should be added to the
commit log, specialy as PREEMPT_RT=y becomes a first class citizen.

> So, I would say this was a regression since earlier preemption was
> not disabled and we would dereference RCU-protected pointers explicitly
> i.e. without using the more appropriate rcu_dereference() family
> of primitives. That being said, these pointers cannot change in this
> context as explained previously.
> 
> Would the above be suitable - just to confirm before I send another
> iteration?

Yes, I would send this to Linus for the rc series. Please adjust the
commit log with all this information.

BTW I think there is just one more fix pending from you right?

  Luis
