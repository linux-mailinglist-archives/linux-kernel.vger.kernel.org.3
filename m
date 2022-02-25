Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265D14C4207
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiBYKQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiBYKQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:16:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF368239D56;
        Fri, 25 Feb 2022 02:15:55 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A2F471F383;
        Fri, 25 Feb 2022 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645784154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGfc/78bTy+CB9nIZC7tP+8SZf15fx20SODiM5dDyOM=;
        b=E/ofbkMDCo00t2R49q0Uy0Av2MLO3f/8iFb+XnXjzjTMMjxsSQpay1q0oRg0sidxGgJ1sO
        MwRcIxJmcOGBnXr8MbVNe1Woot/YGBWsbXQ+0tWGF7ZC+q7AD/5VTNXXbqisUFi0J7u3QZ
        4iW7Y9YmCiNLTl0DnVhaqP6fZ09SwXE=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5CF04A3B84;
        Fri, 25 Feb 2022 10:15:54 +0000 (UTC)
Date:   Fri, 25 Feb 2022 11:15:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH v8 09/13] module: Move kallsyms support into a separate
 file
Message-ID: <YhisWkgZCK8dz5fl@alley>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-10-atomlin@redhat.com>
 <YhieKf9EcS3GQSXG@alley>
 <f9449aa6-be9d-9021-66e7-fb0272909ee7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9449aa6-be9d-9021-66e7-fb0272909ee7@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-02-25 09:27:33, Christophe Leroy wrote:
> 
> 
> Le 25/02/2022 à 10:15, Petr Mladek a écrit :
> > On Tue 2022-02-22 14:12:59, Aaron Tomlin wrote:
> >> No functional change.
> > 
> > The patch adds rcu_dereference_sched() into several locations.
> > It triggers lockdep warnings, see below.
> > 
> > It is good example why avoid any hidden changes when shuffling
> > code. The changes in the code should be done in a preparatory
> > patch or not at all.
> > 
> > This patch is even worse because these changes were not
> > mentioned in the commit message. It should describe what
> > is done and why.
> > 
> > I wonder how many other changes are hidden in this patchset
> > and if anyone really checked them.
> 
> That's probably my fault, when I reviewed version v5 of the series I 
> mentionned all checkpatch and sparse reports asking Aaron to make his 
> series exempt of such warnings. Most warnings where related to style 
> (parenthesis alignment, blank lines, spaces, etc ...) or erroneous 
> casting etc....
> 
> But for that particular patch we had:
> 
> kernel/module/kallsyms.c:174:23: warning: incorrect type in assignment 
> (different address spaces)
> kernel/module/kallsyms.c:174:23:    expected struct mod_kallsyms 
> [noderef] __rcu *kallsyms
> kernel/module/kallsyms.c:174:23:    got void *
> kernel/module/kallsyms.c:176:12: warning: dereference of noderef expression
> kernel/module/kallsyms.c:177:12: warning: dereference of noderef expression
> kernel/module/kallsyms.c:179:12: warning: dereference of noderef expression
> kernel/module/kallsyms.c:180:12: warning: dereference of noderef expression
> kernel/module/kallsyms.c:189:18: warning: dereference of noderef expression
> kernel/module/kallsyms.c:190:35: warning: dereference of noderef expression
> kernel/module/kallsyms.c:191:20: warning: dereference of noderef expression
> kernel/module/kallsyms.c:196:32: warning: dereference of noderef expression
> kernel/module/kallsyms.c:199:45: warning: dereference of noderef expression
> 
> Aaron used rcu_dereference_sched() in order to fix that.
> 
> How should this be fixed if using rcu_dereference_sched() is not correct ?

IMHO, sparse complains that _rcu pointer is not accessed using RCU
API.

rcu_dereference_sched() makes sparse happy. But lockdep complains
because the _rcu pointer is not accessed under:

	rcu_read_lock_sched();
	rcu_read_unlock_sched();

This is not the case here. Note that module_mutex does not
disable preemtion.

Now, the code is safe. The RCU access makes sure that "mod"
can't be freed in the meantime:

   + add_kallsyms() is called by the module loaded when the module
     is being loaded. It could not get removed in parallel
     by definition.

   + module_kallsyms_on_each_symbol() takes module_mutex.
     It means that the module could not get removed.


IMHO, we have two possibilities here:

   + Make sparse and lockdep happy by using rcu_dereference_sched()
     and calling the code under rcu_read_lock_sched().

   + Cast (struct mod_kallsyms *)mod->kallsyms when accessing
     the value.

I do not have strong preference. I am fine with both.

Anyway, such a fix should be done in a separate patch!

Best Regards,
Petr
