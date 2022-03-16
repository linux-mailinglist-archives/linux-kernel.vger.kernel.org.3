Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502834DAC69
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354531AbiCPI1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346342AbiCPI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:27:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EB463BCB;
        Wed, 16 Mar 2022 01:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=gGe/Q0wOH7lGIxRZWER5mI2apc8gnY7qZBwZGULV7Yc=; b=prVGffOvR1csAnss6IzmG07sJw
        SawdYeP/IhPi123rRKEDUxEUaULOh74V2dpIgdJNtoZd/WwXniGNrw4MJlUrCSMAKnsb1X3CfzHHF
        DzjHoht+5W4EkMahRa3u4P+X3sintVKzvMj0K1y0vX35EKJbsuJx2KimIikOjCovl2piB1p+mHQZc
        cGeu0b+oQ185+I0zm2Uqtl3LGu719oid+PtGbGDXSfZ/gdTwTb+EC7TxzHA+VMZzg4gcCsIbw/uEo
        BuZrA6fvWtY36Xjif7TUbnfKkh7JfQJ2vm5Ch0uL9zkGUiW98vVplHynPl/1IKz6YJpnbm94iu4Dw
        OD6vJXOw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUOyF-00C6pX-4R; Wed, 16 Mar 2022 08:25:27 +0000
Date:   Wed, 16 Mar 2022 01:25:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "v.narang@samsung.com" <v.narang@samsung.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "avimalin@gmail.com" <avimalin@gmail.com>,
        "atomlin@redhat.com" <atomlin@redhat.com>
Subject: Re: [PATCH v3] kallsyms: enhance %pS/s/b printing when KALLSYSMS is
 disabled
Message-ID: <YjGe961XL8GW7Qeh@bombadil.infradead.org>
References: <CGME20220315155109epcas5p249963f50d68ee368edb569b1a9e7d63c@epcas5p2.samsung.com>
 <20220315155100.516107-1-maninder1.s@samsung.com>
 <YjDScHjMUbqYV4s4@bombadil.infradead.org>
 <62c74547-deb0-539a-c1cc-64b2ac334c94@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62c74547-deb0-539a-c1cc-64b2ac334c94@csgroup.eu>
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

On Wed, Mar 16, 2022 at 06:40:02AM +0000, Christophe Leroy wrote:
> Hi Luis
> 
> 
> Le 15/03/2022 à 18:52, Luis Chamberlain a écrit :
> > On Tue, Mar 15, 2022 at 09:21:00PM +0530, Maninder Singh wrote:
> >>   include/linux/kallsyms.h |  2 +
> >>   include/linux/module.h   | 20 ++++++++++
> >>   kernel/kallsyms.c        | 27 +++++++------
> >>   kernel/module.c          |  4 +-
> >>   lib/vsprintf.c           | 85 ++++++++++++++++++++++++++++++++++------
> > 
> > Hey Maninder, thanks for your patch!
> > 
> > Since this touches kernel/module.c and include/linux/module.h I'd prefer
> > this go through modules-next [0], and as you will see that's a different
> > world right now. I also have a set of at least 2 other patch sets to
> > merge there before yours.
> > 
> > Also, what is on modules-next is not intended to go to Linus for the
> > next merge window as the changes there got merged only late, and I want
> > at least 2 months of testing on linux-newt before any pull requiest is
> > sent to Linus.
> > 
> > Can you rebase to modules-next? I can evaluate the patches then for
> > integration there once the other stuff gets merged into that tree too.
> > 
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next
> > 
> 
> I can't see Aaron's series on modules-next yet, do you plan to merge it 
> anytime soon ?
> 
> As you say, it will be a different world by then.
> 
> I have my series rebases on top of latest Aaron's series, but I was 
> waiting that it lands in modules-next. How do you plan to proceed ?

Yes sorry about that, modules-testing is what had Aaron's code. And
Aaron noted that from his series 13/14 and 14/14 from his series
had their Message-Id modified accidently via git-send-email. Given
*current events* and since I use b4 am to verify KSIM signatures
I asked Aaron to wait and post a v12 to aggregate further reviews
and acked-by's. The reason being that if his v11 series has issues
I rather start from a very clean patchset.

Yes I am paranoid :)

Anyway so Aaron, let's give it a few more days, and please then post a
v12 collecing all new tags, then I'll apply your changes and then try to
apply Christophe's.

There was some work by Michal Suchánek which would go after, but
its unclear if that's yet vetted by their other respective maintainers.
Michal?

Anyway, your stuff is at the end of the train after Michal's if that
stuff is really ready. So please don't be surprised if you later have
to rebase once again, or two or 3 times more. Thanks for your patience.

I know this has been quite a bit of churn, but given Aaron's series I
really hope we're goint to be in a better place for maintenance for
modules long term.

I guess I gotta go automate tests to these things somehow too.

  Luis
