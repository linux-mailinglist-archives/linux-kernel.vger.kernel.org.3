Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922CC4C57FE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 21:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiBZU2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 15:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBZU2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 15:28:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9050643ADE;
        Sat, 26 Feb 2022 12:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=9yCcSGVYN3jLB7eJbP2OW/SZZ9s+/VmmHUtUePxZZew=; b=KQracF7UT2+2lVsCGP4/4gnqHh
        y1qif2Yv++GeyzOY/D/0H13vrs4I4WQN6WbY/U/vP7bkECgz1Z+qs6lnM71dc6UQS0GIsUyb5WS59
        Je0aey7gbY/GRxAbTAzlmp8w98YpFaAy9Mb3sjNuZRSWyVqZXz5H9+vNO0WSvH/lvOoXUgyS0dFLV
        1+pEbKIlBt+FwAQq4/LAv/z93LctaIJ/cxJSWUSvDxQKmcf6iC1ELaFDdbz5zoxsaML9ZGcZVFkS5
        rJCoM0E+eaSgpJPZpDEzTp90pIk3UfqwQNZ01w1jD+I8Q16o1eTVOTFfRrGAFrstZCC/kPTfA6MBw
        t6S0IFig==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nO3fS-008UKJ-4C; Sat, 26 Feb 2022 20:27:50 +0000
Date:   Sat, 26 Feb 2022 12:27:50 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Aaron Tomlin <atomlin@redhat.com>, Petr Mladek <pmladek@suse.com>,
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
Message-ID: <YhqNRoEgIaoplF9b@bombadil.infradead.org>
References: <20220222141303.1392190-1-atomlin@redhat.com>
 <20220222141303.1392190-10-atomlin@redhat.com>
 <YhieKf9EcS3GQSXG@alley>
 <f9449aa6-be9d-9021-66e7-fb0272909ee7@csgroup.eu>
 <YhisWkgZCK8dz5fl@alley>
 <CANfR36gsRw26C3M0hXGGK2w_05pC0rzkhg0-3Q+8tr_XxLiqiw@mail.gmail.com>
 <CANfR36iKJ6pHU5gm3HKqTPZ=FGsC5qX316UKt2sN0aMFEODA9w@mail.gmail.com>
 <aad10c3f-ecaf-c8fb-f1c6-81ba6f1c4f8d@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aad10c3f-ecaf-c8fb-f1c6-81ba6f1c4f8d@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:57:34PM +0000, Christophe Leroy wrote:
> 
> 
> Le 25/02/2022 à 13:21, Aaron Tomlin a écrit :
> > On Fri 2022-02-25 10:27 +0000, Aaron Tomlin wrote:
> >> On Fri 2022-02-25 11:15 +0100, Petr Mladek wrote:
> >>> rcu_dereference_sched() makes sparse happy. But lockdep complains
> >>> because the _rcu pointer is not accessed under:
> >>>
> >>>      rcu_read_lock_sched();
> >>>      rcu_read_unlock_sched();
> >>
> >> Hi Petr,
> >>
> >>>
> >>> This is not the case here. Note that module_mutex does not
> >>> disable preemtion.
> >>>
> >>> Now, the code is safe. The RCU access makes sure that "mod"
> >>> can't be freed in the meantime:
> >>>
> >>>     + add_kallsyms() is called by the module loaded when the module
> >>>       is being loaded. It could not get removed in parallel
> >>>       by definition.
> >>>
> >>>     + module_kallsyms_on_each_symbol() takes module_mutex.
> >>>       It means that the module could not get removed.
> >>
> >> Indeed, which is why I did not use rcu_read_lock_sched() and
> >> rcu_read_unlock_sched() with rcu_dereference_sched(). That being said, I
> >> should have mentioned this in the commit message.
> >>
> >>> IMHO, we have two possibilities here:
> >>>
> >>>     + Make sparse and lockdep happy by using rcu_dereference_sched()
> >>>       and calling the code under rcu_read_lock_sched().
> >>>
> >>>     + Cast (struct mod_kallsyms *)mod->kallsyms when accessing
> >>>       the value.
> >>
> >> I prefer the first option.
> >>
> >>> I do not have strong preference. I am fine with both.
> >>>
> >>> Anyway, such a fix should be done in a separate patch!
> >>
> >> Agreed.
> > 
> > Luis,
> > 
> > If I understand correctly, it might be cleaner to resolve the above in two
> > separate patches for a v9 i.e. a) address the sparse and lockdep feedback
> > and b) refactor the code, before the latest version [1] is merged into
> > module-next. I assume the previous iteration will be reverted first?
> > 
> > Please let me know your thoughts
> > 
> > [1]: https://lore.kernel.org/all/20220222141303.1392190-1-atomlin@redhat.com/
> > 
> 
> I would do it the other way: first move the code into a separate file, 
> and then handle the sparse __rcu feedback as a followup patch to the series.

I want to avoid any regressions and new complaints, fixes should be
submitted before so that if they are applicable to stable / etc they
can be sent there.

> Regarding module-next, AFAICS at the moment we still have only the 10 
> first patches of v6 in the tree. I guess the way forward will be to 
> rebase module-next and drop those patches and commit v9 instead.

Right, I'll just git fetch and reset to Linus' latest tree, so I'll drop
all of the stuff there now. And then the hope is to apply your new fresh new
clean v9.

Thanks for chugging on with this series!

  Luis
