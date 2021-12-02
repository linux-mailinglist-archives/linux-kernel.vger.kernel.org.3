Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867AA466955
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348177AbhLBRsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242145AbhLBRsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:48:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF90FC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:44:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65D7A624DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 17:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B58C00446;
        Thu,  2 Dec 2021 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638467077;
        bh=20MBb3O0TGXlUvIGLiQ6paI3wafuNiuw+zUTD+gqlCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YGxoSQfrKIjnndOxqey9jaBI/7LC4P/g2a8m7w8bcJwdl7NnMS5K2wRtQ4dWmGwVM
         S9CBCl9bFDlz3Lgos25TB3tA84HhRMrMH9uwBjpyHfD140Gph/EXg/mf7TrKiqcVw9
         mYQXGdhvGitx57ShTaDlRG7rxTCJptbCEPgdiJj6aIktSAtuoPT9NDaGa8xwgjV4u4
         GshFGuMgohLYqtIs1Zzn+b5rlCTzCBfzFUWbcD7EKkt/tIBzAvsqT/au3xhcRwXbaw
         7YKjVAlgRGh6Hr3U5odIxHd+Rx/8c1StGFLKi1ap8IYH6Pvi88J0GuFhQF8nWnKxNI
         yxuXF5Z2EQGRA==
Date:   Thu, 2 Dec 2021 18:44:34 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v7 02/10] add prctl task isolation prctl docs and samples
Message-ID: <20211202174434.GB648659@lothringen>
References: <20211112123531.497831890@fuller.cnet>
 <20211112123750.692268849@fuller.cnet>
 <20211123143726.GC479935@lothringen>
 <20211129151924.GB135990@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129151924.GB135990@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 12:19:24PM -0300, Marcelo Tosatti wrote:
> On Tue, Nov 23, 2021 at 03:37:26PM +0100, Frederic Weisbecker wrote:
> > On Fri, Nov 12, 2021 at 09:35:33AM -0300, Marcelo Tosatti wrote:
> > > +        - ``I_CFG_INHERIT``:
> > > +                Set inheritance configuration when a new task
> > > +                is created via fork and clone.
> > > +
> > > +                The ``(int *)arg4`` argument is a pointer to::
> > > +
> > > +                        struct task_isol_inherit_control {
> > > +                                __u8    inherit_mask;
> > > +                                __u8    pad[7];
> > > +                        };
> > > +
> > > +                inherit_mask is a bitmask that specifies which part
> > > +                of task isolation should be inherited:
> > > +
> > > +                - Bit ISOL_INHERIT_CONF: Inherit task isolation configuration.
> > > +                  This is the state written via prctl(PR_ISOL_CFG_SET, ...).
> > > +
> > > +                - Bit ISOL_INHERIT_ACTIVE: Inherit task isolation activation
> > > +                  (requires ISOL_INHERIT_CONF to be set). The new task
> > > +                  should behave, after fork/clone, in the same manner
> > > +                  as the parent task after it executed:
> > > +
> > > +                        prctl(PR_ISOL_ACTIVATE_SET, &mask, ...);
> > 
> > I'm confused, what is the purpose of ISOL_INHERIT_CONF?
> 
> When ISOL_INHERIT_CONF is set, task isolation configuration (everything
> configured through PR_ISOL_CFG_SET) is copied across fork/clone
> (but not activation) so one can:
> 
> 	1) configure task isolation (with chisol, for example).
> 	2) activate task isolation from the latency sensitive app:
> 
> +This is a snippet of code to activate task isolation if
> +it has been previously configured (by chisol for example)::
> +
> +        #include <sys/prctl.h>
> +        #include <linux/types.h>
> +
> +        #ifdef PR_ISOL_CFG_GET
> +        unsigned long long fmask;
> +
> +        ret = prctl(PR_ISOL_CFG_GET, I_CFG_FEAT, 0, &fmask, 0);
> +        if (ret != -1 && fmask != 0) {
> +                ret = prctl(PR_ISOL_ACTIVATE_SET, &fmask, 0, 0, 0);
> +                if (ret == -1) {
> +                        perror("prctl PR_ISOL_ACTIVATE_SET");
> +                        return ret;
> +                }
> +        }
> +        #endif
> 
> Regarding the 3 possible modes of operation and their relation 
> to ISOL_INHERIT_CONF / ISOL_INHERIT_ACTIVE:
> 
> +This results in three combinations:
> +
> +1. Both configuration and activation performed by the
> +latency sensitive application.
> +Allows fine grained control of what task isolation
> +features are enabled and when (see samples section below).
> 
> 	inherit_mask = 0
> 
> +2. Only activation can be performed by the latency sensitive app
> +(and configuration performed by chisol).
> +This allows the admin/user to control task isolation parameters,
> +and applications have to be modified only once.
> 
> 	inherit_mask = ISOL_INHERIT_CONF
> 
> +3. Configuration and activation performed by an external tool.
> +This allows unmodified applications to take advantage of
> +task isolation. Activation is performed by the "-a" option
> +of chisol.
> 
> 	inherit_mask = ISOL_INHERIT_ACTIVE
> 

Doh yes of course, I read it too fast but it was actually clear.

Thanks!
