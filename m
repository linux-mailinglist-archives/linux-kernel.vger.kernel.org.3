Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D569146B009
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhLGBxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:53:53 -0500
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:53636 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230223AbhLGBxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:53:52 -0500
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 38CD118132D08;
        Tue,  7 Dec 2021 01:50:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 0073F20033;
        Tue,  7 Dec 2021 01:50:19 +0000 (UTC)
Message-ID: <80e800b505adf8a26b2ed9898d03516263a830a7.camel@perches.com>
Subject: Re: [PATCH] sysctl: Add a group of macro functions to initcall the
 sysctl table of each feature
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Julia Lawall <Julia.Lawall@inria.fr>, cocci@inria.fr
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, jlayton@kernel.org, bfields@fieldses.org,
        yzaikin@google.com, wangle6@huawei.com
Date:   Mon, 06 Dec 2021 17:50:19 -0800
In-Reply-To: <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
References: <20211207011320.100102-1-nixiaoming@huawei.com>
         <20211206173842.72c76379adbf8005bfa66e26@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.70
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 0073F20033
X-Stat-Signature: eugaf6p34atyjwnhapyor8dt4d1wdy83
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/vZ1xREZaK8aQe4h87FYXZfPC75uLdtD4=
X-HE-Tag: 1638841819-30
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-06 at 17:38 -0800, Andrew Morton wrote:
> On Tue, 7 Dec 2021 09:13:20 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
> 
> > To avoid duplicated code, add a set of macro functions to initialize the
> > sysctl table for each feature.
> > 
> > The system initialization process is as follows:
> > 
> > 	start_kernel () {
> > 		...
> > 		/* init proc and sysctl base,
> > 		 * proc_root_init()-->proc_sys_init()-->sysctl_init_bases()
> > 		 */
> > 		proc_root_init(); /* init proc and sysctl base */
> > 		...
> > 		arch_call_rest_init();
> > 	}
> > 
> > 	arch_call_rest_init()-->rest_init()-->kernel_init()
> > 	kernel_init() {
> > 		...
> > 		kernel_init_freeable(); /* do all initcalls */
> > 		...
> > 		do_sysctl_args(); /* Process the sysctl parameter: sysctl.*= */
> > 	}
> > 
> > 	kernel_init_freeable()--->do_basic_setup()-->do_initcalls()
> > 	do_initcalls() {
> > 		for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
> > 			do_initcall_level
> > 	}
> > 
> > The sysctl interface of each subfeature should be registered after
> > sysctl_init_bases() and before do_sysctl_args(). It seems that the sysctl
> > interface does not depend on initcall_levels. To prevent the sysctl
> > interface from being initialized before the feature itself. The
> > lowest-level late_initcall() is used as the common sysctl interface
> > registration level.
> 
> I'm not normally a fan of wrapping commonly-used code sequences into
> magical macros, but this one does seem to make sense.
> 
> I wonder if it is possible to cook up a checkpatch rule to tell people
> to henceforth use the magic macros rather than to open-code things in
> the old way.  Sounds hard.

Almost impossible for checkpatch.
Likely easier in coccinelle.


